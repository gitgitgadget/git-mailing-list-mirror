Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F46C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C04610C8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJ1Vy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 17:54:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62892 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhJ1VyY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 17:54:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED405F4984;
        Thu, 28 Oct 2021 17:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lh5cHP8RTVkwWmFG9Lt5U40PGa1cdOyb4AD8iI
        FzHiU=; b=wEXkjclTt16QHG/ml6oEvs6GIlIZm0yst61VHRKWfQr+QftZL0mBQb
        GeJYOSEK51YKi1yDzQn/DJ6eQc8koAZmuFGrYWfJBuU5JnyyJQzH1pE2kZiGJKQi
        Z7Nl7yQ5J3tTng/GFF86qezuvAYXcmJH5Pqu8jSyG10WyOY8jzbG8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4DCBF4983;
        Thu, 28 Oct 2021 17:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BF43F4982;
        Thu, 28 Oct 2021 17:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 03/15] diff --color-moved: factor out function
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <658aec2670c78f9753a5acccab20d3a1741403e6.1635336262.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 14:51:55 -0700
In-Reply-To: <658aec2670c78f9753a5acccab20d3a1741403e6.1635336262.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 27 Oct 2021 12:04:10
        +0000")
Message-ID: <xmqqmtmsq0lg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44FCB7A2-3839-11EC-AC1B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This code is quite heavily indented and having it in its own function
> simplifies an upcoming change.

And this should show as "moved" lines correctly in the output from
"log -p --color-moved -w"?

... not really.  There is an unfortunate artificial line wrapping in
the original, which was unwrapped by this move, so the blocks do not
exactly match.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index bd8e4ec9757..09af94e018c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1098,6 +1098,38 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
>  	return rp + 1;
>  }
>  
> +static void fill_potential_moved_blocks(struct diff_options *o,
> +					struct hashmap *hm,
> +					struct moved_entry *match,
> +					struct emitted_diff_symbol *l,
> +					struct moved_block **pmb_p,
> +					int *pmb_alloc_p, int *pmb_nr_p)
> +
> +{
> +	struct moved_block *pmb = *pmb_p;
> +	int pmb_alloc = *pmb_alloc_p, pmb_nr = *pmb_nr_p;
> +
> +	/*
> +	 * The current line is the start of a new block.
> +	 * Setup the set of potential blocks.
> +	 */
> +	hashmap_for_each_entry_from(hm, match, ent) {
> +		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
> +		if (o->color_moved_ws_handling &
> +		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
> +			if (compute_ws_delta(l, match->es, &(pmb[pmb_nr]).wsd))
> +				pmb[pmb_nr++].match = match;
> +		} else {
> +			pmb[pmb_nr].wsd = 0;
> +			pmb[pmb_nr++].match = match;
> +		}
> +	}
> +
> +	*pmb_p = pmb;
> +	*pmb_alloc_p = pmb_alloc;
> +	*pmb_nr_p = pmb_nr;
> +}
> +
>  /*
>   * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
>   *
> @@ -1198,23 +1230,8 @@ static void mark_color_as_moved(struct diff_options *o,
>  		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
>  
>  		if (pmb_nr == 0) {
> -			/*
> -			 * The current line is the start of a new block.
> -			 * Setup the set of potential blocks.
> -			 */
> -			hashmap_for_each_entry_from(hm, match, ent) {
> -				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
> -				if (o->color_moved_ws_handling &
> -				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
> -					if (compute_ws_delta(l, match->es,
> -							     &pmb[pmb_nr].wsd))
> -						pmb[pmb_nr++].match = match;
> -				} else {
> -					pmb[pmb_nr].wsd = 0;
> -					pmb[pmb_nr++].match = match;
> -				}
> -			}
> -
> +			fill_potential_moved_blocks(
> +				o, hm, match, l, &pmb, &pmb_alloc, &pmb_nr);
>  			if (adjust_last_block(o, n, block_length) &&
>  			    pmb_nr && last_symbol != l->s)
>  				flipped_block = (flipped_block + 1) % 2;
