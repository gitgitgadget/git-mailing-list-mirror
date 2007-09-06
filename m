From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Thu,  6 Sep 2007 18:37:49 +0200
Message-ID: <1189096669534-git-send-email-hjemli@gmail.com>
References: <20070906075104.GA10192@hand.yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:40:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKOd-0006Kg-FM
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbXIFQjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbXIFQjn
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:39:43 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:49587 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbXIFQjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:39:42 -0400
Received: from localhost.localdomain (ti231210a341-5020.bb.online.no [85.166.63.158])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id l86GdKDh008570;
	Thu, 6 Sep 2007 18:39:21 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.1.g0e33-dirty
In-Reply-To: <20070906075104.GA10192@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57904>

This makes git-svn always issue the --first-parent option to git-log when
trying to establish the "base" subversion branch, so the --first-parent
option to git-svn is no longer needed. Instead a new option, --upstream
<revspec>, is introduced. When this is specified the search for embedded
git-svn-id lines in commit messages starts at the specified revision, if
not specified the search starts at HEAD.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-svn.txt |   10 +++++-----
 git-svn.perl              |   18 +++++++++---------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 42d7b82..2903777 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -317,15 +317,15 @@ This is only used with the 'dcommit' command.
 Print out the series of git arguments that would show
 which diffs would be committed to SVN.
 
---first-parent::
+--upstream=<revspec>::
 
 This is only used with the 'dcommit', 'rebase', 'log', 'find-rev' and
 'show-ignore' commands.
 
-These commands tries to detect the upstream subversion branch by means of
-the embedded 'git-svn-id' line in commit messages. When --first-parent is
-specified, git-svn only follows the first parent of each commit, effectively
-ignoring commits brought into the current branch through merge-operations.
+These commands tries to detect the upstream subversion branch by traversing
+the first parent of each commit (starting at HEAD), looking for an embedded
+'git-svn-id' line in the commit messages. When --upstream is specified,
+git-svn starts the traversal at the specified commit instead of HEAD.
 
 --
 
diff --git a/git-svn.perl b/git-svn.perl
index d21eb7f..947a944 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -59,7 +59,7 @@ my ($_stdin, $_help, $_edit,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
-	$_prefix, $_no_checkout, $_verbose, $_first_parent);
+	$_prefix, $_no_checkout, $_verbose, $_upstream);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -119,14 +119,14 @@ my %cmd = (
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
 			  'no-rebase' => \$_no_rebase,
-			  'first-parent' => \$_first_parent,
+			  'upstream=s' => \$_upstream,
 			%cmt_opts, %fc_opts } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
 			{ 'revision|r=i' => \$_revision,
-			  'first-parent' => \$_first_parent
+			  'upstream=s' => \$_upstream
 			} ],
 	'multi-fetch' => [ \&cmd_multi_fetch,
 	                   "Deprecated alias for $0 fetch --all",
@@ -148,11 +148,11 @@ my %cmd = (
 			  'authors-file|A=s' => \$_authors,
 			  'color' => \$Git::SVN::Log::color,
 			  'pager=s' => \$Git::SVN::Log::pager,
-			  'first-parent' => \$_first_parent
+			  'upstream=s' => \$_upstream
 			} ],
 	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
 			{
-			  'first-parent' => \$_first_parent
+			  'upstream=s' => \$_upstream
 			} ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
@@ -160,7 +160,7 @@ my %cmd = (
 			  'strategy|s=s' => \$_strategy,
 			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
-			  'first-parent' => \$_first_parent,
+			  'upstream=s' => \$_upstream,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
@@ -818,9 +818,9 @@ sub cmt_metadata {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my @args = ('log', '--no-color');
-	push @args, '--first-parent' if $_first_parent;
-	my ($fh, $ctx) = command_output_pipe(@args, $head);
+	my @args = ('log', '--no-color', '--first-parent');
+	push @args, ($_upstream ? $_upstream : $head);
+	my ($fh, $ctx) = command_output_pipe(@args);
 	my $hash;
 	my %max;
 	while (<$fh>) {
-- 
1.5.3.1.g0e33-dirty
