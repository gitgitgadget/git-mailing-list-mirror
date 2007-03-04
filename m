From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH] gitweb: Incremental blame
Date: Sun, 04 Mar 2007 17:40:28 +0100
Message-ID: <20070304164028.9686.81040.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 17:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNtlI-0008VH-Ul
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 17:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbXCDQkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 11:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbXCDQkc
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 11:40:32 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:50075 "EHLO
	mxfep01.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbXCDQkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 11:40:31 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep01.bredband.com with ESMTP
          id <20070304164029.ZXFA3634.mxfep01.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 4 Mar 2007 17:40:29 +0100
Received: from c-ef66e455.09-360-6c6b701.cust.bredbandsbolaget.se (HELO c165) ([85.228.102.239])
  by ironport2.bredband.com with ESMTP; 04 Mar 2007 17:40:29 +0100
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1HNtl7-0002WL-00
	for <git@vger.kernel.org>; Sun, 04 Mar 2007 17:40:29 +0100
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41361>


This is a proof of concept patch to add support for incrementally
displaying author data in the blame view.

It has been lightly tested in a couple of browsers (Firefox, Mozilla,
Konqueror, Galeon, Opera and IE6).


There are a couple of issues with this patch:

* If it is going to be merged, we probably need to fallback to the old
  non-incremental blame view as the current code does not work in all
  browsers. Furthermore, not all browsers support javascript. I am not
  sure how this should be done.

* For some unknown reason it does not work in Epiphany.

* In IE6, all author data is eventually shown, but it is not done
  incrementally.

Any comments or suggestions for how to fix any of the issues above is
greatly appreciated.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

---

 Makefile           |    6 +-
 git-instaweb.sh    |    7 ++
 gitweb/blame.js    |  193 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |  112 ++++++++++++++++++++++++++++++
 4 files changed, 316 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 10cdaee..e498c5e 100644
--- a/Makefile
+++ b/Makefile
@@ -139,6 +139,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_BLAMEJS = blame.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -691,13 +692,14 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	    -e 's|++GITWEB_BLAMEJS++|$(GITWEB_BLAMEJS)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/blame.js
 	rm -f $@ $@+
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -706,6 +708,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_BLAMEJS@@/r gitweb/blame.js' \
+	    -e '/@@GITWEB_BLAMEJS@@/d' \
 	    $@.sh > $@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/git-instaweb.sh b/git-instaweb.sh
index cbc7418..dddbb6b 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -233,8 +233,15 @@ gitweb_css () {
 EOFGITWEB
 }
 
+gitweb_blamejs () {
+	cat > "$1" <<\EOFGITWEB
+@@GITWEB_BLAMEJS@@
+EOFGITWEB
+}
+
 gitweb_cgi $GIT_DIR/gitweb/gitweb.cgi
 gitweb_css $GIT_DIR/gitweb/gitweb.css
+gitweb_blamejs $GIT_DIR/gitweb/blame.js
 
 case "$httpd" in
 *lighttpd*)
