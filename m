Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC4EC49361
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F197F6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFTPPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:15:07 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:15378 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFTPOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 344E31303
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201947; x=1626016348;
         bh=/ggegXae2JaTFVQ3cd/o5SGgrTHuCVFp27usIrpE0pw=; b=sgdUz91qx+HA
        Ckq3K9yDPBEO9lUyMwFC/ikdgCF6ItZnGtv/JUTLxDtjdfy1wdTgYqINPTTUwj0D
        kcKsfY7hqlIhKmrjXff0dlWEC5xNDxpBAhkkdwjdEoSNy5yo4gzeA2lY8lKl7IHS
        aFTIBF0IIAqoV/Qxa+PCy1TpNjmgwlCCTuA6TppfCHXQBX45KjUzcY9P6Pr29JoP
        rivG2OWQHQQ4mE5kxmdSyF9A8vMn5WLA1dZp8mGQSlopD62EtX+m92GCjR9T5+vL
        wH5750WUbGsfw/kcJ1FKnA+DzsGTWtZt7methG2w9LDf0i/w2d/EssgU8O85AQol
        16SbqL+hvY7QOMZI+TpwMGLfCnECDXCnCiwT7BPOEaw/xPLzGIoSyHtSGpsI5vna
        L5wlPKOHNkEzKp9MTHY2gGrHv9gZT7DX4eUMprCULegcwhOhwE15xTfT7GHPntAx
        MH3q6pi9B1pLRmDQS7AZCidnBT3iVPjlsDmtFkJxgMUoVo+smHtN1TJCoRlPn/lQ
        MIyS2uogyYcqf6Q+qZCNRxg0BcX8HQUxQxENqWVhaVjiqXwPPyBL4xesauI4eUV3
        ErPAUmm6uv7VZ4WeiYAPNBfCiBvJS+W6+XixHl+ltmdsoG05qLzd2lI5lZZf9AZj
        Ha3pdTxTDg+JdzaLTvpf2CxNzMkimRg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TB_Ma-yYU0QT for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:27 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 86C255C1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:27 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 6A8CB3357;
        Sun, 20 Jun 2021 17:12:26 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 09/12] builtin/mv: free or UNLEAK multiple pointers at end of cmd_mv
Date:   Sun, 20 Jun 2021 17:12:01 +0200
Message-Id: <20210620151204.19260-10-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

These leaks all happen at the end of cmd_mv, hence don't matter in any
way. But we still fix the easy ones and squash the rest to get us closer
to being able to run tests without leaks.

LSAN output from t0050:

