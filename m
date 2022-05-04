Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24452C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351632AbiEDPER (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiEDPEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:04:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67632BC35
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:00:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x18so2449657wrc.0
        for <git@vger.kernel.org>; Wed, 04 May 2022 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5Pq5/ZUIdoe6ryJRwqyDsnMrUsQIJeaFolZVgslWm2A=;
        b=NlaI+6CpcOEazCDnyRhgwY7p/tAHLt/fB5pURiGR3AAyNCD+mMAAK+lZNVl+hd4Hrh
         x+nCXa9z/KXIaqco9NT30ZN1cq0FMigdDFIBgQGqskt9eAfqi3qu+mRuD2PCKSUXSdk7
         hM+OMdqnDuxPE05qF0LGMVijm59O1xOFSR2eGL7xpL4A9gVqM143E+RUiOU31rrM0Gi3
         oWDezp+HSjHt9fpCkEZJ3S4gBZyBDZNJSXze4XAlfdyGRMJRl7SQ8oLQ6i84CEd2FkYr
         3M9gzCYPduzakpFv/JJZ3KjBflbW0tRGAA9cP0evek+yxG3KzsWgUtzCp+op1q7NWiXx
         QNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Pq5/ZUIdoe6ryJRwqyDsnMrUsQIJeaFolZVgslWm2A=;
        b=AYjZ/Xs1IRatJYZ5epvvvZqGF0geKHKPMa0r4ftmYGOgS87WUgNsZD2XuWIwMA0b2M
         g5ab/1gOBX1lirR8Z+8Uq4L7icSSbA33ai4xzPHFYfOefexcLKrNCRjC5VR1kYjRu+Ut
         t1XqT4i1gpVcx9ViCe+tuHJ0+qF1FQntphaxNWpBMCIyOn6KZ4PF4pkjyDZ+y9dSxgtn
         ZhyWHYXJo9F2srQ+RQ/Hm5GRsBb48v4t+2V2N0hoFP2f/xAw8czDlTorBBp0hL4Kp1KQ
         LR9hIUxtzuBYHGWsrMVJSpYZVcOagxEmt6xNi/9JSpk5c+PtAjhMSy7XRuqBLQ0aDqPZ
         qryw==
X-Gm-Message-State: AOAM533DEckwayIu/4Q9yDZ+/HBwiGaHKJl36io8pCfIAeerHq4AZnnL
        1HM815Fs7CPYREadz4V6Qti7oPGpN+E=
X-Google-Smtp-Source: ABdhPJxKiBuCpIvXe5kd6nZbQteqMywfja1ZgYSgBm5kaQdfAZCeFzDi8ffSBnQBEB3RGnMpTpPTwA==
X-Received: by 2002:a5d:4e92:0:b0:20a:cafc:ebf1 with SMTP id e18-20020a5d4e92000000b0020acafcebf1mr16221387wru.17.1651676437355;
        Wed, 04 May 2022 08:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b003942a244f3csm3940469wms.21.2022.05.04.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:00:36 -0700 (PDT)
Message-Id: <pull.1228.git.1651676435634.gitgitgadget@gmail.com>
From:   "Michael Heemskerk via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 15:00:35 +0000
Subject: [PATCH] refs: honor reference-transaction semantics when deleting
 refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Michael Heemskerk <mheemskerk@atlassian.com>,
        Michael Heemskerk <mheemskerk@atlassian.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Heemskerk <mheemskerk@atlassian.com>

When deleting refs from the loose-files refs backend, files_delete_refs
first rewrites packed-refs if any of the to-be-deleted refs were packed
and then removes loose refs. While making those changes, it invokes the
reference-transaction hook incorrectly; a single transaction is used to
prepare and commit the changes to packed-refs, followed by another
transaction per deleted ref, each with another prepared and committed
reference-transaction hook invocation.

This behaviour is problematic for a number of reasons. First of all,
deleting a ref through `git branch -d` or `git tag -d` results in a
different sequence of reference-transaction callbacks than deleting the
same ref through `git update-ref`:

- update-ref of a loose ref: aborted, prepared, committed
- update-ref of a packed ref: prepared, prepared, committed, commited
- branch -d: prepared, committed, aborted, prepared, committed

The bigger problem is that the packed-refs update is committed before
the prepared reference-transaction invocation is done for the loose
ref. Returning a non-zero exit code from the second
reference-transaction callback leads to an invalid sequence of
reference-transaction callbacks:

1. prepared - hook returns 0, so the change is allowed to go through.
2. committed - git informs the hook that the changes are now final,
   but are they really? Any loose refs may still survive if the
   subsequent prepared callback is canceled.
3. aborted - 'fake' invocation from the packed-transaction because the
   ref does not exist in packed-refs.
4. prepared - hook returns 1, so the change should be blocked.
5. aborted - git informs the hook that it has rolled back the change,
   but it really hasn't; packed-refs has already been rewritten and
   if the ref only existed as a packed ref, it is now gone.

The changes to the reference-transaction invocations that were planned
for git 2.36 but have been reverted make the problem more pronounced.
Those changes suppress the 'fake' invocations for the packed-transaction
(invocations 1-3 in the above list). In that case, the prepared callback
in step 4 cannot prevent a ref from being deleted if it only existed in
packed-refs.

To address the issue, the use a separate transactions to update the
packed and loose refs has been removed from files_delete_refs. Instead,
it now uses a single transaction, queues up the refs-to-be-deleted and
relies on the standard transaction mechanism to invoke the
reference-transaction hooks as expected.

Signed-off-by: Michael Heemskerk <mheemskerk@atlassian.com>
---
    refs: honor reference-transaction semantics when deleting refs
    
    When deleting refs from the loose-files refs backend, files_delete_refs
    first rewrites packed-refs if any of the to-be-deleted refs were packed
    and then removes loose refs. While making those changes, it invokes the
    reference-transaction hook incorrectly; a single transaction is used to
    prepare and commit the changes to packed-refs, followed by another
    transaction per deleted ref, each with another prepared and committed
    reference-transaction hook invocation.
    
    This behaviour is problematic for a number of reasons. First of all,
    deleting a ref through git branch -d or git tag -d results in a
    different sequence of reference-transaction callbacks than deleting the
    same ref through git update-ref:
    
     * update-ref of a loose ref: aborted, prepared, committed
     * update-ref of a packed ref: prepared, prepared, committed, commited
     * branch -d: prepared, committed, aborted, prepared, committed
    
    The bigger problem is that the packed-refs update is committed before
    the prepared reference-transaction invocation is done for the loose ref.
    Returning a non-zero exit code from the second reference-transaction
    callback leads to an invalid sequence of reference-transaction
    callbacks:
    
     1. prepared - hook returns 0, so the change is allowed to go through.
     2. committed - git informs the hook that the changes are now final, but
        are they really? Any loose refs may still survive if the subsequent
        prepared callback is canceled.
     3. aborted - 'fake' invocation from the packed-transaction because the
        ref does not exist in packed-refs.
     4. prepared - hook returns 1, so the change should be blocked.
     5. aborted - git informs the hook that it has rolled back the change,
        but it really hasn't; packed-refs has already been rewritten and if
        the ref only existed as a packed ref, it is now gone.
    
    The changes to the reference-transaction invocations that were planned
    for git 2.36 but have been reverted make the problem more pronounced.
    Those changes suppress the 'fake' invocations for the packed-transaction
    (invocations 1-3 in the above list). In that case, the prepared callback
    in step 4 cannot prevent a ref from being deleted if it only existed in
    packed-refs.
    
    To address the issue, the use a separate transactions to update the
    packed and loose refs has been removed from files_delete_refs. Instead,
    it now uses a single transaction, queues up the refs-to-be-deleted and
    relies on the standard transaction mechanism to invoke the
    reference-transaction hooks as expected.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1228%2Fmheemskerk%2Ffiles-delete-ref-reference-transaction-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1228/mheemskerk/files-delete-ref-reference-transaction-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1228

 refs/files-backend.c             | 33 +++++++--------
 t/t1416-ref-transaction-hooks.sh | 70 ++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh                 |  6 +--
 3 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8db7882aacb..5c23277eda7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1265,44 +1265,39 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
-	int i, result = 0;
+	int i;
+	struct ref_transaction *transaction;
 
 	if (!refnames->nr)
 		return 0;
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
-		goto error;
-
-	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
-		packed_refs_unlock(refs->packed_ref_store);
+	transaction = ref_store_transaction_begin(&refs->base, &err);
+	if (!transaction)
 		goto error;
-	}
-
-	packed_refs_unlock(refs->packed_ref_store);
 
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
-
-		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
-			result |= error(_("could not remove reference %s"), refname);
+		if (ref_transaction_delete(transaction, refname, NULL,
+					   flags, msg, &err))
+			goto error;
 	}
 
