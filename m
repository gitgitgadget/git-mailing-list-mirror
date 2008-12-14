From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH v2] gitweb: Incremental blame (proof of concept)
Date: Sun, 14 Dec 2008 01:17:30 +0100
Message-ID: <1229213850-12787-1-git-send-email-jnareb@gmail.com>
References: <20081210200908.16899.36727.stgit@localhost.localdomain>
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 01:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBehR-00050C-LA
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 01:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYLNARn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 19:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbYLNARn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 19:17:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:27181 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYLNARl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 19:17:41 -0500
Received: by ug-out-1314.google.com with SMTP id 39so74814ugf.37
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 16:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qxw6uRuJZVtAuubpYi2YYNel7/lcMqlUIg/SXvAHfY8=;
        b=tx8BcZXGi0M/WCcf7QbdI+f2a1Zk9jx/OiD+oJLoRPYQiiX2NvtvvW3G8u+WSild7L
         JOfemyxrHb5o/opTynPMHgs3PEaChP4GuRu3Ev9JdS4heumJ5hA7iCQUQKxjTXV7X1Mo
         NVHoT/Fg3UKu4qkI3fxB+ro/U3j/Xjk0HkkjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=t1yvIuEV8TmI61fVYID1es1kJZcaWqPkz6dklqvplOG0yWk5TAx9ufbTqwceG0asLh
         OTYFxPfaFzR3D5+MXMBNdFq4s0SyMYDo3dAbbReILxyKEgJCypYlEVaAecQIjnqEPhCn
         HJAPmHb+5GjvFGKrezIMy9PJ0QxTbMBhq3vhg=
Received: by 10.67.87.11 with SMTP id p11mr855088ugl.32.1229213857786;
        Sat, 13 Dec 2008 16:17:37 -0800 (PST)
Received: from localhost.localdomain (abvz56.neoplus.adsl.tpnet.pl [83.8.223.56])
        by mx.google.com with ESMTPS id 32sm392302ugf.37.2008.12.13.16.17.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 16:17:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBE0HXuK012810;
	Sun, 14 Dec 2008 01:17:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBE0HVr3012809;
	Sun, 14 Dec 2008 01:17:31 +0100
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <20081210200908.16899.36727.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103036>

This is tweaked up version of Petr Baudis <pasky@suse.cz> patch, which
in turn was tweaked up version of Fredrik Kuivinen <frekui@gmail.com>'s
proof of concept patch.  It adds 'blame_incremental' view, which
incrementally displays line data in blame view using JavaScript (AJAX).

The original patch by Fredrik Kuivinen has been lightly tested in a
couple of browsers (Firefox, Mozilla, Konqueror, Galeon, Opera and IE6).
The next patch by Petr Baudis has been tested in Firefox and Epiphany.
This patch has been lightly tested in Mozilla 1.17.2 and Konqueror
3.5.3.

This patch does not (contrary to the one by Petr Baudis) enable this
view in gitweb: there are no links leading to 'blame_incremental'
action.  You would have to generate URL 'by hand' (e.g. changing 'blame'
or 'blob' in gitweb URL to 'blame_incremental').  Having links in gitweb
lead to this new action (e.g. by rewriting them like in previous patch),
if JavaScript is enabled in browser, is left for later.

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

This code uses http://ajaxpatterns.org/HTTP_Streaming pattern.

It deals with streamed 'blame_data' server error by notifying about them
in the progress info area (just in case).

This patch adds GITWEB_BLAMEJS compile configuration option, and
modifies git-instaweb.sh to take blame.js into account, but it does not
update gitweb/README file (as it is only proof of concept patch).  The
code for git-instaweb.sh was taken from Pasky's patch.

While at it, this patch uniquifies td.dark and td.dark2 style: they
differ only in that td.dark2 doesn't have style for :hover.


