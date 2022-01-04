Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4472C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiADC0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:26:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50031 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiADC0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:26:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CA94170826;
        Mon,  3 Jan 2022 21:26:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Ow/ehu+EeB7ggoW2KgfvR7hw8IzBc9tunbp+IOHtNFU=; b=bICf
        GYAQn86PQUBPepNboE4I1sCURiGazrdOGgGAIdoxZl1XwTT4NZQGfT80f2T8Xt7N
        jWbFH6zYpELwVmLUkETW5aGmvuAdaOdHUXZOiBi2vBORUkRczt062ZXgFJrTEHzW
        yXCsywAdEDaLctiFX6Wa8uDSaPmWGzJ5DYxfhGY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75D9F170825;
        Mon,  3 Jan 2022 21:26:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2759170824;
        Mon,  3 Jan 2022 21:26:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] parse-options.h: add parse_opt_expiry_date helper
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
        <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
        <bcd74559c2474451687c81e97834b13a859d2191.1641223223.git.gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 18:26:42 -0800
Message-ID: <xmqqlezwfd7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2014A8C-6D05-11EC-AD21-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Extract the logic in parse_opt_expiry_date_cb into a helper
> parse_opt_expiry_date. This is to prepare for the following commit where
> we need to parse an expiry date that gets passed into a callback
> function in opt->value as part of a struct.
>
> The next commit will utilize this helper in a callback function that
> aims to wrap the functionality in parse_opt_expiry_date_cb.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>  parse-options-cb.c | 7 ++++++-
>  parse-options.h    | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 3c811e1e4a7..3edb88a54d8 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -34,10 +34,15 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
>  
>  int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
>  			     int unset)
> +{
> +	return parse_opt_expiry_date((timestamp_t *)opt->value, arg, unset);
> +}
> +
> +int parse_opt_expiry_date(timestamp_t *t, const char *arg, int unset)
>  {
>  	if (unset)
>  		arg = "never";
> -	if (parse_expiry_date(arg, (timestamp_t *)opt->value))
> +	if (parse_expiry_date(arg, t))
>  		die(_("malformed expiration date '%s'"), arg);
>  	return 0;
>  }

Does this even belong to parse-options-cb.c file, though?  It's
interface tells us that it is not limited to the parse-options
infrastructure (i.e. it does not even take "struct option" at all).

I am not sure how having this new function will be helpful to begin
with.  We'll see why it helps by looking at the next step, I
presume, but I wonder if the new caller of this function should just
call parse_expiry_date() itself (with "unset means 'never'").

> diff --git a/parse-options.h b/parse-options.h
> index 275fb440818..0a15bac8619 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -301,6 +301,7 @@ enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
>  					   const char *, int);
>  int parse_opt_passthru(const struct option *, const char *, int);
>  int parse_opt_passthru_argv(const struct option *, const char *, int);
> +int parse_opt_expiry_date(timestamp_t *, const char *, int);
>  
>  #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
>  #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
