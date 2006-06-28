From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/5] git-svn: add the commit-diff command
Date: Tue, 27 Jun 2006 19:39:12 -0700
Message-ID: <1151462358888-git-send-email-normalperson@yhbt.net>
References: <11514623542848-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 04:39:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvPxk-0007c1-No
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 04:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422925AbWF1CjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 22:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422926AbWF1CjW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 22:39:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:26327 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422925AbWF1CjU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 22:39:20 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id F0DF57DC022;
	Tue, 27 Jun 2006 19:39:18 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 19:39:18 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
In-Reply-To: <11514623542848-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22766>

This is intended for interoperability with git-svnimport.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl           |   90 +++++++++++++++++++++++++-------
 contrib/git-svn/t/t0005-commit-diff.sh |   41 +++++++++++++++
 2 files changed, 112 insertions(+), 19 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 4fafe7a..73b339a 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -46,6 +46,7 @@ my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity, $_cp_remote,
 	$_repack, $_repack_nr, $_repack_flags,
+	$_message, $_file,
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m);
@@ -65,6 +66,12 @@ my %multi_opts = ( 'trunk|T=s' => \$_tru
 		'tags|t=s' => \$_tags,
 		'branches|b=s' => \$_branches );
 my %init_opts = ( 'template=s' => \$_template, 'shared' => \$_shared );
+my %cmt_opts = ( 'edit|e' => \$_edit,
+		'rmdir' => \$_rmdir,
+		'find-copies-harder' => \$_find_copies_harder,
+		'l=i' => \$_l,
+		'copy-similarity|C=i'=> \$_cp_similarity
+);
 
 # yes, 'native' sets "\n".  Patches to fix this for non-*nix systems welcome:
 my %EOL = ( CR => "\015", LF => "\012", CRLF => "\015\012", native => "\012" );
@@ -76,14 +83,7 @@ my %cmd = (
 			  " (requires URL argument)",
 			  \%init_opts ],
 	commit => [ \&commit, "Commit git revisions to SVN",
-			{	'stdin|' => \$_stdin,
-				'edit|e' => \$_edit,
-				'rmdir' => \$_rmdir,
-				'find-copies-harder' => \$_find_copies_harder,
-				'l=i' => \$_l,
-				'copy-similarity|C=i'=> \$_cp_similarity,
-				%fc_opts,
-			} ],
+			{	'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings",
 			{ 'revision|r=i' => \$_revision } ],
 	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)",
@@ -112,6 +112,10 @@ my %cmd = (
 			  'show-commit' => \$_show_commit,
 			  'authors-file|A=s' => \$_authors,
 			} ],
+	'commit-diff' => [ \&commit_diff, 'Commit a diff between two trees',
+			{ 'message|m=s' => \$_message,
+			  'file|F=s' => \$_file,
+			%cmt_opts } ],
 );
 
 my $cmd;
