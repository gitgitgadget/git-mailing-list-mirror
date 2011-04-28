From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 03/13] gitweb: Split JavaScript for maintability, combining on build
Date: Thu, 28 Apr 2011 21:04:01 +0200
Message-ID: <1304017451-12283-4-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWX-0003Nk-H1
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413Ab1D1TEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:04:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38748 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917Ab1D1TEn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:43 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2330897wya.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=7Xj/CPTUAvXwZEuuBRQu8hHLwV08kB7K0lObZkbwZZU=;
        b=axJuuwtCEcra4xa0WyC+tK5/WGuqeNDOvcJCo8jCPVGziRYi/2S2JTOeKQAuWc2Nx6
         3Hk7/T2phYVJ4DAUFiWmm4mWAXHqGfC2EI6qcBdnu32ve9lnRBjvaykMCROToMRCjR7+
         dWAJlF48Bu4Z9SWwsw90uklrqXBXl7pRBTOe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pcX19qZUQdhVpeXQOfHjRyxPtlSh7OTWFdZ7FNZUy6wQ5hgHWePOfPdOV4oXMtoEU3
         1GZVvNkyHWmSfudejGO4S5VfOPBUhG8zLrrr5kK/WNJA5kE1viz2bk44/ngap2Dpm8U7
         xLuX1QtXEDnfkGTix6rbwlZqnWHk8Ja6xGWZw=
Received: by 10.227.1.151 with SMTP id 23mr3881861wbf.175.1304017482465;
        Thu, 28 Apr 2011 12:04:42 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.40
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172385>

Split originally single gitweb.js file into smaller files, each
dealing with single issue / area of responsibility.  This move should
make gitweb's JavaScript code easier to maintain.

For better webapp performance it is recommended[1][2][3] to combine
JavaScript files.  Do it during build time (in gitweb/Makefile), by
straight concatenation of files into gitweb.js file (which is now
ignored as being generated).  This means that there are no changes to
gitweb script itself - it still uses gitweb.js or gitweb.min.js, but
now generated.

[1]: http://developer.yahoo.com/performance/rules.html
     "Minimize HTTP Requests" section
[2]: http://code.google.com/speed/articles/include-scripts-properly.html
     "1. Combine external JavaScript files"
[3]: http://javascript-reference.info/speed-up-your-javascript-load-time.htm
     "Combine Your Files" section.

See also new gitweb/static/js/README file.

Inspired-by-patch-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from first version of this series.

Original J.H. patch had
JH>
JH> Enabling this will then add several javascript files to be loaded,
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

While I agree with J.H. that for maintenance reasons JavaScript files
should be split, most web best practice pages recommend to combine
JavaScript files for performance.  This patch allows both.


What is unfortunately not visible from diffstat below is that it is
almost straightforward split of original gitweb/static/gitweb.js file,
with only some header and footer comments added.

I hope that newly introduced gitweb/static/js/README would be of help
to future developers.

 .gitignore                                         |    1 +
 gitweb/Makefile                                    |   16 ++-
 gitweb/static/js/README                            |   20 ++
 .../static/{gitweb.js => js/blame_incremental.js}  |  208 +-------------------
 gitweb/static/js/javascript-detection.js           |   43 ++++
 gitweb/static/js/lib/common-lib.js                 |  187 ++++++++++++++++++
 6 files changed, 269 insertions(+), 206 deletions(-)
 create mode 100644 gitweb/static/js/README
 rename gitweb/static/{gitweb.js => js/blame_incremental.js} (76%)
 create mode 100644 gitweb/static/js/javascript-detection.js
 create mode 100644 gitweb/static/js/lib/common-lib.js

diff --git a/.gitignore b/.gitignore
index 2cf3ca5..9e95005 100644
--- a/.gitignore
+++ b/.gitignore
@@ -158,6 +158,7 @@
 /gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
+/gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /test-chmtime
 /test-ctype
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..0baa9df 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -86,7 +86,7 @@ ifndef V
 endif
 endif
 
-all:: gitweb.cgi
+all:: gitweb.cgi static/gitweb.js
 
 GITWEB_PROGRAMS = gitweb.cgi
 
