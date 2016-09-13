Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB90220984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758819AbcIMWwB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:52:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756789AbcIMWwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:52:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0529B3C487;
        Tue, 13 Sep 2016 18:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g+7cCIx9WCpSIC2QMV5UfzUzmmM=; b=Btl/Xb
        oRuDG1Na4F3W99ecEg6NS917txonhZA6rb2fBJ/gfiC5s2llf9OeyE9PZeAKdXtS
        kjOgs4vQ8TUPcvmvtQerPi0eKQTvNlzBCFfwOP0XWlrNzAyiY63CePTIdADjKvGl
        9cQzb3Zo/Bw/YsVVBb+WHDC2sk73+zOvNyFX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IcCpu+JA+EigEQfEOdAmRybPckqT0hDo
        JQLmgvKrnxm4XsNSNmBacuPN4gP27gLlbt/djX/LkLNMWVAdKS/Sbm6uQawTzn/7
        n2PoJcRIH/WdlBOu/WD9FJ3Zthbrj7fV5esiVbPOBnm5yrGDSiGFjk9Jv6fZiYX+
        yIElblZ7POY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF8803C486;
        Tue, 13 Sep 2016 18:51:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 532BB3C485;
        Tue, 13 Sep 2016 18:51:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, chriscool@tuxfamily.org, git@vger.kernel.org
Subject: Re: [RFC/PATCH 05/17] diff.c: emit_line_0 can handle no color setting
References: <20160913044613.1037-1-sbeller@google.com>
        <20160913044613.1037-6-sbeller@google.com>
Date:   Tue, 13 Sep 2016 15:51:56 -0700
In-Reply-To: <20160913044613.1037-6-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Sep 2016 21:46:01 -0700")
Message-ID: <xmqqy42vtnub.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD12CCE4-7A04-11E6-A9DA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> In later patches we may pass lines that are not colored to
> the central function emit_line_0, so we
> need to emit the color only when it is non-NULL.

Explained this way, a reader would find that this step is here
before the underlying code is ready--we are not even buffering
at this step yet.

But that is OK.  It used to be that passing "" as set/reset was the
way to get a --no-color output.  Now you can pass NULL instead of
empty strings.  That would be an alternative explanation why this is
an acceptable change (as your later step probably has a good reason
why it cannot pass "" instead of NULL).

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index b6a40ae..5d57130 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -473,11 +473,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>  	}
>  
>  	if (len || !nofirst) {
> -		fputs(set, file);
> +		if (set)
> +			fputs(set, file);
>  		if (!nofirst)
>  			fputc(first, file);
>  		fwrite(line, len, 1, file);
> -		fputs(reset, file);
> +		if (reset)
> +			fputs(reset, file);
>  	}
>  	if (has_trailing_carriage_return)
>  		fputc('\r', file);
