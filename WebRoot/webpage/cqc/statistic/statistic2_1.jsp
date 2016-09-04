<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title></title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
   function duibi1(a, b) {
    var arr = a.split("-");
    var starttime = new Date(arr[0], arr[1], arr[2]);
    var starttimes = starttime.getTime();

    var arrs = b.split("-");
    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
    var lktimes = lktime.getTime();

    if (starttimes >= lktimes) 
    {
        return false;
    }
    else
        	return true;

}
   function duibi2(a, b) {
	    var starttime = new Date(Date.parse(a.replace(/-/g,"/")));
	    var endtime = new Date(Date.parse(b.replace(/-/g,"/")));
	    var now = new Date();
	    
	    if(starttime > now || endtime > now)
	        	return false;
	    else
	    		return true;
	}
  function submit1(URL){
	var QID = document.getElementsByName("QID");
	var date_begin=document.getElementsByName("date_begin");
	var date_end=document.getElementsByName("date_end");
	
	if(QID[0].value.length<1)
	{
		tip("请先选择查询问题！");
		QID[0].focus();
		return false;
	}
	if(date_begin[0].value.length<1)
		{
		tip("请先填写起始日期！");
		date_begin[0].focus();
		return false;
		}
	if(date_end[0].value.length<1)
	{
		tip("请先填写终止日期！");
		date_end[0].focus();
		return false;
	}
	if(duibi1(date_begin[0].value, date_end[0].value) == false)
		{
		tip("起始日期不能大于终止日期！");
		date_begin[0].focus();
		return false;
		}
	if(duibi2(date_begin[0].value, date_end[0].value) == false)
	{
		tip("起始日期或终止日期不应晚于今日！");
		date_begin[0].focus();
		return false;
	}
	
	statistic1.action=URL;
	statistic1.method="post";
	statistic1.submit();
}
  </script>
 </head>
 <body>
  <form id="statistic1">
  		<input type="hidden" name="SID" value="${SID }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable" align="center">
				<tr>
					<td align="right">
						<label class="Validform_label">
							查询问题:
						</label>
					</td>
					<td class="value">
					     	 <select id="QID" name="QID">
						     	 <c:if test="${fn:length(sList)  <= 0 }">
						     	 <option value="">---暂无数据---</option>
						     	 </c:if>
						     	 <c:if test="${fn:length(sList)  > 0 }">
					                <option value=""></option>
					                    <c:forEach items="${sList}" var="s">
					                        <option value="${s.id }">${s.question}</option>
					                    </c:forEach>
					             </c:if>
				            </select>
					</td>
				</tr>
		
				<tr>
					<td align="right">
						<label class="Validform_label">
							查询起始日期(0:00):
						</label>
					</td>
					<td class="value">
					     	 <input name="date_begin" id="date_begin" class="easyui-datebox">
					</td>
				</tr>	
				
				<tr>
					<td align="right">
						<label class="Validform_label">
							查询终止日期(0:00):
						</label>
					</td>
					<td class="value">
					     	 <input name="date_end" id="date_end" class="easyui-datebox">
					</td>
				</tr>
				
				<tr>
				<td align="right"><input type="button" id="sub" value="以柱状图显示结果"
				onclick="submit1('statisticController.do?statistic2_2');"></td>
				<td align="center"><input type="button" id="sub" value="以数据表格显示结果"
				onclick="submit1('statisticController.do?statistic2_3');"></td>
				</tr>
			</table>
		</form>
		<br/><br/><br/><br/><br/>
		 提示：当数据量较大时，点击按钮后可能需等待稍长时间才有响应，请您耐心等待。
 </body>