@@ -112,6 +112,15 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# JavaScript files that are composed (concatenated) to form gitweb.js
+#
+# js/lib/common-lib.js should be always first, then js/lib/*.js,
+# then the rest of files; js/gitweb.js should be last (if it exists)
+GITWEB_JSLIB_FILES += static/js/lib/common-lib.js
+GITWEB_JSLIB_FILES += static/js/javascript-detection.js
+GITWEB_JSLIB_FILES += static/js/blame_incremental.js
+
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -146,6 +155,11 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 	chmod +x $@+ && \
 	mv $@+ $@
 
+static/gitweb.js: $(GITWEB_JSLIB_FILES)
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	cat $^ >$@+ && \
+	mv $@+ $@
+
 ### Testing rules
 
 test:
diff --git a/gitweb/static/js/README b/gitweb/static/js/README
new file mode 100644
index 0000000..f8460ed
--- /dev/null
+++ b/gitweb/static/js/README
@@ -0,0 +1,20 @@
+GIT web interface (gitweb) - JavaScript
+=======================================
+
+This directory holds JavaScript code used by gitweb (GIT web interface).
+Scripts from there would be concatenated together in the order specified
+by gitweb/Makefile into gitweb/static/gitweb.js, during building of
+gitweb/gitweb.cgi (during gitweb building).  The resulting file (or its
+minification) would then be installed / deployed together with gitweb.
+
+Scripts in 'lib/' subdirectory compose generic JavaScript library,
+providing features required by gitweb but in no way limited to gitweb
+only.  In the future those scripts could be replaced by some JavaScript
+library / framework, like e.g. jQuery, YUI, Prototype, MooTools, Dojo,
+ExtJS, Script.aculo.us or SproutCore.
+
+All scripts that manipulate gitweb output should be put outside 'lib/',
+directly in this directory ('gitweb/static/js/').  Those scripts would
+have to be rewritten if gitweb moves to using some JavaScript library.
+
+See also comments in gitweb/Makefile.
diff --git a/gitweb/static/gitweb.js b/gitweb/static/js/blame_incremental.js
similarity index 76%
rename from gitweb/static/gitweb.js
rename to gitweb/static/js/blame_incremental.js
index 40ec084..f63f78b 100644
--- a/gitweb/static/gitweb.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -1,44 +1,12 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
 //               2007, Petr Baudis <pasky@suse.cz>
-//          2008-2009, Jakub Narebski <jnareb@gmail.com>
+//          2008-2011, Jakub Narebski <jnareb@gmail.com>
 
 /**
- * @fileOverview JavaScript code for gitweb (git web interface).
+ * @fileOverview JavaScript side of Ajax-y 'blame_incremental' view in gitweb
  * @license GPLv2 or later
  */
 
-/* ============================================================ */
-/* functions for generic gitweb actions and views */
-
-/**
- * used to check if link has 'js' query parameter already (at end),
- * and other reasons to not add 'js=1' param at the end of link
- * @constant
- */
-var jsExceptionsRe = /[;?]js=[01]$/;
-
-/**
- * Add '?js=1' or ';js=1' to the end of every link in the document
- * that doesn't have 'js' query parameter set already.
- *
- * Links with 'js=1' lead to JavaScript version of given action, if it
- * exists (currently there is only 'blame_incremental' for 'blame')
- *
- * @globals jsExceptionsRe
- */
-function fixLinks() {
-	var allLinks = document.getElementsByTagName("a") || document.links;
-	for (var i = 0, len = allLinks.length; i < len; i++) {
-		var link = allLinks[i];
-		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
-			link.href +=
-				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
-		}
-	}
-}
-
-
-/* ============================================================ */
 
 /*
  * This code uses DOM methods instead of (nonstandard) innerHTML
@@ -59,71 +27,6 @@ function fixLinks() {
 
 
 /* ============================================================ */
