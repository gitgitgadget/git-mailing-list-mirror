Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27FC00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiHSDWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiHSDV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:21:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA1DA3DE
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p9so2158421pfq.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YxPlYWFTi8MYRDgdciM3M46fXhqc5pJROhBnPQ5CFUo=;
        b=ZXSsD6zb+Pj9rv7IgCNVf0jKP8ygFAnwkHiNX/aVe59L5MKxaDVD59AALp48C9TdLZ
         QZbwo8eZ9NudUPbqEVzQs8XptGpTCLLAZSsFbez+0bi6+4/Br19mV+iWrz3akyfvg+Um
         K2BgcKUjUK+6luoLchkav/Ib9P+ubxXsGoGHRZWzwJw/iuiyOKpRjxTS4+bZIVy8zkrJ
         k27YrQVUDd3P9+Et0zQYHmU+jrvTMpcBk7kNfh1Dr2RvBSZlf0qV8F43Y5tr89/Bmk2M
         IBZZm49C03KCr4ofrow24xOaNheUedfCEzlqo4shpK5E2m6BkXLM3Gz4YRqXNvSHjQml
         tmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YxPlYWFTi8MYRDgdciM3M46fXhqc5pJROhBnPQ5CFUo=;
        b=MUOb+gbS0Qdpjk3cCBbPdhSWuP1nzIaUF7ChpMNM6r9DHML7CDdpubbDQ4dPPHjfVu
         9hGDUG9xY5KYQy6A5YID6wsAEqhf9R0TV1ok0FQp/YL/zj9Xkw8HnMiA9wpCWpTkZyzk
         9L+iky3uh9D+Rn/IRGglFXrNENNNsw6UixMvi9TvCorgSic8HWx0rrJP8Kjjqyr/42zV
         vLuzm+WUpT3biYf8va9xo8RAcUMPr2JQ2Nney+w4cKroNlP1npJxgNu4ZfUzCfkSZWkX
         bRljOD0baufSyWX4ulO2RDdwEstPMtiBNUq3ngW2HWqG2/hUc4xeuDaD95v58nLQ1pSv
         gKjQ==
X-Gm-Message-State: ACgBeo3dTmJmD22u3EWR+FyaJwWda2nvpqXwPTbRdRS6LBaub0qHDgZV
        GJ7k1Garp5eqCEdMBJGzqEM=
X-Google-Smtp-Source: AA6agR4vYHmW5NZv62kpuFuFE3knwfmNLVMBryyCWP2uPHpjstE7U/Zu8FJvO4LMV17j/FnNNu2wcg==
X-Received: by 2002:a05:6a00:16c1:b0:520:6ede:24fb with SMTP id l1-20020a056a0016c100b005206ede24fbmr5904593pfc.7.1660879316770;
        Thu, 18 Aug 2022 20:21:56 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:21:56 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 5/9] refs: avoid duplicate running of the reference-transaction hook
Date:   Fri, 19 Aug 2022 11:21:43 +0800
Message-Id: <20220819032147.28841-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

If there are references to be deleted in a transaction, we should remove
each reference from both loose references and the "packed-refs" file.
The "reference-transaction" hook will run twice, once for the primary
ref-store (loose ref-store), and another for the second ref-store (i.e.
packed ref-store).

To avoid duplicate running of the "reference-trancaction" hook, we pass
a special "hook-flags" parameter to initialize the second ref-store.
The "REF_TRANSACTION_RUN_PREPARED_HOOK" bit is preserved for the
transaction of the second ref-store because we may still want to call
command "reference-trancaction prepared" to do some checks. E.g.: We
can create a global lock file (such as "site.lock") to disable writing
permissions for one or multiple repositories.

