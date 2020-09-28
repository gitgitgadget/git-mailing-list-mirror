Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E216FC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1FE2075A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IhrrASqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1SWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:22:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64633 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1SWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 14:22:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A500AEEFEC;
        Mon, 28 Sep 2020 14:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cB79xlADAW3/XKTlH8AuFSY8WuM=; b=IhrrAS
        qCqkF9RLky/UhiTPK5G9j0znmGTp2rsBYqdZ8XW4QWgNpp3AHIxNDarvkh5Mb9Ej
        R7g1eyxHA3+53Nu6wbiVCFhKOXvquK4RRfoy5OIpts/S36a13xnAV0VBC5jK0A8S
        1KqZVSYgzCzMFz9jtg0tY2aL48yi8ORGV5jvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=srIv4masOk8EU6L4tCB8svCuK1gMHxQT
        qztUYQzMUiRnfDKr5cTe8oP2EsAJCHxylKRJKaioxL/tjZoy3MOQu51srdI9FGqr
        eiSumFsdXIX6M2+Ex6Xnz5fGlkqbVPXTxTvuwuttB3B0gfbHrjWCbZD06/uWGKQg
        nzRJN+FAkZg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B7C3EEFEB;
        Mon, 28 Sep 2020 14:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2D72EEFE9;
        Mon, 28 Sep 2020 14:22:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com
Subject: Re: [PATCH 2/2] packfile: fix memory leak in add_delta_base_cache()
References: <cover.1601311803.git.matheus.bernardino@usp.br>
        <5b6e3019e08c6bccdee29018e99b0c6933fe05e0.1601311803.git.matheus.bernardino@usp.br>
Date:   Mon, 28 Sep 2020 11:22:43 -0700
In-Reply-To: <5b6e3019e08c6bccdee29018e99b0c6933fe05e0.1601311803.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Mon, 28 Sep 2020 13:50:35 -0300")
Message-ID: <xmqqlfgtn4lo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A879BF6-01B7-11EB-893B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> When add_delta_base_cache() is called with a base that is already in the
> cache, no operation is performed. But the check is done after allocating
> space for a new entry, so we end up leaking memory on the early return.

Wow, that's so obvious a leak that it is surprising it has been
unnoticed, especially given that the runtime inflation of the
packfile was written so long time ago and was a central part of the
system.

I had to dig and find out that the breakage was fairly recent from
early this year, made in 31877c9a (object-store: allow threaded
access to object reading, 2020-01-15).

> Also, the caller always expect that the base will be inserted, so it
> never free()'s it. To fix both of these memory leaks, let's move the
> allocation of a new entry further down in add_delta_base_cache(), and
> make the function return an integer to indicate whether the insertion
> was performed or not. Then, make the caller free() the base when needed.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

> @@ -1841,8 +1843,10 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>  		 * thread could free() it (e.g. to make space for another entry)
>  		 * before we are done using it.
>  		 */
> -		if (!external_base)
> -			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
> +		if (!external_base && !add_delta_base_cache(p, base_obj_offset,
> +						base, base_size, type)) {
> +			free(base);
> +		}

When you have to wrap a long expression, try to split after an
operator near the root of the parse tree, e.g.

		if (!external_base &&
		    !add_delta_base_cache(p, base_obj_offset, base, base_size, type)) {

would make the result easier to follow.

I however suspect that it may be better let add_delta_base_cache()
do the freeing.  There is only one caller, and from its point of
view, the timing when it throws the base at the cache (after the
previous patch) is when it is done with it.

In other words we can think of the call to add_delta_base_cache() as
the caller saying: "I am done with this, but somebody else might
want to reuse it later, so do whatever you want to do with it".  

If we were to go that route, it might even make sense to rename it
to reflect that mentality from the viewpoint of the caller, but a
single-caller helper like this one it may not matter all that much.

Thanks.


