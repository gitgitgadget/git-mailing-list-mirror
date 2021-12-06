Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C769AC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 20:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhLFUDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 15:03:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56208 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLFUDn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 15:03:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FF901600FD;
        Mon,  6 Dec 2021 15:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IVj97XHcpQkd
        Mp9me0/MAW3zV2U7O60/UrRtDWj81h0=; b=oWDmG2d/AfXO1JTAHhKJaIiFijRS
        sMbwlS7pwvaHwHMgDTpMWuyKTX1Kyt6wp/RMmYOf+TJAw7mK/tqJjnr00kShwnpx
        vzfhTdMf2xt+nvJbD0gwtCJ+5tUDxJqAoa3KYEAbtQpJr0DV/k6XwvXNLsQrBnRF
        2nAGBlZvEwJ9/78=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 584091600FB;
        Mon,  6 Dec 2021 15:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 413E41600F1;
        Mon,  6 Dec 2021 15:00:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] usage.c API users: use die_message() where appropriate
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
        <patch-2.4-36c050c90c2-20211206T165221Z-avarab@gmail.com>
Date:   Mon, 06 Dec 2021 12:00:08 -0800
In-Reply-To: <patch-2.4-36c050c90c2-20211206T165221Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Dec
 2021 17:55:51 +0100")
Message-ID: <xmqqy24xec6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1DFAE2FA-56CF-11EC-8046-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  static NORETURN void die_nicely(const char *err, va_list params)
>  {
> +	va_list cp;
>  	static int zombie;
> -	char message[2 * PATH_MAX];
> +	report_fn die_message_fn =3D get_die_message_routine();
> =20
> -	vsnprintf(message, sizeof(message), err, params);
> -	fputs("fatal: ", stderr);
> -	fputs(message, stderr);
> -	fputc('\n', stderr);
> +	va_copy(cp, params);
> +	die_message_fn(err, params);
> =20
>  	if (!zombie) {
> +		char message[2 * PATH_MAX];
> +
>  		zombie =3D 1;
> +		vsnprintf(message, sizeof(message), err, cp);
>  		write_crash_report(message);
>  		end_packfile();
>  		unkeep_all_packs();

So, we used to compose the die-looking "fatal:" message by hand, but
we now grab the function "die()" that is currently in effect uses to
prepare its message, and let it compose the message for us.  It will
work even when somebody else were overriding die_message_routine to
reuse their custome die_message_routine, which is nice.  And because
this function is used to override die_routine, we do not have to be
worrying about somebody else overriding die_routine without
overriding die_message_routine.

OK.


> diff --git a/builtin/notes.c b/builtin/notes.c
> index 71c59583a17..2812d1eac40 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -201,11 +201,12 @@ static void prepare_note_data(const struct object=
_id *object, struct note_data *
>  static void write_note_data(struct note_data *d, struct object_id *oid=
)
>  {
>  	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
> -		error(_("unable to write note object"));
> +		int status =3D die_message(_("unable to write note object"));
> +
>  		if (d->edit_path)
> -			error(_("the note contents have been left in %s"),
> -				d->edit_path);
> -		exit(128);
> +			die_message(_("the note contents have been left in %s"),
> +				    d->edit_path);
> +		exit(status);

OK.  This changes the message when we terminate from "error:" to
"fatal:", but I can buy that we could argue that the original was
abusing the error() to work around the lack of die_message().

> diff --git a/http-backend.c b/http-backend.c
> index 3d6e2ff17f8..982cb62c7cb 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -659,8 +659,9 @@ static NORETURN void die_webcgi(const char *err, va=
_list params)
>  {
>  	if (dead <=3D 1) {
>  		struct strbuf hdr =3D STRBUF_INIT;
> +		report_fn die_message_fn =3D get_die_message_routine();
> =20
> -		vreportf("fatal: ", err, params);
> +		die_message_fn(err, params);
> =20
>  		http_status(&hdr, 500, "Internal Server Error");
>  		hdr_nocache(&hdr);

OK.  As there is a known change that wants to touch this file, it is
unfortunate that you chose to do this now, but the above makes sense.
It is a quite straight-forward clean-up.

> diff --git a/parse-options.c b/parse-options.c
> index fc5b43ff0b2..8bc0a21f1d7 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1075,6 +1075,6 @@ void NORETURN usage_msg_opt(const char *msg,
>  		   const char * const *usagestr,
>  		   const struct option *options)
>  {
> -	fprintf(stderr, "fatal: %s\n\n", msg);
> +	die_message("%s\n", msg); /* The extra \n is intentional */
>  	usage_with_options(usagestr, options);
>  }

OK.

> diff --git a/run-command.c b/run-command.c
> ...
> @@ -372,9 +363,10 @@ static void NORETURN child_die_fn(const char *err,=
 va_list params)
>  static void child_err_spew(struct child_process *cmd, struct child_err=
 *cerr)
>  {
>  	static void (*old_errfn)(const char *err, va_list params);
> +	report_fn die_message_routine =3D get_die_message_routine();
> =20
>  	old_errfn =3D get_error_routine();
> -	set_error_routine(fake_fatal);
> +	set_error_routine(die_message_routine);
>  	errno =3D cerr->syserr;

OK.  This is literally equivalent to the original.

> @@ -1082,7 +1074,9 @@ static void *run_thread(void *data)
> =20
>  static NORETURN void die_async(const char *err, va_list params)
>  {
> -	vreportf("fatal: ", err, params);
> +	report_fn die_message_fn =3D get_die_message_routine();
> +
> +	die_message_fn(err, params);

Likewise.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index a83fbdf6398..d5e495529c8 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -514,6 +514,7 @@ static inline int const_error(void)
>  typedef void (*report_fn)(const char *, va_list params);
> =20
>  void set_die_routine(NORETURN_PTR report_fn routine);
> +report_fn get_die_message_routine(void);
>  void set_error_routine(report_fn routine);
>  report_fn get_error_routine(void);
>  void set_warn_routine(report_fn routine);
> diff --git a/usage.c b/usage.c
> index 74b43c5db6f..76399ba8409 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -68,7 +68,9 @@ static void die_message_builtin(const char *err, va_l=
ist params)
>   */
>  static NORETURN void die_builtin(const char *err, va_list params)
>  {
> -	die_message_builtin(err, params);
> +	report_fn die_message_fn =3D get_die_message_routine();
> +
> +	die_message_fn(err, params);
>  	exit(128);
>  }
> =20
> @@ -112,6 +114,7 @@ static int die_is_recursing_builtin(void)
>   * (ugh), so keep things static. */
>  static NORETURN_PTR report_fn usage_routine =3D usage_builtin;
>  static NORETURN_PTR report_fn die_routine =3D die_builtin;
> +static report_fn die_message_routine =3D die_message_builtin;
>  static report_fn error_routine =3D error_builtin;
>  static report_fn warn_routine =3D warn_builtin;
>  static int (*die_is_recursing)(void) =3D die_is_recursing_builtin;
> @@ -121,6 +124,11 @@ void set_die_routine(NORETURN_PTR report_fn routin=
e)
>  	die_routine =3D routine;
>  }
> =20
> +report_fn get_die_message_routine(void)
> +{
> +	return die_message_routine;
> +}
> +
>  void set_error_routine(report_fn routine)
>  {
>  	error_routine =3D routine;
> @@ -220,7 +228,7 @@ int die_message(const char *err, ...)
>  	va_list params;
> =20
>  	va_start(params, err);
> -	die_message_builtin(err, params);
> +	die_message_routine(err, params);
>  	va_end(params);
>  	return 128;
>  }

I think these hunks are better fit in the previous step.  This is a
"now we have a new set of API functions, let's convert the existing
code to take advantage of them" step, and "oops, what we presented
as a new set of API functions in the previous step was incomplete,
let's patch them up" should not be included in there.

Thanks.
