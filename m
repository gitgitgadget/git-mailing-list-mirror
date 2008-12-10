From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 4/3] gitweb: Incremental blame (proof of concept)
Date: Wed, 10 Dec 2008 21:11:18 +0100
Message-ID: <20081210200908.16899.36727.stgit@localhost.localdomain>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 21:13:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVQV-0008Or-QH
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbYLJULh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbYLJULh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:11:37 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:55117 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbYLJULe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:11:34 -0500
Received: by ti-out-0910.google.com with SMTP id b6so419810tic.23
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=VNLL69WKv+BhA1x06tl5Cp4mqpQHogIQwQ2LsuoeX+Q=;
        b=I8XbNDX9AJqc70V6hA7t6aKqQ+fug/qeBC/6WFnvt59JQ/5e+C4UUiYj3pqQF325iz
         FKp3aiKaXNL5aDDSy+LlJbjjNMknguk4ej2cyL1xGq47hi8mRKSIB4bRkQnijegXlUuI
         O9+S1Kw6/hQ55IvkcyGGJBzw3aoZc4LWcOn7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=iRy0TgN12jBSiEr5kuAt9b8NvZdib+XZSw/pv79Q8AkmxxeQjNC9pqCaelsnOSef/g
         +UOtXyhd2DhG2A9DS5MOA+HiEcq7pfyaetd6nR9XpfqY7CHPzPlgbij+Yr5nUcTbfx/I
         Kebrto9b+F9PoS7MnbrDgxS/JkMNBDoUmn/0Q=
Received: by 10.110.42.17 with SMTP id p17mr2505422tip.42.1228939891980;
        Wed, 10 Dec 2008 12:11:31 -0800 (PST)
Received: from localhost.localdomain (abxf60.neoplus.adsl.tpnet.pl [83.8.255.60])
        by mx.google.com with ESMTPS id 25sm2357904tif.6.2008.12.10.12.11.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 12:11:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBAKBIYt016943;
	Wed, 10 Dec 2008 21:11:19 +0100
In-Reply-To: <20081209223703.28106.29198.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102712>

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
incremental blame, and for incremental blame data.

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

Cc: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm sorry if you have received duplicate copy of this message...

NOTE: This patch is RFC proof of concept patch!: it should be split
onto many smaller patches for easy review (and bug finding) in version
meant to be applied.

[Please tell me if some of info below should be put in the commit
 message instead of here]

Patch by Petr Baudis this one is based on:
  http://permalink.gmane.org/gmane.comp.version-control.git/56657

Original patch by Fredrik Kuivinen:
  http://article.gmane.org/gmane.comp.version-control.git/41361

Snippet adding 'generated in' to gitweb, by Petr Baudis:
  http://article.gmane.org/gmane.comp.version-control.git/83306

Should I post interdiff to Petr Baudis patch, and comments about
difference between them? This post is quite long as it is now...


Differences between 'blame' and 'blame_incremental' output:
* Line number links in 'blame' lead to parent of blamed commit, i.e. to
  the view where given line _changed_; this behavior was introduced in
  244a70e (Blame "linenr" link jumps to previous state at "orig_lineno")
  by Luben Tuikov on Jan 2008 to make data mining possible.

  Currently 'blame_incremental' lead to version at blamed commit; this
  would be hard to change without opening another stream, or without
  having gitweb accept <sha1>^ for 'hb' (hash_base) parameter.

* The title attribute (shown in popup on mouseover) for "sha1" cell
  for 'blame_incremental' view looks like the following:
    'Kay Sievers, 2005-08-07 19:49:46 +0000 (21:49:46 +0200)'
  more like the date format used in 'commit' view, rather than shorter
    'Kay Sievers, 2005-08-07 21:49:46 +0200'

  This is a bit of accident, as in originla patch(es) there was error
  where the time and date shown were for UTC (GMT), and not for shown
  together timezone, i.e.
    'Kay Sievers, 2005-08-07 19:49:46 +0200'
  and I have added local time instead of replacing it. But perhaps it
  is 'blame' view that should change format? 

