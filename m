Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFCBC19F29
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiG2KM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiG2KM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E817747AB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bf13so3651309pgb.11
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RK1ycheVVsycdufDxsj8L/k3H2np/x9auXc508QN99Y=;
        b=KLbS5/wJuqVNG9Kc8IZhM9ftuUfJzAc+h1qdmwjXGAy1vvHjKfXI45qFHuuE8SktsN
         H3KF8ICvPjExZzAdVN8E2PWi2Ilr1DpkZHF7f5voDqXuMv5qnvUyZ+HPCRDa9/81Bbfo
         RbBSnhZgJN2/+tqRp3s5BcRIi43Ihg4hT69X1UyWiGYks8IbkNjqtP55E0UftwT5CaHV
         t/jnH6g8zlr4LIx7qxqLsipfYOG9Xf2rWgfXjSrMWYrSSREdqRv84GCUiM005Vc38h6p
         dGfQyRyMCDfTMB1TZuEevC0P8DN1I+kVLpxj9SKpuE3OOVEw6b9mUPsxKppxdIIntY/+
         FqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RK1ycheVVsycdufDxsj8L/k3H2np/x9auXc508QN99Y=;
        b=tGWWU2Lu3ZI9A0sqDbRiqQBIWxj1fPjNPmkL51D0WsYaDiwvTxx4W7+O4Pv6Trf8KF
         qpKU3qZBCdeJq/k5rRi/JeKk59kbS9DqIgmkP8DUck/vtDsNoA1GvKq9zRnyimuzmVFm
         yJCJTqQN0l5rEwRZBuj1VPBiQKYDupO+naSVoGmysj/F6UujSYfP+1co7QjBUsNKV8s+
         ZpyiV6Jk9lnGSVRXvq6Pbwf5hPiH/na9BMtgEsT0o4u0qinlBBPk6XyeqPfvEh1Br7Dc
         6fI8AXr+VRigYhL/gyGsv6VLDZWpbYcmDZRvgOSjp8dTVdqvtmfmC2yu2PBzD3LU9W7Z
         a4rQ==
X-Gm-Message-State: AJIora+lSbq0SvetGvcuXZZI5JmHGMCgFSDEsa2TdJ9Vl19I9Ki6GHLs
        bIWmDmkn8nrm4hiBhC2CkxM=
X-Google-Smtp-Source: AGRyM1uQW8ZhepveA6bo9B5flutuayLeHWnQbrsFwqzozbxBDG8sNSbvIAKKtQP1aJbLGJ2VwJbBxg==
X-Received: by 2002:a63:1f02:0:b0:41a:f9b8:b4fd with SMTP id f2-20020a631f02000000b0041af9b8b4fdmr2333542pgf.443.1659089575635;
        Fri, 29 Jul 2022 03:12:55 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:55 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 2/9] refs: update missing old-oid in transaction from lockfile
Date:   Fri, 29 Jul 2022 18:12:38 +0800
Message-Id: <20220729101245.6469-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

For commands that update a reference without providing an old-oid, the
"reference-transaction" hook will receive a zero-oid instead of the
correct old-oid.

In order to provide the "reference-transaction" hook with a real old-oid
in any case, get proper old_oid from the lock file and propagate it to
the corresponding update entry of a transaction.

The behavior of the following git commands and four testcases have been
fixed in t1416:

 * git branch [-f] <ref> <new-oid>              # update branch
 * git cherry-pick <oid>
 * git rebase
 * git tag -d <tag>
 * git update-ref --stdin                       # update refs
 * git update-ref -d <ref>
 * git update-ref <ref> <new-oid> [<old-oid>]   # update ref

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             |  9 +++++++++
 t/t1416-ref-transaction-hooks.sh | 12 ++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8db7882aac..957ebe08c0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2565,6 +2565,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			goto out;
 		}
 
+		/*
+		 * Propagate old_oid from the lock to the update entry, so we can
+		 * provide a real old-oid of to the "reference-transaction" hook.
+		 */
+		if (!(update->flags & REF_HAVE_OLD)) {
+			oidcpy(&update->old_oid, &lock->old_oid);
+			update->flags |= REF_HAVE_OLD;
+		}
+
 		/*
 		 * If this update is happening indirectly because of a
 		 * symref update, record the old OID in the parent
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index a84621516c..eef7489b5b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -53,7 +53,7 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 	EOF
 	cat >expect <<-EOF &&
 		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/main
+		$PRE_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST <<-EOF &&
 		update HEAD $ZERO_OID $POST_OID
@@ -76,7 +76,7 @@ test_expect_success 'hook gets all queued updates in committed state' '
 	EOF
 	cat >expect <<-EOF &&
 		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/main
+		$PRE_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST &&
 	test_cmp expect actual
@@ -321,7 +321,7 @@ test_expect_success "update-ref: create new refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "update-ref: update HEAD, a symbolic-ref" '
+test_expect_success "update-ref: update HEAD, a symbolic-ref" '
 	test_when_finished "git switch main; rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -365,7 +365,7 @@ test_expect_failure "update-ref: call git-pack-refs to create packed_ref_store"
 	test_path_is_missing $HOOK_OUTPUT
 '
 
-test_expect_failure "update-ref: update refs already packed to .git/packed-refs" '
+test_expect_success "update-ref: update refs already packed to .git/packed-refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -485,7 +485,7 @@ test_expect_success "update-ref --stdin: create new refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "update-ref --stdin: update refs" '
+test_expect_success "update-ref --stdin: update refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -639,7 +639,7 @@ test_expect_failure "branch: call git-gc to create packed_ref_store" '
 	test_path_is_missing $HOOK_OUTPUT
 '
 
-test_expect_failure "branch: update refs to create loose refs" '
+test_expect_success "branch: update refs to create loose refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
-- 
2.36.1.25.gc87d5ad63a.dirty

