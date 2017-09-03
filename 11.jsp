<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>日常事务记录</title>
    <%@include file="../common/resource.jsp"%>
	<style type="text/css">
	  .main	.lmh_tab ul li {width:180px;}
	</style>
    <style type="text/css">
    /*清除浮动*/
    .clearfix:after { clear: both; display: block; height: 0; content: ""; }
    /*主体部分*/
    .wareSort { padding: 15px 8px 15px 7px; border: 1px solid #ddd; background-color: #f6f6f6; width: 1100px;margin:0 auto;}
    .wareSort #sort1{ float: left; width: 330px; padding: 10px; border: 1px solid #ddd; margin-right: 7px; margin-left: 8px; background-color: #fff; }
    .wareSort #sort2 { float: left; width: 720px; padding: 10px; border: 1px solid #ddd; margin-right: 7px; margin-left: 8px; background-color: #fff; }
    .wareSort #sort3{ float: left; width: 330px; padding: 10px; border: 1px solid #ddd; margin-right: 7px; margin-left: 8px; background-color: #fff; }
    .wareSort #sort4 { float: left; width: 720px; padding: 10px; border: 1px solid #ddd; margin-right: 7px; margin-left: 8px; background-color: #fff; }
    .wareSort ul li a { display: block; padding-right: 25px; padding-left: 10px; border: 1px solid #fff; line-height: 28px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; color: #000; }
    #sort2>table{
        display: none;
    }
    #sort2>table:first-child{
        display: block;
    }
     #sort4>table{
        display: none;
    }
    #sort4>table:first-child{
        display: block;
    }
    .gavin0105{
            float: left;
            margin-top: 6px;
    }
    .gavin1705{
        float: left;
        width: 100px;
        border: 1px solid #ccc;
    }
    .slimScrollDiv{
        float: left;
    }
     .modal-body #sort2 table td{
        line-height: 27px;
    }
    .modal-body #sort4 table td{
        line-height: 27px;
    }
    #sort1 li.active a{
        color:red;
    }
    
    #error_tips {
        display:none;
    }
    
    #error_tips_1 {
        display:none;
    }
    #recordModal table {word-break:break-all;}
    
    #recordBody tr td {word-break:break-all}
    
    #recordBody tr td:nth-child(1){width:25px;}
    #recordBody tr td:nth-child(2){width:95px;}
    #recordBody tr td:nth-child(4){width:105px;}
    #recordBody tr td:nth-child(5){width:105px;}   
    #recordBody tr td:nth-child(6){width:25px;}    
    #recordBody tr td:nth-child(7){width:37px;}
    #recordBody tr td:nth-child(8){width:90px;}
    
     #recordBody tr td {word-break:break-all}
    
    #recordBody tr td:nth-child(1){width:25px;}
    
    
    </style>
    <script>
    
    
    function queryAppRecordById1(id){
    	$("#recordBody").empty();
    	
    	var nameOremail;
    	if($("#nameIdHidden").val()){
    		nameOremail=  $("#nameIdHidden").val();
    	}
    	$.ajax({
    		type: "POST",
    		url: path + "/web/daily/queryAppRecordById.do",
    		data: {
    				id: id,nameOremail:nameOremail
    		},
    		success: function(data) {
    			var jsonData = eval("(" + data + ")");
    			for(var i=0;i<jsonData.length;i++){
    				/*var rowNum=(arrcopy.pageNo-1)*10+i+1;*/
    				var flagString="";
    				if(jsonData[i].flagString==2){
    					flagString="已通报";
    				}
    				if(jsonData[i].flagString==1){
    					flagString="已派发";
    				}
    				var Istring =i+1
    				if (i %2 == 0){
    					$("#recordBody").append('<tr><td>'+Istring+'</td>'+
    							'<td>'+jsonData[i].title+'</td>'+
    							'<td>'+jsonData[i].content+'</td>'+
    							'<td>'+jsonData[i].lordsend+'</td>'+
    							'<td>'+jsonData[i].cc+'</td>'+
    							'<td>'+flagString+'</td>'+
    							'<td>'+jsonData[i].userName+'</td>'+
    							'<td>'+jsonData[i].createTime+'</td>');
    				}

    				if (i%2 != 0) {
    					$("#recordBody").append('<tr class="even"><td>'+Istring+'</td>'+
    							'<td>'+jsonData[i].title+'</td>'+
    							'<td>'+jsonData[i].content+'</td>'+
    							'<td>'+jsonData[i].lordsend+'</td>'+
    							'<td>'+jsonData[i].cc+'</td>'+
    							'<td>'+flagString+'</td>'+
    							'<td>'+jsonData[i].userName+'</td>'+
    							'<td>'+jsonData[i].createTime+'</td>');
    				}

    			}
    		}
    	});
    }
        function tijiao(){
            var a1=$("#customerName").val();
            var a2=$("#file").val();
            var a3=$("#appName").val();
            var a4=$("#version").val();
            var a5=$("#assess").val();
            var a6=$("#assessTime").val();  
            var fileExt = "";
            var assessExt = "";
            if(a2 != null && a2 != ""){
	            fileExt=a2.substr(a2.lastIndexOf("."));
            }
            if(a5 != null && a5 != ""){
	            assessExt=a5.substr(a5.lastIndexOf("."));
            }
            var reg=/^((\d+\.)*\d){1,15}$/;
            if(a1==""){
               $('#xgwarn2').modal('show');
               $('#xgwarnId').html('受害方不能为空！');
            }else if(a2==""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('APP文件不能为空！');
            }else if(a3==""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('APP名称不能为空！');
            }else if(a4==""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('APP版本不能为空！');
            }else if(a5==""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('评估报告不能为空！');
            }else if(a6==""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('评估时间不能为空！');
            }else if($.inArray(a1,textArr)<0){
               $('#xgwarn2').modal('show');
               $('#xgwarnId').html('请填写正确的受害方！！！');
            }else if(!reg.test(a4)){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('请填写正确格式的APP版本号！'); 
            }else if(fileExt!='.xls' && fileExt!='.xlsx' && fileExt!='.doc' && fileExt!='.docx' &&
    				fileExt!='.pdf' && fileExt!='.ara' && fileExt!='.zip' &&
    				fileExt!='.apk'){
    			$('#xgwarn2').modal('show');
                $('#xgwarnId').html('请上传正确格式的APP文件(doc、docx、xls、xlsx、pdf、rar、zip、apk)');
    		}else if(assessExt!='.xls' && assessExt!='.xlsx' && assessExt!='.doc' && assessExt!='.docx' &&
            		assessExt!='.pdf' && assessExt!='.ara' && assessExt!='.zip'){
    			$('#xgwarn2').modal('show');
                $('#xgwarnId').html('请上传正确格式的评估报告文件(doc、docx、xls、xlsx、pdf、rar、zip)');
    		}else{
               addOrUpdate(0,0);
            }  
        }
        
        
      //通报
        function sendMailCp(type) {
            var emailTitle = $("#emailTitle").val();
            var emailContent = $("#emailContent").val();
            var lordSend = $("#lordSend").val().replace(/[\r\n\s]/g,"");
            var cc = $("#cc").val().replace(/[\r\n\s]/g,"");
            var Reg = /^([^\|^,]+)(,([A-z0-9_\-\.])+@([A-z0-9_-])+(\.[A-z0-9_-]+)+)+(\|([^\|^,]+)(,([A-z0-9_\-\.])+@([A-z0-9_-])+(\.[A-z0-9_-]+)+)+)*$/;
            var emailReg = /^([A-z0-9_-])+@([A-z0-9_-])+(\.[A-z0-9_-]+)+(,([A-z0-9_-])+@([A-z0-9_-])+(\.[A-z0-9_-]+)+)*$/;
            if(lordSend == ""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('主送人不能为空！');
            }else if(!Reg.test(lordSend)){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('主送人填写的格式不正确！');
            }else if(emailTitle == ""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('邮件标题不能为空！');
            }else if(emailContent == ""){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('邮件内容不能为空！');
            }else if(cc != "" && !emailReg.test(cc)){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('抄送人邮箱格式不正确！');
            }else{
            	$(".zhezhao").show();
                $(".mask").show();
            	var option = {
        	    	url : path+"/web/daily/sendMailShare.do",
        	    	type : 'POST',
        	     	dataType : 'text',
        	    	headers : {"ClientCallMode" : "ajax"}, //添加请求头部
        	    	success : function(data) {
        	    		
        				if("ok" != data && "no" != data){
        					$(".zhezhao").hide();
        		            $(".mask").hide();
        					$('#xgwarn2').modal('show');
        		            $('#xgwarnId').html(data);
        				}else if("ok" == data){
        					$(".zhezhao").hide();
        		            $(".mask").hide();
        		            location.href=path+"/web/daily/sharingList.do";
        		        }else if("no" == data){
        		        	$(".zhezhao").hide();
        		            $(".mask").hide();
        		        	document.getElementById('text').innerHTML = "派发失败！";
        		    		$('#msg').modal('show');
        		        }
        		    },
        		    error: function(data) {
        		    	    $(".zhezhao").hide();
        		    	    $(".mask").hide();
        		        document.getElementById('text').innerHTML = "派发失败";
        					$('#msg').modal('show');
        		   }
        		};
            	$("#emailForm").ajaxSubmit(option);
            }
        }

        
        function xiugai(){
            var a10=$("#customerNameEdit").val();
            var a20=$("#fileEdit").val();
            var a30=$("#appNameEdit").val();
            var a40=$("#versionEdit").val();
            var a50=$("#assessEdit").val();
            var a60=$("#assessTimeEdit").val();     
            var fileExt = "";
            var assessExt = "";
            if(a20 != null && a20 != ""){
	            fileExt=a20.substr(a20.lastIndexOf("."));
            }
            if(a50 != null && a50 != ""){
	            assessExt=a50.substr(a50.lastIndexOf("."));
            }
            var reg=/^((\d+\.)*\d){1,20}$/; 
            if(a10==""){
                $('#xgwarn2').modal('show');
                $('#xgwarnId').html('受害方不能为空！');
             }else if(a30==""){
             	$('#xgwarn2').modal('show');
                 $('#xgwarnId').html('APP名称不能为空！');
             }else if(a40==""){
             	$('#xgwarn2').modal('show');
                 $('#xgwarnId').html('APP版本不能为空！');
             }else if(a60==""){
             	$('#xgwarn2').modal('show');
                 $('#xgwarnId').html('评估时间不能为空！');
             }else if($.inArray(a10,textArr)<0){
               $('#xgwarn2').modal('show');
               $('#xgwarnId').html('请填写正确的受害方！！！');     
            }else if(!reg.test(a40)){
            	$('#xgwarn2').modal('show');
                $('#xgwarnId').html('请填写正确格式的APP版本号！'); 
            }else if(fileExt != '' && fileExt!='.xls' && fileExt!='.xlsx' && fileExt!='.doc' && fileExt!='.docx' &&
    				fileExt!='.pdf' && fileExt!='.ara' && fileExt!='.zip' &&
    				fileExt!='.apk'){
    			$('#xgwarn2').modal('show');
                $('#xgwarnId').html('请上传正确格式的文件(doc、docx、xls、xlsx、pdf、rar、zip、apk)');
    		}else if(assessExt != '' && assessExt!='.xls' && assessExt!='.xlsx' && assessExt!='.doc' && 
    				assessExt!='.docx' && assessExt!='.pdf' && assessExt!='.ara' && assessExt!='.zip'){
    			$('#xgwarn2').modal('show');
                $('#xgwarnId').html('请上传正确格式的文件(doc、docx、xls、xlsx、pdf、rar、zip)');
    		}else{
               addOrUpdate(1,0);
            }  
        } 
      
        
        function sendModalCp(type) {

        	if ($(".ck").is(':checked')) {
        		if($("input[name='vid']:checked").length > 1){
        			document.getElementById('text').innerHTML = "只能选择一条数据！";
        			$('#msg').modal('show');
        			return;
        		}
        		
        		
        		var id = "";
        		$(".ck:checked").each(function() {
        			id=$(this).val();
        		});	
        		
        			
        		var custName=$('#'+id+"customer").text();
        		var appName=$('#'+id+"appName").text();
        		var mainContacts=$('#'+id+"mainContacts").val();
        		var emailCC;
        		
        		var content="";
        		var title="";
        	
        		$('#lordSend').val("");
        		$('#cc').val("");
        		if(custName!=null&&custName!=""&&mainContacts!=null){
        		$('#lordSend').val(custName+","+mainContacts);
        		}
        		if(emailCC!=null&&emailCC!=""){
        		$('#cc').val(emailCC);
        		}
        		$('#emailId').val(id);
        		$('#emailTitle').val(title);
        		$('#emailContent').val(content);
        		$('#sendModal').modal('show');
        	} else {
        		document.getElementById('text').innerHTML = "请选择数据！";
        		$('#msg').modal('show');
        	}
        }

        
        function inportFile1(type){
        	var file = document.getElementById("inportFile").value;
        	var photoExt=file.substr(file.lastIndexOf("."));
        	if(photoExt!='.zip'){
        		$('#xgwarn2').modal('show');
                $('#xgwarnId').html('请上传正确格式的zip文件');
                return;
        	}else{
        		$(".mask").css("display","block");
        	    $("#shut_,#save").css("pointer-events","none");
        		var option = {
        	        	url : path+"/web/daily/inport.do",
        	        	type : 'POST',
        	        	dataType : 'json',
        	        	headers : {"ClientCallMode" : "ajax"}, //添加请求头部
        	        	success : function(data) {
        	      		$(".mask").css("display","none");
        	            $("#shut_,#save").css("pointer-events","auto");
        	         	if("0" == data.result){
                 			type = 3;
        	           		location.href=path+"/web/daily/sharingList.do";
        		        }else{
        		        	document.getElementById('text').innerHTML = data.desc;
        		    		$('#msg').modal('show');
        		        }
        	        	},
        	        error: function(data) {
        	        	$(".mask").css("display","none");
        	 			$("#shut_,#save").css("pointer-events","auto");
        	            document.getElementById('text').innerHTML = "批量上传失败";
        	   			$('#msg').modal('show');
        	       }
        	    };
        	    $("#inportForm").ajaxSubmit(option);
        	}
        	return false;
        }
    </script>
