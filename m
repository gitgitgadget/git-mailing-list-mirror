From: Sham Chukoury <eleusis@xmms.org>
Subject: [PATCH] gitweb - XMMS2 project customisations
Date: Fri, 26 Aug 2005 19:16:05 +0800
Message-ID: <430EF9F5.70003@xmms.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050603010106020903090507"
X-From: git-owner@vger.kernel.org Fri Aug 26 13:18:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8cBo-0001V1-3I
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVHZLPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHZLPi
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:15:38 -0400
Received: from l3-202-89-186-142.arach.net.au ([202.89.186.142]:1796 "EHLO
	shambhala.ath.cx") by vger.kernel.org with ESMTP id S932563AbVHZLPg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 07:15:36 -0400
Received: from shambhala ([10.0.0.1])
	by shambhala.ath.cx with asmtp (Exim 3.35 #1 (Debian))
	id 1E8cBG-00066p-00
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 19:15:30 +0800
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7809>

This is a multi-part message in MIME format.
--------------050603010106020903090507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

G'day.

I figured you folks might be interested in a number of modifications the 
XMMS2 team have made to gitweb. All the changes can be seen at 
http://git.xmms.se

1) Navbar refactoring (gitweb-xmms2navbar.diff)
The original idea was to add a link to our snapshots directory, in the 
navigation bar at the top of every gitweb page. The problem was that the 
code for producing the navbar HTML was mostly duplicated in various 
different places. I refactored the code so that a single 'git_navbar' 
subroutine is called every time gitweb needs a navbar. The patch itself 
probably needs some cleaning up: 1) I omitted the git_navbar call in one 
place, as the original navbar code there didn't look like the navbar 
code in other places, 2) there's a 'snapshot link' in the navbar which 
won't work unless gitweb-xmms2snapshots.diff is also applied 
($snapshots_url isn't defined in gitweb-xmms2navbar.diff)

2) Commit tags support (gitweb-xmms2committags.diff)
We originally started using specific commit tags during the development 
of XMMS2 to facilitate the generation of changelogs at every release. 
This patch reformats commit descriptions containing 'BUG' or 'FEATURE' 
to produce hyperlinks to bug reports on our mantis bug tracker 
(http://bugs.xmms2.xmms.se), as well as linking to release information 
pages ('RELEASE' tag). You could adapt this patch to provide support for 
other custom tags. It might also be possible to cleverly integrate the 
committags and committags_shortlog subroutines into a single 
subroutine.. I couldn't figure it out easily enough - my 
Perl(+regexp)-fu isn't strong enough. ;)

3) Snapshot integration (gitweb-xmms2snapshots.diff & snapshot.cgi)
This patch makes it possible to easily produce snapshots of every commit 
in a git tree. Hyperlinks to 'snapshot' or 'latest snapshot' are added 
in various places. All you need is to have a CGI script to handle the 
request, with 'tree' and 'commit' parameters, where 'tree' refers to a 
git tree/repository and 'commit' is either a commit hash or 'HEAD'. I'm 
also attaching snapshot.cgi, the Python script we use to automagically 
generate and serve snapshot tarballs, as reference.

Hope someone finds these useful.. ;)
Cheers
-S

--------------050603010106020903090507
Content-Type: text/plain;
 name="gitweb-xmms2committags.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitweb-xmms2committags.diff"

--- ../gitweb/gitweb.cgi	2005-08-25 19:25:11.000000000 +0800
+++ gitweb.cgi	2005-08-25 20:33:50.000000000 +0800
@@ -40,6 +40,23 @@
 #my $projects_list = $projectroot;
 my $projects_list = "index/index.aux";
 
+# custom stuff - mantis/commit tags integration
+sub committags($){
+	my $a = shift;
+	$a =~ s!BUG\(([0-9]*)\)!<a href="http://bugs.xmms2.xmms.se/view.php?id=$1">BUG($1)</a>!g;
+	$a =~ s!FEATURE\(([0-9]*)\)!<a href="http://bugs.xmms2.xmms.se/view.php?id=$1">FEATURE($1)</a>!g;
+	$a =~ s!RELEASE: (.*)!RELEASE: <a href="http://wiki.xmms2.xmms.se/index.php/Release:$1">$1</a>!g;
+	return $a;
+}
+sub committags_shortlog($$){
+	my $a = shift;
+	my $href = shift;
+	$a =~ s!BUG\(([0-9]*)\)!</a><a href="http://bugs.xmms2.xmms.se/view.php?id=$1">BUG($1)</a><a class=\"list\" href=\"$href\">!g;
+	$a =~ s!FEATURE\(([0-9]*)\)!</a><a href="http://bugs.xmms2.xmms.se/view.php?id=$1">FEATURE($1)</a><a class=\"list\" href=\"$href\">!g;
+	$a =~ s!RELEASE: (.*)!RELEASE: <a href="http://wiki.xmms2.xmms.se/index.php/Release:$1">$1</a>!g;
+	return $a;
+}
+
 # input validation and dispatch
 my $action = $cgi->param('a');
 if (defined $action) {
@@ -655,7 +672,7 @@
 			$line =~ s/$hash_text/$link/;
 		}
 	}
