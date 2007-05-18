From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Incremental blame
Date: Fri, 18 May 2007 17:15:02 +0200
Message-ID: <20070518151502.27621.36135.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Fredrik Kuivinen <frekui@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 17:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp4Am-0005eN-E5
	for gcvg-git@gmane.org; Fri, 18 May 2007 17:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbXERPPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 11:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbXERPPI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 11:15:08 -0400
Received: from rover.dkm.cz ([62.24.64.27]:60208 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbXERPPF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 11:15:05 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id F27848B6ED;
	Fri, 18 May 2007 17:15:02 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47614>

This is tweaked up version of Fredrik Kuivinen <frekui@gmail.com>'s proof
of concept patch to add support for incrementally displaying line data in
the blame view using some javascript gadgetry.

The original patch has been lightly tested in a couple of browsers
(Firefox, Mozilla, Konqueror, Galeon, Opera and IE6). The new patch has
been tested in Firefox and Epiphany (and works fine in Epiphany 2.14.3,
contrary to what the original patch claimed).

Compared to the original patch, this one works with pathinfo-ish URLs as
well, and should play well with non-javascript browsers as well (the HTML
points to the blame action, while javascript code rewrites the links to use
the blame_incremental action; it is somewhat hackish but I couldn't think
of a better solution).

As usual, you can see it in action at repo.or.cz. blame view now feels a
lot more friendly.

Cc: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile           |    6 +-
 git-instaweb.sh    |    7 ++
 gitweb/blame.js    |  193 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |  140 +++++++++++++++++++++++++++++++++++---
 4 files changed, 335 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index ed12577..46a9fcb 100644
--- a/Makefile
+++ b/Makefile
@@ -168,6 +168,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_BLAMEJS = blame.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -815,13 +816,14 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
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
 	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -830,6 +832,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_BLAMEJS@@/r gitweb/blame.js' \
+	    -e '/@@GITWEB_BLAMEJS@@/d' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
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
index 981fe41..cc671b1 100755
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
@@ -472,6 +474,8 @@ $git_dir = "$projectroot/$project" if $project;
 # dispatch
 my %actions = (
 	"blame" => \&git_blame2,
+	"blame_incremental" => \&git_blame_incremental,
+	"blame_data" => \&git_blame_data,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -570,7 +574,7 @@ sub href(%) {
 			push @result, $symbol . "=" . esc_param($params{$name});
 		}
 	}
-	$href .= "?" . join(';', @result) if scalar @result;
+	$href .= "?" . join(';', @result) if $params{-partial_query} or scalar @result;
 
 	return $href;
 }
@@ -1937,6 +1941,16 @@ sub git_header_html {
 <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
+<script type="text/javascript">/* <![CDATA[ */
+function fixBlameLinks() {
+	var allLinks = document.getElementsByTagName("a");
+	for (var i = 0; i < allLinks.length; i++) {
+		var link = allLinks.item(i);
+		if (link.className == 'blamelink')
+			link.href = link.href.replace("a=blame", "a=blame_incremental");
+	}
+}
+/* ]]> */</script>
 EOF
 # print out each stylesheet that exist
 	if (defined $stylesheet) {
@@ -1968,7 +1982,7 @@ EOF
 	}
 
 	print "</head>\n" .
-	      "<body>\n";
+	      "<body onload=\"fixBlameLinks();\">\n";
 
 	if (-f $site_header) {
 		open (my $fd, $site_header);
@@ -2358,7 +2372,7 @@ sub git_print_tree_entry {
 		if ($have_blame) {
 			print " | " .
 			      $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
-			                             file_name=>"$basedir$t->{'name'}", %base_key)},
+			                             file_name=>"$basedir$t->{'name'}", %base_key), -class => "blamelink"},
 			              "blame");
 		}
 		if (defined $hash_base) {
@@ -2608,7 +2622,7 @@ sub git_difftree_body {
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
-				                             file_name=>$diff->{'file'})},
+				                             file_name=>$diff->{'file'}), -class => "blamelink"},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
@@ -2658,7 +2672,7 @@ sub git_difftree_body {
 			               "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff->{'file'})},
+				                             file_name=>$diff->{'file'}), -class => "blamelink"},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
@@ -2703,7 +2717,7 @@ sub git_difftree_body {
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff->{'to_file'})},
+				                             file_name=>$diff->{'to_file'}), -class => "blamelink"},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
@@ -3577,6 +3591,112 @@ sub git_tag {
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
+		$cgi->a({-href => href(action=>"blame", file_name=>$file_name), -class => "blamelink"},
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
+	print "startBlame(\"" . href(action=>"blame_data", hash_base=>$hash_base, file_name=>$file_name) . "\", \"" .
+	  href(-partial_query=>1) . "\");\n";
+	print "</script>\n";
+	git_footer_html();
+}
+
+
 sub git_blame2 {
 	my $fd;
 	my $ftype;
@@ -3609,7 +3729,7 @@ sub git_blame2 {
 		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 			"history") .
 		" | " .
-		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
+		$cgi->a({-href => href(action=>"blame", file_name=>$file_name), -class => "blamelink"},
 		        "HEAD");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -3711,7 +3831,7 @@ sub git_blame {
 		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 			"history") .
 		" | " .
-		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
+		$cgi->a({-href => href(action=>"blame", file_name=>$file_name), -class => "blamelink"},
 		        "HEAD");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -3884,7 +4004,7 @@ sub git_blob {
 			if ($have_blame) {
 				$formats_nav .=
 					$cgi->a({-href => href(action=>"blame", hash_base=>$hash_base,
-					                       hash=>$hash, file_name=>$file_name)},
+					                       hash=>$hash, file_name=>$file_name), -class => "blamelink"},
 					        "blame") .
 					" | ";
 			}
@@ -5179,7 +5299,7 @@ XML
 			              -title => "diff"}, 'D');
 			if ($have_blame) {
 				print $cgi->a({-href => href(-full=>1, action=>"blame",
-				                             file_name=>$file, hash_base=>$commit),
+				                             file_name=>$file, hash_base=>$commit), -class => "blamelink",
 				              -title => "blame"}, 'B');
 			}
 			# if this is not a feed of a file history
