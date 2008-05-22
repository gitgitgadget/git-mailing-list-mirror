From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] New merge tests
Date: Wed, 21 May 2008 18:16:45 -0700
Message-ID: <1211419009-9741-3-git-send-email-gitster@pobox.com>
References: <1211419009-9741-1-git-send-email-gitster@pobox.com>
 <1211419009-9741-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 03:17:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyzRK-0002Gi-Vm
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 03:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762589AbYEVBRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 21:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbYEVBRE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 21:17:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762527AbYEVBRC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 21:17:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D436684A
	for <git@vger.kernel.org>; Wed, 21 May 2008 21:17:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A52FD6849 for <git@vger.kernel.org>; Wed, 21 May 2008 21:16:59 -0400
 (EDT)
X-Mailer: git-send-email 1.5.5.1.499.g878b8
In-Reply-To: <1211419009-9741-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C802F628-279C-11DD-A78E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82593>

From: Sverre Hvammen Johansen <hvammen@gmail.com>

Introduce new merge tests for preparation of new features:

  --ff=<fast forward option>
  Head reduction
  --ff=only

Set up the framework (based on t7600) and add some test cases
that should succeed independent of the new features.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 t/t7601-merge-ff-options.sh |  477 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 477 insertions(+), 0 deletions(-)
 create mode 100755 t/t7601-merge-ff-options.sh

diff --git a/t/t7601-merge-ff-options.sh b/t/t7601-merge-ff-options.sh
new file mode 100755
index 0000000..e499bf5
--- /dev/null
+++ b/t/t7601-merge-ff-options.sh
@@ -0,0 +1,477 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Sverre Hvammen Johansen, based on t7600 by Lars Hjemli
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
+10
+11
+12
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
+10
+11
+12
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
+10
+11
+12
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
+10
+11
+12
+EOF
+
+cat  >result.0 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
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
+10
+11
+12
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
+10
+11
+12
+EOF
+
+cat >result.9 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9 X
+10
+11
+12
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
+10
+11
+12
+EOF
+
+cat >result.1-5-9-13 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9 X
+10
+11
+12
+13 x
+EOF
+
+cat >result.1-5-13 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >result.5-13 <<EOF
+1
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >result.1-13 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >extend <<EOF
+13 x
+EOF
+
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
+# Setup with the following commits:
+#
+#             y3
+#            /  \
+#           /    \
+#         y1      y2
+#         | \    / |
+#         |  \  /  |
+#         x1  x0  x2
+#         |  /  \  |
+#         | /    \ |
+#         c1      c2
+#           \    /
+#            \  /
+#             c0---c3
+#
+
+test_expect_success 'setup' '
+	git add file &&
+	test_tick &&
+	git commit -m "commit 0" &&
+	git tag c0 &&
+	c0=$(git rev-parse HEAD) &&
+
+	cp file.1 file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 1" &&
+	git tag c1 &&
+	c1=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c0" &&
+	cp file.5 file &&
+	git add file &&
+	git commit -m "commit 2" &&
+	test_tick &&
+	git tag c2 &&
+	c2=$(git rev-parse HEAD) &&
+
+	git reset --hard "$c0" &&
+	cp file.9 file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 3" &&
+	git tag c3 &&
+	c3=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c1" &&
+	cat extend >>file &&
+	git add file &&
+	git commit -m "commit 4" &&
+	git tag x1 &&
+	x1=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c1" &&
+	git merge "$c2" &&
+	git tag x0 &&
+	x0=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c2" &&
+	cat extend >>file &&
+	git add file &&
+	git commit -m "commit 5" &&
+	git tag x2 &&
+	x2=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$x1" &&
+	git merge "$x0" &&
+	git tag y1 &&
+	y1=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$x0" &&
+	git merge "$x2" &&
+	git tag y2 &&
+	y2=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$y1" &&
+	git merge "$y2" &&
+	git tag y3 &&
+	y3=$(git rev-parse HEAD) &&
+	test_tick &&
+	git reset --hard "$c0" &&
+	create_merge_msgs &&
+
+	git reset --hard x1 &&
+	git clone .git clone &&
+	git config remote.clone.url clone &&
+	git config remote.clone.fetch "+refs/heads/*:refs/remotes/clone/*" &&
+
+	(mkdir new && cd new && git init && cp ../file.9 file2 && git add file2 && test_tick && git commit -m "commit new") &&
+	git config remote.new.url new &&
+	git config remote.new.fetch "+refs/heads/*:refs/remotes/new/*"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 and c0' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge c0 c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge c1 c2 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0, c2, c0, and c1' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge c0 c2 c0 c1 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge y2 with x0, c3, and c0' '
+	git reset --hard y2 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge x0 c3 c0 &&
+	verify_merge file result.1-5-9-13 &&
+	verify_parents $y2 $c3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x0 with y2, c3, and c0' '
+	git reset --hard x0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge y2 c3 c0 &&
+	verify_merge file result.1-5-9-13 &&
+	verify_parents $y2 $c3
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 and x1' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge c2 x1 &&
+	verify_merge file result.1-5-13 &&
+	verify_parents $c2 $x1
+'
+
+test_debug 'gitk --all'
+
+test_done
-- 
1.5.5.1.499.g878b8
