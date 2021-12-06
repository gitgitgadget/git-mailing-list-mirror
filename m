Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116BC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351596AbhLFV3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:29:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54720 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351553AbhLFV3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:29:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87EED102CEB;
        Mon,  6 Dec 2021 16:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hBXW0/ewGkHD
        bCFh9Mu5U9scBF2TWDIUDWU8mKOH+SE=; b=CvqScyrOEdega3VjhB49TPf47Hek
        PUWqJrWPfalAcCcJJ3fKiBHCre1YTUB4oapvmNoTAKHIRYKC6UTGALNSNqEgtOhP
        JHt1xKu8xrnvvrFot5s4oJIYWxueiwNRdbRKBbw4CO5tnte6q1PI6rhb4vX6ctDk
        1xUyHXKl08NHEps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 711A2102CEA;
        Mon,  6 Dec 2021 16:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9576102CE9;
        Mon,  6 Dec 2021 16:26:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] config API: don't use vreportf(), make it static in
 usage.c
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
        <patch-4.4-e0e6427cbd3-20211206T165221Z-avarab@gmail.com>
Date:   Mon, 06 Dec 2021 13:26:13 -0800
In-Reply-To: <patch-4.4-e0e6427cbd3-20211206T165221Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Dec
 2021 17:55:53 +0100")
Message-ID: <xmqqfsr5e87e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24426078-56DB-11EC-AE95-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In preceding commits the rest of the vreportf() users outside of
> usage.c have been migrated to die_message(), leaving only the
> git_die_config() function added in 5a80e97c827 (config: add
> `git_die_config()` to the config-set API, 2014-08-07).
>
> Let's have its callers call error() themselves if they want to emit a
> message, which is exactly what git_die_config() was doing for them
> before emitting its own die() message.

I do not quite get this.  If git_die_config() has been showing the
message for them, and if the existing callers can just use error(),
why not git_die_config() call error() on behalf of these callers?

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 2b2e28bad79..4e2432bb491 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -3456,9 +3456,10 @@ static void git_pack_config(void)
>  	}
>  	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
>  		pack_idx_opts.version =3D indexversion_value;
> -		if (pack_idx_opts.version > 2)
> -			git_die_config("pack.indexversion",
> -					"bad pack.indexversion=3D%"PRIu32, pack_idx_opts.version);
> +		if (pack_idx_opts.version > 2) {
> +			error("bad pack.indexversion=3D%"PRIu32, pack_idx_opts.version);
> +			git_die_config("pack.indexversion");
> +		}

This is exactly what triggered the question above, and the pattern
repeats elsewhere, too.

> @@ -2550,18 +2552,12 @@ void git_die_config_linenr(const char *key, con=
st char *filename, int linenr)
>  		    key, filename, linenr);
>  }
> =20
> -NORETURN __attribute__((format(printf, 2, 3)))
> -void git_die_config(const char *key, const char *err, ...)
> +NORETURN
> +void git_die_config(const char *key)
>  {
>  	const struct string_list *values;
>  	struct key_value_info *kv_info;
> =20
> -	if (err) {
> -		va_list params;
> -		va_start(params, err);
> -		vreportf("error: ", err, params);
> -		va_end(params);

I get that we do not want to expose vreportf() to this caller, and I
agree with the goal, but wouldn't it be the matter of calling
get_error_routine() and calling it with err and params here, instead
of losing the whole block?  Is that insufficient to avoid toucing
all the callers?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index c6c6f7d6b51..bdb3977b9ec 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -474,7 +474,6 @@ static inline int git_has_dir_sep(const char *path)
>  struct strbuf;
> =20
>  /* General helper functions */
> -void vreportf(const char *prefix, const char *err, va_list params);

Good.

> diff --git a/usage.c b/usage.c
> index 3d09e8eea48..9943dd8742e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -6,7 +6,7 @@
>  #include "git-compat-util.h"
>  #include "cache.h"
> =20
> -void vreportf(const char *prefix, const char *err, va_list params)
> +static void vreportf(const char *prefix, const char *err, va_list para=
ms)

Good, too.

Thanks.
