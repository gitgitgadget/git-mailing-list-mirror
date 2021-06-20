Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCFC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4138F6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFTPOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:52 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:15368 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230082AbhFTPOh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 15E4F12FC
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201942; x=1626016343;
         bh=7xJGAO3HmotPtfpYR5xOy+rsQdBXInpdymVSWPWfFvg=; b=Hre5Fsq7OoVt
        EDmpkXUrXyysd97My+ewUXX6hiliDJFkp392+vCHrlep2JRZZJOMNz881ySb9+8y
        qDYs0vTf8yt/FcrnPypoWEr1cBjt0L4J7g5QcMh/3jVMsFLs2kY/D0Fe+ay8Mowu
        qzFprnuDvxP9xpkbOXi0VcXFI/uXsF1vWCMSZoYFlwWLABZgApPLu6V9NaDteiHE
        nRpLglsDY6wvk1DJoPZxt/20qJfZJ3DwuFhOHTmY1DTMcoBdyMZztyq3cc1zXNMj
        Ii+oByjHNePGKkcfD/2xmaC4uPa6QDX96O/NJt/kO8GHsWGzuTaJikoiz6xjWcth
        UNth6GyIc2/N+TayhoxoqoUJXF5tZWF9PuzZASUl5HdjWCfEmrc/CX+0QA7eRQL4
        7MtaltdsNay76p6l/iB9E9eMpCeRYxAa+P2O7ivZSqbaV6PzOjX3uACxxmfFhYzF
        ifjzKn5K+GXOYmKgjhfDgiTWCD4O0Z9JIV0KKLNEeLyRF42A8ydkGCnjQGmdbnYF
        37P1SlUh3npxlUn2PSk63PYl1pYNYvoIM9ygBMy+LUmH9Rh+XDcg+/jW4qoaZ5Ek
        g0CmHPEQuNmS0CDvGx0QW0XkCK781t/wLEZddDjzjGt0by+bGSqsHlikBR7QTwvb
        Pv+mYaBNjOl+YA4VoK26763e08ABJrw=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DHOwdht5GxSc for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:22 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 8F7D25C1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:22 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id ABB4934B;
        Sun, 20 Jun 2021 17:12:21 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 07/12] read-cache: call diff_setup_done to avoid leak
Date:   Sun, 20 Jun 2021 17:11:59 +0200
Message-Id: <20210620151204.19260-8-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

repo_diff_setup() calls through to diff.c's static prep_parse_options(),
which in  turn allocates a new array into diff_opts.parseopts.
diff_setup_done() is responsible for freeing that array, and has the
benefit of verifying diff_opts too - hence we add a call to
diff_setup_done() to avoid leaking parseopts.

Output from the leak as found while running t0090 with LSAN:

Direct leak of 7120 byte(s) in 1 object(s) allocated from:
    #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0xa8bf89 in do_xmalloc wrapper.c:41:8
    #2 0x7a7bae in prep_parse_options diff.c:5636:2
    #3 0x7a7bae in repo_diff_setup diff.c:4611:2
    #4 0x93716c in repo_index_has_changes read-cache.c:2518:3
    #5 0x872233 in unclean merge-ort-wrappers.c:12:14
    #6 0x872233 in merge_ort_recursive merge-ort-wrappers.c:53:6
    #7 0x5d5b11 in try_merge_strategy builtin/merge.c:752:12
    #8 0x5d0b6b in cmd_merge builtin/merge.c:1666:9
    #9 0x4ce83e in run_builtin git.c:475:11
    #10 0x4ccafe in handle_builtin git.c:729:3
    #11 0x4cb01c in run_argv git.c:818:4
    #12 0x4cb01c in cmd_main git.c:949:19
    #13 0x6bdc2d in main common-main.c:52:11
    #14 0x7f551eb51349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 7120 byte(s) leaked in 1 allocation(s)

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index 77961a3885..212d604dd3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2487,37 +2487,38 @@ int unmerged_index(const struct index_state *istate)
 int repo_index_has_changes(struct repository *repo,
 			   struct tree *tree,
 			   struct strbuf *sb)
 {
 	struct index_state *istate = repo->index;
 	struct object_id cmp;
 	int i;
 
 	if (tree)
 		cmp = tree->object.oid;
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
 		repo_diff_setup(repo, &opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
+		diff_setup_done(&opt);
 		do_diff_cache(&cmp, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
 		}
 		diff_flush(&opt);
 		return opt.flags.has_changes != 0;
 	} else {
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(istate);
 		for (i = 0; sb && i < istate->cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, istate->cache[i]->name);
 		}
 		return !!istate->cache_nr;
 	}
 }
-- 
2.26.2

