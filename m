Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3FEC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE0E60E78
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGYM24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:28:56 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:26132 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhGYM2W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 63A71AB0;
        Sun, 25 Jul 2021 15:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218516; x=1629032917;
         bh=VqjrI+/TJRXkejnTF3C7M+Xu7sNgcudEVHyrtpY9rDc=; b=T4+z6N16oKZl
        WKNcmu3IiwlHg/E0zNGR8X8aw4/p3x2byRt3gXQJO/8La0RSLx4c2OrJX9M7F8ci
        Tj9kFuvCiKJnWwBobpsyflL1qPAPYMmZiYYODypdsLXFRmUJuzCg6e+r2tYSEteD
        ZR6MRYglQ6Fn3RD/7yBZ5zRojKUwBifbPqihZQuO423eWSA4Ubydt8DX8ZN9PY5L
        CeBznW7TKSAZlUzq2DH2gnmhCgPN3lpREsmPNBRL3NuCKXMDBYjJZDZhkCnv/xpt
        Hfb0lWVJ4crJ8NgLBWQGtqJAGMtga6LOOTW/s147ICV5QfNzGC5/lPULJketj4nF
        dRUcsbHlPXZ0opAtPu2CSF5NjnLNMTJEGZ78RyYshBiNxid99PF6c2jFkaapSWvr
        spmVTz29lmIqTDP3EQKkOTDmlo6S5qt03X7kkLnBtmCoTCCGsEzKQztEerxzD4GD
        V2Faf99IFk5mBkOpKMXWBzpcqg32pSPMmUtfBpClxNI3MY+hHjKC6vI8FYJlYgCr
        bvdS9gTKv39E9cfQxwdacL7P0JXwTlbkEQMi5TH1hnTu930bzqxtTKNqieF+uxZS
        uDLHz37DgPyIjSqnSy/FqBSFmWCTM7qXmYnWMD5PRpfPqoSNGSnLi93sbhxQPluM
        1+F0FOrliQdLP/H09uSVPXWM7tGUbNU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vXNtkQBMku0M; Sun, 25 Jul 2021 15:08:36 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id B4C3C702;
        Sun, 25 Jul 2021 15:08:36 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 44CB917C;
        Sun, 25 Jul 2021 15:08:35 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 01/12] fmt-merge-msg: free newly allocated temporary strings when done
Date:   Sun, 25 Jul 2021 15:08:19 +0200
Message-Id: <20210725130830.5145-2-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

origin starts off pointing to somewhere within line, which is owned by
the caller. Later we might allocate a new string using xmemdupz() or
xstrfmt(). To avoid leaking these new strings, we introduce a to_free
pointer - which allows us to safely free the newly allocated string when
we're done (we cannot just free origin directly as it might still be
pointing to line).

LSAN output from t0090:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0xa71f49 in do_xmalloc wrapper.c:41:8
    #2 0xa720b0 in do_xmallocz wrapper.c:75:8
    #3 0xa720b0 in xmallocz wrapper.c:83:9
    #4 0xa720b0 in xmemdupz wrapper.c:99:16
    #5 0x8092ba in handle_line fmt-merge-msg.c:187:23
    #6 0x8092ba in fmt_merge_msg fmt-merge-msg.c:666:7
    #7 0x5ce2e6 in prepare_merge_message builtin/merge.c:1119:2
    #8 0x5ce2e6 in collect_parents builtin/merge.c:1215:3
    #9 0x5c9c1e in cmd_merge builtin/merge.c:1454:16
    #10 0x4ce83e in run_builtin git.c:475:11
    #11 0x4ccafe in handle_builtin git.c:729:3
    #12 0x4cb01c in run_argv git.c:818:4
    #13 0x4cb01c in cmd_main git.c:949:19
    #14 0x6b3fad in main common-main.c:52:11
    #15 0x7fb929620349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 8 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 fmt-merge-msg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 0f66818e0f..b969dc6ebb 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -108,6 +108,7 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 	struct origin_data *origin_data;
 	char *src;
 	const char *origin, *tag_name;
+	char *to_free = NULL;
 	struct src_data *src_data;
 	struct string_list_item *item;
 	int pulling_head = 0;
@@ -183,12 +184,13 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 	if (!strcmp(".", src) || !strcmp(src, origin)) {
 		int len = strlen(origin);
 		if (origin[0] == '\'' && origin[len - 1] == '\'')
-			origin = xmemdupz(origin + 1, len - 2);
+			origin = to_free = xmemdupz(origin + 1, len - 2);
 	} else
-		origin = xstrfmt("%s of %s", origin, src);
+		origin = to_free = xstrfmt("%s of %s", origin, src);
 	if (strcmp(".", src))
 		origin_data->is_local_branch = 0;
 	string_list_append(&origins, origin)->util = origin_data;
+	free(to_free);
 	return 0;
 }
 
-- 
2.26.2

