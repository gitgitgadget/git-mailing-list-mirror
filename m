From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 5/5] gitweb: Incremental blame
Date: Sun, 20 May 2007 22:23:32 +0200
Message-ID: <11796926121907-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11796926121641-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121315-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121911-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926122089-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun May 20 22:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HprwR-0003nX-KZ
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbXETUXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbXETUXn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:23:43 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59510 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929AbXETUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:23:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 9B1917AF1C81;
	Sun, 20 May 2007 22:23:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Hh26ktfyB6H; Sun, 20 May 2007 22:23:33 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 889E47AF1C82; Sun, 20 May 2007 22:23:32 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11796926122089-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47905>

Rewrite ontop of diff patches + some performance tuning.
---
The first chunk is the new version of the link rewriting for git-blame.
It does not need the blamelink class.

As gitweb.js is included in each page (and I didn't wanted to add a second JavaScript file),
I added the content of blame.js at the end of gitweb.js.

I also tried some optimizations. In IceWeasel 2.0.0.3 (= FireFox), the blame of sha1_file.c
needs now 33 instead of 46 seconds on my computer.

The "optimizations" are not tested in other browsers. According to my experience,
I expect that the incremental blame in IE will be slower then in Mozilla.

 gitweb/gitweb.js   |  181 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |   92 ++++++++++++++++++++++++---
 2 files changed, 264 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index cacab5a..001fac6 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -259,6 +259,11 @@ function GitAddLinks ()
     {
       var link = links[i];
       var url = splitGitURL (link.href);
+      if (url.a == "blame")
+	{
+	  url.a = "blame_incremental";
+	  link.href = url.ToURL();
+	}
       if (link.innerHTML == 'commit' || link.innerHTML == 'tag')
 	{
 	  if (!url.h)
@@ -296,3 +301,179 @@ function GitAddLinks ()
 }
 
 window.onload = GitAddLinks;
+
+// Blame Javascript functions
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+// modifed by Martin Koegler <mkoegler@auto.tuwien.ac.at>
+
+function createRequestObject() {
+	var ro;
+	if (window.XMLHttpRequest) {
+		ro = new XMLHttpRequest();
+	} else {
+		ro = new ActiveXObject("Microsoft.XMLHTTP");
+	}
+	return ro;
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
+	this.sha1 = sha1;
+}
+
+function zeroPad(n)
+{
+	if (n < 10)
+		return '0' + n;
+	else
+		return n.toString();
+}
+
+function handleLine(commit)
+{
+	/* This is the structure of the HTML fragment we are working
+	   with:
+	   
+	   <tr id="l123" class="light2">
+	   <td class="sha1" title="">
+	   <a href=""></a>
+	   </td>
+	   <td class="linenr">
+	   <a class="linenr" href="">123</a>
+	   </td>
+	   <td class="pre"># times (my ext3 doesn&#39;t).</td>
+	   </tr>
+	 */
+	var tr = document.getElementById('l'+commit.resline);
+	var linkurl = baseUrl + ';a=blame_incremental;hb=' + commit.sha1
+	  + ';f=' + commit.filename + '#l' + commit.srcline;
+
+	var date = new Date();
+	date.setTime(commit.authorTime * 1000);
+	var dateStr = date.getUTCFullYear() + '-'
+	  + zeroPad(date.getUTCMonth()+1) + '-'
+	  + zeroPad(date.getUTCDate());
+	var timeStr = zeroPad(date.getUTCHours()) + ':'
+	  + zeroPad(date.getUTCMinutes()) + ':'
+	  + zeroPad(date.getUTCSeconds());
+	var title = commit.author + ', ' + dateStr + ' ' + timeStr;
+
+	for (var i = 0; i < commit.numlines; i++) {
+		tr.firstChild.title = title;
+		var shaAnchor = tr.firstChild.firstChild;
+		if (i == 0) {
+			shaAnchor.href = baseUrl + ';a=commit;h=' + commit.sha1;
+			shaAnchor.innerHTML = commit.sha1.substr(0, 8);
+		} else {
+		  if (shaAnchor.innerHTML != '')
+		    shaAnchor.innerHTML = '';
+		}
+
+		tr.firstChild.nextSibling.firstChild.href = linkurl;
+
+		tr = tr.nextSibling;
+		while (tr && tr.nodeType == 3)
+		  tr = tr.nextSibling;
+	}
+}
+
+function fixColors()
+{
+	var colorClasses = ['light2', 'dark2'];
+	var tr = document.getElementById('l1');
+	var colorClass = 0;
+
+	while (tr) {
+		if (tr.firstChild.firstChild.innerHTML != '')
+			colorClass = (colorClass+1)%2;
+
+		if (tr.className != colorClasses[colorClass])
+		  tr.className = colorClasses[colorClass];
+		tr = tr.nextSibling;
+		while (tr && tr.nodeType == 3)
+		  tr = tr.nextSibling;
+	}
+}
+
+var prevDataLength = -1;
+var nextLine = 0;
+var inProgress = false;
+
+var curCommit = new Commit();
+
+function handleResponse() {
+	if (http.readyState != 4 && http.readyState != 3)
+		return;
+
+	// In konqueror http.responseText is sometimes null here...
+	if (http.responseText === null)
+		return;
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
+			var split = lines[i].split(' ');
+			if (split.length == 4 && split[0].length == 40) {
+				var sha1 = split[0];
+				var c = commits[sha1];
+				if (!c) {
+					c = new Commit(sha1);
+					commits[sha1] = c;
+				}
+
+				c.srcline = split[1];
+				c.resline = split[2];
+				c.numlines = split[3];
+				curCommit = c;
+			} else {
+				var info = split[0];
+				var data = lines[i].substr (info.length + 1);
+				if (info == 'filename') {
+					curCommit.filename = data;
+					handleLine(curCommit);
+				} else if (info == 'author') {
+					curCommit.author = data;
+				} else if (info == 'author-time') {
+					curCommit.authorTime = parseInt(data);
+				}
+			}
+		}
+	}
+
+	if (http.readyState == 4 && prevDataLength == http.responseText.length)
+		fixColors();
+
+	inProgress = false;
+}
+
+function startBlame(blamedataUrl, bUrl)
+{
+	baseUrl = bUrl;
+	http = createRequestObject();
+	http.open('get', blamedataUrl);
+	http.onreadystatechange = handleResponse;
+	http.send(null);
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f59a4b5..45787a6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -462,6 +462,8 @@ $git_dir = "$projectroot/$project" if $project;
 # dispatch
 my %actions = (
 	"blame" => \&git_blame2,
+	"blame_incremental" => \&git_blame_incremental,
+	"blame_data" => \&git_blame_data,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -562,7 +564,7 @@ sub href(%) {
 			push @result, $symbol . "=" . esc_param($params{$name});
 		}
 	}
-	$href .= "?" . join(';', @result) if scalar @result;
+	$href .= "?" . join(';', @result) if $params{-partial_query} or scalar @result;
 
 	return $href;
 }
