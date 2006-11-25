X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Add author and committer email extraction to parse_commit
Date: Sat, 25 Nov 2006 15:54:32 +0100
Message-ID: <11644664852840-git-send-email-jnareb@gmail.com>
References: <11644664743455-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 25 Nov 2006 14:54:17 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=te2n1KAUtid3Vo1mE5jf4CF0rR/JgjRodjOcSrjZite7N600pXEMQsMhEUzjQyoL6azmb3f5OFZFfAUoFs6UZfyiEq59yTnt03P7+zyNCMAO6PgOoZwh9I1A6GxAMSPH56+K5NTO/ZMUh/mnbC5YFzD3Q0+MoJxL6ziWHFqU0qI=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11644664743455-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32289>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnyuq-0001AE-Rh for gcvg-git@gmane.org; Sat, 25 Nov
 2006 15:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966602AbWKYOxw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 09:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966603AbWKYOxw
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 09:53:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:38525 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966602AbWKYOxu
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 09:53:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so849710uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 06:53:49 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr8923186ugh.1164466429318; Sat, 25
 Nov 2006 06:53:49 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 55sm12391470ugq.2006.11.25.06.53.48; Sat, 25 Nov 2006 06:53:49 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAPEsx26016975; Sat, 25 Nov 2006 15:55:10 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAPEsj0A016973; Sat, 25 Nov 2006 15:54:45 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Extract author email to 'author_email' key, and comitter mail to
'committer_mail' key; uniquify committer and author lines handling
by the way.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1cded75..2ebd9d7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1294,8 +1294,9 @@ sub parse_commit {
 			$co{'author'} = $1;
 			$co{'author_epoch'} = $2;
 			$co{'author_tz'} = $3;
-			if ($co{'author'} =~ m/^([^<]+) </) {
-				$co{'author_name'} = $1;
+			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
+				$co{'author_name'}  = $1;
+				$co{'author_email'} = $2;
 			} else {
 				$co{'author_name'} = $co{'author'};
 			}
@@ -1304,7 +1305,12 @@ sub parse_commit {
 			$co{'committer_epoch'} = $2;
 			$co{'committer_tz'} = $3;
 			$co{'committer_name'} = $co{'committer'};
-			$co{'committer_name'} =~ s/ <.*//;
+			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
+				$co{'committer_name'}  = $1;
+				$co{'committer_email'} = $2;
+			} else {
+				$co{'committer_name'} = $co{'committer'};
+			}
 		}
 	}
 	if (!defined $co{'tree'}) {
-- 
1.4.4.1