This patch also adds showing time (in seconds) it took to generate
a page in page footer (based on example code by Pasky), even though
it is independent change, to be able to evaluate incremental blame in
gitweb better.  In proper patch series it would be independent commit;
and it probably would provide fallback if Time::HiRes is not available
(by e.g. not showing generating time info), even though this is
unlikely.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from previous version of patch:
 * Fixed copying git-instaweb related changes from Petr Baudis patch;
   git-instaweb should not work with 'blame_incremental' view
 * Fixed links in blame table in 'blame_incremental' view, and add
   support for href(..., -partial_query=>1)
 * The title attribute for "Commit" column ("sha1" cells) agrees with
   the one used for 'blame' view, meaning using localtime e.g. 
     'Kay Sievers, 2005-08-07 21:49:46 +0200'
   There was a bug in Pasky and Frederik patch here...
 * Incremental blame data generation can lead to neighbour groups
   blaming the same commit; such groups are now concatenated when
   fixing colors to zebra pattern. This mean that 'blame_incremental'
   output should match 'blame' view.
 * New feature adding author initials below shortened sha1 of commit
   was dropped; it was not present in 'blame' view, and it would make
   fixing of line grouping mentioned in previous point much more
   difficult.

 * Use more robust createRequestObject(), using try ... catch,
   taken from AJAX article at WikiPedia.
 * Better error handling: show big warning with link to 'blame'
   view if scripts are disabled, show error if XMLHttpRequest object
   cannot be started, show statusText on server returning status != 200
 * use deleteCell (DOM HTML) rather than removeChild (DOM Core)
   to delete cell(s) below cell spanning multiple rows
 * Set 'commits' to empty associative array to mark memory to be freed
 * A few improvements to findColorNo and its helper functions
 * Remember about Internet Explorer quirk when setting class attr
 * Added many comments, changed names of few variables to be more
   readable, rename few functions, split off functions, etc.
 * A bit of style cleanup: always use block with if, in continued
   (broken) lines put operator at the end of line, use literal object
   notation "{}" to initialize empty associative array rather than
   cryptic "new Object()", use === and !=== instead of == and !=,
   always use radix parameter to parseInt (i.e. parseInt(str, 10))  
   All those changes were recommended by JSLint.

 Makefile           |    6 +-
 git-instaweb.sh    |    7 +
 gitweb/blame.js    |  470 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |   27 +++-
 gitweb/gitweb.perl |  263 ++++++++++++++++++++---------
 5 files changed, 683 insertions(+), 90 deletions(-)
 create mode 100644 gitweb/blame.js