@@ -3517,7 +3519,47 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame2 {
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
+sub git_blame_common {
+	my ($type) = @_;
+
 	my $fd;
 	my $ftype;
 
@@ -3536,11 +3578,16 @@ sub git_blame2 {
 	}
 	$ftype = git_get_type($hash);
 	if ($ftype !~ "blob") {
-		die_error('400 Bad Request', "Object is not a blob");
+		die_error("400 Bad Request", "Object is not a blob");
+	}
+	if ($type eq 'incremental') {
+		open ($fd, "-|", git_cmd(), 'cat-file', 'blob', $hash)
+			or die_error(undef, "Open git-cat-file failed");
+	} else {
+		open ($fd, "-|", git_cmd(), 'blame', '-p', '--',
+		      $file_name, $hash_base)
+			or die_error(undef, "Open git-blame failed");
 	}
-	open ($fd, "-|", git_cmd(), "blame", '-p', '--',
-	      $file_name, $hash_base)
-		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
 		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
@@ -3564,9 +3611,19 @@ sub git_blame2 {
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
 	my %metainfo = ();
-	while (1) {
-		$_ = <$fd>;
-		last unless defined $_;
+	my $linenr = 0;
+	while (<$fd>) {
+		chomp;
+		if ($type eq 'incremental') {
+			# Empty stage with just the file contents
+			$linenr += 1;
+			print "<tr id=\"l$linenr\" class=\"light2\">";
+			print '<td class="sha1"><a href=""></a></td>';
+			print "<td class=\"linenr\"><a class=\"linenr\" href=\"\">$linenr</a></td><td class=\"pre\">" . esc_html($_) . "</td>\n";
+			print "</tr>\n";
+			next;
+		}
+
 		my ($full_rev, $orig_lineno, $lineno, $group_size) =
 		    /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/;
 		if (!exists $metainfo{$full_rev}) {
@@ -3618,13 +3675,30 @@ HTML
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
 	}
+
 	print "</table>\n";
 	print "</div>";
 	close $fd
 		or print "Reading blob failed\n";
+
+	if ($type eq 'incremental') {
+		print "<script type=\"text/javascript\">\n";
+		print "startBlame(\"" . href(action=>"blame_data", hash_base=>$hash_base, file_name=>$file_name) . "\", \"" .
+		  href(-partial_query=>1) . "\");\n";
+		print "</script>\n";
+	}
+
 	git_footer_html();
 }
 
+sub git_blame_incremental {
+	git_blame_common('incremental');
+}
+
+sub git_blame2 {
+	git_blame_common('oneshot');
+}
+
 sub git_blame {
 	my $fd;
 
-- 
1.5.2.rc3.802.g4b4b7
