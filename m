From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 17/23] tests: worktree: retrofit "checkout --to" tests for "worktree add"
Date: Mon,  6 Jul 2015 13:30:54 -0400
Message-ID: <1436203860-846-18-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFo-00087w-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbbGFRcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:32:24 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34015 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbbGFRbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:46 -0400
Received: by iebmu5 with SMTP id mu5so117797768ieb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHfIBw3EMILUBw2SIs8FGcF8DF6WdeptDGlRoSk6SGE=;
        b=d7uQkQGi+wsxmpkAkpCahl1dCmGI6pl8zY59o/P7VqNIB5KGel/5yrWVivLXwPTDhC
         4KrqTHK+q++hNnguWPNDSung0/dmLMjPWha7tf13NZnm+34tissY+LqqUIXr6USVjtyJ
         gv81yK84M5UA2v7TSDdt1eEX+2bHenyQfJdi4P4FKkJ25RY++XNqscmnr7GHts66bn/7
         x8VEDwFmisJZ4ehWlqtHhP4BN1y/gh83jKER0TFjdzfYDER4Kf0EbmAY74nXTt+mVr1F
         2YssBt5ktkeODFlDFQxHlsljv76KI3oeHkdLvkH7YTCVi5wYeH02HX5iy7euSWOTC52K
         oDfg==
X-Received: by 10.107.149.14 with SMTP id x14mr57244354iod.87.1436203905958;
        Mon, 06 Jul 2015 10:31:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273426>

With the introduction of "git worktree add", "git checkout --to" is
slated for removal. Therefore, retrofit linked worktree creation tests
to use "git worktree add" instead.

(The test to check exclusivity of "checkout --to" and "checkout <paths>"
is dropped altogether since it becomes meaningless with retirement of
"checkout --to".)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/{t2025-checkout-to.sh => t2025-worktree-add.sh} | 48 +++++++++++------------
 t/t2026-prune-linked-checkouts.sh                 |  2 +-
 t/t7410-submodule-checkout-to.sh                  |  4 +-
 3 files changed, 25 insertions(+), 29 deletions(-)
 rename t/{t2025-checkout-to.sh => t2025-worktree-add.sh} (59%)

diff --git a/t/t2025-checkout-to.sh b/t/t2025-worktree-add.sh
similarity index 59%
rename from t/t2025-checkout-to.sh
rename to t/t2025-worktree-add.sh
index 0fd731b..192c936 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-worktree-add.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test git checkout --to'
+test_description='test git worktree add'
 
 . ./test-lib.sh
 
@@ -8,22 +8,18 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_success 'checkout --to not updating paths' '
-	test_must_fail git checkout --to -- init.t
-'
-
-test_expect_success 'checkout --to an existing worktree' '
+test_expect_success '"add" an existing worktree' '
 	mkdir -p existing/subtree &&
-	test_must_fail git checkout --detach --to existing master
+	test_must_fail git worktree add --detach existing master
 '
 
-test_expect_success 'checkout --to an existing empty worktree' '
+test_expect_success '"add" an existing empty worktree' '
 	mkdir existing_empty &&
-	git checkout --detach --to existing_empty master
+	git worktree add --detach existing_empty master
 '
 
-test_expect_success 'checkout --to refuses to checkout locked branch' '
-	test_must_fail git checkout --to zere master &&
+test_expect_success '"add" refuses to checkout locked branch' '
+	test_must_fail git worktree add zere master &&
 	! test -d zere &&
 	! test -d .git/worktrees/zere
 '
@@ -36,9 +32,9 @@ test_expect_success 'checking out paths not complaining about linked checkouts'
 	)
 '
 
-test_expect_success 'checkout --to a new worktree' '
+test_expect_success '"add" worktree' '
 	git rev-parse HEAD >expect &&
-	git checkout --detach --to here master &&
+	git worktree add --detach here master &&
 	(
 		cd here &&
 		test_cmp ../init.t init.t &&
@@ -49,27 +45,27 @@ test_expect_success 'checkout --to a new worktree' '
 	)
 '
 
