From: Max Kirillov <max@max630.net>
Subject: [PATCH v2] git-common-dir: make submodule related variables worktree specific
Date: Thu,  2 Apr 2015 00:28:32 +0300
Message-ID: <1427923712-8177-1-git-send-email-max@max630.net>
References: <1427923407-7939-1-git-send-email-max@max630.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 23:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdQBd-00018r-3c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 23:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbDAV23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 17:28:29 -0400
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:32955
	"EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752335AbbDAV22 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2015 17:28:28 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-10.prod.phx3.secureserver.net with 
	id AlUN1q0055B68XE01lUSnV; Wed, 01 Apr 2015 14:28:27 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1427923407-7939-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266621>

Then submodules in different worktrees will be fully independent.
They can, and should, be initialised and updated separately.

Update t7410-submodule-checkout-to.sh to consider this.

Signed-off-by: Max Kirillov <max@max630.net>
---
Some local slipped into patch which can break applying. Now hopely correct
 t/t7410-submodule-checkout-to.sh | 38 ++++++++++++++++++++++++--------------
 templates/info--config.worktree  |  6 ++++++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index b43391a..ce41e6b 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -8,20 +8,22 @@ base_path=$(pwd -P)
 
 test_expect_success 'setup: make origin' \
     'mkdir -p origin/sub && ( cd origin/sub && git init &&
-	echo file1 >file1 &&
-	git add file1 &&
-	git commit -m file1 ) &&
+	test_commit sub_init file ) &&
+    mkdir -p origin/sub2 && ( cd origin/sub2 && git init &&
+	test_commit sub2_init file ) &&
     mkdir -p origin/main && ( cd origin/main && git init &&
 	git submodule add ../sub &&
-	git commit -m "add sub" ) &&
+	git submodule add ../sub2 &&
+	git commit -m "add submodules" ) &&
     ( cd origin/sub &&
-	echo file1updated >file1 &&
-	git add file1 &&
-	git commit -m "file1 updated" ) &&
+	test_commit sub_update file ) &&
+    ( cd origin/sub2 &&
+	test_commit sub2_update file ) &&
     ( cd origin/main/sub && git pull ) &&
+    ( cd origin/main/sub2 && git pull ) &&
     ( cd origin/main &&
-	git add sub &&
-	git commit -m "sub updated" )'
+	git add sub sub2 &&
+	git commit -m "submodules updated" )'
 
 test_expect_success 'setup: clone' \
     'mkdir clone && ( cd clone &&
@@ -35,17 +37,25 @@ test_expect_success 'checkout main' \
     (cd clone/main &&
 	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main")'
 
-test_expect_failure 'can see submodule diffs just after checkout' \
-    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
+test_expect_success 'cannot see submodule diffs just after checking out main' \
+    '(cd default_checkout/main &&
+	git diff --submodule master"^!" | grep "Submodule sub .*(not checked out)" &&
+	git diff --submodule master"^!" | grep "Submodule sub2 .*(not checked out)")'
 
 test_expect_success 'checkout main and initialize independed clones' \
     'mkdir fully_cloned_submodule &&
     (cd clone/main &&
 	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
-    (cd fully_cloned_submodule/main && git submodule update)'
+    (cd fully_cloned_submodule/main &&
+	git submodule init sub &&
+	git submodule update)'
 
 test_expect_success 'can see submodule diffs after independed cloning' \
-    '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+    '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "sub_update")'
+
+test_expect_success 'sub2 remains uninitialized' '
+    (cd fully_cloned_submodule/main &&
+	git diff --submodule master"^!" | grep "Submodule sub2 .*(not checked out)")'
 
 test_expect_success 'checkout sub manually' \
     'mkdir linked_submodule &&
@@ -55,6 +65,6 @@ test_expect_success 'checkout sub manually' \
 	git checkout --to "$base_path/linked_submodule/main/sub" "$rev1_hash_sub")'
 
 test_expect_success 'can see submodule diffs after manual checkout of linked submodule' \
-    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "sub_update")'
 
 test_done
diff --git a/templates/info--config.worktree b/templates/info--config.worktree
index f358230..c78916a 100644
--- a/templates/info--config.worktree
+++ b/templates/info--config.worktree
@@ -1,2 +1,8 @@
 core.worktree
 core.bare
+submodule.*.path
+submodule.*.url
+submodule.*.update
+submodule.*.branch
+submodule.*.fetchRecurseSubmodules
+submodule.*.ignore
-- 
2.3.4.2801.g3d0809b
