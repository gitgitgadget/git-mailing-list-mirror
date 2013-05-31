From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 5/7] add tests for rebasing merged history
Date: Thu, 30 May 2013 23:49:45 -0700
Message-ID: <1369982987-18954-6-git-send-email-martinvonz@gmail.com>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
 <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:50:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJAQ-0000gk-6b
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab3EaGuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:50:22 -0400
Received: from mail-ye0-f201.google.com ([209.85.213.201]:43419 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab3EaGuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:50:04 -0400
Received: by mail-ye0-f201.google.com with SMTP id q9so113176yen.4
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=jTUOGvFGVHLkm7/VmWK07qm6bdPlq0LYPwLI21XBf18=;
        b=g5i8KsPs8aNmWZjakEgTBZcKAliDAfs6+wgwrMZqJ13kLv7fQzyb7JNzmjGeTlxThy
         ckjxq/Bp51mNxXUajTVnRqRK37ZLRHB7LTd9xNeJfHXt3fmI2lKAZnrHo1ynbzt17B7u
         HtPFxgb3DBg6ogH1eNf8sT9Hi2896QWS2ouLQBwbXLwwbyNybR0T+QJPcU475urK4/26
         mxzQat7F59Tqx0rkzKkHN4D5pCTtK+N5L75Iaf38+Ybn0T65Q0eh5x8/98QZgmthycmm
         PcXmAI0ARhe22fLliaj3uH3aW9V+QGCkPiR6JZ297m5WXVaF732BXjXmMufx5zxDcVm7
         y3Kg==
X-Received: by 10.236.124.165 with SMTP id x25mr5683894yhh.4.1369983003845;
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y4si2042797yhi.3.2013.05.30.23.50.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8C5D831C2DF;
	Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 2042B100F99; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlo6ifCtv/7fbpdSAfdZUveReoU+8ZRVZ/UT/oVbshoUhTYX3BKFyKAcODRXYaQ5BzbsUCrFzOezNNoPBh6Ph1ePWpNBRLQXpanHnupsg5GqqF3YUNe9OlZdbPirOK1oMZP5ImiGwRorq3LJTrNQx+DtmuPtW6w/oe4Rjvhmxu9tWt9rGGn9oDhYv69xVWLMBcQOOWC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226054>

---
 t/t3400-rebase.sh                 |  31 +----
 t/t3401-rebase-partial.sh         |  45 -------
 t/t3404-rebase-interactive.sh     |  10 +-
 t/t3409-rebase-preserve-merges.sh |  53 --------
 t/t3425-rebase-topology-merges.sh | 252 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+), 137 deletions(-)
 delete mode 100755 t/t3401-rebase-partial.sh
 create mode 100755 t/t3425-rebase-topology-merges.sh

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b58fa1a..b436ef4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -40,13 +40,6 @@ test_expect_success 'prepare repository with topic branches' '
 	echo Side >>C &&
 	git add C &&
 	git commit -m "Add C" &&
-	git checkout -b nonlinear my-topic-branch &&
-	echo Edit >>B &&
-	git add B &&
-	git commit -m "Modify B" &&
-	git merge side &&
-	git checkout -b upstream-merged-nonlinear &&
-	git merge master &&
 	git checkout -f my-topic-branch &&
 	git tag topic
 '
@@ -106,31 +99,9 @@ test_expect_success 'rebase from ambiguous branch name' '
 	git rebase master
 '
 
-test_expect_success 'rebase after merge master' '
-	git checkout --detach refs/tags/topic &&
-	git branch -D topic &&
-	git reset --hard topic &&
-	git merge master &&
-	git rebase master &&
-	! (git show | grep "^Merge:")
-'
-
-test_expect_success 'rebase of history with merges is linearized' '
-	git checkout nonlinear &&
-	test 4 = $(git rev-list master.. | wc -l) &&
-	git rebase master &&
-	test 3 = $(git rev-list master.. | wc -l)
-'
-
-test_expect_success 'rebase of history with merges after upstream merge is linearized' '
-	git checkout upstream-merged-nonlinear &&
-	test 5 = $(git rev-list master.. | wc -l) &&
-	git rebase master &&
-	test 3 = $(git rev-list master.. | wc -l)
-'
-
 test_expect_success 'rebase a single mode change' '
 	git checkout master &&
