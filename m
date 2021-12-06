Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E6C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 19:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245338AbhLFTqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:46:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50011 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbhLFTqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 14:46:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 603411021BC;
        Mon,  6 Dec 2021 14:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a18+ff4NRyaB
        ZvqnWm2Lb1lLwhQmdQ+nfTplrWFVoPk=; b=oRJtfYgl2K65KOCjwhwrJPJbq5fd
        x+LI+4ebDFvYaczHgiyN7Xx85twMhoiQpEGoHEX03VXPKjNPGkfY5ANS9HeehJYw
        rF8TFRIwbPv4+oBKHCdqrxgPfW0vjfLAEiSCVXnlXHJXI/bG47OSCKgwnT+dMeLd
        yUV02nQVLYReP30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53A0F1021BB;
        Mon,  6 Dec 2021 14:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A641E1021BA;
        Mon,  6 Dec 2021 14:42:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] usage.c: add a die_message() routine
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
        <patch-1.4-5a9ab85fa56-20211206T165221Z-avarab@gmail.com>
Date:   Mon, 06 Dec 2021 11:42:42 -0800
In-Reply-To: <patch-1.4-5a9ab85fa56-20211206T165221Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Dec
 2021 17:55:50 +0100")
Message-ID: <xmqqee6pfrkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE2A774E-56CC-11EC-847D-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +int die_message(const char *err, ...) __attribute__((format (printf, 1=
, 2)));

This probalby makes sense (we'll need to see the caller first).

> +static void die_message_builtin(const char *err, va_list params)
> +{
> +	trace2_cmd_error_va(err, params);
> +	vreportf("fatal: ", err, params);
> +}

I thought the convention was *not* that we name the variant that
takes va_list with _builtin suffix, rather, I thought that the
convention is that ones with the _builtin suffix are meant to be
override-able by other code.

>  /*
>   * We call trace2_cmd_error_va() in the below functions first and
>   * expect it to va_copy 'params' before using it (because an 'ap' can
> @@ -62,10 +68,7 @@ static NORETURN void usage_builtin(const char *err, =
va_list params)
>   */
>  static NORETURN void die_builtin(const char *err, va_list params)
>  {
> -	trace2_cmd_error_va(err, params);
> -
> -	vreportf("fatal: ", err, params);
> -
> +	die_message_builtin(err, params);
>  	exit(128);
>  }

And by making die() and die_message() both override-able, doesn't it
cause confusion on the caller's end which one should get replaced?
Or with die_message being overridable, we should rewrite the ones
that override die() to instead override die_message()?

It also makes readers wonder why this is not

	exit(die_message(err, params));

which I take it a sign that this new API is overly loose to allow a
simple single thing to be done in multiple ways.  Perhaps as the
series progresses, the picture might improve, but if that is the
case, perhaps the presentation order needs to be rethought.
E.g. start without the _builtin that implies override-ability,
convert the existing code that can benefit from calling die_message(),
and then finally introduce _builtin that is merely an implementation
detail, or something like that, perhaps?

In any case, the first step in this four patch series is not enough
to evaluate if this step makes sense, so let's keep reading.

> @@ -211,6 +214,17 @@ void NORETURN die_errno(const char *fmt, ...)
>  	va_end(params);
>  }
> =20
> +#undef die_message
> +int die_message(const char *err, ...)
> +{
> +	va_list params;
> +
> +	va_start(params, err);
> +	die_message_builtin(err, params);
> +	va_end(params);
> +	return 128;
> +}

OK.

Thanks.


>  #undef error_errno
>  int error_errno(const char *fmt, ...)
>  {
