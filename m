From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] Add git-svn branch to allow branch creation in SVN
	repositories
Date: Sat, 4 Oct 2008 19:35:17 -0700
Message-ID: <20081005023517.GA14078@untitled>
References: <20081004142444.GC3052@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rafl@debian.org, spearce@spearce.org, git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Sun Oct 05 04:36:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmJUK-0000hv-J0
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 04:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbYJECfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 22:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYJECfV
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 22:35:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35600 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643AbYJECfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 22:35:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 656CA2DC01A;
	Sat,  4 Oct 2008 19:35:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081004142444.GC3052@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97495>

Thanks Deskin, one small fix to quiet the warning that was
making t9108 fail.

>From c7e48f128865823a4c5024eb4f67b69231d1d5dc Mon Sep 17 00:00:00 2001
From: Florian Ragwitz <rafl@debian.org>
Date: Tue, 2 Sep 2008 14:20:39 +0000
Subject: [PATCH] Add git-svn branch to allow branch creation in SVN repositories

[ew: fixed a warning to stderr causing t9108 to fail]

Signed-off-by: Florian Ragwitz <rafl@debian.org>
Signed-off-by: Deskin Miller <deskinm@umich.edu>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt     |   24 ++++++++++++++++-
 git-svn.perl                  |   47 ++++++++++++++++++++++++++++++++-
 t/t9128-git-svn-cmd-branch.sh |   59 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100755 t/t9128-git-svn-cmd-branch.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 82d03b4..84c8f3c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -149,6 +149,22 @@ and have no uncommitted changes.
 	is very strongly discouraged.
 --
 
+'branch'::
+	Create a branch in the SVN repository.
+
+-m;;
+--message;;
+	Allows to specify the commit message.
+
+-t;;
+--tag;;
+	Create a tag by using the tags_subdir instead of the branches_subdir
+	specified during git svn init.
+
+'tag'::
+	Create a tag in the SVN repository. This is a shorthand for
+	'branch -t'.
+
 'log'::
 	This should make it easy to look up svn log messages when svn
 	users refer to -r/--revision numbers.
@@ -372,7 +388,8 @@ Passed directly to 'git-rebase' when using 'dcommit' if a
 -n::
 --dry-run::
 
-This can be used with the 'dcommit' and 'rebase' commands.
+This can be used with the 'dcommit', 'rebase', 'branch' and 'tag'
+commands.
 
 For 'dcommit', print out the series of git arguments that would show
 which diffs would be committed to SVN.
@@ -381,6 +398,9 @@ For 'rebase', display the local branch associated with the upstream svn
 repository associated with the current branch and the URL of svn
 repository that will be fetched from.
 
+For 'branch' and 'tag', display the urls that will be used for copying when
+creating the branch or tag.
+
 --
 
 ADVANCED OPTIONS
@@ -498,6 +518,8 @@ Tracking and contributing to an entire Subversion-managed project
 	git svn clone http://svn.example.com/project -T trunk -b branches -t tags
 # View all branches and tags you have cloned:
 	git branch -r
+# Create a new branch in SVN
+    git svn branch waldo
 # Reset your master to trunk (or any other branch, replacing 'trunk'
 # with the appropriate name):
 	git reset --hard remotes/trunk
diff --git a/git-svn.perl b/git-svn.perl
index 7609a83..ef6d773 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -66,7 +66,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url);
+	$_git_format, $_commit_url, $_tag);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -131,6 +131,15 @@ my %cmd = (
 			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
 			%cmt_opts, %fc_opts } ],
+	branch => [ \&cmd_branch,
+	            'Create a branch in the SVN repository',
+	            { 'message|m=s' => \$_message,
+	              'dry-run|n' => \$_dry_run,
+		      'tag|t' => \$_tag } ],
+	tag => [ sub { $_tag = 1; cmd_branch(@_) },
+	         'Create a tag in the SVN repository',
+	         { 'message|m=s' => \$_message,
+	           'dry-run|n' => \$_dry_run } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
@@ -537,6 +546,42 @@ sub cmd_dcommit {
 	unlink $gs->{index};
 }
 
+sub cmd_branch {
+	my ($branch_name, $head) = @_;
+
+	unless (defined $branch_name && length $branch_name) {
+		die(($_tag ? "tag" : "branch") . " name required\n");
+	}
+	$head ||= 'HEAD';
+
+	my ($src, $rev, undef, $gs) = working_head_info($head);
+
+	my $remote = Git::SVN::read_all_remotes()->{svn};
+	my $glob = $remote->{ $_tag ? 'tags' : 'branches' };
+	my ($lft, $rgt) = @{ $glob->{path} }{qw/left right/};
+	my $dst = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());
+
+	my $ctx = SVN::Client->new(
+		auth    => Git::SVN::Ra::_auth_providers(),
+		log_msg => sub {
+			${ $_[0] } = defined $_message
+				? $_message
+				: 'Create ' . ($_tag ? 'tag ' : 'branch ' )
+				. $branch_name;
+		},
+	);
+
+	eval {
+		$ctx->ls($dst, 'HEAD', 0);
+	} and die "branch ${branch_name} already exists\n";
+
+	print "Copying ${src} at r${rev} to ${dst}...\n";
+	$ctx->copy($src, $rev, $dst)
+		unless $_dry_run;
+
+	$gs->fetch_all;
+}
+
 sub cmd_find_rev {
 	my $revision_or_hash = shift or die "SVN or git revision required ",
 	                                    "as a command-line argument\n";
diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
new file mode 100755
index 0000000..47c4d4d
--- /dev/null
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Deskin Miller
+#
+
+test_description='git svn partial-rebuild tests'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize svnrepo' '
+	mkdir import &&
+	(
+		cd import &&
+		mkdir trunk branches tags &&
+		cd trunk &&
+		echo foo > foo &&
+		cd .. &&
+		svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
+		cd .. &&
+		rm -rf import &&
+		svn co "$svnrepo"/trunk trunk &&
+		cd trunk &&
+		echo bar >> foo &&
+		svn ci -m "updated trunk" &&
+		cd .. &&
+		rm -rf trunk
+	)
+'
+
+test_expect_success 'import into git' '
+	git svn init --stdlayout "$svnrepo" &&
+	git svn fetch &&
+	git checkout remotes/trunk
+'
+
+test_expect_success 'git svn branch tests' '
+	git svn branch a &&
+	base=$(git rev-parse HEAD:) &&
+	test $base = $(git rev-parse remotes/a:) &&
+	git svn branch -m "created branch b blah" b &&
+	test $base = $(git rev-parse remotes/b:) &&
+	test_must_fail git branch -m "no branchname" &&
+	git svn branch -n c &&
+	test_must_fail git rev-parse remotes/c &&
+	test_must_fail git svn branch a &&
+	git svn branch -t tag1 &&
+	test $base = $(git rev-parse remotes/tags/tag1:) &&
+	git svn branch --tag tag2 &&
+	test $base = $(git rev-parse remotes/tags/tag2:) &&
+	git svn tag tag3 &&
+	test $base = $(git rev-parse remotes/tags/tag3:) &&
+	git svn tag -m "created tag4 foo" tag4 &&
+	test $base = $(git rev-parse remotes/tags/tag4:) &&
+	test_must_fail git svn tag -m "no tagname" &&
+	git svn tag -n tag5 &&
+	test_must_fail git rev-parse remotes/tags/tag5 &&
+	test_must_fail git svn tag tag1
+'
+
+test_done
-- 
Eric Wong
