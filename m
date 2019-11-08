Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D301D1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 05:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfKHFRw (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 00:17:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61163 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfKHFRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 00:17:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13AB721CC5;
        Fri,  8 Nov 2019 00:17:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hyPkPQXOvB7i1jw4zQRxYGzgGzY=; b=Wf3XK/
        uP60rPTpvvYnGAy8NnPSC7J+Dl+sJ6HVIbSlxDsTSGbH270fuBsewZnJGfP5uywj
        ZsxQKXkRmWHby85C/a7Rz+EqyjRB160Mg9pgmdeSRjM4KsF5GUjYgvE23qXo4559
        /dlTts1rdqRQOe9Dbw5H+aRO/V7PU2p9yoiVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NNzbku5oaTdT918vDlJP5KuD2fvCih4r
        UJExLBjwOPOyDbpvTjBPYtU3h9YhiDL0llwZ5kl1y74kcnoBhOQXUlscNygNXj4R
        UivM9f9r9EfBe1XcLKXfWmwJ1CDtz2vHiw0z2Pqs02d3knKqz7GqQhb4ZcPjgD7p
        xJqYsO0qGAM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AA5221CC4;
        Fri,  8 Nov 2019 00:17:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C07121CC3;
        Fri,  8 Nov 2019 00:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 5/9] built-in add -i: implement the main loop
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <25590fbbbee7efc34477bfea233684e93ee7fe60.1572869730.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Nov 2019 14:17:45 +0900
In-Reply-To: <25590fbbbee7efc34477bfea233684e93ee7fe60.1572869730.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 04 Nov 2019
        12:15:25 +0000")
Message-ID: <xmqq1rujndza.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19784522-01E7-11EA-91A7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The reason why we did not start with the main loop to begin with is that
> it is the first user of `list_and_choose()`, which uses the `list()`
> function that we conveniently introduced for use by the `status`
> command.
>
> Apart from the "and choose" part, there are more differences between the
> way the `status` command calls the `list_and_choose()` function in the
> Perl version of `git add -i` compared to the other callers of said
> function. The most important ones:
>
> - The list is not only shown, but the user is also asked to make a
>   choice, possibly selecting multiple entries.

The list_and_choose() we have here shows and lets users choose and
returns the choice, but the above makes it sound as if it only shows
and the caller is responsible for asking the end-user input.  Is
this description outdated or something?

Perl allows us to return multiple choices, where it is a bit hard to
express it in C (perhaps because we are passing in an array of
structs to be shown as choices, list_and_choose could set a bit in
these structs to signal "this one, that one and that other one was
chosen", returning how many are chosen in total, to extend the
version here to bring it to feature-parity?).  So at this step, it
only lets the user one choice (or abort or ask for help).  Isn't the
lack of multiple choice the only difference this bullet item wants
to highlight?

> The Perl script `git-add--interactive.perl` mixed the purposes of the
> "list" and the "and choose" part into the same function. In the C
> version, we will keep them separate instead, calling the `list()`
> function from the `list_and_choose()` function.

That makes sense.

> +static ssize_t list_and_choose(struct add_i_state *s, struct string_list *items,
> +			       struct list_and_choose_options *opts)
> +{
> +	struct strbuf input = STRBUF_INIT;
> +	ssize_t res = LIST_AND_CHOOSE_ERROR;
> +
> +	for (;;) {
> +		char *p, *endp;

The scope of endp looks way too wide in this function, isn't it?
Even in the final state of the series, it only gets used to parse
an integer input using strtoul, inside a block of three lines.

Other than that, the code at this step was a pleasant read overall.

Thanks.