</head>
<body id="center">
   
    <div class="main">
        <div class="lmh_tab">
            <ul>
                <li>
                 	<a style="color:#fff;" href="<%=path%>/web/daily/queryDailyList.do">日常事务记录</a>
                </li>
                 <li>
        			<a style="color:#fff;"  href="<%=path%>/web/daily/meetingList.do">会议派发</a>
                 </li>
                 <li class="active">
        			<a style="color:#fff;"  href="<%=path%>/web/daily/sharingList.do">账号共享</a>
                 </li>
            </ul>
        </div>
    	<div class="content"  id="app"  style="display: block" >
            <div class="dataContent" style="display: block">
                <div class="lmh_search" style="overflow:visible">
                <form class="form-horizontal" method = 'post' id="queryForm" action="<%=path%>/web/daily/sharingList.do">
                    <div class="search" style="margin-top:0px;">
                    	<div class="input"  style="position:relative">
                            <label>受害方：</label>
      						<input class="w289" autocomplete="off"  type="text" name="customerName" id="addName1"   style="width:170px" onfocus="setfocus1(this)" value="${customerName}" oninput="setinput1(this);"/>
                            <p id="selectOptionFind" class="clearfix" style="display:none;position:absolute;left:104px;top:28px;">
                       		    <select name="typenum" id="typenum1" onchange="changeNameFind(this)" size="10"   style="width:187px;height:100px;"></select>
                   		    </p>
                        </div>
                       	
                         </div>
                        <div class="search" style="margin-top:0px;">
                        <input type="hidden" id="type"  name="type" value="0"> 
                        <input type="hidden" id="pageNum"  name="pageNum"> 
                        <input type="hidden" id="pageSizeQuery"  name="pageSize"> 
                        <input type="hidden" id="nameIdHidden"  name="nameIdHidden">
                        <div class="input">
                            <label>录入开始时间：</label>
                            <input class="calendar" id="startTime"  name="startTime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'endTime\',{d:0})}'})"  value="${startTime}" type="text"/>
                        </div>    
                         <div class="input">
                            <label>录入结束时间：</label>
                            <input class="calendar"   id="endTime"  name="endTime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'startTime\',{d:0})}',startDate:'#F{$dp.$D(\'startTime\',{d:0})}'})"   value="${endTime}" type="text"/>
                        </div> 
                        
                        	<a class="search_btn" style="margin-left:132px;margin-right:20px;"  id="queryFind"><img src="<%=path%>/images/search.png" alt=""/>查询</a>
                    	</div>
                    </form>
                </div>
                <div class="data">
                    <div class="table-responsive shadow">
						<div class="handle">
                            <h3>账号共享</h3>
							<div class="handleBtn">
								<a class="purple" href="#" onclick="inport();">导入</a>
								<!-- <a class="orange" href="#" onclick="showAdd();">新建</a> -->
								<!-- <a class="yellow" href="#" onclick="update();" >修改</a> -->
								<!-- <a class="red"    href="#" onclick="deleteAppAssess();">删除</a> -->
								<a class="green" href="#" onclick="sendModalCp(0);">通报</a>
                            </div>
                        </div>
                        
                        <table class="">
                            <thead>
							   <tr>
									<th style="width:3.4%;"><input type="checkbox" onclick="checkids()" id="vids" name="vids"/></th>
									<th style="width:9.1%">编号</th>
									<th style="width:8%">受害方</th>
									<th style="width:8%">附件</th>
									<th style="width:4.3%">录入人</th>
									<th style="width:10.6%">录入时间${p.createTime}</th>
									<th style="width:5.4%;">通报详情</th>
								</tr>
							</thead>
                            <tbody>
                             <c:forEach items="${pageBean.data}" var="p" varStatus="st">
                             	 <c:if test="${st.index%2 == 0}">
                            	    <tr>
								 </c:if>
								 <c:if test="${st.index%2 != 0}">
									<tr class="even">
								 </c:if>
                                  <td class="ids"><input type="checkbox" class="ck" name="vid" value="${p.id}"/></td>
                                  <td id="${p.id}number">${p.number}</td>
                                  <input type="hidden" id="${p.id}mainContacts" value="${p.customer.email}" />
                                  <td id="${p.id}customer">${p.customer.name}</td> 
                                  <td><a href="${imgUrl}${p.sharingFile.path}">${p.sharingFile.fileName}</a></td>
                                  <td>${p.user.name}</td>                             
                                  <td><fmt:formatDate value="${p.createTime}" type="both"></fmt:formatDate></td>
                                  <td><a href="#" data-toggle="modal" data-target="#recordModal" onclick="queryAppRecordById1('${p.id}')">详情</a></td>
                                </tr> 
                             </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%@ include file="/views/common/setPage.jsp" %>
            </div>
        </div>
    </div>
     <!-- 派发记录模态框 -->
    <div class="modal fade" id="recordModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:1050px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                        	派发记录
                    </h4>
                    <span data-dismiss="modal">&times;</span>
                </div>
                <div class="modal-body">
                    <table>
                    <thead>
					      <tr  style="background:#4b70bf;color:white;">
							<td  style="width:25px;">序号</td>
							<td  style="width:95px;">邮件标题</td>
							<td>邮件内容</td>
							<td  style="width:105px;">主送人</td>
							<td  style="width:105px;">抄送人</td>
							<td  style="width:25px;">状态</td>
							<td  style="width:37px;">派发人</td>
							<td  style="width:90px;">派发时间</td>
						  </tr>
					</thead>
					<tbody id="recordBody">
					</tbody>
					
					</table>
                  
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    
	<!--派发模态框-->
	<div class="modal fade" id="sendModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
            <form id="emailForm" >
           		<input type="hidden" name="id" id="emailId">
           		<input type="hidden" name="type" id="type" value="0">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">
                       	通报
                    </h4>
                    <span data-dismiss="modal">&times;</span>
                </div>
                 <div class="modal-body">
                    <div class="task">
						<p style="margin-bottom: 20px;">
							<span class="span2">接收人:</span>
                            <span class="span3">
                                <a class="add" href="#" style="margin:10px 0 0 0;"  data-toggle="modal" data-target="#linkage">添加</a>
                            </span>
                         </p>
                            <p style="height: inherit;position:relative;" class="clearfix">
                                <span class="span2">主送人：</span>
                                <span class="span1" style="position:absolute;top:-10px;left:90px;">示例：小明,xiaoming@qq.com|小强,xiaoqiang@163.com</span>
                                <span style="margin-top: 13px;" class="span3">
                                	<textarea class="w289" cols="34" rows="8" id="lordSend" name="lordSend" placeholder="主送人"  style="width:350px"></textarea>
                                </span>
                            </p>
                            <p style="height: inherit;" class="clearfix">
                                <span class="span2">抄送人：</span>
                                <span style="margin-top: 13px;" class="span3">
                                    <textarea class="w289" cols="34" rows="8"  id="cc" name="cc" placeholder="抄送人"  style="width:350px"></textarea>
                                    <span class="span1">多个邮箱地址以,号分隔</span>
                                </span>
                            </p>
                            <p style="height: inherit;" class="clearfix">
                                <span class="span2">邮件标题:</span>
                                <span class="span3"><input class="w289" type="text" id="emailTitle" placeholder="邮件标题" name="title"  style="width:350px" />
                                <span class="span1">*</span></span>
                            </p>
							<p style="height: inherit;" class="clearfix">
                                <span class="span2">邮件内容:</span>
                                <span class="span3"  style="margin-top: 13px;"><textarea class="w289" cols="34" rows="10"  id="emailContent" name="content" placeholder="邮件内容"  style="width:350px"></textarea>
                                <span class="span1">*</span></span>
                            </p>
                        </p>                        
                        <div class="btn_group">
                        	<a class="save" id="distribute" onclick="sendMailCp(0)" href="#">通报</a>
                        	<a class="cancel" data-dismiss="modal" href="#">关 闭</a>
                   		</div>
                    </div>
                </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <!--模态框8结束-->
    <!-- 批量导入弹出框 -->
    <div class="modal fade" id="inportModal"  tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:600px;">
            <div class="modal-content" style="width:750px;">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">
           				导入
                    </h4>
                    <span data-dismiss="modal">&times;</span>
                </div>
                <div class="modal-body" >
                <form  id="inportForm" action="" enctype="multipart/form-data" method="post">
                    <div class="task">
                    	<p style="width:100%">
                            <span class="span2">压缩文件:</span>
                            <span class="span3">
                            	<input style="width:185px;" type="file" id="inportFile" name="inportFile"/>
                            	<span class="span1">仅支持zip格式（受害方_时间.扩展名），文件名不能包含特殊字符。</span>
                            </span>
                        </p>
                     <%--    <p>
                        	<span class="span1" style="float:right;">
                            	<a href="<%=path%>/templet/xxx_2016-07-01.doc">下载模板</a>
                            </span>
                        </p> --%>
                        
                    </div>
                    <div class="btn_group">
                        <a class="save" onclick="inportFile1(0)" href="#">提 交</a>
                        <a class="cancel" data-dismiss="modal" href="#">关 闭</a>
                    </div>
                    </form>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <!--消息提示框-->
    <div class="modal fade" id="msg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog" style="width:400px;">
        	<div class="modal-content">
            	<div class="modal-header">
                	<h4 class="modal-title">
                           	提示
                    </h4>
                    <span data-dismiss="modal">&times;</span>
                </div>
                <div class="modal-body">
                	<div class="lowcontent">
                    	<p class="confirmed"><span id="text"></span></p>
                        <div class="quitlogin">
                        	<a class="yellow" style="margin-left: 50px;" href="#" data-dismiss="modal">确定</a>
                        </div>
                    </div>
                </div>
        	</div><!-- /.modal-content -->
    	</div><!-- /.modal -->
    </div>
    <div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width:400px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">
                            	提示
                        </h4>
                        <span data-dismiss="modal">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div class="lowcontent">
                            <p class="confirmed">确定删除吗?</p>
                            <div class="quitlogin">
                                <a class="yellow" href="#" onclick="deleteConfirm(0);" >确定</a>
                                <a class="red" href="#" data-dismiss="modal">取消</a>
                            </div>
                        </div>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <div class="modal fade" id="linkage" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:1150px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel4">
                        	选择接收人
                    </h4>
                    <span data-dismiss="modal">&times;</span>
                </div>
                <div class="modal-body">
                	<div class="lmh_search" style="overflow: initial;">
						<div class="search" style="margin-top:0px;">
							<input type="hidden" id="pageNum"  name="pageNum"> 
	                        <input type="hidden" id="pageSizeQuery"  name="pageSize" > 
						   	<div class="input">
	                            <label>客户单位：</label>
	                            <input class="w289" type="text" id="name" name="name"/>
	                       	</div>
	                       	<div class="input">
	                            <label>所属行业：</label>
	                            <select name="trade" id="trade" class="xg1229">   
                            		<option value="">请选择</option>   
                            		<option value="0">银行</option>    
                            		<option value="1">政府</option>
                            		<option value="2">企业</option>
                            		<option value="3">保险</option>  
                            	</select> 
	                        </div>
	                     	<a class="search_btn" id="queryCust" href="#"><img src="<%=path%>/images/search.png" alt=""/>查询</a> 
	                    </div>
                	</div>
                
                    <div class="wareSort clearfix">
                        <ul id="sort1"></ul>
                        <ul id="sort2"></ul>
                    </div>
                    <div class="wareSort clearfix" style="background:#fff;margin-top:20px;">
                        <ul id="views">
                        	<table id="receiveTable" style="width:inherit;margin-left:250px;">
                        	</table>
                        </ul>
                    </div>
                     <div class="btn_group">
                        <a class="save" onclick="addLordSend()" href="#">提 交</a>
                        <a class="cancel" data-dismiss="modal" href="#">关 闭</a>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    
    
   
    <script src="<%=path%>/js/jquery.form.js"></script>
    <script src="<%=path %>/js/slimscroll/jquery-ui.min.js"></script>
    <script src="<%=path %>/js/slimscroll/jquery.slimscroll.js"></script>
    <script src="<%=path%>/js/sourceData/appAssess.js"></script>
    <script>
    
    	$(function(){
    		$("#queryFind").click(function() {
    			var addName = document.getElementById("addName1").value;
    			$("#queryForm").submit();
    		});
    	});
    
        function check1234(){         
           var  aa = $("#customerName").val();
           if ($.inArray(aa,textArr)<0){         
             $("#error_tips").show()
           } else if($.inArray(aa,textArr)>=0){
             $("#error_tips").hide();
           }
        }  
        
         function check12345(){         
           var  aaa = $("#customerNameEdit").val();
           if ($.inArray(aaa,textArr)<0){         
             $("#error_tips_1").show()
           } else if($.inArray(aaa,textArr)>=0){
             $("#error_tips_1").hide();
           }
        }  
        
        $("#addModal").click(function(e){         
           var  aa = $("#customerName").val();
           if ($.inArray(aa,textArr)<0){         
             $("#error_tips").show()
           } else if($.inArray(aa,textArr)>=0){
             $("#error_tips").hide();
           }  
        }) 
        
         $("#editModal").click(function(e){         
           var  aaa = $("#customerNameEdit").val();
           if ($.inArray(aaa,textArr)<0){         
             $("#error_tips_1").show()
           } else if($.inArray(aaa,textArr)>=0){
             $("#error_tips_1").hide();
           }  
        }) 
    </script>
     <div class="zhezhao"></div>
    <div class="mask" style="display:none;z-index:99999">
                            <div class="spinner">
                               <div class="spinner-container container1">
                                  <div class="circle1"></div>
                                  <div class="circle2"></div>
                                  <div class="circle3"></div>
                                  <div class="circle4"></div>
                               </div>
                               <div class="spinner-container container2">
                                  <div class="circle1"></div>
                                  <div class="circle2"></div>
                                  <div class="circle3"></div>
                                  <div class="circle4"></div>
                               </div>
                               <div class="spinner-container container3">
                                  <div class="circle1"></div>
                                  <div class="circle2"></div>
                                  <div class="circle3"></div>
                                  <div class="circle4"></div>
                               </div>
                             </div>
                          </div>
</body>
</html>