-	return $line;
+	return committags($line);
 }
 
 sub date_str {
@@ -979,7 +996,7 @@
 			      "<td><i>" . escapeHTML(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 			      "<td>" .
 			      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit", -class => "list"},
-			      "<b>" . escapeHTML($co{'title_short'}) . "</b>") .
+			      "<b>" . committags_shortlog(escapeHTML($co{'title_short'}), "$my_uri?p=$project;a=commit;h=$commit") . "</b>") .
 			      "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
@@ -1977,7 +1994,7 @@
 	      "<br/><br/>\n" .
 	      "</div>\n";
 	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
+	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, committags(escapeHTML($co{'title'}))) . "\n" .
 	      "</div>\n";
 	print "<div class=\"page_path\"><b>/$file_name</b><br/></div>\n";
 
@@ -2004,7 +2021,7 @@
 			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 			      "<td><i>" . escapeHTML(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
 			      "<td>" . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit", -class => "list"}, "<b>" .
-			      escapeHTML(chop_str($co{'title'}, 50)) . "</b>") . "</td>\n" .
+			      committags(escapeHTML(chop_str($co{'title'}, 50))) . "</b>") . "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
 			      " | " . $cgi->a({-href => "$my_uri?p=$project;a=blob;hb=$commit;f=$file_name"}, "blob");
@@ -2230,7 +2247,7 @@
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . escapeHTML(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 		      "<td>" . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit", -class => "list"}, "<b>" .
-		      escapeHTML($co{'title_short'}) . "</b>") . "</td>\n" .
+		      committags_shortlog(escapeHTML($co{'title_short'}), "$my_uri?p=$project;a=commit;h=$commit") . "</b>") . "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$commit"}, "commitdiff") .

--------------050603010106020903090507
Content-Type: text/plain;
 name="gitweb-xmms2navbar.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitweb-xmms2navbar.diff"

--- ../gitweb/gitweb.cgi	2005-08-25 19:25:11.000000000 +0800
+++ gitweb.cgi	2005-08-26 17:56:41.000000000 +0800
@@ -40,6 +40,53 @@
 #my $projects_list = $projectroot;
 my $projects_list = "index/index.aux";
 
+# custom stuff - refactored navbar
+sub git_navbar($$$$) {
+	my $project = shift;
+	my $head = shift;
+	my $curSection = shift;
+	my $extraLinks = shift;
+
+	my $sumLink = $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary");
+	my $slogLink = $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog");
+	my $logLink = $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log");
+	my $comLink = $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit");
+	my $comdifLink = $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff");
+	my $treeLink = $cgi->a({-href => "$my_uri?p=$project;a=tree"}, "tree");
+	my $snapLink = $cgi->a({-href => "$snapshots_url?tree=$project&commit=HEAD"}, "latest snapshot");
+
+	if ($curSection eq "summary") {
+		$sumLink = "summary";
+	}
+	elsif ($curSection eq "shortlog") {
+		$slogLink = "shortlog";
+	}
+	elsif ($curSection eq "log") {
+		$logLink = "log";
+	}
+	elsif ($curSection eq "commit") {
+		$comLink = "commit";
+	}
+	elsif ($curSection eq "commitdiff") {
+		$comdifLink = "commitdiff";
+	}
+	elsif ($curSection eq "tree") {
+		$treeLink = "tree";
+	}
+
+	my $retVal = "<div class=\"page_nav\">\n" .
+	      $sumLink .
+	      " | " . $slogLink .
+	      " | " . $logLink .
+	      " | " . $comLink .
+	      " | " . $comdifLink .
+	      " | " . $treeLink .
+	      " | " . $snapLink .
+	      "<br/>$extraLinks<br/>\n" .
+	      "</div>\n";
+	return $retVal;
+}
+
 # input validation and dispatch
 my $action = $cgi->param('a');
 if (defined $action) {
@@ -941,15 +988,7 @@
 	}
 
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      "summary".
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree"}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $head, "summary", "");
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . escapeHTML($descr) . "</td></tr>\n" .
@@ -1087,15 +1126,7 @@
 sub git_tag {
 	my $head = git_read_hash("$project/HEAD");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;hb=$head"}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $head, "tag", "");
 	my %tag = git_read_tag($hash);
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($tag{'name'})) . "\n" .
@@ -1126,15 +1157,7 @@
 sub git_tags {
 	my $head = git_read_hash("$project/HEAD");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;hb=$head"}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $head, "tags", "");
 	my $taglist = git_read_refs("refs/tags");
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=summary", -class => "title"}, "&nbsp;") .
@@ -1185,15 +1208,7 @@
 sub git_branches {
 	my $head = git_read_hash("$project/HEAD");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;hb=$head"}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $head, "branches", "");
 	my $taglist = git_read_refs("refs/heads");
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=summary", -class => "title"}, "&nbsp;") .
@@ -1263,15 +1278,7 @@
 	my $base = $file_name || "";
 	git_header_html();
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base"}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash_base"}, "commitdiff") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash_base"}, "tree") . "<br/>\n";
-		print $cgi->a({-href => "$my_uri?p=$project;a=blob_plain;h=$hash"}, "plain") . "<br/>\n" .
-		      "</div>\n";
+		print git_navbar($project, $hash_base, "blob", $cgi->a({-href => "$my_uri?p=$project;a=blob_plain;h=$hash"}, "plain"));
 		print "<div>" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base", -class => "title"}, escapeHTML($co{'title'})) .
 		      "</div>\n";
