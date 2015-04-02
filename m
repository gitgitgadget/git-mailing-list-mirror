From: Max Kirillov <max@max630.net>
Subject: [PATCH 1/4] Add test for showing discarded changes with diff --cc
Date: Thu,  2 Apr 2015 23:34:10 +0300
Message-ID: <1428006853-21212-2-git-send-email-max@max630.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydlp4-0005Fi-IL
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbbDBUee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 16:34:34 -0400
Received: from p3plsmtpa09-09.prod.phx3.secureserver.net ([173.201.193.238]:52509
	"EHLO p3plsmtpa09-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779AbbDBUec (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 16:34:32 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-09.prod.phx3.secureserver.net with 
	id B8aH1q00T5B68XE018aX8u; Thu, 02 Apr 2015 13:34:32 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1428006853-21212-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266671>

If a hunk has been changed in both branches and conflict resolution
fully takes one of branches, discarding all changes that are in the
other, then the merge is not shown in 3-way diff which git uses by
default.

The advice is to use flag --cc and and explicitly add the mergebase was
given in $gmane/191557. It was discovered though that it does not always
work. If the whole file has not changed at all compared to one of
branches then no difference is shown for this file.

This looks inconsistent and for particular scenario of viewing discarded
changes is undesirable.

Add the test which demonstrates the issue.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t4059-diff-merge-with-base.sh | 100 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100755 t/t4059-diff-merge-with-base.sh

diff --git a/t/t4059-diff-merge-with-base.sh b/t/t4059-diff-merge-with-base.sh
new file mode 100755
index 0000000..e650a33
--- /dev/null
+++ b/t/t4059-diff-merge-with-base.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='Diff aware of merge base'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir short &&
+	mkdir long &&
+	for fn in win1 win2 merge delete base only1 only2; do
+		test_seq 3 >short/$fn
+		git add short/$fn &&
+		test_seq 11 >long/$fn &&
+		git add long/$fn
+	done &&
+	git commit -m mergebase &&
+	git branch mergebase &&
+
+	for fn in win1 win2 merge delete base only1; do
+		for dir in short long; do
+			sed -e "s/^2/2change1/" -e "s/^7/7change1/" $dir/$fn >sed.new &&
+			mv sed.new $dir/$fn &&
+			git add $dir/$fn
+		done
+	done &&
+	sed -e "s/^7/7change1/" long/only2 >sed.new &&
+	mv sed.new long/only2 &&
+	git add long/only2 &&
+	git commit -m branch1 &&
+	git branch branch1 &&
+
+	git reset --hard mergebase &&
+	for fn in win1 win2 merge delete base only2; do
+		for dir in short long; do
+			sed -e "s/^2/2change2/" -e "s/^11/11change2/" $dir/$fn >sed.new &&
+			mv sed.new $dir/$fn &&
+			git add $dir/$fn
+		done
+	done &&
+	sed -e "s/^11/11change2/" long/only1 >sed.new &&
+	mv sed.new long/only1 &&
+	git add long/only1 &&
+	git commit -m branch2 &&
+	git branch branch2 &&
+
+	test_must_fail git merge branch1 &&
+	git checkout mergebase -- . &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" >long/base &&
+	git add long/base &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "s/^2/2change1/" >long/win1 &&
+	git add long/win1 &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "s/^2/2change2/" >long/win2 &&
+	git add long/win2 &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "s/^2/2merged/" >long/merge &&
+	git add long/merge &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "/^2/d" >long/delete &&
+	git add long/delete &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "s/^2/2change1/" >long/only1 &&
+	git add long/only1 &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "s/^2/2change2/" >long/only2 &&
+	git add long/only2 &&
+	test_seq 3 >short/base &&
+	git add short/base &&
+	test_seq 3 | sed -e "s/^2/2change1/" >short/win1 &&
+	git add short/win1 &&
+	test_seq 3 | sed -e "s/^2/2change2/" >short/win2 &&
+	git add short/win2 &&
+	test_seq 3 | sed -e "s/^2/2merged/" >short/merge &&
+	git add short/merge &&
+	test_seq 3 | sed -e "/^2/d" >short/delete &&
+	git add short/delete &&
+	test_seq 3 | sed -e "s/^2/2change1/" >short/only1 &&
+	git add short/only1 &&
+	test_seq 3 | sed -e "s/^2/2change2/" >short/only2 &&
+	git add short/only2 &&
+	git commit -m merge &&
+	git branch merge
+'
+
+test_expect_success 'diff with mergebase shows discarded change from parent 2 in merged file' '
+	git diff --cc merge branch1 branch2 mergebase -- long/win1 >actual &&
+	test -s actual
+'
+
+test_expect_success 'diff with mergebase shows discarded change from parent 1 in merged file' '
+	git diff --cc merge branch1 branch2 mergebase -- long/win2 >actual &&
+	test -s actual
+'
+
+test_expect_failure 'diff with mergebase shows fully discarded file from parent 2' '
+	git diff --cc merge branch1 branch2 mergebase -- short/win1 >actual &&
+	test -s actual
+'
+
+test_expect_failure 'diff with mergebase shows fully discarded file from parent 1' '
+	git diff --cc merge branch1 branch2 mergebase -- short/win2 >actual &&
+	test -s actual
+'
+
+test_done
-- 
2.3.4.2801.g3d0809b
