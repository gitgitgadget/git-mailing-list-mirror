From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'}
Date: Mon, 28 Aug 2006 17:49:58 +0200
Message-ID: <11567801982990-git-send-email-jnareb@gmail.com>
References: <20060824151246.G465d67c8@leonov.stosberg.net>
Cc: Dennis Stosberg <dennis@stosberg.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 17:51:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHjNY-00013w-Fl
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWH1PuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 11:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWH1PuU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 11:50:20 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:56513 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750719AbWH1PuT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 11:50:19 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SFmkCQ001270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 17:48:47 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SFnxQq022942;
	Mon, 28 Aug 2006 17:49:59 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SFnwhf022941;
	Mon, 28 Aug 2006 17:49:58 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <20060824151246.G465d67c8@leonov.stosberg.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26163>

From: Dennis Stosberg <dennis@stosberg.net>

This makes it possible to run gitweb under mod_perl's Apache::Registry.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Updated to the 'next' version (v1.4.2-gc6063de).

It needs fairly new git version, with --git-dir=<path> parameter
to git wrapper, i.e. post v1.4.2-rc2-g6acbcb9 version.

Dennis, could you check that it works for you in 'next'
version of gitweb? The patch you sent is pre-rename even...

 gitweb/gitweb.perl |   90 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ef09cf5..f421825 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -157,6 +157,9 @@ require $GITWEB_CONFIG if -e $GITWEB_CON
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
+# path to the current git repository
+our $git_dir;
+
 $projects_list ||= $projectroot;
 
 # ======================================================================
@@ -184,7 +187,7 @@ if (defined $project) {
 	if (!(-e "$projectroot/$project/HEAD")) {
 		die_error(undef, "No such project");
 	}
-	$ENV{'GIT_DIR'} = "$projectroot/$project";
+	$git_dir = "$projectroot/$project";
 }
 
 our $file_name = $cgi->param('f');