@@ -1331,15 +1338,7 @@
 	my $base = "";
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
 		$base_key = ";hb=$hash_base";
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash_base"}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash_base"}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base"}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash_base"}, "commitdiff") .
-		      " | tree" .
-		      "<br/><br/>\n" .
-		      "</div>\n";
+		print git_navbar($project, $hash_base, "tree", "");
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 		      "</div>\n";
@@ -1493,38 +1492,31 @@
 		$page = 0;
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n";
-	print $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash"}, "shortlog") .
-	      " | log" .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$hash;hb=$hash"}, "tree") . "<br/>\n";
 
+	my $navExtra = "";
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
 	if ($hash ne $head || $page) {
-		print $cgi->a({-href => "$my_uri?p=$project;a=log"}, "HEAD");
+		$navExtra .= $cgi->a({-href => "$my_uri?p=$project;a=log"}, "HEAD");
 	} else {
-		print "HEAD";
+		$navExtra .= "HEAD";
 	}
 	if ($page > 0) {
-		print " &sdot; " .
+		$navExtra .= " &sdot; " .
 		$cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash;pg=" . ($page-1), -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
-		print " &sdot; prev";
+		$navExtra .= " &sdot; prev";
 	}
 	if ($#revlist >= (100 * ($page+1)-1)) {
-		print " &sdot; " .
+		$navExtra .= " &sdot; " .
 		$cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash;pg=" . ($page+1), -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
-		print " &sdot; next";
+		$navExtra .= " &sdot; next";
 	}
-	print "<br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $hash, "log", $navExtra);
 	if (!@revlist) {
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=summary", -class => "title"}, "&nbsp;") .
@@ -1593,6 +1585,7 @@
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 	git_header_html();
+	# git_navbar omitted here - commitdiff link a bit weird o_O
 	print "<div class=\"page_nav\">\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
 	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash"}, "shortlog") .
@@ -1773,16 +1766,7 @@
 	mkdir($git_temp, 0700);
 	git_header_html();
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base"}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash_base"}, "commitdiff") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash_base"}, "tree") .
-		      "<br/>\n";
-		print $cgi->a({-href => "$my_uri?p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent"}, "plain") .
-		      "</div>\n";
+		print git_navbar($project, $hash_base, "blobdiff", $cgi->a({-href => "$my_uri?p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent"}, "plain"));
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 		      "</div>\n";
@@ -1825,15 +1809,7 @@
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | commitdiff" .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") . "<br/>\n";
-	print $cgi->a({-href => "$my_uri?p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent"}, "plain") . "\n" .
-	      "</div>\n";
+	print git_navbar($project, $hash, "commitdiff", $cgi->a({-href => "$my_uri?p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent"}, "plain"));
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 	      "</div>\n";
@@ -1967,15 +1943,7 @@
 		die_error(undef, "Unknown commit object.");
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $hash, "history", "");
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 	      "</div>\n";
@@ -2051,15 +2019,7 @@
 		$pickaxe_search = 1;
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary;h=$hash"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $hash, "search", "");
 
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
@@ -2180,38 +2140,31 @@
 		$page = 0;
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | shortlog" .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$hash;hb=$hash"}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
+	my $navExtra = "";
 	if ($hash ne $head || $page) {
-		print $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "HEAD");
+		$navExtra .= $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "HEAD");
 	} else {
-		print "HEAD";
+		$navExtra .= "HEAD";
 	}
 	if ($page > 0) {
-		print " &sdot; " .
+		$navExtra .= " &sdot; " .
 		$cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash;pg=" . ($page-1), -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
-		print " &sdot; prev";
+		$navExtra .= " &sdot; prev";
 	}
 	if ($#revlist >= (100 * ($page+1)-1)) {
-		print " &sdot; " .
+		$navExtra .= " &sdot; " .
 		$cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash;pg=" . ($page+1), -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
-		print " &sdot; next";
+		$navExtra .= " &sdot; next";
 	}
