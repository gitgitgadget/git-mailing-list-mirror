X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] git-svn: correctly handle revision 0 in SVN repositories
Date: Thu, 23 Nov 2006 14:54:04 -0800
Message-ID: <1164322446983-git-send-email-normalperson@yhbt.net>
References: <1164322445180-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Thu, 23 Nov 2006 22:54:35 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
In-Reply-To: <1164322445180-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32164>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNSQ-0005y8-1u for gcvg-git@gmane.org; Thu, 23 Nov
 2006 23:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757484AbWKWWyK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 17:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbWKWWyJ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 17:54:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:3028 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757484AbWKWWyI (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 17:54:08 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id E9FD07DC0A8; Thu, 23 Nov 2006 14:54:06 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 23 Nov 2006
 14:54:06 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

some SVN repositories have a revision 0 (committed by no author
and no date) when created; so when we need to ensure that we
check any revision variables are defined, and not just
non-zero.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index f0db4af..6feae56 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -232,7 +232,7 @@ sub rebuild {
 		my @commit = grep(/^git-svn-id: /,`git-cat-file commit $c`);
 		next if (!@commit); # skip merges
 		my ($url, $rev, $uuid) = extract_metadata($commit[$#commit]);
-		if (!$rev || !$uuid) {
+		if (!defined $rev || !$uuid) {
 			croak "Unable to extract revision or UUID from ",
 				"$c, $commit[$#commit]\n";
 		}
@@ -832,8 +832,14 @@ sub commit_diff {
 		print STDERR "Needed URL or usable git-svn id command-line\n";
 		commit_diff_usage();
 	}
-	my $r = shift || $_revision;
-	die "-r|--revision is a required argument\n" unless (defined $r);
+	my $r = shift;
+	unless (defined $r) {
+		if (defined $_revision) {
+			$r = $_revision
+		} else {
+			die "-r|--revision is a required argument\n";
+		}
+	}
 	if (defined $_message && defined $_file) {
 		print STDERR "Both --message/-m and --file/-F specified ",
 				"for the commit message.\n",
@@ -2493,7 +2499,7 @@ sub extract_metadata {
 	my $id = shift or return (undef, undef, undef);
 	my ($url, $rev, $uuid) = ($id =~ /^git-svn-id:\s(\S+?)\@(\d+)
 							\s([a-f\d\-]+)$/x);
-	if (!$rev || !$uuid || !$url) {
+	if (!defined $rev || !$uuid || !$url) {
 		# some of the original repositories I made had
 		# identifiers like this:
 		($rev, $uuid) = ($id =~/^git-svn-id:\s(\d+)\@([a-f\d\-]+)/);
-- 
1.4.4.1.g22a08
