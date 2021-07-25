Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1362AC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8A560F11
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhGYM3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:29:23 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:38640 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhGYM25 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 267E740F59;
        Sun, 25 Jul 2021 15:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218533; x=1629032934;
         bh=YIY1dn33X2wJyIvL14v+OSYsLWLu5lOxPVe3xu+1evo=; b=0th43hfqFevs
        dPZYrxJLb6yhLj/Dt1YwnIt7LimBZMfilX8AHeeAv1l61/HoSAbyx9rSSYus+svh
        n67LeFXqB2XMfeZMr8FdY13a4nmcAlVD2C80abgH923NUDWY/sgGuC5n+CxS7Usf
        HlQ8bLEs3VuCM9Lz1ylNeegXBJNvsdg0RlVu+zAU5ilYg0sIuv6Su4lu9mRIpErL
        G2JewBZZo+C42TDzWI6WUi6ElVcU8y1cSVIQhuCUlVKb8nfIlCg6VyNuxJjNBybP
        Epe3EECe2uIv8wb/DvHuwnFfwaFpbfzMQ+oyOeEB/NKoqr3lRVmpWnufj9JOZtB3
        JSzDB3GleRwzF7RWxX1qpLkoWCMr15jXET/b5Ruuv8mU0Gy0CnMqFx4/LeGn5M9D
        5pvrF0L3wl6Hx0E/6BvEsbCJbRuu4RxQonvKJKlcxNRaz20cxAFzzBLSuXJgH3Lg
        MFj+Ikp03jpqnqpcfQxPAoUjvgsU900/UTGc/FZfP+xYbjBu4wwgJci2GQqtjhgi
        vNZEdKEL6qLZxJ0S0aWkHxZYa9WGMfZ8ouXYfh/Pcdsn1ifoEWS9z8dRMyTWlxTe
        46KtLn2UJiWw2Xc5OqJbDdL4ecbfpUMJ9utl2P1X8nr5JuWaCHtc2s01oo5pKX4U
        HR7xMlxs0G8bbpaEJ82ZdvM07mKiDPw=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YVF__5j1xdQt; Sun, 25 Jul 2021 15:08:53 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 7EE3B404BD;
        Sun, 25 Jul 2021 15:08:53 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 56AEE17C;
        Sun, 25 Jul 2021 15:08:51 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 08/12] convert: release strbuf to avoid leak
Date:   Sun, 25 Jul 2021 15:08:26 +0200
Message-Id: <20210725130830.5145-9-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
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

