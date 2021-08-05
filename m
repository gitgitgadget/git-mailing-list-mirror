Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F5C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777856105A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhHESo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:44:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58759 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbhHESoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 14:44:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E269C140550;
        Thu,  5 Aug 2021 14:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FRpt63UZcBNbu5ILnMyVCHr6TnAUBCjE5o35ke
        96L0w=; b=io71oyLOchxRpYyCInWzyCpcbM6If4HWLsvCsjqWHzuhUB4Gd5b+Oi
        EERR25XUckgL36O7Bhh5Ydne8XAC5ndocDeEz05cOyhfcYshbgHG8i9CV89NB2i3
        scCk8yVrUM16ZFiFiCrcUUW0zDMzXkdXlEpqKBVzD6O8ft8WDgFw0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA71614054F;
        Thu,  5 Aug 2021 14:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 119AD14054C;
        Thu,  5 Aug 2021 14:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 2/6] connected: do not sort input revisions
References: <cover.1624858240.git.ps@pks.im> <cover.1628162156.git.ps@pks.im>
        <9d7f484907e2bd2492e6676238579e9f0c6ed374.1628162156.git.ps@pks.im>
Date:   Thu, 05 Aug 2021 11:44:05 -0700
In-Reply-To: <9d7f484907e2bd2492e6676238579e9f0c6ed374.1628162156.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 5 Aug 2021 13:25:28 +0200")
Message-ID: <xmqqfsvnloju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D4B49F2-F61D-11EB-8AE4-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +	} else if (!strcmp(arg, "--unsorted-input")) {
> +		if (revs->no_walk && !revs->unsorted_input)
> +			die(_("--unsorted-input is incompatible with --no-walk and --no-walk=sorted"));
> +		revs->unsorted_input = 1;

So this can be used with --no-walk=unsorted, even though doing
so would be redundant and meaningless.  OK.

> @@ -2651,6 +2655,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
>  	} else if (!strcmp(arg, "--not")) {
>  		*flags ^= UNINTERESTING | BOTTOM;
>  	} else if (!strcmp(arg, "--no-walk")) {
> +		if (revs->unsorted_input)
> +			die(_("--no-walk is incompatible with --no-walk=unsorted and --unsorted-input"));

And likewise, --no-walk is --no-walk=sorted so we do not allow it to
be used with --unsorted-input or --no=walk=unsorted.  OK.

>  		revs->no_walk = 1;
>  	} else if (skip_prefix(arg, "--no-walk=", &optarg)) {
>  		/*
> @@ -2658,9 +2664,12 @@ static int handle_revision_pseudo_opt(const char *submodule,
>  		 * not allowed, since the argument is optional.
>  		 */
>  		revs->no_walk = 1;
> -		if (!strcmp(optarg, "sorted"))
> +		if (!strcmp(optarg, "sorted")) {
> +			if (revs->unsorted_input)
> +				die(_("--no-walk=sorted is incompatible with --no-walk=unsorted "
> +				    "and --unsorted-input"));

OK.

>  			revs->unsorted_input = 0;
> -		else if (!strcmp(optarg, "unsorted"))
> +		} else if (!strcmp(optarg, "unsorted"))
>  			revs->unsorted_input = 1;

This is --no-walk=unsorted; could it have been given after --no-walk
or --no-walk=unsorted?

The application of the incompatibility rules seems a bit uneven.  An
earlier piece of code will reject "--no-walk=unsorted --no-walk" given
in this order (see "And likewise" above).  But here, this part of
the code will happily take "--no-walk --no-walk=unsorted".

Of course these details can be fixed with more careful code design,
but I wonder if it may be result in the code and behaviour that is
far simpler to explain (and probably implement) if we declare that

 * --no-walk is not a synonym to --no-walk=sorted; it just flips
   .no_walk member on.

 * --no-walk=sorted and --no-walk=unsorted flip .no_walk member on,
   and then flips .unsorted_input member off or on, respectively.

and define that the usual last-one-wins rule would apply?

Thanks.
