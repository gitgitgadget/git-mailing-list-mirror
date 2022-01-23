Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A710FC433EF
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 20:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiAWURV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 15:17:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60398 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiAWURU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 15:17:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4899016F24F;
        Sun, 23 Jan 2022 15:17:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pX4t8KbKSJHehKt+KEjnekDdaSBvw/xRLHBzYc
        xMiDw=; b=ReSTOf7QxZEStzqH3hGafPRQjcykIvtG0diy2nz+EqKP2qr7Ho/DSO
        9zKYIlGc0GyiChPgE6c6Jxbw2e9OMc2JLDUWsPDXNeI/n/lvqQ6KZ7k/wn3aAh1a
        y5i96ZML8wTVFR5xv6eVANbANEVowW5OjOOoiVE8EMGIOMseDBuyQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41B6916F24E;
        Sun, 23 Jan 2022 15:17:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B106D16F24D;
        Sun, 23 Jan 2022 15:17:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] mem-pool: Don't assume uintmax_t is aligned enough
 for all types
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
        <20220123152458.72540-1-jrtc27@jrtc27.com>
Date:   Sun, 23 Jan 2022 12:17:16 -0800
In-Reply-To: <20220123152458.72540-1-jrtc27@jrtc27.com> (Jessica Clarke's
        message of "Sun, 23 Jan 2022 15:24:58 +0000")
Message-ID: <xmqqsfte8awj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 763832D0-7C89-11EC-A25F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

> Currently mem_pool_alloc uses sizeof(uintmax_t) as a proxy for what
> should be _Alignof(max_align_t) in C11. On most architectures this is

Lose "Currently", as the present tense describes the status quo, the
shape of the problematic code we have today that wants improvement
by the proposed patch.

> sufficient (though on m68k it is in fact overly strict, since the
> de-facto ABI, which differs from the specified System V ABI, has the
> maximum alignment of all types as 2 bytes), but on CHERI, and thus Arm's
> Morello prototype, it is insufficient for any type that stores a
> pointer, which must be aligned to 128 bits (on 64-bit architectures
> extended with CHERI), whilst uintmax_t is a 64-bit integer.

OK.

> Fix this by introducing our own approximation for max_align_t and a
> means to compute _Alignof it without relying on C11. Currently this
> union only contains uintmax_t and void *, but more types can be added as
> needed.

Nicely described.

> +/*
> + * The inner union is an approximation for C11's max_align_t, and the
> + * struct + offsetof computes _Alignof. This can all just be replaced
> + * with _Alignof(max_align_t) if/when C11 is part of the baseline.
> + *
> + * Add more types to the union if the current set is insufficient.
> + */
> +struct git_max_alignment {
> +	char unalign;
> +	union {
> +		uintmax_t max_align_uintmax;
> +		void *max_align_pointer;
> +	} aligned;
> +};
> +#define GIT_MAX_ALIGNMENT offsetof(struct git_max_alignment, aligned)
> +

The original computed the alignment requirement for uintmax_t as
sizeof(uintmax_t), not as

	offsetof(struct {
		char unalign;
		union { uintmax_t i; } aligned;
	}, aligned)

because if you have an array of a type, each element of it must be
aligned appropriately already for that type, without the unalignment
the outer struct enforces.  I wonder if your complex offsetof is
equivalent to sizeof(union { uintmax_t u; void *p; })?

IOW, in this struct:

	struct max_alignment_helper {
		char unalign;
		union {
			uintmax_t uintmax_t_unused;
			void *pointer_unused;
		} u[2];
	} s;

both s.u[0] and s.u[1] must be properly aligned, so wouldn't the
alignment requirement for the union type, which can be used to hold
a single value of either uintmax_t or a poinhter, be the distance
between these two array elements, i.e. sizeof(s.u[0])?

To put it differently in yet another way, wouldn't it simplify down
to this?

	union max_alignment_helper {
		uintmax_t uintmax_t_unused;
                void *pointer_unused;
	};
	#define GIT_MAX_ALIGNMENT sizeof(union max_alignment_helper);

I am not saying that the "a forcibly unaligned union in a struct" is
a bad/wrong way to express what you want to achieve.  I just do not
know if there is a reason to choose it over a seemingly simpler
sizeof(that union) without the outer struct and unalign member.

Other than that, looks OK to me.  Especially the parts that use the
macro look correctly converted.

Thanks.

> @@ -69,9 +85,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
>  	struct mp_block *p = NULL;
>  	void *r;
>  
> -	/* round up to a 'uintmax_t' alignment */
> -	if (len & (sizeof(uintmax_t) - 1))
> -		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
> +	if (len & (GIT_MAX_ALIGNMENT - 1))
> +		len += GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
>  
>  	if (pool->mp_block &&
>  	    pool->mp_block->end - pool->mp_block->next_free >= len)


>  /*
>   * Allocate a new mp_block and insert it after the block specified in
>   * `insert_after`. If `insert_after` is NULL, then insert block at the
> @@ -69,9 +85,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
>  	struct mp_block *p = NULL;
>  	void *r;
>  
> -	/* round up to a 'uintmax_t' alignment */
> -	if (len & (sizeof(uintmax_t) - 1))
> -		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
> +	if (len & (GIT_MAX_ALIGNMENT - 1))
> +		len += GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
>  
>  	if (pool->mp_block &&
>  	    pool->mp_block->end - pool->mp_block->next_free >= len)
