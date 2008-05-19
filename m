From: Seth Falcon <seth@userprimary.net>
Subject: [PATCH] Add a --dry-run option to git-svn rebase
Date: Mon, 19 May 2008 07:20:44 -0700
Message-ID: <1211206844-29842-1-git-send-email-seth@userprimary.net>
References: <3c20080519141036.GV396@ziti.local>
Cc: Seth Falcon <seth@userprimary.net>
To: git@vger.kernel.org, normalperson@yhbt.ne
X-From: git-owner@vger.kernel.org Mon May 19 16:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy6Oe-0006YW-6W
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 16:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757925AbYESOai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 10:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757918AbYESOah
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 10:30:37 -0400
Received: from dsl017-040-092.sea1.dsl.speakeasy.net ([69.17.40.92]:41497 "EHLO
	zimbra.evri.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757880AbYESOah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 10:30:37 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 May 2008 10:30:37 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.evri.com (Postfix) with ESMTP id 922F21A2C230;
	Mon, 19 May 2008 07:20:40 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 3.062
X-Spam-Level: ***
X-Spam-Status: No, score=3.062 tagged_above=-10 required=5 tests=[AWL=-0.162,
	BAYES_00=-2.599, HELO_LOCALHOST=3.941, RCVD_IN_PBL=0.905,
	RCVD_IN_SORBS_DUL=0.877, RDNS_DYNAMIC=0.1]
Received: from zimbra.evri.com ([127.0.0.1])
	by localhost (zimbra.evri.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id joUbe-aQUdoo; Mon, 19 May 2008 07:20:39 -0700 (PDT)
Received: from localhost (c-71-197-245-84.hsd1.or.comcast.net [71.197.245.84])
	by zimbra.evri.com (Postfix) with ESMTP id EB2551A2C22E;
	Mon, 19 May 2008 07:20:38 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.316.g377d9.dirty
In-Reply-To: <3c20080519141036.GV396@ziti.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82432>

When working with multiple branches in an svn repository, it can be
useful to verify the svn repository and local tracking branch that will
be used for the rebase operation.

Signed-off-by: Seth Falcon <seth@userprimary.net>
---
 Documentation/git-svn.txt |    8 ++++++--
 git-svn.perl              |    6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c6b56b4..5890028 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -342,11 +342,15 @@ Passed directly to git-rebase when using 'dcommit' if a
 -n::
 --dry-run::
 
-This is only used with the 'dcommit' command.
+This can be used with the 'dcommit' and 'rebase' commands.
 
-Print out the series of git arguments that would show
+For 'dcommit', print out the series of git arguments that would show
 which diffs would be committed to SVN.
 
+For 'rebase', display the local branch associated with the upstream svn
+repository associated with the current branch and the URL of svn
+repository that will be fetched from.
+
 --
 
 ADVANCED OPTIONS
diff --git a/git-svn.perl b/git-svn.perl
index 2c53f39..de52c12 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -176,6 +176,7 @@ my %cmd = (
 			  'strategy|s=s' => \$_strategy,
 			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
+                          'dryrun|n' => \$_dry_run,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
@@ -553,6 +554,11 @@ sub cmd_rebase {
 		die "Unable to determine upstream SVN information from ",
 		    "working tree history\n";
 	}
+        if ($_dry_run) {
+                print "remote-branch: " . $gs->refname . "\n";
+                print "svn-url: " . $url . "\n";
+                return;
+        }
 	if (command(qw/diff-index HEAD --/)) {
 		print STDERR "Cannot rebase with uncommited changes:\n";
 		command_noisy('status');
-- 
1.5.5.1.316.g377d9.dirty
