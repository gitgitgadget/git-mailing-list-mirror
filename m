From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add test-script for git-merge porcelain
Date: Fri, 21 Sep 2007 20:23:19 +0200
Message-ID: <1190398999-7350-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 20:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYnAc-0001cf-1X
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 20:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbXIUSYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 14:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbXIUSYA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 14:24:00 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:64419 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbXIUSX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 14:23:59 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8LIMmqv011520;
	Fri, 21 Sep 2007 20:22:48 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58867>

This test-script tries to excercise the porcelainish aspects of git-merge.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 t/t7600-merge.sh |  317 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 317 insertions(+), 0 deletions(-)
 create mode 100644 t/t7600-merge.sh

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
new file mode 100644
index 0000000..9e58636
--- /dev/null
+++ b/t/t7600-merge.sh
@@ -0,0 +1,317 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Lars Hjemli
+#
+
+test_description='git-merge
+
+Testing basic merge operations/option parsing.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "
+1
+2
+3
+4
+5
+6
+7
+8
+9
+" > file &&
+	git add file &&
+	git commit -m "commit 0" &&
+	git tag c0 &&
+	c0=$(git rev-parse HEAD) &&
+	echo "
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+" > file &&
+	git add file &&
+	git commit -m "commit 1" &&
+	git tag c1 &&
+	c1=$(git rev-parse HEAD) &&
+	git reset --hard "$c0" &&
+	echo "
+1
+2
+3
+4
+5 X
+6
+7
+8
+9
+" > file &&
+	git add file &&
+	git commit -m "commit 2" &&
+	git tag c2 &&
+	c2=$(git rev-parse HEAD) &&
+	git reset --hard "$c0" &&
+	echo "
+1
+2
+3
+4
+5
+6
+7
+8
+9 X
+" > file &&
+	git add file &&
+	git commit -m "commit 3" &&
+	git tag c3 &&
+	c3=$(git rev-parse HEAD)
+	git reset --hard "$c0"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'test option parsing' '
+	if git merge -$ c1
+	then
+		echo "[OOPS] -$ accepted"
+		false
+	fi &&
+	if git merge --no-such c1
+	then
+		echo "[OOPS] --no-such accepted"
+		false
+	fi &&
+	if git merge -s foobar c1
+	then
+		echo "[OOPS] -s foobar accepted"
+		false
+	fi &&
+	if git merge -s=foobar c1
+	then
+		echo "[OOPS] -s=foobar accepted"
+		false
+	fi &&
+	if git merge -m
+	then
+		echo "[OOPS] missing commit msg accepted"
+		false
+	fi &&
+	if git merge
+	then
+		echo "[OOPS] missing commit references accepted"
+		false
+	fi
+'
+
+test_expect_success 'merge c0 with c1' '
+	git reset --hard c0 &&
+	git merge c1 &&
+	test "$c1" = "$(git rev-parse HEAD)"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'verify merge result' '
+	echo "
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+" > result.1 &&
+	cmp -s file result.1
+'
+
+test_expect_success 'merge c1 with c2' '
+	git reset --hard c1 &&
+	git merge c2 &&
+	test "$c1" = "$(git rev-parse HEAD^1)" &&
+	test "$c2" = "$(git rev-parse HEAD^2)"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'verify merge result' '
+	echo "
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9
+" > result.1-5 &&
+	cmp -s file result.1-5
+'
+
+test_expect_success 'merge c1 with c2 and c3' '
+	git reset --hard c1 &&
+	git merge c2 c3 &&
+	test "$c1" = "$(git rev-parse HEAD^1)" &&
+	test "$c2" = "$(git rev-parse HEAD^2)" &&
+	test "$c3" = "$(git rev-parse HEAD^3)"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'verify merge result' '
+	echo "
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9 X
+" > result.1-5-9 &&
+	cmp -s file result.1-5-9
+'
+
+test_expect_success 'merge c0 with c1 (no-commit)' '
+	git reset --hard c0 &&
+	git merge --no-commit c1 &&
+	if test "$c1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] fast-forward not performed"
+		false
+	fi &&
+	if ! cmp -s file result.1
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (no-commit)' '
+	git reset --hard c1 &&
+	git merge --no-commit c2 &&
+	if test "$c1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] HEAD changed"
+		false
+	fi &&
+	if ! cmp -s file result.1-5
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi &&
+	if test "$c2" != "$(cat .git/MERGE_HEAD)"
+	then
+		echo "[OOPS] MERGE_HEAD is wrong"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 and c3 (no-commit)' '
+	git reset --hard c1 &&
+	git merge --no-commit c2 c3 &&
+	if test "$c1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] HEAD changed"
+		false
+	fi &&
+	if ! cmp -s file result.1-5-9
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi &&
+	if ! grep -q "$c2" .git/MERGE_HEAD
+	then
+		echo "[OOPS] c2 not in MERGE_HEAD"
+		false
+	fi &&
+	if ! grep -q "$c3" .git/MERGE_HEAD
+	then
+		echo "[OOPS] c3 not in MERGE_HEAD"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (squash)' '
+	git reset --hard c0 &&
+	git merge --squash c1 &&
+	if test "$c0" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] HEAD changed"
+		false
+	fi &&
+	if ! cmp -s file result.1
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi &&
+	if test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD exists"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (squash)' '
+	git reset --hard c1 &&
+	git merge --squash c2 &&
+	if test "$c1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] new commit created"
+		false
+	fi &&
+	if ! cmp -s file result.1-5
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi &&
+	if test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD exists"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 and c3 (squash)' '
+	git reset --hard c1 &&
+	git merge --squash c2 c3 &&
+	if test "$c1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] HEAD changed"
+		false
+	fi &&
+	if ! cmp -s file result.1-5-9
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi &&
+	if test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD exists"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_done
-- 
1.5.3.2.82.g75c8d
