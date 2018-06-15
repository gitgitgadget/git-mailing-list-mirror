Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15011F403
	for <e@80x24.org>; Fri, 15 Jun 2018 04:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeFOEnH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 00:43:07 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:59233
        "EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751776AbeFOEnG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Jun 2018 00:43:06 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id TgZgfY1GOB1yFTgZkf3E8o; Thu, 14 Jun 2018 21:43:06 -0700
From:   Max Kirillov <max@max630.net>
To:     git@vger.kernel.org
Cc:     Max Kirillov <max@max630.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] unpack-trees: do not fail reset because of unmerged skipped entry
Date:   Fri, 15 Jun 2018 07:42:51 +0300
Message-Id: <20180615044251.10597-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
X-CMAE-Envelope: MS4wfMzV/Si4+7kp6rHfQDh81jmSE9mKGIp9GeZQgDtPH9Sttaxscrsrg1lHRcmTUjLRLQThskJq7dRfQoNfItUon7LQhacppoqNW6cGeUdj1pwnBPdwBaLf
 RdX+pwu4lhibFJ/spGxAjG9o+syHKcT/8DU0Q9+10BMfm5E7gQ931Up+cuFHnNaNxTaop+fsdQohJEfayfqGO8T34sUiMYQJ9MmKFeE8PDb3jp5UGXEh+MV1
 hUWFi9DHRnWxhQ7Qv8kW0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After modify/delete merge conflict happens in a file skipped by sparse
checkout, "git reset --merge", which implements the "--abort" actions, and
"git reset --hard" fail with message "Entry * not uptodate. Cannot update
sparse checkout." The reason is that the entry is verified in
apply_sparse_checkout() for being up-to-date even when it has a conflict.
Checking conflicted entry for being up-to-date is not performed in other
cases. One obvious reason to not check it is that it is already modified
by inserting conflict marks.

Fix by not checking conflicted entries before performing reset.
Also, add test case which verifies the issue is fixed.

Signed-off-by: Max Kirillov <max@max630.net>
---
I have tried to use sparse-checkout for merging and cherrypicking, to save on IO
and disk space. It works, mostly, but there are issues here and there.
This one was low hanging, and also pretty annoying.

 t/t3035-merge-sparse.sh | 46 +++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c          |  2 +-
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100755 t/t3035-merge-sparse.sh

diff --git a/t/t3035-merge-sparse.sh b/t/t3035-merge-sparse.sh
new file mode 100755
index 0000000000..c6b2b0b82a
--- /dev/null
+++ b/t/t3035-merge-sparse.sh
@@ -0,0 +1,46 @@
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
+test_expect_success 'setup: conflict back' '
+	! git merge theirs
+'
+
+test_expect_success 'Merge abort works after the conflict' '
+	git merge --abort
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051e..65ae0721a6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -468,7 +468,7 @@ static int apply_sparse_checkout(struct index_state *istate,
 		 * also stat info may have lost after merged_entry() so calling
 		 * verify_uptodate() again may fail
 		 */
-		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+		if (!(ce->ce_flags & CE_UPDATE) && !(ce->ce_flags & CE_CONFLICTED) && verify_uptodate_sparse(ce, o))
 			return -1;
 		ce->ce_flags |= CE_WT_REMOVE;
 		ce->ce_flags &= ~CE_UPDATE;
-- 
2.17.0.1185.g782057d875

