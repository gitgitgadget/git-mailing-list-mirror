From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2/RFC 09/10] gitweb: Incremental blame (proof of concept)
Date: Sat, 25 Jul 2009 00:44:09 +0200
Message-ID: <1248475450-5668-10-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTaN-0000l5-HE
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbZGXWtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbZGXWtJ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:49:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:52843 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbZGXWtG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:49:06 -0400
Received: by fg-out-1718.google.com with SMTP id e21so528679fga.17
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c01uh3DQa+UjNG14Ll5k9jmX0uN6mF93ei5x4h2VPVA=;
        b=PxFKkX58N73EC9da+zv0oKn643XJzyOVY5miVhNX6K5CnS2pbzMdHbR0cZs9OLSJ7T
         qJiaJPVraoww7qgsuogK3XGCJ+/90k0920RJSoStptyBZUtWEjFJVbvLyMaRBr+uzc4z
         qJP4WoCfywX74wTmBcYPTqEeljcq+3OrzB9ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jkHvLjxLXZ+Am+QG6rf+FDyNz8I3Eqj6VIBupJW0uro3n63Lohb6aNx/m1HUyoD2tZ
         Ck2MIhG7rfsOSn+JXEfrYnwrabCQInOLhDufaIDsj7zy9x1j8C/BXur22A9rGvHeyBFs
         HnBIacmakoUidr3o6wyS9CSywZAgBjR/AetSg=
Received: by 10.86.25.14 with SMTP id 14mr185016fgy.14.1248475743104;
        Fri, 24 Jul 2009 15:49:03 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id e11sm3605344fga.11.2009.07.24.15.48.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:49:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMsGkE005871;
	Sat, 25 Jul 2009 00:54:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMrjYB005865;
	Sat, 25 Jul 2009 00:53:45 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123968>

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
* 'blame_incremental' always uses "rowspan" appribite, even if
  rowspan="1".  This simplifies code, and is not visible to user.

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
4. First, second and third version by me (Jakub Narebski)
   http://thread.gmane.org/gmane.comp.version-control.git/102657/focus=102712
   http://article.gmane.org/gmane.comp.version-control.git/123202

Changes compared to the last version:
* simplified spacePad function in blame.js; add padLeft (unused)
* deal with lack of 'timed' info from server, and with expanded
  information including number of git commands used
* a few style fixes (like declaring previously un-declared variables). 
* fixed escape code sequences; they are different for JavaScript than
  for Perl (and for C).
* refactor communicating error message to user into errorInfo(str)
* use /regex/ instead of new RegExp("regex")
* use DOM2 HTML (faster) in place of DOM2 Core when possible,
  e.g. elem.className instead of elem.getAttribute('class') 
* use === instead of == and !== instead of !=
* first column cells doesn't need now (at least in theory) 'rowspan'
  attribute to be present (set)
* instead of creating list of classes in fixColorsAndGroups(), replace
  colorN by light/dark in class name(s).
* add unquote() to deal with quoted filenames (e.g. with TAB character
  encoded as C escape sequence "\t")
* set and deal with "no-previous" and "multiple-previous" classes;
  this was somewhat-ported from 'blame' view in gitweb.perl

TODO list:
* Using 'application/xhtml+xml' Content-Type, together with 
  XHTML 1.0 Strict doctype turns on strict validation (and not
  continuing on errors, if possible) in some web browsers.
  Unfortunately the web browser I use (Mozilla 1.17.2) turns on
  strict mode also for _JavaScript_, which means no innerHTML.
  
  In current patch gitweb is modified to always return 'text/html'.
  Better solution would be to return 'text/html' only for
  'blame_incremental' view, or replace innerHTML by DOM2 manipulations
  (which are unfortunately usually slower).

* handleResponse is used both as onreadystatechange and pollTimer;
  if onreadystatechange works for partial responses we can turn off
  the timer.  It is protected from concurrent running by global
  inProgress variable; we could instead pass XMLHttpResponse object
  as a parameter (see comment in startBlame).
