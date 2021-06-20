Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E127C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6769C6108E
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFTPPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:15:04 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:21566 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhFTPOj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 8821D411D8
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201945; x=1626016346;
         bh=YIY1dn33X2wJyIvL14v+OSYsLWLu5lOxPVe3xu+1evo=; b=q3dNV2ElRnWd
        egbAGqiBqD1eRnWONNcGu7Eo8K5a5swAZdHFTJGgysDWGt1UkFmop51gspX89lre
        7FGmBsU6eiwTmYjmJ1ZNwrUI4H9193s94K+2MMOVFFn4rBD1JCXUpNVRnv3hKYcr
        6sRPTsrnckWWdQWqNA4bxXYLHUR/OYMqbvUR2iYCR6LX0CyYZzknmSd0N7+e3mO6
        qNYBWIFiJDt8WgJLEaYdbTb1mAn67ucOIN8Sg2QsHQriP0+e38myItve+JXOIwTk
        n7UbfvAKrdwwOosb7Oc/BjvxI79t48NKbyPL/FkSY4gZ4xF5PMUUNvieN2dLSUkG
        d3eDNbX6MycOhMYhs9BSKH6MGpqh+yw1xXfV6hw+2bsua5kah9CwajlTqu3Z5LBu
        VCkQXwbglY2R8pliMwTV6eHmhPYkApOgrduJIa/ppGjEZziyaar4Zekxu6mDop2S
        ATfio2PcX1gSVaqKzVqhkW/lAq4Ppn9symNEUVKoieOP2QrU6rCUsyk+yzR6b4jP
        PnY3ScPL9mP+jua/uvJTTRLznQv29D8MgWMp9HPVxeoBCta3j7KmzrLcW/BVisg2
        vALlHd7Ubh7Q/LF6sPCqqB27XenCEx/tOk/ziaog68/uvjRtafpGpimKbXnRJQDT
        WC+4cJ5jfEpPMKySc/Mvd0pgDuxwLrs=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o1J6KvNisrol for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:25 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id DE593407B7
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:24 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id F2A8A80F;
        Sun, 20 Jun 2021 17:12:23 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 08/12] convert: release strbuf to avoid leak
Date:   Sun, 20 Jun 2021 17:12:00 +0200
Message-Id: <20210620151204.19260-9-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

apply_multi_file_filter and async_query_available_blobs both query
subprocess output using subprocess_read_status, which writes data into
the identically named filter_status strbuf. We add a strbuf_release to
avoid leaking their contents.

Leak output seen when running t0021 with LSAN:

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa8c2b5 in xrealloc wrapper.c:126:8
    #2 0x9ff99d in strbuf_grow strbuf.c:98:2
    #3 0x9ff99d in strbuf_addbuf strbuf.c:304:2
    #4 0xa101d6 in subprocess_read_status sub-process.c:45:5
    #5 0x77793c in apply_multi_file_filter convert.c:886:8
    #6 0x77793c in apply_filter convert.c:1042:10
    #7 0x77a0b5 in convert_to_git_filter_fd convert.c:1492:7
    #8 0x8b48cd in index_stream_convert_blob object-file.c:2156:2
    #9 0x8b48cd in index_fd object-file.c:2248:9
    #10 0x597411 in hash_fd builtin/hash-object.c:43:9
    #11 0x596be1 in hash_object builtin/hash-object.c:59:2
    #12 0x596be1 in cmd_hash_object builtin/hash-object.c:153:3
    #13 0x4ce83e in run_builtin git.c:475:11
    #14 0x4ccafe in handle_builtin git.c:729:3
    #15 0x4cb01c in run_argv git.c:818:4
    #16 0x4cb01c in cmd_main git.c:949:19
    #17 0x6bdc2d in main common-main.c:52:11
    #18 0x7f42acf79349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 24 byte(s) leaked in 1 allocation(s).

Direct leak of 120 byte(s) in 5 object(s) allocated from:
    #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xa8c295 in xrealloc wrapper.c:126:8
    #2 0x9ff97d in strbuf_grow strbuf.c:98:2
    #3 0x9ff97d in strbuf_addbuf strbuf.c:304:2
    #4 0xa101b6 in subprocess_read_status sub-process.c:45:5
    #5 0x775c73 in async_query_available_blobs convert.c:960:8
    #6 0x80029d in finish_delayed_checkout entry.c:183:9
    #7 0xa65d1e in check_updates unpack-trees.c:493:10
    #8 0xa5f469 in unpack_trees unpack-trees.c:1747:8
    #9 0x525971 in checkout builtin/clone.c:815:6
    #10 0x525971 in cmd_clone builtin/clone.c:1409:8
    #11 0x4ce83e in run_builtin git.c:475:11
    #12 0x4ccafe in handle_builtin git.c:729:3
    #13 0x4cb01c in run_argv git.c:818:4
    #14 0x4cb01c in cmd_main git.c:949:19
    #15 0x6bdc2d in main common-main.c:52:11
    #16 0x7fa253fce349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 120 byte(s) leaked in 5 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 convert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/convert.c b/convert.c
index fd9c84b025..0d6fb3410a 100644
--- a/convert.c
+++ b/convert.c
@@ -916,6 +916,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	else
 		strbuf_swap(dst, &nbuf);
 	strbuf_release(&nbuf);
+	strbuf_release(&filter_status);
 	return !err;
 }
 
@@ -966,6 +967,7 @@ int async_query_available_blobs(const char *cmd, struct string_list *available_p
 
 	if (err)
 		handle_filter_error(&filter_status, entry, 0);
+	strbuf_release(&filter_status);
 	return !err;
 }
 
-- 
2.26.2

