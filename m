Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566A9C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CD760F11
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhGYM3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:29:14 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:26156 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhGYM24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 6B96312AF;
        Sun, 25 Jul 2021 15:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218531; x=1629032932;
         bh=A4jfMVoN5EZDxkwMeNoVN0kq2ZhI2EM9h6L6F87MdK0=; b=o4GarRYzNCx0
        tEG0Iw9M7uQXLuvGx1cgGPZZfpcD+1SlkLXojdhM6M9DkLth7bHbHTv5RDQSwgLc
        0GrTYjbEuF/d1ZJonzKD5X2VRDemoZ7toTNPt6KvFqbCUDVunUSxsA2DuXjP8MlJ
        EhRnp13duR8iRqqqn+Cwu+QL/v4BwBHbApNEEWeVe/FBuvM0Y4PS3P9nFcz0pFAn
        HSXr5rIK7MK5TCnO32JeQqpZICeON7tVxi0ES2lYN3E0Cjgd69e9LgiTKRWfHJdZ
        ECgxfxfrwAs0gG7XHgaAQfwblXQI5haWLbNI779NaM7ivSRZvZlt8UFfLcboUuWT
        2YNNYya+YnwEc7LXRN0tjrWHep857UMFTm+Jzj+fI1jqT18f0Pl+GcE0C4Cm0Y2/
        VaW4knmF7P8CHfEVCFMXYKdcvmIcGnYKHi/e3gk0rac9DyV67W5ik1nyfRyT6fJY
        G2KM3G4oBvV4sHVbYbjS62CW0kJ74TTIqyrd37waG7KNWRNRFlE577P1gBkY/14e
        /OMKSlOZIU6xq/VQlBNR/dgDBOhWFxyTwksi0AFKcSx+1I9UtdqqLIHxnKYEaELz
        d99XZfwVwvtTRljfweJo5cZQQHUJmMFsBIGjyKQwDBijOOCvmicAKuk5z+ZoxLVp
        ybP+iqijC+gm/IYh5yWPKdq6ySl90R8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OuZiXe8XszjL; Sun, 25 Jul 2021 15:08:51 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id D30B5702;
        Sun, 25 Jul 2021 15:08:50 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 4160A3B2A;
        Sun, 25 Jul 2021 15:08:49 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 07/12] read-cache: call diff_setup_done to avoid leak
Date:   Sun, 25 Jul 2021 15:08:25 +0200
Message-Id: <20210725130830.5145-8-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
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
index 46ccd66f34..83d1817ad0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2505,6 +2505,7 @@ int repo_index_has_changes(struct repository *repo,
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
+		diff_setup_done(&opt);
 		do_diff_cache(&cmp, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
-- 
2.26.2

