Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F16C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiGKV1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKV1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 17:27:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172C6326CC
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:27:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 597E7135F65;
        Mon, 11 Jul 2022 17:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4+VGdnwXLIKyfCTf2jvsKMdaUh/RkUS2at1vHK
        lpP4M=; b=T7yxftXah65V6qgsQ2wp0WnpyGNUkU5A8XgKSIufYqnGmF8T9jAlzf
        J4K5jLJ2b5hfZmtq2mdO5ES36poQz/Mtiii+9UOkunvTgui0FlmwrR3EBmOxsM50
        ueDrL3x//Ac8raEXM6lKtdkP2xByZ8HYk/DqJcxvrXDrsD4FcOHL8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CBF9135F63;
        Mon, 11 Jul 2022 17:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7631A135F62;
        Mon, 11 Jul 2022 17:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] ref-filter: disable save_commit_buffer while traversing
References: <Ysw4JtoHW1vWmqhz@coredump.intra.peff.net>
Date:   Mon, 11 Jul 2022 14:27:06 -0700
In-Reply-To: <Ysw4JtoHW1vWmqhz@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 11 Jul 2022 10:48:06 -0400")
Message-ID: <xmqqilo3mjbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37530BEC-0160-11ED-AB9F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - Note that all of this assumes you don't have a commit-graph file. if
>     you do, then the heap usage is even lower, and the runtime is 10x
>     faster. So in that sense this is not urgent, as there's a much
>     better solution. But since it's such an obvious and easy win for
>     fallback cases (including commits which aren't yet in the graph
>     file), there's no reason not to.

Sounds sensible.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just pulling this out of the discussion in:
>
>   https://lore.kernel.org/git/YswuaPx6Mk7YkIim@coredump.intra.peff.net/
>
> as it's an easy win.
>
> I doubt that anyone even cares about restoring the value of
> save_commit_buffer. So this _could_ be a one-liner turning it off,
> rather than doing the save/restore dance. I was mostly erring on the
> conservative side, but maybe fewer lines of code is a worthwhile thing.
>
>  ref-filter.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index d3c90e5dbe..bdf39fa761 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2405,13 +2405,17 @@ static void reach_filter(struct ref_array *array,
>  int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
>  {
>  	struct ref_filter_cbdata ref_cbdata;
> +	int save_commit_buffer_orig;
>  	int ret = 0;
>  
>  	ref_cbdata.array = array;
>  	ref_cbdata.filter = filter;
>  
>  	filter->kind = type & FILTER_REFS_KIND_MASK;
>  
> +	save_commit_buffer_orig = save_commit_buffer;
> +	save_commit_buffer = 0;
> +
>  	init_contains_cache(&ref_cbdata.contains_cache);
>  	init_contains_cache(&ref_cbdata.no_contains_cache);
>  
> @@ -2444,6 +2448,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>  	reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
>  	reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);
>  
> +	save_commit_buffer = save_commit_buffer_orig;
>  	return ret;
>  }
