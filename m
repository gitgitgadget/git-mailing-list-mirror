Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E35C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DD76194E
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhGFTbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:31:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50780 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFTbV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:31:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0084D1994;
        Tue,  6 Jul 2021 15:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nuVLsqTSffylo2R+pEAafCaAbE8viS8BaZMiDZ
        GhTq0=; b=XdA9bQfh73VO5xgZWZxj143tQZmrXwMXRwMIRPtAp5zJTzmpCoVJvk
        jObzltBE5VW/RxNmL01KT5uKclfxijw3ucCMzn0q7uj2of4BLX1WrD3Z6+29CVZn
        aSGEzOnk3PWbSJba8+fbEh9poFa6dr+iG0nw5HNETSrovZ5E9OHAQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7235D1993;
        Tue,  6 Jul 2021 15:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70635D1992;
        Tue,  6 Jul 2021 15:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 4/5] refs: add failure_errno to refs_read_raw_ref()
 signature
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
        <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
        <4aaa9d3bd6f01b83932b25a9ba18ec9c1106405a.1625518566.git.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 12:28:40 -0700
In-Reply-To: <4aaa9d3bd6f01b83932b25a9ba18ec9c1106405a.1625518566.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 05 Jul 2021
        20:56:04 +0000")
Message-ID: <xmqqk0m3jl7b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EF63168-DE90-11EB-A109-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	int result;
> -	int failure_errno;
> +	int ignore;
> +	if (failure_errno)
> +		*failure_errno = 0;
> +	else
> +		failure_errno = &ignore;

Hmph, I would have expected that a piece of code that gives fallback
location for ignored return parameter to initialize the location the
same way, i.e.

	int ignore

	if (!failure_errno)
		failure_errno = &ignore
	*failure_errno = 0;

That way, the code that follows that takes failure_errno does not
have to care if that return parameter location was supplied by the
caller or given by the fallback logic.

> +const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
> +					       const char *refname,
> +					       int resolve_flags,
> +					       struct object_id *oid,
> +					       int *flags, int *failure_errno)
>  {
>  	static struct strbuf sb_refname = STRBUF_INIT;
>  	struct object_id unused_oid;
>  	int unused_flags;
> +	int unused_errno;
>  	int symref_count;
>  
>  	if (!oid)
> @@ -1707,6 +1708,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  		flags = &unused_flags;
>  
>  	*flags = 0;
> +	if (!failure_errno)
> +		failure_errno = &unused_errno;
> +	*failure_errno = 0;

And you do use that pattern correctly here.  We probably would want
to be consistent.
