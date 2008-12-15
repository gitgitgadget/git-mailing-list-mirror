From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2 updated] Show a failure of rebase -p if the merge had a conflict
Date: Mon, 15 Dec 2008 11:05:30 +0100
Message-ID: <1229335531-32707-1-git-send-email-j6t@kdbg.org>
References: <1229012461-31377-1-git-send-email-j6t@kdbg.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Stephen Haberman <stephen@exigencecorp.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:07:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCALv-0006gs-MU
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbYLOKFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYLOKFp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:05:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4506 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbYLOKFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:05:44 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1LCAKS-0001aB-Hw; Mon, 15 Dec 2008 11:05:39 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 112144E4; Mon, 15 Dec 2008 11:05:32 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id CE450FA46; Mon, 15 Dec 2008 11:05:31 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc2.22.gf3bf84
In-Reply-To: <1229012461-31377-1-git-send-email-j6t@kdbg.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103149>

This extends t3409-rebase-preserve-merges by a case where the merge that
is rebased has a conflict. Therefore, the rebase stops and expects that
the user resolves the conflict. However, currently rebase --continue
fails because .git/rebase-merge/author-script is missing.

The test script had allocated two identical clones, but only one of them
(clone2) was used. Now we use both as indicated in the comment. Also,
two instances of && was missing in the setup part.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This is a resend of the earlier patch with a minor update: I missed one
 instance of && in the setup part, so there were actually two missing.

 -- Hannes

 t/t3409-rebase-preserve-merges.sh |   55 +++++++++++++++++++++++++++++-------
 1 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8cde40f..5ddd1d1 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -11,15 +11,23 @@ Run "git rebase -p" and check that merges are properly carried along
 GIT_AUTHOR_EMAIL=bogus_email_address
 export GIT_AUTHOR_EMAIL
 
-#echo 'Setting up:
+# Clone 1 (trivial merge):
 #
-#A1--A2  <-- origin/master
-# \   \
-#  B1--M  <-- topic
-#   \
-#    B2  <-- origin/topic
+# A1--A2  <-- origin/master
+#  \   \
+#   B1--M  <-- topic
+#    \
+#     B2  <-- origin/topic
 #
-#'
+# Clone 2 (conflicting merge):
+#
+# A1--A2--B3   <-- origin/master
+#  \       \
+#   B1------M  <-- topic
+#    \
+#     B2       <-- origin/topic
+#
+# In both cases, 'topic' is rebased onto 'origin/topic'.
 
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
@@ -37,12 +45,19 @@ test_expect_success 'setup for merge-preserving rebase' \
 	cd clone1 &&
 	git checkout -b topic origin/topic &&
 	git merge origin/master &&
-	cd ..
+	cd .. &&
+
+	echo Fifth > B &&
+	git add B &&
+	git commit -m "Add different B" &&
 
-	git clone ./. clone2
+	git clone ./. clone2 &&
 	cd clone2 &&
 	git checkout -b topic origin/topic &&
-	git merge origin/master &&
+	test_must_fail git merge origin/master &&
+	echo Resolved > B &&
+	git add B &&
+	git commit -m "Merge origin/master into topic" &&
 	cd .. &&
 
 	git checkout topic &&
@@ -51,11 +66,29 @@ test_expect_success 'setup for merge-preserving rebase' \
 '
 
 test_expect_success 'rebase -p fakes interactive rebase' '
-	cd clone2 &&
+	(
+	cd clone1 &&
 	git fetch &&
 	git rebase -p origin/topic &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l)
+	)
+'
+
+test_expect_failure '--continue works after a conflict' '
+	(
+	cd clone2 &&
+	git fetch &&
+	test_must_fail git rebase -p origin/topic &&
+	test 2 = $(git ls-files B | wc -l) &&
+	echo Resolved again > B &&
+	test_must_fail git rebase --continue &&
+	git add B &&
+	git rebase --continue &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Add different" | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge origin" | wc -l)
+	)
 '
 
 test_done
-- 
1.6.1.rc2.22.gf3bf84
