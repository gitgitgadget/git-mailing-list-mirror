From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH] git-svn: add support for --first-parent
Date: Wed,  5 Sep 2007 11:35:29 +0200
Message-ID: <1188984929315-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 11:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISrL1-0000ng-SU
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214AbXIEJhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756210AbXIEJhr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:37:47 -0400
Received: from mail42.e.nsc.no ([193.213.115.42]:59743 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756182AbXIEJhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:37:45 -0400
Received: from localhost.localdomain (ti231210a341-5020.bb.online.no [85.166.63.158])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id l859b1tY024601;
	Wed, 5 Sep 2007 11:37:02 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.1.g7e90d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57703>

When git-svn uses git-log to find embedded 'git-svn-id'-lines in commit
messages, it can get confused when local history contains merges with
other git-svn branches. But if --first-parent is supplied to git-log,
working_head_info() will only see 'branch-local' commits and thus the
first commit containing a 'git-svn-id' line should refer to the correct
subversion branch.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This passes the test-suite and I've used it to correctly dcommit against a
real-life repository after merging subversion-branches in git ('dcommit -n'
reported the wrong subversion branch while 'dcommit -n --first-parent' got
it right, so I did 'dcommit --first-parent' and then inspected the logs and
diffs in the subversion repo and everything looked swell).

But I'm not a perl person, my understanding of git-svn is limited and the
use of --first-parent may not be the right solution to the problem...

 Documentation/git-svn.txt |   10 ++++++++++
 git-svn.perl              |   17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index be2e34e..42d7b82 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -317,6 +317,16 @@ This is only used with the 'dcommit' command.
 Print out the series of git arguments that would show
 which diffs would be committed to SVN.
 
+--first-parent::
+
+This is only used with the 'dcommit', 'rebase', 'log', 'find-rev' and
+'show-ignore' commands.
+
+These commands tries to detect the upstream subversion branch by means of
+the embedded 'git-svn-id' line in commit messages. When --first-parent is
+specified, git-svn only follows the first parent of each commit, effectively
+ignoring commits brought into the current branch through merge-operations.
+
 --
 
 ADVANCED OPTIONS
diff --git a/git-svn.perl b/git-svn.perl
index d3c8cd0..d21eb7f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -59,7 +59,7 @@ my ($_stdin, $_help, $_edit,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
-	$_prefix, $_no_checkout, $_verbose);
+	$_prefix, $_no_checkout, $_verbose, $_first_parent);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -119,12 +119,15 @@ my %cmd = (
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
 			  'no-rebase' => \$_no_rebase,
+			  'first-parent' => \$_first_parent,
 			%cmt_opts, %fc_opts } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
-			{ 'revision|r=i' => \$_revision } ],
+			{ 'revision|r=i' => \$_revision,
+			  'first-parent' => \$_first_parent
+			} ],
 	'multi-fetch' => [ \&cmd_multi_fetch,
 	                   "Deprecated alias for $0 fetch --all",
 			   { 'revision|r=s' => \$_revision, %fc_opts } ],
@@ -145,15 +148,19 @@ my %cmd = (
 			  'authors-file|A=s' => \$_authors,
 			  'color' => \$Git::SVN::Log::color,
 			  'pager=s' => \$Git::SVN::Log::pager,
+			  'first-parent' => \$_first_parent
 			} ],
 	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
-			{ } ],
+			{
+			  'first-parent' => \$_first_parent
+			} ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
 			  'verbose|v' => \$_verbose,
 			  'strategy|s=s' => \$_strategy,
 			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
+			  'first-parent' => \$_first_parent,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
@@ -811,7 +818,9 @@ sub cmt_metadata {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my ($fh, $ctx) = command_output_pipe('log', '--no-color', $head);
+	my @args = ('log', '--no-color');
+	push @args, '--first-parent' if $_first_parent;
+	my ($fh, $ctx) = command_output_pipe(@args, $head);
 	my $hash;
 	my %max;
 	while (<$fh>) {
-- 
1.5.3.1.g7e90d-dirty
