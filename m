Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34718C433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E510B23AC1
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbhAVTM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:12:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56737 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbhAVTL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:11:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E419A937C4;
        Fri, 22 Jan 2021 14:11:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rJK6r0W8DS2xQyiyUCt3VsH9rv0=; b=W8yhB+
        1ksCc9c5W88yYYcFpqliwsLNqpaC9a27P6X3hCVqoJZWm3AW9t+Bb4YysTCI+Gyh
        p0Ow+BjVB1ZPTBWN6zinrdMYDrmpLWGKCflve1X1nmswgsD4YUoP3I+DmFxsQ+fR
        4jjeu3JhaP37eq+3yWyiAWRk1jqCEO+hiV3RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KSNAXWvMl7iWLJGIa/iH4ETt1OvWyy05
        xFq/b4yGlbPbSiq36Aho1e+9zeAFiZpv8LwEf4bhHtTClwo9oxgZQed4YX+wS7mE
        /afLm2dTHe5X0ziLZxHi8OsPBFH0+q34gCpQkt1uNQirxtOt+rLbdOSHH5sENuma
        cCcZt7VgIBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9515937C3;
        Fri, 22 Jan 2021 14:11:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2619C937C2;
        Fri, 22 Jan 2021 14:11:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/8] cache-tree: clean up cache_tree_update()
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <f9dccaed0acae91b06f5f9ccaf0f9116b65f3f09.1611320639.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 11:11:12 -0800
In-Reply-To: <f9dccaed0acae91b06f5f9ccaf0f9116b65f3f09.1611320639.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 22 Jan 2021
        13:03:52 +0000")
Message-ID: <xmqqlfck948f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97F6B136-5CE5-11EB-A3A4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Make the method safer by allocating a cache_tree member for the given
> index_state if it is not already present. This is preferrable to a
> BUG() statement or returning with an error because future callers will
> want to populate an empty cache-tree using this method.

How do the current callers prepare the istate to be passed to this
function?  The implications of this question obviously are:

 - why is it unreasonable for future callers to follow suit?  or

 - now the callers are no longer responsible to give an empty
   cache_tree to istate before calling this function, shouldn't
   existing callers lose code that is no longer needed?

I would imagine that the first is easily answered with "but that
would be more code on the callers' side", but then the second one
becomes even more relevant, no?

> Also drop local variables that are used exactly once and can be found
> directly from the 'istate' parameter.

It actuall is used twice, no?

I do find it an improvement because it makes it clearer that
istate->{cache,cache_nr} comes in pairs.

I wonder if verify_cache() wants to take istate as a parameter,
replacing the first two?  update_one() shifts where it starts
working in the array and reduces the number of entries as it digs
deeper, so it still has to keep taking the (base, nr) pair (iow, its
second and third parameters cannot be replaced with an istate).

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 3f1a8d4f1b7..c1e49901c17 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -436,16 +436,20 @@ static int update_one(struct cache_tree *it,
>  
>  int cache_tree_update(struct index_state *istate, int flags)
>  {
> -	struct cache_tree *it = istate->cache_tree;
> -	struct cache_entry **cache = istate->cache;
> -	int entries = istate->cache_nr;
> -	int skip, i = verify_cache(cache, entries, flags);
> +	int skip, i;
> +
> +	i = verify_cache(istate->cache, istate->cache_nr, flags);
>  
>  	if (i)
>  		return i;
> +
> +	if (!istate->cache_tree)
> +		istate->cache_tree = cache_tree();
> +
>  	trace_performance_enter();
>  	trace2_region_enter("cache_tree", "update", the_repository);
> -	i = update_one(it, cache, entries, "", 0, &skip, flags);
> +	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> +		       "", 0, &skip, flags);
>  	trace2_region_leave("cache_tree", "update", the_repository);
>  	trace_performance_leave("cache_tree_update");
>  	if (i < 0)
