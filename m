From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] merge-recursive: demonstrate an incorrect conflict with submodule
Date: Tue, 08 Jun 2010 13:34:12 +0200
Message-ID: <4C0E2AB4.2010008@viscovery.net>
References: <4C1009EE-3A67-4DF9-9F45-493CD463AEF9@dazjorz.com> <4C0DDBC8.9030909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Diederik van der Boor <vdboor@codindomain.com>
To: Sjors Gielen <dazjorz@dazjorz.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 13:34:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLx4X-0001Sk-Hl
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 13:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab0FHLeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 07:34:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35654 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0FHLeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 07:34:15 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OLx4O-0003Rq-Ne; Tue, 08 Jun 2010 13:34:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6A8EC1660F;
	Tue,  8 Jun 2010 13:34:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C0DDBC8.9030909@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148661>

From: Johannes Sixt <j6t@kdbg.org>

When one side of a merge turns a directory into a submodule, and the other
side does not touch that directory (but has other non-conflicting changes),
then a merge should succeed. But currently, it does not; it rather fails
with a file/directory conflict.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 6/8/2010 7:57, schrieb Johannes Sixt:
> The *only* curious thing after your cherry-pick is this:
> 
>> #	added by us:        contrib/isf-qt
> 
> because contrib/isf-qt is not touched by the commit that you are
> cherry-picking.

Here's a test case that exhibits the bug in merge-recursive;
at least, I think it is a bug.

-- Hannes

 t/t3030-merge-recursive.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 9929f82..9eae6e9 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -22,6 +22,7 @@ test_expect_success 'setup 1' '
 	git branch df-2 &&
 	git branch df-3 &&
 	git branch remove &&
+	git branch submod &&
 
 	echo hello >>a &&
 	cp a d/e &&
@@ -236,6 +237,17 @@ test_expect_success 'setup 6' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup 7' '
+
+	git checkout submod &&
+	git rm d/e &&
+	test_tick &&
+	git commit -m "remove d/e" &&
+	git update-index --add --cacheinfo 160000 $c1 d &&
+	test_tick &&
+	git commit -m "make d/ a submodule"
+'
+
 test_expect_success 'merge-recursive simple' '
 
 	rm -fr [abcd] &&
@@ -551,4 +563,21 @@ test_expect_success 'merge removes empty directories' '
 	test_must_fail test -d d
 '
 
+test_expect_failure 'merge-recursive simple w/submodule' '
+
+	git checkout submod &&
+	git merge remove
+'
+
+test_expect_failure 'merge-recursive simple w/submodule result' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o5 0	a"
+		echo "100644 $o0 0	c"
+		echo "100644 $c1 0	d"
+	) >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.1.75.g68e2c
