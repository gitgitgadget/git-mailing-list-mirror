From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 1/3] git-svn: Generate mergeinfo for every commit
Date: Thu, 28 Nov 2013 10:52:15 -0500
Message-ID: <1385653937-29595-2-git-send-email-andrew.kw.w@gmail.com>
References: <1385653937-29595-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 16:52:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm3t1-0004kl-1w
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 16:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831Ab3K1PwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 10:52:12 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34544 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab3K1PwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 10:52:10 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so14931077iej.28
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 07:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTOKXDRdzHEm5baEUSmh0pBLvORRpP/bV7ypRQET+6c=;
        b=Et2s6BxkpR67Rk+H7agF8aVtE/OHYRWgYwokQ7hUSRGzAWsIuMDBFw1Eb0aNdhsjwA
         fqHt2q9mUwRqkZ+pea5occCwVGmdCOUAZR9L/oKwe0TukowZucM9N4KJU1RYrE2VnL6Y
         EAaOtipf85f67So5q5LCWnbpOF0YkjwanfqV6vPaVyEzT7QpDgSb0720U/ASvBTQA83N
         VeaEcgxmF2vOkQiVuxt8/HbfywFL3IPgReM2IlJ39UskeKFtEpn81XTz/xi68IybJSt7
         eYQamOsMgKAI5yE1H1HWw9+TFvdLBXCg/ODnSTI1QOODomVDQu8+/8sqQdn+W0PPFAGu
         Cyyg==
X-Received: by 10.42.113.66 with SMTP id b2mr10044042icq.21.1385653930035;
        Thu, 28 Nov 2013 07:52:10 -0800 (PST)
Received: from zanarkand.local (24-212-191-132.cable.teksavvy.com. [24.212.191.132])
        by mx.google.com with ESMTPSA id qi3sm45309190igc.8.2013.11.28.07.52.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 07:52:09 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <1385653937-29595-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238496>

The previous behavior would only generate mergeinfo once using the first
commit, and use that mergeinfo for all remaining commits. The new behavior will
generate it once for every commit.
---
 git-svn.perl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7349ffe..9ddeaf4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -974,8 +974,12 @@ sub cmd_dcommit {
 		} else {
 			my $cmt_rev;
 
-			unless (defined($_merge_info) || ! $push_merge_info) {
-				$_merge_info = populate_merge_info($d, $gs,
+			my $rev_merge_info;
+			if (defined($_merge_info)) {
+				$rev_merge_info = $_merge_info;
+			}
+			unless (defined($rev_merge_info) || ! $push_merge_info) {
+				$rev_merge_info = populate_merge_info($d, $gs,
 				                             $uuid,
 				                             $linear_refs,
 				                             $rewritten_parent);
@@ -993,7 +997,7 @@ sub cmd_dcommit {
 			                       print "Committed r$_[0]\n";
 			                       $cmt_rev = $_[0];
 			                },
-					mergeinfo => $_merge_info,
+					mergeinfo => $rev_merge_info,
 			                svn_path => '');
 
 			my $err_handler = $SVN::Error::handler;
-- 
1.8.5.rc3.5.g96ccada