@@ -485,11 +489,7 @@ sub commit_lib {
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
 	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
 
-	if (defined $LC_ALL) {
-		$ENV{LC_ALL} = $LC_ALL;
-	} else {
-		delete $ENV{LC_ALL};
-	}
+	set_svn_commit_env();
 	foreach my $c (@revs) {
 		my $log_msg = get_commit_message($c, $commit_msg);
 
@@ -724,6 +724,55 @@ out:
 	print '-' x72,"\n" unless $_incremental || $_oneline;
 }
 
+sub commit_diff_usage {
+	print STDERR "Usage: $0 commit-diff <tree-ish> <tree-ish> [<URL>]\n";
+	exit 1
+}
+
+sub commit_diff {
+	if (!$_use_lib) {
+		print STDERR "commit-diff must be used with SVN libraries\n";
+		exit 1;
+	}
+	my $ta = shift or commit_diff_usage();
+	my $tb = shift or commit_diff_usage();
+	if (!eval { $SVN_URL = shift || file_to_s("$GIT_SVN_DIR/info/url") }) {
+		print STDERR "Needed URL or usable git-svn id command-line\n";
+		commit_diff_usage();
+	}
+	if (defined $_message && defined $_file) {
+		print STDERR "Both --message/-m and --file/-F specified ",
+				"for the commit message.\n",
+				"I have no idea what you mean\n";
+		exit 1;
+	}
+	if (defined $_file) {
+		$_message = file_to_s($_message);
+	} else {
+		$_message ||= get_commit_message($tb,
+					"$GIT_DIR/.svn-commit.tmp.$$")->{msg};
+	}
+	my $repo;
+	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
+	$SVN_LOG ||= libsvn_connect($repo);
+	$SVN ||= libsvn_connect($repo);
+	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
+	my $ed = SVN::Git::Editor->new({	r => $SVN->get_latest_revnum,
+						ra => $SVN, c => $tb,
+						svn_path => $SVN_PATH
+					},
+				$SVN->get_commit_editor($_message,
+					sub {print "Committed $_[0]\n"},@lock)
+				);
+	my $mods = libsvn_checkout_tree($ta, $tb, $ed);
+	if (@$mods == 0) {
+		print "No changes\n$ta == $tb\n";
+		$ed->abort_edit;
+	} else {
+		$ed->close_edit;
+	}
+}
+
 ########################### utility functions #########################
 
 sub cmt_showable {
@@ -1473,7 +1522,6 @@ sub get_commit_message {
 	my %log_msg = ( msg => '' );
 	open my $msg, '>', $commit_msg or croak $!;
 
-	print "commit: $commit\n";
 	chomp(my $type = `git-cat-file -t $commit`);
 	if ($type eq 'commit') {
 		my $pid = open my $msg_fh, '-|';
@@ -1510,6 +1558,14 @@ sub get_commit_message {
 	return \%log_msg;
 }
 
+sub set_svn_commit_env {
+	if (defined $LC_ALL) {
+		$ENV{LC_ALL} = $LC_ALL;
+	} else {
+		delete $ENV{LC_ALL};
+	}
+}
+
 sub svn_commit_tree {
 	my ($last, $commit) = @_;
 	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
@@ -1517,11 +1573,7 @@ sub svn_commit_tree {
 	my ($oneline) = ($log_msg->{msg} =~ /([^\n\r]+)/);
 	print "Committing $commit: $oneline\n";
 
-	if (defined $LC_ALL) {
-		$ENV{LC_ALL} = $LC_ALL;
-	} else {
-		delete $ENV{LC_ALL};
-	}
+	set_svn_commit_env();
 	my @ci_output = safe_qx(qw(svn commit -F),$commit_msg);
 	$ENV{LC_ALL} = 'C';
 	unlink $commit_msg;
diff --git a/contrib/git-svn/t/t0005-commit-diff.sh b/contrib/git-svn/t/t0005-commit-diff.sh
new file mode 100644
index 0000000..f994b72
--- /dev/null
+++ b/contrib/git-svn/t/t0005-commit-diff.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+test_description='git-svn commit-diff'
+. ./lib-git-svn.sh
+
+if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
+then
+	echo 'Skipping: commit-diff needs SVN libraries'
+	test_done
+	exit 0
+fi
+
+test_expect_success 'initialize repo' "
+	mkdir import &&
+	cd import &&
+	echo hello > readme &&
+	svn import -m 'initial' . $svnrepo &&
+	cd .. &&
+	echo hello > readme &&
+	git update-index --add readme &&
+	git commit -a -m 'initial' &&
+	echo world >> readme &&
+	git commit -a -m 'another'
+	"
+
+head=`git rev-parse --verify HEAD^0`
+prev=`git rev-parse --verify HEAD^1`
+
+# the internals of the commit-diff command are the same as the regular
+# commit, so only a basic test of functionality is needed since we've
+# already tested commit extensively elsewhere
+
+test_expect_success 'test the commit-diff command' "
+	test -n '$prev' && test -n '$head' &&
+	git-svn commit-diff '$prev' '$head' '$svnrepo' &&
+	svn co $svnrepo wc &&
+	cmp readme wc/readme
+	"
+
+test_done
-- 
1.4.1.rc1.g3cc8
