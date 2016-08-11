X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: avoid printing filenames of files we're not tracking
Date: Sat,  4 Nov 2006 21:51:10 -0800
Message-ID: <11627058712379-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Sun, 5 Nov 2006 05:51:34 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.3.ga126
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30950>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggaub-00077U-7h for gcvg-git@gmane.org; Sun, 05 Nov
 2006 06:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161095AbWKEFvO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 00:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWKEFvO
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 00:51:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:8874 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1161095AbWKEFvN (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 00:51:13 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 30B7C2DC034; Sat,  4 Nov 2006 21:51:12 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 04 Nov 2006
 21:51:11 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is purely an aesthetic change, we already skip importing of
files that don't affect the subdirectory we import.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 37ecc51..cc3335a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2662,11 +2662,12 @@ sub libsvn_connect {
 }
 
 sub libsvn_get_file {
-	my ($gui, $f, $rev) = @_;
+	my ($gui, $f, $rev, $chg) = @_;
 	my $p = $f;
 	if (length $SVN_PATH > 0) {
 		return unless ($p =~ s#^\Q$SVN_PATH\E/##);
 	}
+	print "\t$chg\t$f\n" unless $_q;
 
 	my ($hash, $pid, $in, $out);
 	my $pool = SVN::Pool->new;
@@ -2769,8 +2770,7 @@ sub libsvn_fetch {
 		$pool->clear;
 	}
 	foreach (@amr) {
-		print "\t$_->[0]\t$_->[1]\n" unless $_q;
-		libsvn_get_file($gui, $_->[1], $rev)
+		libsvn_get_file($gui, $_->[1], $rev, $_->[0]);
 	}
 	close $gui or croak $?;
 	return libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
@@ -2848,8 +2848,7 @@ sub libsvn_traverse {
 			if (defined $files) {
 				push @$files, $file;
 			} else {
-				print "\tA\t$file\n" unless $_q;
-				libsvn_get_file($gui, $file, $rev);
+				libsvn_get_file($gui, $file, $rev, 'A');
 			}
 		}
 	}
-- 
1.4.3.3.ga126
