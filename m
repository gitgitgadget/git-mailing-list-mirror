From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: add -l/--local command to "git svn rebase"
Date: Tue, 13 Mar 2007 11:40:36 -0700
Message-ID: <11738112361307-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 19:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRBvP-0002yA-Fz
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 19:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbXCMSkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 14:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbXCMSkj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 14:40:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40264 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbXCMSki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 14:40:38 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A53C32DC01A;
	Tue, 13 Mar 2007 11:40:36 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Mar 2007 11:40:36 -0700
X-Mailer: git-send-email 1.5.0.3.316.gbd1fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42142>

This avoids fetching new revisions remotely, and is usefuly
versus plain "git rebase" because the user does not have to
specify which remote head to rebase against.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    8 ++++++++
 git-svn.perl              |    7 +++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9b5a3d6..a0d34e0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -104,6 +104,14 @@ accepts.  However '--fetch-all' only fetches from the current
 
 Like 'git-rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
++
+--
+-l;;
+--local;;
+	Do not fetch remotely; only run 'git-rebase' against the
+	last fetched commit from the upstream SVN.
+--
++
 
 'dcommit'::
 	Commit each diff from a specified head directly to the SVN
diff --git a/git-svn.perl b/git-svn.perl
index 326e89f..e845789 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -56,7 +56,7 @@ my ($_stdin, $_help, $_edit,
 	$_message, $_file,
 	$_template, $_shared,
 	$_version, $_fetch_all,
-	$_merge, $_strategy, $_dry_run,
+	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_verbose);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
@@ -145,6 +145,7 @@ my %cmd = (
 			{ 'merge|m|M' => \$_merge,
 			  'verbose|v' => \$_verbose,
 			  'strategy|s=s' => \$_strategy,
+			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
@@ -439,7 +440,9 @@ sub cmd_rebase {
 		command_noisy('status');
 		exit 1;
 	}
-	$_fetch_all ? $gs->fetch_all : $gs->fetch;
+	unless ($_local) {
+		$_fetch_all ? $gs->fetch_all : $gs->fetch;
+	}
 	command_noisy(rebase_cmd(), $gs->refname);
 }
 
-- 
1.5.0.3.316.gbd1fc
