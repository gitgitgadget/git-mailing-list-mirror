From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3/RFC 2/3] gitweb: Incremental blame (proof of concept)
Date: Thu,  6 Aug 2009 19:11:51 +0200
Message-ID: <1249578712-3862-3-git-send-email-jnareb@gmail.com>
References: <1249578712-3862-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6Vv-00048i-PT
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbZHFRMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756365AbZHFRMW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:12:22 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:49950 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350AbZHFRMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:12:18 -0400
Received: by qyk34 with SMTP id 34so955153qyk.33
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2ErhkF41cDWfSs1V6VDkSGkwhpqoawwfHKiwYt7evwY=;
        b=caL3gHeFMmB/GNMPF0Bi6/27PhCdIKh2RscXL4eG0M95KmhDDPiK8qOYBoIihEWQOa
         Khga3mu2bdB7rJrw+xNB/z5PiyyNHzRmxFA+d7SfeYnoNmVog8IaPWZQdeqi6pddqqzY
         h2DBbMKbKjNwnV+xWFxMPpTBEYSRPxfkvd5KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dwvyGQlFd/Wwbe2Le2xPILnPvfBCxGKZdgCK7CBnk1Tdv4N9pMDnXExtUXZNnWLfgI
         iMNikkOoxLykoNiMBbY5tiRZL8Rbt7FR8k1RU/tdHbYf8JiGGKZ5O6PDCO0C5uJDUnWP
         V8Vbco27JIpF5ursPyLfm1tn5UvEAtn7soUtk=
Received: by 10.224.28.201 with SMTP id n9mr126217qac.316.1249578737587;
        Thu, 06 Aug 2009 10:12:17 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.8])
        by mx.google.com with ESMTPS id 21sm151517ywh.13.2009.08.06.10.12.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 10:12:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n76HCABH003903;
	Thu, 6 Aug 2009 19:12:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n76HCAvi003902;
	Thu, 6 Aug 2009 19:12:10 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1249578712-3862-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125095>

This is tweaked up version of Petr Baudis <pasky@suse.cz> patch, which
in turn was tweaked up version of Fredrik Kuivinen <frekui@gmail.com>'s
proof of concept patch.  It adds 'blame_incremental' view, which
incrementally displays line data in blame view using JavaScript (AJAX).

This patch does not (contrary to the one by Petr Baudis) enable this
view in gitweb: there are no links leading to 'blame_incremental'
action.  You would have to generate URL 'by hand' (e.g. changing 'blame'
or 'blob' in gitweb URL to 'blame_incremental').  Having links in gitweb
lead to this new action (e.g. by rewriting them like in previous patch,
if JavaScript is enabled in browser) is left for later.

Like earlier patch by Per Baudis it avoids code duplication, but it goes
one step further and use git_blame_common for ordinary blame view, for
incremental blame, and (which is change from previous patch) for
incremental blame data.

How the 'blame_incremental' view works:
* gitweb generates initial info by putting file contents (from
  git-cat-file) together with line numbers in blame table
* then gitweb makes web browser JavaScript engine call startBlame()
  function from blame.js
* startBlame() opens connection to 'blame_data' view, which in turn
  calls "git blame --incremental" for a file, and streams output of
  git-blame to JavaScript (blame.js)
* blame.js updates line info in blame view, coloring it, and updating
  progress info; note that it has to use 3 colors to ensure that
  different neighbour groups have different styles
* when 'blame_data' ends, and blame.js finishes updating line info,
  it fixes colors to match (as far as possible) ordinary 'blame' view,
  and updates generating time info.

It deals with streamed 'blame_data' server error by notifying about them
in the progress info area (just in case).

Differences between 'blame_incremental' and original 'blame' view:
* 'blame_incremental' always used (partial) query form for links
  generated by JavaScript.  The difference is visible if we use path_info
  link (pass some or all arguments in path_info), e.g. in 'blame' view
  called using:
    http://git.example.com/w/git.git/blame/HEAD:/README
  we have 'linenr' links using the same form:
    http://git.example.com/w/git.git/blame/e83c5163316f89bfbde7d9ab23ca2e25604af290:/README#l4
  while in 'blame_incremental' view called with:
    http://git.example.com/w/git.git/blame_incremental/HEAD:/README
  we have "partial query" form
    http://git.example.com/w/git.git?;a=blame_incremental;hb=e83c5163316f89bfbde7d9ab23ca2e25604af290;f=README#l4
  Changing this would require implementing something akin to href()
  subroutine from gitweb.perl in JavaScript
* 'blame_incremental' currently always uses "rowspan" attribute,
  even when it leads to torowspan="1".  This is not visible to user.

This patch adds GITWEB_BLAMEJS compile configuration option, and
modifies git-instaweb.sh to take blame.js into account, but it does not
update gitweb/README file (as it is only proof of concept patch).  The
code for git-instaweb.sh was taken from Pasky's patch.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Refrences:
1. Original patch by Frederik Kuivinen
   http://article.gmane.org/gmane.comp.version-control.git/41361
2. Tweaked up version by Petr Baudis
   http://article.gmane.org/gmane.comp.version-control.git/47614
   http://article.gmane.org/gmane.comp.version-control.git/56657
3. New link rewriting and some optimization in Matrin Koegler
   series introducing some JavaScript support in Git
   http://thread.gmane.org/gmane.comp.version-control.git/47902/focus=47905   
4. My earlier patches
   http://thread.gmane.org/gmane.comp.version-control.git/102657/focus=102712
   http://article.gmane.org/gmane.comp.version-control.git/123202
   http://thread.gmane.org/gmane.comp.version-control.git/123957/focus=123968

