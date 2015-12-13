From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/2] git-p4: fix handling of multiple depot paths
Date: Sun, 13 Dec 2015 20:07:14 +0000
Message-ID: <1450037234-15344-3-git-send-email-luke@diamand.org>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 21:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Cvg-0007F8-6z
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 21:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbbLMUH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 15:07:28 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36783 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbLMUHY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 15:07:24 -0500
Received: by mail-wm0-f44.google.com with SMTP id n186so93173916wmn.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kFo8DpTxwDA1kyqxrF9cw5ZDRr6pUlo0JwthdLeScyw=;
        b=DGsJaYpgC3UVBlMYMWSsTiCIdrT1Qis5wdC41qlh1kI+1+NCirGiDJ2WvB+pGrQel2
         PlIzZtDJ95MZiq1QbTVmgCyR0Kudc6nELdCmHUHdISXfw6a0SKnYYzlZ3dVRgLflS37r
         vbiLPdD1AM4BeQKLmBWq7cMWPyvSwf6v/cG70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kFo8DpTxwDA1kyqxrF9cw5ZDRr6pUlo0JwthdLeScyw=;
        b=mn2rNdxVF2CvicoJKrWNsuOXQR2D5P+BH3nXQUaMr2PXDwfkHnHjdt+3dIt4iOo+pz
         ntQ2U4+wjArugDuVfM31rcTd+NHiYZSMWEbtgRrudsX223ZIpIl3gOWpoZ8ndrhUxDGB
         znaHxFR0CSwnzRKH5MTOymBRoYYrH3HuFmg0IU4YY+ScnqVN08gLuMef0hACVk8zENzn
         R3sTg9ES0+eATlO5xSQiOApAX5sGK06Jxnc5jZun1Qn7xIyyiDNeRky+7lZY5wvAISY8
         GdZrgUh8COY0y2ycxkwI5EdqAAk+e005WcVpsDfegabjX8LNt/SBoZEeb/MWzpyDkyNh
         PjhA==
X-Gm-Message-State: ALoCoQmez716eiMsyZ+Wh4QLRKbt9J1H9jILMTGnyTvdVOXM6lBgnueA7TupvvskaFzr0MfXnGtc5jNTCaySBTD6lAmXCXDklA==
X-Received: by 10.28.182.11 with SMTP id g11mr21125159wmf.42.1450037243624;
        Sun, 13 Dec 2015 12:07:23 -0800 (PST)
Received: from ethel.local.diamand.org (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id e136sm7404804wma.23.2015.12.13.12.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Dec 2015 12:07:23 -0800 (PST)
X-Mailer: git-send-email 2.6.2.474.g3eb3291
In-Reply-To: <1450037234-15344-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282350>

With multiple depot paths (//depot/pathA, //depot/pathB) if there
are more changes than the changes-block-size limit, then some
of the changes will be skipped. This fixes this by correcting
the loop in p4ChangesForPaths() to reset the "start" point
for each depot.

Suggested-by: James Farwell <jfarwell@vmware.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 8 +++++---
 t/t9818-git-p4-block.sh | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7a9dd6a..a8b5278 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -829,12 +829,14 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         # Retrieve changes a block at a time, to prevent running
         # into a MaxResults/MaxScanRows error from the server.
 
+        start = changeStart
+
         while True:
             cmd = ['changes']
 
             if block_size:
-                end = min(changeEnd, changeStart + block_size)
-                revisionRange = "%d,%d" % (changeStart, end)
+                end = min(changeEnd, start + block_size)
+                revisionRange = "%d,%d" % (start, end)
             else:
                 revisionRange = "%s,%s" % (changeStart, changeEnd)
 
@@ -850,7 +852,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             if end >= changeEnd:
                 break
 
-            changeStart = end + 1
+            start = end + 1
 
     changelist = changes.keys()
     changelist.sort()
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 64510b7..8840a18 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -128,7 +128,7 @@ test_expect_success 'Create a repo with multiple depot paths' '
 	done
 '
 
-test_expect_failure 'Clone repo with multiple depot paths' '
+test_expect_success 'Clone repo with multiple depot paths' '
 	(
 		cd "$git" &&
 		git p4 clone --changes-block-size=4 //depot/pathA@all //depot/pathB@all \
-- 
2.6.2.474.g3eb3291
