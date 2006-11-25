X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (take 3)] gitweb: Use git-show-ref instead of git-peek-remote
Date: Sat, 25 Nov 2006 11:32:08 +0100
Message-ID: <11644507284105-git-send-email-jnareb@gmail.com>
References: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Sat, 25 Nov 2006 10:30:54 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uQBY043zWUJx/DvlgGuGy0Tvn/7oqIEzAMDbxYec+VFCn0S66lJnxbN2MGn54Fxwptac7UPLhtNlDT/rgtM/pB58d9X8Bj1HF4RX03X+nB4FETe3F0C0jy++f8nSdl/LuLbiRLuZguKQRaHtvcfD1+RcYOEmfB9iWnTav/ZLCNs=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32277>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnuo5-0005vY-6f for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966408AbWKYKac (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 05:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966403AbWKYKac
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:30:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:48187 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966408AbWKYKab
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 05:30:31 -0500
Received: by ug-out-1314.google.com with SMTP id 44so827559uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 02:30:30 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr8653395ugl.1164450629853; Sat, 25
 Nov 2006 02:30:29 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 a1sm15959343ugf.2006.11.25.02.30.29; Sat, 25 Nov 2006 02:30:29 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAPAW8Sm011877; Sat, 25 Nov 2006 11:32:09 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAPAW8la011876; Sat, 25 Nov 2006 11:32:08 +0100
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Use "git show-ref --dereference" instead of "git peek-remote
$projectroot/project" in git_get_references. git-show-ref is faster
than git-peek-remote (40ms vs 56ms user+sys for git.git repository);
even faster is reading info/refs file (if it exists), but the
information in info/refs can be stale; that and the fact that
info/refs is meant for dumb protocol transports, not for gitweb.

git-show-ref is available since v1.4.4; the output format is slightly
different than git-peek-remote output format.

While at it make git_get_references return hash in list context,
and reference to hash (as it used to do) in scalar and void contexts.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is the final version.

Once again, I'm extremly sorry for the confusion with the previous
version...

 gitweb/gitweb.perl |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f06cd3e..1cded75 100755
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
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
@@ -1170,7 +1171,7 @@ sub git_get_references {
 		}
 	}
 	close $fd or return;
-	return \%refs;
+	return wantarray ? %refs : \%refs;
 }
 
 sub git_get_rev_name_tags {
-- 
1.4.4.1
