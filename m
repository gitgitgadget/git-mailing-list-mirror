Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15929E8FDB2
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbjJCU1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjJCU13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:27:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3314FA7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:27:26 -0700 (PDT)
Received: (qmail 14860 invoked by uid 109); 3 Oct 2023 20:27:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:27:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14911 invoked by uid 111); 3 Oct 2023 20:27:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:27:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:27:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/10] merge: free result of repo_get_merge_bases()
Message-ID: <20231003202724.GC7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We call repo_get_merge_bases(), which allocates a commit_list, but never
free the result, causing a leak.

The obvious solution is to free it, but we need to look at the contents
of the first item to decide whether to leave the loop. One option is to
free it in both code paths. But since the commit that the list points to
is longer-lived than the list itself, we can just dereference it
immediately, free the list, and then continue with the existing logic.
This is about the same amount of code, but keeps the list management all
in one place.

This lets us mark a number of merge-related test scripts as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c                   | 5 ++++-
 t/t4214-log-graph-octopus.sh      | 1 +
 t/t4215-log-skewed-merges.sh      | 1 +
 t/t6009-rev-list-parent.sh        | 1 +
 t/t6416-recursive-corner-cases.sh | 1 +
 t/t6433-merge-toplevel.sh         | 1 +
 t/t6437-submodule-merge.sh        | 1 +
 t/t7602-merge-octopus-many.sh     | 1 +
 t/t7603-merge-reduce-heads.sh     | 1 +
 t/t7607-merge-state.sh            | 1 +
 t/t7608-merge-messages.sh         | 1 +
 11 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index fd21c0d4f4..ac4816c14e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1634,6 +1634,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		for (j = remoteheads; j; j = j->next) {
 			struct commit_list *common_one;
+			struct commit *common_item;
 
 			/*
 			 * Here we *have* to calculate the individual
@@ -1643,7 +1644,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			common_one = repo_get_merge_bases(the_repository,
 							  head_commit,
 							  j->item);
-			if (!oideq(&common_one->item->object.oid, &j->item->object.oid)) {
+			common_item = common_one->item;
+			free_commit_list(common_one);
+			if (!oideq(&common_item->object.oid, &j->item->object.oid)) {
 				up_to_date = 0;
 				break;
 			}
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index f70c46bbbf..7905597869 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -5,6 +5,7 @@ test_description='git log --graph of skewed left octopus merge.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..b877ac7235 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -2,6 +2,7 @@
 
 test_description='git log --graph of skewed merges'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 5a67bbc760..ced40157ed 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -5,6 +5,7 @@ test_description='ancestor culling and limiting by parent number'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_revlist () {
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 17b54d625d..5f414abc89 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -5,6 +5,7 @@ test_description='recursive merge corner cases involving criss-cross merges'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index b16031465f..2b42f095dc 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -5,6 +5,7 @@ test_description='"git merge" top-level frontend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 t3033_reset () {
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c9a86f2e94..daa507862c 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -8,6 +8,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index ff085b086c..3669d33bd5 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -4,6 +4,7 @@ test_description='git merge
 
 Testing octopus merge with more than 25 refs.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 4887ca705b..0e85b21ec8 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -4,6 +4,7 @@ test_description='git merge
 
 Testing octopus merge when reducing parents to independent branches.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # 0 - 1
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
index 89a62ac53b..9001674f2e 100755
--- a/t/t7607-merge-state.sh
+++ b/t/t7607-merge-state.sh
@@ -4,6 +4,7 @@ test_description="Test that merge state is as expected after failed merge"
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'Ensure we restore original state if no merge strategy handles it' '
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 0b908ab2e7..2179938c43 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -4,6 +4,7 @@ test_description='test auto-generated merge messages'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_oneline() {
-- 
2.42.0.810.gbc538a0ee6

