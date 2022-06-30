Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8367CC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiF3ScL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiF3ScK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:32:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550742A18
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:32:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7F3612EA56;
        Thu, 30 Jun 2022 14:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Os5bZGIrC5mNfwooO30Q4R2ZBO9YLVS1tlERve
        ao/gY=; b=MneASzjNjINQp+nmN93QVGhukUSxjet7BsDkQbeKXFobib75a26wbt
        LzxkFx0mIBFI5lnkRngyE3RV6oSzyt0FxZgNdAivwway6E+TJ0pqEy/yKfAoZxuZ
        3/Zxcg1b/HDlRvOgl4OQSPZ+7PIyYuZIpOiC8/5cAdhSkFDUqwiGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 638F012EA55;
        Thu, 30 Jun 2022 14:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87B0812EA54;
        Thu, 30 Jun 2022 14:32:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
        <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 11:32:05 -0700
In-Reply-To: <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 29 Jun 2022 15:25:34
        +0000")
Message-ID: <xmqqtu82dmu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2559962-F8A2-11EC-9920-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * Ensure array p can accommodate at least nr elements, growing the
> + * array and updating alloc (which is the number of allocated
> + * elements) as necessary. Frees p and returns -1 on failure, returns
> + * 0 on success
> + */
> +#define XDL_ALLOC_GROW(p, nr, alloc)	\
> +	(-!((nr) <= (alloc) ||		\
> +	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
> + ...
> +
> +void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
> +{
> +	void *tmp = NULL;
> +	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;

Not counting in size_t but in long?

I assume that 16 mimics the ALLOW_GROW(), but ALLOW_GROW() grows by
1.5, not by 2, so these two are not exactly compatible.

The computation of 'n' tries to avoid arithmetic in "long"
overflowing, but does it ensure that we actually grow if we truncate
at LONG_MAX?  After *alloc grew to LONG_MAX by calling this helper
once, if we need to grow again and call this helper, 'n' will again
get LONG_MAX and we end up not growing at all, no?

> +	if (nr > n)
> +		n = nr;
> +	if (SIZE_MAX / size >= n)
> +		tmp = xdl_realloc(p, n * size);
> +	if (tmp) {
> +		*alloc = n;
> +	} else {
> +		xdl_free(p);
> +		*alloc = 0;
> +	}
> +	return tmp;
> +}


