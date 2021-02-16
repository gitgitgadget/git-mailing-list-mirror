Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14CC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA01464E7A
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBPTjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:39:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60581 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBPTjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:39:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABA069D273;
        Tue, 16 Feb 2021 14:39:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NkjGrFZngqLb64GRBaGRFF4pt60=; b=oFG3mJ
        /D5foXtSPqg0hLSNRwKzLyxu7ujox8lA58GGEIqFvt0BTFD8mDdpXJ3yzxcZtVKQ
        Ao25h5Cdguyph8pd9mms1OpR14nMn/RwZ6gaYXdnpstC0abfc5BWLjPfdCq06B6/
        JMbbFwGcUHLC8Et8lktUdj3ip4tDq6vY05OVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lm3zqgU4SaTtA99wJd8bnNmaX4kNfVen
        U7LCuyHkw+fTIi5uoErXAW2Euq0AmxRlohXODQgtv5Gnl+MFrWSbMgYWR0ZcHZrs
        +b5B8U36O+/SEOpz/bYSoFjF2CLMeXg5m8CwjtpYjz+bd9JGKunaxCYV5wJgOsRM
        ocYqNhE/izA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3AE39D271;
        Tue, 16 Feb 2021 14:39:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 067B39D270;
        Tue, 16 Feb 2021 14:39:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break
 parsing
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
        <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
        <YCwJ8tORQg2Air4r@nand.local>
Date:   Tue, 16 Feb 2021 11:39:00 -0800
In-Reply-To: <YCwJ8tORQg2Air4r@nand.local> (Taylor Blau's message of "Tue, 16
        Feb 2021 13:07:46 -0500")
Message-ID: <xmqqmtw3pzu3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E6BF9BA-708E-11EB-9110-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Anyway, I'm pretty sure the problem is that
> trailer.c:find_trailer_start() doesn't disambiguate between a blank line
> and one that contains only space characters.

I saw that while reviewing another topic the other day and found it
a bit strange, but kept it as I thought it was deliberate and the
behaviour (i.e. a line with only blanks and a line that is empty are
treated the same) was protected with some tests, but looking at your
patch below, I guess there is no such test.

> When it encounters a blank line, find_trailer_start() assumes that the
> trailers must begin on the line following the one it's looking at. But
> this isn't the case if the line is a non-empty continuation, in which
> the line may be part of a trailer.
>
> Fix this by only considering a blank line which has exactly zero space
> characters before the LF as delimiting the start of trailers.

Hmph...

> +test_expect_success 'handling of empty continuations lines' '
> +	tr _ " " >input <<-\EOF &&
> +	subject
> +
> +	body
> +
> +	trailer: single
> +	multi: one
> +	_two
> +	multi: one
> +	_
> +	_two
> +	_three
> +	EOF
> +	cat >expect <<-\EOF &&
> +	trailer: single
> +	multi: one two
> +	multi: one two three
> +	EOF
> +	git interpret-trailers --parse <input >actual &&
> +	test_cmp expect actual
> +'

A few comments (not pointing out bugs, but just sharing
observations).

 - if the line before "trailer: single" were not an empty line but a
   line with a single SP on it (which is is_blank_line()), would the
   new logic get confused?

 - if the second "multi:" trailer did not have the funny blank line
   before "_two", the expected output would still be "multi:"
   followed by "one two three", iow, the line after the second
   "multi: one" is a total no-op?  If we added many more " \n" lines
   there, they are all absorbed and ignored?  It somehow feels wrong

> diff --git a/trailer.c b/trailer.c
> index 249ed618ed..7ca7200aec 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -846,7 +846,7 @@ static size_t find_trailer_start(const char *buf, size_t len)
>  			possible_continuation_lines = 0;
>  			continue;
>  		}
> -		if (is_blank_line(bol)) {
> +		if (is_blank_line(bol) && *bol == '\n') {
>  			if (only_spaces)
>  				continue;
>  			non_trailer_lines += possible_continuation_lines;
> --
> 2.30.0.667.g81c0cbc6fd
