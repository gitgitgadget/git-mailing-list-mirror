Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC40C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FF42395C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbhANGds (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:33:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50952 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANGdr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 01:33:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E40A10A0B0;
        Thu, 14 Jan 2021 01:33:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=znjtLm7RTMBA1kQ4/BHAuYLsBDc=; b=Nrj5Lo
        jSzNAEyYl1wWplOD4paABGFGajr1o6jpihXMkvI8AqWm6wEDOdUChE7BVl/p8WsE
        Odgm4LN16uKLdSsif9vMRgv47SZqaH2GSPA/MjInQszlwPM27cK4/y/gQ8SEnPiP
        9ybBFXqzGtXvoQzR7cwG3wW1hSB4qsbVbJ0eY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IPTuwi6m9zwDxu+UH41Xcnoeby5ZdnV5
        AwOp3wpR1Y3j6NVlxXGCRuveQn4dFOXY7kYoCEojAcaVKOGNIbWLiadeouZWcTLA
        mrYNq/ne69wb8Bp9spTL7JyCaCq71M2zhx1UZrZ7kv4LXpGzfGp8LGVgux9DgTkS
        BmA17HLC2PI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4676810A0AF;
        Thu, 14 Jan 2021 01:33:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C8CD10A0AD;
        Thu, 14 Jan 2021 01:33:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 16/20] builtin/gc.c: guess the size of the revindex
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <a500311e33a2f7e11a539dd0718ed946f4bd6bc8.1610576604.git.me@ttaylorr.com>
Date:   Wed, 13 Jan 2021 22:33:01 -0800
In-Reply-To: <a500311e33a2f7e11a539dd0718ed946f4bd6bc8.1610576604.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 13 Jan 2021 17:24:54 -0500")
Message-ID: <xmqqwnwgyqn6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AC1B7FC-5632-11EB-959B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> 'estimate_repack_memory()' takes into account the amount of memory
> required to load the reverse index in memory by multiplying the assumed
> number of objects by the size of the 'revindex_entry' struct.
>
> Prepare for hiding the definition of 'struct revindex_entry' by removing
> a 'sizeof()' of that type from outside of pack-revindex.c. Instead,
> guess that one off_t and one uint32_t are required per object. Strictly
> speaking, this is a worse guess than asking for 'sizeof(struct
> revindex_entry)' directly, since the true size of this struct is 16
> bytes with padding on the end of the struct in order to align the offset
> field.

Meaning that we under-estimate by 25%?

> But, this is an approximation anyway, and it does remove a use of the
> 'struct revindex_entry' from outside of pack-revindex internals.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 4c24f41852..c60811f212 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -301,7 +301,7 @@ static uint64_t estimate_repack_memory(struct packed_git *pack)
>  	/* and then obj_hash[], underestimated in fact */
>  	heap += sizeof(struct object *) * nr_objects;
>  	/* revindex is used also */
> -	heap += sizeof(struct revindex_entry) * nr_objects;
> +	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
>  	/*
>  	 * read_sha1_file() (either at delta calculation phase, or
>  	 * writing phase) also fills up the delta base cache
