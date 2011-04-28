From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 11/13] gitweb: JavaScript ability to adjust time based on timezone
Date: Thu, 28 Apr 2011 21:04:09 +0200
Message-ID: <1304017451-12283-12-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWa-0003Nk-Gu
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933431Ab1D1TFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:05:03 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63114 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933426Ab1D1TE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:58 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3481351wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=h0VK32NE7iJ44uNBP/XP2WcwF/7ss6CJdDgJLEI7Hyg=;
        b=gxW1nVtpH84o/nbi5woheh8zRfrU2Z7fNfZGKGGA3p3XUZRPHHZYRDzJWK+fsno4in
         PXl8YZDn5SsVxrVbEab2BOV0Nu+eYfTezU/ZSInb4iHY7ahPlfu2B1zGk/z9s0I9DfW+
         GNKUs55gBbr6LVe+BDXjVgwUP1SWMyldhKVJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E+KMvngL+puQ2rU+2U+9p9zZNxP7jM5ow7wjqGr/g/RT2UVkbqB04YF9vNYANgchP1
         3WGYJCCpeduFiftG//in7GzmvKYABLn+c1M/gEqpXelGsjHiy6nCSk+kJr+iDXzVu+jA
         oWNJp5CgJisYwf5Up102fPAqVAoRemr3EkpC8=
Received: by 10.227.174.14 with SMTP id r14mr621824wbz.30.1304017497795;
        Thu, 28 Apr 2011 12:04:57 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.55
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172392>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This patch is based on Kevin Cernekee's <cernekee@gmail.com>
patch series entitled "gitweb: introduce localtime feature".  While
Kevin's patch changed the server side output so that the timezone
was output from gitweb itself, this has a number of drawbacks, in
particular with respect to gitweb-caching.

This patch takes the same basic goal, display the appropriate times in
a given common timezone, and implements it in JavaScript.  This
requires adding / using a new class, "datetime", to be able to find
elements to be adjusted from JavaScript.  Appropriate dates are
wrapped in a span with this class.

Timezone to be used can be retrieved from "gitweb_tz" cookie, though
currently there is no way to set / manipulate this cookie from gitweb;
this is left for later commit.

Valid timezones, currently, are: "utc", "local" (which means that
timezone is taken from browser), and "+/-ZZZZ" numeric timezone as in
RFC-2822.  Default timezone is "local" (currently not configurable,
left for later commit).

Fallback (should JavaScript not be enabled) is to treat dates as they
have been and display them, only, in UTC.

Pages affected:
* 'summary' view, "last change" field (commit time from latest change)
* 'log' view, author time
* 'commit' and 'commitdiff' views, author/committer time
* 'tag' view, tagger time

Based-on-code-from: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The only change from v2 is that we used

  epoch = parseRFC2822Date(curElement.innerHTML);

now we use

  epoch = parseRFC2822Date(curElement.firstChild.data);

This is because of two reasons:
* it futureproofs fixDatetimeTZ() against eventual changes in
  structure of gitweb output (of contents of "span.datetime"),
  like e.g. timezone selection menu not deleted but only made
  invisible.

* it is more consistent, because we have to use .firstChild.data
  instead of .innerHTML for setting, as the latter doesn't work
  for Mozilla 1.17.2 in [overly] strict settings (XHTML DOM +
  application/xml+xhtml mimetype).  

...
This is major part of J.H. patch.

NOTE that while major ideas (and some of names) are taken from
J.H. patch, the code was practically written anew from scratch.

I avoid using global variables, as recommended in various tips for
better JavaScript performance.  Global variables are discouraged
anyway...


Actual interface for changing / selecting timezone is left for later
commit, both because smaller patches are easier to review, and because
interface part is more tricky and involves more issues

...
Changes compared to original patch by J.H.

* In J.H. patch if the feature is enabled, i.e. if $jslocaltime is not
  equal '' (the check should probably be if $jslocaltime is false-ish;
  neither '-0000' nor '+0000' is false-ish), five additional SCRIPT
  elements are added: four loading new external scripts (libraries),
  one running onloadTZSetup()... and not as window.onload handler.

  This series makes it so gitweb.js is composed of newly introduced or
  result of splitting JavaScript files, so $gitweb_js remains only
  loaded external script (note: it can be minified).  onloadTZSetup
  call is added to anonymous function which is used as window.onload
  handler.  Thus there are no new SCRIPT elements.

