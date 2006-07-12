From: Alp Toker <alp@atoker.com>
Subject: [PATCH] gitweb: Make command invocations go through the git wrapper
Date: Wed, 12 Jul 2006 23:55:10 +0100
Message-ID: <11527449102604-git-send-email-alp@atoker.com>
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 13 00:55:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0ncC-00014h-Sk
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 00:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWGLWzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 18:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWGLWzT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 18:55:19 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:34564 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S932414AbWGLWzR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 18:55:17 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id DA5771576AD; Wed, 12 Jul 2006 23:55:10 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g2fca1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23803>

This patch makes invocations of core git commands go through the 'git'
binary itself, which improves readability and might help system
administrators lock down their CGI environment for security.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 gitweb/gitweb.cgi |   62 +++++++++++++++++++++++++----------------------------
 1 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 3d9fa44..2fd1e5f 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -22,20 +22,16 @@ our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 our $rss_link = "";
 
-# location of the git-core binaries
-our $gitbin = "/usr/bin";
+# core git executable to use
+# this can just be "git" if your webserver has a sensible PATH
+our $GIT = "/usr/bin/git";
 
 # absolute fs-path which will be prepended to the project path
 #our $projectroot = "/pub/scm";
 our $projectroot = "/home/kay/public_html/pub/scm";
 
-# version of the git-core binaries
-our $git_version = qx($gitbin/git --version);
-if ($git_version =~ m/git version (.*)$/) {
-	$git_version = $1;
-} else {
-	$git_version = "unknown";
-}
+# version of the core git binary
+our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
 # location for temporary files needed for diffs
 our $git_temp = "/tmp/gitweb";
