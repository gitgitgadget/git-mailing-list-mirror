Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37FAC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAEB6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFTPOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:43 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:21552 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhFTPOg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id AF4D34112C
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201941; x=1626016342;
         bh=PSGkEFO1THQYjwYuHdoRxHq2p5ZO/zKHc7cftucOtrw=; b=UlrYPFk51j1a
        9f1zSvTs6nITn4dOQ6MHy5MYATOEECHD1topdjjj9nH9gbkaAHwW1gJrWUmXor8Z
        J0vzkRFTtWL13zxmk7nNTpPglZtv30FnkI2XeJwFobdKnOEEQU9KgNjFTpJJnDN2
        XX6zselkaBceLv6KAOWKEOJsySZIkl2l2RipH4/759hJ62hLltcCeA5NPvCCrfh1
        BqmSfuxBPTx6eYibiL0tkFLzjMcwuJSRiF/hW0g6elkYFVSVx6iE99z0imEJuo8f
        djjioTtMW1czFLLNH8fwDHunmMgPnO5wSX3oApTepPJF/5omxmnQtRY05qLqY6wH
        So2xssmkGBFwQgRhC0erTLn4+6OxKkIxO19cqwxwxHBrw8OpbrJ/xoQvw6n3EmZ/
        5qZ3KD5RHeDmLUoOpfASCybPRV4ZCElVoGIsQysNvjoXbY8EhuYiz4+4kCBYGVxk
        nhckByL3QcHKjlonU8GHmkxo7MUcbvUnHrINQVopclIF4ds9EW3dDWJrebnG8Hhs
        xMiOT73iuPplshh+WgIH3le3dtYidA1vB2xAEHN73tc3iO02iEV21xJOjuP1C9AM
        DHK3OWk7fa5Mi69PAD2z/cZoMk1/rZQD4FebdmlWR/hocbxUHpfMLHklSnpXoPNM
        /jRtvHIPsPyC/rDQJJxcgeqGISCwtRA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cam4O9W98ux1 for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:21 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 21F25407B7
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:20 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id DACCA34B;
        Sun, 20 Jun 2021 17:12:19 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 06/12] ref-filter: also free head for ATOM_HEAD to avoid leak
Date:   Sun, 20 Jun 2021 17:11:58 +0200
Message-Id: <20210620151204.19260-7-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

u.head is populated using resolve_refdup(), which returns a newly
allocated string - hence we also need to free() it.

Found while running t0041 with LSAN:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xa8be98 in xstrdup wrapper.c:29:14
    #2 0x9481db in head_atom_parser ref-filter.c:549:17
    #3 0x9408c7 in parse_ref_filter_atom ref-filter.c:703:30
    #4 0x9400e3 in verify_ref_format ref-filter.c:974:8
    #5 0x4f9e8b in print_ref_list builtin/branch.c:439:6
    #6 0x4f9e8b in cmd_branch builtin/branch.c:757:3
    #7 0x4ce83e in run_builtin git.c:475:11
    #8 0x4ccafe in handle_builtin git.c:729:3
    #9 0x4cb01c in run_argv git.c:818:4
    #10 0x4cb01c in cmd_main git.c:949:19
    #11 0x6bdc2d in main common-main.c:52:11
    #12 0x7f96edf86349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 ref-filter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4..f8bfd25ae4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2225,8 +2225,12 @@ void ref_array_clear(struct ref_array *array)
 	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
 
-	for (i = 0; i < used_atom_cnt; i++)
-		free((char *)used_atom[i].name);
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
+		if (atom->atom_type == ATOM_HEAD)
+			free(atom->u.head);
+		free((char *)atom->name);
+	}
 	FREE_AND_NULL(used_atom);
 	used_atom_cnt = 0;
 
-- 
2.26.2