* The default timezone is 'local' like in J.H. patch, but it is passed
  from gitweb.perl as onloadTZSetup argument, and not put in global
  variable tzDefault from gitweb variable $jslocaltime (sic!).  Note
  that in this patch default timezone is not yet configurable, and
  that you cannot yet turn off this feature.

* The cookie name is 'gitweb_tz' not 'tzOffset', and is passed from
  gitweb.perl as parameter to onloadTZSetup, and not put in global
  variable named getwebCookieTZOffset (sic!).

* The classname that marks dates for manipulation by adjusting
  timezone is "datetime" and not "dtcommit" like in J.H. patch,
  because of taggerdate ('tag' view) case.  It is passed to JavaScript
  code as argument to onloadTZSetup().

  Note that thanks to next to previous patch we need to add 
  '<span class="datetime">' only in one place: in format_timestamp_html
  function, as compared to J.H. patch modifying 3 places.

* onloadTZSetup, which in this patch has options passed from gitweb by
  the way of function arguments rather than global variables, first
  checks cookie then fixes dates to given timezone; in J.H. patch it
  checks cookie last.

  In this patch we skip manipulating dates if timezone is 'utc',
  i.e. the same as gitweb already outputs.

* original tzChangeNS -> tzChangeSNS (why this indirection?) finds
  elements by hardcoded classname "dtcommit" (though it might apply
  also to taggerdate), gets supposedly machine readable but not in all
  browsers (see Kevin comment in [1]) ISO-8601 format from title
  attribute, and uses it as base for datetime manipulation, and uses
  .innerHTML for changing output.

  fixDatetimeTZ finds elements with tzClassName class (passed down
  from call in gitweb.perl), uses original RFC-2822 formatted date
  from contents of the element (or rather its first child text node)
  as base for datetime manipulation, and uses .firstChild.data 
  (W3C DOM 2 Core TextNode interface) for changing output.

  tzChangeSNS in J.H. patch also set cookie, and added triggers for
  timezone selection menu -- this really shouldn't be its job.

  The function to generate RFC-2822 date with adjusted timezone is
  named formatRFC2822Date and not dateOutputTZ.

  Please also take note of caching length of Array or live NodeSet in
  a loop.

  [1] http://thread.gmane.org/gmane.comp.version-control.git/169384/focus=169891

* The knowledge of "utc" and "local" timezones is encapsulated in
  normalizeTimezoneInfo() function in lib/datetime.js, instead of
  being in dateOutputTZ().  Knowledge about how to get local timezone
  in +/-HHMM format is contained in localTimezoneInfo() function.

 gitweb/Makefile                     |    1 +
 gitweb/gitweb.perl                  |   11 +++++--
 gitweb/static/js/adjust-timezone.js |   60 +++++++++++++++++++++++++++++++++++
 gitweb/static/js/lib/datetime.js    |   15 +++++++++
 4 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 gitweb/static/js/adjust-timezone.js

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 7dd1dee..5d20515 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -120,6 +120,7 @@ GITWEB_JSLIB_FILES += static/js/lib/common-lib.js
 GITWEB_JSLIB_FILES += static/js/lib/datetime.js
 GITWEB_JSLIB_FILES += static/js/lib/cookies.js
 GITWEB_JSLIB_FILES += static/js/javascript-detection.js
+GITWEB_JSLIB_FILES += static/js/adjust-timezone.js
 GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 67bcfe8..6651946 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3732,9 +3732,14 @@ sub git_footer_html {
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
 		      qq!</script>\n!;
-	} elsif (gitweb_check_feature('javascript-actions')) {
+	} else {
 		print qq!<script type="text/javascript">\n!.
-		      qq!window.onload = fixLinks;\n!.
+		      qq!window.onload = function () {\n!.
+		      (gitweb_check_feature('javascript-actions') ?
+		      qq!	fixLinks();\n! : '').
+		      # last parameter to onloadTZSetup must be CSS class used by format_timestamp_html
+		      qq!	onloadTZSetup('local', 'gitweb_tz', 'datetime');\n!.
+		      qq!};\n!.
 		      qq!</script>\n!;
 	}
 
