From: Max Kirillov <max@max630.net>
Subject: [PATCH 3/4] git-common-dir: make "modules/" per-working-directory directory
Date: Sun, 12 Oct 2014 08:13:10 +0300
Message-ID: <1413090791-14428-4-git-send-email-max@max630.net>
References: <1413090791-14428-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 12 07:14:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdBTr-0006vU-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 07:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaJLFOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 01:14:01 -0400
Received: from p3plsmtpa09-01.prod.phx3.secureserver.net ([173.201.193.230]:40291
	"EHLO p3plsmtpa09-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751193AbaJLFN5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2014 01:13:57 -0400
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa09-01.prod.phx3.secureserver.net with 
	id 25Dj1p00F5B68XE015DvV6; Sat, 11 Oct 2014 22:13:57 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1413090791-14428-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each working directory of main repository has its own working directory
of submodule, and in most cases they should be checked out to different
revisions. So they should be separated.

It looks logical to make submodule instances in different working
directories to reuse the submodule directory in the common dir of
the main repository, and probably this is how "checkout --to" should
initialize them called on the main repository, but they also should work
fine being completely separated clones.

Testfile t7410-submodule-checkout-to.sh demostrates the behavior.

Signed-off-by: Max Kirillov <max@max630.net>
---
 Documentation/gitrepository-layout.txt |  4 +--
 path.c                                 |  2 +-
 t/t7410-submodule-checkout-to.sh       | 50 ++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 4 deletions(-)
 create mode 100755 t/t7410-submodule-checkout-to.sh

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 2b30a92..7173b38 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -248,9 +248,7 @@ commondir::
 	incomplete without the repository pointed by "commondir".
 
 modules::
-	Contains the git-repositories of the submodules. This
-	directory is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/modules" will be used instead.
+	Contains the git-repositories of the submodules.
 
 worktrees::
 	Contains worktree specific information of linked
diff --git a/path.c b/path.c
index 35d498e..a5c51a3 100644
--- a/path.c
+++ b/path.c
@@ -92,7 +92,7 @@ static void replace_dir(struct strbuf *buf, int len, const char *newdir)
 }
 
 static const char *common_list[] = {
-	"/branches", "/hooks", "/info", "!/logs", "/lost-found", "/modules",
+	"/branches", "/hooks", "/info", "!/logs", "/lost-found",
 	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
 	"config", "!gc.pid", "packed-refs", "shallow",
 	NULL
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
new file mode 100755
index 0000000..8f30aed
--- /dev/null
+++ b/t/t7410-submodule-checkout-to.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='Combination of submodules and multiple workdirs'
+
+. ./test-lib.sh
+
+base_path=$(pwd -P)
+
+test_expect_success 'setup: make origin' \
+    'mkdir -p origin/sub && ( cd origin/sub && git init &&
+	echo file1 >file1 &&
+	git add file1 &&
+	git commit -m file1 ) &&
+    mkdir -p origin/main && ( cd origin/main && git init &&
+	git submodule add ../sub &&
+	git commit -m "add sub" ) &&
+    ( cd origin/sub &&
+	echo file1updated >file1 &&
+	git add file1 &&
+	git commit -m "file1 updated" ) &&
+    ( cd origin/main/sub && git pull ) &&
+    ( cd origin/main &&
+	git add sub &&
+	git commit -m "sub updated" )'
+
+test_expect_success 'setup: clone' \
+    'mkdir clone && ( cd clone &&
+	git clone --recursive "$base_path/origin/main")'
+
+rev1_hash_main=$(git --git-dir=origin/main/.git show --pretty=format:%h -q "HEAD~1")
+rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1")
+
+test_expect_success 'checkout main' \
+    'mkdir default_checkout &&
+    (cd clone/main &&
+	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main")'
+
+test_expect_failure 'can see submodule diffs just after checkout' \
+    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_expect_success 'checkout main and initialize independed clones' \
+    'mkdir fully_cloned_submodule &&
+    (cd clone/main &&
+	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
+    (cd fully_cloned_submodule/main && git submodule update)'
+
+test_expect_success 'can see submodule diffs after independed cloning' \
+    '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_done
-- 
2.0.1.1697.g73c6810
