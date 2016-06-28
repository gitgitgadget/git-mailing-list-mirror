Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943D61FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbcF1L3n (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:29:43 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:53138 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752165AbcF1L3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:29:40 -0400
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1bHqed-0001LL-UV; Tue, 28 Jun 2016 05:54:08 -0500
From:	David Greene <greened@obbligato.org>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, sunshine@sunshineco.com,
	davidw@realtimegenomics.com
Subject: [PATCH v6 1/1] contrib/subtree: Add a test for subtree rebase that loses commits
Date:	Tue, 28 Jun 2016 05:54:02 -0500
Message-Id: <834520c69d67b6dbe804ff67b4be00a9ac17d556.1467111148.git.greened@obbligato.org>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <xmqqsi1tbh68.fsf@gitster.mtv.corp.google.com>
References: <xmqqsi1tbh68.fsf@gitster.mtv.corp.google.com>
X-Filter-Spam-Score:  ()
X-Filter-Spam-Report: 
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David A. Greene <greened@obbligato.org>

This test merges an external tree in as a subtree, makes some commits
on top of it and splits it back out.  In the process the added commits
are lost or the rebase aborts with an internal error.  The tests are
marked to expect failure so that we don't forget to fix it.

Signed-off-by: David A. Greene <greened@obbligato.org>
---

Notes:
    Change History:
    
    v1 - Initial version
    v2 - Additional tests and code cleanup
    v3 - Remove check_equal, mark comments on failure and remove
         test_debug statements
    v4 - Send correct v3 test (botched v3)
    v5 - Fix use of verbose
    v6 - Add individual tests for each potentially dropped commit

 t/t3427-rebase-subtree.sh | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
new file mode 100755
index 0000000..3780877
--- /dev/null
+++ b/t/t3427-rebase-subtree.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description='git rebase tests for -Xsubtree
+
+This test runs git rebase and tests the subtree strategy.
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+commit_message() {
+	git log --pretty=format:%s -1 "$1"
+}
+
+test_expect_success 'setup' '
+	test_commit README &&
+	mkdir files &&
+	(
+		cd files &&
+		git init &&
+		test_commit master1 &&
+		test_commit master2 &&
+		test_commit master3
+	) &&
+	git fetch files master &&
+	git branch files-master FETCH_HEAD &&
+	git read-tree --prefix=files_subtree files-master &&
+	git checkout -- files_subtree &&
+	tree=$(git write-tree) &&
+	head=$(git rev-parse HEAD) &&
+	rev=$(git rev-parse --verify files-master^0) &&
+	commit=$(git commit-tree -p $head -p $rev -m "Add subproject master" $tree) &&
+	git update-ref HEAD $commit &&
+	(
+		cd files_subtree &&
+		test_commit master4
+	) &&
+	test_commit files_subtree/master5
+'
+
+# FAILURE: Does not preserve master4.
+test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
+	reset_rebase &&
+	git checkout -b rebase-preserve-merges-4 master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
+'
+
+# FAILURE: Does not preserve master5.
+test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
+	reset_rebase &&
+	git checkout -b rebase-preserve-merges-5 master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
+'
+
+# FAILURE: Does not preserve master4.
+test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
+	reset_rebase &&
+	git checkout -b rebase-keep-empty-4 master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
+'
+
+# FAILURE: Does not preserve master5.
+test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
+	reset_rebase &&
+	git checkout -b rebase-keep-empty-5 master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
+'
+
+# FAILURE: Does not preserve Empty.
+test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
+	reset_rebase &&
+	git checkout -b rebase-keep-empty-empty master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD)" = "Empty commit"
+'
+
+# FAILURE: fatal: Could not parse object
+test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
+	reset_rebase &&
+	git checkout -b rebase-onto-4 master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
+'
+
+# FAILURE: fatal: Could not parse object
+test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
+	reset_rebase &&
+	git checkout -b rebase-onto-5 master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
+'
+# FAILURE: fatal: Could not parse object
+test_expect_failure 'Rebase -Xsubtree --onto empty commit' '
+	reset_rebase &&
+	git checkout -b rebase-onto-empty master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	verbose test "$(commit_message HEAD)" = "Empty commit"
+'
+
+test_done
-- 
2.8.1