Direct leak of 384 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa8c015 in xrealloc wrapper.c:126:8
    #2 0xa0a7e1 in add_entry string-list.c:44:2
    #3 0xa0a7e1 in string_list_insert string-list.c:58:14
    #4 0x5dac03 in cmd_mv builtin/mv.c:248:4
    #5 0x4ce83e in run_builtin git.c:475:11
    #6 0x4ccafe in handle_builtin git.c:729:3
    #7 0x4cb01c in run_argv git.c:818:4
    #8 0x4cb01c in cmd_main git.c:949:19
    #9 0x6bd9ad in main common-main.c:52:11
    #10 0x7fbfeffc4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0xa8bd09 in do_xmalloc wrapper.c:41:8
    #2 0x5dbc34 in internal_prefix_pathspec builtin/mv.c:32:2
    #3 0x5da575 in cmd_mv builtin/mv.c:158:14
    #4 0x4ce83e in run_builtin git.c:475:11
    #5 0x4ccafe in handle_builtin git.c:729:3
    #6 0x4cb01c in run_argv git.c:818:4
    #7 0x4cb01c in cmd_main git.c:949:19
    #8 0x6bd9ad in main common-main.c:52:11
    #9 0x7fbfeffc4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0xa8bd09 in do_xmalloc wrapper.c:41:8
    #2 0x5dbc34 in internal_prefix_pathspec builtin/mv.c:32:2
    #3 0x5da4e4 in cmd_mv builtin/mv.c:148:11
    #4 0x4ce83e in run_builtin git.c:475:11
    #5 0x4ccafe in handle_builtin git.c:729:3
    #6 0x4cb01c in run_argv git.c:818:4
    #7 0x4cb01c in cmd_main git.c:949:19
    #8 0x6bd9ad in main common-main.c:52:11
    #9 0x7fbfeffc4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x49a9a2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0xa8c119 in xcalloc wrapper.c:140:8
    #2 0x5da585 in cmd_mv builtin/mv.c:159:22
    #3 0x4ce83e in run_builtin git.c:475:11
    #4 0x4ccafe in handle_builtin git.c:729:3
    #5 0x4cb01c in run_argv git.c:818:4
    #6 0x4cb01c in cmd_main git.c:949:19
    #7 0x6bd9ad in main common-main.c:52:11
    #8 0x7fbfeffc4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x49a9a2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0xa8c119 in xcalloc wrapper.c:140:8
    #2 0x5da4f8 in cmd_mv builtin/mv.c:149:10
    #3 0x4ce83e in run_builtin git.c:475:11
    #4 0x4ccafe in handle_builtin git.c:729:3
    #5 0x4cb01c in run_argv git.c:818:4
    #6 0x4cb01c in cmd_main git.c:949:19
    #7 0x6bd9ad in main common-main.c:52:11
    #8 0x7fbfeffc4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 65 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa8c015 in xrealloc wrapper.c:126:8
    #2 0xa00226 in strbuf_grow strbuf.c:98:2
    #3 0xa00226 in strbuf_vaddf strbuf.c:394:3
    #4 0xa065c7 in xstrvfmt strbuf.c:981:2
    #5 0xa065c7 in xstrfmt strbuf.c:991:8
    #6 0x9e7ce7 in prefix_path_gently setup.c:115:15
    #7 0x9e7fa6 in prefix_path setup.c:128:12
    #8 0x5dbdbf in internal_prefix_pathspec builtin/mv.c:55:23
    #9 0x5da575 in cmd_mv builtin/mv.c:158:14
    #10 0x4ce83e in run_builtin git.c:475:11
    #11 0x4ccafe in handle_builtin git.c:729:3
    #12 0x4cb01c in run_argv git.c:818:4
    #13 0x4cb01c in cmd_main git.c:949:19
    #14 0x6bd9ad in main common-main.c:52:11
    #15 0x7fbfeffc4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 65 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa8c015 in xrealloc wrapper.c:126:8
    #2 0xa00226 in strbuf_grow strbuf.c:98:2
    #3 0xa00226 in strbuf_vaddf strbuf.c:394:3
    #4 0xa065c7 in xstrvfmt strbuf.c:981:2
    #5 0xa065c7 in xstrfmt strbuf.c:991:8
    #6 0x9e7ce7 in prefix_path_gently setup.c:115:15
    #7 0x9e7fa6 in prefix_path setup.c:128:12
    #8 0x5dbdbf in internal_prefix_pathspec builtin/mv.c:55:23
    #9 0x5da4e4 in cmd_mv builtin/mv.c:148:11
    #10 0x4ce83e in run_builtin git.c:475:11
    #11 0x4ccafe in handle_builtin git.c:729:3
    #12 0x4cb01c in run_argv git.c:818:4
    #13 0x4cb01c in cmd_main git.c:949:19
    #14 0x6bd9ad in main common-main.c:52:11
    #15 0x7fbfeffc4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 558 byte(s) leaked in 7 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/mv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 3fccdcb645..c2f96c8e89 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -303,5 +303,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
 
+	string_list_clear(&src_for_dst, 0);
+	UNLEAK(source);
+	UNLEAK(dest_path);
+	free(submodule_gitfile);
+	free(modes);
 	return 0;
 }
-- 
2.26.2

