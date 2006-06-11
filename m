From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/5] git-svn: don't allow commit if svn tree is not current
Date: Sun, 11 Jun 2006 00:03:45 -0700
Message-ID: <1150009432591-git-send-email-normalperson@yhbt.net>
References: <11500094252972-git-send-email-normalperson@yhbt.net> <11500094271080-git-send-email-normalperson@yhbt.net> <11500094281515-git-send-email-normalperson@yhbt.net> <11500094292561-git-send-email-normalperson@yhbt.net> <11500094313384-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 11 09:04:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJzQ-0005iD-BA
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 09:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWFKHD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 03:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFKHDz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 03:03:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:32177 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751559AbWFKHDy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 03:03:54 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BBF057DC021;
	Sun, 11 Jun 2006 00:03:52 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Jun 2006 00:03:52 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g2dc7b-dirty
In-Reply-To: <11500094313384-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21639>

If new revisions are fetched, that implies we haven't merged,
acked, or nacked them yet, and attempting to write the tree
we're committing means we'd silently clobber the newly fetched
changes.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 8bc3d69..72129de 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -309,9 +309,16 @@ sub commit {
 	}
 	chomp @revs;
 
-	fetch();
-	chdir $SVN_WC or croak $!;
+	chdir $SVN_WC or croak "Unable to chdir $SVN_WC: $!\n";
 	my $info = svn_info('.');
+	my $fetched = fetch();
+	if ($info->{Revision} != $fetched->{revision}) {
+		print STDERR "There are new revisions that were fetched ",
+				"and need to be merged (or acknowledged) ",
+				"before committing.\n";
+		exit 1;
+	}
+	$info = svn_info('.');
 	read_uuid($info);
 	my $svn_current_rev =  $info->{'Last Changed Rev'};
 	foreach my $c (@revs) {
-- 
1.3.3.g2dc7b-dirty
