From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 4/6] am --abort: revert changes introduced by failed 3way merge
Date: Sat,  6 Jun 2015 19:46:10 +0800
Message-ID: <1433591172-27077-5-git-send-email-pyokagan@gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 13:46:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CYm-0005Ec-Vn
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbbFFLqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:46:40 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36207 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbbFFLqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:46:37 -0400
Received: by pabqy3 with SMTP id qy3so65429624pab.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o062jB/hMPpL8rPr65S6u80OLg+cweh7AN0tV8nPpUs=;
        b=jTpH+lv+eFqjm9qFDfiQNUqg/nvx7gdkn7e1+fXGumAyxnTfPHhazntnU2ZNjLCyHS
         wW5Vw9WSZMH6OZCYIm6QXsloJm7ClKNLcKl/Lr4a/77CBeD4SuNRWejrNFovmfJbE0FN
         ksCS2YLBU0j5cJ+dpUQ+nWAal43jzJ0Wd1vxtD+4f9cUl2AxgJKKlkxcoGDOIuRnAuB8
         csudBjL1QciKKO7fe84AxnAPgBvb8yzrmzF9N2i2d4ghhwCI0Lw3quOEmxFEuwjRiCmk
         KIOoSxohoUaydXJleNkkHYV/hjitI4RCihFgqAMO2afQDjBUg1FB0B61BpXZdp4W925t
         DUVw==
X-Received: by 10.68.241.9 with SMTP id we9mr13379008pbc.59.1433591196791;
        Sat, 06 Jun 2015 04:46:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id on3sm9344587pbc.69.2015.06.06.04.46.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 04:46:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270920>

Even when a merge conflict occurs with am --3way, the index will be
modified with the results of any successfully merged files. These
changes to the index will not be reverted with a
"git read-tree --reset -u HEAD ORIG_HEAD", as git read-tree will not be
aware of how the current index differs from HEAD or ORIG_HEAD.

To fix this, we first reset any conflicting entries in the index. The
resulting index will contain the results of successfully merged files
introduced by the failed merge. We write this index to a tree, and then
use git read-tree to fast-forward this "index tree" back to ORIG_HEAD,
thus undoing all the changes from the failed merge.

When we are on an unborn branch, HEAD and ORIG_HEAD will not point to
valid trees. In this case, use an empty tree.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh           |  6 +++++-
 t/t4151-am-abort.sh | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 67f4f25..e4fe3ed 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -519,7 +519,11 @@ then
 		git rerere clear
 		if safe_to_abort
 		then
-			git read-tree --reset -u HEAD ORIG_HEAD
+			head_tree=$(git rev-parse --verify -q HEAD || echo $empty_tree) &&
+			git read-tree --reset -u $head_tree $head_tree &&
+			index_tree=$(git write-tree) &&
+			orig_head=$(git rev-parse --verify -q ORIG_HEAD || echo $empty_tree) &&
+			git read-tree -m -u $index_tree $orig_head
 			git reset ORIG_HEAD
 		fi
 		rm -fr "$dotest"
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index ea4a49e..2366042 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -70,6 +70,17 @@ test_expect_success 'am -3 --skip removes otherfile-4' '
 	test 4 = "$(cat otherfile-4)" &&
 	git am --skip &&
 	test_cmp_rev initial HEAD &&
+	test -z "$(git ls-files -u)" &&
+	test_path_is_missing otherfile-4
+'
+
+test_expect_success 'am -3 --abort removes otherfile-4' '
+	git reset --hard initial &&
+	test_must_fail git am -3 0003-*.patch &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 4 = "$(cat otherfile-4)" &&
+	git am --abort &&
+	test_cmp_rev initial HEAD &&
 	test -z $(git ls-files -u) &&
 	test_path_is_missing otherfile-4
 '
@@ -102,4 +113,16 @@ test_expect_success 'am -3 --skip clears index on unborn branch' '
 	test_path_is_missing tmpfile
 '
 
+test_expect_success 'am -3 --abort removes otherfile-4 on unborn branch' '
+	git checkout -f --orphan orphan &&
+	git reset &&
+	rm -f otherfile-4 file-1 &&
+	test_must_fail git am -3 0003-*.patch &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 4 = "$(cat otherfile-4)" &&
+	git am --abort &&
+	test -z "$(git ls-files -u)" &&
+	test_path_is_missing otherfile-4
+'
+
 test_done
-- 
2.1.4
