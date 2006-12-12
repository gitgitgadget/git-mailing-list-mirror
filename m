X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] git-svn: allow dcommit to take an alternate head
Date: Tue, 12 Dec 2006 14:47:01 -0800
Message-ID: <1165963624339-git-send-email-normalperson@yhbt.net>
References: <11659636223725-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Tue, 12 Dec 2006 22:47:43 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g6f98
In-Reply-To: <11659636223725-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34158>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGPL-0007T7-SA for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932533AbWLLWrS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWLLWrQ
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:47:16 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54305 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932534AbWLLWrO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:47:14 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id F40577DC031; Tue, 12 Dec 2006 14:47:12 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 14:47:04 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Previously dcommit would unconditionally commit all patches
up-to and including the current HEAD.  Now if an optional
command-line argument is specified, it will only commit
up to the specified revision.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    6 ++++--
 git-svn.perl              |   11 ++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index a45067e..c589a98 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -57,11 +57,13 @@ See '<<fetch-args,Additional Fetch Arguments>>' if you are interested in
 manually joining branches on commit.
 
 'dcommit'::
-	Commit all diffs from the current HEAD directly to the SVN
+	Commit all diffs from a specified head directly to the SVN
 	repository, and then rebase or reset (depending on whether or
-	not there is a diff between SVN and HEAD).  It is recommended
+	not there is a diff between SVN and head).  It is recommended
 	that you run git-svn fetch and rebase (not pull) your commits
 	against the latest changes in the SVN repository.
+	An optional command-line argument may be specified as an
+	alternative to HEAD.
 	This is advantageous over 'commit' (below) because it produces
 	cleaner, more linear history.
 
diff --git a/git-svn.perl b/git-svn.perl
index 06e89ff..819584b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -604,8 +604,9 @@ sub commit_lib {
 }
 
 sub dcommit {
+	my $head = shift || 'HEAD';
 	my $gs = "refs/remotes/$GIT_SVN";
-	chomp(my @refs = safe_qx(qw/git-rev-list --no-merges/, "$gs..HEAD"));
+	chomp(my @refs = safe_qx(qw/git-rev-list --no-merges/, "$gs..$head"));
 	my $last_rev;
 	foreach my $d (reverse @refs) {
 		if (quiet_run('git-rev-parse','--verify',"$d~1") != 0) {
@@ -632,16 +633,16 @@ sub dcommit {
 	}
 	return if $_dry_run;
 	fetch();
-	my @diff = safe_qx(qw/git-diff-tree HEAD/, $gs);
+	my @diff = safe_qx('git-diff-tree', $head, $gs);
 	my @finish;
 	if (@diff) {
 		@finish = qw/rebase/;
 		push @finish, qw/--merge/ if $_merge;
 		push @finish, "--strategy=$_strategy" if $_strategy;
-		print STDERR "W: HEAD and $gs differ, using @finish:\n", @diff;
+		print STDERR "W: $head and $gs differ, using @finish:\n", @diff;
 	} else {
-		print "No changes between current HEAD and $gs\n",
-		      "Hard resetting to the latest $gs\n";
+		print "No changes between current $head and $gs\n",
+		      "Resetting to the latest $gs\n";
 		@finish = qw/reset --mixed/;
 	}
 	sys('git', @finish, $gs);
-- 
1.4.4.2.g6f98