* In 'blame_incremental' the cell (<td>) with sha1 has rowspan
  attribute set even if it is at its default value rowspan="1".
  This should be very easy to fix.

* The 'blame_incremental' view has new feature inspired by output of
  "git gui blame <file>", that if group of lines blamed to the same
  commit has more than two lines, then below shortened sha-1 of a
  commit it is shown shortened author (initials, in uppercase).

  If you think it is worth it, this feature should be fairly easy to
  port to ordinary non-incremental 'blame' view.

* Sometimes "git blame --porcelain" and "git blame --incremental" can
  give different output.  Compare for example 'blame' and
  'blame_incremental' view for GIT-VERSION-GEN in git.git repository,
  and note that in 'blame_incremental' the last two groups are for the
  same commit (compare bottom parts of pages).  'blame_incremental'
  currently does not consolidate groups; if it did that, it should do
  it before fixColors()

* During filling blame info 'blame_incremental' view uses three colors
  (three styles: color1, color2, color3) instead of two color zebra
  coloring (two styles: light2, dark2) to ensure that the color of
  current group is different from both of its neighbours.

  This is non-issue: this is fixed at the end (although intermediate
  versions of blame.js script didn't fo fixColors() to make it easier
  to check if the 3-coloring is correct).

* The 'blame_incremental' view contains unique progress bar and
  progress report; perhaps they should vanish after succesfull loading
  of all data?


Bugs and suspected bugs in Mozilla 1.17.2 (my main browser); perhaps
those got corrected, as 1.17.2 is ancient (Gecko/20050923) version:
* HTML 4.01 Transitional specification at W3C states only ID and NAME
  tokens must begin with a letter ([A-Za-z]); it looks like class
  named "1" or "2" or "3" has style specified by CSS ignored.

* With XHTML 1.0 DTD and application/xhtml+xml content type, if there
  were <col /> elements in blame table (currently commented out in the
  source), then row with column headings (with <td> elements) was not
  visible.

* With XHTML 1.0 DTD and application/xhtml+xml content type, if there
  was an error in JavaScript, instead of having it visible as error
  message in JavaScript Console, Mozilla behaved as if the script
  wasn't there at all.

* With XHTML 1.0 DTD and application/xhtml+xml content type, setting
  innerHTML doesn't work: it raises cryptic JavaScript exception:

    Component returned failure code: 0x80004005 (NS_ERROR_FAILURE)
    [nsIDOMNSHTMLElement.innerHTML]	

  Correct solution would be to use only DOM, or rather depending on
  what web browser supports, use either .innerHTML (which is
  proprietary Microsoft extension) or DOM (which is standard but not
  all browser use it).  Current *workaround* is to simply always use
  'text/html' content type, and HTML 4.01 DTD.

  I wonder whether innerHTML or DOM is faster; and how many of web
  browser implements other similar properties like innerText,
  outerHTML and insertAdjacentHTML.

* XHTML 1.0 doesn't allow for trick with using HTML comments to hide
  contents of <script> element from old browsers, as XML compliant
  browser can remove XML comments before seeing JavaScript, so we
  don't use it.  Besides I think this issue is irrelevant now.


P.S. I have removed a few spurious one line change chunks from
gitweb/gitweb.perl, which were done to not confuse Perl syntax
highlighting (lazy-lock-mode) from cperl-mode in GNU Emacs 21.4.1,
and to not confuse imenu parser in GNU Emacs (which allow to go to
specified subroutine, and to display which-function-info in
modeline), so diffstat is slightly out of sync.

Those were #" or #' after regexp with single unescaped " or ',
and ($) in definition of "sub S_ISGITLINK($)".

P.P.S. What is the stance for copyrigth assesments in the files
for git code, like the ones in gitweb/gitweb.perl and gitweb/blame.js?

