Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC49C19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiG2KNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiG2KND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:13:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A5F747AD
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:13:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c3so4211977pfb.13
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s61hS95jHvISsYdtqUNlnG/+XSd8dKD0uQdWQK9qzPs=;
        b=KuZw/gPtmBePL9bni+clADdwm9zGRNgBH4d8IH0fbXBfYeCIFlRWrIiRLEQMc+ZxdZ
         hDWIrB5AoZeGREmEX6T4hT4Magw1AsWIW/w92Tdi2VBMISzAwwxPVWZHwhyCZFKAhqlY
         8XSSOoG27Qnia43JM2Ez5ty4d7rX+wU33LmMoAq6+Jvuvr/VKtQ/7zh7qUpiayGkn77T
         t072CxgwFMuOnFxTj3/FgDTL77uiReo1/mF+ee42ouBBnW458+lQCju47OA9AvAVaoDX
         /kvkrZQ8zmhecUz7QhKttzTAj+Rp6QhBjAg7QdkfahDQKXpW1MfcP0WgSTj7eQIbEd2V
         Nl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s61hS95jHvISsYdtqUNlnG/+XSd8dKD0uQdWQK9qzPs=;
        b=6ESV924w5xMrbHuhdfI935aqvt+pJ73geZ1OMqCAepdiPcmuGL8socDi5Qr6FohNVs
         ZNRQ/aiAOwZPkmY39Bu2FHM/GX910Y7zSdx24fTVTY/UEs4uvTupH1Pfu4yoHt8fz4gg
         jjqFWSXh27h6LjHl109E0VF7mbCCccgw5baDVlIK5Gm6kBAik9J506sPzrrWywYGxfSf
         QZPCydqTtQ2aMS4LFV5DZlG9FrFPGlFHQFxs9iaqv+gtx4vmGNmgqsa7Z6vVBUu+wzxo
         QXfevuzga2XtctnZH/zlivnLH3q+c4pGXRjrizxhvmsfQfmwIOHzUN2nTjYesfPL+G2C
         WIWA==
X-Gm-Message-State: AJIora8NawI+lkF8xE+e4eVDWV1OoFPInQNTZW+pi5GR3F3/BDut/JvK
        RN5i/scgXy4Nmt5eZ9OGv78=
X-Google-Smtp-Source: AA6agR61yCNe3pAphMRbSsLsBmL/5UOGj8xyCsG4oMc//A74l1i2pjqZN3FN5QTSHoX309xyJ/rKkQ==
X-Received: by 2002:a05:6a00:8c8:b0:52c:887d:fa25 with SMTP id s8-20020a056a0008c800b0052c887dfa25mr2762600pfu.86.1659089581714;
        Fri, 29 Jul 2022 03:13:01 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.13.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:13:01 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 9/9] refs: reimplement refs_delete_refs() and run hook once
Date:   Fri, 29 Jul 2022 18:12:45 +0800
Message-Id: <20220729101245.6469-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When delete references using "git branch -d" or "git tag -d", there will
be duplicate call of "reference-transaction committed" for same refs.
This is because "refs_delete_refs()" is called twice, once for
files-backend and once for packed-backend, and we used to reinvented the
wheel in "files_delete_refs()" and "packed_delete_refs()". By removing
"packed_delete_refs()" and reimplement "files_delete_refs()", the
"reference-transaction" hook will run only once for deleted branches and
tags.

The behavior of the following git commands and the last two testcases
have been fixed in t1416:

 * git branch -d <branch>
 * git tag -d <tag>

A testcase in t5510 is broken because we used to call the function
"packed_refs_lock()", but it is not necessary if the deleted reference
is not in the "packed-refs" file.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             | 21 ++++++-------
 refs/packed-backend.c            | 51 +-------------------------------
 t/t1416-ref-transaction-hooks.sh |  4 +--
 t/t5510-fetch.sh                 | 17 +++++++++++
 4 files changed, 29 insertions(+), 64 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8baea66e58..21426efaae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1268,31 +1268,27 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
 	if (!refnames->nr)
 		return 0;
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
-		goto error;
-
-	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
-		packed_refs_unlock(refs->packed_ref_store);
+	transaction = ref_store_transaction_begin(ref_store, &err);
+	if (!transaction)
 		goto error;
