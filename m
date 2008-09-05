From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH] Add git-svn branch to allow branch creation in SVN repositories
Date: Fri,  5 Sep 2008 13:34:07 +0200
Message-ID: <1220614447-3751-1-git-send-email-rafl@debian.org>
Cc: Florian Ragwitz <rafl@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 14:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbaBW-0000RI-Bb
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 14:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbYIEML6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 08:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYIEML6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 08:11:58 -0400
Received: from weedy.perldition.org ([85.10.210.75]:49704 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbYIEML5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 08:11:57 -0400
X-Greylist: delayed 2236 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Sep 2008 08:11:57 EDT
Received: from p4fd7562a.dip.t-dialin.net ([79.215.86.42]:53182 helo=ata.xb.lan)
	by weedy.perldition.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <rafl@debian.org>)
	id 1KbZZm-0003HX-0V; Fri, 05 Sep 2008 13:34:06 +0200
Received: from rafl by ata.xb.lan with local (Exim 4.69)
	(envelope-from <rafl@debian.org>)
	id 1KbZZn-0000yr-Fk; Fri, 05 Sep 2008 13:34:07 +0200
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95008>

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 Documentation/git-svn.txt |   14 ++++++++++++++
 git-svn.perl              |   30 +++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1e644ca..23cf7c3 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -149,6 +149,18 @@ and have no uncommitted changes.
 	is very strongly discouraged.
 --
 
+'branch'::
+    Create a branch in the SVN repository.
+
+-m;;
+--message;;
+    Allows to specify the commit message.
+
+-t;;
+--tag;;
+    Create a tag by using the tags_subdir instead of the branches_subdir
+    specified during git svn init.
+
 'log'::
 	This should make it easy to look up svn log messages when svn
 	users refer to -r/--revision numbers.
@@ -498,6 +510,8 @@ Tracking and contributing to an entire Subversion-managed project
 	git svn clone http://svn.foo.org/project -T trunk -b branches -t tags
 # View all branches and tags you have cloned:
 	git branch -r
+# Create a new branch in SVN
+    git svn branch waldo
 # Reset your master to trunk (or any other branch, replacing 'trunk'
 # with the appropriate name):
 	git reset --hard remotes/trunk
diff --git a/git-svn.perl b/git-svn.perl
index 7a1d26d..55a2052 100755
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
@@ -131,6 +131,10 @@ my %cmd = (
 			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
 			%cmt_opts, %fc_opts } ],
+	branch => [ \&cmd_branch,
+	            'Create a branch in the SVN repository',
+	            { 'tag|t'       => \$_tag,
+	              'message|m=s' => \$_message } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
@@ -537,6 +541,30 @@ sub cmd_dcommit {
 	unlink $gs->{index};
 }
 
+sub cmd_branch {
+	my $branch_name = shift or die "branch name required\n";
+	my $head        = shift || 'HEAD';
+
+	my ($src, $rev, undef, $gs) = working_head_info($head);
+
+	my $remote      = Git::SVN::read_all_remotes()->{svn};
+	my ($lft, $rgt) = @{ $remote->{ $_tag ? 'tags' : 'branches' }->{path} }{qw/left right/};
+	my $dst         = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());
+
+	my $ctx = SVN::Client->new(
+		auth    => Git::SVN::Ra::_auth_providers(),
+		log_msg => sub { ${ $_[0] } = $_message || 'Create branch ' . $branch_name },
+	);
+
+	eval {
+		$ctx->ls($dst, 'HEAD', 0);
+	} and die "branch ${branch_name} already exists\n";
+
+	$ctx->copy($src, $rev, $dst);
+
+	$gs->fetch_all;
+}
+
 sub cmd_find_rev {
 	my $revision_or_hash = shift or die "SVN or git revision required ",
 	                                    "as a command-line argument\n";
-- 
1.5.6.5
