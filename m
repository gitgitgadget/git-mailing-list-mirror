From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 11/12] t3418: non-interactive rebase --continue with rerere enabled
Date: Fri,  3 Jul 2015 02:16:39 +0800
Message-ID: <1435861000-25278-12-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3d-0006ab-NM
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbGBSRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:53 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34109 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbGBSRj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:39 -0400
Received: by pdbep18 with SMTP id ep18so49209428pdb.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lcKghU2I6lKqapubM6VGtsbJfrJPMu/jeyE21JPVfO8=;
        b=xOkmy5cInog6PYMF1IQiXOX3rRJRFP/WRfLC0y6mlNy4MCP3ICg9sdlHEqF6bkg2tw
         Xgu+AzlfyxX6LhKWZK7dKXBT5ChW12cPTwg/dYQiQ3AnzaMKkSJZmn6QhdLtIHHdYl6N
         egDpq7gx4aTYVPCltgRvCeXwsfa/ZF8qirwBGyHJV0MwRjluqPX4PLFMPXbjcTikTkB/
         tBE37vH/39O17o+2xl8jub5gocC2rJcJMDTeMwaFQnxd4PhezEsFJOx174IjnDGUOzis
         kiv5jsa7TZXfGGqJII4Ag9MKMMZHggKUNfQYYKKyDdf3RHulD7dqxgBNHjspCxwlaG/3
         HDVw==
X-Received: by 10.66.141.109 with SMTP id rn13mr67772358pab.127.1435861058959;
        Thu, 02 Jul 2015 11:17:38 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273265>

Since 8389b52 (git-rerere: reuse recorded resolve., 2006-01-28), git-am
will call git-rerere to re-use recorded merge conflict resolutions if
any occur in a threeway merge.

Add a test to ensure that git-rerere is called by git-am (which handles
the non-interactive rebase).

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t3418-rebase-continue.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2680375..4428b90 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -40,6 +40,25 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	git rebase --continue
 '
 
+test_expect_success 'non-interactive rebase --continue with rerere enabled' '
+	test_config rerere.enabled true &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	git checkout master &&
+	rm -fr .git/rebase-* &&
+
+	test_must_fail git rebase --onto master master topic &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	cp F2 F2.expected &&
+	git rebase --continue &&
+
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	git checkout master &&
+	test_must_fail git rebase --onto master master topic &&
+	test_cmp F2.expected F2
+'
+
 test_expect_success 'rebase --continue can not be used with other options' '
 	test_must_fail git rebase -v --continue &&
 	test_must_fail git rebase --continue -v
-- 
2.5.0.rc1.81.gfe77482
