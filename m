Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A7C19F2C
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiG2KNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiG2KM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D002480F5B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y9so4213207pff.12
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pnYj2ZiDDgT+0RwpuNP6TDb+/1ojVFBEIKhL1B7z6DA=;
        b=eGSfdpRXgSxhSk97+ihvBpiVHDxFzh36QeJOqIRW6aWOQmtnRj6kJnN8zf+GenYkXC
         Xp7PYaKlnS3v1clyZMPbyoY434lKnbIwtJtWnvX2c7roYmyss506eiCibvlwrgWcSPXb
         bqVopFs/8ULTbReN8SqRlU09CwfOMfho0MGMxbFCklfpLf5IMePyh6DCnKDX+sNPiZPJ
         enqFWoy4dmde5OR+97EsjxPgTM61d80X1SZNSvORbAzD1VjHcQ+BwGfCgw6NlTpAs9k5
         j++A1+LsLcPCuxxT+uYmF59+lTfSLmVa4GJTxvF06TgOGbGLaFlWX2Kc+goFevStOric
         2eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pnYj2ZiDDgT+0RwpuNP6TDb+/1ojVFBEIKhL1B7z6DA=;
        b=SdINR82FoEJx5S1QQccy/nox2J5TtJyxmQlhojJ1rFfIOgE0LR4X3CaJ1sc+tO6ngG
         mIcShs9H+VrbCF4dPQmm7nTUNmd1fNfQX7GdEL/I4V5PFLUTew9AsjWyRAqMwTjKkXH8
         mXKznQQZrRUoz8zS0+3LoPIarL4WOFQVQ3ohaDE8z8rpRnlzStafn0fTgY3z+/u9WAPM
         VhHz1bXGWdbPLyyw6pAF2qfHDfxnAdG0GwphC+mImhH3jdnUtXbpzDprlU2FrI5onphW
         AC2utbPuD7LJonZpm2LJIrSKMdLaIIg+4lzrZft6OwIV5b3woiWWdn91qoCx+n6fyit4
         he3g==
X-Gm-Message-State: AJIora/en/62EyHasQLj4S9HSl5JoaOX72EJSqQv60bNSuRgWq4jcGyy
        tSXfRE75mtWAR+tsUZrSFYY=
X-Google-Smtp-Source: AGRyM1vlc1G3OdTVY7bt3/NGrrIpGsELceXt4N9uJqJZUZevrHOmiOIx6Vef1ZfxSiKa9mbf3dkW9w==
X-Received: by 2002:a63:4847:0:b0:419:c8f4:4f88 with SMTP id x7-20020a634847000000b00419c8f44f88mr2277727pgk.603.1659089578362;
        Fri, 29 Jul 2022 03:12:58 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:58 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 5/9] refs: avoid duplicate running of the reference-transaction hook
Date:   Fri, 29 Jul 2022 18:12:41 +0800
Message-Id: <20220729101245.6469-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

If there are references to be deleted in a transaction, we should remove
each reference from both loose references and the "packed-refs" file.
The "reference-transaction" hook will run twice, once for the primary
ref-store (loose references), and another for the second ref-store (i.e.
packed ref-store).

To avoid duplicate running of the "reference-trancaction" hook, we pass
a special "hook-flags" parameter to initialize the second ref-store.
The "REF_TRANSACTION_RUN_PREPARED_HOOK" bit is preserved for the
transaction of the second ref-store because we may still want to call
command "reference-trancaction prepared" for some pre-checks, such as
terminate unwanted transaction for the "packed-refs" file.

The behavior of the following git commands and five testcases have been
fixed in t1416:

 * git cherry-pick
 * git rebase
 * git revert
 * git update-ref -d <ref>
 * git update-ref --stdin	# delete refs

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             |  7 +++++--
 t/t1416-ref-transaction-hooks.sh | 10 +++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3be317d524..e8d12cb343 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2788,8 +2788,11 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
index 7f8fd012e8..21d5326575 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -407,7 +407,7 @@ test_expect_success "update-ref: update refs already packed to .git/packed-refs"
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "update-ref: remove refs with mixed ref_stores" '
+test_expect_success "update-ref: remove refs with mixed ref_stores" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -523,7 +523,7 @@ test_expect_success "update-ref --stdin: update refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "update-ref --stdin: delete refs" '
+test_expect_success "update-ref --stdin: delete refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -1023,7 +1023,7 @@ test_expect_success "worktree: topic2: merge" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "worktree: topic3: cherry-pick" '
+test_expect_success "worktree: topic3: cherry-pick" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -1067,7 +1067,7 @@ test_expect_failure "worktree: topic3: cherry-pick" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "worktree: topic4: rebase" '
+test_expect_success "worktree: topic4: rebase" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -1119,7 +1119,7 @@ test_expect_failure "worktree: topic4: rebase" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "worktree: topic5: revert" '
+test_expect_success "worktree: topic5: revert" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
-- 
2.36.1.25.gc87d5ad63a.dirty

