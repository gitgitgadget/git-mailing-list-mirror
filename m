X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix dcommit losing changes when out-of-date from svn
Date: Thu, 9 Nov 2006 01:19:37 -0800
Message-ID: <20061109091937.GA22853@localdomain>
References: <455277A6.2000404@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 09:19:49 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <455277A6.2000404@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31183>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi64W-0000Mq-D6 for gcvg-git@gmane.org; Thu, 09 Nov
 2006 10:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754466AbWKIJTl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 04:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbWKIJTk
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 04:19:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:5312 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1754448AbWKIJTj (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 04:19:39 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id C695E7DC098; Thu,  9 Nov 2006 01:19:37 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 09 Nov 2006
 01:19:37 -0800
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

There was a bug in dcommit (and commit-diff) which caused deltas
to be generated against the latest version of the changed file
in a repository, and not the revision we are diffing (the tree)
against locally.

This bug can cause recent changes to the svn repository to be
silently clobbered by git-svn if our repository is out-of-date.

Thanks to Steven Grimm for noticing the bug.

The (few) people using the commit-diff command are now required
to use the -r/--revision argument.  dcommit usage is unchanged.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt              |    1 +
 git-svn.perl                           |   29 +++++++++++-
 t/t9105-git-svn-commit-diff.sh         |    2 +-
 t/t9106-git-svn-commit-diff-clobber.sh |   74 ++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 450ff1f..a764d1f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -120,6 +120,7 @@ manually joining branches on commit.
 	URL of the target Subversion repository.  The final argument
 	(URL) may be omitted if you are working from a git-svn-aware
 	repository (that has been init-ed with git-svn).
+	The -r<revision> option is required for this.
 
 'graft-branches'::
 	This command attempts to detect merges/branches from already
diff --git a/git-svn.perl b/git-svn.perl
index 4a56f18..80b7b87 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -134,6 +134,7 @@ my %cmd = (
 	'commit-diff' => [ \&commit_diff, 'Commit a diff between two trees',
 			{ 'message|m=s' => \$_message,
 			  'file|F=s' => \$_file,
+			  'revision|r=s' => \$_revision,
 			%cmt_opts } ],
 	dcommit => [ \&dcommit, 'Commit several diffs to merge with upstream',
 			{ 'merge|m|M' => \$_merge,
@@ -586,11 +587,21 @@ sub commit_lib {
 sub dcommit {
 	my $gs = "refs/remotes/$GIT_SVN";
 	chomp(my @refs = safe_qx(qw/git-rev-list --no-merges/, "$gs..HEAD"));
+	my $last_rev;
 	foreach my $d (reverse @refs) {
+		unless (defined $last_rev) {
+			(undef, $last_rev, undef) = cmt_metadata("$d~1");
+			unless (defined $last_rev) {
+				die "Unable to extract revision information ",
+				    "from commit $d~1\n";
+			}
+		}
 		if ($_dry_run) {
 			print "diff-tree $d~1 $d\n";
 		} else {
-			commit_diff("$d~1", $d);
+			if (my $r = commit_diff("$d~1", $d, undef, $last_rev)) {
+				$last_rev = $r;
+			} # else: no changes, same $last_rev
 		}
 	}
 	return if $_dry_run;
@@ -814,6 +825,8 @@ sub commit_diff {
 		print STDERR "Needed URL or usable git-svn id command-line\n";
 		commit_diff_usage();
 	}
+	my $r = shift || $_revision;
+	die "-r|--revision is a required argument\n" unless (defined $r);
 	if (defined $_message && defined $_file) {
 		print STDERR "Both --message/-m and --file/-F specified ",
 				"for the commit message.\n",
@@ -830,13 +843,22 @@ sub commit_diff {
 	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
 	$SVN_LOG ||= libsvn_connect($repo);
 	$SVN ||= libsvn_connect($repo);
+	if ($r eq 'HEAD') {
+		$r = $SVN->get_latest_revnum;
+	} elsif ($r !~ /^\d+$/) {
+		die "revision argument: $r not understood by git-svn\n";
+	}
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
-	my $ed = SVN::Git::Editor->new({	r => $SVN->get_latest_revnum,
+	my $rev_committed;
+	my $ed = SVN::Git::Editor->new({	r => $r,
 						ra => $SVN_LOG, c => $tb,
 						svn_path => $SVN_PATH
 					},
 				$SVN->get_commit_editor($_message,
-					sub {print "Committed $_[0]\n"},@lock)
+					sub {
+						$rev_committed = $_[0];
+						print "Committed $_[0]\n";
+					}, @lock)
 				);
 	my $mods = libsvn_checkout_tree($ta, $tb, $ed);
 	if (@$mods == 0) {
@@ -846,6 +868,7 @@ sub commit_diff {
 		$ed->close_edit;
 	}
 	$_message = $_file = undef;
+	return $rev_committed;
 }
 
 ########################### utility functions #########################
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index f994b72..746c827 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -33,7 +33,7 @@ prev=`git rev-parse --verify HEAD^1`
 
 test_expect_success 'test the commit-diff command' "
 	test -n '$prev' && test -n '$head' &&
-	git-svn commit-diff '$prev' '$head' '$svnrepo' &&
+	git-svn commit-diff -r1 '$prev' '$head' '$svnrepo' &&
 	svn co $svnrepo wc &&
 	cmp readme wc/readme
 	"
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
new file mode 100755
index 0000000..58698b3
--- /dev/null
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+test_description='git-svn commit-diff clobber'
+. ./lib-git-svn.sh
+
+if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
+then
+	echo 'Skipping: commit-diff clobber needs SVN libraries'
+	test_done
+	exit 0
+fi
+
+test_expect_success 'initialize repo' "
+	mkdir import &&
+	cd import &&
+	echo initial > file &&
+	svn import -m 'initial' . $svnrepo &&
+	cd .. &&
+	echo initial > file &&
+	git update-index --add file &&
+	git commit -a -m 'initial'
+	"
+test_expect_success 'commit change from svn side' "
+	svn co $svnrepo t.svn &&
+	cd t.svn &&
+	echo second line from svn >> file &&
+	svn commit -m 'second line from svn' &&
+	cd .. &&
+	rm -rf t.svn
+	"
+
+test_expect_failure 'commit conflicting change from git' "
+	echo second line from git >> file &&
+	git commit -a -m 'second line from git' &&
+	git-svn commit-diff -r1 HEAD~1 HEAD $svnrepo
+	" || true
+
+test_expect_success 'commit complementing change from git' "
+	git reset --hard HEAD~1 &&
+	echo second line from svn >> file &&
+	git commit -a -m 'second line from svn' &&
+	echo third line from git >> file &&
+	git commit -a -m 'third line from git' &&
+	git-svn commit-diff -r2 HEAD~1 HEAD $svnrepo
+	"
+
+test_expect_failure 'dcommit fails to commit because of conflict' "
+	git-svn init $svnrepo &&
+	git-svn fetch &&
+	git reset --hard refs/remotes/git-svn &&
+	svn co $svnrepo t.svn &&
+	cd t.svn &&
+	echo fourth line from svn >> file &&
+	svn commit -m 'fourth line from svn' &&
+	cd .. &&
+	rm -rf t.svn &&
+	echo 'fourth line from git' >> file &&
+	git commit -a -m 'fourth line from git' &&
+	git-svn dcommit
+	" || true
+
+test_expect_success 'dcommit does the svn equivalent of an index merge' "
+	git reset --hard refs/remotes/git-svn &&
+	echo 'index merge' > file2 &&
+	git update-index --add file2 &&
+	git commit -a -m 'index merge' &&
+	echo 'more changes' >> file2 &&
+	git update-index file2 &&
+	git commit -a -m 'more changes' &&
+	git-svn dcommit
+	"
+
+test_done
-- 
1.4.4.rc1.g40e94

-- 
