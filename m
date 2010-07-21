From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t3508: add check_head_differs_from() helper function and use
	it
Date: Wed, 21 Jul 2010 06:25:02 +0200
Message-ID: <20100721042503.1948.5144.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:39:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obvzx-0007WR-SO
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759380Ab0GVNjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:39:37 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:60447 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757522Ab0GVNjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:39:36 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 34963800075B;
	Thu, 22 Jul 2010 15:39:35 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 266C580021D8;
	Thu, 22 Jul 2010 15:39:35 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 893A38000E97;
	Thu, 22 Jul 2010 15:39:34 +0200 (CEST)
X-ME-UUID: 20100722133934562.893A38000E97@mwinf2f18.orange.fr
X-git-sha1: 2b10d59e207ff647b31019727ba0f852aa5257c0 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151456>

In a test like:

test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"

the --verify does not accomplish much, since the exit status of
git rev-parse is not propagated to test. So it is more robust to
define and use the helper functions check_head_differs_from() and
check_head_equals() as done by this patch.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3508-cherry-pick-many-commits.sh |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 6044173..0f61495 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -4,6 +4,18 @@ test_description='test cherry-picking many commits'
 
 . ./test-lib.sh
 
+check_head_differs_from() {
+	head=$(git rev-parse --verify HEAD) &&
+	arg=$(git rev-parse --verify "$1") &&
+	test "$head" != "$arg"
+}
+
+check_head_equals() {
+	head=$(git rev-parse --verify HEAD) &&
+	arg=$(git rev-parse --verify "$1") &&
+	test "$head" = "$arg"
+}
+
 test_expect_success setup '
 	echo first > file1 &&
 	git add file1 &&
@@ -36,7 +48,7 @@ test_expect_success 'cherry-pick first..fourth works' '
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
 	test_cmp expected actual &&
-	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+	check_head_differs_from fourth
 '
 
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
@@ -53,7 +65,7 @@ test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
 	test_cmp expected actual &&
-	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+	check_head_differs_from fourth
 '
 
 test_expect_success 'cherry-pick --ff first..fourth works' '
@@ -63,7 +75,7 @@ test_expect_success 'cherry-pick --ff first..fourth works' '
 	git cherry-pick --ff first..fourth &&
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
-	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify fourth)"
+	check_head_equals fourth
 '
 
 test_expect_success 'cherry-pick -n first..fourth works' '
@@ -113,7 +125,7 @@ test_expect_success 'cherry-pick -3 fourth works' '
 	git cherry-pick -3 fourth &&
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
-	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+	check_head_differs_from fourth
 '
 
 test_expect_success 'cherry-pick --stdin works' '
@@ -123,7 +135,7 @@ test_expect_success 'cherry-pick --stdin works' '
 	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
-	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+	check_head_differs_from fourth
 '
 
 test_done
-- 
1.7.2.rc3.133.g31b0a
