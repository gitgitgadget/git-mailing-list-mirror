X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] git-svn: error out from dcommit on a parent-less commit
Date: Thu, 23 Nov 2006 14:54:03 -0800
Message-ID: <1164322445180-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Thu, 23 Nov 2006 22:54:36 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32165>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNSR-0005y8-Mj for gcvg-git@gmane.org; Thu, 23 Nov
 2006 23:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757482AbWKWWyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 17:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbWKWWyJ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 17:54:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:2004 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757482AbWKWWyH (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 17:54:07 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id ACB802DC034; Thu, 23 Nov 2006 14:54:05 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 23 Nov 2006
 14:54:05 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

dcommit would unconditionally append "~1" to a commit in order
to generate a diff.  Now we generate a meaningful error message
if we try to generate an impossible diff.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 80b7b87..f0db4af 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -589,6 +589,13 @@ sub dcommit {
 	chomp(my @refs = safe_qx(qw/git-rev-list --no-merges/, "$gs..HEAD"));
 	my $last_rev;
 	foreach my $d (reverse @refs) {
+		if (quiet_run('git-rev-parse','--verify',"$d~1") != 0) {
+			die "Commit $d\n",
+			    "has no parent commit, and therefore ",
+			    "nothing to diff against.\n",
+			    "You should be working from a repository ",
+			    "originally created by git-svn\n";
+		}
 		unless (defined $last_rev) {
 			(undef, $last_rev, undef) = cmt_metadata("$d~1");
 			unless (defined $last_rev) {
-- 
1.4.4.1.g22a08
