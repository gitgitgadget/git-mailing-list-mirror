Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D52AC4320A
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0F860F39
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhGYM3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:29:13 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:12502 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhGYM2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 4B5BA12A9;
        Sun, 25 Jul 2021 15:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218529; x=1629032930;
         bh=cjFr4qStq4vm+X6P1fFqaTwl9jK85bEC+EcsER0/dgM=; b=WXy8/WO6XEfg
        RLVoP7SxBR7Czmi/IGrYM+vU0O5aKw3sBQTLSyGskva6C2aOlJLHa+vqimaH4sYm
        Fbh6xeJ0N1Dfa6B4nD1MIVmhVK5mRV5rZ7f28uIzbHZTSTRmJCj0FtzSZkafyenj
        e6pJkAfJ5qbCAOCYCd4yJd0opnprUM5FRndpks3eyeqJGdqqsf19oCLX56SOmz1A
        5kMoFWSsg/cAJq1hJ1V1ts+Ocxk60fYjdMD6c7htRV+upGoP/ghMAbMBfFGTy+GI
        Iq9SBmrmvOpnY0jRIOOkUlWbBP+kWigFXymqpAMsyvhoc8zBFy9GBHNvCjRPjNg+
        tx+HWxvoSAmv1SJtXo9QLZU8xmhbsquzdrYkZAkVUSKRfEP9AvubPm2TBTOM6T0W
        SQ5vRfeukgTifV11A1xAWLojaRjI4phZXgJkAGYTooMDq7IPDDIAZQPiA0JsUGAT
        uvNxxcwA9Prcg1UbEUUIdfH1eumdeFNYIE9i3xjn45JisU709TQtsTTxo1QgrPwD
        46FpTcFbUsk+UKk6aH4CQvhJ7yI3qPwzCIsaONowReXCtPEyPK2HDz1TtojPwAJS
        ZQ+SEMpXulfsGNpmNFLdvZj7qVls9vWqR97lKoHnghlUVge6nWmMbWT851B7aaEj
        i+elCsnDuobVIRXWQ8PkuhIe6OBxwdY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eXqGD1Hs9iyO; Sun, 25 Jul 2021 15:08:49 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id C3BE5BCD;
        Sun, 25 Jul 2021 15:08:49 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 8CB2C2469;
        Sun, 25 Jul 2021 15:08:47 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 06/12] ref-filter: also free head for ATOM_HEAD to avoid leak
Date:   Sun, 25 Jul 2021 15:08:24 +0200
Message-Id: <20210725130830.5145-7-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
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
index f45d3a1b26..0cfef7b719 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2226,8 +2226,12 @@ void ref_array_clear(struct ref_array *array)
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