diff --git a/Makefile b/Makefile
index 5158197..d2d3fff 100644
--- a/Makefile
+++ b/Makefile
@@ -218,6 +218,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_BLAMEJS = blame.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -1209,13 +1210,14 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
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
@@ -1224,6 +1226,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_BLAMEJS@@/r gitweb/blame.js' \
+	    -e '/@@GITWEB_BLAMEJS@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 0843372..510789f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -268,8 +268,15 @@ gitweb_css () {
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
index 0000000..6288bd1
--- /dev/null
+++ b/gitweb/blame.js
@@ -0,0 +1,470 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+
+var DEBUG = 0;
+function debug(str) {
+	if (DEBUG) {
+		alert(str);
+	}
+}
+
+function createRequestObject() {
+	try {
+		return new XMLHttpRequest();
+	} catch(e) {}
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
+var http; // XMLHttpRequest object
+var projectUrl; // partial query
+
+// 'commits' is an associative map. It maps SHA1s to Commit objects.
+var commits = {};
+
+function Commit(sha1) {
+	this.sha1 = sha1;
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
+// pad number N with nonbreakable spaces on the right, to WIDTH characters
+// example: spacePad(12, 3) == '&nbsp;12' ('&nbsp;' is nonbreakable space)
+function spacePad(n,width) {
+	var scale = 1;
+	var str = '';
+
+	while (width > 1) {
+		scale *= 10;
+		if (n < scale) {
+			str += '&nbsp;';
+		}
+		width--;
+	}
+	return str + n;
+}
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
+		div_progress_info.innerHTML  = blamedLines + ' / ' + totalLines +
+			' ('+spacePad(percentage,3)+'%)';
+	}
+
+	if (div_progress_bar) {
+		div_progress_bar.setAttribute('style', 'width: '+percentage+'%;');
+	}
+}
+
+// used to extract N from colorN, where N is a number,
+var colorRe = new RegExp('color([0-9]*)');
+
+// return N if <tr class="colorN">, otherwise return null
+// (some browsers require CSS class names to begin with letter)
+function getColorNo(tr) {
+	if (!tr) {
+		return null;
+	}
+	var className = tr.getAttribute('class');
+	if (className) {
+		match = colorRe.exec(className);
+		if (match) {
+			return parseInt(match[1],10);
+		}
+	}
+	return null;
+}
+
+// return one of given possible colors
+// example: chooseColorNoFrom(2, 3) might be 2 or 3
+function chooseColorNoFrom() {
+	// simplest version
+	return arguments[0];
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
+	if (!color_prev && !color_next) {
+		return chooseColorNoFrom(1,2,3);
+	}
+
+	// either both neighbours have the same color,
+	// or only one of neighbours have color set
+	var color;
+	if (color_prev == color_next) {
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
+	return (3 - ((color_prev + color_next) % 3));
+}
+
+// used to extract hours and minutes from timezone info, e.g '-0900'
+var tzRe = new RegExp('^([+-][0-9][0-9])([0-9][0-9])$');
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
+		var localDate = new Date(); // date corrected by timezone
+		var match = tzRe.exec(commit.authorTimezone);
+		localDate.setTime(1000 * (commit.authorTime +
+			(parseInt(match[1],10)*3600 + parseInt(match[2],10)*60)));
+		var localDateStr = // e.g. '2005-08-07'
+			localDate.getUTCFullYear()         + '-' +
+			zeroPad(localDate.getUTCMonth()+1) + '-' +
+			zeroPad(localDate.getUTCDate());
+		var localTimeStr = // e.g. '21:49:46'
+			zeroPad(localDate.getUTCHours())   + ':' +
+			zeroPad(localDate.getUTCMinutes()) + ':' +
+			zeroPad(localDate.getUTCSeconds());
+
+		/* e.g. 'Kay Sievers, 2005-08-07 21:49:46 +0200' */
+		commit.info = commit.author + ', ' + localDateStr + ' ' +
+			localTimeStr + ' ' + commit.authorTimezone;
+	}
+
+	// color depends on group of lines, not only on blamed commit
+	var colorNo = findColorNo(
+		document.getElementById('l'+(resline-1)),
+		document.getElementById('l'+(resline+commit.numlines))
+	);
+
+
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
+		if (colorNo !== null) {
+			tr.setAttribute('class', 'color'+colorNo);
+			// Internet Explorer needs this
+			tr.setAttribute('className', 'color'+colorNo);
+		}
+		/* <td class="sha1" title="?" rowspan="?"><a href="?">?</a></td> */
+		if (i === 0) {
+			td_sha1.title = commit.info;
+			td_sha1.setAttribute('rowspan', commit.numlines);
+
+			a_sha1.href = projectUrl + ';a=commit;h=' + commit.sha1;
+			a_sha1.innerHTML = commit.sha1.substr(0, 8);
+
+		} else {
+			//tr.removeChild(td_sha1); // DOM2 Core way
+			tr.deleteCell(0); // DOM2 HTML way
+		}
+
+		/* <td class="linenr"><a class="linenr" href="?">123</a></td> */
+		a_linenr.href = projectUrl + ';a=blame;hb=' + commit.sha1 +
+			';f=' + commit.filename + '#l' + (commit.srcline + i);
+
+		resline++;
+		blamedLines++;
+
+		//updateProgressInfo();
+	}
+}
+
+function startOfGroup(tr) {
+	return tr.firstChild.getAttribute('class') == 'sha1';
+}
+
+function fixColorsAndGroups() {
+	var colorClasses = ['light2', 'dark2'];
+	var linenum = 1;
+	var tr, prev_group;
+	var colorClass = 0;
+
+	while ((tr = document.getElementById('l'+linenum))) {
+		if (startOfGroup(tr, linenum, document)) {
+			if (prev_group &&
+			    prev_group.firstChild.firstChild.href ==
+			            tr.firstChild.firstChild.href) {
+				// we have to concatenate groups
+				var rows = prev_group.firstChild.getAttribute('rowspan');
+				// assume that we have rowspan even for rowspan="1"
+				prev_group.firstChild.setAttribute('rowspan',
+					(rows + tr.firstChild.getAttribute('rowspan')));
+				tr.removeChild(tr.firstChild);
+			} else {
+				colorClass = (colorClass + 1) % 2;
+				prev_group = tr;
+			}
+		}
+		tr.setAttribute('class', colorClasses[colorClass]);
+		// Internet Explorer needs this
+		tr.setAttribute('className', colorClasses[colorClass]);
+		linenum++;
+	}
+}
+
+var t_interval_server = '';
+var t0 = new Date();
+
+// write how much it took to generate data, and to run script
+function writeTimeInterval() {
+	var info = document.getElementById('generate_time');
+	if (!info) {
+		return;
+	}
+	var t1 = new Date();
+
+	info.innerHTML += ' + ' +
+		t_interval_server+'s server (blame_data) / ' +
+		(t1.getTime() - t0.getTime())/1000 + 's client (JavaScript)';
+}
+
+// ----------------------------------------------------------------------
+
+var prevDataLength = -1;
+var nextLine = 0;
+var inProgress = false;
+
+var sha1Re = new RegExp('([0-9a-f]{40}) ([0-9]+) ([0-9]+) ([0-9]+)');
+var infoRe = new RegExp('([a-z-]+) ?(.*)');
+var endRe = new RegExp('END ?(.*)');
+var curCommit = new Commit();
+
+var pollTimer = null;
+
+function handleResponse() {
+	debug('handleResp ready: ' + http.readyState +
+	      ' respText null?: ' + (http.responseText === null) +
+	      ' progress: ' + inProgress);
+
+	if (http.readyState != 4 && http.readyState != 3) {
+		return;
+	}
+
+	// the server returned error
+	if (http.readyState == 3 && http.status != 200) {
+		return;
+	}
+	if (http.readyState == 4 && http.status != 200) {
+		if (!div_progress_info) {
+			div_progress_info = document.getElementById('progress_info');
+		}
+
+		if (div_progress_info) {
+			div_progress_info.setAttribute('class', 'error');
+			// Internet Explorer needs this
+			div_progress_info.setAttribute('className', 'error');
+			div_progress_info.innerHTML = 'Server error: ' +
+				http.status+' - '+(http.statusText || 'Error contacting server');
+		}
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
+	while (prevDataLength != http.responseText.length) {
+		if (http.readyState == 4 &&
+		    prevDataLength == http.responseText.length) {
+			break;
+		}
+
+		prevDataLength = http.responseText.length;
+		var response = http.responseText.substring(nextLine);
+		var lines = response.split('\n');
+		nextLine = nextLine + response.lastIndexOf('\n') + 1;
+		if (response[response.length-1] != '\n') {
+			lines.pop();
+		}
+
+		for (var i = 0; i < lines.length; i++) {
+			var match = sha1Re.exec(lines[i]);
+			if (match) {
+				var sha1 = match[1];
+				var srcline = parseInt(match[2],10);
+				var resline = parseInt(match[3],10);
+				var numlines = parseInt(match[4],10);
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
+			} else if ((match = infoRe.exec(lines[i]))) {
+				var info = match[1];
+				var data = match[2];
+				if (info == 'filename') {
+					curCommit.filename = data;
+					handleLine(curCommit);
+					updateProgressInfo();
+				} else if (info == 'author') {
+					curCommit.author = data;
+				} else if (info == 'author-time') {
+					curCommit.authorTime = parseInt(data,10);
+				} else if (info == 'author-tz') {
+					curCommit.authorTimezone = data;
+				}
+			} else if ((match = endRe.exec(lines[i]))) {
+				t_interval_server = match[1];
+				debug('END: '+lines[i]);
+			} else if (lines[i] !== '') {
+				debug('malformed line: ' + lines[i]);
+			}
+		}
+	}
+
+	// did we finish work?
+	if (http.readyState == 4 &&
+	    prevDataLength == http.responseText.length) {
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
+		div_progress_info = document.getElementById('progress_info');
+
+		if (div_progress_info) {
+			div_progress_info.setAttribute('class', 'error');
+			// Internet Explorer needs this
+			div_progress_info.setAttribute('className', 'error');
+			div_progress_info.innerHTML = 'XMLHttpRequest not supported';
+		}
+
+		return;
+	}
+
+	t0 = new Date();
+	projectUrl = bUrl;
+	totalLines = countLines();
+	updateProgressInfo();
+
+	http.open('get', blamedataUrl);
+	http.onreadystatechange = handleResponse;
+	http.send(null);
+
+	// not all browsers call onreadystatechange event on each server flush
+	pollTimer = setInterval(handleResponse, 2000);
+}
+
+// end of blame.js
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index a01eac8..e359618 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -223,11 +223,7 @@ tr.light:hover {
 	background-color: #edece6;
 }
 
-tr.dark {
-	background-color: #f6f6f0;
-}
-
-tr.dark2 {
+tr.dark, tr.dark2 {
 	background-color: #f6f6f0;
 }
 
@@ -235,6 +231,14 @@ tr.dark:hover {
 	background-color: #edece6;
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
@@ -255,7 +259,7 @@ td.sha1 {
 	font-family: monospace;
 }
 
-td.error {
+.error {
 	color: red;
 	background-color: yellow;
 }
@@ -326,6 +330,17 @@ td.mode {
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
index 4987fdc..93a4e82 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,6 +18,9 @@ use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
+use Time::HiRes qw(gettimeofday tv_interval);
+our $t0 = [gettimeofday];
+
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
 }
@@ -74,6 +77,8 @@ our $stylesheet = undef;
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
 our $favicon = "++GITWEB_FAVICON++";
+# URI of blame.js
+our $blamejs = "++GITWEB_BLAMEJS++";
 
 # URI and label (title) of GIT logo link
 #our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
@@ -493,6 +498,8 @@ our %cgi_param_mapping = @cgi_param_mapping;
 # we will also need to know the possible actions, for validation
 our %actions = (
 	"blame" => \&git_blame,
+	"blame_incremental" => \&git_blame_incremental,
+	"blame_data" => \&git_blame_data,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -919,7 +926,8 @@ sub href (%) {
 			}
 		}
 	}
-	$href .= "?" . join(';', @result) if scalar @result;
+	$href .= "?" . join(';', @result)
+		if ($params{-partial_query} or scalar @result);
 
 	return $href;
 }
@@ -1272,7 +1280,7 @@ use constant {
 };
 
 # submodule/subproject, a commit object reference
-sub S_ISGITLINK($) {
+sub S_ISGITLINK {
 	my $mode = shift;
 
 	return (($mode & S_IFMT) == S_IFGITLINK)
@@ -1558,7 +1566,7 @@ sub format_diff_from_to_header {
 	# no extra formatting for "^--- /dev/null"
 	if (! $diffinfo->{'nparents'}) {
 		# ordinary (single parent) diff
-		if ($line =~ m!^--- "?a/!) {
+		if ($line =~ m!^--- "?a/!) {#"
 			if ($from->{'href'}) {
 				$line = '--- a/' .
 				        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
@@ -1816,7 +1824,7 @@ sub git_cmd {
 # Try to avoid using this function wherever possible.
 sub quote_command {
 	return join(' ',
-		    map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
+		    map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));#'
 }
 
 # get HEAD ref of given project as hash
@@ -2874,13 +2882,13 @@ sub git_header_html {
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
@@ -3042,6 +3050,14 @@ sub git_footer_html {
 	}
 	print "</div>\n"; # class="page_footer"
 
+	print "<div class=\"page_footer\">\n";
+	print 'This page took '.
+	      '<span id="generate_time" class="time_span">'.
+	      tv_interval($t0, [gettimeofday]).'s'.
+	      '</span>'.
+	      " to generate.\n";
+	print "</div>\n"; # class="page_footer"
+
 	if (-f $site_footer) {
 		insert_file($site_footer);
 	}
@@ -3803,7 +3819,7 @@ sub git_patchset_body {
 	while ($patch_line) {
 
 		# parse "git diff" header line
-		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {
+		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {#"
 			# $1 is from_name, which we do not use
 			$to_name = unquote($2);
 			$to_name =~ s!^b/!!;
@@ -4574,7 +4590,9 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame {
+sub git_blame_common {
+	my $format = shift || 'porcelain';
+
 	# permissions
 	gitweb_check_feature('blame')
 		or die_error(403, "Blame view not allowed");
@@ -4596,10 +4614,36 @@ sub git_blame {
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
+		print "END ".tv_interval($t0, [gettimeofday])."\n";
+
+		return;
+	}
 
 	# page header
 	git_header_html();
@@ -4610,93 +4654,146 @@ sub git_blame {
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
 	my @rev_color = qw(light2 dark2);
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
-			$metainfo{$full_rev} = {};
-		}
-		my $meta = $metainfo{$full_rev};
-		my $data; # last line is used later
-		while ($data = <$fd>) {
-			chomp $data;
-			last if ($data =~ s/^\t//); # contents of line
-			if ($data =~ /^(\S+) (.*)$/) {
-				$meta->{$1} = $2;
-			}
-		}
-		my $short_rev = substr($full_rev, 0, 8);
-		my $author = $meta->{'author'};
-		my %date =
-			parse_date($meta->{'author-time'}, $meta->{'author-tz'});
-		my $date = $date{'iso-tz'};
-		if ($group_size) {
-			$current_color = ($current_color + 1) % $num_colors;
-		}
-		print "<tr id=\"l$lineno\" class=\"$rev_color[$current_color]\">\n";
-		if ($group_size) {
-			print "<td class=\"sha1\"";
-			print " title=\"". esc_html($author) . ", $date\"";
-			print " rowspan=\"$group_size\"" if ($group_size > 1);
-			print ">";
-			print $cgi->a({-href => href(action=>"commit",
-			                             hash=>$full_rev,
-			                             file_name=>$file_name)},
-			              esc_html($short_rev));
-			print "</td>\n";
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
 		}
-		my $parent_commit;
-		if (!exists $meta->{'parent'}) {
-			open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-				or die_error(500, "Open git-rev-parse failed");
-			$parent_commit = <$dd>;
-			close $dd;
-			chomp($parent_commit);
-			$meta->{'parent'} = $parent_commit;
-		} else {
-			$parent_commit = $meta->{'parent'};
-		}
-		my $blamed = href(action => 'blame',
-		                  file_name => $meta->{'filename'},
-		                  hash_base => $parent_commit);
-		print "<td class=\"linenr\">";
-		print $cgi->a({ -href => "$blamed#l$orig_lineno",
-		                -class => "linenr" },
-		              esc_html($lineno));
-		print "</td>";
-		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
-		print "</tr>\n";
-	}
-	print "</table>\n";
-	print "</div>";
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
+				($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/);
+			$metainfo{$full_rev} ||= {};
+			my $meta = $metainfo{$full_rev};
+			my $data; # last line is used later
+			while ($data = <$fd>) {
+				chomp $data;
+				last if ($data =~ s/^\t//); # contents of line
+				if ($data =~ /^(\S+) (.*)$/) {
+					$meta->{$1} = $2;
+				}
+			}
+			my $short_rev = substr($full_rev, 0, 8);
+			my $author = $meta->{'author'};
+			my %date =
+				parse_date($meta->{'author-time'}, $meta->{'author-tz'});
+			my $date = $date{'iso-tz'};
+			if ($group_size) {
+				$current_color = ($current_color + 1) % $num_colors;
+			}
+			print qq!<tr id="l$lineno" class="$rev_color[$current_color]">\n!;
+			if ($group_size) {
+				print qq!<td class="sha1"!.
+				      qq! title="!. esc_html($author) . qq!, $date"!;
+				print qq! rowspan="$group_size"! if ($group_size > 1);
+				print qq!>!;
+				print $cgi->a({-href => href(action=>"commit",
+				                             hash=>$full_rev,
+				                             file_name=>$file_name)},
+				              esc_html($short_rev));
+				print qq!</td>\n!;
+			}
+			if (!exists $meta->{'parent'}) {
+				open my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^"
+					or die_error(500, "Open git-rev-parse failed");
+				$meta->{'parent'} = <$dd>;
+				close $dd;
+				chomp $meta->{'parent'};
+			}
+			my $blamed = href(action => 'blame',
+			                  file_name => $meta->{'filename'},
+			                  hash_base => $meta->{'parent'});
+			print qq!<td class="linenr">!.
+			       $cgi->a({ -href => "$blamed#l$orig_lineno",
+			                -class => "linenr" },
+			               esc_html($lineno)).
+			      qq!</td>!;
+			print qq!<td class="pre">! . esc_html($data) . "</td>\n";
+			print qq!</tr>\n!;
+		}
+	}
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
1.6.0.4
