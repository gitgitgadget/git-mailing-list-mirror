From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 17/23] tests: worktree: retrofit "checkout --to" tests for "worktree add"
Date: Fri,  3 Jul 2015 20:17:26 -0400
Message-ID: <1435969052-540-18-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBB0-0000RE-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbbGDATU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:20 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38554 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668AbbGDASm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:42 -0400
Received: by igrv9 with SMTP id v9so85103274igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHfIBw3EMILUBw2SIs8FGcF8DF6WdeptDGlRoSk6SGE=;
        b=HVDWGxZwEZG2flKcce1O9ZCcQupbXMywSzTGINEJGg7UMuW+aBdLaF4KRDHcWrx6uD
         1bFcjX8lk3GYGbT3eRQKybVwLOEW0EACSzkDq64HchYVqhVxx0bcGPjMMbKAeP9x7zqe
         DPrQ4DXKrm/AoJ1qcb87A2mL3j/vhKNtuMykcWI6PXQLS6gTD+NzvgQsgDHCqdL2j+Na
         1pTPoUUHcj8aWhk5hsMedsSik4DAdU3zU1eD2PdRs3QBavAVmrXG7eSKfj9cEiqTRL2d
         fKkIieTJFq8XvbQn93mXllnsqjTflpGKbv65UaoMwyg16v+lo41p8zQx9ObzacFydFm0
         jtaQ==
X-Received: by 10.43.92.199 with SMTP id br7mr21215889icc.43.1435969121615;
        Fri, 03 Jul 2015 17:18:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273331>

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
