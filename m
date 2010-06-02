From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 6/8] revert: add tests to check cherry-picking many commits
Date: Wed, 02 Jun 2010 07:58:39 +0200
Message-ID: <20100602055842.21504.76127.chriscool@tuxfamily.org>
References: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:59:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgzR-0006zP-HC
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0FBF7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:59:41 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48155 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab0FBF7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:59:39 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B84B7818120;
	Wed,  2 Jun 2010 07:59:31 +0200 (CEST)
X-git-sha1: d2be0496635566a69698b88d64a7f82c6d01c960 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148214>

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
1.7.1.362.g8d752