+	git branch -D topic &&
 	echo 1 >X &&
 	git add X &&
 	test_tick &&
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
deleted file mode 100755
index 7ba1797..0000000
--- a/t/t3401-rebase-partial.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2006 Yann Dirson, based on t3400 by Amos Waterland
-#
-
-test_description='git rebase should detect patches integrated upstream
-
-This test cherry-picks one local change of two into master branch, and
-checks that git rebase succeeds with only the second patch in the
-local branch.
-'
-. ./test-lib.sh
-
-test_expect_success 'prepare repository with topic branch' '
-	test_commit A &&
-	git checkout -b my-topic-branch &&
-	test_commit B &&
-	test_commit C &&
-	git checkout -f master &&
-	test_commit A2 A.t
-'
-
-test_expect_success 'pick top patch from topic branch into master' '
-	git cherry-pick C &&
-	git checkout -f my-topic-branch
-'
-
-test_debug '
-	git cherry master &&
-	git format-patch -k --stdout --full-index master >/dev/null &&
-	gitk --all & sleep 1
-'
-
-test_expect_success 'rebase topic branch against new master and check git am did not get halted' '
-	git rebase master &&
-	test_path_is_missing .git/rebase-apply
-'
-
-test_expect_success 'rebase --merge topic branch that was partially merged upstream' '
-	git reset --hard C &&
-	git rebase --merge master &&
-	test_path_is_missing .git/rebase-merge
-'
-
-test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a58406d..ffcaf02 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -477,19 +477,11 @@ test_expect_success 'interrupted squash works as expected (case 2)' '
 	test $one = $(git rev-parse HEAD~2)
 '
 
-test_expect_success 'ignore patch if in upstream' '
-	HEAD=$(git rev-parse HEAD) &&
-	git checkout -b has-cherry-picked HEAD^ &&
+test_expect_success '--continue tries to commit, even for "edit"' '
 	echo unrelated > file7 &&
 	git add file7 &&
 	test_tick &&
 	git commit -m "unrelated change" &&
-	git cherry-pick $HEAD &&
-	EXPECT_COUNT=1 git rebase -i $HEAD &&
-	test $HEAD = $(git rev-parse HEAD^)
-'
-
-test_expect_success '--continue tries to commit, even for "edit"' '
 	parent=$(git rev-parse HEAD^) &&
 	test_tick &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 6de4e22..2e0c364 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -11,14 +11,6 @@ Run "git rebase -p" and check that merges are properly carried along
 GIT_AUTHOR_EMAIL=bogus_email_address
 export GIT_AUTHOR_EMAIL
 
-# Clone 1 (trivial merge):
-#
-# A1--A2  <-- origin/master
-#  \   \
-#   B1--M  <-- topic
-#    \
-#     B2  <-- origin/topic
-#
 # Clone 2 (conflicting merge):
 #
 # A1--A2--B3   <-- origin/master
@@ -36,16 +28,6 @@ export GIT_AUTHOR_EMAIL
 #     \--A3    <-- topic2
 #      \
 #       B2     <-- origin/topic
-#
-# Clone 4 (merge using second parent as base):
-#
-# A1--A2--B3   <-- origin/master
-#  \
-#   B1--A3--M  <-- topic
-#    \     /
-#     \--A4    <-- topic2
-#      \
-#       B2     <-- origin/topic
 
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
@@ -58,20 +40,6 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git checkout -f master &&
 	echo Third >> A &&
 	git commit -a -m "Modify A2" &&
