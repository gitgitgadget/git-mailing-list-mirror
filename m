From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v3] Add git-svn branch to allow branch creation in SVN
	repositories
Date: Sat, 4 Oct 2008 10:24:44 -0400
Message-ID: <20081004142444.GC3052@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: rafl@debian.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sat Oct 04 16:31:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km8AR-0007II-Qa
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 16:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbYJDO04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 10:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYJDO0z
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 10:26:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:24239 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbYJDO0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 10:26:54 -0400
Received: by wr-out-0506.google.com with SMTP id 69so875808wri.5
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=fBWm072NNEHa585DkDH8zp697z1nQySyzxfz86HwBms=;
        b=pf35n0huA10+efuEoTNqr9EGkApA9ayiYhVF1/4ZgwlkcJ1sKXAi6hAgA/ZEkMyB/3
         uTlNfgF51ubfKIUHO8edCGayBuNtjJxgOZiTCvRbch2xorJFUGvRfyGbHITdgIkIF7sh
         z8b4xfRy+mHnE+IPxbnjYY6d1WXLak3218/0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=NLSZwIpmK1CqpbsqKChmzOwPnzPl3RdfGYS5fDlIPDgdNh+GlFpORBvhqSTSLiz4Dh
         GgVmriMD8WskrgKT2iS+kvbaAKszUKqsWpTAqSrrr1PfK20fiEJRhne8uIO64eGgidgG
         f6Mc+3Omqc0agTz9noV/n6DIp+zSvfncnU5B8=
Received: by 10.65.240.16 with SMTP id s16mr2687207qbr.13.1223130410147;
        Sat, 04 Oct 2008 07:26:50 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id 25sm6938988qbw.1.2008.10.04.07.26.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 07:26:48 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97470>

>From 7a8a811bbb229825da8c90e71c57a60634a9280b Mon Sep 17 00:00:00 2001
From: Florian Ragwitz <rafl@debian.org>
Date: Tue, 2 Sep 2008 14:20:39 +0000

Signed-off-by: Florian Ragwitz <rafl@debian.org>
Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
Eric Wong <normalperson <at> yhbt.net> writes:
> Florian Ragwitz <rafl <at> debian.org> wrote:
> > Signed-off-by: Florian Ragwitz <rafl <at> debian.org>
> 
> The patch looks good, but can you add a test for this functionality?

Here's a new patch with tests for this feature.  There are also some minor
changes to Florian's patch: branch now parses -t/--tag, and some of the
messages in cmd_branch change depending on $_tag also.

Florian, I apologise if I'm stepping on your toes here; this is a feature I
would've written if I was better at Perl, so I want to see it included, and I'm
glad for your work on it.

 Documentation/git-svn.txt     |   24 ++++++++++++++++-
 git-svn.perl                  |   46 +++++++++++++++++++++++++++++++-
 t/t9128-git-svn-cmd-branch.sh |   59 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100755 t/t9128-git-svn-cmd-branch.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1e644ca..0fe4955 100644
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
 	git svn clone http://svn.foo.org/project -T trunk -b branches -t tags
 # View all branches and tags you have cloned:
 	git branch -r
+# Create a new branch in SVN
+    git svn branch waldo
 # Reset your master to trunk (or any other branch, replacing 'trunk'
 # with the appropriate name):
 	git reset --hard remotes/trunk
diff --git a/git-svn.perl b/git-svn.perl
index 80a5728..e7b9254 100755
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
@@ -537,6 +546,41 @@ sub cmd_dcommit {
 	unlink $gs->{index};
 }
 
+sub cmd_branch {
+	my ($branch_name, $head) = @_;
+
+	die ($_tag ? "tag" : "branch") . " name required\n"
+		unless $branch_name;
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
1.6.0.2.307.gc427
