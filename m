Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FEDC433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 22:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiEBXCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiEBXCK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 19:02:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E6E28993
        for <git@vger.kernel.org>; Mon,  2 May 2022 15:58:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 267A21097DF;
        Mon,  2 May 2022 18:58:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=23aoe2tWJmWEZhySpYdqQ+YAy0b4cTCG5bv6es
        /RMME=; b=AJ2V9ZeOdqQqUg4ZBTpGWU955BJvYTqf/h12gMvkOqU2eF1B1tVNo4
        bJGy+4wSDjBSMSWkSEwWhElYO/LOLgKRLiqVlTIITw8EP//Zuh6U23//Upzh8Bpj
        ZK34KkIkL3NUsJ4dW0+XPcnYP5vKMKx++vvXFIZ+a1BQdJSlPjHwU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D1E51097DE;
        Mon,  2 May 2022 18:58:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F3801097DD;
        Mon,  2 May 2022 18:58:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 2/8] fetch-pack: move fetch default settings
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-3-calvinwan@google.com>
Date:   Mon, 02 May 2022 15:58:30 -0700
In-Reply-To: <20220502170904.2770649-3-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 2 May 2022 17:08:58 +0000")
Message-ID: <xmqq8rrjv8x5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 632650FC-CA6B-11EC-8716-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> When the state machine in do_fetch_pack_v2() is in FETCH_CHECK_LOCAL, we
> set a few v2-specific defaults. It will be helpful for a future patch to
> have these defaults set if the initial state is not FETCH_CHECK_LOCAL.


> This is a safe change since the initial state is currently always
> FETCH_CHECK_LOCAL, so we're guaranteed to hit that code whether it's in
> the state machine or not.

What does "it" (which supposed to be able to be in the state machine
and also not to be in the state matchine) in the last sentence refer
to?

>
> ---

Missing sign-off.

The patch looks correct and I agree that this is a benign no-op
because the initial value of state is FETCH_CHECK_LOCAL (i.e. the
block of code moved here will execute pretty much as the first
thing, and the relative order between that block and sorting of ref
list should not matter).  I just didn't understand the explanation
given by the patch why it is safe.

Thanks.

>  fetch-pack.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index e06125c90a..45473b4602 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1610,18 +1610,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		reader.me = "fetch-pack";
>  	}
>  
> +	/* v2 supports these by default */
> +	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
> +	use_sideband = 2;
> +	if (args->depth > 0 || args->deepen_since || args->deepen_not)
> +		args->deepen = 1;
> +
>  	while (state != FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
>  			sort_ref_list(&ref, ref_compare_name);
>  			QSORT(sought, nr_sought, cmp_ref_by_name);
>  
> -			/* v2 supports these by default */
> -			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
> -			use_sideband = 2;
> -			if (args->depth > 0 || args->deepen_since || args->deepen_not)
> -				args->deepen = 1;
> -
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			mark_complete_and_common_ref(negotiator, args, &ref);
>  			filter_refs(args, &ref, sought, nr_sought);