-
-	git clone ./. clone1 &&
-	(cd clone1 &&
-	git checkout -b topic origin/topic &&
-	git merge origin/master
-	) &&
-
-	git clone ./. clone4 &&
-	(
-		cd clone4 &&
-		git checkout -b topic origin/topic &&
-		git merge origin/master
-	) &&
-
 	echo Fifth > B &&
 	git add B &&
 	git commit -m "Add different B" &&
@@ -101,16 +69,6 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git commit -a -m "Modify B2"
 '
 
-test_expect_success 'rebase -p fakes interactive rebase' '
-	(
-	cd clone1 &&
-	git fetch &&
-	git rebase -p origin/topic &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
-	)
-'
-
 test_expect_success '--continue works after a conflict' '
 	(
 	cd clone2 &&
@@ -138,15 +96,4 @@ test_expect_success 'rebase -p preserves no-ff merges' '
 	)
 '
 
-test_expect_success 'rebase -p works when base inside second parent' '
-	(
-	cd clone4 &&
-	git fetch &&
-	git rebase -p HEAD^2 &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify B" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
-	)
-'
-
 test_done
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
new file mode 100755
index 0000000..72fa76d
--- /dev/null
+++ b/t/t3425-rebase-topology-merges.sh
@@ -0,0 +1,252 @@
+#!/bin/sh
+
+test_description='rebase topology tests with merges'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_revision_subjects () {
+	expected="$1"
+	shift
+	set -- $(git log --format=%s --no-walk=unsorted "$@")
+	test "$expected" = "$*"
+}
+
+# a---b-----------c
+#      \           \
+#       d-------e   \
+#        \       \   \
+#         n---o---w---v
+#              \
+#               z
+test_expect_success 'setup of non-linear-history' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	git checkout b &&
+	test_commit d &&
+	test_commit e
+
+	git checkout c &&
+	test_commit g &&
+	revert h g &&
+	git checkout d &&
+	cherry_pick G g &&
+	test_commit i &&
+	git checkout b &&
+	test_commit f
+
+	git checkout d &&
+	test_commit n &&
+	test_commit o &&
+	test_merge w e &&
+	test_merge v c &&
+	git checkout o &&
+	test_commit z
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* after merge from upstream" "
+		reset_rebase &&
+		git rebase $* e w &&
+		test_cmp_rev e HEAD~2 &&
+		test_linear_range 'n o' e..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+
+test_run_rebase () {
+	result=$1
+	shift
+	expected=$1
+	shift
+	test_expect_$result "rebase $* of non-linear history is linearized in place" "
+		reset_rebase &&
+		git rebase $* d w &&
+		test_cmp_rev d HEAD~3 &&
+		test_linear_range "\'"$expected"\'" d..
+	"
+}
+#TODO: make all flavors of rebase use --topo-order
+test_run_rebase success 'e n o' ''
+test_run_rebase success 'e n o' -m
+test_run_rebase success 'n o e' -i
+
+test_run_rebase () {
+	result=$1
+	shift
+	expected=$1
+	shift
+	test_expect_$result "rebase $* of non-linear history is linearized upstream" "
+		reset_rebase &&
+		git rebase $* c w &&
+		test_cmp_rev c HEAD~4 &&
+		test_linear_range "\'"$expected"\'" c..
+	"
+}
+#TODO: make all flavors of rebase use --topo-order
+test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -i
+
+test_run_rebase () {
+	result=$1
+	shift
+	expected=$1
+	shift
+	test_expect_$result "rebase $* of non-linear history with merges after upstream merge is linearized" "
+		reset_rebase &&
+		git rebase $* c v &&
+		test_cmp_rev c HEAD~4 &&
+		test_linear_range "\'"$expected"\'" c..
+	"
+}
+#TODO: make all flavors of rebase use --topo-order
+test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -i
+
+test_expect_success "rebase -p is no-op in non-linear history" "
+	reset_rebase &&
+	git rebase -p d w &&
+	test_cmp_rev w HEAD
+"
+
+test_expect_success "rebase -p is no-op when base inside second parent" "
+	reset_rebase &&
+	git rebase -p e w &&
+	test_cmp_rev w HEAD
+"
+
+test_expect_failure "rebase -p --root on non-linear history is a no-op" "
+	reset_rebase &&
+	git rebase -p --root w &&
+	test_cmp_rev w HEAD
+"
+
+test_expect_success "rebase -p re-creates merge from side branch" "
+	reset_rebase &&
+	git rebase -p z w &&
+	test_cmp_rev z HEAD^ &&
+	test_cmp_rev w^2 HEAD^2
+"
+
+test_expect_success "rebase -p re-creates internal merge" "
+	reset_rebase &&
+	git rebase -p c w &&
+	test_cmp_rev c HEAD~4 &&
+	test_revision_subjects 'd n e o w' HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p can re-create two branches on onto" "
+	reset_rebase &&
+	git rebase -p --onto c d w &&
+	test_cmp_rev c HEAD~3 &&
+	test_revision_subjects 'n e o w' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+#       f
+#      /
+# a---b---c---g---h
+#      \
+#       d---G---i
+#        \       \
+#         e-------u
+#
+# uppercase = cherry-picked
+# h = reverted g
+test_expect_success 'setup of non-linear-history for patch-equivalence tests' '
+	git checkout e &&
+	test_merge u i
+'
+
+test_expect_success "rebase -p re-creates history around dropped commit matching upstream" "
+	reset_rebase &&
+	git rebase -p h u &&
+	test_cmp_rev h HEAD~3 &&
+	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p --onto in merged history drops patches in upstream" "
+	reset_rebase &&
+	git rebase -p --onto f h u &&
+	test_cmp_rev f HEAD~3 &&
+	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p --onto in merged history does not drop patches in onto" "
+	reset_rebase &&
+	git rebase -p --onto h f u &&
+	test_cmp_rev h HEAD~3 &&
+	test_revision_subjects 'd G i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
+"
+
+# a---b---c---g---h
+#      \
+#       d---G---s
+#        \   \ /
+#         \   X
+#          \ / \
+#           e---t
+#
+# uppercase = cherry-picked
+# h = reverted g
+test_expect_success 'setup of non-linear-history for dropping whole side' '
+	git checkout G &&
+	test_merge s e &&
+	git checkout e &&
+	test_merge t G
+'
+
+test_expect_failure "rebase -p drops merge commit when entire first-parent side is dropped" "
+	reset_rebase &&
+	git rebase -p h s &&
+	test_cmp_rev h HEAD~2 &&
+	test_linear_range 'd e' h..
+"
+
+test_expect_success "rebase -p drops merge commit when entire second-parent side is dropped" "
+	reset_rebase &&
+	git rebase -p h t &&
+	test_cmp_rev h HEAD~2 &&
+	test_linear_range 'd e' h..
+"
+
+# a---b---c
+#      \
+#       d---e
+#        \   \
+#         n---r
+#          \
+#           o
+#
+# r = tree-same with n
+test_expect_success 'setup of non-linear-history for empty commits' '
+	git checkout n &&
+	git merge --no-commit e &&
+	git reset n . &&
+	git commit -m r &&
+	git reset --hard &&
+	git clean -f &&
+	git tag r
+'
+
+test_expect_success "rebase -p re-creates empty internal merge commit" "
+	reset_rebase &&
+	git rebase -p c r &&
+	test_cmp_rev c HEAD~3 &&
+	test_revision_subjects 'd e n r' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p re-creates empty merge commit" "
+	reset_rebase &&
+	git rebase -p o r &&
+	test_cmp_rev e HEAD^2 &&
+	test_cmp_rev o HEAD^ &&
+	test_revision_subjects 'r' HEAD
+"
+
+test_done
-- 
1.8.2.674.gd17d3d2
