From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v8 3/4] git-cherry-pick: Add test to validate new options
Date: Fri, 20 Apr 2012 10:36:16 -0400
Message-ID: <1334932577-31232-4-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 16:37:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLExu-0001lK-M8
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 16:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab2DTOh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 10:37:29 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40359 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652Ab2DTOhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 10:37:05 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SLExI-000211-Q0; Fri, 20 Apr 2012 10:37:02 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195993>

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
