Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDCEC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiG2KNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiG2KM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E87E306
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p8so4158991plq.13
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2g9jgpwv2AB84NQoqyN1KHm+X1DuDo2Tz047zdIsz4=;
        b=RwLInpzzHCLk11Tsg+MAka9ds2+DnyvyTisM3icLgUOb1qdAj9FLTXq4jzvBSKzOEJ
         sC2ZgBXSk+X2WGN3W5I7cDnSVX2lK5mGOi3Do4wy/JVqV/qQbnSO3uVteAQj7PYMTN9C
         VWFpmMFSCgx9jN0DRhKYvOG1OkK5RAm+0fotTjdFNe3prE+k+HeGcqKWwVGRC+O1kMg6
         yZqGLX+9qObWlPZi4BAZY5S6WKtCzNuc7+5616tWKyssMakaw4nvfl5phArphH852XHg
         awssP+mXo9R0MCwIEDjCf4pHt/V20CDbWR0Ki9My1PqGBRje3+E9zQBR+BLNTH/ccWqB
         N7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2g9jgpwv2AB84NQoqyN1KHm+X1DuDo2Tz047zdIsz4=;
        b=vO2jkfTzkZV7l/hFcC41BBJKGim/uAG/WdZ5vqAkc7YkU/hRWmQjIYM1p6v0kq0Sl2
         qLNOYW3F3f8Af7JkAUuWZKyYmmXiPdIL9VaRYyPbMEDMQSVJNC1CGv83oOjzTPpFTA9U
         nih3ni7aa13cFA5OnJZ99Cmh4jfxn9O5P5IH6TymILV52Xy7PxJvHKn9GHeAaqPtmQdJ
         pyI7meRoKHbvWeY0TWjkYsPgsHg1i1spOB+bfGuOOvWk/0rpSlwyD/Th2pUcwE5KpOZt
         q0xPcQ80kBV/rFdV/2js0D2w2ReWDcK36q+oHXh/JxM38iE5iPy4J0l46ydeY3Sd4YoB
         Wh3w==
X-Gm-Message-State: ACgBeo2hCtaJ47w+nYusiz1A/2yLIvklX973/orGifIqKwihkwnb4+ka
        +oPRGxS+XblEtSsxLLjWFNZ+mLbZa1MBlw==
X-Google-Smtp-Source: AA6agR7vBzsbwgcBNJAbMjrMS1nkdV7A43ajb7iwRcZp13LfWCG5DvcZ4lsx0UTA/dkQKQmR3c/PBA==
X-Received: by 2002:a17:90b:3555:b0:1f3:259b:b8b3 with SMTP id lt21-20020a17090b355500b001f3259bb8b3mr3246900pjb.91.1659089577543;
        Fri, 29 Jul 2022 03:12:57 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:57 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 4/9] refs: do not run transaction hook for git-pack-refs
Date:   Fri, 29 Jul 2022 18:12:40 +0800
Message-Id: <20220729101245.6469-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

git-pack-refs will call "files_pack_refs()" to pack loose references
into the "packed-refs" file, and there are no real changes to the
repository. Therefore, by initializing a transaction with an empty
"hook_flags" field, the "reference-transaction" hook will not run.

The "prune_refs()" and "prune_ref()" functions are called from
"file_pack_refs()", and they are used to prune loose refereces which
have already been packed into "packed-refs". The transaction instance
in "prune_ref()" should also be initialized with an empty "hook_flags"
field.

The behavior of the following git commands and three testcases have been
fixed in t1416:

 * git gc
 * git pack-refs

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             | 10 ++++++++--
 t/t1416-ref-transaction-hooks.sh |  6 +++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 957ebe08c0..3be317d524 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1136,7 +1136,8 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
 
-	transaction = ref_store_transaction_begin(&refs->base, &err);
+	/* Called by "files_pack_refs()" and should not run any hooks. */
+	transaction = ref_store_transaction_begin_extended(&refs->base, 0, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1207,7 +1208,12 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
-	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
+	/*
+	 * No real changes have occurred to the repository and no hooks
+	 * should be run for this transaction.
+	 */
+	transaction = ref_store_transaction_begin_extended(refs->packed_ref_store,
+							   0, &err);
 	if (!transaction)
 		return -1;
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index eef7489b5b..7f8fd012e8 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -358,7 +358,7 @@ test_expect_success "update-ref: update HEAD, a symbolic-ref" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "update-ref: call git-pack-refs to create packed_ref_store" '
+test_expect_success "update-ref: call git-pack-refs to create packed_ref_store" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 	git -C workdir pack-refs --all &&
 	test_path_is_file workdir/.git/packed-refs &&
@@ -632,7 +632,7 @@ test_expect_success "branch: create new branches" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "branch: call git-gc to create packed_ref_store" '
+test_expect_success "branch: call git-gc to create packed_ref_store" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 	git -C workdir gc &&
 	test_path_is_file workdir/.git/packed-refs &&
@@ -835,7 +835,7 @@ test_expect_success "tag: create new tags" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "tag: call git-pack-refs to create packed_ref_store" '
+test_expect_success "tag: call git-pack-refs to create packed_ref_store" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 	git -C workdir pack-refs --all &&
 	test_path_is_file workdir/.git/packed-refs &&
-- 
2.36.1.25.gc87d5ad63a.dirty

