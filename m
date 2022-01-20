Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270B0C433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 07:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiATHrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiATHrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 02:47:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D4AC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:47:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso19833329wmj.2
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wlgh7dcbZfRgjyco0Pqr2rhpATfv7bqNQvgO75fQuDY=;
        b=E9AeCrZ2KwN9DlQ89pVFzAif3p0GjBRQLyuE6JbC07N0rL8r4jYcWS+h+/h8QE7Qwk
         +Yi4DL6lTnERQK6a0mZsSKVipjbmh4n2yBPFTdAr1VRQBo6yFp5w/5YLStqGSWq/n+Iw
         5ihJ5jhri+nwxLRKC2C9VlxSPR/1+gkblklZ2jTKCB6MSURCNqdxQ6GgAJuLvOEo+FAd
         flKrWF5JvBd27VekL6i5uDRVTPG8TwqFFAWsXzXdH9Z2sAY6d02ATIv8Pqsp9bkClHzA
         R31fp6DVljLbYWLle8eXw5qUr4BQPjYFUipI/i754KMAgQ4fm2zST35QFqkM8DNPT0wq
         60Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wlgh7dcbZfRgjyco0Pqr2rhpATfv7bqNQvgO75fQuDY=;
        b=e08W5eojR33rAdB/s3Asbz51Wm8Q+AeAqm4W+QOeNfeyokmrPqw9rhhouatSIOb9O3
         j42lgnb1y9+khjwnumsfeiGVt9clk7PVOXdNzL3Q6rnpUbCr8psb0P9ehqmPtG3XT8/Q
         sEgz+omXnTxegl4Ei6hKiLA8m2ovBzNxi5+dAIl1HOrJ8rnL5xE7Fyvz8jJ6YsCbaBAg
         PMCWLMNOu+YBNe9BGmjROgxawZzCfsQR3p2EQciYtvdLWU060l+8ivz+VPdfqC6yw5ZE
         IqIJm4cnHbzVu830Ei0JPDpChKEp5yQXXC42oIkydtZplCyLst9V/0em1D4XIDnWLi9P
         NvzA==
X-Gm-Message-State: AOAM532K5s27Esw6DgjIa9ZNpHfhrLjyVhXSjApkltGl/thbjuUhRIUM
        tbar5wsppalrSKvEccCc8pY/oHUIS+k=
X-Google-Smtp-Source: ABdhPJzu4DWjzpp5UlqRo2IrXTq38I24YoCyqP0FWOt1xAJCM8PVgwUb2pKk2X1tpM4sH2Oik966KA==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr7609681wmh.22.1642664838550;
        Wed, 19 Jan 2022 23:47:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14sm2472639wri.32.2022.01.19.23.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 23:47:17 -0800 (PST)
Message-Id: <c6522d6449f9323edbbd9329b2859368492aabd3.1642664835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1200.git.git.1642664835.gitgitgadget@gmail.com>
References: <pull.1200.git.git.1642664835.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 07:47:15 +0000
Subject: [PATCH 2/2] merge: fix memory leaks in cmd_merge()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were two commit_lists created in cmd_merge() that were only
conditionally free()'d.  Add a quick conditional call to
free_commit_list() for each of them at the end of the function.

Testing this commit against t6404 under valgrind shows that this patch
fixes the following two leaks:

    16 bytes in 1 blocks are definitely lost in loss record 16 of 126
       at 0x484086F: malloc (vg_replace_malloc.c:380)
       by 0x69FFEB: do_xmalloc (wrapper.c:41)
       by 0x6A0073: xmalloc (wrapper.c:62)
       by 0x52A72D: commit_list_insert (commit.c:556)
       by 0x47FC93: reduce_parents (merge.c:1114)
       by 0x4801EE: collect_parents (merge.c:1214)
       by 0x480B56: cmd_merge (merge.c:1465)
       by 0x40686E: run_builtin (git.c:464)
       by 0x406C51: handle_builtin (git.c:716)
       by 0x406E96: run_argv (git.c:783)
       by 0x40730A: cmd_main (git.c:914)
       by 0x4E7DFA: main (common-main.c:56)

    8 (16 direct, 32 indirect) bytes in 1 blocks are definitely lost in \
    loss record 61 of 126
       at 0x484086F: malloc (vg_replace_malloc.c:380)
       by 0x69FFEB: do_xmalloc (wrapper.c:41)
       by 0x6A0073: xmalloc (wrapper.c:62)
       by 0x52A72D: commit_list_insert (commit.c:556)
       by 0x52A8F2: commit_list_insert_by_date (commit.c:620)
       by 0x5270AC: get_merge_bases_many_0 (commit-reach.c:413)
       by 0x52716C: repo_get_merge_bases (commit-reach.c:438)
       by 0x480E5A: cmd_merge (merge.c:1520)
       by 0x40686E: run_builtin (git.c:464)
       by 0x406C51: handle_builtin (git.c:716)
       by 0x406E96: run_argv (git.c:783)
       by 0x40730A: cmd_main (git.c:914)

There are still 3 leaks in chdir_notify_register() after this, but
chdir_notify_register() has been brought up on the list before and folks
were not a fan of fixing those, so I'm not touching them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 74e53cf20a7..bd8fff9b223 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1273,7 +1273,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
-	struct commit_list *remoteheads, *p;
+	struct commit_list *remoteheads = NULL, *p;
 	void *branch_to_free;
 	int orig_argc = argc;
 
@@ -1752,6 +1752,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		ret = suggest_conflicts();
 
 done:
+	if (!automerge_was_ok) {
+		free_commit_list(common);
+		free_commit_list(remoteheads);
+	}
 	strbuf_release(&buf);
 	free(branch_to_free);
 	return ret;
-- 
gitgitgadget
