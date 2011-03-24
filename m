From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
Date: Wed, 23 Mar 2011 17:08:55 -0700
Message-ID: <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
Cc: jnareb@gmail.com, cernekee@gmail.com, gitster@pobox.com,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 01:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Y83-0007sO-K0
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 01:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933265Ab1CXAKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 20:10:12 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:49573 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023Ab1CXAKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 20:10:10 -0400
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2O09DCr028588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Mar 2011 17:09:19 -0700
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 23 Mar 2011 17:09:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169882>

This patch is based on Kevin Cernekee's <cernekee@gmail.com>
patch series entitled "gitweb: introduce localtime feature".  While
Kevin's patch changed the server side output so that the timezone
was output from gitweb itself, this has a number of drawbacks, in
particular with respect to gitweb-caching.

This patch takes the same basic goal, display the appropriate times
in a given timezone, and implements it in Javascript.  This requires
adding / using a new class, dtcommit, which is based on the
dtstart/dtend microformats.  Appropriate commit dates are wrapped in
a span with this class, and a title of the time in ISO8601 format.

enabling this will then add several javascript files to be loaded,
a default timezone to be selected and a single onloadTZSetup()
function to be called.

This will place a "+" to the right of an appropriate time and clicking
on it will give you a drop down to choose the timezone to change to.

All changes are saved to a Javascript cookie, so page changes and
browser closure / reopening retains the last known setting used.

Fallback (should Javascript not be enabled) is to treat dates as
they have been and display them, only, in UTC.

Valid timezones, currently, are:

utc
local
-1200
-1100
...
+1100
+1200

With each timezone being +1hr to the previous.  The code is capable of
handling fractional timezones, but those have not been added.

Pages Affected:
* 'summary' view, "last change" field (commit time from latest change)
* 'log' view, author time
* 'commit' and 'commitdiff' views, author/committer time

Based-on-code-from: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl              |   64 +++++++++++++++-
 gitweb/static/js/common-defs.js |   12 +++
 gitweb/static/js/common-lib.js  |   32 ++++++++
 gitweb/static/js/cookies.js     |   35 +++++++++
 gitweb/static/js/date.js        |  160 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 300 insertions(+), 3 deletions(-)
 create mode 100644 gitweb/static/js/common-defs.js
 create mode 100644 gitweb/static/js/common-lib.js
 create mode 100644 gitweb/static/js/cookies.js
 create mode 100644 gitweb/static/js/date.js

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9dccfb0..2a662d8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -261,6 +261,49 @@ our %highlight_ext = (
 	map { $_ => 'xml' } qw(xhtml html htm),
 );
 
+
+# Enable / Disable the ability for gitweb to use a small amount of 
+# javascript, along with a javascript cookie, to display commit
+# times in the preffered timezone.  Time zones can be pre-set 
+# by specifying it in $jslocaltime with one of the following:
+#
+#	utc
+#	local
+#	-1200
+#	-1100
+#	-1000
+#	-0900
+#	-0800
+#	-0700
+#	-0600
+#	-0500
+#	-0400
+#	-0300
+#	-0200
+#	-0100
+#	+0000
+#	+0100
+#	+0200
+#	+0300
+#	+0400
+#	+0500
+#	+0600
+#	+0700
+#	+0800
+#	+0900
+#	+1000
+#	+1100
+#	+1200
+#
+# utc is identical to +0000, and local will use the
+# timezone that the browser thinks it is in.
+#
+# Enabled by default.
+#
+# To disable set to null or ''
+
+our $jslocaltime = 'local';
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -504,6 +547,7 @@ our %feature = (
 		'sub' => sub { feature_bool('remote_heads', @_) },
 		'override' => 0,
 		'default' => [0]},
+
 );
 
 sub gitweb_get_feature {
@@ -3728,6 +3772,19 @@ sub git_footer_html {
 		      qq!</script>\n!;
 	}
 
+	print "<!-- jslocaltime: $jslocaltime -->";
+	if( $jslocaltime ne '' ){
+		my $js_path = File::Basename::dirname($javascript);
+		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/common-defs.js" )	.qq!"></script>\n!;
+		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/common-lib.js" )	.qq!"></script>\n!;
+		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/date.js" )		.qq!"></script>\n!;
+		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/cookies.js" )		.qq!"></script>\n!;
+		print "<script type=\"text/javascript\">\n".
+				"var tzDefault = \"$jslocaltime\";\n".
+				"onloadTZSetup();\n".
+		      "</script>";
+	}
+
 	print "</body>\n" .
 	      "</html>";
 }