Changes compared to last version (v2):
 * projectUrl now contains '?' or ';' as terminator; the bUrl
   parameter to startBlame function doesn't need to be 
   href(..., -partial_query), but just href(...).
 * Do not use (nonstandard but widely implemented) elem.innerHTML,
   but elem.firstChild.data (DOM 2 Core: CharacterData).  It is less
   powerfull (only text) and more fragile (text node has to exist,
   and has to be first child) currently, but a bit faster.  Code was
   modified to ensure that (' ' as tag content as a start value).
   See comment at beginning of blame.js file. 
 * Remove commenting out content type negotiation, which prevented
   sending 'application/xhtml+xml' content type if it is preferred by
   browser (gitweb always used 'text/html' in v2).   This content type
   causes in most browsers turning on strict XML mode; and in Firefox
   up to 1.5 it turned on strict _JavaScript_ mode, which meant no
   innerHTML.  Now that blame.js doesn't use innerHTML it is no longer
   necessary to have for me to be able to debug 'blame_incremental'
   view.

 * remove '#"' used to help with confused syntax highlighting
 * remove tr.colorN:hover style (doesn't work well with commit
   groups, i.e. blamed commit being responsible/blamed for several
   consecutive lines)
 * use document fragment to (try to) speed up DOM manipulation, 
   if possible (if browser supports createDocumentFragment())
 * use generic "padLeft(num, 2, '0')" in place of specilized
   "zeroPad(num)"; remove zeroPad() function
 * added JSDoc documentation and other comments
 * comment out debug(...) calls
 * extended copyright statement 
 * future-proof so 'var = Commmit(sha1);' works as 'var = new Commit(sha1);'
   (nice trick, but probably not necessary)

TODO list:
* Use W3C Progress Events in addition/instead of readystatechange
    http://www.w3.org/TR/progress-events/
    http://www.nczonline.net/blog/2009/07/09/firefox-35firebug-xmlhttprequest-and-readystatechange-bug/
  event, if XMLHttpResponse supports it
* handleResponse is used both as onreadystatechange and pollTimer;
  if onreadystatechange works for partial responses we can turn off
  the timer.
* handleResponse is protected from concurrent running by global
  inProgress variable; we could instead pass XMLHttpResponse object
  as a parameter (see comment in startBlame).
* Instead of running startBlame, put it in window.onload handler
* Rename blame.js to gitweb.js to have all JavaScript in a single
  file.  Note that this would require changes to next commit in
  series (enabling 'blame_incremental' view if browser has javaScript
  turned on).

TODO for future commits:
* Remove (fade out) progress bar and progress info after blame
  incremental finished run (left for a separate commit).
* Profile blame.js using YUI Profiler or other JavaScript profile tool
    http://developer.yahoo.com/yui/profiler/
  to check whether performance improvements described in articles
  on NCZOnline blog by Nicholas C. Zakas are required, and would help
    http://www.nczonline.net/blog/
* Check whether it is worth to do some server processing of
  incremental blame output, and send e.g. JSON and not text/plain
  of raw 'git blame --incremental' output.
* Check whether it would make sense to use some lightweight JavaScript
  library (framework) like jQuery, Prototype, ExtJS, MooTools, etc.
* Minify JavaScript during building gitweb/gitweb.cgi, if minification
  tool is found.

 Makefile           |    6 +-
 git-instaweb.sh    |    7 +
 gitweb/blame.js    |  731 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |   16 ++
 gitweb/gitweb.perl |  271 +++++++++++++------
 5 files changed, 944 insertions(+), 87 deletions(-)
 create mode 100644 gitweb/blame.js

diff --git a/Makefile b/Makefile
index daf4296..cb93aa3 100644
--- a/Makefile
+++ b/Makefile
@@ -265,6 +265,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_BLAMEJS = blame.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -1407,13 +1408,14 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	    -e 's|++GITWEB_BLAMEJS++|$(GITWEB_BLAMEJS)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/blame.js
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -1422,6 +1424,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_BLAMEJS@@/r gitweb/blame.js' \
+	    -e '/@@GITWEB_BLAMEJS@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 32f6496..15dfb96 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -331,8 +331,15 @@ gitweb_css () {
 EOFGITWEB
 }
 
+gitweb_blamejs () {
+	cat > "$1" <<\EOFGITWEB
+@@GITWEB_BLAMEJS@@
+EOFGITWEB
+}
+
 gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
 gitweb_css "$GIT_DIR/gitweb/gitweb.css"
+gitweb_blamejs "$GIT_DIR/gitweb/blame.js"
 
 case "$httpd" in
 *lighttpd*)