@@ -3940,7 +3945,7 @@ sub git_print_section {
 
 sub format_timestamp_html {
 	my $date = shift;
-	my $strtime = $date->{'rfc2822'};
+	my $strtime = '<span class="datetime">'.$date->{'rfc2822'}.'</span>';
 
 	my $localtime_format = '(%02d:%02d %s)';
 	if ($date->{'hour_local'} < 6) {
diff --git a/gitweb/static/js/adjust-timezone.js b/gitweb/static/js/adjust-timezone.js
new file mode 100644
index 0000000..1577d78
--- /dev/null
+++ b/gitweb/static/js/adjust-timezone.js
@@ -0,0 +1,60 @@
+// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
+//               2011, Jakub Narebski <jnareb@gmail.com>
+
+/**
+ * @fileOverview Manipulate dates in gitweb output, adjusting timezone
+ * @license GPLv2 or later
+ */
+
+/**
+ * Get common timezone and adjust dates to use this common timezone.
+ *
+ * This function is called during onload event (added to window.onload).
+ *
+ * @param {String} tzDefault: default timezone, if there is no cookie
+ * @param {String} tzCookieName: name of cookie to store timezone
+ * @param {String} tzClassName: denotes elements with date to be adjusted
+ */
+function onloadTZSetup(tzDefault, tzCookieName, tzClassName) {
+	var tzCookie = getCookie(tzCookieName);
+	var tz = tzCookie ? tzCookie : tzDefault;
+
+	// server-side of gitweb produces datetime in UTC,
+	// so if tz is 'utc' there is no need for changes
+	if (tz !== 'utc') {
+		fixDatetimeTZ(tz, tzClassName);
+	}
+}
+
+
+/**
+ * Replace RFC-2822 dates contained in SPAN elements with tzClassName
+ * CSS class with equivalent dates in given timezone.
+ *
+ * @param {String} tz: numeric timezone in '(-|+)HHMM' format, or 'utc', or 'local'
+ * @param {String} tzClassName: specifies elements to be changed
+ */
+function fixDatetimeTZ(tz, tzClassName) {
+	// sanity check, method should be ensured by common-lib.js
+	if (!document.getElementsByClassName) {
+		return;
+	}
+
+	// translate to timezone in '(-|+)HHMM' format
+	tz = normalizeTimezoneInfo(tz);
+
+	// NOTE: result of getElementsByClassName should probably be cached
+	var classesFound = document.getElementsByClassName(tzClassName, "span");
+	for (var i = 0, len = classesFound.length; i < len; i++) {
+		var curElement = classesFound[i];
+
+		// we use *.firstChild.data (W3C DOM) instead of *.innerHTML
+		// as the latter doesn't always work everywhere in every browser
+		var epoch = parseRFC2822Date(curElement.firstChild.data);
+		var adjusted = formatDateRFC2882(epoch, tz);
+
+		curElement.firstChild.data = adjusted;
+	}
+}
+
+/* end of adjust-timezone.js */
diff --git a/gitweb/static/js/lib/datetime.js b/gitweb/static/js/lib/datetime.js
index b3dcedb..f78c60a 100644
--- a/gitweb/static/js/lib/datetime.js
+++ b/gitweb/static/js/lib/datetime.js
@@ -105,6 +105,21 @@ function formatTimezoneInfo(hours, minutes, sep) {
 }
 
 /**
+ * translate 'utc' and 'local' to numerical timezone
+ * @param {String} timezoneInfo: might be 'utc' or 'local' (browser)
+ */
+function normalizeTimezoneInfo(timezoneInfo) {
+	switch (timezoneInfo) {
+	case 'utc':
+		return '+0000';
+	case 'local': // 'local' is browser timezone
+		return localTimezoneInfo();
+	}
+	return timezoneInfo;
+}
+
+
+/**
  * return date in local time formatted in iso-8601 like format
  * 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
  *
-- 
1.7.3
