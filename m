From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'}
Date: Thu, 24 Aug 2006 17:12:46 +0200
Message-ID: <20060824151246.G465d67c8@leonov.stosberg.net>
References: <eck6sq$agn$1@sea.gmane.org> <20060824140525.G638085b@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 17:12:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGGt3-0000jG-Kx
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 17:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWHXPMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 11:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWHXPMu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 11:12:50 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:60032 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S964958AbWHXPMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 11:12:49 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id 7AE6EF3B5F; Thu, 24 Aug 2006 17:12:46 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060824140525.G638085b@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25961>

This makes it possible to run gitweb under mod_perl's Apache::Registry.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
Gitweb has changed a lot since I last looked into it two months ago,
so this patch is a little different from the former one.  Only very
superficially tested, but seems to work well.

 gitweb/gitweb.perl |   73 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ae13e3e..73b3663 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -65,6 +65,9 @@ require $GITWEB_CONFIG if -e $GITWEB_CON
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
+# path to the current git repository
+our $git_dir;
+
 $projects_list ||= $projectroot;
 if (! -d $git_temp) {
 	mkdir($git_temp, 0700) || die_error(undef, "Couldn't mkdir $git_temp");
@@ -99,7 +102,7 @@ if (defined $project && $project) {
 	if (!(-e "$projectroot/$project/HEAD")) {
 		die_error(undef, "No such project");
 	}
-	$ENV{'GIT_DIR'} = "$projectroot/$project";
+	$git_dir = "$projectroot/$project";
 } else {
 	git_project_list();
 	exit;
@@ -375,21 +378,26 @@ sub git_get_referencing {
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
+# returns path to the core git executable and the --git-dir parameter
+sub git_cmd {
+    return $GIT, '--git-dir='.$git_dir;
+}
+
 # get HEAD ref of given project as hash
 sub git_read_head {
 	my $project = shift;
-	my $oENV = $ENV{'GIT_DIR'};
+	my $o_git_dir = $git_dir;
 	my $retval = undef;
-	$ENV{'GIT_DIR'} = "$projectroot/$project";
-	if (open my $fd, "-|", $GIT, "rev-parse", "--verify", "HEAD") {
+	$git_dir = "$projectroot/$project";
+	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
 			$retval = $1;
 		}
 	}
-	if (defined $oENV) {
-		$ENV{'GIT_DIR'} = $oENV;
+	if (defined $o_git_dir) {
+		$git_dir = $o_git_dir;
 	}
 	return $retval;
 }
@@ -398,7 +406,7 @@ # get type of given object
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", $GIT, "cat-file", '-t', $hash or return;
+	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -412,7 +420,8 @@ sub git_get_project_config {
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my $val = qx($GIT repo-config --get gitweb.$key);
+	my $git_command = join(' ', git_cmd());
+	my $val = qx($git_command repo-config --get gitweb.$key);
 	return ($val);
 }
 
@@ -431,7 +440,7 @@ sub git_get_hash_by_path {
 
 	my $tree = $base;
 
-	open my $fd, "-|", $GIT, "ls-tree", $base, "--", $path
+	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
 		or die_error(undef, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
@@ -566,7 +575,7 @@ sub git_read_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", $GIT, "cat-file", "tag", $tag_id or return;
+	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -607,7 +616,7 @@ sub git_read_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", "--max-count=1", $commit_id or return;
+		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", "--max-count=1", $commit_id or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
 		$/ = "\n";
@@ -1219,7 +1228,7 @@ sub git_diff_print {
 	if (defined $from) {
 		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
 		open my $fd2, "> $from_tmp";
-		open my $fd, "-|", $GIT, "cat-file", "blob", $from;
+		open my $fd, "-|", git_cmd(), "cat-file", "blob", $from;
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -1230,7 +1239,7 @@ sub git_diff_print {
 	if (defined $to) {
 		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
 		open my $fd2, "> $to_tmp";
-		open my $fd, "-|", $GIT, "cat-file", "blob", $to;
+		open my $fd, "-|", git_cmd(), "cat-file", "blob", $to;
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -1292,7 +1301,7 @@ sub git_project_list {
 		if (!defined $head) {
 			next;
 		}
-		$ENV{'GIT_DIR'} = "$projectroot/$pr->{'path'}";
+		$git_dir = "$projectroot/$pr->{'path'}";
 		my %co = git_read_commit($head);
 		if (!%co) {
 			next;
@@ -1418,7 +1427,7 @@ sub git_summary {
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
 
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project)
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17", git_read_head($project)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -1489,7 +1498,7 @@ sub git_blame2 {
 	if ($ftype !~ "blob") {
 		die_error("400 Bad Request", "Object is not a blob");
 	}
-	open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "blame", '-l', $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
@@ -1543,7 +1552,7 @@ sub git_blame {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(undef, "Error lookup file");
 	}
-	open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "annotate", '-l', '-t', '-r', $file_name, $hash_base)
 		or die_error(undef, "Open git-annotate failed");
 	git_header_html();
 	my $formats_nav =
@@ -1654,7 +1663,7 @@ sub git_blob_plain {
 		}
 	}
 	my $type = shift;
-	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 
 	$type ||= git_blob_plain_mimetype($fd, $file_name);
@@ -1687,7 +1696,7 @@ sub git_blob {
 		}
 	}
 	my $have_blame = git_get_project_config_bool ('blame');
-	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
@@ -1740,7 +1749,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", $GIT, "ls-tree", '-z', $hash
+	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
 		or die_error(undef, "Open git-ls-tree failed");
 	my @entries = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading tree failed");
@@ -1821,7 +1830,7 @@ sub git_log {
 	my $refs = read_info_ref();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
+	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -1892,7 +1901,7 @@ sub git_commit {
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $parent, $hash
+	open my $fd, "-|", git_cmd(), "diff-tree", '-r', '-M', $parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
@@ -2116,7 +2125,7 @@ sub git_commitdiff {
 	if (!defined $hash_parent) {
 		$hash_parent = $co{'parent'} || '--root';
 	}
-	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
+	open my $fd, "-|", git_cmd(), "diff-tree", '-r', $hash_parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
@@ -2207,7 +2216,7 @@ sub git_commitdiff_plain {
 	if (!defined $hash_parent) {
 		$hash_parent = $co{'parent'} || '--root';
 	}
-	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
+	open my $fd, "-|", git_cmd(), "diff-tree", '-r', $hash_parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed");
@@ -2215,7 +2224,7 @@ sub git_commitdiff_plain {
 	# try to figure out the next tag after this commit
 	my $tagname;
 	my $refs = read_info_ref("tags");
-	open $fd, "-|", $GIT, "rev-list", "HEAD";
+	open $fd, "-|", git_cmd(), "rev-list", "HEAD";
 	my @commits = map { chomp; $_ } <$fd>;
 	close $fd;
 	foreach my $commit (@commits) {
@@ -2284,7 +2293,7 @@ sub git_history {
 	git_print_page_path($file_name, $ftype);
 
 	open my $fd, "-|",
-		$GIT, "rev-list", "--full-history", $hash_base, "--", $file_name;
+		git_cmd(), "rev-list", "--full-history", $hash_base, "--", $file_name;
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
@@ -2358,7 +2367,7 @@ sub git_search {
 	my $alternate = 0;
 	if ($commit_search) {
 		$/ = "\0";
-		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", $hash or next;
+		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", $hash or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -2408,7 +2417,7 @@ sub git_search {
 
 	if ($pickaxe_search) {
 		$/ = "\n";
-		open my $fd, "-|", "$GIT rev-list $hash | $GIT diff-tree -r --stdin -S\'$searchtext\'";
+		open my $fd, "-|", git_cmd()." rev-list $hash | ".git_cmd()." diff-tree -r --stdin -S\'$searchtext\'";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
@@ -2471,7 +2480,7 @@ sub git_shortlog {
 	my $refs = read_info_ref();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
+	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2499,7 +2508,7 @@ ## feeds (RSS, OPML)
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project)
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=150", git_read_head($project)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed");
@@ -2520,7 +2529,7 @@ sub git_rss {
 			last;
 		}
 		my %cd = date_str($co{'committer_epoch'});
-		open $fd, "-|", $GIT, "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd or next;
 		print "<item>\n" .
@@ -2573,7 +2582,7 @@ sub git_opml {
 		if (!defined $head) {
 			next;
 		}
-		$ENV{'GIT_DIR'} = "$projectroot/$proj{'path'}";
+		$git_dir = "$projectroot/$proj{'path'}";
 		my %co = git_read_commit($head);
 		if (!%co) {
 			next;
-- 
1.4.2
