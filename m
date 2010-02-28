From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 09/12] cherry-pick: add tests for new --ff option
Date: Sun, 28 Feb 2010 23:22:04 +0100
Message-ID: <20100228222208.2260.78213.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrXp-0006Rr-2W
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032156Ab0B1WXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:23:00 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48570 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032135Ab0B1WWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 330BE81812E;
	Sun, 28 Feb 2010 23:22:40 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 28CC08180C9;
	Sun, 28 Feb 2010 23:22:38 +0100 (CET)
X-git-sha1: 8dcc1c3e3bef016bd14d63e9287fbd8e64591f1f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141279>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3506-cherry-pick-ff.sh |   98 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100755 t/t3506-cherry-pick-ff.sh

diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
new file mode 100755
index 0000000..e17ae71
--- /dev/null
+++ b/t/t3506-cherry-pick-ff.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='test cherry-picking with --ff option'
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
+	echo second >> file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "second" &&
+	git tag second
+'
+
+test_expect_success 'cherry-pick using --ff fast forwards' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick --ff second &&
+	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify second)"
+'
+
+test_expect_success 'cherry-pick not using --ff does not fast forwards' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick second &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify second)"
+'
+
+#
+# We setup the following graph:
+#
+#	      B---C
+#	     /   /
+#	first---A
+#
+# (This has been taken from t3502-cherry-pick-merge.sh)
+#
+test_expect_success 'merge setup' '
+	git checkout master &&
+	git reset --hard first &&
+	echo new line >A &&
+	git add A &&
+	test_tick &&
+	git commit -m "add line to A" A &&
+	git tag A &&
+	git checkout -b side first &&
+	echo new line >B &&
+	git add B &&
+	test_tick &&
+	git commit -m "add line to B" B &&
+	git tag B &&
+	git checkout master &&
+	git merge side &&
+	git tag C &&
+	git checkout -b new A
+'
+
+test_expect_success 'cherry-pick a non-merge with --ff and -m should fail' '
+	git reset --hard A -- &&
+	test_must_fail git cherry-pick --ff -m 1 B &&
+	git diff --exit-code A --
+'
+
+test_expect_success 'cherry pick a merge with --ff but without -m should fail' '
+	git reset --hard A -- &&
+	test_must_fail git cherry-pick --ff C &&
+	git diff --exit-code A --
+'
+
+test_expect_success 'cherry pick with --ff a merge (1)' '
+	git reset --hard A -- &&
+	git cherry-pick --ff -m 1 C &&
+	git diff --exit-code C &&
+	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify C)"
+'
+
+test_expect_success 'cherry pick with --ff a merge (2)' '
+	git reset --hard B -- &&
+	git cherry-pick --ff -m 2 C &&
+	git diff --exit-code C &&
+	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify C)"
+'
+
+test_expect_success 'cherry pick a merge relative to nonexistent parent with --ff should fail' '
+	git reset --hard B -- &&
+	test_must_fail git cherry-pick --ff -m 3 C
+'
+
+test_done
-- 
1.7.0.321.g2d270
