From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH 1/2] t/t4202-log.sh: Add testcases
Date: Thu, 22 Jan 2009 17:37:24 +0100
Message-ID: <1232642245-94405-1-git-send-email-arjen@yaph.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 17:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2i4-00061K-F0
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbZAVQpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756707AbZAVQpI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:45:08 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:3275 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575AbZAVQpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:45:05 -0500
Received: from localhost.localdomain ([194.109.31.155])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id n0MGbPXp090230
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 17:37:25 +0100 (CET)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.6.1.354.gd9e51
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106766>

Add testcases for 'git log --diff-filter=[CM]' (copies and renames).
Also add a testcase for 'git log --follow'.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 t/t4202-log.sh |   59 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 0ab925c..7b976ee 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -16,27 +16,31 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m second &&
 
-	mkdir a &&
-	echo ni >a/two &&
-	git add a/two &&
+	git mv one ichi &&
 	test_tick &&
 	git commit -m third &&
 
-	echo san >a/three &&
-	git add a/three &&
+	cp ichi ein &&
+	git add ein &&
 	test_tick &&
 	git commit -m fourth &&
 
-	git rm a/three &&
+	mkdir a &&
+	echo ni >a/two &&
+	git add a/two &&
+	test_tick &&
+	git commit -m fifth  &&
+
+	git rm a/two &&
 	test_tick &&
-	git commit -m fifth
+	git commit -m sixth
 
 '
 
 test_expect_success 'diff-filter=A' '
 
 	actual=$(git log --pretty="format:%s" --diff-filter=A HEAD) &&
-	expect=$(echo fourth ; echo third ; echo initial) &&
+	expect=$(echo fifth ; echo fourth ; echo third ; echo initial) &&
 	test "$actual" = "$expect" || {
 		echo Oops
 		echo "Actual: $actual"
@@ -60,7 +64,43 @@ test_expect_success 'diff-filter=M' '
 test_expect_success 'diff-filter=D' '
 
 	actual=$(git log --pretty="format:%s" --diff-filter=D HEAD) &&
-	expect=$(echo fifth) &&
+	expect=$(echo sixth ; echo third) &&
+	test "$actual" = "$expect" || {
+		echo Oops
+		echo "Actual: $actual"
+		false
+	}
+
+'
+
+test_expect_success 'diff-filter=R' '
+
+	actual=$(git log -M --pretty="format:%s" --diff-filter=R HEAD) &&
+	expect=$(echo third) &&
+	test "$actual" = "$expect" || {
+		echo Oops
+		echo "Actual: $actual"
+		false
+	}
+
+'
+
+test_expect_success 'diff-filter=C' '
+
+	actual=$(git log -C -C --pretty="format:%s" --diff-filter=C HEAD) &&
+	expect=$(echo fourth) &&
+	test "$actual" = "$expect" || {
+		echo Oops
+		echo "Actual: $actual"
+		false
+	}
+
+'
+
+test_expect_success 'git log --follow' '
+
+	actual=$(git log --follow --pretty="format:%s" ichi) &&
+	expect=$(echo third ; echo second ; echo initial) &&
 	test "$actual" = "$expect" || {
 		echo Oops
 		echo "Actual: $actual"
@@ -72,6 +112,7 @@ test_expect_success 'diff-filter=D' '
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
+	git add one
 	git commit -a -m Second
 '
 
-- 
1.6.1.354.gd9e51
