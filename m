From: Brian Gernhardt <brian@silverinsanity.com>
Subject: [PATCH] t4027,4041: Use test -s to test for an empty file
Date: Fri, 25 Jun 2010 13:20:48 -0400
Message-ID: <20100625172047.GA16172@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 19:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSCaL-0001zW-DO
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 19:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab0FYRU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 13:20:56 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56424 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab0FYRUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 13:20:55 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 40FE51FFC05B; Fri, 25 Jun 2010 17:20:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=4.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 824E41FFC057;
	Fri, 25 Jun 2010 17:20:46 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149697>

The tests used a mixture of 'echo -n' (which is non-portable) and either
test_cmp or diff to check if a file is empty.  The much easier and portable
method to check for an empty file is '! test -s'

While we're in t4027, there was an excess test_done.  Remove it.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Changes since v2:
  - extra trailing dashes removed (noticed by Brandon Casey)
  - extra test_done removed (noticed by Junio C Hamano)

 t/t4027-diff-submodule.sh        |   12 ++++++------
 t/t4041-diff-submodule-option.sh |   14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 559b41e..1bd8e5e 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -105,15 +105,15 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
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
-test_done
+
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
 	(
 		cd sub &&
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
index f44b906..8e391cf 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -207,17 +207,17 @@ EOF
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' "
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual
 "
 
 test_expect_success 'submodule contains untracked content (dirty ignored)' "
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual
 "
 
 test_expect_success 'submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual
 "
 
 test_expect_success 'submodule contains untracked and modifed content' "
@@ -240,13 +240,13 @@ EOF
 test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual
 "
 
 test_expect_success 'submodule contains untracked and modifed content (all ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual
 "
 
 test_expect_success 'submodule contains modifed content' "
@@ -295,7 +295,7 @@ EOF
 
 test_expect_success 'modified submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual
 "
 
 test_expect_success 'modified submodule contains untracked and modifed content' "
@@ -331,7 +331,7 @@ EOF
 test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	! test -s actual
 "
 
 test_expect_success 'modified submodule contains modifed content' "
-- 
1.7.1.756.gb48b1