@@ -572,21 +575,31 @@ sub format_diff_line {
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
+# returns path to the core git executable and the --git-dir parameter as list
+sub git_cmd {
+	return $GIT, '--git-dir='.$git_dir;
+}
+
+# returns path to the core git executable and the --git-dir parameter as string
+sub git_cmd_str {
+	return join(' ', git_cmd());
+}
+
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
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
@@ -595,7 +608,7 @@ # get type of given object
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", $GIT, "cat-file", '-t', $hash or return;
+	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -609,7 +622,7 @@ sub git_get_project_config {
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my @x = ($GIT, 'repo-config');
+	my @x = (git_cmd(), 'repo-config');
 	if (defined $type) { push @x, $type; }
 	push @x, "--get";
 	push @x, "gitweb.$key";
@@ -625,7 +638,7 @@ sub git_get_hash_by_path {
 
 	my $tree = $base;
 
-	open my $fd, "-|", $GIT, "ls-tree", $base, "--", $path
+	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
 		or die_error(undef, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
@@ -756,7 +769,7 @@ sub git_get_references {
 		open $fd, "$projectroot/$project/info/refs"
 			or return;
 	} else {
-		open $fd, "-|", $GIT, "ls-remote", "."
+		open $fd, "-|", git_cmd(), "ls-remote", "."
 			or return;
 	}
 
@@ -777,7 +790,7 @@ sub git_get_references {
 sub git_get_rev_name_tags {
 	my $hash = shift || return undef;
 
-	open my $fd, "-|", $GIT, "name-rev", "--tags", $hash
+	open my $fd, "-|", git_cmd(), "name-rev", "--tags", $hash
 		or return;
 	my $name_rev = <$fd>;
 	close $fd;
@@ -825,7 +838,7 @@ sub parse_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", $GIT, "cat-file", "tag", $tag_id or return;
+	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -866,7 +879,7 @@ sub parse_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", "--max-count=1", $commit_id
+		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", "--max-count=1", $commit_id
 			or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
@@ -1971,7 +1984,7 @@ sub git_project_list {
 		if (!defined $head) {
 			next;
 		}
-		$ENV{'GIT_DIR'} = "$projectroot/$pr->{'path'}";
+		$git_dir = "$projectroot/$pr->{'path'}";
 		my %co = parse_commit($head);
 		if (!%co) {
 			next;
@@ -2090,7 +2103,8 @@ sub git_summary {
 	}
 	print "</table>\n";
 
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head_hash($project)
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
+		git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2168,7 +2182,7 @@ sub git_blame2 {
 	if ($ftype !~ "blob") {
 		die_error("400 Bad Request", "Object is not a blob");
 	}
-	open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "blame", '-l', $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
@@ -2233,7 +2247,7 @@ sub git_blame {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(undef, "Error lookup file");
 	}
-	open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "annotate", '-l', '-t', '-r', $file_name, $hash_base)
 		or die_error(undef, "Open git-annotate failed");
 	git_header_html();
 	my $formats_nav =
@@ -2354,7 +2368,7 @@ sub git_blob_plain {
 		}
 	}
 	my $type = shift;
-	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 
 	$type ||= blob_mimetype($fd, $file_name);
@@ -2396,7 +2410,7 @@ sub git_blob {
 		}
 	}
 	my $have_blame = gitweb_check_feature('blame');
-	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
@@ -2461,7 +2475,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", $GIT, "ls-tree", '-z', $hash
+	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
 		or die_error(undef, "Open git-ls-tree failed");
 	my @entries = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading tree failed");
@@ -2564,7 +2578,8 @@ sub git_snapshot {
 	                   -content_disposition => "inline; filename=\"$filename\"",
 	                   -status => '200 OK');
 
-	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | $command" or
+	my $git_command = git_cmd_str();
+	open my $fd, "-|", "$git_command tar-tree $hash \'$project\' | $command" or
 		die_error(undef, "Execute git-tar-tree failed.");
 	binmode STDOUT, ':raw';
 	print <$fd>;
@@ -2584,7 +2599,7 @@ sub git_log {
 	my $refs = git_get_references();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
+	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2639,7 +2654,7 @@ sub git_commit {
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	open my $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts, $parent, $hash
+	open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
@@ -2746,7 +2761,7 @@ sub git_blobdiff {
 	if (defined $hash_base && defined $hash_parent_base) {
 		if (defined $file_name) {
 			# read raw output
-			open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base,
+			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base,
 				"--", $file_name
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree = map { chomp; $_ } <$fd>;
@@ -2760,7 +2775,7 @@ sub git_blobdiff {
 			# try to find filename from $hash
 
 			# read filtered raw output
-			open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base
+			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
@@ -2794,7 +2809,7 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_base, $hash_base,
 			"--", $file_name
 			or die_error(undef, "Open git-diff-tree failed");
@@ -2830,7 +2845,7 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		open $fd, "-|", $GIT, "diff", '-p', @diff_opts, $hash_parent, $hash
+		open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts, $hash_parent, $hash
 			or die_error(undef, "Open git-diff failed");
 	} else  {
 		die_error('404 Not Found', "Missing one of the blob diff parameters")
@@ -2915,7 +2930,7 @@ sub git_commitdiff {
 	my $fd;
 	my @difftree;
 	if ($format eq 'html') {
-		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			"--patch-with-raw", "--full-index", $hash_parent, $hash
 			or die_error(undef, "Open git-diff-tree failed");
 
@@ -2926,7 +2941,7 @@ sub git_commitdiff {
 		}
 
 	} elsif ($format eq 'plain') {
-		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent, $hash
 			or die_error(undef, "Open git-diff-tree failed");
 
@@ -3027,7 +3042,8 @@ sub git_history {
 	git_print_page_path($file_name, $ftype, $hash_base);
 
 	open my $fd, "-|",
-		$GIT, "rev-list", "--full-history", $hash_base, "--", $file_name;
+		git_cmd(), "rev-list", "--full-history", $hash_base, "--", $file_name;
+
 	git_history_body($fd, $refs, $hash_base, $ftype);
 
 	close $fd;
@@ -3067,7 +3083,7 @@ sub git_search {
 	my $alternate = 0;
 	if ($commit_search) {
 		$/ = "\0";
-		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", $hash or next;
+		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", $hash or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -3119,7 +3135,9 @@ sub git_search {
 
 	if ($pickaxe_search) {
 		$/ = "\n";
-		open my $fd, "-|", "$GIT rev-list $hash | $GIT diff-tree -r --stdin -S\'$searchtext\'";
+		my $git_command = git_cmd_str();
+		open my $fd, "-|", "$git_command rev-list $hash | " .
+			"$git_command diff-tree -r --stdin -S\'$searchtext\'";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
@@ -3186,7 +3204,7 @@ sub git_shortlog {
 	my $refs = git_get_references();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
+	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -3214,7 +3232,7 @@ ## feeds (RSS, OPML)
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_get_head_hash($project)
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=150", git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed");
@@ -3237,7 +3255,7 @@ XML
 			last;
 		}
 		my %cd = parse_date($co{'committer_epoch'});
-		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			$co{'parent'}, $co{'id'}
 			or next;
 		my @difftree = map { chomp; $_ } <$fd>;
@@ -3295,7 +3313,7 @@ XML
 		if (!defined $head) {
 			next;
 		}
-		$ENV{'GIT_DIR'} = "$projectroot/$proj{'path'}";
+		$git_dir = "$projectroot/$proj{'path'}";
 		my %co = parse_commit($head);
 		if (!%co) {
 			next;
-- 
1.4.1.1
