From: Alp Toker <alp@atoker.com>
Subject: [PATCH] gitweb: Use the git binary in the search path by default
Date: Tue, 11 Jul 2006 11:19:36 +0100
Message-ID: <11526131791902-git-send-email-alp@atoker.com>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com>
X-From: git-owner@vger.kernel.org Tue Jul 11 12:20:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0FLU-0003jo-Jk
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 12:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWGKKT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 06:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWGKKT4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 06:19:56 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:12051 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1750947AbWGKKTz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 06:19:55 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 20DB41645F1; Tue, 11 Jul 2006 11:19:39 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g97c7-dirty
In-Reply-To: <1152613179634-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23703>

Introduce a sensible default for the location of the git binary used by
gitweb. This means one less option to configure when deploying gitweb if
git is in the search path.

This patch also makes invocations of core git commands go through the
'git' binary itself, which might help system administrators lock down
their CGI environment for security.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 gitweb/gitweb.cgi |   61 ++++++++++++++++++++++++-----------------------------
 1 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index b12417b..0bb46b9 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -22,20 +22,15 @@ our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 our $rss_link = "";
 
-# location of the git-core binaries
-our $gitbin = "/usr/bin";
+# core git binary to use, optionally specified as an absolute path
+our $GIT = "git";
 
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
@@ -391,7 +386,7 @@ sub die_error {
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", "$gitbin/git-cat-file -t $hash" or return;
+	open my $fd, "-|", "$GIT cat-file -t $hash" or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -403,7 +398,7 @@ sub git_read_head {
 	my $oENV = $ENV{'GIT_DIR'};
 	my $retval = undef;
 	$ENV{'GIT_DIR'} = "$projectroot/$project";
-	if (open my $fd, "-|", "$gitbin/git-rev-parse", "--verify", "HEAD") {
+	if (open my $fd, "-|", $GIT, "rev-parse", "--verify", "HEAD") {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
@@ -443,7 +438,7 @@ sub git_read_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", "$gitbin/git-cat-file tag $tag_id" or return;
+	open my $fd, "-|", "$GIT cat-file tag $tag_id" or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -515,7 +510,7 @@ sub git_read_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", "$gitbin/git-rev-list --header --parents --max-count=1 $commit_id" or return;
+		open my $fd, "-|", "$GIT rev-list --header --parents --max-count=1 $commit_id" or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
 		$/ = "\n";
@@ -613,7 +608,7 @@ sub git_diff_print {
 	if (defined $from) {
 		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
 		open my $fd2, "> $from_tmp";
-		open my $fd, "-|", "$gitbin/git-cat-file blob $from";
+		open my $fd, "-|", "$GIT cat-file blob $from";
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -624,7 +619,7 @@ sub git_diff_print {
 	if (defined $to) {
 		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
 		open my $fd2, "> $to_tmp";
-		open my $fd, "-|", "$gitbin/git-cat-file blob $to";
+		open my $fd, "-|", "$GIT cat-file blob $to";
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -843,7 +838,7 @@ sub git_get_project_config {
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my $val = qx($gitbin/git-repo-config --get gitweb.$key);
+	my $val = qx($GIT repo-config --get gitweb.$key);
 	return ($val);
 }
 
@@ -1065,7 +1060,7 @@ sub git_summary {
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 	print "<div>\n" .
@@ -1253,7 +1248,7 @@ sub git_blame {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(undef, "Error lookup file.");
 	}
-	open ($fd, "-|", "$gitbin/git-annotate", '-l', '-t', '-r', $file_name, $hash_base)
+	open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
 		or die_error(undef, "Open failed.");
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
@@ -1448,7 +1443,7 @@ sub git_get_hash_by_path {
 	my $tree = $base;
 	my @parts = split '/', $path;
 	while (my $part = shift @parts) {
-		open my $fd, "-|", "$gitbin/git-ls-tree $tree" or die_error(undef, "Open git-ls-tree failed.");
+		open my $fd, "-|", "$GIT ls-tree $tree" or die_error(undef, "Open git-ls-tree failed.");
 		my (@entries) = map { chomp; $_ } <$fd>;
 		close $fd or return undef;
 		foreach my $line (@entries) {
@@ -1535,7 +1530,7 @@ sub git_blob_plain_mimetype {
 
 sub git_blob_plain {
 	my $type = shift;
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error("Couldn't cat $file_name, $hash");
+	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error("Couldn't cat $file_name, $hash");
 
 	$type ||= git_blob_plain_mimetype($fd, $file_name);
 
@@ -1562,7 +1557,7 @@ sub git_blob {
 		$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
 	}
 	my $have_blame = git_get_project_config_bool ('blame');
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error(undef, "Open failed.");
 	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
 		close $fd;
@@ -1628,7 +1623,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", "$gitbin/git-ls-tree -z $hash" or die_error(undef, "Open git-ls-tree failed.");
+	open my $fd, "-|", "$GIT ls-tree -z $hash" or die_error(undef, "Open git-ls-tree failed.");
 	chomp (my (@entries) = <$fd>);
 	close $fd or die_error(undef, "Reading tree failed.");
 	$/ = "\n";
@@ -1711,7 +1706,7 @@ #			      " | " . $cgi->a({-href => "$my
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
@@ -1731,7 +1726,7 @@ sub git_rss {
 			last;
 		}
 		my %cd = date_str($co{'committer_epoch'});
-		open $fd, "-|", "$gitbin/git-diff-tree -r $co{'parent'} $co{'id'}" or next;
+		open $fd, "-|", "$GIT diff-tree -r $co{'parent'} $co{'id'}" or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd or next;
 		print "<item>\n" .
@@ -1819,7 +1814,7 @@ sub git_log {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
@@ -1910,7 +1905,7 @@ sub git_commit {
 		$root = " --root";
 		$parent = "";
 	}
-	open my $fd, "-|", "$gitbin/git-diff-tree -r -M $root $parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT diff-tree -r -M $root $parent $hash" or die_error(undef, "Open failed.");
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2152,7 +2147,7 @@ sub git_commitdiff {
 	if (!defined $hash_parent) {
 		$hash_parent = $co{'parent'};
 	}
-	open my $fd, "-|", "$gitbin/git-diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2242,14 +2237,14 @@ sub git_commitdiff {
 
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
@@ -2320,7 +2315,7 @@ sub git_history {
 	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
 
 	open my $fd, "-|",
-		"$gitbin/git-rev-list --full-history $hash -- \'$file_name\'";
+		"$GIT rev-list --full-history $hash -- \'$file_name\'";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
@@ -2407,7 +2402,7 @@ sub git_search {
 	my $alternate = 0;
 	if ($commit_search) {
 		$/ = "\0";
-		open my $fd, "-|", "$gitbin/git-rev-list --header --parents $hash" or next;
+		open my $fd, "-|", "$GIT rev-list --header --parents $hash" or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -2457,7 +2452,7 @@ sub git_search {
 
 	if ($pickaxe_search) {
 		$/ = "\n";
-		open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin -S\'$searchtext\'";
+		open my $fd, "-|", "$GIT rev-list $hash | $GIT diff-tree -r --stdin -S\'$searchtext\'";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
@@ -2528,7 +2523,7 @@ sub git_shortlog {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$GIT rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
-- 
1.4.1.g97c7-dirty
