From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-svn: always use --first-parent
Date: Fri,  7 Sep 2007 02:00:08 +0200
Message-ID: <11891232082570-git-send-email-hjemli@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITRJW-0001fq-VQ
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbXIGACI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbXIGACH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:02:07 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:59984 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbXIGACG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 20:02:06 -0400
Received: from localhost.localdomain (ti231210a341-5020.bb.online.no [85.166.63.158])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l8701dna007211;
	Fri, 7 Sep 2007 02:01:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.1.g0e33-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57951>

This makes git-svn unconditionally invoke git-log with --first-parent when
it is trying to discover its upstream subversion branch and collecting the
commit ids which should be pushed to it with dcommit. The reason for always
using --first-parent is to make git-svn behave in a predictable way when the
ancestry chain contains merges with other git-svn branches.

Since git-svn now always uses 'git-log --first-parent' there is no longer
any need for the --first-parent option to git-svn, so this is removed.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

I'd like to add a '--upstream <revspec>' option, just for completeness, but
that will also require a new test script and now it's way past my bedtime.


 Documentation/git-svn.txt |   10 ----------
 git-svn.perl              |   17 +++++------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 42d7b82..be2e34e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -317,16 +317,6 @@ This is only used with the 'dcommit' command.
 Print out the series of git arguments that would show
 which diffs would be committed to SVN.
 
---first-parent::
-
-This is only used with the 'dcommit', 'rebase', 'log', 'find-rev' and
-'show-ignore' commands.
-
-These commands tries to detect the upstream subversion branch by means of
-the embedded 'git-svn-id' line in commit messages. When --first-parent is
-specified, git-svn only follows the first parent of each commit, effectively
-ignoring commits brought into the current branch through merge-operations.
-
 --
 
 ADVANCED OPTIONS
diff --git a/git-svn.perl b/git-svn.perl
index d21eb7f..badcd33 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -59,7 +59,7 @@ my ($_stdin, $_help, $_edit,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
-	$_prefix, $_no_checkout, $_verbose, $_first_parent);
+	$_prefix, $_no_checkout, $_verbose);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -119,14 +119,12 @@ my %cmd = (
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
 			  'no-rebase' => \$_no_rebase,
-			  'first-parent' => \$_first_parent,
 			%cmt_opts, %fc_opts } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
-			{ 'revision|r=i' => \$_revision,
-			  'first-parent' => \$_first_parent
+			{ 'revision|r=i' => \$_revision
 			} ],
 	'multi-fetch' => [ \&cmd_multi_fetch,
 	                   "Deprecated alias for $0 fetch --all",
@@ -147,20 +145,16 @@ my %cmd = (
 			  'non-recursive' => \$Git::SVN::Log::non_recursive,
 			  'authors-file|A=s' => \$_authors,
 			  'color' => \$Git::SVN::Log::color,
-			  'pager=s' => \$Git::SVN::Log::pager,
-			  'first-parent' => \$_first_parent
+			  'pager=s' => \$Git::SVN::Log::pager
 			} ],
 	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
-			{
-			  'first-parent' => \$_first_parent
-			} ],
+			{} ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
 			  'verbose|v' => \$_verbose,
 			  'strategy|s=s' => \$_strategy,
 			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
-			  'first-parent' => \$_first_parent,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
@@ -818,8 +812,7 @@ sub cmt_metadata {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my @args = ('log', '--no-color');
-	push @args, '--first-parent' if $_first_parent;
+	my @args = ('log', '--no-color', '--first-parent');
 	my ($fh, $ctx) = command_output_pipe(@args, $head);
 	my $hash;
 	my %max;
-- 
1.5.3.1.g0e33-dirty