-	print "<br/>\n" .
-	      "</div>\n";
+	print git_navbar($project, $hash, "shortlog", $navExtra);
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=summary", -class => "title"}, "&nbsp;") .
 	      "</div>\n";

--------------050603010106020903090507
Content-Type: text/plain;
 name="gitweb-xmms2snapshots.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitweb-xmms2snapshots.diff"

--- ../gitweb/gitweb.cgi	2005-08-25 19:25:11.000000000 +0800
+++ gitweb.cgi	2005-08-26 17:50:57.000000000 +0800
@@ -40,6 +40,8 @@
 #my $projects_list = $projectroot;
 my $projects_list = "index/index.aux";
 
+my $snapshots_url = "http://git.xmms.se/snapshot.cgi";
+
 # input validation and dispatch
 my $action = $cgi->param('a');
 if (defined $action) {
@@ -845,6 +847,7 @@
 		      $cgi->a({-href => "$my_uri?p=$pr->{'path'};a=summary"}, "summary") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$pr->{'path'};a=shortlog"}, "shortlog") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$pr->{'path'};a=log"}, "log") .
+		      " | " . $cgi->a({-href => "$snapshots_url?tree=$pr->{'path'}&commit=HEAD"}, "latest snapshot") .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
@@ -984,6 +987,7 @@
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
 			      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$commit"}, "commitdiff") .
+			      " | " . $cgi->a({-href => "$snapshots_url?tree=$project&commit=$commit"}, "snapshot") .
 			      "</td>\n" .
 			      "</tr>";
 		} else {
@@ -1033,7 +1037,8 @@
 				print $cgi->a({-href => "$my_uri?p=$project;a=$tag{'reftype'};h=$tag{'refid'}"}, $tag{'reftype'});
 				if ($tag{'reftype'} eq "commit") {
 				      print " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$tag{'name'}"}, "shortlog") .
-				            " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$tag{'refid'}"}, "log");
+				            " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$tag{'refid'}"}, "log") .
+				            " | " . $cgi->a({-href => "$snapshots_url?tree=$project&commit=$tag{'refid'}"}, "snapshot");
 				}
 				print "</td>\n" .
 				      "</tr>";
@@ -1172,7 +1177,8 @@
 			print $cgi->a({-href => "$my_uri?p=$project;a=$tag{'reftype'};h=$tag{'refid'}"}, $tag{'reftype'});
 			if ($tag{'reftype'} eq "commit") {
 			      print " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$tag{'name'}"}, "shortlog") .
-			            " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$tag{'refid'}"}, "log");
+			            " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$tag{'refid'}"}, "log") .
+			            " | " . $cgi->a({-href => "$snapshots_url?tree=$project&commit=$tag{'refid'}"}, "snapshot");
 			}
 			print "</td>\n" .
 			      "</tr>";
@@ -1545,6 +1551,7 @@
 		      "<div class=\"log_link\">\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$commit"}, "commitdiff") .
+		      " | " . $cgi->a({-href => "$snapshots_url?tree=$project&commit=$commit"}, "snapshot") .
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . escapeHTML($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
@@ -1646,6 +1653,8 @@
 		      "</td>" .
 		      "</tr>\n";
 	}
+	print "<tr><td>snapshot</td>".
+	      "<td><a href=\"$snapshots_url?tree=$project&commit=$hash\">$hash</a></td></tr>";
 	print "</table>". 
 	      "</div>\n";
 	print "<div class=\"page_body\">\n";
@@ -2234,6 +2243,7 @@
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$commit"}, "commitdiff") .
+		      " | " . $cgi->a({-href => "$snapshots_url?tree=$project&commit=$commit"}, "snapshot") .
 		      "</td>\n" .
 		      "</tr>";
 	}

--------------050603010106020903090507
Content-Type: application/x-cgi;
 name="snapshot.cgi"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="snapshot.cgi"

