Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3001F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbeGJTZs (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:25:48 -0400
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:45890
        "EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732187AbeGJTZs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jul 2018 15:25:48 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 15:25:47 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id cy97fKFKFiVP1cy9BfqkIc; Tue, 10 Jul 2018 12:18:03 -0700
From:   Max Kirillov <max@max630.net>
To:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] unpack-trees: do not fail reset because of unmerged skipped entry
Date:   Tue, 10 Jul 2018 22:17:48 +0300
Message-Id: <20180710191748.17339-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
in-reply-to: <20180615044251.10597-1-max@max630.net>
X-CMAE-Envelope: MS4wfHAP7ae5gjBVhXeYaUe9qepB2U+SOFkdd/hY2aVL7kSOOWmNbz0B4mdyeODC1HQJbVJ7pHBH6U3t2qOeM7KlmNQqk+LqGEthDznAdKX3GcnMvVBlvVe9
 f6B+Z0IAhbzq2nU4IF54SUO8H7DywmHdCAZE9VUiw7oFKirVwMFxSJvQZm6q62cfDvAPFUNA1Om7QuAdpch98jKEzhoR0hUcuPH9Pg1Q/ueVRm9JAvowZMWR
 dkhMpbKwlKl2D6fCUHzikw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After modify/delete merge conflict happens in a file skipped by sparse
checkout, "git reset --merge", which implements the "--abort" actions,
and "git reset --hard" fail with message "Entry * not uptodate. Cannot
update sparse checkout."

As explained in [1], the up-to-date checker mistakenly treats conflicted
entry which does not exist in HEAD as still skipped by sparse checkout.

Use the fix suggested in [1]. Also, add test case which verifies the
issue is fixed.

[1] https://public-inbox.org/git/20180616051444.GA29754@duynguyen.home/

Fix-authored-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
* used the right fix. Probably there should be sign off?
* add extra check that state is correct after the reset. it is literally
  different from the one described by Junio but should be equivalent for this
  case

 t/t3035-merge-sparse.sh | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c          |  2 +-
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100755 t/t3035-merge-sparse.sh

diff --git a/t/t3035-merge-sparse.sh b/t/t3035-merge-sparse.sh
new file mode 100755
index 0000000..0c0b433
--- /dev/null
+++ b/t/t3035-merge-sparse.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='merge with sparse files'
+
+. ./test-lib.sh
+
+# test_file $filename $content
+test_file () {
+	echo "$2" > "$1" &&
+	git add "$1"
+}
+
+# test_commit_this $message_and_tag
+test_commit_this () {
+	git commit -m "$1" &&
+	git tag "$1"
+}
+
+test_expect_success 'setup' '
+	: >empty &&
+	test_file checked-out init &&
+	test_file modify_delete modify_delete_init &&
+	test_commit_this init &&
+	test_file modify_delete modify_delete_theirs &&
+	test_commit_this theirs &&
+	git reset --hard init &&
+	git rm modify_delete &&
+	test_commit_this ours &&
+	git config core.sparseCheckout true &&
+	echo "/checked-out" >.git/info/sparse-checkout &&
+	git reset --hard &&
+	! git merge theirs
+'
+
+test_expect_success 'reset --hard works after the conflict' '
+	git reset --hard
+'
+
+test_expect_success 'is reset properly' '
+	git status --porcelain -- modify_delete >out &&
+	test_cmp empty out &&
+	test_path_is_missing modify_delete
+'
+
+test_expect_success 'setup: conflict back' '
+	! git merge theirs
+'
+
+test_expect_success 'Merge abort works after the conflict' '
+	git merge --abort
+'
+
+test_expect_success 'is aborted properly' '
+	git status --porcelain -- modify_delete >out &&
+	test_cmp empty out &&
+	test_path_is_missing modify_delete
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02..eb544ee 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1246,7 +1246,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
 
-		if (!ce_stage(ce))
+		if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
 			ce->ce_flags |= skip_wt_flag;
 		else
 			ce->ce_flags &= ~skip_wt_flag;
-- 
2.0.0

