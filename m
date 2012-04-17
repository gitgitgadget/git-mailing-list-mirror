From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v6 3/4] git-cherry-pick: Add test to validate new options
Date: Tue, 17 Apr 2012 14:20:08 -0400
Message-ID: <1334686809-17634-4-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
Cc: Clemens Buchacher <drizzd@aon.at>, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 20:21:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKD1P-0005YR-69
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116Ab2DQSUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:20:55 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:53770 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2DQSUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 14:20:54 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKD1A-00007p-Vi; Tue, 17 Apr 2012 14:20:51 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195785>

Since we've added the --allow-empty and --keep-redundant-commits
options to git cherry-pick we should also add a test to ensure that its working
properly.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
---
 t/t3505-cherry-pick-empty.sh |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index c10b28c..d513127 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -18,7 +18,12 @@ test_expect_success setup '
 	echo third >> file1 &&
 	git add file1 &&
 	test_tick &&
-	git commit --allow-empty-message -m ""
+	git commit --allow-empty-message -m "" &&
+
+	git checkout master &&
+	git checkout -b empty-branch2 &&
+	test_tick &&
+	git commit --allow-empty -m "empty"
 
 '
 
@@ -48,4 +53,22 @@ test_expect_success 'index lockfile was removed' '
 
 '
 
+test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
+	git checkout master &&
+	echo fourth >> file2 &&
+	git add file2 &&
+	git commit -m "fourth" &&
+	test_must_fail git cherry-pick empty-branch2
+'
+
+test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
+	git checkout master &&
+	git cherry-pick --allow-empty empty-branch2
+'
+
+test_expect_success 'cherry pick with --keep-redundant-commits' '
+	git checkout master &&
+	git cherry-pick --keep-redundant-commits HEAD^
+'
+
 test_done
-- 
1.7.7.6