@@ -392,7 +388,7 @@ sub die_error {
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", "$gitbin/git-cat-file -t $hash" or return;
+	open my $fd, "-|", "$GIT cat-file -t $hash" or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -404,7 +400,7 @@ sub git_read_head {
 	my $oENV = $ENV{'GIT_DIR'};
 	my $retval = undef;
 	$ENV{'GIT_DIR'} = "$projectroot/$project";
-	if (open my $fd, "-|", "$gitbin/git-rev-parse", "--verify", "HEAD") {
+	if (open my $fd, "-|", $GIT, "rev-parse", "--verify", "HEAD") {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
@@ -444,7 +440,7 @@ sub git_read_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", "$gitbin/git-cat-file tag $tag_id" or return;
+	open my $fd, "-|", "$GIT cat-file tag $tag_id" or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -516,7 +512,7 @@ sub git_read_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", "$gitbin/git-rev-list --header --parents --max-count=1 $commit_id" or return;
+		open my $fd, "-|", "$GIT rev-list --header --parents --max-count=1 $commit_id" or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
 		$/ = "\n";
@@ -614,7 +610,7 @@ sub git_diff_print {
 	if (defined $from) {
 		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
 		open my $fd2, "> $from_tmp";
-		open my $fd, "-|", "$gitbin/git-cat-file blob $from";
+		open my $fd, "-|", "$GIT cat-file blob $from";
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -625,7 +621,7 @@ sub git_diff_print {
 	if (defined $to) {
 		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
 		open my $fd2, "> $to_tmp";
-		open my $fd, "-|", "$gitbin/git-cat-file blob $to";
+		open my $fd, "-|", "$GIT cat-file blob $to";
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -844,7 +840,7 @@ sub git_get_project_config {
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my $val = qx($gitbin/git-repo-config --get gitweb.$key);
+	my $val = qx($GIT repo-config --get gitweb.$key);
 	return ($val);
 }
 
@@ -1066,7 +1062,7 @@ sub git_summary {
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 	print "<div>\n" .
@@ -1254,7 +1250,7 @@ sub git_blame {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(undef, "Error lookup file.");
 	}
-	open ($fd, "-|", "$gitbin/git-annotate", '-l', '-t', '-r', $file_name, $hash_base)
+	open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
 		or die_error(undef, "Open failed.");
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
@@ -1449,7 +1445,7 @@ sub git_get_hash_by_path {
 	my $tree = $base;
 	my @parts = split '/', $path;
 	while (my $part = shift @parts) {
-		open my $fd, "-|", "$gitbin/git-ls-tree $tree" or die_error(undef, "Open git-ls-tree failed.");
+		open my $fd, "-|", "$GIT ls-tree $tree" or die_error(undef, "Open git-ls-tree failed.");
 		my (@entries) = map { chomp; $_ } <$fd>;
 		close $fd or return undef;
 		foreach my $line (@entries) {
@@ -1536,7 +1532,7 @@ sub git_blob_plain_mimetype {
 
 sub git_blob_plain {
 	my $type = shift;
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error("Couldn't cat $file_name, $hash");
+	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error("Couldn't cat $file_name, $hash");
 
 	$type ||= git_blob_plain_mimetype($fd, $file_name);
 
@@ -1563,7 +1559,7 @@ sub git_blob {
 		$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
 	}
 	my $have_blame = git_get_project_config_bool ('blame');
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error(undef, "Open failed.");
 	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
 		close $fd;
@@ -1629,7 +1625,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", "$gitbin/git-ls-tree -z $hash" or die_error(undef, "Open git-ls-tree failed.");
+	open my $fd, "-|", "$GIT ls-tree -z $hash" or die_error(undef, "Open git-ls-tree failed.");
 	chomp (my (@entries) = <$fd>);
 	close $fd or die_error(undef, "Reading tree failed.");
 	$/ = "\n";
@@ -1712,7 +1708,7 @@ #			      " | " . $cgi->a({-href => "$my
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
@@ -1732,7 +1728,7 @@ sub git_rss {
 			last;
 		}
 		my %cd = date_str($co{'committer_epoch'});
-		open $fd, "-|", "$gitbin/git-diff-tree -r $co{'parent'} $co{'id'}" or next;
+		open $fd, "-|", "$GIT diff-tree -r $co{'parent'} $co{'id'}" or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd or next;
 		print "<item>\n" .
@@ -1820,7 +1816,7 @@ sub git_log {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
@@ -1911,7 +1907,7 @@ sub git_commit {
 		$root = " --root";
 		$parent = "";
 	}
-	open my $fd, "-|", "$gitbin/git-diff-tree -r -M $root $parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT diff-tree -r -M $root $parent $hash" or die_error(undef, "Open failed.");
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2153,7 +2149,7 @@ sub git_commitdiff {
 	if (!defined $hash_parent) {
 		$hash_parent = $co{'parent'};
 	}
-	open my $fd, "-|", "$gitbin/git-diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2243,14 +2239,14 @@ sub git_commitdiff {
 
 sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
-	open my $fd, "-|", "$gitbin/git-diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	# try to figure out the next tag after this commit
 	my $tagname;
 	my $refs = read_info_ref("tags");
-	open $fd, "-|", "$gitbin/git-rev-list HEAD";
+	open $fd, "-|", "$GIT rev-list HEAD";
 	chomp (my (@commits) = <$fd>);
 	close $fd;
 	foreach my $commit (@commits) {
@@ -2321,7 +2317,7 @@ sub git_history {
 	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
 
 	open my $fd, "-|",
-		"$gitbin/git-rev-list --full-history $hash -- \'$file_name\'";
+		"$GIT rev-list --full-history $hash -- \'$file_name\'";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
@@ -2408,7 +2404,7 @@ sub git_search {
 	my $alternate = 0;
 	if ($commit_search) {
 		$/ = "\0";
-		open my $fd, "-|", "$gitbin/git-rev-list --header --parents $hash" or next;
+		open my $fd, "-|", "$GIT rev-list --header --parents $hash" or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -2458,7 +2454,7 @@ sub git_search {
 
 	if ($pickaxe_search) {
 		$/ = "\n";
-		open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin -S\'$searchtext\'";
+		open my $fd, "-|", "$GIT rev-list $hash | $GIT diff-tree -r --stdin -S\'$searchtext\'";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
@@ -2529,7 +2525,7 @@ sub git_shortlog {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
-- 
1.4.1.g2fca1