+	if (ref_transaction_commit(transaction, &err))
+		goto error;
+
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	return result;
+	return 0;
 
 error:
-	/*
-	 * If we failed to rewrite the packed-refs file, then it is
-	 * unsafe to try to remove loose refs, because doing so might
-	 * expose an obsolete packed value for a reference that might
-	 * even point at an object that has been garbage collected.
-	 */
 	if (refnames->nr == 1)
 		error(_("could not delete reference %s: %s"),
 		      refnames->items[0].string, err.buf);
 	else
 		error(_("could not delete references: %s"), err.buf);
 
+	if (transaction)
+		ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return -1;
 }
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 27731722a5b..e3d4fe624f7 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -133,4 +133,74 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
+test_expect_success 'hook allows deleting loose ref if successful' '
+	test_when_finished "rm actual" &&
+	git branch to-be-deleted $PRE_OID &&
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+	EOF
+	cat >expect <<-EOF &&
+		aborted
+		prepared
+		committed
+	EOF
+	git branch -d to-be-deleted &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse refs/heads/to-be-deleted
+'
+
+test_expect_success 'hook allows deleting packed ref if successful' '
+	test_when_finished "rm actual" &&
+	git branch to-be-deleted $PRE_OID &&
+	git pack-refs --all --prune &&
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+	EOF
+	cat >expect <<-EOF &&
+		prepared
+		prepared
+		committed
+		committed
+	EOF
+	git branch -d to-be-deleted &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse refs/heads/to-be-deleted
+'
+
+test_expect_success 'hook aborts deleting loose ref in prepared state' '
+	test_when_finished "rm actual" &&
+	test_when_finished "git branch -d to-be-deleted" &&
+	git branch to-be-deleted $PRE_OID &&
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		exit 1
+	EOF
+	cat >expect <<-EOF &&
+		aborted
+		prepared
+		aborted
+	EOF
+	test_must_fail git branch -d to-be-deleted &&
+	test_cmp expect actual &&
+	git rev-parse refs/heads/to-be-deleted
+'
+
+test_expect_success 'hook aborts deleting packed ref in prepared state' '
+	test_when_finished "rm actual" &&
+	test_when_finished "git branch -d to-be-deleted" &&
+	git branch to-be-deleted $PRE_OID &&
+	git pack-refs --all --prune &&
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		exit 1
+	EOF
+	cat >expect <<-EOF &&
+		prepared
+		aborted
+	EOF
+	test_must_fail git branch -d to-be-deleted &&
+	test_cmp expect actual &&
+	git rev-parse refs/heads/to-be-deleted
+'
+
 test_done
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4620f0ca7fa..8b09a99c2e8 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -169,10 +169,10 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	git clone . prune-fail &&
 	cd prune-fail &&
 	git update-ref refs/remotes/origin/extrabranch main &&
-	: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
-	>.git/packed-refs.new &&
+	: this will prevent --prune from locking refs/remotes/origin/extra for deletion &&
+	>.git/refs/remotes/origin/extrabranch.lock &&
 
-	test_must_fail git fetch --prune origin
+	test_must_fail git fetch --prune origin > outputs 2> errors
 '
 
 test_expect_success 'fetch --atomic works with a single branch' '

base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
-- 
gitgitgadget
