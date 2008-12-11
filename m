From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Show a failure of rebase -p if the merge had a conflict
Date: Thu, 11 Dec 2008 17:21:01 +0100
Message-ID: <1229012461-31377-1-git-send-email-j6t@kdbg.org>
Cc: Andreas Ericsson <ae@op5.se>,
	Stephen Haberman <stephen@exigencecorp.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 11 17:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAoJH-00081Z-HT
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 17:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbYLKQVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 11:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756742AbYLKQVP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 11:21:15 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37267 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881AbYLKQVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 11:21:15 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1LAoHd-0003aR-N6; Thu, 11 Dec 2008 17:21:09 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 66D6054D; Thu, 11 Dec 2008 17:21:01 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 3EEC8FA46; Thu, 11 Dec 2008 17:21:01 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc2.22.gf3bf84
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102803>

This extends t3409-rebase-preserve-merges by a case where the merge that
is rebased has a conflict. Therefore, the rebase stops and expects that
the user resolves the conflict. However, currently rebase --continue
fails because .git/rebase-merge/author-script is missing.

The test script had allocated two identical clones, but only one of them
(clone2) was used. Now we use both as indicated in the comment. Also, an
instance of && was missing in the setup part.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  BTW, I'm not 100% sure whether the additional tests of what to expect
  from the test if it did not fail are correct.

  I am unable to fix the failure.

  -- Hannes

  [Sorry, Junio, for the resend. git send-email & PEBCAK. :-/ ]

 t/t3409-rebase-preserve-merges.sh |   43 ++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8cde40f..02a6401 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -11,7 +11,7 @@ Run "git rebase -p" and check that merges are properly carried along
 GIT_AUTHOR_EMAIL=bogus_email_address
 export GIT_AUTHOR_EMAIL
 
-#echo 'Setting up:
+#Clone 1 (trivial merge):
 #
 #A1--A2  <-- origin/master
 # \   \
@@ -19,7 +19,15 @@ export GIT_AUTHOR_EMAIL
 #   \
 #    B2  <-- origin/topic
 #
-#'
+#Clone 2 (conflicting merge):
+#
+#A1--A2--B3   <-- origin/master
+# \       \
+#  B1------M  <-- topic
+#   \
+#    B2       <-- origin/topic
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
 
 	git clone ./. clone2
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
