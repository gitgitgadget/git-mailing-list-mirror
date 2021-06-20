Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18261C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F127E6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFTPPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:15:16 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:15388 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFTPOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 2E013130B
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201953; x=1626016354;
         bh=fxqQkGUklOckyJHTrIVeDmxxwt1yQ8DicutANrUIb9k=; b=ZjGd1Rzq4ZUy
        BF7tu/5rl3Ekq1jbHbKydIXh7Zp/SlbioJAhO33zEGE6/z0ghnopZFDUwxWJRl3O
        8bEPBt7tsYO/A2KtOkWEQBBKcJMh2lYf4pQfK0QpE02OWIa8nDeeoB/TytDUsJ9w
        FuWGGgcnjUs4kSx+ss728gsTm8vwbS3Jxqk8QH9MPXr163yCV+TErr5ZaU6iGFY/
        NSUyIamnPVFI1vHY8d2uDMgWIYuyqSaJlUHz+p8nuc2vdcGyfGZpPQoy3JRk4OOA
        q2txM4zFtVl0ziNBBneeAFVy/zgEGV5cERSQNh595nen/rg37AahVDyTByqlNC2r
        rizSCQTdikxQ/xOZ61U2Q5ErPclZyuCxNOcUp18Tx3x34bFD8/HSwW6qYTRXmxKY
        QfGg/mDMHk0/1K00XwHH9ptoByrfbclNYHQRUcrB0dTVZswTLJ/v8/e2X76uoPZt
        jgUZGd6TTcWV7HP0vWlajg2+u6IS/fzGSgXtU1sWpM25gfLwIUGiDtyYe7IkAyg1
        dzckKfPNQPDjK7zVp+w4Xe0SyufhYU+lvn/7V9vNfQ8nuL+JzBL4wJ1Y01kQUDYJ
        iPqNYy2QjjgVOmskLHE8DR8C1rs2esbXHHlyf8EH0yBvNFm2vSuRJTBVxcuDYm11
        vgvKMQgEyrK3hVKrgUupyQhVskH/NL0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a-cxwJkjfWRS for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:33 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 8BBB85C1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:33 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 23D4F34B;
        Sun, 20 Jun 2021 17:12:32 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 12/12] reset: clear_unpack_trees_porcelain to plug leak
Date:   Sun, 20 Jun 2021 17:12:04 +0200
Message-Id: <20210620151204.19260-13-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

setup_unpack_trees_porcelain() populates various fields on
unpack_tree_opts, we need to call clear_unpack_trees_porcelain() to
avoid leaking them. Specifically, we used to leak
unpack_tree_opts.msgs_to_free.

We have to do this in leave_reset_head because there are multiple
scenarios where unpack_tree_opts has already been configured, followed
by a 'goto leave_reset_head'. But we can also 'goto leave_reset_head'
prior to having initialised unpack_tree_opts via memset(..., 0, ...).
Therefore we also move unpack_tree_opts initialisation to the start of
reset_head(), and convert it to use brace initialisation - which
guarantees that we can never clear an unitialised unpack_tree_opts.
clear_unpack_tree_opts() is always safe to call as long as
unpack_tree_opts is at least zero-initialised, i.e. it does not depend
on a previous call to setup_unpack_trees_porcelain().

LSAN output from t0021:

Direct leak of 192 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa721e5 in xrealloc wrapper.c:126:8
    #2 0x9f7861 in strvec_push_nodup strvec.c:19:2
    #3 0x9f7861 in strvec_pushf strvec.c:39:2
    #4 0xa43e14 in setup_unpack_trees_porcelain unpack-trees.c:129:3
    #5 0x97e011 in reset_head reset.c:53:2
    #6 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
    #7 0x4ce83e in run_builtin git.c:475:11
    #8 0x4ccafe in handle_builtin git.c:729:3
    #9 0x4cb01c in run_argv git.c:818:4
    #10 0x4cb01c in cmd_main git.c:949:19
    #11 0x6b3f3d in main common-main.c:52:11
    #12 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 147 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa721e5 in xrealloc wrapper.c:126:8
    #2 0x9e8d54 in strbuf_grow strbuf.c:98:2
    #3 0x9e8d54 in strbuf_vaddf strbuf.c:401:3
    #4 0x9f7774 in strvec_pushf strvec.c:36:2
    #5 0xa43e14 in setup_unpack_trees_porcelain unpack-trees.c:129:3
    #6 0x97e011 in reset_head reset.c:53:2
    #7 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
    #8 0x4ce83e in run_builtin git.c:475:11
    #9 0x4ccafe in handle_builtin git.c:729:3
    #10 0x4cb01c in run_argv git.c:818:4
    #11 0x4cb01c in cmd_main git.c:949:19
    #12 0x6b3f3d in main common-main.c:52:11
    #13 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 134 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa721e5 in xrealloc wrapper.c:126:8
    #2 0x9e8d54 in strbuf_grow strbuf.c:98:2
    #3 0x9e8d54 in strbuf_vaddf strbuf.c:401:3
    #4 0x9f7774 in strvec_pushf strvec.c:36:2
    #5 0xa43fe4 in setup_unpack_trees_porcelain unpack-trees.c:168:3
    #6 0x97e011 in reset_head reset.c:53:2
    #7 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
    #8 0x4ce83e in run_builtin git.c:475:11
    #9 0x4ccafe in handle_builtin git.c:729:3
    #10 0x4cb01c in run_argv git.c:818:4
    #11 0x4cb01c in cmd_main git.c:949:19
    #12 0x6b3f3d in main common-main.c:52:11
    #13 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 130 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa721e5 in xrealloc wrapper.c:126:8
    #2 0x9e8d54 in strbuf_grow strbuf.c:98:2
    #3 0x9e8d54 in strbuf_vaddf strbuf.c:401:3
    #4 0x9f7774 in strvec_pushf strvec.c:36:2
    #5 0xa43f20 in setup_unpack_trees_porcelain unpack-trees.c:150:3
    #6 0x97e011 in reset_head reset.c:53:2
    #7 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
    #8 0x4ce83e in run_builtin git.c:475:11
    #9 0x4ccafe in handle_builtin git.c:729:3
    #10 0x4cb01c in run_argv git.c:818:4
    #11 0x4cb01c in cmd_main git.c:949:19
    #12 0x6b3f3d in main common-main.c:52:11
    #13 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 603 byte(s) leaked in 4 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reset.c b/reset.c
index 4bea758053..79310ae071 100644
--- a/reset.c
+++ b/reset.c
@@ -21,7 +21,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
-	struct unpack_trees_options unpack_tree_opts;
+	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
 	const char *reflog_action;
 	struct strbuf msg = STRBUF_INIT;
@@ -49,7 +49,6 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	if (refs_only)
 		goto reset_head_refs;
 
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = r->index;
@@ -134,6 +133,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 leave_reset_head:
 	strbuf_release(&msg);
 	rollback_lock_file(&lock);
+	clear_unpack_trees_porcelain(&unpack_tree_opts);
 	while (nr)
 		free((void *)desc[--nr].buffer);
 	return ret;
-- 
2.26.2