P.P.P.S. Should I use Signed-off-by from Pasky and Fredrik if I based
my code on theirs, and if they all signed their patches?

 Makefile           |    4 +
 git-instaweb.sh    |    6 +
 gitweb/blame.js    |  398 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |   27 +++-
 gitweb/gitweb.perl |  252 ++++++++++++++++++++++-----------
 5 files changed, 597 insertions(+), 90 deletions(-)
 create mode 100644 gitweb/blame.js

diff --git a/Makefile b/Makefile
index 5158197..05ac246 100644
--- a/Makefile
+++ b/Makefile
@@ -218,6 +218,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_BLAMEJS = blame.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -1209,6 +1210,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	    -e 's|++GITWEB_BLAMEJS++|$(GITWEB_BLAMEJS)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
 	    $< >$@+ && \
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
index 0843372..f41354c 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -268,6 +268,12 @@ gitweb_css () {
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
 
diff --git a/gitweb/blame.js b/gitweb/blame.js
new file mode 100644
index 0000000..197d615
--- /dev/null
+++ b/gitweb/blame.js
@@ -0,0 +1,398 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+
+var DEBUG = 0;
+function debug(str) {
+	if (DEBUG)
+		alert(str);
+}
+
+function createRequestObject() {
+	var ro;
+	if (window.XMLHttpRequest) {
+		ro = new XMLHttpRequest();
+	} else {
+		ro = new ActiveXObject("Microsoft.XMLHTTP");
+	}
+	if (!ro)
+		debug("Couldn't start XMLHttpRequest object");
+	return ro;
+}
+
+var http;
+var baseUrl;
+
+// 'commits' is an associative map. It maps SHA1s to Commit objects.
+var commits = new Object();
+
+function Commit(sha1) {
+	this.sha1 = sha1;
+}
+
+// convert month or day of the month to string, padding it with
+// '0' (zero) to two characters width if necessary
+function zeroPad(n) {
+	if (n < 10)
+		return '0' + n;
+	else
+		return n.toString();
+}
+
+function spacePad(n,width) {
+	var scale = 1;
+	var str = '';
+
+	while (width > 1) {
+		scale *= 10;
+		if (n < scale)
+			str += '&nbsp;';
+		width--;
+	}
+	return str + n.toString();
+}
+
+
+var blamedLines = 0;
+var totalLines  = '???';
+var div_progress_bar;
+var div_progress_info;
+
+function countLines() {
+	var table = document.getElementById('blame_table');
+	if (!table)
+		table = document.getElementsByTagName('table').item(0);
+
+	if (table)
+		return table.getElementsByTagName('tr').length - 1; // for header
+	else
+		return '...';
+}
+
+function updateProgressInfo() {
+	if (!div_progress_info)
+		div_progress_info = document.getElementById('progress_info');
+	if (!div_progress_bar)
+		div_progress_bar = document.getElementById('progress_bar');
+	if (!div_progress_info && !div_progress_bar)
+		return;
+
+	var percentage = Math.floor(100.0*blamedLines/totalLines);
+
+	if (div_progress_info) {
+		div_progress_info.innerHTML  = blamedLines + ' / ' + totalLines
+			+ ' ('+spacePad(percentage,3)+'%)';
+	}
+
+	if (div_progress_bar) {
+		div_progress_bar.setAttribute('style', 'width: '+percentage+'%;');
+	}
+}
+
+var colorRe = new RegExp('color([0-9]*)');
+/* return N if <tr class="colorN">, otherwise return null */
+function getColorNo(tr) {
+	var className = tr.getAttribute('class');
+	if (className) {
+		match = colorRe.exec(className);
+		if (match)
+			return parseInt(match[1]);
+	}
+	return null;
+}
+
+function findColorNo(tr_prev, tr_next) {
+	var color_prev;
+	var color_next;
+
+	if (tr_prev)
+		color_prev = getColorNo(tr_prev);
+	if (tr_next)
+		color_next = getColorNo(tr_next);
+
+	if (!color_prev && !color_next)
+		return 1;
+	if (color_prev == color_next)
+		return ((color_prev % 3) + 1);
+	if (!color_prev)
+		return ((color_next % 3) + 1);
+	if (!color_next)
+		return ((color_prev % 3) + 1);
+	return (3 - ((color_prev + color_next) % 3));
+}
+
+var tzRe = new RegExp('^([+-][0-9][0-9])([0-9][0-9])$');
+// called for each blame entry, as soon as it finishes
+function handleLine(commit) {
+	/* This is the structure of the HTML fragment we are working
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
+	if (!commit.info) {
+		var date = new Date();
+		date.setTime(commit.authorTime * 1000); // milliseconds
+		var dateStr =
+			date.getUTCFullYear() + '-'
+			+ zeroPad(date.getUTCMonth()+1) + '-'
+			+ zeroPad(date.getUTCDate());
+		var timeStr =
+			zeroPad(date.getUTCHours()) + ':'
+			+ zeroPad(date.getUTCMinutes()) + ':'
+			+ zeroPad(date.getUTCSeconds());
+
+		var localDate = new Date();
+		var match = tzRe.exec(commit.authorTimezone);
+		localDate.setTime(1000 * (commit.authorTime
+			+ (parseInt(match[1],10)*3600 + parseInt(match[2],10)*60)));
+		var localTimeStr =
+			zeroPad(localDate.getUTCHours()) + ':'
+			+ zeroPad(localDate.getUTCMinutes()) + ':'
+			+ zeroPad(localDate.getUTCSeconds());
+
+		/* e.g. 'Kay Sievers, 2005-08-07 19:49:46 +0000 (21:49:46 +0200)' */
+		commit.info = commit.author + ', ' + dateStr + ' '
+			+ timeStr + ' +0000'
+			+ ' (' + localTimeStr + ' ' + commit.authorTimezone + ')';
+	}
+
+	var color = findColorNo(
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
+		if (color) {
+			tr.setAttribute('class', 'color'+color.toString());
+			// Internet Explorer needs this
+			//tr.setAttribute('className', color.toString);
+		}
+		/* <td class="sha1" title="?" rowspan="?"><a href="?">?</a></td> */
+		if (i == 0) {
+			td_sha1.title = commit.info;
+			td_sha1.setAttribute('rowspan', commit.numlines);
+
+			a_sha1.href = baseUrl + '?a=commit;h=' + commit.sha1;
+			a_sha1.innerHTML = commit.sha1.substr(0, 8);
+			if (commit.numlines >= 2) {
+				var br   = document.createElement("br");
+				var text = document.createTextNode(commit.author.match(/\b([A-Z])\B/g).join(''));
+				if (br && text) {
+					td_sha1.appendChild(br);
+					td_sha1.appendChild(text);
+				}
+			}
+		} else {
+			tr.removeChild(td_sha1);
+		}
+
+		/* <td class="linenr"><a class="linenr" href="?">123</a></td> */
+		a_linenr.href = baseUrl + '?a=blame;hb=' + commit.sha1
+			+ ';f=' + commit.filename + '#l' + (commit.srcline + i);
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
+function fixColors() {
+	var colorClasses = ['light2', 'dark2'];
+	var linenum = 1;
+	var tr;
+	var colorClass = 0;
+
+	while ((tr = document.getElementById('l'+linenum))) {
+		if (startOfGroup(tr, linenum, document)) {
+			colorClass = (colorClass + 1) % 2;
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
+function writeTimeInterval() {
+	var info = document.getElementById('generate_time');
+	if (!info)
+		return;
+	var t1 = new Date();
+
+	info.innerHTML += ' + '
+		+ t_interval_server+'s server (blame_data) / '
+		+ (t1.getTime() - t0.getTime())/1000 + 's client (JavaScript)';
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
+	debug('handleResp ready: ' + http.readyState
+	      + ' respText null?: ' + (http.responseText === null)
+	      + ' progress: ' + inProgress);
+
+	if (http.readyState != 4 && http.readyState != 3)
+		return;
+
+	// the server stream is incorrect
+	if (http.readyState == 3 && http.status != 200)
+		return;
+	if (http.readyState == 4 && http.status != 200) {
+		if (!div_progress_info)
+			div_progress_info = document.getElementById('progress_info');
+
+		if (div_progress_info) {
+			div_progress_info.setAttribute('class', 'error');
+			div_progress_info.innerHTML =
+				http.status+' - Error contacting server\n';
+		} else {
+			document.write("<b>ERROR:</b> HTTP status is "+http.status+"<br />\n");
+		}
+
+		clearInterval(pollTimer);
+		inProgress = false;
+	}
+
+	// In konqueror http.responseText is sometimes null here...
+	if (http.responseText === null)
+		return;
+
+	/*
+	var resp = document.getElementById('state');
+	if (resp) {
+		resp.innerHTML = http.readyState + ' : ' + http.status
+			+ '<br />len = ' + http.responseText.length
+			+ '; inProgress='+inProgress;
+		//inProgress = true;
+	}
+	*/
+
+	if (inProgress)
+		return;
+	else
+		inProgress = true;
+
+	while (prevDataLength != http.responseText.length) {
+		if (http.readyState == 4
+		    && prevDataLength == http.responseText.length) {
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
+				var srcline = parseInt(match[2]);
+				var resline = parseInt(match[3]);
+				var numlines = parseInt(match[4]);
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
+					curCommit.authorTime = parseInt(data);
+				} else if (info == 'author-tz') {
+					curCommit.authorTimezone = data;
+				}
+			} else if ((match = endRe.exec(lines[i]))) {
+				t_interval_server = match[1];
+				debug('END: '+lines[i]);
+			} else if (lines[i] != '') {
+				debug('malformed line: ' + lines[i]);
+			}
+		}
+	}
+
+	if (http.readyState == 4 &&
+	    prevDataLength == http.responseText.length) {
+		clearInterval(pollTimer);
+
+		fixColors();
+		writeTimeInterval();
+	}
+
+	inProgress = false;
+}
+
+function startBlame(blamedataUrl, bUrl) {
+	debug('startBlame('+blamedataUrl+', '+bUrl+')');
+
+	t0 = new Date();
+	baseUrl = bUrl;
+	totalLines = countLines();
+	updateProgressInfo();
+
+	http = createRequestObject();
+	http.open('get', blamedataUrl);
+	http.onreadystatechange = handleResponse;
+	http.send(null);
+
+	pollTimer = setInterval(handleResponse, 1000);
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
index 4987fdc..774bcc6 100755
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
@@ -2874,13 +2881,13 @@ sub git_header_html {
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
@@ -3042,6 +3049,14 @@ sub git_footer_html {
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
@@ -4574,7 +4589,9 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame {
+sub git_blame_common {
+	my $format = shift || 'porcelain';
+
 	# permissions
 	gitweb_check_feature('blame')
 		or die_error(403, "Blame view not allowed");
@@ -4596,10 +4613,36 @@ sub git_blame {
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
@@ -4610,93 +4653,134 @@ sub git_blame {
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
+	print qq!<div id="progress_bar" style="width: 100%; background-color: yellow"></div>\n!
+		if ($format eq 'incremental');
+	print qq!<div class="page_body">\n!;
+	print qq!<div id="progress_info">... / ...</div>\n!
+		if ($format eq 'incremental');
+	print qq!<table id="blame_table" class="blame" width="100%">\n!.
+	      #qq!<col width="5.5em" /><col width="2.5em" /><col width="*" />\n!.
+	      qq!<tr><th>Commit</th><th>Line</th><th>Data</th></tr>\n!;
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
+	print "</table>\n"; # class="blame"
+	print "</div>\n";   # class="blame_body"
 	close $fd
 		or print "Reading blob failed\n";
 
-	# page footer
+	if ($format eq 'incremental') {
+		print qq!<script type="text/javascript" src="$blamejs"></script>\n!.
+		      qq!<script type="text/javascript">\n!.
+		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
+		      qq!           "$my_url");\n!.
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
Stacked GIT 0.14.3
git version 1.6.0.4