The behavior of the following git commands and five testcases have been
fixed in t1416:

 * git cherry-pick
 * git rebase
 * git revert
 * git update-ref -d <ref>
 * git update-ref --stdin	# delete refs

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             |   7 +-
 t/t1416-ref-transaction-hooks.sh | 156 ++-----------------------------
 2 files changed, 15 insertions(+), 148 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f0947c9dca..9ec4c23a16 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2797,8 +2797,11 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			 * packed-refs if it exists there.
 			 */
 			if (!packed_transaction) {
-				packed_transaction = ref_store_transaction_begin(
-						refs->packed_ref_store, err);
+				packed_transaction = ref_store_transaction_begin_extended(
+						refs->packed_ref_store,
+						transaction->hook_flags &
+							REF_TRANSACTION_RUN_PREPARED_HOOK,
+						err);
 				if (!packed_transaction) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index b7ffc9415b..6ba7ba746c 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -441,45 +441,7 @@ test_expect_success "update-ref: update refs already in packed_ref_store" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output when deleting refs using "git update-refs -d":
-#
-#  * The "reference-transaction committed" command was executed twice,
-#    once for packed ref-store, and once for loose ref-store.
-#
-#  * Unexpected execution of the "reference-transaction abort" command.
-#
-# The differences are as follows:
-#
-#     @@ -4,6 +4,8 @@
-#      <COMMIT-A> <ZERO-OID> refs/heads/topic1
-#      <COMMIT-A> <ZERO-OID> HEAD
-#      ## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#     +## Call hook: reference-transaction committed ##
-#      <COMMIT-A> <ZERO-OID> refs/heads/topic1
-#      <COMMIT-A> <ZERO-OID> HEAD
-#      ## Call hook: reference-transaction  prepared ##
-#     @@ -11,13 +13,19 @@
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#      ## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
-#     +## Call hook: reference-transaction committed ##
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#      ## Call hook: reference-transaction  prepared ##
-#      <ZERO-OID> <ZERO-OID> refs/heads/topic3
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
-#      ## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
-#     +## Call hook: reference-transaction committed ##
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic4
-#      ## Call hook: reference-transaction committed ##
-test_expect_failure "update-ref: remove refs with mixed ref_stores" '
+test_expect_success "update-ref: remove refs with mixed ref_stores" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -604,27 +566,7 @@ test_expect_success "update-ref --stdin: update refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output when deleting refs using "git update-refs
-# --stdin":
-#
-#  * The "reference-transaction committed" command was executed twice,
-#    once for packed ref-store, and once for loose ref-store.
-#
-# The differences are as follows:
-#
-#     @@ -10,6 +10,11 @@
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic4
-#      <COMMIT-A> <ZERO-OID> HEAD
-#      ## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
-#     +## Call hook: reference-transaction committed ##
-#      <COMMIT-A> <ZERO-OID> refs/heads/topic1
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
-test_expect_failure "update-ref --stdin: delete refs" '
+test_expect_success "update-ref --stdin: delete refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -813,24 +755,16 @@ test_expect_failure "branch: copy branches" '
 #  * The "reference-transaction committed" command was not executed
 #    for the target branch.
 #
-#  * Unexpected execution of the "reference-transaction abort" command.
-#
 # The differences are as follows:
 #
-#     @@ -1,16 +1,12 @@
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic4
+#     @@ -3,14 +3,6 @@
 #      ## Call hook: reference-transaction committed ##
 #      <COMMIT-B> <ZERO-OID> refs/heads/topic4
-#     -## Call hook: reference-transaction  prepared ##
+#      ## Call hook: reference-transaction  prepared ##
 #     -<ZERO-OID> <COMMIT-B> refs/heads/topic6
 #     -## Call hook: reference-transaction committed ##
 #     -<ZERO-OID> <COMMIT-B> refs/heads/topic6
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic5
-#      ## Call hook: reference-transaction  prepared ##
+#     -## Call hook: reference-transaction  prepared ##
 #      <COMMIT-C> <ZERO-OID> refs/heads/topic5
 #      ## Call hook: reference-transaction committed ##
 #      <COMMIT-C> <ZERO-OID> refs/heads/topic5
@@ -886,11 +820,9 @@ test_expect_failure "branch: rename branches" '
 #    and the "reference-transaction committed" command was executed
 #    redundantly on the packed-ref-store.
 #
-#  * Unexpected execution of the "reference-transaction abort" command.
-#
 # The differences are as follows:
 #
-#     @@ -2,11 +2,25 @@
+#     @@ -2,11 +2,19 @@
 #      <ZERO-OID> <ZERO-OID> refs/heads/topic1
 #      <ZERO-OID> <ZERO-OID> refs/heads/topic2
 #      <ZERO-OID> <ZERO-OID> refs/heads/topic3
@@ -898,14 +830,10 @@ test_expect_failure "branch: rename branches" '
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
 #     +## Call hook: reference-transaction  prepared ##
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
 #     +## Call hook: reference-transaction committed ##
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
 #      ## Call hook: reference-transaction  prepared ##
 #     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
 #      <COMMIT-B> <ZERO-OID> refs/heads/topic2
@@ -913,8 +841,6 @@ test_expect_failure "branch: rename branches" '
 #      ## Call hook: reference-transaction committed ##
 #     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
 #      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
 #     +## Call hook: reference-transaction  prepared ##
 #     +<COMMIT-C> <ZERO-OID> refs/heads/topic3
 #     +## Call hook: reference-transaction committed ##
@@ -1055,11 +981,9 @@ test_expect_success "tag: update refs to create loose refs" '
 #    and the "reference-transaction committed" command was executed
 #    redundantly on the packed-ref-store.
 #
-#  * Unexpected execution of the "reference-transaction abort" command.
-#
 # The differences are as follows:
 #
-#     @@ -2,11 +2,25 @@
+#     @@ -2,11 +2,19 @@
 #      <ZERO-OID> <ZERO-OID> refs/tags/v1
 #      <ZERO-OID> <ZERO-OID> refs/tags/v2
 #      <ZERO-OID> <ZERO-OID> refs/tags/v3
@@ -1067,14 +991,10 @@ test_expect_success "tag: update refs to create loose refs" '
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v1
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v2
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v3
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
 #     +## Call hook: reference-transaction  prepared ##
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v1
 #     +## Call hook: reference-transaction committed ##
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v1
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v2
 #      ## Call hook: reference-transaction  prepared ##
 #     -<COMMIT-A> <ZERO-OID> refs/tags/v1
 #      <COMMIT-B> <ZERO-OID> refs/tags/v2
@@ -1082,8 +1002,6 @@ test_expect_success "tag: update refs to create loose refs" '
 #      ## Call hook: reference-transaction committed ##
 #     -<COMMIT-A> <ZERO-OID> refs/tags/v1
 #      <COMMIT-B> <ZERO-OID> refs/tags/v2
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v3
 #     +## Call hook: reference-transaction  prepared ##
 #     +<COMMIT-C> <ZERO-OID> refs/tags/v3
 #     +## Call hook: reference-transaction committed ##
@@ -1232,22 +1150,7 @@ test_expect_success "worktree: topic2: merge" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output for git-cherry-pick:
-#
-#  * Unexpected execution of the "reference-transaction abort" command.
-#
-# The differences are as follows:
-#
-#     @@ -12,6 +12,8 @@
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-A> <COMMIT-F> HEAD
-#      <COMMIT-A> <COMMIT-F> refs/heads/topic3
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-C> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction committed ##
-test_expect_failure "worktree: topic3: cherry-pick" '
+test_expect_success "worktree: topic3: cherry-pick" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -1291,31 +1194,7 @@ test_expect_failure "worktree: topic3: cherry-pick" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output for git-rebase:
-#
-#  * Unexpected execution of the "reference-transaction abort" command.
-#
-# The differences are as follows:
-#
-#     @@ -6,6 +6,8 @@
-#      <COMMIT-G> <COMMIT-C> HEAD
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-G> <COMMIT-C> HEAD
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> REBASE_HEAD
-#      ## Call hook: reference-transaction  prepared ##
-#      <ZERO-OID> <ZERO-OID> REBASE_HEAD
-#      ## Call hook: reference-transaction committed ##
-#     @@ -18,6 +20,8 @@
-#      <COMMIT-C> <COMMIT-H> HEAD
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-C> <COMMIT-H> HEAD
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-G> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction committed ##
-test_expect_failure "worktree: topic4: rebase" '
+test_expect_success "worktree: topic4: rebase" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -1367,22 +1246,7 @@ test_expect_failure "worktree: topic4: rebase" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output for git-revert:
-#
-#  * Unexpected execution of the "reference-transaction abort" command.
-#
-# The differences are as follows:
-#
-#     @@ -8,6 +8,8 @@
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-C> <COMMIT-I> HEAD
-#      <COMMIT-C> <COMMIT-I> refs/heads/topic5
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction  prepared ##
-#      <ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction committed ##
-test_expect_failure "worktree: topic5: revert" '
+test_expect_success "worktree: topic5: revert" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
-- 
2.36.1.25.gc87d5ad63a.dirty

