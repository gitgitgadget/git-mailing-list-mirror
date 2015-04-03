From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 1/4] t4059: test 'diff --cc' with a change from only few parents
Date: Fri,  3 Apr 2015 18:58:33 +0300
Message-ID: <1428076716-4449-2-git-send-email-max@max630.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye40y-0008TX-S8
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 18:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbbDCQAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 12:00:08 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:46628
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753142AbbDCP6d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 11:58:33 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id BTyS1q0045B68XE01TyX2s; Fri, 03 Apr 2015 08:58:33 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1428076716-4449-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266712>

If `git diff --cc` is used with 2 or more parents, then
it shows all hunks which have changed compared to at least 2 parents.
Which is reasonable, because those places are likely places for
conflicts, and it should be displayed how they were resolved.
But, preliminary path filtering passes a path only it was changed
compared to each parent. So, if a hunk which has not changed compared to
some of parents is shown if there are more changed hunks in the file,
but not shown if it is the only change.

This looks inconsistent and for some scenarios it is desirable to show
such changes.

Add the test which demonstrates the issue.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t4059-diff-cc-not-affected-by-path-filtering.sh | 108 ++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100755 t/t4059-diff-cc-not-affected-by-path-filtering.sh

diff --git a/t/t4059-diff-cc-not-affected-by-path-filtering.sh b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
new file mode 100755
index 0000000..3e6e59b
--- /dev/null
+++ b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='combined diff filtering is not affected by preliminary path filtering'
+# Since diff --cc allows use not only real parents but any commits, use merge
+# base here as the 3rd "parent". The trick was suggested in $gmane/191557 to
+# spot changes which were discarded during conflict resolution.
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir short &&
+	mkdir long &&
+	for fn in win1 win2 merge delete base only1 only2
+	do
+		test_seq 3 >short/$fn &&
+		git add short/$fn &&
+		test_seq 11 >long/$fn &&
+		git add long/$fn || return $?
+	done &&
+	git commit -m mergebase &&
+	git branch mergebase &&
+
+	for fn in win1 win2 merge delete base only1
+	do
+		for dir in short long
+		do
+			sed -e "s/^2/2change1/" -e "s/^7/7change1/" $dir/$fn >sed.new &&
+			mv sed.new $dir/$fn &&
+			git add $dir/$fn || return $?
+		done || return $?
+	done &&
+	sed -e "s/^7/7change1/" long/only2 >sed.new &&
+	mv sed.new long/only2 &&
+	git add long/only2 &&
+	git commit -m branch1 &&
+	git branch branch1 &&
+
+	git reset --hard mergebase &&
+	for fn in win1 win2 merge delete base only2
+	do
+		for dir in short long
+		do
+			sed -e "s/^2/2change2/" -e "s/^11/11change2/" $dir/$fn >sed.new &&
+			mv sed.new $dir/$fn &&
+			git add $dir/$fn || return $?
+		done || return $?
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
