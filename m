From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 4/4] revert: add tests to check cherry-picking a range of
	commits
Date: Sat, 29 May 2010 06:40:43 +0200
Message-ID: <20100529044044.569.79624.chriscool@tuxfamily.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 29 06:41:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIDrc-0007PG-Jp
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 06:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab0E2Elc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 00:41:32 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56316 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab0E2Elb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 00:41:31 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DF51981803D;
	Sat, 29 May 2010 06:41:23 +0200 (CEST)
X-git-sha1: ddaa7ba46da02b41ce6ab13f56efbf88c4d23a5d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100529043738.569.85482.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147952>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3508-cherry-pick-range.sh |   65 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100755 t/t3508-cherry-pick-range.sh

diff --git a/t/t3508-cherry-pick-range.sh b/t/t3508-cherry-pick-range.sh
new file mode 100755
index 0000000..d83b74b
--- /dev/null
+++ b/t/t3508-cherry-pick-range.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='test cherry-picking a range of commits'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo first > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "first" &&
+	git tag first &&
+
+	git checkout -b other &&
+	for val in second third fourth
+	do
+		echo $val >> file1 &&
+		git add file1 &&
+		test_tick &&
+		git commit -m "$val" &&
+		git tag $val
+	done
+'
+
+test_expect_success 'cherry-pick first..fourth works' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick first..fourth &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+'
+
+test_expect_success 'cherry-pick --ff first..fourth works' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick --ff first..fourth &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify fourth)"
+'
+
+test_expect_success 'cherry-pick -n first..fourth works' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick -n first..fourth &&
+	git diff --quiet other &&
+	git diff --cached --quiet other &&
+	git diff --quiet HEAD first
+'
+
+test_expect_success 'revert first..fourth works' '
+	git checkout master &&
+	git reset --hard fourth &&
+	test_tick &&
+	git revert first..fourth &&
+	git diff --quiet first &&
+	git diff --cached --quiet first &&
+	git diff --quiet HEAD first
+'
+
+test_done
-- 
1.7.1.346.g7c1d7.dirty
