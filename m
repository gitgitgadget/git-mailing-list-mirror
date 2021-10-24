Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F6C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AB760E0B
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhJXFvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 01:51:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55383 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJXFvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 01:51:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 011C21642E9;
        Sun, 24 Oct 2021 01:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bc/tj27yqXlP
        1eOuwTiT5tsQ2HOTSIjU3O1TPR8Ngfc=; b=WnL4zm8TtL2+0wEsIPSwA6VfI/SQ
        xxOjLT64CH7wXUfsVXrjFdZmIkGRbNPS2G2rhqfdcZ1kaGrpp7XgApRYlPHmSir8
        IH6QnS2EZ1W0z4V7xKoqDigcNbWuhuFH/MFUWqeUJeYDkCyDJqKGp1GPOx3K1m26
        uwhpWR898Fs5Sk4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBCF71642E8;
        Sun, 24 Oct 2021 01:49:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A5A41642E7;
        Sun, 24 Oct 2021 01:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 1/6] usage.c: add a die_message() routine
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
        <patch-v3-1.6-fe8763337ed-20211022T175227Z-avarab@gmail.com>
Date:   Sat, 23 Oct 2021 22:49:17 -0700
In-Reply-To: <patch-v3-1.6-fe8763337ed-20211022T175227Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Oct
 2021 20:19:34
        +0200")
Message-ID: <xmqqmtmz55wi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20DFE1CC-348E-11EC-A2F9-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We have code in various places that would like to call die(), but
> wants to defer the exit(128) it would invoke, e.g. to print an
> additional message, or adjust the exit code. Add a die_message()
> helper routine to bridge this gap in the API.
>
> Functionally this behaves just like the error() routine, except it'll
> print a "fatal: " prefix, and it will exit with 128 instead of -1,

exit with -> return?

> this is so that caller can pas the return value to exit(128), instead
> of having to hardcode "128".

Is it just me or do your patch always have to do about the same
amount of seemingly unnecessary and/or unadvertised changes as the
necessary and/or advertised changes?  I agree that adding
die_message() that returns 128 after giving a message is an
excellent idea, and I can see that it is necessary and sufficient to
achieve the above advertised goal, but I don't see any reason why
set/get_message_routine() must exist, especially as a part of this
step.

IOW, perhaps that half of this patch belongs to and should be
squashed into one of the later steps of this series?

> A subsequent commit will migrate various callers that benefit from
> this function over to it, for now we're just migrating trivial users
> in usage.c itself.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  git-compat-util.h |  3 +++
>  usage.c           | 46 ++++++++++++++++++++++++++++++++++------------
>  2 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 141bb86351e..c1bb32460b6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -471,6 +471,7 @@ NORETURN void usage(const char *err);
>  NORETURN void usagef(const char *err, ...) __attribute__((format (prin=
tf, 1, 2)));
>  NORETURN void die(const char *err, ...) __attribute__((format (printf,=
 1, 2)));
>  NORETURN void die_errno(const char *err, ...) __attribute__((format (p=
rintf, 1, 2)));
> +int die_message(const char *err, ...) __attribute__((format (printf, 1=
, 2)));
>  int error(const char *err, ...) __attribute__((format (printf, 1, 2)))=
;
>  int error_errno(const char *err, ...) __attribute__((format (printf, 1=
, 2)));
>  void warning(const char *err, ...) __attribute__((format (printf, 1, 2=
)));
> @@ -505,6 +506,8 @@ static inline int const_error(void)
>  typedef void (*report_fn)(const char *, va_list params);
> =20
>  void set_die_routine(NORETURN_PTR report_fn routine);
> +void set_die_message_routine(report_fn routine);
> +report_fn get_die_message_routine(void);
>  void set_error_routine(report_fn routine);
>  report_fn get_error_routine(void);
>  void set_warn_routine(report_fn routine);
> diff --git a/usage.c b/usage.c
> index c7d233b0de9..3d4b90bce1f 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -55,6 +55,12 @@ static NORETURN void usage_builtin(const char *err, =
va_list params)
>  	exit(129);
>  }
> =20
> +static void die_message_builtin(const char *err, va_list params)
> +{
> +	trace2_cmd_error_va(err, params);
> +	vreportf("fatal: ", err, params);
> +}
> +
>  /*
>   * We call trace2_cmd_error_va() in the below functions first and
>   * expect it to va_copy 'params' before using it (because an 'ap' can
> @@ -62,10 +68,9 @@ static NORETURN void usage_builtin(const char *err, =
va_list params)
>   */
>  static NORETURN void die_builtin(const char *err, va_list params)
>  {
> -	trace2_cmd_error_va(err, params);
> -
> -	vreportf("fatal: ", err, params);
> +	report_fn die_message_fn =3D get_die_message_routine();
> =20
> +	die_message_fn(err, params);
>  	exit(128);
>  }
> =20
> @@ -109,6 +114,7 @@ static int die_is_recursing_builtin(void)
>   * (ugh), so keep things static. */
>  static NORETURN_PTR report_fn usage_routine =3D usage_builtin;
>  static NORETURN_PTR report_fn die_routine =3D die_builtin;
> +static report_fn die_message_routine =3D die_message_builtin;
>  static report_fn error_routine =3D error_builtin;
>  static report_fn warn_routine =3D warn_builtin;
>  static int (*die_is_recursing)(void) =3D die_is_recursing_builtin;
> @@ -118,6 +124,16 @@ void set_die_routine(NORETURN_PTR report_fn routin=
e)
>  	die_routine =3D routine;
>  }
> =20
> +void set_die_message_routine(report_fn routine)
> +{
> +	die_message_routine =3D routine;
> +}
> +
> +report_fn get_die_message_routine(void)
> +{
> +	return die_message_routine;
> +}
> +
>  void set_error_routine(report_fn routine)
>  {
>  	error_routine =3D routine;
> @@ -157,14 +173,23 @@ void NORETURN usage(const char *err)
>  	usagef("%s", err);
>  }
> =20
> +#undef die_message
> +int die_message(const char *err, ...)
> +{
> +	va_list params;
> +
> +	va_start(params, err);
> +	die_message_routine(err, params);
> +	va_end(params);
> +	return 128;
> +}
> +
>  void NORETURN die(const char *err, ...)
>  {
>  	va_list params;
> =20
> -	if (die_is_recursing()) {
> -		fputs("fatal: recursion detected in die handler\n", stderr);
> -		exit(128);
> -	}
> +	if (die_is_recursing())
> +		exit(die_message("recursion detected in die handler"));
> =20
>  	va_start(params, err);
>  	die_routine(err, params);
> @@ -200,11 +225,8 @@ void NORETURN die_errno(const char *fmt, ...)
>  	char buf[1024];
>  	va_list params;
> =20
> -	if (die_is_recursing()) {
> -		fputs("fatal: recursion detected in die_errno handler\n",
> -			stderr);
> -		exit(128);
> -	}
> +	if (die_is_recursing())
> +		exit(die_message("recursion detected in die_errno handler"));
> =20
>  	va_start(params, fmt);
>  	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
