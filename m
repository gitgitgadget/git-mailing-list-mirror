From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v3 3/4] git-cherry-pick: Add test to validate new options
Date: Tue, 10 Apr 2012 11:47:47 -0400
Message-ID: <1334072868-9435-4-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 17:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHdJ6-0004VE-Lw
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 17:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759129Ab2DJPsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 11:48:31 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:49345 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673Ab2DJPsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 11:48:31 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SHdIs-0005XD-Ly; Tue, 10 Apr 2012 11:48:28 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195098>

Since we've added the --allow-empty and --keep-redundant-commits
options to git cherry-pick we should also add a test to ensure that its working
properly

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
---
 t/t3505-cherry-pick-empty.sh |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index c10b28c..9d419ae 100755
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
+	echo fourth >> file2 &&
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
+test_expect_success 'cherry pick with --keep-redundant-commits' '
+	git checkout master && {
+		git cherry-pick --keep-redundant-commits HEAD^
+		test "$?" = 0
+	}
+'
+
 test_done
-- 
1.7.7.6
