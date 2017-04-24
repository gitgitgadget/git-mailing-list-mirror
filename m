Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77A7207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 03:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164468AbdDXDY6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 23:24:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57980 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164428AbdDXDYz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 23:24:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAF2D7DB14;
        Sun, 23 Apr 2017 23:24:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yn53U4JOvjdI9HmM+cxn9XgoVaQ=; b=Jwbn/8
        pElYvqYcuYGXCrdxm4DJewb+80GlR/OIJvmlsPDqXvszwhQKDAy8wb9+N8lU8oiG
        Cs1f+n1Nxmzg/RehoOxNk6WPRqJj/kTw1dqblV4RwVpnUbMIgSFLPCBVsjd0bI32
        JvzaZXKlDAuA9uJhFtVtA8u1EQYAajIVc+Nrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mBctALJbkj/yY4YQUENYZfTdqXM87BoO
        uMq/fxPXjSBhXPWUpAupKKsndhSyzawwrpjfGSHA9Kak5V75IkwmhZp5Etgvnvt2
        XgWX6jYdZBaBQvZ952NYKjyxM7XGrHVXPxx8gKkqP6VKidUeJ7I30InbKYKoXowE
        wPWOkAdaU4k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E23B37DB13;
        Sun, 23 Apr 2017 23:24:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38CC67DB12;
        Sun, 23 Apr 2017 23:24:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
Date:   Sun, 23 Apr 2017 20:24:49 -0700
In-Reply-To: <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 21 Apr 2017 12:46:01 +0200
        (CEST)")
Message-ID: <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 932FDE00-289D-11E7-8C5C-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Previously, we used `unsigned long` for timestamps. This was only a good
> choice on Linux, where we know implicitly that `unsigned long` is what is
> used for `time_t`.
>
> However, we want to use a different data type for timestamps for two
> reasons:
>
> - there is nothing that says that `unsigned long` should be the same data
>   type as `time_t`, and indeed, on 64-bit Windows for example, it is not:
>   `unsigned long` is 32-bit but `time_t` is 64-bit.
>
> - even on 32-bit Linux, where `unsigned long` (and thereby `time_t`) is
>   32-bit, we *want* to be able to encode timestamps in Git that are
>   currently absurdly far in the future, *even if* the system library is
>   not able to format those timestamps into date strings.
>
> So let's just switch to the maximal integer type available, which should
> be at least 64-bit for all practical purposes these days. It certainly
> cannot be worse than `unsigned long`, so...

Should we at least clamp in date_overflows() so that large values
representable with timestamp_t that will become unrepresentable when
we start allowing negative timestamps would be rejected?  That way
we won't have to hear complaints from the people who used timestamps
far in the future that we regressed the implementation for them by
halving the possible timestamp range.



> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-compat-util.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 72c12173a14..c678ca94b8f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -319,10 +319,14 @@ extern char *gitdirname(char *);
>  #define PRIo32 "o"
>  #endif
>  
> -typedef unsigned long timestamp_t;
> -#define PRItime "lu"
> -#define parse_timestamp strtoul
> +typedef uintmax_t timestamp_t;
> +#define PRItime PRIuMAX
> +#define parse_timestamp strtoumax
> +#ifdef ULLONG_MAX
> +#define TIME_MAX ULLONG_MAX
> +#else
>  #define TIME_MAX ULONG_MAX
> +#endif
>  
>  #ifndef PATH_SEP
>  #define PATH_SEP ':'
