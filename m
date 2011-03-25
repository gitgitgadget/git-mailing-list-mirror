From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 1/3] gitweb: Split JavaScript for maintability; concatenate on build
Date: Fri, 25 Mar 2011 22:46:24 +0100
Message-ID: <1301089586-8534-2-git-send-email-jnareb@gmail.com>
References: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 22:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Eqf-0003g1-Jz
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab1CYVqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 17:46:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50419 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab1CYVqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 17:46:50 -0400
Received: by wya21 with SMTP id 21so1471195wya.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=AHuz0iOEAWp4VIAKQpoOvWxxI8bfFUhhTwwqfPSVPpM=;
        b=o8GgthZulfrBJxydVp+77bmtiWtzDzQ1wWFv9Eb7Xbt3JtAFUrcewSKpYW6sfisUXk
         PJnUcOwtSOzmuYlnIFw3mejTjkaJg9HFw5nVP/JebowUGtDT6D+MdzFxKyPxXf+SC66I
         qOIbfDuB4TLrVrD9aIVyEFlrOkBMgjMjX+0DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iWv0K7cUXZVY0PCThINaiWHeuqIQh5B2rh8TTo+ek2NwyGvFU0Tzf8que6uphXWKdV
         K/fN2wphnG/LFpiRCfhifN/yXEjdGf9FXbZCViv6qPPwdjuhigicndB8K4ejbNfYaWWj
         7JnwrllHdcyFuO85YDou96z+m4NLxEAf979iQ=
Received: by 10.227.159.77 with SMTP id i13mr1243672wbx.177.1301089608247;
        Fri, 25 Mar 2011 14:46:48 -0700 (PDT)
Received: from localhost.localdomain (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id g7sm647802wby.14.2011.03.25.14.46.46
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 14:46:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170023>

Split single gitweb.js file into smaller files, each dealing with
single thing.  This should make gitweb's JavaScript code easier to
maintain.

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

Inspired-by-patch-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 .gitignore                                         |    1 +
 gitweb/Makefile                                    |   12 +-
 .../static/{gitweb.js => js/blame_incremental.js}  |  196 +-------------------
 gitweb/static/js/common-lib.js                     |  173 +++++++++++++++++
 gitweb/static/js/detect-javascript.js              |   44 +++++
 5 files changed, 233 insertions(+), 193 deletions(-)
 rename gitweb/static/{gitweb.js => js/blame_incremental.js} (77%)
 create mode 100644 gitweb/static/js/common-lib.js
 create mode 100644 gitweb/static/js/detect-javascript.js

diff --git a/.gitignore b/.gitignore
index c460c66..601c71a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -160,6 +160,7 @@
 /gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
+/gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /test-chmtime
 /test-ctype
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..230b1b9 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -86,7 +86,7 @@ ifndef V
 endif
 endif
 
-all:: gitweb.cgi
+all:: gitweb.cgi static/gitweb.js
 
 GITWEB_PROGRAMS = gitweb.cgi
 
@@ -112,6 +112,11 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+GITWEB_JSLIB_FILES += static/js/common-lib.js
+GITWEB_JSLIB_FILES += static/js/detect-javascript.js
+GITWEB_JSLIB_FILES += static/js/blame_incremental.js
+
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -146,6 +151,11 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 	chmod +x $@+ && \
 	mv $@+ $@
 
+static/gitweb.js: $(GITWEB_JSLIB_FILES)
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	cat $^ >$@+ && \
+	mv $@+ $@
+
 ### Testing rules
 
 test:
diff --git a/gitweb/static/gitweb.js b/gitweb/static/js/blame_incremental.js
similarity index 77%
rename from gitweb/static/gitweb.js
rename to gitweb/static/js/blame_incremental.js
index 9c66928..3317390 100644
--- a/gitweb/static/gitweb.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -1,44 +1,13 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
 //               2007, Petr Baudis <pasky@suse.cz>
-//          2008-2009, Jakub Narebski <jnareb@gmail.com>
+//          2008-2011, Jakub Narebski <jnareb@gmail.com>
 
 /**
- * @fileOverview JavaScript code for gitweb (git web interface).
+ * @fileOverview JavaScript side of Ajax-y 'blame_incremental' view in gitweb
+ *               requires functions in common-lib.js to be available
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
@@ -59,71 +28,6 @@ function fixLinks() {
 
 
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
@@ -392,98 +296,6 @@ function fixColorsAndGroups() {
 	}
 }
 
-/* ............................................................ */
-/* time and data */
-
-/**
- * used to extract hours and minutes from timezone info, e.g '-0900'
- * @constant
- */
-var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
-
-/**
- * return date in local time formatted in iso-8601 like format
- * 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
- *
- * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
- * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
- * @returns {String} date in local time in iso-8601 like format
- *
- * @globals tzRe
- */
-function formatDateISOLocal(epoch, timezoneInfo) {
-	var match = tzRe.exec(timezoneInfo);
-	// date corrected by timezone
-	var localDate = new Date(1000 * (epoch +
-		(parseInt(match[1],10)*3600 + parseInt(match[2],10)*60)));
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
-
 /* ============================================================ */
 /* main part: parsing response */
 
@@ -872,4 +684,4 @@ function startBlame(blamedataUrl, bUrl) {
 	pollTimer = setInterval(xhr.onreadystatechange, 1000);
 }
 
-// end of gitweb.js
+/* end of blame_incremental.js */
diff --git a/gitweb/static/js/common-lib.js b/gitweb/static/js/common-lib.js
new file mode 100644
index 0000000..566c98a
--- /dev/null
+++ b/gitweb/static/js/common-lib.js
@@ -0,0 +1,173 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+//               2007, Petr Baudis <pasky@suse.cz>
+//          2008-2011, Jakub Narebski <jnareb@gmail.com>
+
+/**
+ * @fileOverview Generic JavaScript code (helper functions).
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
+var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
+
+/**
+ * return date in local time formatted in iso-8601 like format
+ * 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
+ *
+ * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
+ * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
+ * @returns {String} date in local time in iso-8601 like format
+ *
+ * @globals tzRe
+ */
+function formatDateISOLocal(epoch, timezoneInfo) {
+	var match = tzRe.exec(timezoneInfo);
+	// date corrected by timezone
+	var localDate = new Date(1000 * (epoch +
+		(parseInt(match[1],10)*3600 + parseInt(match[2],10)*60)));
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
diff --git a/gitweb/static/js/detect-javascript.js b/gitweb/static/js/detect-javascript.js
new file mode 100644
index 0000000..12a221d
--- /dev/null
+++ b/gitweb/static/js/detect-javascript.js
@@ -0,0 +1,44 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+//               2007, Petr Baudis <pasky@suse.cz>
+//          2008-2011, Jakub Narebski <jnareb@gmail.com>
+
+/**
+ * @fileOverview Detect if JavaScript is enabled, and pass it to server-side,
+ *               so that JavaScript-only version of page would/could be used
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
+/* end of detect-javascript.js */
-- 
1.7.3