* Probably 'blame_data' should use multipart/x-mixed-replace as
  content type, instead of (in addition to?) text/plain.  I am not
  sure about that; I am not knowledgeable in AJAX and Comet.
* Remove or move to separate commit changes which help CPerl
  mode for GNU Emacs to deal with syntax highlighting (#', #").
  Best via simplifying complex regexp, as in "Perl best Practices".
* Remove (fade out) progress bar and progress info after blame
  incremental finished run (left for a separate commit).
* Instead of running startBlame, put it in window.onload handler

 Makefile           |    6 +-
 git-instaweb.sh    |    7 +
 gitweb/blame.js    |  632 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |   19 ++
 gitweb/gitweb.perl |  287 ++++++++++++++++--------
 5 files changed, 856 insertions(+), 95 deletions(-)
 create mode 100644 gitweb/blame.js

diff --git a/Makefile b/Makefile
index bde27ed..95b577c 100644
--- a/Makefile
+++ b/Makefile
@@ -265,6 +265,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_BLAMEJS = blame.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -1406,13 +1407,14 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
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
@@ -1421,6 +1423,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_BLAMEJS@@/r gitweb/blame.js' \
+	    -e '/@@GITWEB_BLAMEJS@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 5f4419b..fd6341a 100755
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
index 0000000..5a8a29f
--- /dev/null
+++ b/gitweb/blame.js
@@ -0,0 +1,632 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
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
+// convert month or day of the month to string, padding it with
+// '0' (zero) to two characters width if necessary, e.g. 2 -> '02'
+function zeroPad(n) {
+	if (n < 10) {
+		return '0' + n;
+	} else {
+		return n.toString();
+	}
+}
+
+// pad number N with nonbreakable spaces on the left, to WIDTH characters
+// example: spacePad(12, 3) == '&nbsp;12' ('&nbsp;' is nonbreakable space)
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
+ * @param {string} input: input value converted to string.
+ * @param {number} size: desired length of output.
+ * @param {string} ch: single character to prefix to s.
+ */
+function padLeft(input, size, ch) {
+	var s = input + "";
+	while (s.length < size) {
+		s = ch + s;
+	}
+	return s;
+}
+
+// create XMLHttpRequest object in cross-browser way
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
+	debug("XMLHttpRequest not supported");
+	return null;
+}
+
+/* ============================================================ */
+/* utility/helper functions (and variables) */
+
+var http;       // XMLHttpRequest object
+var projectUrl; // partial query
+
+// 'commits' is an associative map. It maps SHA1s to Commit objects.
+var commits = {};
+
+// constructor for Commit objects, used in 'blame'
+function Commit(sha1) {
+	this.sha1 = sha1;
+	this.nprevious = 0; /* blame-specific */
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
+// how many lines does a file have, used in progress info
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
+// update progress info and length (width) of progress bar
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
+		//div_progress_info.firstChild.data = ... /* text node */ ???
+		div_progress_info.innerHTML  = blamedLines + ' / ' + totalLines +
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
+// write how much it took to generate data, and to run script
+function writeTimeInterval() {
+	var info_time = document.getElementById('generate_time');
+	if (!info_time || !t_interval_server) {
+		return;
+	}
+	var t1 = new Date();
+	//info_time.firstChild.data = ... /* text node */ ???
+	info_time.innerHTML += ' + (' +
+		t_interval_server + 's server blame_data / ' +
+		(t1.getTime() - t0.getTime())/1000 + 's client JavaScript)';
+
+	var info_cmds = document.getElementById('generate_cmd');
+	if (!info_time || !cmds_server) {
+		return;
+	}
+	info_cmds.innerHTML += ' + ' + cmds_server;
+}
+
+// show an error message alert to user within page
+function errorInfo(str) {
+	if (!div_progress_info) {
+		div_progress_info = document.getElementById('progress_info');
+	}
+	if (div_progress_info) {
+		div_progress_info.className = 'error';
+		div_progress_info.innerHTML = str; /* can contain HTML */
+	}
+}
+
+/* ............................................................ */
+/* coloring rows during blame_data (git blame --incremental) run */
+
+// used to extract N from colorN, where N is a number,
+var colorRe = /\bcolor([0-9]*)\b/;
+
+// return N if <tr class="colorN">, otherwise return null
+// (some browsers require CSS class names to begin with letter)
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
+// return one of given possible colors (curently least used one)
+// example: chooseColorNoFrom(2, 3) returns 2 or 3
+var colorsFreq = [0, 0, 0];
+// assumes that  1 <= arguments[i] <= colorsFreq.length
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
+// given two neigbour <tr> elements, find color which would be different
+// from color of both of neighbours; used to 3-color blame table
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
+// returns true if given row element (tr) is first in commit group
+function isStartOfGroup(tr) {
+	return tr.firstChild.className === 'sha1';
+}
+
+// change colors to use zebra coloring (2 colors) instead of 3 colors
+// concatenate neighbour commit groups belonging to the same commit
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
+	// index origin is 0, which is table header
+	//while ((tr = table.rows[linenum])) {
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
+// used to extract hours and minutes from timezone info, e.g '-0900'
+var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
+
+// return date in local time formatted in iso-8601 like format
+// 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
+function formatDateISOLocal(epoch, timezoneInfo) {
+	var match = tzRe.exec(timezoneInfo);
+	// date corrected by timezone
+	var localDate = new Date(1000 * (epoch +
+		(parseInt(match[1],10)*3600 + parseInt(match[2],10)*60)));
+	var localDateStr = // e.g. '2005-08-07'
+		localDate.getUTCFullYear()         + '-' +
+		zeroPad(localDate.getUTCMonth()+1) + '-' +
+		zeroPad(localDate.getUTCDate());
+	var localTimeStr = // e.g. '21:49:46'
+		zeroPad(localDate.getUTCHours())   + ':' +
+		zeroPad(localDate.getUTCMinutes()) + ':' +
+		zeroPad(localDate.getUTCSeconds());
+
+	return localDateStr + ' ' + localTimeStr + ' ' + timezoneInfo;
+}
+
+/* ............................................................ */
+/* unquoting/unescaping filenames */
+
+var escCodeRe = /\\([^0-7]|[0-7]{1,3})/g;
+
+// unquote maybe git-quoted filename
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
+// called for each blame entry, as soon as it finishes
+function handleLine(commit) {
+	/* 
+	   This is the structure of the HTML fragment we are working
+	   with:
+
+	   <tr id="l123" class="">
+	     <td class="sha1" title=""><a href=""></a></td>
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
+			debug('tr is null! resline: ' + resline);
+			break;
+		}
+		/*
+			<tr id="l123" class="">
+			  <td class="sha1" title=""><a href=""></a></td>
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
+			a_sha1.href = projectUrl + ';a=commit;h=' + commit.sha1;
+			//a_sha1.firstChild.data = ... /* text node */ ???
+			a_sha1.innerHTML = commit.sha1.substr(0, 8);
+			if (commit.numlines >= 2) {
+				var br   = document.createElement("br");
+				var text = document.createTextNode(
+					commit.author.match(/\b([A-Z])\B/g).join(''));
+				if (br && text) {
+					td_sha1.appendChild(br);
+					td_sha1.appendChild(text);
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
+		a_linenr.href = projectUrl + ';a=blame_incremental' +
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
+var sha1Re = /^([0-9a-f]{40}) ([0-9]+) ([0-9]+) ([0-9]+)/;
+var infoRe = /^([a-z-]+) ?(.*)/;
+var endRe  = /^END ?([^ ]*) ?(.*)/;
+var curCommit = new Commit();
+
+var pollTimer = null;
+
+// handler for XMLHttpRequest onreadystatechange events
+function handleResponse() {
+	debug('handleResp ready: ' + http.readyState +
+	      ' respText null?: ' + (http.responseText === null) +
+	      ' progress: ' + inProgress);
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
+					debug('Boundary commit: '+curCommit.sha1);
+					curCommit.boundary = true;
+					break;
+				} // end switch
+
+			} else if ((match = endRe.exec(lines[i]))) {
+				t_interval_server = match[1];
+				cmds_server = match[2];
+				debug('END: '+lines[i]);
+			} else if (lines[i] !== '') {
+				debug('malformed line: ' + lines[i]);
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
+/*
+	Function: startBlame
+
+	Incrementally update line data in blame_incremental view in gitweb.
+
+	Parameters:
+
+		blamedataUrl - URL to server script generating blame data.
+		bUrl -partial URL to project, used to generate links in blame.
+
+	Comments:
+
+	Called from 'blame_incremental' view after loading table with
+	file contents, a base for blame view.
+*/
+function startBlame(blamedataUrl, bUrl) {
+	debug('startBlame('+blamedataUrl+', '+bUrl+')');
+
+	http = createRequestObject();
+	if (!http) {
+		errorInfo('<b>ERROR:</b> XMLHttpRequest not supported');
+		return;
+	}
+
+	t0 = new Date();
+	projectUrl = bUrl;
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
index 8f68fe3..8b05604 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -250,6 +250,14 @@ tr.no-previous td.linenr {
 	font-weight: bold;
 }
 
+tr.color1:hover { background-color: #e6ede6; }
+tr.color2:hover { background-color: #e6e6ed; }
+tr.color3:hover { background-color: #ede6e6; }
+
+tr.color1 { background-color: #f6fff6; }
+tr.color2 { background-color: #f6f6ff; }
+tr.color3 { background-color: #fff6f6; }
+
 td {
 	padding: 2px 5px;
 	font-size: 100%;
@@ -341,6 +349,17 @@ td.mode {
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
index bd77b31..036f8da 100755
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
@@ -1721,7 +1725,7 @@ sub format_diff_from_to_header {
 	# no extra formatting for "^--- /dev/null"
 	if (! $diffinfo->{'nparents'}) {
 		# ordinary (single parent) diff
-		if ($line =~ m!^--- "?a/!) {
+		if ($line =~ m!^--- "?a/!) {#"
 			if ($from->{'href'}) {
 				$line = '--- a/' .
 				        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
@@ -3048,13 +3052,13 @@ sub git_header_html {
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
 	# we have to do this because MSIE sometimes globs '*/*', pretending to
 	# support xhtml+xml but choking when it gets what it asked for.
-	if (defined $cgi->http('HTTP_ACCEPT') &&
-	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
-	    $cgi->Accept('application/xhtml+xml') != 0) {
-		$content_type = 'application/xhtml+xml';
-	} else {
+	#if (defined $cgi->http('HTTP_ACCEPT') &&
+	#    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
+	#    $cgi->Accept('application/xhtml+xml') != 0) {
+	#	$content_type = 'application/xhtml+xml';
+	#} else {
 		$content_type = 'text/html';
-	}
+	#}
 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
 	                   -status=> $status, -expires => $expires);
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
@@ -4024,7 +4028,7 @@ sub git_patchset_body {
 	while ($patch_line) {
 
 		# parse "git diff" header line
-		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {
+		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {#"
 			# $1 is from_name, which we do not use
 			$to_name = unquote($2);
 			$to_name =~ s!^b/!!;
@@ -4788,7 +4792,9 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame {
+sub git_blame_common {
+	my $format = shift || 'porcelain';
+
 	# permissions
 	gitweb_check_feature('blame')
 		or die_error(403, "Blame view not allowed");
@@ -4810,10 +4816,43 @@ sub git_blame {
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
@@ -4824,109 +4863,169 @@ sub git_blame {
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
+		      "This page requires JavaScript to run\nUse ".
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
+			      qq!<td class="sha1"><a href=""></a></td>!.
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
+		      qq!           "!. href(-partial_query=>1) .qq!");\n!.
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
