Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8A51F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfJCWoL (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:44:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51742 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbfJCWoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:44:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 993E6261A2;
        Thu,  3 Oct 2019 18:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lf3VeLnVRvmcqTBCzfCu1F6qdK0=; b=r4quwR
        5ZJMz9j1U3qWMAQYZN3zPzCl6Hi6EIowKtmTxEn/FSeRYO847UlhZPQ802doXejB
        5iP9i7IhSExu6oCgqw1CSQDdAt16gTj/YLRT9b9S03ZOc3U59gUi8ezNiR6met43
        K+p/B0amFxmB9iGW3GZ76Kz6ySMKzNYMuEXDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Om5jWWtOlba9wNgoLkVHI6QBsa6eE7YJ
        IoWpCH0mqWj6dq1N0OkIcye+/AJkaIc78M6O7iKVBDdnvkRo8bDGLT+rVgu4/Pu5
        D3eNkPyPReMr0GvgDpgPlZUGQXi1r/yZuVOBPXI3DYj51Lhbvm//pR+J3K4mWK/2
        mfA+hcXqTb4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 884D8261A1;
        Thu,  3 Oct 2019 18:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBBC3261A0;
        Thu,  3 Oct 2019 18:44:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned types
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
        <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Oct 2019 07:44:03 +0900
In-Reply-To: <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 30 Sep 2019
        02:55:31 -0700 (PDT)")
Message-ID: <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D657F04-E62F-11E9-B2FF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> While at it, we take care of reporting overflows (which are unlikely,
> but hey, defensive programming is good!).
>
> We _also_ take pains of casting the unsigned value to signed: otherwise,
> the signed operand (i.e. the `-1`) would be cast to unsigned before
> doing the arithmetic.

These three look good and too similar to each other, which makes me
wonder if we want to allow them simply write

	return insert_pos_as_negative_offset(nr);

with something like

	static int insert_pos_as_negative_offset(uintmax_t nr)
	{
		if (INT_MAX < nr)
			die("overflow: -1 - %"PRIuMAX, nr);
		return -1 - (int)nr;
	}

to avoid repetition.

> Helped-by: Denton Liu <liu.denton@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  read-cache.c  |  9 ++++++---
>  sha1-lookup.c | 12 +++++++++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index c701f7f8b8..97745c2a31 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1275,8 +1275,11 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>  	 * we can avoid searching for it.
>  	 */
>  	if (istate->cache_nr > 0 &&
> -		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
> -		pos = -istate->cache_nr - 1;
> +		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0) {
> +		if (istate->cache_nr > INT_MAX)
> +			die("overflow: -1 - %u", istate->cache_nr);
> +		pos = -1 - (int)istate->cache_nr;
> +	}
>  	else
>  		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
>  
> @@ -1894,7 +1897,7 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>  	/*
>  	 * Account for potential alignment differences.
>  	 */
> -	per_entry += align_padding_size(sizeof(struct cache_entry), -sizeof(struct ondisk_cache_entry));
> +	per_entry += align_padding_size(per_entry, 0);
>  	return ondisk_size + entries * per_entry;
>  }
>  
> diff --git a/sha1-lookup.c b/sha1-lookup.c
> index 796ab68da8..bb786b5420 100644
> --- a/sha1-lookup.c
> +++ b/sha1-lookup.c
> @@ -69,8 +69,12 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
>  			miv = take2(sha1 + ofs);
>  			if (miv < lov)
>  				return -1;
> -			if (hiv < miv)
> -				return -1 - nr;
> +			if (hiv < miv) {
> +				if (nr > INT_MAX)
> +					die("overflow: -1 - %"PRIuMAX,
> +					    (uintmax_t)nr);
> +				return -1 - (int)nr;
> +			}
>  			if (lov != hiv) {
>  				/*
>  				 * At this point miv could be equal
> @@ -97,7 +101,9 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
>  			lo = mi + 1;
>  		mi = lo + (hi - lo) / 2;
>  	} while (lo < hi);
> -	return -lo-1;
> +	if (nr > INT_MAX)
> +		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
> +	return -1 - (int)lo;
>  }
>  
>  int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