-	}
-
-	packed_refs_unlock(refs->packed_ref_store);
 
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
-
-		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
+		if (ref_transaction_delete(transaction, refname, NULL,
+					   flags, msg, &err))
 			result |= error(_("could not remove reference %s"), refname);
 	}
+	if (ref_transaction_commit(transaction, &err))
+		goto error;
 
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return result;
 
@@ -1309,6 +1305,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	else
 		error(_("could not delete references: %s"), err.buf);
 
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return -1;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 97b6837767..fdb7a0a52c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1519,55 +1519,6 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
 	return ref_transaction_commit(transaction, err);
 }
 
-static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
-			     struct string_list *refnames, unsigned int flags)
-{
-	struct packed_ref_store *refs =
-		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
-	struct strbuf err = STRBUF_INIT;
-	struct ref_transaction *transaction;
-	struct string_list_item *item;
-	int ret;
-
-	(void)refs; /* We need the check above, but don't use the variable */
-
-	if (!refnames->nr)
-		return 0;
-
-	/*
-	 * Since we don't check the references' old_oids, the
-	 * individual updates can't fail, so we can pack all of the
-	 * updates into a single transaction.
-	 */
-
-	transaction = ref_store_transaction_begin(ref_store, &err);
-	if (!transaction)
-		return -1;
-
-	for_each_string_list_item(item, refnames) {
-		if (ref_transaction_delete(transaction, item->string, NULL,
-					   flags, msg, &err)) {
-			warning(_("could not delete reference %s: %s"),
-				item->string, err.buf);
-			strbuf_reset(&err);
-		}
-	}
-
-	ret = ref_transaction_commit(transaction, &err);
-
-	if (ret) {
-		if (refnames->nr == 1)
-			error(_("could not delete reference %s: %s"),
-			      refnames->items[0].string, err.buf);
-		else
-			error(_("could not delete references: %s"), err.buf);
-	}
-
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
-	return ret;
-}
-
 static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	/*
@@ -1595,7 +1546,7 @@ struct ref_storage_be refs_be_packed = {
 
 	.pack_refs = packed_pack_refs,
 	.create_symref = NULL,
-	.delete_refs = packed_delete_refs,
+	.delete_refs = NULL,
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index df75e5727c..f64166f9d7 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -744,7 +744,7 @@ test_expect_success "branch: rename branches" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "branch: remove branches" '
+test_expect_success "branch: remove branches" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -873,7 +873,7 @@ test_expect_success "tag: update refs to create loose refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "tag: remove tags with mixed ref_stores" '
+test_expect_success "tag: remove tags with mixed ref_stores" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b45879a760..22de7ac9ec 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -168,6 +168,8 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	cd "$D" &&
 	git clone . prune-fail &&
 	cd prune-fail &&
+	git update-ref refs/remotes/origin/extrabranch main~ &&
+	git pack-refs --all &&
 	git update-ref refs/remotes/origin/extrabranch main &&
 	: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
 	>.git/packed-refs.new &&
@@ -175,6 +177,21 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	test_must_fail git fetch --prune origin
 '
 
+test_expect_success REFFILES 'fetch --prune ok for loose refs not in locked packed-refs' '
+	test_when_finished "cd \"$D\"; rm -rf \"prune-ok-ref-not-packed\"" &&
+	cd "$D" &&
+	git clone . prune-ok-ref-not-packed &&
+	(
+		cd prune-ok-ref-not-packed &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		: for loose refs not in packed-refs, we can delete them even the packed-refs is locked &&
+		:>.git/packed-refs.new &&
+
+		git fetch --prune origin &&
+		test_must_fail git rev-parse refs/remotes/origin/extrabranch --
+	)
+'
+
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
 
-- 
2.36.1.25.gc87d5ad63a.dirty