IyEvdXNyL2Jpbi9weXRob24KIyBzbmFwc2hvdC5jZ2kgLSBzaW1wbGUgcHl0aG9uIENHSSBz
Y3JpcHQgdG8gZ2VuZXJhdGUgZ2l0IHNuYXBzaG90cwojIChDKSAyMDA1LCBTaGFtIENodWtv
dXJ5IDxlbGV1c2lzQHhtbXMub3JnPgojIChDKSAyMDA1LCBYTU1TMiBkZXZlbG9wbWVudCB0
ZWFtIChodHRwOi8veG1tczIueG1tcy5vcmcpCiMgVGhpcyBwcm9ncmFtIGlzIGxpY2Vuc2Vk
IHVuZGVyIHRoZSBHUEwgdjIKCmltcG9ydCBzeXMKaW1wb3J0IG9zCmltcG9ydCBjZ2kKaW1w
b3J0IHRpbWUKaW1wb3J0IGJ6MgoKZ2l0X2Jpbl9kaXIgPSAiL3Vzci9sb2NhbC9iaW4iCmdp
dF9iYXNlX2RpciA9ICIvdmFyL2NhY2hlL2dpdCIKc25hcHNob3RfZGlyID0gIi92YXIvd3d3
L2dpdC9zbmFwc2hvdHMiCnNuYXBzaG90c191cmwgPSAiaHR0cDovL2dpdC54bW1zLnNlLyIK
CmRlZiByZWRpcmVjdCh1cmwpOgogICAgICAgIHByaW50ICJMb2NhdGlvbjogJXNcbiIgJSB1
cmwKCmRlZiBzZW5kX3RleHQobXNnKToKICAgICAgICBwcmludCAiQ29udGVudC1UeXBlOiB0
ZXh0L3BsYWluXG4iCiAgICAgICAgcHJpbnQgbXNnCgpjbGFzcyBTbmFwc2hvdDoKICAgICAg
ICBkZWYgX19pbml0X18oc2VsZiwgZ2l0X2RpciwgdHJlZW5hbWUsIGNvbW1pdElEKToKICAg
ICAgICAgICAgICAgIHNlbGYuZ2l0X2RpciA9IGdpdF9kaXIKICAgICAgICAgICAgICAgIHNl
bGYudHJlZW5hbWUgPSB0cmVlbmFtZQogICAgICAgICAgICAgICAgc2VsZi5kaXIgPSBvcy5w
YXRoLmpvaW4oc25hcHNob3RfZGlyLCB0cmVlbmFtZSkKCiAgICAgICAgICAgICAgICBpZiAo
Y29tbWl0SUQgPT0gIkhFQUQiKToKICAgICAgICAgICAgICAgICAgICAgICAgc2VsZi5jb21t
aXRJRCA9IGZpbGUoIiVzL0hFQUQiICUgZ2l0X2RpcikucmVhZCgpLnJzdHJpcCgpCiAgICAg
ICAgICAgICAgICBlbHNlOgogICAgICAgICAgICAgICAgICAgICAgICBzZWxmLmNvbW1pdElE
ID0gY29tbWl0SUQKCiAgICAgICAgICAgICAgICAjIHJlYWQgY29tbWl0IGRhdGEKICAgICAg
ICAgICAgICAgIG9zLnB1dGVudigiR0lUX09CSkVDVF9ESVJFQ1RPUlkiLCAiJXMvb2JqZWN0
cyIgJSBnaXRfZGlyKQogICAgICAgICAgICAgICAgZiA9IG9zLnBvcGVuKCIlcyBjb21taXQg
JXMiICUgKAogICAgICAgICAgICAgICAgb3MucGF0aC5qb2luKGdpdF9iaW5fZGlyLCAiZ2l0
LWNhdC1maWxlIiksIHNlbGYuY29tbWl0SUQpKQogICAgICAgICAgICAgICAgc2VsZi50cmVl
ID0gZi5yZWFkbGluZSgpLnJzdHJpcCgpLnNwbGl0KCIgIilbLTFdCiAgICAgICAgICAgICAg
ICBmLnJlYWRsaW5lKCkgIyBwYXJlbnQKICAgICAgICAgICAgICAgIGYucmVhZGxpbmUoKSAj
IGF1dGhvcgogICAgICAgICAgICAgICAgY29tbWl0ID0gZi5yZWFkbGluZSgpLnJzdHJpcCgp
CgogICAgICAgICAgICAgICAgIyBwYXJzZSBjb21taXR0ZXIgZmllbGQsIGdlbmVyYXRlIHNu
YXBzaG90IG5hbWUKICAgICAgICAgICAgICAgIGNvbW1pdHRpbWUgPSBpbnQoY29tbWl0LnNw
bGl0KCIgIilbLTJdKQogICAgICAgICAgICAgICAgc2VsZi5uYW1lID0gIiVzLXNuYXBzaG90
LSVzIiAlICh0cmVlbmFtZSwgdGltZS5zdHJmdGltZSgiJVklbSVkJUglTSIsdGltZS5sb2Nh
bHRpbWUoY29tbWl0dGltZSkpKQogICAgICAgICAgICAgICAgc2VsZi5maWxlcGF0aCA9ICIl
cy8lcy50YXIuYnoyIiAlIChzZWxmLmRpciwgc2VsZi5uYW1lKQoKICAgICAgICAjIGNoZWNr
IHdoZXRoZXIgc25hcHNob3QgZGlyIGV4aXN0cywgb3IgY3JlYXRlIGl0CiAgICAgICAgZGVm
IGNoZWNrX2RpcihzZWxmKToKICAgICAgICAgICAgICAgIGlmIG5vdCBvcy5hY2Nlc3MoIiVz
LyIgJSBzZWxmLmRpciwgb3MuRl9PSyk6CiAgICAgICAgICAgICAgICAgICAgICAgIG9zLm1r
ZGlyKCIlcy8iICUgc2VsZi5kaXIpCgogICAgICAgICMgY2hlY2sgd2hldGhlciBzbmFwc2hv
dCBmaWxlIGV4aXN0cywgb3IgYnVpbGQgaXQKICAgICAgICBkZWYgYnVpbGQoc2VsZik6CiAg
ICAgICAgICAgICAgICBzZWxmLmNoZWNrX2RpcigpCiAgICAgICAgICAgICAgICBpZiBub3Qg
b3MuYWNjZXNzKHNlbGYuZmlsZXBhdGgsIG9zLkZfT0spOgogICAgICAgICAgICAgICAgICAg
ICAgICAjIHRvZG86IHRyYXAgcG9zc2libGUgZXJyb3JzIGhlcmUKICAgICAgICAgICAgICAg
ICAgICAgICAgb3Muc3lzdGVtKCIlcyAlcyAlcyB8IGJ6aXAyID4gJXMiICUgKAogICAgICAg
ICAgICAgICAgICAgICAgICBvcy5wYXRoLmpvaW4oZ2l0X2Jpbl9kaXIsICJnaXQtdGFyLXRy
ZWUiKSwKICAgICAgICAgICAgICAgICAgICAgICAgc2VsZi50cmVlLCBzZWxmLm5hbWUsIHNl
bGYuZmlsZXBhdGgpKQogICAgICAgICAgICAgICAgICAgICAgICBmaWxlKCIlcy8uaHRhY2Nl
c3MiICUgc2VsZi5kaXIsImEiKS53cml0ZSgnQWRkRGVzY3JpcHRpb24gIiVzIGdpdCBzbmFw
c2hvdCAoJXMpIiAlcy50YXIuYnoyXG4nICUgKHNlbGYudHJlZW5hbWUsIHNlbGYuY29tbWl0
SUQsIHNlbGYubmFtZSkpIAoKICAgICAgICAjIG9wZW4gc25hcHNob3QgZmlsZQogICAgICAg
IGRlZiBnZXRfZmlsZShzZWxmKToKICAgICAgICAgICAgICAgIHRyeToKICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0RmlsZSA9IGZpbGUoc2VsZi5maWxlcGF0aCwgInIiKSwgc2VsZi5u
YW1lICsgIi50YXIuYnoyIgogICAgICAgICAgICAgICAgZXhjZXB0IElPRXJyb3I6CiAgICAg
ICAgICAgICAgICAgICAgICAgIHJldEZpbGUgPSBOb25lLCBOb25lCiAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0RmlsZQoKICAgICAgICBkZWYgc2VuZF9iaGVhZGVycyhzZWxmLCBmaWxl
bmFtZSA9IE5vbmUsIHNpemUgPSBOb25lLCBsYXN0bW9kID0gTm9uZSk6CiAgICAgICAgICAg
ICAgICBpZiBmaWxlbmFtZSBpcyBOb25lOgogICAgICAgICAgICAgICAgICAgICAgICBmaWxl
bmFtZSA9IHNlbGYubmFtZSArICIudGFyLmJ6MiIKICAgICAgICAgICAgICAgIHNpemVzdHIg
PSAiIgogICAgICAgICAgICAgICAgaWYgc2l6ZSBpcyBub3QgTm9uZToKICAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZXN0ciA9ICI7IHNpemU9JWkiICUgc2l6ZQogICAgICAgICAgICAg
ICAgcHJpbnQgIkNvbnRlbnQtVHlwZTogYXBwbGljYXRpb24veC1iemlwMiIKICAgICAgICAg
ICAgICAgIHByaW50ICJDb250ZW50LUVuY29kaW5nOiB4LWJ6aXAyIgogICAgICAgICAgICAg
ICAgcHJpbnQgIkNvbnRlbnQtRGlzcG9zaXRpb246IGlubGluZTsgZmlsZW5hbWU9JXMlcyIg
JSAoCiAgICAgICAgICAgICAgICBmaWxlbmFtZSwgc2l6ZXN0cikKICAgICAgICAgICAgICAg
IHByaW50ICJBY2NlcHQtUmFuZ2VzOiBub25lIgogICAgICAgICAgICAgICAgaWYgc2l6ZSBp
cyBub3QgTm9uZToKICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnQgIkNvbnRlbnQtTGVu
Z3RoOiAlaSIgJSBzaXplCiAgICAgICAgICAgICAgICBpZiBsYXN0bW9kIGlzIG5vdCBOb25l
OgogICAgICAgICAgICAgICAgICAgICAgICBwcmludCAiTGFzdC1Nb2RpZmllZDogJXMiICUg
KAogICAgICAgICAgICAgICAgICAgICAgICB0aW1lLnN0cmZ0aW1lKCIlYSwgJWQgJWIgJVkg
JUg6JU06JVMgR01UIiwgdGltZS5nbXRpbWUobGFzdG1vZCkpKQogICAgICAgICAgICAgICAg
cHJpbnQgIiIKCiAgICAgICAgIyBzZW5kIHByZS1tYWRlIHRhcmJhbGwgKHNlbGYuYnVpbGQs
IG9yIG90aGVyd2lzZSkKICAgICAgICBkZWYgc2VuZF9iaW5hcnkoc2VsZik6CiAgICAgICAg
ICAgICAgICBiZmlsZSwgZmlsZW5hbWUgPSBzZWxmLmdldF9maWxlKCkKICAgICAgICAgICAg
ICAgIGlmIGJmaWxlIGlzIE5vbmU6CiAgICAgICAgICAgICAgICAgICAgICAgIHNlbmRfdGV4
dCgiU29ycnksIGNvdWxkIG5vdCBwcm92aWRlIHNuYXBzaG90IGZvciB0cmVlICVzLCBjb21t
aXQgJXMiICUgKHNlbGYudHJlZW5hbWUsIGNvbW1pdElEKSkKICAgICAgICAgICAgICAgIGVs
c2U6CiAgICAgICAgICAgICAgICAgICAgICAgIHNlbGYuc2VuZF9iaGVhZGVycyhzaXplPW9z
LnN0YXQoc2VsZi5maWxlcGF0aClbNl0sCiAgICAgICAgICAgICAgICAgICAgICAgIGxhc3Rt
b2QgPSBvcy5zdGF0KHNlbGYuZmlsZXBhdGgpWzhdKQogICAgICAgICAgICAgICAgICAgICAg
ICBmb3IgbGluZSBpbiBiZmlsZToKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
eXMuc3Rkb3V0LndyaXRlKGxpbmUpCiAgICAgICAgICAgICAgICAgICAgICAgIGJmaWxlLmNs
b3NlKCkKCiAgICAgICAgIyBtYWtlIHNuYXBzaG90IHRhcmJhbGwgYW5kIHNlbmQsIG9uIHRo
ZSBmbHkKICAgICAgICBkZWYgb25fdGhlX2ZseShzZWxmKToKICAgICAgICAgICAgICAgIGRl
ZiBjYWNoZV9jaHVua19zZW5kKGNodW5rLCBjZmlsZSk6CiAgICAgICAgICAgICAgICAgICAg
ICAgIGNmaWxlLndyaXRlKGNodW5rKQogICAgICAgICAgICAgICAgICAgICAgICBzeXMuc3Rk
b3V0LndyaXRlKGNodW5rKQoKICAgICAgICAgICAgICAgICMgdHJ5IHRvIGdldCBmaWxlIGZy
b20gZGlzayBpZiBpdCBleGlzdHMsIGZpcnN0CiAgICAgICAgICAgICAgICBpZiBvcy5hY2Nl
c3Moc2VsZi5maWxlcGF0aCwgb3MuRl9PSyk6CiAgICAgICAgICAgICAgICAgICAgICAgIHNl
bGYuc2VuZF9iaW5hcnkoKQogICAgICAgICAgICAgICAgZWxzZToKICAgICAgICAgICAgICAg
ICAgICAgICAgc2VsZi5jaGVja19kaXIoKQogICAgICAgICAgICAgICAgICAgICAgICBjYWNo
ZWZpbGUgPSBmaWxlKHNlbGYuZmlsZXBhdGgsICJ3IikKICAgICAgICAgICAgICAgICAgICAg
ICAgdGFyID0gb3MucG9wZW4oIiVzICVzICVzIiAlICgKICAgICAgICAgICAgICAgICAgICAg
ICAgb3MucGF0aC5qb2luKGdpdF9iaW5fZGlyLCAiZ2l0LXRhci10cmVlIiksCiAgICAgICAg
ICAgICAgICAgICAgICAgIHNlbGYudHJlZSwgc2VsZi5uYW1lKSkKCiAgICAgICAgICAgICAg
ICAgICAgICAgIGtvbXByZXNzb3IgPSBiejIuQloyQ29tcHJlc3NvcigpCiAgICAgICAgICAg
ICAgICAgICAgICAgIHNlbGYuc2VuZF9iaGVhZGVycygpCiAgICAgICAgICAgICAgICAgICAg
ICAgIGZvciBsaW5lIGluIHRhcjoKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
YWNoZV9jaHVua19zZW5kKGtvbXByZXNzb3IuY29tcHJlc3MobGluZSksCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2FjaGVmaWxlKQogICAgICAgICAgICAgICAgICAgICAg
ICBjYWNoZV9jaHVua19zZW5kKGtvbXByZXNzb3IuZmx1c2goKSwgY2FjaGVmaWxlKQogICAg
ICAgICAgICAgICAgICAgICAgICBjYWNoZWZpbGUuY2xvc2UoKQogICAgICAgICAgICAgICAg
ICAgICAgICB0YXIuY2xvc2UoKQoKaWYgbm90IG9zLmFjY2VzcyhzbmFwc2hvdF9kaXIsIG9z
LkZfT0spOgogICAgICAgIHRyeToKICAgICAgICAgICAgICAgIG9zLm1rZGlyKHNuYXBzaG90
X2RpcikKICAgICAgICBleGNlcHQgT1NFcnJvcjoKICAgICAgICAgICAgICAgIHBhc3MKCmRl
ZiB2YWxpZF9oYXNoKGhhc2gpOgogICAgICAgIHJldFZhbCA9IFRydWUKCiAgICAgICAgaWYg
aGFzaCAhPSAiSEVBRCI6CiAgICAgICAgICAgICAgICBpZiBsZW4oaGFzaCkgIT0gNDA6CiAg
ICAgICAgICAgICAgICAgICAgICAgIHJldFZhbCA9IEZhbHNlCiAgICAgICAgICAgICAgICBm
b3IgY2hhciBpbiBoYXNoOgogICAgICAgICAgICAgICAgICAgICAgICBpZiBjaGFyIG5vdCBp
biAiMDEyMzQ1Njc4OWFiY2RlZiI6CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0VmFsID0gRmFsc2UKICAgICAgICByZXR1cm4gcmV0VmFsCgpmcyA9IGNnaS5GaWVsZFN0
b3JhZ2UoKQppZiAoZnMuaGFzX2tleSgidHJlZSIpIGFuZCBmcy5oYXNfa2V5KCJjb21taXQi
KSk6CiAgICAgICAgdHJlZSA9IGZzWyJ0cmVlIl0udmFsdWUKICAgICAgICBjb21taXQgPSBm
c1siY29tbWl0Il0udmFsdWUKCiAgICAgICAgIyB2YWxpZGF0ZSB0cmVlIG5hbWUKICAgICAg
ICBpZiBub3Qgb3MuYWNjZXNzKG9zLnBhdGguam9pbihnaXRfYmFzZV9kaXIsIHRyZWUpLCBv
cy5GX09LKToKICAgICAgICAgICAgICAgIHNlbmRfdGV4dCgiTm8gc3VjaCB0cmVlOiAlcyIg
JSB0cmVlKQogICAgICAgICAgICAgICAgc3lzLmV4aXQoKQoKICAgICAgICAjIHZhbGlkYXRl
IGNvbW1pdCBoYXNoCiAgICAgICAgaWYgbm90IHZhbGlkX2hhc2goY29tbWl0KToKICAgICAg
ICAgICAgICAgIHNlbmRfdGV4dCgiSW52YWxpZCBoYXNoOiAlcyIgJSBjb21taXQpCiAgICAg
ICAgICAgICAgICBzeXMuZXhpdCgpCgogICAgICAgIHNuYXAgPSBTbmFwc2hvdChvcy5wYXRo
LmpvaW4oZ2l0X2Jhc2VfZGlyLCB0cmVlKSwgdHJlZSwgY29tbWl0KQogICAgICAgIHNuYXAu
YnVpbGQoKQogICAgICAgIHNuYXAuc2VuZF9iaW5hcnkoKQogICAgICAgICNzbmFwLm9uX3Ro
ZV9mbHkoKQoKZWxzZToKICAgICAgICAjIHVzZXIgcmVxdWVzdGVkIHVybCBkaXJlY3RseSwg
d2l0aG91dCBhIGNvbW1pdCBoYXNoCiAgICAgICAgIyByZWRpcmVjdCB0byBzbmFwc2hvdHMg
ZGlyCiAgICAgICAgcmVkaXJlY3Qoc25hcHNob3RzX3VybCkK
--------------050603010106020903090507--
