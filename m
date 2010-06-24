From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2] t4027,4041: Use test -s to test for an empty file
Date: Thu, 24 Jun 2010 16:10:31 -0400
Message-ID: <1277410231-12326-1-git-send-email-brian@gernhardtsoftware.com>
References: <201006242134.54081.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORslA-0003Fh-Op
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab0FXUKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:10:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53526 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab0FXUKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:10:47 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 50F661FFC061; Thu, 24 Jun 2010 20:10:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 16FBD1FFC057;
	Thu, 24 Jun 2010 20:10:27 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.756.gb48b1
In-Reply-To: <201006242134.54081.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149633>

The tests had used a mixture of 'echo -n' (which is non-portable) and
either test_cmp or diff to check if a file is empty.  The much easier
and portable method to check for an empty file is '! test -s'

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Johannes Sixt wrote:
 > Shouldn't you replace these by
 >
 >	! test -s actual2 &&

 Yes, you're right.  I was just trying to get the tests to run and didn't really pay attention to what it was trying to do.

 t/t4027-diff-submodule.sh        |   10 +++++-----
 t/t4041-diff-submodule-option.sh |   14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 559b41e..8f016aa 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -105,13 +105,13 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules HEAD >actual2 &&
-	echo -n "" | test_cmp - actual2 &&
+	! test -s actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
 	sed -e "1,/^@@/d" actual3 >actual3.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual3.body &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	echo -n "" | test_cmp - actual4
+	! test -s actual4
 '
 test_done
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
@@ -139,11 +139,11 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
-	echo -n "" | test_cmp - actual2 &&
+	! test -s actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
-	echo -n "" | test_cmp - actual3 &&
+	! test -s actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	echo -n "" | test_cmp - actual4
+	! test -s actual4
 '
 
 test_expect_success 'git diff (empty submodule dir)' '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f44b906..db9b64d 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -207,17 +207,17 @@ EOF
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' "
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual -
 "
 
 test_expect_success 'submodule contains untracked content (dirty ignored)' "
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual -
 "
 
 test_expect_success 'submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual -
 "
 
 test_expect_success 'submodule contains untracked and modifed content' "
@@ -240,13 +240,13 @@ EOF
 test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual -
 "
 
 test_expect_success 'submodule contains untracked and modifed content (all ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual -
 "
 
 test_expect_success 'submodule contains modifed content' "
@@ -295,7 +295,7 @@ EOF
 
 test_expect_success 'modified submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual -
 "
 
 test_expect_success 'modified submodule contains untracked and modifed content' "
@@ -331,7 +331,7 @@ EOF
 test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual -
 "
 
 test_expect_success 'modified submodule contains modifed content' "
-- 
1.7.1.756.gb48b1
