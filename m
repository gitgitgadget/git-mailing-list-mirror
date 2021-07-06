Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56091C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC9261C3B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhGFTll (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:41:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60936 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhGFTll (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:41:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CE5EC146E;
        Tue,  6 Jul 2021 15:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NpUz3hrbmHAMrw7Q+JAT0881m98rvsXPfB2DG6
        dquj0=; b=Mt7e+7WuSzITpXHLnSchYFvHci6TkD6ybs4BKrgTC5Wnr9X5n+KRjF
        UVnfUko85ST3lBHvbqVmsUQRRb1Sbd8rRmcpEKhWWp7DXJH6+4YwX8U6kJatRDSz
        FZeFXrpsKaqSXW+KBoa2WqU1lW6txOADFDdfhkPn6IYWEh8TYxfko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44F04C146D;
        Tue,  6 Jul 2021 15:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA89DC146C;
        Tue,  6 Jul 2021 15:39:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 4/6] refs: add failure_errno to refs_read_raw_ref()
 signature
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
        <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <9c933706cb09265b62213b29f4a632c8a4445de1.1625597757.git.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 12:39:01 -0700
In-Reply-To: <9c933706cb09265b62213b29f4a632c8a4445de1.1625597757.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 06 Jul 2021
        18:55:55 +0000")
Message-ID: <xmqqbl7fjkq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0BA6728-DE91-11EB-B255-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -int refs_read_raw_ref(struct ref_store *ref_store,
> -		      const char *refname, struct object_id *oid,
> -		      struct strbuf *referent, unsigned int *type)
> +int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
> +		      struct object_id *oid, struct strbuf *referent,
> +		      unsigned int *type, int *failure_errno)
>  {
> -	int result;
> -	int failure_errno;
> +	int ignore;
> +	if (failure_errno)
> +		*failure_errno = 0;
> +	else
> +		failure_errno = &ignore;
> +

Same comment as v3(v5).  Squashable fix-up follows.

diff --git a/refs.c b/refs.c
index eca7310e7a..aaea9b34c6 100644
--- a/refs.c
+++ b/refs.c
@@ -1677,11 +1677,11 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno)
 {
-	int ignore;
-	if (failure_errno)
-		*failure_errno = 0;
-	else
-		failure_errno = &ignore;
+	int unused_errno;
+
+	if (!failure_errno)
+		failure_errno = &unused_errno;
+	*failure_errno = 0;
 
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
