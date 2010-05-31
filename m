From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/8] revert: add tests to check cherry-picking many commits
Date: Mon, 31 May 2010 21:42:37 +0200
Message-ID: <20100531194240.28729.28049.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:04:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHmR-0000XE-FX
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab0FADEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:04:32 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42068 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab0FADEb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:04:31 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 62E6481805F;
	Tue,  1 Jun 2010 05:04:23 +0200 (CEST)
X-git-sha1: 362a85c5476f90de71dd8f281546c827b0aed0fe 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148067>

Note that there is an expected failure when running:

	git cherry-pick -3 fourth

that's because:

	git rev-list --no-walk -3 fourth

produce only one commit and not 3 as "--no-walk" seems to
take over "-3".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3508-cherry-pick-many-commits.sh |   95 +++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100755 t/t3508-cherry-pick-many-commits.sh

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
new file mode 100755
index 0000000..3b87efe
--- /dev/null
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='test cherry-picking many commits'
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
+test_expect_success 'revert ^first fourth works' '
+	git checkout master &&
+	git reset --hard fourth &&
+	test_tick &&
+	git revert ^first fourth &&
+	git diff --quiet first &&
+	git diff --cached --quiet first &&
+	git diff --quiet HEAD first
+'
+
+test_expect_success 'revert fourth fourth~1 fourth~2 works' '
+	git checkout master &&
+	git reset --hard fourth &&
+	test_tick &&
+	git revert fourth fourth~1 fourth~2 &&
+	git diff --quiet first &&
+	git diff --cached --quiet first &&
+	git diff --quiet HEAD first
+'
+
+test_expect_failure 'cherry-pick -3 fourth works' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick -3 fourth &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+'
+
+test_done
-- 
1.7.1.361.g42de.dirty
