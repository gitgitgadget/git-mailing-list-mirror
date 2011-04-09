From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 09/11] gitweb: JavaScript ability to adjust time based on timezone
Date: Sun, 10 Apr 2011 00:49:24 +0200
Message-ID: <1302389366-21515-10-git-send-email-jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 00:50:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gzA-0005HA-Lk
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab1DIWuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:50:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60231 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721Ab1DIWuC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:50:02 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2942671fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=GLBZrBP7QQKeNJAeSm21mr9k23VMifrqqn0qvF/kH1s=;
        b=EnBcH9zgDpxQ0cJp0fxxsWjHLfMbcukKfku/Gt4u5fvmFCcI3f3OkbVqioPUisEGVI
         bkAENnQ5FBUjiO0LtB0wyCd2Ur1KbKBbP8wMnRviSQ/ug4ZzkStLPzt7cESP4LFqYjm1
         Lpk79D/aZ2/oCzy/oNBvbJZAb8GYV9O7rlahw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LJ3BSHcawFxbyPe4oIa11+g5CqA5o4SS3cnpsYw4WaqJIFVF9rKCqypQjcr9cq+gMb
         T7Sq2tSUi0zqk5MEtFlXUgSOFmdXnBYZH9q24CpnI9bMfLYbmJ913Giqhl97Kk5Fq0QN
         y1HGQejWOVKp30LVUaaSDSN8QVCTSfIgoRasw=
Received: by 10.223.57.86 with SMTP id b22mr1239600fah.95.1302389401944;
        Sat, 09 Apr 2011 15:50:01 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.50.00
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:50:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171223>

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
left for later commit... though one could edit browser cookie externally).

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
This is major part of J.H. patch.

NOTE that while major ideas (and some of names) are taken from
J.H. patch, the code was practically written anew from scratch.

I avoid using global variables, as recommended in various tips for
better JavaScript performance.  Global variables are discouraged
anyway...


Actual interface for changing / selecting timezone is left for later
commit, both because smaller patches are easier to review, and because
interface part is more tricky and involves more issue.

 gitweb/Makefile                     |    1 +
 gitweb/gitweb.perl                  |   11 +++++--
 gitweb/static/js/adjust-timezone.js |   59 +++++++++++++++++++++++++++++++++++
 gitweb/static/js/lib/datetime.js    |   15 +++++++++
 4 files changed, 83 insertions(+), 3 deletions(-)
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
index 0000000..5cebc08
--- /dev/null
+++ b/gitweb/static/js/adjust-timezone.js
@@ -0,0 +1,59 @@
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
+ * @param {String} tz: numeric timezone in '(-|+)HHMM' format, or 'utf', or 'local'
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
+		var epoch = parseRFC2822Date(curElement.innerHTML);
+		var adjusted = formatDateRFC2882(epoch, tz);
+
+		// curElement.innerHTML = adjusted; // does not work for Mozilla 1.17.2
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