-test_expect_success 'checkout --to a new worktree from a subdir' '
+test_expect_success '"add" worktree from a subdir' '
 	(
 		mkdir sub &&
 		cd sub &&
-		git checkout --detach --to here master &&
+		git worktree add --detach here master &&
 		cd here &&
 		test_cmp ../../init.t init.t
 	)
 '
 
-test_expect_success 'checkout --to from a linked checkout' '
+test_expect_success '"add" from a linked checkout' '
 	(
 		cd here &&
-		git checkout --detach --to nested-here master &&
+		git worktree add --detach nested-here master &&
 		cd nested-here &&
 		git fsck
 	)
 '
 
-test_expect_success 'checkout --to a new worktree creating new branch' '
-	git checkout --to there -b newmaster master &&
+test_expect_success '"add" worktree creating new branch' '
+	git worktree add -b newmaster there master &&
 	(
 		cd there &&
 		test_cmp ../init.t init.t &&
@@ -90,7 +86,7 @@ test_expect_success 'die the same branch is already checked out' '
 test_expect_success 'not die the same branch is already checked out' '
 	(
 		cd here &&
-		git checkout --ignore-other-worktrees --to anothernewmaster newmaster
+		git worktree add --force anothernewmaster newmaster
 	)
 '
 
@@ -101,15 +97,15 @@ test_expect_success 'not die on re-checking out current branch' '
 	)
 '
 
-test_expect_success 'checkout --to from a bare repo' '
+test_expect_success '"add" from a bare repo' '
 	(
 		git clone --bare . bare &&
 		cd bare &&
-		git checkout --to ../there2 -b bare-master master
+		git worktree add -b bare-master ../there2 master
 	)
 '
 
-test_expect_success 'checkout from a bare repo without --to' '
+test_expect_success 'checkout from a bare repo without "add"' '
 	(
 		cd bare &&
 		test_must_fail git checkout master
@@ -129,17 +125,17 @@ test_expect_success 'checkout with grafts' '
 	EOF
 	git log --format=%s -2 >actual &&
 	test_cmp expected actual &&
-	git checkout --detach --to grafted master &&
+	git worktree add --detach grafted master &&
 	git --git-dir=grafted/.git log --format=%s -2 >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'checkout --to from relative HEAD' '
+test_expect_success '"add" from relative HEAD' '
 	test_commit a &&
 	test_commit b &&
 	test_commit c &&
 	git rev-parse HEAD~1 >expected &&
-	git checkout --to relhead HEAD~1 &&
+	git worktree add relhead HEAD~1 &&
 	git -C relhead rev-parse HEAD >actual &&
 	test_cmp expected actual
 '
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index e872f02..a0f1e3b 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -88,7 +88,7 @@ test_expect_success 'not prune recent checkouts' '
 
 test_expect_success 'not prune proper checkouts' '
 	test_when_finished rm -r .git/worktrees &&
-	git checkout "--to=$PWD/nop" --detach master &&
+	git worktree add --detach "$PWD/nop" master &&
 	git worktree prune &&
 	test -d .git/worktrees/nop
 '
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 8f30aed..3f609e8 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -33,7 +33,7 @@ rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1
 test_expect_success 'checkout main' \
     'mkdir default_checkout &&
     (cd clone/main &&
-	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main")'
+	git worktree add "$base_path/default_checkout/main" "$rev1_hash_main")'
 
 test_expect_failure 'can see submodule diffs just after checkout' \
     '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
@@ -41,7 +41,7 @@ test_expect_failure 'can see submodule diffs just after checkout' \
 test_expect_success 'checkout main and initialize independed clones' \
     'mkdir fully_cloned_submodule &&
     (cd clone/main &&
-	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
+	git worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
     (cd fully_cloned_submodule/main && git submodule update)'
 
 test_expect_success 'can see submodule diffs after independed cloning' \
-- 
2.5.0.rc1.197.g417e668
