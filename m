Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C267C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2062520708
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ODN/Idhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgHNEiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:38:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50588 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNEiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 00:38:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EA817A734;
        Fri, 14 Aug 2020 00:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cTaVMz79lyS5NX3XQmFugTRyxpc=; b=ODN/Id
        hc6NvA/w1t3F6A4+7bkDjevyfJAu7+mJE4V4COhQrM/38dgMTz1ERbaie8wSv/Ww
        1oHAvX0fN1byGWtchfcz9M1CvxoDUgDMwa/HK0pq9vzp6unYqM6EaVlL3gSPNRzU
        VYz+dFPGxvXcfdPqjsldxwsketfg+HI7VSOwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q0IAA7fTaeA9DNAMNkkAmjoWmXxZIB8p
        QUC2W/Npp8V7XenuILnqtCfG6ZkyvddVI9z2dAsbQxLABBKXyAB3CDLf5yCKU134
        3IN2xxJqP6nd18oQtZ1OzDkM9I7II9EBhMdFcW35aRy4WdwucxpuHJY44oIn4EG6
        J6RtJsBVAC4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4578B7A733;
        Fri, 14 Aug 2020 00:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA1857A732;
        Fri, 14 Aug 2020 00:38:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] mem-pool: use more standard initialization and finalization
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
        <f13a52055cd975d457e0593cbabb70897e78024b.1597374135.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Aug 2020 21:38:04 -0700
In-Reply-To: <f13a52055cd975d457e0593cbabb70897e78024b.1597374135.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 14 Aug 2020
        03:02:14 +0000")
Message-ID: <xmqqpn7tzvtf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F18B077E-DDE7-11EA-9F48-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> written.  mem_pool_init() does essentially the following (simplified
> for purposes of explanation here):
>
>     void mem_pool_init(struct mem_pool **pool...)
>     {
>         *pool = xcalloc(1, sizeof(*pool));
>
> It seems weird to require that mem_pools can only be accessed through a
> pointer.

Yup, if the _init() were to also allocate, I would expect it to be
more like

	struct mem_pool *mem_pool_create(...)
	{
		struct mem_pool *pool = xcalloc(1, sizeof(*pool));
		...
		return pool;
	}

It also is OK to let the caller pass uninitialized region of memory,
which is how we usually arrange _init() to work.  It seems that that
is the approach this patch takes.

> -void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
> +void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size)
>  {
> -	struct mem_pool *pool;
> -
> -	if (*mem_pool)
> -		return;
> -
> -	pool = xcalloc(1, sizeof(*pool));
> -
> -	pool->block_alloc = BLOCK_GROWTH_SIZE;
> +	mem_pool->mp_block = NULL;
> +	mem_pool->pool_alloc = 0;
> +	mem_pool->block_alloc = BLOCK_GROWTH_SIZE;
>  
>  	if (initial_size > 0)
> -		mem_pool_alloc_block(pool, initial_size, NULL);
> -
> -	*mem_pool = pool;
> +		mem_pool_alloc_block(mem_pool, initial_size, NULL);

It used to be that this function both knew and took control of all
the bits in *pool memory by using xcalloc().  Any field the function
assigned to of course got explicitly the value the function wanted
it to have, and all other fields were left to 0.

It may happen to be still the case (i.e. the assignments we see in
this function cover all the fields defined), but don't we need some
provision to make sure it will hold to be true in the future?

Starting it with "memset(pool, 0, sizeof(*pool)" would be one way.

You'd standardize to s/mem_pool/pool/ in [3/3]; shouldn't this be
written with pool to begin with, instead of reintroducing mem_pool
that is of different type from the original?

> -	if (!*pool_ptr)
> -		mem_pool_init(pool_ptr, 0);
> +	if (!*pool_ptr) {
> +		*pool_ptr = xmalloc(sizeof(**pool_ptr));
> +		mem_pool_init(*pool_ptr, 0);

This one gives an uninitialized chunk of memory to the _init(); an
example of the caller that the earlier comment may matter.

> +	istate->ce_mem_pool = xmalloc(sizeof(*istate->ce_mem_pool));
>  	if (istate->version == 4) {
> -		mem_pool_init(&istate->ce_mem_pool,
> +		mem_pool_init(istate->ce_mem_pool,
>  				estimate_cache_size_from_compressed(istate->cache_nr));
>  	} else {
> -		mem_pool_init(&istate->ce_mem_pool,
> +		mem_pool_init(istate->ce_mem_pool,
>  				estimate_cache_size(mmap_size, istate->cache_nr));
>  	}

Likewise.

Thanks.
