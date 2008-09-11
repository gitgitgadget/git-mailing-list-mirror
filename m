From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH] Add git-svn branch to allow branch creation in SVN repositories
Date: Thu, 11 Sep 2008 16:20:39 +0200
Message-ID: <1221142839-29624-1-git-send-email-rafl@debian.org>
Cc: Florian Ragwitz <rafl@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 16:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdn4F-0004aG-TM
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 16:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYIKOVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 10:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYIKOVf
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 10:21:35 -0400
Received: from weedy.perldition.org ([85.10.210.75]:45764 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbYIKOVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 10:21:34 -0400
Received: from p4fd756d7.dip.t-dialin.net ([79.215.86.215]:56992 helo=ata.xb.lan)
	by weedy.perldition.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <rafl@debian.org>)
	id 1Kdn2T-0003r1-O9; Thu, 11 Sep 2008 16:20:56 +0200
Received: from rafl by ata.xb.lan with local (Exim 4.69)
	(envelope-from <rafl@debian.org>)
	id 1Kdn2F-0007iA-BJ; Thu, 11 Sep 2008 16:20:39 +0200
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95608>

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 Documentation/git-svn.txt |   24 +++++++++++++++++++++++-
 git-svn.perl              |   43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 2 deletions(-)

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
index 88066c9..54a785c 100755
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
@@ -131,6 +131,14 @@ my %cmd = (
 			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
 			%cmt_opts, %fc_opts } ],
+	branch => [ \&cmd_branch,
+	            'Create a branch in the SVN repository',
+	            { 'message|m=s' => \$_message,
+	              'dry-run|n' => \$_dry_run } ],
+	tag => [ sub { $_tag = 1; cmd_branch(@_) },
+	         'Create a tag in the SVN repository',
+	         { 'message|m=s' => \$_message,
+	           'dry-run|n' => \$_dry_run } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
@@ -537,6 +545,39 @@ sub cmd_dcommit {
 	unlink $gs->{index};
 }
 
+sub cmd_branch {
+	my ($branch_name, $head) = @_;
+
+	die "branch name required\n" unless $branch_name;
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
+				: 'Create branch ' . $branch_name;
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
-- 
1.5.6.5
