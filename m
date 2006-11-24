X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Use git-show-ref instead of git-peek-remote
Date: Fri, 24 Nov 2006 23:01:22 +0100
Message-ID: <11644056823095-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Fri, 24 Nov 2006 22:00:13 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=S0rwdtfZ1sGDfeIYIiActRlSHgrSh39Y1y30yi107VSH+WEVACC1++6qRvn6BT01RvdnJddbSppy8gmB/4Fwo7nRA26D1aaEmRx6FNh9l/vn15z2PdUKfhsi0RWhMsMN5l38gKJusuykEpDsrfmq61lMHox/IF3+Y6k0M5dHj2w=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32240>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnj5S-0006UZ-KU for gcvg-git@gmane.org; Fri, 24 Nov
 2006 22:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966225AbWKXV7o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 16:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966210AbWKXV7o
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 16:59:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:26058 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966226AbWKXV7n
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 16:59:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so773859uga for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 13:59:41 -0800 (PST)
Received: by 10.67.119.13 with SMTP id w13mr7847287ugm.1164405581799; Fri, 24
 Nov 2006 13:59:41 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 y7sm15311247ugc.2006.11.24.13.59.41; Fri, 24 Nov 2006 13:59:41 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAOM1NV0031077; Fri, 24 Nov 2006 23:01:24 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAOM1MHU031076; Fri, 24 Nov 2006 23:01:22 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Use "git show-ref --dereference" instead of "git peek-remote ." in
git_get_references. git-show-ref is faster than git-peek-remote; even
faster is reading info/refs file (if it exists), but the information
in info/refs can be stale.

git-show-ref is available since v1.4.4; the output format is slightly
different than git-peek-remote output format.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f06cd3e..290751f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1154,14 +1154,15 @@ sub git_get_last_activity {
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
-	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
-	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
-	open my $fd, "-|", $GIT, "peek-remote", "$projectroot/$project/"
+	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
+	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
+	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
+		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type
 		or return;
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
+		if ($line =~ m/^([0-9a-fA-F]{40}) refs\/($type\/?[^\^]+)/) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
-- 
1.4.4.1
