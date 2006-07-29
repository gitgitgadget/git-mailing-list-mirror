From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2] gitweb: Use list for of open for running git commands, thorougly.
Date: Sat, 29 Jul 2006 22:51:17 +0200
Message-ID: <200607292251.21072.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 29 22:51:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6vmO-0007HV-Hy
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 22:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWG2UvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 16:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWG2UvM
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 16:51:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:47767 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932231AbWG2UvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 16:51:11 -0400
Received: by ug-out-1314.google.com with SMTP id m3so207390ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 13:51:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TNJAyAE2y1C/ZZPpbpywipUeHmBMu/XQs+d+dR18FjMiGXPCoGMmMWP/TVcIzEfcdizUQabfw/gtYguIKjcTxjWvjLup5n72GGZuvbTduVwPdl/LvJmS145aS7aTqndT9Rweb/9V7tcme/umYeOM3BUD6IuKuluSfRtbIaX7dNY=
Received: by 10.67.100.17 with SMTP id c17mr979918ugm;
        Sat, 29 Jul 2006 13:51:09 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k30sm3472987ugc.2006.07.29.13.51.08;
        Sat, 29 Jul 2006 13:51:09 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24434>

Use list form of open for running git commands and reading their
output through pipe, for example
  open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", $hash
instead of
  open my $fd, "-|", "$GIT rev-list --header --parents $hash"
Single letter options use ' instead of " as quotes, according to style
used in list form of magic "-|" open.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The correct solution would be to use safe_pipe_capture or, 
what's better, use Git.pm, when it will be in released version.

Should have no impact on speed. Using ' instead of " could bring
insignificant speedup.

 gitweb/gitweb.cgi |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index f92eeab..9a17f87 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -388,7 +388,7 @@ sub die_error {
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", "$GIT cat-file -t $hash" or return;
+	open my $fd, "-|", $GIT, "cat-file", '-t', $hash or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -440,7 +440,7 @@ sub git_read_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", "$GIT cat-file tag $tag_id" or return;
+	open my $fd, "-|", $GIT, "cat-file", "tag", $tag_id or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -512,7 +512,7 @@ sub git_read_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", "$GIT rev-list --header --parents --max-count=1 $commit_id" or return;
+		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", "--max-count=1", $commit_id or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
 		$/ = "\n";
@@ -610,7 +610,7 @@ sub git_diff_print {
 	if (defined $from) {
 		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
 		open my $fd2, "> $from_tmp";
-		open my $fd, "-|", "$GIT cat-file blob $from";
+		open my $fd, "-|", $GIT, "cat-file", "blob", $from;
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -621,7 +621,7 @@ sub git_diff_print {
 	if (defined $to) {
 		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
 		open my $fd2, "> $to_tmp";
-		open my $fd, "-|", "$GIT cat-file blob $to";
+		open my $fd, "-|", $GIT, "cat-file", "blob", $to;
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -1062,7 +1062,8 @@ sub git_summary {
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
-	open my $fd, "-|", "$GIT rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project) 
+		or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 	print "<div>\n" .
@@ -1526,7 +1527,7 @@ sub git_get_hash_by_path {
 	my $tree = $base;
 	my @parts = split '/', $path;
 	while (my $part = shift @parts) {
-		open my $fd, "-|", "$GIT ls-tree $tree" or die_error(undef, "Open git-ls-tree failed.");
+		open my $fd, "-|", $GIT, "ls-tree", $tree or die_error(undef, "Open git-ls-tree failed.");
 		my (@entries) = map { chomp; $_ } <$fd>;
 		close $fd or return undef;
 		foreach my $line (@entries) {
@@ -1622,7 +1623,7 @@ sub git_blob_plain {
 		}
 	}
 	my $type = shift;
-	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error("Couldn't cat $file_name, $hash");
+	open my $fd, "-|", $GIT, "cat-file", "blob", $hash or die_error("Couldn't cat $file_name, $hash");
 
 	$type ||= git_blob_plain_mimetype($fd, $file_name);
 
@@ -1654,7 +1655,7 @@ sub git_blob {
 		}
 	}
 	my $have_blame = git_get_project_config_bool ('blame');
-	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "cat-file", "blob", $hash or die_error(undef, "Open failed.");
 	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
 		close $fd;
@@ -1718,7 +1719,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", "$GIT ls-tree -z $hash" or die_error(undef, "Open git-ls-tree failed.");
+	open my $fd, "-|", $GIT, "ls-tree", '-z', $hash or die_error(undef, "Open git-ls-tree failed.");
 	chomp (my (@entries) = <$fd>);
 	close $fd or die_error(undef, "Reading tree failed.");
 	$/ = "\n";
@@ -1799,7 +1800,8 @@ #			      " | " . $cgi->a({-href => "$my
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", "$GIT rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project) 
+		or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
@@ -1819,7 +1821,7 @@ sub git_rss {
 			last;
 		}
 		my %cd = date_str($co{'committer_epoch'});
-		open $fd, "-|", "$GIT diff-tree -r $co{'parent'} $co{'id'}" or next;
+		open $fd, "-|", $GIT, "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd or next;
 		print "<item>\n" .
@@ -1907,7 +1909,7 @@ sub git_log {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$GIT rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "rev-list", $limit, $hash or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
@@ -1998,7 +2000,8 @@ sub git_commit {
 		$root = " --root";
 		$parent = "";
 	}
-	open my $fd, "-|", "$GIT diff-tree -r -M $root $parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $root, $parent, $hash 
+		or die_error(undef, "Open failed.");
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2244,7 +2247,8 @@ sub git_commitdiff {
 	if (!defined $hash_parent) {
 		$hash_parent = $co{'parent'};
 	}
-	open my $fd, "-|", "$GIT diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
+		or die_error(undef, "Open failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2334,14 +2338,15 @@ sub git_commitdiff {
 
 sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
-	open my $fd, "-|", "$GIT diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash 
+		or die_error(undef, "Open failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	# try to figure out the next tag after this commit
 	my $tagname;
 	my $refs = read_info_ref("tags");
-	open $fd, "-|", "$GIT rev-list HEAD";
+	open $fd, "-|", $GIT, "rev-list", "HEAD";
 	chomp (my (@commits) = <$fd>);
 	close $fd;
 	foreach my $commit (@commits) {
@@ -2419,7 +2424,7 @@ sub git_history {
 	git_print_page_path($file_name, $ftype);
 
 	open my $fd, "-|",
-		"$GIT rev-list --full-history $hash_base -- \'$file_name\'";
+		$GIT, "rev-list", "--full-history", $hash_base, "--", "\'$file_name\'";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
@@ -2506,7 +2511,7 @@ sub git_search {
 	my $alternate = 0;
 	if ($commit_search) {
 		$/ = "\0";
-		open my $fd, "-|", "$GIT rev-list --header --parents $hash" or next;
+		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", $hash or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -2627,7 +2632,7 @@ sub git_shortlog {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$GIT rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "rev-list", $limit, $hash or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
-- 
1.4.0
