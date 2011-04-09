From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 01/11] gitweb: Split JavaScript for maintability, combining on build
Date: Sun, 10 Apr 2011 00:49:16 +0200
Message-ID: <1302389366-21515-2-git-send-email-jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 00:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gyi-00058j-SK
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab1DIWtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:49:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40519 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab1DIWts (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:49:48 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2942648fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OBanDFe3Uko7MwpZVk35KYJLEJkbQrJbyjpOn8pqlDQ=;
        b=lP6qX3LbF53zkBW8HZyis8ffOEr9Q4qhik37e6S3tmL6rAgu7M4CmYWJgnxXuUq4xY
         vBDi5XV54Du2cdlLT87ZxzWLQQBwQ2lMhOXXkZpN8h1fntXORiB6k2py1KF4wMzI0ShJ
         32dH8iIzqfd1XXAq4N0Kp0cY3tugPtxPWVzls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gGAktu8URwZDmMMfuJyRdK3sRQ5w10sOr4q4jRifanI+OktlD1Janl2R1o2oqXwO+5
         RdirJ2zC8j+sIF2WkIQTSjurNWPuIt3zLQzCIe+jTDCuue5JP+VXK0bruofibTfxdpg/
         qBRUFsgcCc1c1eFZ1+IxqDzCr5vByJnsQYDn8=
Received: by 10.223.102.129 with SMTP id g1mr2722350fao.3.1302389387908;
        Sat, 09 Apr 2011 15:49:47 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.49.45
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:49:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171213>

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
Original J.H. patch had
JH>
JH> Enabling this will then add several javascript files to be loaded,
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

While I agree with J.H. that for maintenance reasons JavaScript files
should be split, most web best practice pages recommends to combine
JavaScript files for performance.  This patch allows both.


What is unfortunately not visible from diffstat below is that it is
almost straightforward split of original gitweb/statis/gitweb.js file,
with only some header and footer comments added.

Is there any magic git-diff / git-show onvocation that is able to turn
split into patch involving solely renames / copies in split result?

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
