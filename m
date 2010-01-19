From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 1/3] cvsimport: modernize callouts to git subcommands
Date: Tue, 19 Jan 2010 14:03:08 -0500
Message-ID: <1263927790-1872-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <7v8wbwzgnw.fsf@alter.siamese.dyndns.org>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 20:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJMr-0001jR-1f
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 20:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0ASTDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 14:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284Ab0ASTDR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 14:03:17 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:34870 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab0ASTDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 14:03:15 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:38910 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NXJM9-00045o-5p; Tue, 19 Jan 2010 14:03:13 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NXJM9-0000Ul-3Q; Tue, 19 Jan 2010 14:03:13 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o0JJ3DvF001903;
	Tue, 19 Jan 2010 14:03:13 -0500
X-Mailer: git-send-email 1.6.6
In-Reply-To: <7v8wbwzgnw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137486>

This patch updates all calling conventions for external git tools.  to
use the modern calling convention (eg: git foo instead of git-foo).
This is almost entierly a s/git-/git / operation, with deviations only
as required to keep tests passing.

Reported-by: Alexander Maier <amaier@opencsw.org>
Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-cvsimport.perl |   64 ++++++++++++++++++++++++++--------------------------
 1 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index a7d215c..adffa0c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -609,16 +609,16 @@ $orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
 my %index; # holds filenames of one index per branch
 
 unless (-d $git_dir) {
-	system("git-init");
+	system("git init");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
-	system("git-read-tree");
+	system("git read-tree");
 	die "Cannot init an empty tree: $?\n" if $?;
 
 	$last_branch = $opt_o;
 	$orig_branch = "";
 } else {
-	open(F, "git-symbolic-ref HEAD |") or
-		die "Cannot run git-symbolic-ref: $!\n";
+	open(F, "git symbolic-ref HEAD |") or
+		die "Cannot run git symbolic-ref: $!\n";
 	chomp ($last_branch = <F>);
 	$last_branch = basename($last_branch);
 	close(F);
@@ -627,12 +627,12 @@ unless (-d $git_dir) {
 		$last_branch = "master";
 	}
 	$orig_branch = $last_branch;
-	$tip_at_start = `git-rev-parse --verify HEAD`;
+	$tip_at_start = `git rev-parse --verify HEAD`;
 
 	# Get the last import timestamps
 	my $fmt = '($ref, $author) = (%(refname), %(author));';
-	open(H, "git-for-each-ref --perl --format='$fmt' $remote |") or
-		die "Cannot run git-for-each-ref: $!\n";
+	open(H, "git for-each-ref --perl --format='$fmt' $remote |") or
+		die "Cannot run git for-each-ref: $!\n";
 	while (defined(my $entry = <H>)) {
 		my ($ref, $author);
 		eval($entry) || die "cannot eval refs list: $@";
@@ -687,7 +687,7 @@ unless ($opt_P) {
 	    print $cvspsfh $_;
 	}
 	close CVSPS;
-	$? == 0 or die "git-cvsimport: fatal: cvsps reported error\n";
+	$? == 0 or die "git cvsimport: fatal: cvsps reported error\n";
 	close $cvspsfh;
 } else {
 	$cvspsfile = munge_user_filename($opt_P);
@@ -716,27 +716,27 @@ my $state = 0;
 sub update_index (\@\@) {
 	my $old = shift;
 	my $new = shift;
-	open(my $fh, '|-', qw(git-update-index -z --index-info))
-		or die "unable to open git-update-index: $!";
+	open(my $fh, '|-', qw(git update-index -z --index-info))
+		or die "unable to open git update-index: $!";
 	print $fh
 		(map { "0 0000000000000000000000000000000000000000\t$_\0" }
 			@$old),
 		(map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\0" }
 			@$new)
-		or die "unable to write to git-update-index: $!";
+		or die "unable to write to git update-index: $!";
 	close $fh
-		or die "unable to write to git-update-index: $!";
-	$? and die "git-update-index reported error: $?";
+		or die "unable to write to git update-index: $!";
+	$? and die "git update-index reported error: $?";
 }
 
 sub write_tree () {
-	open(my $fh, '-|', qw(git-write-tree))
-		or die "unable to open git-write-tree: $!";
+	open(my $fh, '-|', "git write-tree")
+		or die "unable to open git write-tree: $!";
 	chomp(my $tree = <$fh>);
 	is_sha1($tree)
 		or die "Cannot get tree id ($tree): $!";
 	close($fh)
-		or die "Error running git-write-tree: $?\n";
+		or die "Error running git write-tree: $?\n";
 	print "Tree ID $tree\n" if $opt_v;
 	return $tree;
 }
@@ -751,7 +751,7 @@ sub commit {
 	if ($branch eq $opt_o && !$index{branch} &&
 		!get_headref("$remote/$branch")) {
 	    # looks like an initial commit
-	    # use the index primed by git-init
+	    # use the index primed by git init
 	    $ENV{GIT_INDEX_FILE} = "$git_dir/index";
 	    $index{$branch} = "$git_dir/index";
 	} else {
@@ -761,9 +761,9 @@ sub commit {
 		$index{$branch} = tmpnam();
 		$ENV{GIT_INDEX_FILE} = $index{$branch};
 		if ($ancestor) {
-		    system("git-read-tree", "$remote/$ancestor");
+		    system("git", "read-tree", "$remote/$ancestor");
 		} else {
-		    system("git-read-tree", "$remote/$branch");
+		    system("git", "read-tree", "$remote/$branch");
 		}
 		die "read-tree failed: $?\n" if $?;
 	    }
@@ -798,7 +798,7 @@ sub commit {
 	$ENV{GIT_COMMITTER_EMAIL} = $author_email;
 	$ENV{GIT_COMMITTER_DATE} = $commit_date;
 	my $pid = open2(my $commit_read, my $commit_write,
-		'git-commit-tree', $tree, @commit_args);
+		'git', 'commit-tree', $tree, @commit_args);
 
 	# compatibility with git2cvs
 	substr($logmsg,32767) = "" if length($logmsg) > 32767;
@@ -811,7 +811,7 @@ sub commit {
 	}
 
 	print($commit_write "$logmsg\n") && close($commit_write)
-		or die "Error writing to git-commit-tree: $!\n";
+		or die "Error writing to git commit-tree: $!\n";
 
 	print "Committed patch $patchset ($branch $commit_date)\n" if $opt_v;
 	chomp(my $cid = <$commit_read>);
@@ -820,9 +820,9 @@ sub commit {
 	close($commit_read);
 
 	waitpid($pid,0);
-	die "Error running git-commit-tree: $?\n" if $?;
+	die "Error running git commit-tree: $?\n" if $?;
 
-	system('git-update-ref', "$remote/$branch", $cid) == 0
+	system('git' , 'update-ref', "$remote/$branch", $cid) == 0
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if ($tag) {
@@ -832,7 +832,7 @@ sub commit {
 		$xtag =~ s/[\/]/$opt_s/g;
 		$xtag =~ s/\[//g;
 
-		system('git-tag', '-f', $xtag, $cid) == 0
+		system('git' , 'tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
@@ -969,7 +969,7 @@ while (<CVS>) {
 			my $pid = open(my $F, '-|');
 			die $! unless defined $pid;
 			if (!$pid) {
-			    exec("git-hash-object", "-w", $tmpname)
+			    exec("git", "hash-object", "-w", $tmpname)
 				or die "Cannot create object: $!\n";
 			}
 			my $sha = <$F>;
@@ -1013,7 +1013,7 @@ unless ($opt_P) {
 # The heuristic of repacking every 1024 commits can leave a
 # lot of unpacked data.  If there is more than 1MB worth of
 # not-packed objects, repack once more.
-my $line = `git-count-objects`;
+my $line = `git count-objects`;
 if ($line =~ /^(\d+) objects, (\d+) kilobytes$/) {
   my ($n_objects, $kb) = ($1, $2);
   1024 < $kb
@@ -1038,26 +1038,26 @@ if ($orig_branch) {
 	if ($opt_i) {
 		exit 0;
 	}
-	my $tip_at_end = `git-rev-parse --verify HEAD`;
+	my $tip_at_end = `git rev-parse --verify HEAD`;
 	if ($tip_at_start ne $tip_at_end) {
 		for ($tip_at_start, $tip_at_end) { chomp; }
 		print "Fetched into the current branch.\n" if $opt_v;
-		system(qw(git-read-tree -u -m),
+		system(qw(git read-tree -u -m),
 		       $tip_at_start, $tip_at_end);
 		die "Fast-forward update failed: $?\n" if $?;
 	}
 	else {
-		system(qw(git-merge cvsimport HEAD), "$remote/$opt_o");
+		system(qw(git merge cvsimport HEAD), "$remote/$opt_o");
 		die "Could not merge $opt_o into the current branch.\n" if $?;
 	}
 } else {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
-	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
+	system("git", "update-ref", "refs/heads/master", "$remote/$opt_o")
 		unless defined get_headref('refs/heads/master');
-	system("git-symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
+	system("git", "symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
 		if ($opt_r && $opt_o ne 'HEAD');
-	system('git-update-ref', 'HEAD', "$orig_branch");
+	system('git', 'update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
 		system('git checkout -f');
 		die "checkout failed: $?\n" if $?;
-- 
1.6.5.3