-/* generic utility functions */
-
-
-/**
- * pad number N with nonbreakable spaces on the left, to WIDTH characters
- * example: padLeftStr(12, 3, '\u00A0') == '\u00A012'
- *          ('\u00A0' is nonbreakable space)
- *
- * @param {Number|String} input: number to pad
- * @param {Number} width: visible width of output
- * @param {String} str: string to prefix to string, e.g. '\u00A0'
- * @returns {String} INPUT prefixed with (WIDTH - INPUT.length) x STR
- */
-function padLeftStr(input, width, str) {
-	var prefix = '';
-
-	width -= input.toString().length;
-	while (width > 0) {
-		prefix += str;
-		width--;
-	}
-	return prefix + input;
-}
-
-/**
- * Pad INPUT on the left to SIZE width, using given padding character CH,
- * for example padLeft('a', 3, '_') is '__a'.
- *
- * @param {String} input: input value converted to string.
- * @param {Number} width: desired length of output.
- * @param {String} ch: single character to prefix to string.
- *
- * @returns {String} Modified string, at least SIZE length.
- */
-function padLeft(input, width, ch) {
-	var s = input + "";
-	while (s.length < width) {
-		s = ch + s;
-	}
-	return s;
-}
-
-/**
- * Create XMLHttpRequest object in cross-browser way
- * @returns XMLHttpRequest object, or null
- */
-function createRequestObject() {
-	try {
-		return new XMLHttpRequest();
-	} catch (e) {}
-	try {
-		return window.createRequest();
-	} catch (e) {}
-	try {
-		return new ActiveXObject("Msxml2.XMLHTTP");
-	} catch (e) {}
-	try {
-		return new ActiveXObject("Microsoft.XMLHTTP");
-	} catch (e) {}
-
-	return null;
-}
-
-
-/* ============================================================ */
 /* utility/helper functions (and variables) */
 
 var xhr;        // XMLHttpRequest object
@@ -392,111 +295,6 @@ function fixColorsAndGroups() {
 	}
 }
 
-/* ............................................................ */
-/* time and data */
-
-/**
- * used to extract hours and minutes from timezone info, e.g '-0900'
- * @constant
- */
-var tzRe = /^([+-])([0-9][0-9])([0-9][0-9])$/;
-
-/**
- * convert numeric timezone +/-ZZZZ to offset from UTC in seconds
- *
- * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
- * @returns {Number} offset from UTC in seconds for timezone
- *
- * @globals tzRe
- */
-function timezoneOffset(timezoneInfo) {
-	var match = tzRe.exec(timezoneInfo);
-	var tz_sign = (match[1] === '-' ? -1 : +1);
-	var tz_hour = parseInt(match[2],10);
-	var tz_min  = parseInt(match[3],10);
-
-	return tz_sign*(((tz_hour*60) + tz_min)*60);
-}
-
-/**
- * return date in local time formatted in iso-8601 like format
- * 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
- *
- * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
- * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
- * @returns {String} date in local time in iso-8601 like format
- */
-function formatDateISOLocal(epoch, timezoneInfo) {
-	// date corrected by timezone
-	var localDate = new Date(1000 * (epoch +
-		timezoneOffset(timezoneInfo)));
-	var localDateStr = // e.g. '2005-08-07'
-		localDate.getUTCFullYear()                 + '-' +
-		padLeft(localDate.getUTCMonth()+1, 2, '0') + '-' +
-		padLeft(localDate.getUTCDate(),    2, '0');
-	var localTimeStr = // e.g. '21:49:46'
-		padLeft(localDate.getUTCHours(),   2, '0') + ':' +
-		padLeft(localDate.getUTCMinutes(), 2, '0') + ':' +
-		padLeft(localDate.getUTCSeconds(), 2, '0');
-
-	return localDateStr + ' ' + localTimeStr + ' ' + timezoneInfo;
-}
-
-/* ............................................................ */
-/* unquoting/unescaping filenames */
-
-/**#@+
- * @constant
- */
-var escCodeRe = /\\([^0-7]|[0-7]{1,3})/g;
-var octEscRe = /^[0-7]{1,3}$/;
-var maybeQuotedRe = /^\"(.*)\"$/;
-/**#@-*/
-
-/**
- * unquote maybe git-quoted filename
- * e.g. 'aa' -> 'aa', '"a\ta"' -> 'a	a'
- *
- * @param {String} str: git-quoted string
- * @returns {String} Unquoted and unescaped string
- *
- * @globals escCodeRe, octEscRe, maybeQuotedRe
- */
-function unquote(str) {
-	function unq(seq) {
-		var es = {
-			// character escape codes, aka escape sequences (from C)
-			// replacements are to some extent JavaScript specific
-			t: "\t",   // tab            (HT, TAB)
-			n: "\n",   // newline        (NL)
-			r: "\r",   // return         (CR)
-			f: "\f",   // form feed      (FF)
-			b: "\b",   // backspace      (BS)
-			a: "\x07", // alarm (bell)   (BEL)
-			e: "\x1B", // escape         (ESC)
-			v: "\v"    // vertical tab   (VT)
-		};
-
-		if (seq.search(octEscRe) !== -1) {
-			// octal char sequence
-			return String.fromCharCode(parseInt(seq, 8));
-		} else if (seq in es) {
-			// C escape sequence, aka character escape code
-			return es[seq];
-		}
-		// quoted ordinary character
-		return seq;
-	}
-
-	var match = str.match(maybeQuotedRe);
-	if (match) {
-		str = match[1];
-		// perhaps str = eval('"'+str+'"'); would be enough?
-		str = str.replace(escCodeRe,
-			function (substr, p1, offset, s) { return unq(p1); });
-	}
-	return str;
-}
 
 /* ============================================================ */
 /* main part: parsing response */