diff --git a/gitweb/blame.js b/gitweb/blame.js
new file mode 100644
index 0000000..88b6499
--- /dev/null
+++ b/gitweb/blame.js
@@ -0,0 +1,193 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+
+var DEBUG = 0;
+function debug(str)
+{
+    if (DEBUG)
+        alert(str);
+}
+
+function createRequestObject() {
+    var ro;
+    if (window.XMLHttpRequest) {
+        ro = new XMLHttpRequest();
+    } else {
+        ro = new ActiveXObject("Microsoft.XMLHTTP");
+    }
+    return ro;
+}
+
+var http;
+var baseUrl;
+
+// 'commits' is an associative map. It maps SHA1s to Commit objects.
+var commits = new Object();
+
+function Commit(sha1)
+{
+    this.sha1 = sha1;
+}
+
+function zeroPad(n)
+{
+    if (n < 10)
+        return '0' + n;
+    else
+        return n.toString();
+}
+
+function handleLine(commit)
+{
+        /* This is the structure of the HTML fragment we are working
+         with:
+
+         <tr id="l123" class="light2">
+           <td class="sha1" title="">
+             <a href=""></a>
+           </td>
+           <td class="linenr">
+             <a class="linenr" href="">123</a>
+           </td>
+           <td class="pre"># times (my ext3 doesn&#39;t).</td>
+         </tr>
+        */
+
+    var resline = commit.resline;
+    for (var i = 0; i < commit.numlines; i++) {
+        var tr = document.getElementById('l'+resline);
+        if (!tr) {
+            debug('tr is null! resline: ' + resline);
+            break;
+        }
+
+        var date = new Date();
+        date.setTime(commit.authorTime*1000);
+        var dateStr =
+            date.getUTCFullYear() + '-' +
+            zeroPad(date.getUTCMonth()+1) + '-' +
+            zeroPad(date.getUTCDate());
+        var timeStr =
+            zeroPad(date.getUTCHours()) + ':' +
+            zeroPad(date.getUTCMinutes()) + ':' +
+            zeroPad(date.getUTCSeconds());
+        tr.firstChild.title = commit.author + ', ' + dateStr + ' ' + timeStr;
+        var shaAnchor = tr.firstChild.firstChild;
+        if (i == 0) {
+            shaAnchor.href = baseUrl + ';a=commit;h=' + commit.sha1;
+            shaAnchor.innerHTML = commit.sha1.substr(0, 8);
+        } else {
+            shaAnchor.innerHTML = '';
+        }
+
+        var lineAnchor = tr.firstChild.nextSibling.firstChild;
+        lineAnchor.href = baseUrl + ';a=blame;hb=' + commit.sha1 +
+            ';f=' + commit.filename + '#l' + commit.srcline;
+        resline++;
+    }
+}
+
+function fixColors()
+{
+    var colorClasses = ['light2', 'dark2'];
+    var linenum = 1;
+    var tr;
+    var colorClass = 0;
+
+    while((tr = document.getElementById('l'+linenum))) {
+        if(tr.firstChild.firstChild.innerHTML != '') {
+            colorClass = (colorClass + 1) % 2;
+        }
+        tr.setAttribute('class', colorClasses[colorClass]);
+        // Internet Explorer needs this
+        tr.setAttribute('className', colorClasses[colorClass]);
+        linenum++;
+    }
+}
+
+var prevDataLength = -1;
+var nextLine = 0;
+var inProgress = false;
+
+var sha1Re = new RegExp('([0-9a-f]{40}) ([0-9]+) ([0-9]+) ([0-9]+)');
+var infoRe = new RegExp('([a-z-]+) ?(.*)');
+var curCommit = new Commit();
+
+function handleResponse() {
+    debug('handleResp ready: ' + http.readyState +
+          ' respText null?: ' + (http.responseText === null) +
+          ' progress: ' + inProgress);
+
+    if (http.readyState != 4 && http.readyState != 3)
+        return;
+
+    // In konqueror http.responseText is sometimes null here...
+    if (http.responseText === null)
+        return;
+
+    if (inProgress)
+        return;
+    else
+        inProgress = true;
+
+    while (prevDataLength != http.responseText.length) {
+        if (http.readyState == 4 &&
+            prevDataLength == http.responseText.length) {
+            break;
+        }
+
+        prevDataLength = http.responseText.length;
+        var response = http.responseText.substring(nextLine);
+        var lines = response.split('\n');
+        nextLine = nextLine + response.lastIndexOf('\n') + 1;
+        if (response[response.length-1] != '\n') {
+            lines.pop();
+        }
+
+        for (var i = 0; i < lines.length; i++) {
+            var match = sha1Re.exec(lines[i]);
+            if (match) {
+                var sha1 = match[1];
+                var srcline = parseInt(match[2]);
+                var resline = parseInt(match[3]);
+                var numlines = parseInt(match[4]);
+                var c = commits[sha1];
+                if (!c) {
+                    c = new Commit(sha1);
+                    commits[sha1] = c;
+                }
+
+                c.srcline = srcline;
+                c.resline = resline;
+                c.numlines = numlines;
+                curCommit = c;
+            } else if ((match = infoRe.exec(lines[i]))) {
+                var info = match[1];
+                var data = match[2];
+                if (info == 'filename') {
+                    curCommit.filename = data;
+                    handleLine(curCommit);
+                } else if (info == 'author') {
+                    curCommit.author = data;
+                } else if (info == 'author-time') {
+                    curCommit.authorTime = parseInt(data);
+                }
+            } else if (lines[i] != '') {
+                debug('malformed line: ' + lines[i]);
+            }
+        }
+    }
+
+    if (http.readyState == 4 && prevDataLength == http.responseText.length)
+        fixColors();
+
+    inProgress = false;
+}
+
+function startBlame(blamedataUrl, bUrl)
+{
+    baseUrl = bUrl;
+    http = createRequestObject();
+    http.open('get', blamedataUrl);
+    http.onreadystatechange = handleResponse;
+    http.send(null);
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 653ca3c..9c07f09 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -61,6 +61,8 @@ our $stylesheet = undef;
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
 our $favicon = "++GITWEB_FAVICON++";
+# URI of blame.js
+our $blamejs = "++GITWEB_BLAMEJS++";
 
 # URI and label (title) of GIT logo link
 #our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
@@ -425,7 +427,9 @@ $git_dir = "$projectroot/$project" if $project;
 
 # dispatch
 my %actions = (
-	"blame" => \&git_blame2,
+#	"blame" => \&git_blame2,
+	"blame" => \&git_blame_incremental,
+	"blamedata" => \&git_blame_data,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -3135,6 +3139,112 @@ sub git_tag {
 	git_footer_html();
 }
 
+sub git_blame_data {
+	my $fd;
+	my $ftype;
+
+	my ($have_blame) = gitweb_check_feature('blame');
+	if (!$have_blame) {
+		die_error('403 Permission denied', "Permission denied");
+	}
+	die_error('404 Not Found', "File name not defined") if (!$file_name);
+	$hash_base ||= git_get_head_hash($project);
+	die_error(undef, "Couldn't find base commit") unless ($hash_base);
+	my %co = parse_commit($hash_base)
+		or die_error(undef, "Reading commit failed");
+	if (!defined $hash) {
+		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
+			or die_error(undef, "Error looking up file");
+	}
+	$ftype = git_get_type($hash);
+	if ($ftype !~ "blob") {
+		die_error("400 Bad Request", "Object is not a blob");
+	}
+	open ($fd, "-|", git_cmd(), "blame", '--incremental', $hash_base, '--',
+	      $file_name)
+		or die_error(undef, "Open git-blame --incremental failed");
+
+	print $cgi->header(-type=>"text/plain", -charset => 'utf-8',
+	                   -status=> "200 OK");
+
+	while(<$fd>) {
+ 	  if (/^([0-9a-f]{40}) ([0-9]+) ([0-9]+) ([0-9]+)/ or
+	     /^author-time |^author |^filename /) {
+ 	    print;
+	  }
+	}
+
+	close $fd or print "Reading blame data failed\n";
+}
+
+sub git_blame_incremental {
+	my $fd;
+	my $ftype;
+
+	my ($have_blame) = gitweb_check_feature('blame');
+	if (!$have_blame) {
+		die_error('403 Permission denied', "Permission denied");
+	}
+	die_error('404 Not Found', "File name not defined") if (!$file_name);
+	$hash_base ||= git_get_head_hash($project);
+	die_error(undef, "Couldn't find base commit") unless ($hash_base);
+	my %co = parse_commit($hash_base)
+		or die_error(undef, "Reading commit failed");
+	if (!defined $hash) {
+		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
+			or die_error(undef, "Error looking up file");
+	}
+	$ftype = git_get_type($hash);
+	if ($ftype !~ "blob") {
+		die_error("400 Bad Request", "Object is not a blob");
+	}
+	open ($fd, "-|", git_cmd(), 'cat-file', 'blob', $hash)
+		or die_error(undef, "Open git-cat-file failed");
+	git_header_html();
+	my $formats_nav =
+		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		        "blob") .
+		" | " .
+		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+			"history") .
+		" | " .
+		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
+		        "HEAD");
+	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_path($file_name, $ftype, $hash_base);
+	my @rev_color = (qw(light2 dark2));
+	my $num_colors = scalar(@rev_color);
+	my $current_color = 0;
+	my $last_rev;
+	print "<script type=\"text/javascript\" src=\"$blamejs\"></script>\n";
+	print <<HTML;
+<div class="page_body">
+<table class="blame">
+<tr><th>Commit</th><th>Line</th><th>Data</th></tr>
+HTML
+	my %metainfo = ();
+	my $linenr = 0;
+	while (<$fd>) {
+		chomp;
+		$linenr += 1;
+		print "<tr id=\"l$linenr\" class=\"light2\">";
+		print '<td class="sha1"><a href=""></a></td>';
+		print "<td class=\"linenr\"><a class=\"linenr\" href=\"\">$linenr</a></td><td class=\"pre\">" . esc_html($_) . "</td>\n";
+		print "</tr>\n"
+	}
+
+	print "</table>\n";
+	print "</div>";
+	close $fd or print "Reading blob failed\n";
+	print "<script type=\"text/javascript\">\n";
+	print "startBlame(\"" . href(action=>"blamedata", hash_base=>$hash_base, file_name=>$file_name) . "\", \"" .
+	  href() . "\");\n";
+	print "</script>\n";
+	git_footer_html();
+}
+
+
 sub git_blame2 {
 	my $fd;
 	my $ftype;
