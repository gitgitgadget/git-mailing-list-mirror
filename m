Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93445C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiBYGqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiBYGqi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 01:46:38 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051C2757AE
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 22:46:06 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37B4217984C;
        Fri, 25 Feb 2022 01:46:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZpmOM3P8G3ypcz6JOIUU+hYs2qU0Qu2MJxdiIW
        Q6Ha0=; b=Ek+usujPUFgzlJ6HV7PkRSrz/CiyQFejOs3V7c9Gmeg8vudHUOh9G5
        34Bt7lCzsrJ7RORLtprlobg+aAPX+DiMbPxbGOYzmRov0U+JxY7P88bmxLSZZ//A
        CUUBBXOWyuXkzmHk6J6hIB0rmWg7wynPkLUYQrfgobschC0bmuOQA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EA8F17984B;
        Fri, 25 Feb 2022 01:46:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A60B179849;
        Fri, 25 Feb 2022 01:46:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 2/8] fetch-pack: add repairing
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <2d817a65db55750d27986c2e2ab5b1723d17081e.1645719218.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:46:01 -0800
In-Reply-To: <2d817a65db55750d27986c2e2ab5b1723d17081e.1645719218.git.gitgitgadget@gmail.com>
        (Robert Coup via GitGitGadget's message of "Thu, 24 Feb 2022 16:13:32
        +0000")
Message-ID: <xmqqwnhjfnpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 990A7278-9606-11EC-B773-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -694,6 +696,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  
>  	save_commit_buffer = 0;
>  
> +	if (args->repair)
> +		return;
> +

Reading how the original value of save_commit_buffer is saved away,
the variable gets cleared and then gets restored before the function
returns in the normal codepath, this new code looks wrong.  Hitting
this early return after clearing the variable means nobody will
restore the saved value of the variable, no?

> @@ -1027,9 +1032,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	struct fetch_negotiator negotiator_alloc;
>  	struct fetch_negotiator *negotiator;
>  
> -	negotiator = &negotiator_alloc;
> -	fetch_negotiator_init(r, negotiator);

I know why you want to force the "noop" negotiator while repairing,
but it is unclear why you need to move this down in the function.

>  	sort_ref_list(&ref, ref_compare_name);
>  	QSORT(sought, nr_sought, cmp_ref_by_name);
>  
> @@ -1119,9 +1121,16 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	if (!server_supports_hash(the_hash_algo->name, NULL))
>  		die(_("Server does not support this repository's object format"));
>  
> +	negotiator = &negotiator_alloc;
> +	if (args->repair) {
> +		fetch_negotiator_init_noop(negotiator);
> +	} else {
> +		fetch_negotiator_init(r, negotiator);
> +	}

Hmph.  I am debating myself if hardcoding the implementation detail
of "when repairing, the noop negitiator is the only useful one" like
this code does is a sensible thing to do.  If we later need to tweak
the choice of negotiator used depending on the caller's needs,
perhaps fetch_negotiator_init() should gain a new flags word, i.e.

	fetch_negotiator_init(struct repository *,
			      struct fetch_negotiator *,
			      unsigned flags)

where "Use negotiator suitable for the repairing fetch" could be a
single bit in the flags word, making this caller more like:

	negotiator = &negotiator_alloc;
	flags = 0;
	if (args->repair)
		flags |= FETCH_NEGOTIATOR_REPAIRING;
	fetch_negotiator_init(r, negotiator, flags);

perhaps.  That way, [1/8] becomes unnecessary.

>  	mark_complete_and_common_ref(negotiator, args, &ref);
>  	filter_refs(args, &ref, sought, nr_sought);
> -	if (everything_local(args, &ref)) {
> +	if (!args->repair && everything_local(args, &ref)) {
>  		packet_flush(fd[1]);
>  		goto all_done;
>  	}
> @@ -1587,7 +1596,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct strvec index_pack_args = STRVEC_INIT;
>  
>  	negotiator = &negotiator_alloc;
> -	fetch_negotiator_init(r, negotiator);
> +	if (args->repair)
> +		fetch_negotiator_init_noop(negotiator);
> +	else
> +		fetch_negotiator_init(r, negotiator);

Likewise.

>  	packet_reader_init(&reader, fd[0], NULL, 0,
>  			   PACKET_READ_CHOMP_NEWLINE |
> @@ -1613,7 +1625,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			mark_complete_and_common_ref(negotiator, args, &ref);
>  			filter_refs(args, &ref, sought, nr_sought);
> -			if (everything_local(args, &ref))
> +			if (!args->repair && everything_local(args, &ref))
>  				state = FETCH_DONE;
>  			else
>  				state = FETCH_SEND_REQUEST;
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 7f94a2a5831..bbb663edda8 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -42,6 +42,7 @@ struct fetch_pack_args {
>  	unsigned update_shallow:1;
>  	unsigned reject_shallow_remote:1;
>  	unsigned deepen:1;
> +	unsigned repair:1;
>  
>  	/*
>  	 * Indicate that the remote of this request is a promisor remote. The