@@ -886,4 +684,4 @@ function startBlame(blamedataUrl, bUrl) {
 	pollTimer = setInterval(xhr.onreadystatechange, 1000);
 }
 
-// end of gitweb.js
+/* end of blame_incremental.js */
diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static/js/javascript-detection.js
new file mode 100644
index 0000000..93dd2bd
--- /dev/null
+++ b/gitweb/static/js/javascript-detection.js
@@ -0,0 +1,43 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+//               2007, Petr Baudis <pasky@suse.cz>
+//          2008-2011, Jakub Narebski <jnareb@gmail.com>
+
+/**
+ * @fileOverview Detect if JavaScript is enabled, and pass it to server-side
+ * @license GPLv2 or later
+ */
+
+
+/* ============================================================ */
+/* Manipulating links */
+
+/**
+ * used to check if link has 'js' query parameter already (at end),
+ * and other reasons to not add 'js=1' param at the end of link
+ * @constant
+ */
+var jsExceptionsRe = /[;?]js=[01]$/;
+
+/**
+ * Add '?js=1' or ';js=1' to the end of every link in the document
+ * that doesn't have 'js' query parameter set already.
+ *
+ * Links with 'js=1' lead to JavaScript version of given action, if it
+ * exists (currently there is only 'blame_incremental' for 'blame')
+ *
+ * To be used as `window.onload` handler
+ *
+ * @globals jsExceptionsRe
+ */
+function fixLinks() {
+	var allLinks = document.getElementsByTagName("a") || document.links;
+	for (var i = 0, len = allLinks.length; i < len; i++) {
+		var link = allLinks[i];
+		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
+			link.href +=
+				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
+		}
+	}
+}
+
+/* end of javascript-detection.js */
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
new file mode 100644
index 0000000..38f3b9e
--- /dev/null
+++ b/gitweb/static/js/lib/common-lib.js
@@ -0,0 +1,187 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+//               2007, Petr Baudis <pasky@suse.cz>
+//          2008-2011, Jakub Narebski <jnareb@gmail.com>
+
+/**
+ * @fileOverview Generic JavaScript code (helper functions)
+ * @license GPLv2 or later
+ */
+
+
+/* ============================================================ */
+/* ............................................................ */
+/* Padding */
+
+/**
+ * pad number N with nonbreakable spaces on the left, to WIDTH characters
+ * example: padLeftStr(12, 3, '\u00A0') == '\u00A012'
+ *          ('\u00A0' is nonbreakable space)
+ *
+ * @param {Number|String} input: number to pad
+ * @param {Number} width: visible width of output
+ * @param {String} str: string to prefix to string, e.g. '\u00A0'
+ * @returns {String} INPUT prefixed with (WIDTH - INPUT.length) x STR
+ */
+function padLeftStr(input, width, str) {
+	var prefix = '';
+
+	width -= input.toString().length;
+	while (width > 0) {
+		prefix += str;
+		width--;
+	}
+	return prefix + input;
+}
+
+/**
+ * Pad INPUT on the left to SIZE width, using given padding character CH,
+ * for example padLeft('a', 3, '_') is '__a'.
+ *
+ * @param {String} input: input value converted to string.
+ * @param {Number} width: desired length of output.
+ * @param {String} ch: single character to prefix to string.
+ *
+ * @returns {String} Modified string, at least SIZE length.
+ */
+function padLeft(input, width, ch) {
+	var s = input + "";
+	while (s.length < width) {
+		s = ch + s;
+	}
+	return s;
+}
+
+
+/* ............................................................ */
+/* Ajax */
+
+/**
+ * Create XMLHttpRequest object in cross-browser way
+ * @returns XMLHttpRequest object, or null
+ */
+function createRequestObject() {
+	try {
+		return new XMLHttpRequest();
+	} catch (e) {}
+	try {
+		return window.createRequest();
+	} catch (e) {}
+	try {
+		return new ActiveXObject("Msxml2.XMLHTTP");
+	} catch (e) {}
+	try {
+		return new ActiveXObject("Microsoft.XMLHTTP");
+	} catch (e) {}
+
+	return null;
+}
+
+
+/* ............................................................ */
+/* time and data */
+
+/**
+ * used to extract hours and minutes from timezone info, e.g '-0900'
+ * @constant
+ */
+var tzRe = /^([+-])([0-9][0-9])([0-9][0-9])$/;
+
+/**
+ * convert numeric timezone +/-ZZZZ to offset from UTC in seconds
+ *
+ * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
+ * @returns {Number} offset from UTC in seconds for timezone
+ *
+ * @globals tzRe
+ */
+function timezoneOffset(timezoneInfo) {
+	var match = tzRe.exec(timezoneInfo);
+	var tz_sign = (match[1] === '-' ? -1 : +1);
+	var tz_hour = parseInt(match[2],10);
+	var tz_min  = parseInt(match[3],10);
+
+	return tz_sign*(((tz_hour*60) + tz_min)*60);
+}
+
+/**
+ * return date in local time formatted in iso-8601 like format
+ * 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
+ *
+ * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
+ * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
+ * @returns {String} date in local time in iso-8601 like format
+ */
+function formatDateISOLocal(epoch, timezoneInfo) {
+	// date corrected by timezone
+	var localDate = new Date(1000 * (epoch +
+		timezoneOffset(timezoneInfo)));
+	var localDateStr = // e.g. '2005-08-07'
+		localDate.getUTCFullYear()                 + '-' +
+		padLeft(localDate.getUTCMonth()+1, 2, '0') + '-' +
+		padLeft(localDate.getUTCDate(),    2, '0');
+	var localTimeStr = // e.g. '21:49:46'
+		padLeft(localDate.getUTCHours(),   2, '0') + ':' +
+		padLeft(localDate.getUTCMinutes(), 2, '0') + ':' +
+		padLeft(localDate.getUTCSeconds(), 2, '0');
+
+	return localDateStr + ' ' + localTimeStr + ' ' + timezoneInfo;
+}
+
+
+/* ............................................................ */
+/* unquoting/unescaping filenames */
+
+/**#@+
+ * @constant
+ */
+var escCodeRe = /\\([^0-7]|[0-7]{1,3})/g;
+var octEscRe = /^[0-7]{1,3}$/;
+var maybeQuotedRe = /^\"(.*)\"$/;
+/**#@-*/
+
+/**
+ * unquote maybe git-quoted filename
+ * e.g. 'aa' -> 'aa', '"a\ta"' -> 'a	a'
+ *
+ * @param {String} str: git-quoted string
+ * @returns {String} Unquoted and unescaped string
+ *
+ * @globals escCodeRe, octEscRe, maybeQuotedRe
+ */
+function unquote(str) {
+	function unq(seq) {
+		var es = {
+			// character escape codes, aka escape sequences (from C)
+			// replacements are to some extent JavaScript specific
+			t: "\t",   // tab            (HT, TAB)
+			n: "\n",   // newline        (NL)
+			r: "\r",   // return         (CR)
+			f: "\f",   // form feed      (FF)
+			b: "\b",   // backspace      (BS)
+			a: "\x07", // alarm (bell)   (BEL)
+			e: "\x1B", // escape         (ESC)
+			v: "\v"    // vertical tab   (VT)
+		};
+
+		if (seq.search(octEscRe) !== -1) {
+			// octal char sequence
+			return String.fromCharCode(parseInt(seq, 8));
+		} else if (seq in es) {
+			// C escape sequence, aka character escape code
+			return es[seq];
+		}
+		// quoted ordinary character
+		return seq;
+	}
+
+	var match = str.match(maybeQuotedRe);
+	if (match) {
+		str = match[1];
+		// perhaps str = eval('"'+str+'"'); would be enough?
+		str = str.replace(escCodeRe,
+			function (substr, p1, offset, s) { return unq(p1); });
+	}
+	return str;
+}
+
+/* end of common-lib.js */
-- 
1.7.3
