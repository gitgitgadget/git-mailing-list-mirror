From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 4/5] git-cherry-pick: Add test to validate new options [v2]
Date: Thu,  5 Apr 2012 15:39:04 -0400
Message-ID: <1333654745-7898-5-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 21:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFsXk-0007vM-8p
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 21:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab2DETkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 15:40:20 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:57302 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab2DETjl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 15:39:41 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFsWv-0005WK-Em; Thu, 05 Apr 2012 15:39:39 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194795>

Since we've added the --allow-empty and --ignore-if-made-empty
options to git cherry-pick we should also add a test to ensure that its working
properly

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
---
 t/t3505-cherry-pick-empty.sh |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index c10b28c..049ed28 100755
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
 
@@ -48,4 +53,28 @@ test_expect_success 'index lockfile was removed' '
 
 '
 
+test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
+	git checkout master &&
+	echo fouth >> file2 &&
+	git add file2 &&
+	git commit -m "fourth" && {
+		git cherry-pick empty-branch2
+		test "$?" = 1 
+	}
+'
+
+test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
+	git checkout master && {
+		git cherry-pick --allow-empty empty-branch2
+		test "$?" = 0
+	}
+'
+
+test_expect_success 'cherry pick with --ignore-if-made-empty' '
+	git checkout master && {
+		git cherry-pick --allow-empty --ignore-if-made-empty empty-branch2
+		test "$?" = 0
+	}
+'
+
 test_done
-- 
1.7.7.6
