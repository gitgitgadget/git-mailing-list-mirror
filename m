From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 2/8] tests: add checking that combine-diff emits only correct paths
Date: Mon,  3 Feb 2014 16:47:16 +0400
Message-ID: <9ee3e17af9a8da1f47423a74171d5cb95293f677.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:46:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIuZ-0006tq-NW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaBCMpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 07:45:55 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37374 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbaBCMpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:45:54 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIuO-0004Zd-I4; Mon, 03 Feb 2014 16:45:52 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIwC-0007Fj-3L; Mon, 03 Feb 2014 16:47:44 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241427>

where "correct paths" stands for paths that are different to all
parents.

Up until now, we were testing combined diff only on one file, or on
several files which were all different (t4038-diff-combined.sh).

As recent thinko in "simplify intersect_paths() further" showed, and
also, since we are going to rework code for finding paths different to
all parents, lets write at least basic tests.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 t/t4057-diff-combined-paths.sh | 106 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100755 t/t4057-diff-combined-paths.sh

diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
new file mode 100755
index 0000000..e6e457d
--- /dev/null
+++ b/t/t4057-diff-combined-paths.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='combined diff show only paths that are different to all parents'
+
+. ./test-lib.sh
+
+# verify that diffc.expect matches output of
+# `git diff -c --name-only HEAD HEAD^ HEAD^2`
+diffc_verify() {
+	git diff -c --name-only HEAD HEAD^ HEAD^2 >diffc.actual &&
+	test_cmp diffc.expect diffc.actual
+}
+
+test_expect_success 'trivial merge - combine-diff empty' '
+	for i in `test_seq 1 9`
+	do
+		echo $i >$i.txt	&&
+		git add $i.txt
+	done &&
+	git commit -m "init" &&
+	git checkout -b side &&
+	for i in `test_seq 2 9`
+	do
+		echo $i/2 >>$i.txt
+	done &&
+	git commit -a -m "side 2-9" &&
+	git checkout master &&
+	echo 1/2 >1.txt &&
+	git commit -a -m "master 1" &&
+	git merge side &&
+	>diffc.expect &&
+	diffc_verify
+'
+
+
+test_expect_success 'only one trully conflicting path' '
+	git checkout side &&
+	for i in `test_seq 2 9`
+	do
+		echo $i/3 >>$i.txt
+	done &&
+	echo "4side" >>4.txt &&
+	git commit -a -m "side 2-9 +4" &&
+	git checkout master &&
+	for i in `test_seq 1 9`
+	do
+		echo $i/3 >>$i.txt
+	done &&
+	echo "4master" >>4.txt &&
+	git commit -a -m "master 1-9 +4" &&
+	test_must_fail git merge side &&
+	cat <<-\EOF >4.txt &&
+	4
+	4/2
+	4/3
+	4master
+	4side
+	EOF
+	git add 4.txt &&
+	git commit -m "merge side (2)" &&
+	echo 4.txt >diffc.expect &&
+	diffc_verify
+'
+
+test_expect_success 'merge introduces new file' '
+	git checkout side &&
+	for i in `test_seq 5 9`
+	do
+		echo $i/4 >>$i.txt
+	done &&
+	git commit -a -m "side 5-9" &&
+	git checkout master &&
+	for i in `test_seq 1 3`
+	do
+		echo $i/4 >>$i.txt
+	done &&
+	git commit -a -m "master 1-3 +4hello" &&
+	git merge side &&
+	echo "Hello World" >4hello.txt &&
+	git add 4hello.txt &&
+	git commit --amend &&
+	echo 4hello.txt >diffc.expect &&
+	diffc_verify
+'
+
+test_expect_success 'merge removed a file' '
+	git checkout side &&
+	for i in `test_seq 5 9`
+	do
+		echo $i/5 >>$i.txt
+	done &&
+	git commit -a -m "side 5-9" &&
+	git checkout master &&
+	for i in `test_seq 1 3`
+	do
+		echo $i/4 >>$i.txt
+	done &&
+	git commit -a -m "master 1-3" &&
+	git merge side &&
+	git rm 4.txt &&
+	git commit --amend &&
+	echo 4.txt >diffc.expect &&
+	diffc_verify
+'
+
+test_done
-- 
1.9.rc1.181.g641f458