diff --git a/gitweb/blame.js b/gitweb/blame.js
new file mode 100644
index 0000000..5cdd20b
--- /dev/null
+++ b/gitweb/blame.js
@@ -0,0 +1,731 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+//               2007, Petr Baudis <pasky@suse.cz>
+//          2008-2009, Jakub Narebski <jnareb@gmail.com>
+
+/**
+ * @fileOverview JavaScript part of 'blame_incremental' action in gitweb.
+ * @license GPLv2 or later
+ */
+
+/*
+ * This code uses DOM methods instead of (nonstandard) innerHTML
+ * to modify page.
+ *
+ * innerHTML is non-standard IE extension, though supported by most
+ * browsers; however Firefox up to version 1.5 didn't implement it in
+ * a strict mode (application/xml+xhtml mimetype).  Also my simple
+ * benchmarks show that using elem.firstChild.data = 'content' is
+ * slightly faster than elem.innerHTML = 'content', if more fragile
+ * (text element fragment must exists), and less feature-rich (we
+ * cannot add HTML).
+ */
+
+/* ============================================================ */
+/* generic utility functions */
+
+var DEBUG = 0;
+function debug(str) {
+	if (DEBUG) {
+		alert(str);
+	}
+}
+
+/**
+ * pad number N with nonbreakable spaces on the left, to WIDTH characters
+ * example: spacePad(12, 3) == '&nbsp;12' ('&nbsp;' is nonbreakable space)
+ *
+ * @param {Number} n: number to pad
+ * @param {Number} width: visible width of output
+ * @returns {String} N prefixed with (WIDTH - N.length) x '&nbsp;'
+ */
+function spacePad(n, width) {
+	var prefix = '';
+
+	width -= n.toString().length;
+	while (width > 1) {
+		prefix += '&nbsp;';
+		width--;
+	}
+	return prefix + n;
+}
+
+/**
+ * Pad INPUT on the left to SIZE width, using given padding character CH,
+ * for example padLeft('a', 3, '_') is '__a'.
+ *
+ * @param {String} input: input value converted to string.
+ * @param {Number} size: desired length of output.
+ * @param {String} ch: single character to prefix to string.
+ *
+ * @returns {String} Modified string, at least SIZE length.
+ */
+function padLeft(input, size, ch) {
+	var s = input + "";
+	while (s.length < size) {
+		s = ch + s;
+	}
+	return s;
+}
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
+		return new ActiveXObject("Msxml2.XMLHTTP");
+	} catch (e) {}
+	try {
+		return new ActiveXObject("Microsoft.XMLHTTP");
+	} catch (e) {}
+
+	//debug("XMLHttpRequest not supported");
+	return null;
+}
+
+/* ============================================================ */
+/* utility/helper functions (and variables) */
+
+var http;       // XMLHttpRequest object
+var projectUrl; // partial query + separator ('?' or ';')
+
+// 'commits' is an associative map. It maps SHA1s to Commit objects.
+var commits = {};
+
+/**
+ * constructor for Commit objects, used in 'blame'
+ * @class Represents a blamed commit
+ * @param {String} sha1: SHA-1 identifier of a commit
+ */
+function Commit(sha1) {
+	if (this instanceof Commit) {
+		this.sha1 = sha1;
+		this.nprevious = 0; /* blame-specific */
+	} else {
+		return new Commit(sha1);
+	}
+}
+
+/* ............................................................ */
+/* progress info, timing, error reporting */
+
+var blamedLines = 0;
+var totalLines  = '???';
+var div_progress_bar;
+var div_progress_info;
+
+/**
+ * Detects how many lines does a blamed file have,
+ * This information is used in progress info
+ *
+ * @returns {Number|String} Number of lines in file, or string '...'
+ */
+function countLines() {
+	var table =
+		document.getElementById('blame_table') ||
+		document.getElementsByTagName('table')[0];
+
+	if (table) {
+		return table.getElementsByTagName('tr').length - 1; // for header
+	} else {
+		return '...';
+	}
+}
+
+/**
+ * update progress info and length (width) of progress bar
+ */
+function updateProgressInfo() {
+	if (!div_progress_info) {
+		div_progress_info = document.getElementById('progress_info');
+	}
+	if (!div_progress_bar) {
+		div_progress_bar = document.getElementById('progress_bar');
+	}
+	if (!div_progress_info && !div_progress_bar) {
+		return;
+	}
+
+	var percentage = Math.floor(100.0*blamedLines/totalLines);
+
+	if (div_progress_info) {
+		div_progress_info.firstChild.data  = blamedLines + ' / ' + totalLines +
+			' (' + spacePad(percentage, 3) + '%)';
+	}
+
+	if (div_progress_bar) {
+		//div_progress_bar.setAttribute('style', 'width: '+percentage+'%;');
+		div_progress_bar.style.width = percentage + '%';
+	}
+}
+
+
+var t_interval_server = '';
+var cmds_server = '';
+var t0 = new Date();
+
+/**
+ * write how much it took to generate data, and to run script
+ */
+function writeTimeInterval() {
+	var info_time = document.getElementById('generate_time');
+	if (!info_time || !t_interval_server) {
+		return;
+	}
+	var t1 = new Date();
+	info_time.firstChild.data += ' + (' +
+		t_interval_server + 's server blame_data / ' +
+		(t1.getTime() - t0.getTime())/1000 + 's client JavaScript)';
+
+	var info_cmds = document.getElementById('generate_cmd');
+	if (!info_time || !cmds_server) {
+		return;
+	}
+	info_cmds.firstChild.data += ' + ' + cmds_server;
+}
+
+/**
+ * show an error message alert to user within page (in prohress info area)
+ * @param {String} str: plain text error message (no HTML)
+ */
+function errorInfo(str) {
+	if (!div_progress_info) {
+		div_progress_info = document.getElementById('progress_info');
+	}
+	if (div_progress_info) {
+		div_progress_info.className = 'error';
+		div_progress_info.firstChild.data = str;
+	}
+}
+
+/* ............................................................ */
+/* coloring rows during blame_data (git blame --incremental) run */
+
+/**
+ * used to extract N from 'colorN', where N is a number,
+ * @constant
+ */
+var colorRe = /\bcolor([0-9]*)\b/;
+
+/**
+ * return N if <tr class="colorN">, otherwise return null
+ * (some browsers require CSS class names to begin with letter)
+ *
+ * @param {HTMLElement} tr: table row element to check
+ * @param {String} tr.className: 'class' attribute of tr element
+ * @returns {Number|null} N if tr.className == 'colorN', otherwise null
+ */
+function getColorNo(tr) {
+	if (!tr) {
+		return null;
+	}
+	var className = tr.className;
+	if (className) {
+		var match = colorRe.exec(className);
+		if (match) {
+			return parseInt(match[1], 10);
+		}
+	}
+	return null;
+}
+
+var colorsFreq = [0, 0, 0];
+/**
+ * return one of given possible colors (curently least used one)
+ * example: chooseColorNoFrom(2, 3) returns 2 or 3
+ *
+ * @param {Number[]} arguments: one or more numbers
+ *        assumes that  1 <= arguments[i] <= colorsFreq.length
+ * @returns {Number} Least used color number from arguments
+ */
+function chooseColorNoFrom() {
+	// choose the color which is least used
+	var colorNo = arguments[0];
+	for (var i = 1; i < arguments.length; i++) {
+		if (colorsFreq[arguments[i]-1] < colorsFreq[colorNo-1]) {
+			colorNo = arguments[i];
+		}
+	}
+	colorsFreq[colorNo-1]++;
+	return colorNo;
+}
+
+/**
+ * given two neigbour <tr> elements, find color which would be different
+ * from color of both of neighbours; used to 3-color blame table
+ *
+ * @param {HTMLElement} tr_prev
+ * @param {HTMLElement} tr_next
+ * @returns {Number} color number N such that
+ * colorN != tr_prev.className && colorN != tr_next.className
+ */
+function findColorNo(tr_prev, tr_next) {
+	var color_prev = getColorNo(tr_prev);
+	var color_next = getColorNo(tr_next);
+
+
+	// neither of neighbours has color set
+	// THEN we can use any of 3 possible colors
+	if (!color_prev && !color_next) {
+		return chooseColorNoFrom(1,2,3);
+	}
+
+	// either both neighbours have the same color,
+	// or only one of neighbours have color set
+	// THEN we can use any color except given
+	var color;
+	if (color_prev === color_next) {
+		color = color_prev; // = color_next;
+	} else if (!color_prev) {
+		color = color_next;
+	} else if (!color_next) {
+		color = color_prev;
+	}
+	if (color) {
+		return chooseColorNoFrom((color % 3) + 1, ((color+1) % 3) + 1);
+	}
+
+	// neighbours have different colors
+	// THEN there is only one color left
+	return (3 - ((color_prev + color_next) % 3));
+}
+
+/* ............................................................ */
+/* coloring rows like 'blame' after 'blame_data' finishes */
+
+/**
+ * returns true if given row element (tr) is first in commit group
+ * to be used only after 'blame_data' finishes (after processing)
+ *
+ * @param {HTMLElement} tr: table row
+ * @returns {Boolean} true if TR is first in commit group
+ */
+function isStartOfGroup(tr) {
+	return tr.firstChild.className === 'sha1';
+}
+
+/**
+ * change colors to use zebra coloring (2 colors) instead of 3 colors
+ * concatenate neighbour commit groups belonging to the same commit
+ */
+function fixColorsAndGroups() {
+	var colorClasses = ['light', 'dark'];
+	var linenum = 1;
+	var tr, prev_group;
+	var colorClass = 0;
+	var table =
+		document.getElementById('blame_table') ||
+		document.getElementsByTagName('table')[0];
+
+	while ((tr = document.getElementById('l'+linenum))) {
+	// index origin is 0, which is table header; start from 1
+	//while ((tr = table.rows[linenum])) { // <- it is slower
+		if (isStartOfGroup(tr, linenum, document)) {
+			if (prev_group &&
+			    prev_group.firstChild.firstChild.href ===
+			            tr.firstChild.firstChild.href) {
+				// we have to concatenate groups
+				var prev_rows = prev_group.firstChild.rowSpan || 1;
+				var curr_rows =         tr.firstChild.rowSpan || 1;
+				prev_group.firstChild.rowSpan = prev_rows + curr_rows;
+				//tr.removeChild(tr.firstChild);
+				tr.deleteCell(0); // DOM2 HTML way
+			} else {
+				colorClass = (colorClass + 1) % 2;
+				prev_group = tr;
+			}
+		}
+		var tr_class = tr.className;
+		tr.className = tr_class.replace(colorRe, colorClasses[colorClass]);
+		linenum++;
+	}
+}
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
+/* ............................................................ */
+/* unquoting/unescaping filenames */
+
+/**
+ * Used to detect escape sequences (octal e.g. \008 and symbolic e.g. \n)
+ * @constant
+ */
+var escCodeRe = /\\([^0-7]|[0-7]{1,3})/g;
+
+/**
+ * unquote maybe git-quoted filename
+ * e.g. 'aa' -> 'aa', '"a\ta"' -> 'a	a'
+ *
+ * @param {String} str: git-quoted string
+ * @returns {String} Unquoted and unescaped string
+ */
+function unquote(str) {
+	function unq(seq) {
+		var es = { // character escape codes, aka escape sequences
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
+		if (seq.search(/^[0-7]{1,3}$/) !== -1) {
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
+	var match = str.match(/^\"(.*)\"$/);
+	if (match) {
+		str = match[1];
+		// perhaps str = eval('"'+str+'"'); would be enough?
+		str = str.replace(escCodeRe,
+			function (substr, p1, offset, s) { return unq(p1); });
+	}
+	return str;
+}
+
+/* ============================================================ */
+/* main part: parsing response */
+
+/**
+ * Function called for each blame entry, as soon as it finishes
+ *
+ * @param {Commit} commit: blamed commit (blame entry)
+ */
+function handleLine(commit) {
+	/* 
+	   This is the structure of the HTML fragment we are working
+	   with:
+
+	   <tr id="l123" class="">
+	     <td class="sha1" title=""><a href=""> </a></td>
+	     <td class="linenr"><a class="linenr" href="">123</a></td>
+	     <td class="pre"># times (my ext3 doesn&#39;t).</td>
+	   </tr>
+	*/
+
+	var resline = commit.resline;
+
+	// format date and time string only once per commit
+	if (!commit.info) {
+		/* e.g. 'Kay Sievers, 2005-08-07 21:49:46 +0200' */
+		commit.info = commit.author + ', ' +
+			formatDateISOLocal(commit.authorTime, commit.authorTimezone);
+	}
+
+	// color depends on group of lines, not only on blamed commit
+	var colorNo = findColorNo(
+		document.getElementById('l'+(resline-1)),
+		document.getElementById('l'+(resline+commit.numlines))
+	);
+
+	// loop over lines in commit group
+	for (var i = 0; i < commit.numlines; i++) {
+		var tr = document.getElementById('l'+resline);
+		if (!tr) {
+			//debug('tr is null! resline: ' + resline);
+			break;
+		}
+		/*
+			<tr id="l123" class="">
+			  <td class="sha1" title=""><a href=""> </a></td>
+			  <td class="linenr"><a class="linenr" href="">123</a></td>
+			  <td class="pre"># times (my ext3 doesn&#39;t).</td>
+			</tr>
+		*/
+		var td_sha1  = tr.firstChild;
+		var a_sha1   = td_sha1.firstChild;
+		var a_linenr = td_sha1.nextSibling.firstChild;
+
+		/* <tr id="l123" class=""> */
+		var tr_class = '';
+		if (colorNo !== null) {
+			tr_class = 'color'+colorNo;
+		}
+		if (commit.boundary) {
+			tr_class += ' boundary';
+		}
+		if (commit.nprevious === 0) {
+			tr_class += ' no-previous';
+		} else if (commit.nprevious > 1) {
+			tr_class += ' multiple-previous';
+		}
+		tr.className = tr_class;
+
+		/* <td class="sha1" title="?" rowspan="?"><a href="?">?</a></td> */
+		if (i === 0) {
+			td_sha1.title = commit.info;
+			td_sha1.rowSpan = commit.numlines;
+
+			a_sha1.href = projectUrl + 'a=commit;h=' + commit.sha1;
+			a_sha1.firstChild.data = commit.sha1.substr(0, 8);
+			if (commit.numlines >= 2) {
+				var fragment = document.createDocumentFragment();
+				var br   = document.createElement("br");
+				var text = document.createTextNode(
+					commit.author.match(/\b([A-Z])\B/g).join(''));
+				if (br && text) {
+					var elem = fragment || td_sha1;
+					elem.appendChild(br);
+					elem.appendChild(text);
+					if (fragment) {
+						td_sha1.appendChild(fragment);
+					}
+				}
+			}
+		} else {
+			//tr.removeChild(td_sha1); // DOM2 Core way
+			tr.deleteCell(0); // DOM2 HTML way
+		}
+
+		/* <td class="linenr"><a class="linenr" href="?">123</a></td> */
+		var linenr_commit =
+			('previous' in commit ? commit.previous : commit.sha1);
+		var linenr_filename =
+			('file_parent' in commit ? commit.file_parent : commit.filename);
+		a_linenr.href = projectUrl + 'a=blame_incremental' +
+			';hb=' + linenr_commit +
+			';f='  + encodeURIComponent(linenr_filename) +
+			'#l' + (commit.srcline + i);
+
+		resline++;
+		blamedLines++;
+
+		//updateProgressInfo();
+	}
+}
+
+// ----------------------------------------------------------------------
+
+var prevDataLength = -1;
+var nextLine = 0;
+var inProgress = false;
+
+/**#@+
+ * @constant
+ */
+var sha1Re = /^([0-9a-f]{40}) ([0-9]+) ([0-9]+) ([0-9]+)/;
+var infoRe = /^([a-z-]+) ?(.*)/;
+var endRe  = /^END ?([^ ]*) ?(.*)/;
+/**@-*/
+
+var curCommit = new Commit();
+var pollTimer = null;
+
+/**
+ * handler for XMLHttpRequest onreadystatechange event
+ * @see startBlame
+ */
+function handleResponse() {
+	//debug('handleResp ready: ' + http.readyState +
+	//      ' respText null?: ' + (http.responseText === null) +
+	//      ' progress: ' + inProgress);
+
+	if (http.readyState !== 4 && http.readyState !== 3) {
+		return;
+	}
+
+	// the server returned error
+	if (http.readyState === 3 && http.status !== 200) {
+		return;
+	}
+	if (http.readyState === 4 && http.status !== 200) {
+		if (!div_progress_info) {
+			div_progress_info = document.getElementById('progress_info');
+		}
+
+		errorInfo('Server error: ' +
+			http.status + ' - ' + (http.statusText || 'Error contacting server'));
+
+		clearInterval(pollTimer);
+		inProgress = false;
+	}
+
+	// In konqueror http.responseText is sometimes null here...
+	if (http.responseText === null) {
+		return;
+	}
+
+	// in case we were called before finished processing
+	if (inProgress) {
+		return;
+	} else {
+		inProgress = true;
+	}
+
+	while (prevDataLength !== http.responseText.length) {
+		if (http.readyState === 4 &&
+		    prevDataLength === http.responseText.length) {
+			break;
+		}
+
+		prevDataLength = http.responseText.length;
+		var response = http.responseText.substring(nextLine);
+		var lines = response.split('\n');
+		nextLine = nextLine + response.lastIndexOf('\n') + 1;
+		if (response[response.length-1] !== '\n') {
+			lines.pop();
+		}
+
+		for (var i = 0; i < lines.length; i++) {
+			var match = sha1Re.exec(lines[i]);
+			if (match) {
+				var sha1 = match[1];
+				var srcline  = parseInt(match[2], 10);
+				var resline  = parseInt(match[3], 10);
+				var numlines = parseInt(match[4], 10);
+				var c = commits[sha1];
+				if (!c) {
+					c = new Commit(sha1);
+					commits[sha1] = c;
+				}
+
+				c.srcline = srcline;
+				c.resline = resline;
+				c.numlines = numlines;
+				curCommit = c;
+
+			} else if ((match = infoRe.exec(lines[i]))) {
+				var info = match[1];
+				var data = match[2];
+				switch (info) {
+				case 'filename':
+					curCommit.filename = unquote(data);
+					// 'filename' information terminates the entry
+					handleLine(curCommit);
+					updateProgressInfo();
+					break;
+				case 'author':
+					curCommit.author = data;
+					break;
+				case 'author-time':
+					curCommit.authorTime = parseInt(data, 10);
+					break;
+				case 'author-tz':
+					curCommit.authorTimezone = data;
+					break;
+				case 'previous':
+					curCommit.nprevious++;
+					if (!'previous' in curCommit) {
+						var parts = data.split(' ', 2);
+						curCommit.previous    = parts[0];
+						curCommit.file_parent = unquote(parts[1]);
+					}
+					break;
+				case 'boundary':
+					//debug('Boundary commit: '+curCommit.sha1);
+					curCommit.boundary = true;
+					break;
+				} // end switch
+
+			} else if ((match = endRe.exec(lines[i]))) {
+				t_interval_server = match[1];
+				cmds_server = match[2];
+				//debug('END: '+lines[i]);
+			} else if (lines[i] !== '') {
+				//debug('malformed line: ' + lines[i]);
+			}
+		}
+	}
+
+	// did we finish work?
+	if (http.readyState === 4 &&
+	    prevDataLength === http.responseText.length) {
+		clearInterval(pollTimer);
+
+		fixColorsAndGroups();
+		writeTimeInterval();
+		commits = {}; // free memory
+	}
+
+	inProgress = false;
+}
+
+// ============================================================
+// ------------------------------------------------------------
+
+/**
+ * Incrementally update line data in blame_incremental view in gitweb.
+ *
+ * @param {String} blamedataUrl: URL to server script generating blame data.
+ * @param {String} bUrl: partial URL to project, used to generate links.
+ *
+ * Called from 'blame_incremental' view after loading table with
+ * file contents, a base for blame view.
+*/
+function startBlame(blamedataUrl, bUrl) {
+	//debug('startBlame('+blamedataUrl+', '+bUrl+')');
+
+	http = createRequestObject();
+	if (!http) {
+		errorInfo('ERROR: XMLHttpRequest not supported');
+		return;
+	}
+
+	t0 = new Date();
+	projectUrl = bUrl + (bUrl.indexOf('?') === -1 ? '?' : ';');
+	if ((div_progress_bar = document.getElementById('progress_bar'))) {
+		div_progress_bar.setAttribute('style', 'width: 100%;');
+		//div_progress_bar.style.value = 'width: 100%;';
+	}
+	totalLines = countLines();
+	updateProgressInfo();
+
+	http.open('get', blamedataUrl);
+	http.setRequestHeader('Accept', 'text/plain'); // in case of future changes
+	// perhaps also 'multipart/x-mixed-replace'
+	http.onreadystatechange = handleResponse;
+	//http.onreadystatechange = function () { handleResponse(http); };
+	http.send(null);
+
+	// not all browsers call onreadystatechange event on each server flush
+	if (!DEBUG) {
+		pollTimer = setInterval(handleResponse, 1000);
+	}
+}
+
+// end of blame.js
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 8f68fe3..c9a7501 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -250,6 +250,11 @@ tr.no-previous td.linenr {
 	font-weight: bold;
 }
 
+/* for 'blame_incremental', during processing */
+tr.color1 { background-color: #f6fff6; }
+tr.color2 { background-color: #f6f6ff; }
+tr.color3 { background-color: #fff6f6; }
+
 td {
 	padding: 2px 5px;
 	font-size: 100%;
@@ -341,6 +346,17 @@ td.mode {
 	font-family: monospace;
 }
 
+/* progress of blame_interactive */
+div#progress_bar {
+	height: 2px;
+	margin-bottom: -2px;
+	background-color: #d8d9d0;
+}
+div#progress_info {
+	float: right;
+	text-align: right;
+}
+
 /* styling of diffs (patchsets): commitdiff and blobdiff views */
 div.diff.header,
 div.diff.extended_header {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c6894e2..b94ce10 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -96,6 +96,8 @@ our $stylesheet = undef;
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
 our $favicon = "++GITWEB_FAVICON++";
+# URI of blame.js
+our $blamejs = "++GITWEB_BLAMEJS++";
 
 # URI and label (title) of GIT logo link
 #our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
@@ -564,6 +566,8 @@ our %cgi_param_mapping = @cgi_param_mapping;
 # we will also need to know the possible actions, for validation
 our %actions = (
 	"blame" => \&git_blame,
+	"blame_incremental" => \&git_blame_incremental,
+	"blame_data" => \&git_blame_data,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -4787,7 +4791,9 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame {
+sub git_blame_common {
+	my $format = shift || 'porcelain';
+
 	# permissions
 	gitweb_check_feature('blame')
 		or die_error(403, "Blame view not allowed");
@@ -4809,10 +4815,43 @@ sub git_blame {
 		}
 	}
 
-	# run git-blame --porcelain
-	open my $fd, "-|", git_cmd(), "blame", '-p',
-		$hash_base, '--', $file_name
-		or die_error(500, "Open git-blame failed");
+	my $fd;
+	if ($format eq 'incremental') {
+		# get file contents (as base)
+		open $fd, "-|", git_cmd(), 'cat-file', 'blob', $hash
+			or die_error(500, "Open git-cat-file failed");
+	} elsif ($format eq 'data') {
+		# run git-blame --incremental
+		open $fd, "-|", git_cmd(), "blame", "--incremental",
+			$hash_base, "--", $file_name
+			or die_error(500, "Open git-blame --incremental failed");
+	} else {
+		# run git-blame --porcelain
+		open $fd, "-|", git_cmd(), "blame", '-p',
+			$hash_base, '--', $file_name
+			or die_error(500, "Open git-blame --porcelain failed");
+	}
+
+	# incremental blame data returns early
+	if ($format eq 'data') {
+		print $cgi->header(
+			-type=>"text/plain", -charset => "utf-8",
+			-status=> "200 OK");
+		local $| = 1; # output autoflush
+		print while <$fd>;
+		close $fd
+			or print "ERROR $!\n";
+
+		print 'END';
+		if (defined $t0 && gitweb_check_feature('timed')) {
+			print ' '.
+			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
+			      ' '.$number_of_git_cmds;
+		}
+		print "\n";
+
+		return;
+	}
 
 	# page header
 	git_header_html();
@@ -4823,109 +4862,169 @@ sub git_blame {
 		$cgi->a({-href => href(action=>"history", -replay=>1)},
 		        "history") .
 		" | " .
-		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
+		$cgi->a({-href => href(action=>$action, file_name=>$file_name)},
 		        "HEAD");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype, $hash_base);
 
 	# page body
+	if ($format eq 'incremental') {
+		print "<noscript>\n<div class=\"error\"><center><b>\n".
+		      "This page requires JavaScript to run.\n Use ".
+		      $cgi->a({-href => href(action=>'blame',-replay=>1)}, 'this page').
+		      " instead.\n".
+		      "</b></center></div>\n</noscript>\n";
+
+		print qq!<div id="progress_bar" style="width: 100%; background-color: yellow"></div>\n!;
+	}
+
+	print qq!<div class="page_body">\n!;
+	print qq!<div id="progress_info">... / ...</div>\n!
+		if ($format eq 'incremental');
+	print qq!<table id="blame_table" class="blame" width="100%">\n!.
+	      #qq!<col width="5.5em" /><col width="2.5em" /><col width="*" />\n!.
+	      qq!<thead>\n!.
+	      qq!<tr><th>Commit</th><th>Line</th><th>Data</th></tr>\n!.
+	      qq!</thead>\n!.
+	      qq!<tbody>\n!;
+
 	my @rev_color = qw(light dark);
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
-	my %metainfo = ();
 
-	print <<HTML;
-<div class="page_body">
-<table class="blame">
-<tr><th>Commit</th><th>Line</th><th>Data</th></tr>
-HTML
- LINE:
-	while (my $line = <$fd>) {
-		chomp $line;
-		# the header: <SHA-1> <src lineno> <dst lineno> [<lines in group>]
-		# no <lines in group> for subsequent lines in group of lines
-		my ($full_rev, $orig_lineno, $lineno, $group_size) =
-		   ($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/);
-		if (!exists $metainfo{$full_rev}) {
-			$metainfo{$full_rev} = { 'nprevious' => 0 };
-		}
-		my $meta = $metainfo{$full_rev};
-		my $data;
-		while ($data = <$fd>) {
-			chomp $data;
-			last if ($data =~ s/^\t//); # contents of line
-			if ($data =~ /^(\S+)(?: (.*))?$/) {
-				$meta->{$1} = $2 unless exists $meta->{$1};
+	if ($format eq 'incremental') {
+		my $color_class = $rev_color[$current_color];
+
+		#contents of a file
+		my $linenr = 0;
+	LINE:
+		while (my $line = <$fd>) {
+			chomp $line;
+			$linenr++;
+
+			print qq!<tr id="l$linenr" class="$color_class">!.
+			      qq!<td class="sha1"><a href=""> </a></td>!.
+			      qq!<td class="linenr">!.
+			      qq!<a class="linenr" href="">$linenr</a></td>!;
+			print qq!<td class="pre">! . esc_html($line) . "</td>\n";
+			print qq!</tr>\n!;
+		}
+
+	} else { # porcelain, i.e. ordinary blame
+		my %metainfo = (); # saves information about commits
+
+		# blame data
+	LINE:
+		while (my $line = <$fd>) {
+			chomp $line;
+			# the header: <SHA-1> <src lineno> <dst lineno> [<lines in group>]
+			# no <lines in group> for subsequent lines in group of lines
+			my ($full_rev, $orig_lineno, $lineno, $group_size) =
+			   ($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/);
+			if (!exists $metainfo{$full_rev}) {
+				$metainfo{$full_rev} = { 'nprevious' => 0 };
 			}
-			if ($data =~ /^previous /) {
-				$meta->{'nprevious'}++;
+			my $meta = $metainfo{$full_rev};
+			my $data;
+			while ($data = <$fd>) {
+				chomp $data;
+				last if ($data =~ s/^\t//); # contents of line
+				if ($data =~ /^(\S+)(?: (.*))?$/) {
+					$meta->{$1} = $2 unless exists $meta->{$1};
+				}
+				if ($data =~ /^previous /) {
+					$meta->{'nprevious'}++;
+				}
 			}
-		}
-		my $short_rev = substr($full_rev, 0, 8);
-		my $author = $meta->{'author'};
-		my %date =
-			parse_date($meta->{'author-time'}, $meta->{'author-tz'});
-		my $date = $date{'iso-tz'};
-		if ($group_size) {
-			$current_color = ($current_color + 1) % $num_colors;
-		}
-		my $tr_class = $rev_color[$current_color];
-		$tr_class .= ' boundary' if (exists $meta->{'boundary'});
-		$tr_class .= ' no-previous' if ($meta->{'nprevious'} == 0);
-		$tr_class .= ' multiple-previous' if ($meta->{'nprevious'} > 1);
-		print "<tr id=\"l$lineno\" class=\"$tr_class\">\n";
-		if ($group_size) {
-			print "<td class=\"sha1\"";
-			print " title=\"". esc_html($author) . ", $date\"";
-			print " rowspan=\"$group_size\"" if ($group_size > 1);
-			print ">";
-			print $cgi->a({-href => href(action=>"commit",
-			                             hash=>$full_rev,
-			                             file_name=>$file_name)},
-			              esc_html($short_rev));
-			if ($group_size >= 2) {
-				my @author_initials = ($author =~ /\b([[:upper:]])\B/g);
-				if (@author_initials) {
-					print "<br />" .
-					      esc_html(join('', @author_initials));
-					#           or join('.', ...)
+			my $short_rev = substr($full_rev, 0, 8);
+			my $author = $meta->{'author'};
+			my %date =
+				parse_date($meta->{'author-time'}, $meta->{'author-tz'});
+			my $date = $date{'iso-tz'};
+			if ($group_size) {
+				$current_color = ($current_color + 1) % $num_colors;
+			}
+			my $tr_class = $rev_color[$current_color];
+			$tr_class .= ' boundary' if (exists $meta->{'boundary'});
+			$tr_class .= ' no-previous' if ($meta->{'nprevious'} == 0);
+			$tr_class .= ' multiple-previous' if ($meta->{'nprevious'} > 1);
+			print "<tr id=\"l$lineno\" class=\"$tr_class\">\n";
+			if ($group_size) {
+				print "<td class=\"sha1\"";
+				print " title=\"". esc_html($author) . ", $date\"";
+				print " rowspan=\"$group_size\"" if ($group_size > 1);
+				print ">";
+				print $cgi->a({-href => href(action=>"commit",
+				                             hash=>$full_rev,
+				                             file_name=>$file_name)},
+				              esc_html($short_rev));
+				if ($group_size >= 2) {
+					my @author_initials = ($author =~ /\b([[:upper:]])\B/g);
+					if (@author_initials) {
+						print "<br />" .
+						      esc_html(join('', @author_initials));
+						#           or join('.', ...)
+					}
 				}
+				print "</td>\n";
 			}
-			print "</td>\n";
-		}
-		# 'previous' <sha1 of parent commit> <filename at commit>
-		if (exists $meta->{'previous'} &&
-		    $meta->{'previous'} =~ /^([a-fA-F0-9]{40}) (.*)$/) {
-			$meta->{'parent'} = $1;
-			$meta->{'file_parent'} = unquote($2);
-		}
-		my $linenr_commit =
-			exists($meta->{'parent'}) ?
-			$meta->{'parent'} : $full_rev;
-		my $linenr_filename =
-			exists($meta->{'file_parent'}) ?
-			$meta->{'file_parent'} : unquote($meta->{'filename'});
-		my $blamed = href(action => 'blame',
-		                  file_name => $linenr_filename,
-		                  hash_base => $linenr_commit);
-		print "<td class=\"linenr\">";
-		print $cgi->a({ -href => "$blamed#l$orig_lineno",
-		                -class => "linenr" },
-		              esc_html($lineno));
-		print "</td>";
-		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
-		print "</tr>\n";
+			# 'previous' <sha1 of parent commit> <filename at commit>
+			if (exists $meta->{'previous'} &&
+			    $meta->{'previous'} =~ /^([a-fA-F0-9]{40}) (.*)$/) {
+				$meta->{'parent'} = $1;
+				$meta->{'file_parent'} = unquote($2);
+			}
+			my $linenr_commit =
+				exists($meta->{'parent'}) ?
+				$meta->{'parent'} : $full_rev;
+			my $linenr_filename =
+				exists($meta->{'file_parent'}) ?
+				$meta->{'file_parent'} : unquote($meta->{'filename'});
+			my $blamed = href(action => 'blame',
+			                  file_name => $linenr_filename,
+			                  hash_base => $linenr_commit);
+			print "<td class=\"linenr\">";
+			print $cgi->a({ -href => "$blamed#l$orig_lineno",
+			                -class => "linenr" },
+			              esc_html($lineno));
+			print "</td>";
+			print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
+			print "</tr>\n";
+		} # end while
+
 	}
-	print "</table>\n";
-	print "</div>";
+
+	# footer
+	print "</tbody>\n".
+	      "</table>\n"; # class="blame"
+	print "</div>\n";   # class="blame_body"
 	close $fd
 		or print "Reading blob failed\n";
 
-	# page footer
+	if ($format eq 'incremental') {
+		print qq!<script type="text/javascript" src="$blamejs"></script>\n!.
+		      qq!<script type="text/javascript">\n!.
+		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
+		      qq!           "!. href() .qq!");\n!.
+		      qq!</script>\n!;
+	}
+
 	git_footer_html();
 }
 
+sub git_blame {
+	git_blame_common();
+}
+
+sub git_blame_incremental {
+	git_blame_common('incremental');
+}
+
+sub git_blame_data {
+	git_blame_common('data');
+}
+
 sub git_tags {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-- 
1.6.3.3
