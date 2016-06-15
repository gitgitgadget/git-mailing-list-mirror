From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/6] Add test-script for git-merge porcelain
Date: Mon, 24 Sep 2007 00:51:40 +0200
Message-ID: <1190587905-700-2-git-send-email-hjemli@gmail.com>
References: <1190587905-700-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:52:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaIz-0002CH-8s
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbXIWWv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbXIWWvZ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:51:25 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:42786 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753AbXIWWvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:51:23 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8NMp91M023085;
	Mon, 24 Sep 2007 00:51:10 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190587905-700-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58996>

This test-script excercises the porcelainish aspects of git-merge, and
does it thoroughly enough to detect a small bug already noticed by Junio:
squashing an octopus generates a faulty .git/SQUASH_MSG.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 t/t7600-merge.sh |  344 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 344 insertions(+), 0 deletions(-)
 create mode 100755 t/t7600-merge.sh

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
new file mode 100755
index 0000000..dec6ea2
--- /dev/null
+++ b/t/t7600-merge.sh
@@ -0,0 +1,344 @@
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
+cat >file <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9
+EOF
+
+cat >file.1 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+EOF
+
+cat >file.5 <<EOF
+1
+2
+3
+4
+5 X
+6
+7
+8
+9
+EOF
+
+cat >file.9 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9 X
+EOF
+
+cat  >result.1 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+EOF
+
+cat >result.1-5 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9
+EOF
+
+cat >result.1-5-9 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9 X
+EOF
+
+create_merge_msgs() {
+	echo "Merge commit 'c2'" >msg.1-5 &&
+	echo "Merge commit 'c2'; commit 'c3'" >msg.1-5-9 &&
+	echo "Squashed commit of the following:" >squash.1 &&
+	echo >>squash.1 &&
+	git log --no-merges ^HEAD c1 >>squash.1 &&
+	echo "Squashed commit of the following:" >squash.1-5 &&
+	echo >>squash.1-5 &&
+	git log --no-merges ^HEAD c2 >>squash.1-5 &&
+	echo "Squashed commit of the following:" >squash.1-5-9 &&
+	echo >>squash.1-5-9 &&
+	git log --no-merges ^HEAD c2 c3 >>squash.1-5-9
+}
+
+verify_diff() {
+	if ! diff -u "$1" "$2"
+	then
+		echo "$3"
+		false
+	fi
+}
+
+verify_merge() {
+	verify_diff "$2" "$1" "[OOPS] bad merge result" &&
+	if test $(git ls-files -u | wc -l) -gt 0
+	then
+		echo "[OOPS] unmerged files"
+		false
+	fi &&
+	if ! git diff --exit-code
+	then
+		echo "[OOPS] working tree != index"
+		false
+	fi &&
+	if test -n "$3"
+	then
+		git show -s --pretty=format:%s HEAD >msg.act &&
+		verify_diff "$3" msg.act "[OOPS] bad merge message"
+	fi
+}
+
+verify_head() {
+	if test "$1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] HEAD != $1"
+		false
+	fi
+}
+
+verify_parents() {
+	i=1
+	while test $# -gt 0
+	do
+		if test "$1" != "$(git rev-parse HEAD^$i)"
+		then
+			echo "[OOPS] HEAD^$i != $1"
+			return 1
+		fi
+		i=$(expr $i + 1)
+		shift
+	done
+}
+
+verify_mergeheads() {
+	i=1
+	if ! test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD is missing"
+		false
+	fi &&
+	while test $# -gt 0
+	do
+		head=$(head -n $i .git/MERGE_HEAD | tail -n 1)
+		if test "$1" != "$head"
+		then
+			echo "[OOPS] MERGE_HEAD $i != $1"
+			return 1
+		fi
+		i=$(expr $i + 1)
+		shift
+	done
+}
+
+verify_no_mergehead() {
+	if test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD exists"
+		false
+	fi
+}
+
+
+test_expect_success 'setup' '
+	git add file &&
+	test_tick &&
+	git commit -m "commit 0" &&
+	git tag c0 &&
+	c0=$(git rev-parse HEAD) &&
+	cp file.1 file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 1" &&
+	git tag c1 &&
+	c1=$(git rev-parse HEAD) &&
+	git reset --hard "$c0" &&
+	cp file.5 file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 2" &&
+	git tag c2 &&
+	c2=$(git rev-parse HEAD) &&
+	git reset --hard "$c0" &&
+	cp file.9 file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 3" &&
+	git tag c3 &&
+	c3=$(git rev-parse HEAD)
+	git reset --hard "$c0" &&
+	create_merge_msgs
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
+	verify_merge file result.1 &&
+	verify_head "$c1"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2' '
+	git reset --hard c1 &&
+	test_tick &&
+	git merge c2 &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 and c3' '
+	git reset --hard c1 &&
+	test_tick &&
+	git merge c2 c3 &&
+	verify_merge file result.1-5-9 msg.1-5-9 &&
+	verify_parents $c1 $c2 $c3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (no-commit)' '
+	git reset --hard c0 &&
+	git merge --no-commit c1 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (no-commit)' '
+	git reset --hard c1 &&
+	git merge --no-commit c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_mergeheads $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 and c3 (no-commit)' '
+	git reset --hard c1 &&
+	git merge --no-commit c2 c3 &&
+	verify_merge file result.1-5-9 &&
+	verify_head $c1 &&
+	verify_mergeheads $c2 $c3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (squash)' '
+	git reset --hard c0 &&
+	git merge --squash c1 &&
+	verify_merge file result.1 &&
+	verify_head $c0 &&
+	verify_no_mergehead &&
+	verify_diff squash.1 .git/SQUASH_MSG "[OOPS] bad squash message"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (squash)' '
+	git reset --hard c1 &&
+	git merge --squash c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_no_mergehead &&
+	verify_diff squash.1-5 .git/SQUASH_MSG "[OOPS] bad squash message"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 and c3 (squash)' '
+	git reset --hard c1 &&
+	git merge --squash c2 c3 &&
+	verify_merge file result.1-5-9 &&
+	verify_head $c1 &&
+	verify_no_mergehead &&
+	verify_diff squash.1-5-9 .git/SQUASH_MSG "[OOPS] bad squash message"
+'
+
+test_debug 'gitk --all'
+
+test_done
-- 
1.5.3.2.82.g75c8d