@@ -3956,7 +4013,7 @@ sub git_print_authorship {
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<$tag class=\"author_date\">" .
 	      format_search_author($author, "author", esc_html($author)) .
-	      " [$ad{'rfc2822'}";
+	      " [<span class=\"dtcommit\" title=\"$ad{'iso-8601'}\">$ad{'rfc2822'}</span>";
 	print_local_time(%ad) if ($opts{-localtime});
 	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
 		  . "</$tag>\n";
@@ -3983,7 +4040,7 @@ sub git_print_authorship_rows {
 		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
 		      "</td></tr>\n" .
 		      "<tr>" .
-		      "<td></td><td> $wd{'rfc2822'}";
+		      "<td></td><td> <span class=\"dtcommit\" title=\"$wd{'iso-8601'}\">$wd{'rfc2822'}</span>";
 		print_local_time(%wd);
 		print "</td>" .
 		      "</tr>\n";
@@ -5395,7 +5452,8 @@ sub git_summary {
 	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (defined $cd{'rfc2822'}) {
-		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+		print "<tr id=\"metadata_lchange\"><td>last change</td>\n";
+		print "<td><span class=\"dtcommit\" title=\"$cd{'iso-8601'}\">$cd{'rfc2822'}</span></td></tr>\n";
 	}
 
 	# use per project git URL list in $projectroot/$project/cloneurl
diff --git a/gitweb/static/js/common-defs.js b/gitweb/static/js/common-defs.js
new file mode 100644
index 0000000..23a1cc2
--- /dev/null
+++ b/gitweb/static/js/common-defs.js
@@ -0,0 +1,12 @@
+// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
+//
+//
+// JavaScript common globals for gitweb (git web interface).
+// @license GPLv2 or later
+//
+
+// Common universal values get set here
+// Things like cookie names, and other just
+// basic global variables.
+
+getwebCookieTZOffset = "tzOffset";
diff --git a/gitweb/static/js/common-lib.js b/gitweb/static/js/common-lib.js
new file mode 100644
index 0000000..2ce65ec
--- /dev/null
+++ b/gitweb/static/js/common-lib.js
@@ -0,0 +1,32 @@
+// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
+//
+//
+// JavaScript date handling code for gitweb (git web interface).
+// @license GPLv2 or later
+//
+//
+function findElementsByClassName( className ) {
+	if( document.getElementsByClassName == undefined) {
+		var hasClassName = new RegExp("(?:^|\\s)" + className + "(?:$|\\s)");
+		var allElements = document.getElementsByTagName("*");
+		var foundElements = [];
+
+		var element = null;
+		for (var x = 0; (element = allElements[x]) != null; x++) {
+			var curClass = element.className;
+			if(
+				curClass				// If we've actually got something
+				&&
+				curClass.indexOf(className) != -1	// And it has a valid index, I.E. not -1
+				&&
+				hasClassName.test(curClass)		// and the regex passes
+			) {
+				foundElements.push(element);		// push it onto the results stack
+			}
+		}
+
+		return foundElements;
+	}else{
+		return document.getElementsByClassName( className );
+	}
+}
diff --git a/gitweb/static/js/cookies.js b/gitweb/static/js/cookies.js
new file mode 100644
index 0000000..8c8f7aa
--- /dev/null
+++ b/gitweb/static/js/cookies.js
@@ -0,0 +1,35 @@
+// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
+//
+//
+// JavaScript cookie handling code for gitweb (git web interface).
+// @license GPLv2 or later
+//
+
+function setCookieExp( name, value, expires ){
+	var expDate = new Date( expires.toString() );
+	expires = expDate.toUTCString;
+	document.cookie = escape(name) +"="+ escape(value) +";"+ expDate.toUTCString() +";path=/";
+}
+
+function setCookie( name, value ){
+	var txtCookie = name +"=\""+ value +"\";path=/";
+	document.cookie = txtCookie;
+}
+
+function getCookie( name ){
+	var allCookies = document.cookie.split(";");
+	var value = "";
+
+	for( var x = 0; x < allCookies.length; x++ ){
+		var brokenCookie = allCookies[x].split("=",2);
+		var hasName = new RegExp("^\\s*" + name + "\\s*$");
+		if(
+			hasName.test(brokenCookie[0])	// Check for the name of the cookie based on the regex
+			&&
+			brokenCookie.length == 2	// Just making sure there is something to actually return here
+		){
+			return unescape(brokenCookie[1]);
+		}
+	}
+	return null;
+}
diff --git a/gitweb/static/js/date.js b/gitweb/static/js/date.js
new file mode 100644
index 0000000..a6d6f81
--- /dev/null
+++ b/gitweb/static/js/date.js
@@ -0,0 +1,160 @@
+// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
+//
+//
+// JavaScript date handling code for gitweb (git web interface).
+// @license GPLv2 or later
+//
+
+function onloadTZSetup(){
+	addChangeTZ();
+	tzChangeNS( tzDefault );
+	checkTZCookie();
+}
+
+function addChangeTZ() {
+		var txtClassesFound = "";
+		var classesFound = findElementsByClassName( "dtcommit" );
+		txtClassesFound += "Length: "+ classesFound.length +"<br>\n";
+		for ( x = 0; x < classesFound.length; x++){
+			curElement = classesFound[x];
+			txtClassesFound += "<br>\n"+ x +" - "+ curElement.nodeName  +" - "+ curElement.title +" - "+ curElement.innerHTML +"<br>\n";
+			var strExtra = " <span onclick=\"clickDate(event.target);\" title=\"+\">+</span>"
+			curElement.innerHTML = curElement.innerHTML + strExtra;
+		}
+}
+
+function checkTZCookie(){
+	var preSetTZ = getCookie( getwebCookieTZOffset );
+	if(
+		preSetTZ != null
+		&&
+		preSetTZ.length != 0
+	){
+		tzChange( preSetTZ );
+	}
+}
+
+function formatTZ( tzOffset ) {
+		var posNeg = "+";
+		if( tzOffset < 0 ){
+			posNeg = "-";
+		}
+		tzOffset = Math.sqrt( Math.pow( tzOffset, 2 ) );
+		if( tzOffset < 100 ){
+			tzOffset = tzOffset * 100;
+		}
+		for( y = tzOffset.toString().length + 1; y <= 4; y++ ){
+			tzOffset = "0"+ tzOffset;
+		}
+		return posNeg + tzOffset;
+}
+
+function dateOutput( objDate ) {
+	return dateOutputTZ( objDate, "0" );
+}
+
+function dateOutputTZ( objDate, tzOffset ) {
+	var strDate = "";
+	var daysOfWeek = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
+	var monthsOfYr = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
+
+	if( tzOffset == "utc" ){
+		tzOffset = 0;
+	}else if( tzOffset == "local" ){
+		var tempDate = new Date();
+		tzOffset = tempDate.getTimezoneOffset() * -1 / 60 * 100; 
+		tzOffset = formatTZ( tzOffset );
+	}
+
+	var msPerHr = 1000 * 60 * 60;	// 1000ms/sec * 60sec/min * 60sec/hr
+	var toDateTime = new Date();
+	toDateTime.setTime( objDate.getTime() + ( tzOffset / 100 * msPerHr ) );
+
+	// Current Date Formatting:
+	// Fri, 19 Dec 2008 11:35:33 +0000
+	strDate += daysOfWeek[ toDateTime.getUTCDay() ] +", ";
+	strDate += toDateTime.getUTCDate() +" ";
+	strDate += monthsOfYr[ toDateTime.getUTCMonth() ] +" ";
+	strDate += toDateTime.getUTCFullYear() +" ";
+	strDate += toDateTime.getUTCHours() +":";
+	strDate += toDateTime.getUTCMinutes() +":";
+	strDate += toDateTime.getUTCSeconds() +" ";
+
+	strDate += tzOffset;
+
+	return strDate;
+}
+
+function tzChange( tzOffset ){
+	return tzChangeSNS( tzOffset, true );
+}
+
+function tzChangeNS( tzOffset ){
+	return tzChangeSNS( tzOffset, false );
+}
+
+function tzChangeSNS( tzOffset, set ){
+	var txtClassesFound = "";
+	var classesFound = findElementsByClassName( "dtcommit" );
+	for ( x = 0; x < classesFound.length; x++){
+		curElement = classesFound[x];
+		var origDateTime = new Date( curElement.title );
+		curElement.innerHTML = dateOutputTZ(origDateTime, tzOffset);
+	}
+	var tzExpDate = new Date();
+	tzExpDate.setDate( tzExpDate.getDate() + 180 );
+	if( set == true ){
+		setCookieExp( getwebCookieTZOffset, tzOffset, tzExpDate.toUTCString() );
+	}
+	addChangeTZ();
+}
+
+function clickDate( clkEvent ) {
+	if( clkEvent.title == "+" ){
+		clkEvent.title="-";
+
+		var preSetTZ = getCookie( getwebCookieTZOffset );
+		
+		var arrSelected = new Array();
+		var offsetArr = 14;
+		arrSelected[0] = " ";
+		arrSelected[1] = " ";
+		if( preSetTZ == "utc" ) {
+			arrSelected[0] = " selected=\"selected\" ";
+		} else if( preSetTZ == "local" ){
+			arrSelected[1] = " selected=\"selected\" ";
+		}
+		for( x = -12; x <= 12; x++){
+			arrSelected[x + offsetArr] = "";
+			if( ( x * 100 ) == preSetTZ ){
+				arrSelected[x + offsetArr] = " selected=\"selected\" ";
+			}
+		}
+		var txtTzSelect = " \
+<span style=\"width: 10%;background-color: grey;\">- \
+<table border=\"1\">\
+	<tr>\
+		<td>\
+			Time Zone:\
+		</td>\
+		<td>\
+			<select name=\"tzoffset\" onchange=\"tzChange(this.value);\">\
+				<option "+ arrSelected[0] +" value=\"utc\">UTC/GMT</option>\
+				<option "+ arrSelected[1] +" value=\"local\">Local (per browser)</option>";
+		for( x = -12; x <= 12; x++){
+			var tzOffset = formatTZ( x );
+			txtTzSelect +="					<option "+ arrSelected[x + offsetArr] +"value=\""+ tzOffset +"\">"+ tzOffset +"</option>";
+		}
+		txtTzSelect += "\
+			</select>\
+		</td>\
+	</tr>\
+</table>\
+</span>";
+		clkEvent.innerHTML = txtTzSelect;
+	}else{
+		clkEvent.parentNode.title="+";
+		clkEvent.parentNode.innerHTML = "+";
+	}
+}
+
-- 
1.7.2.3
