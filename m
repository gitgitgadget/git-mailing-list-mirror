Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18DEC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJNSkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJNSkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 14:40:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85808A8CE2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 11:40:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0B1815FE75;
        Fri, 14 Oct 2022 14:40:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nx6NSPFMCVvW
        V/HXn0YC1JbV/HxTIEGNU/1dyzvrSRw=; b=s0qVrskmrSElYuBgLmiiRpbCrNXg
        PgCTFwtgEYdSIxg0buOrF5kC/G+gPwXMqexEVM+ovOxSCw7bp8SjyZoYLnRZ4jQB
        1htNt0W0R9tHWbi6PgSkP+0dxfcSHo4PTycu/ks+hhY5jOkHzwq2vJV/0EVxh9RB
        dLq7FHZRB6ARrPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6E7115FE74;
        Fri, 14 Oct 2022 14:40:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AC5E15FE73;
        Fri, 14 Oct 2022 14:40:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 03/10] run-command API: add and use a run_command_l_opt()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <patch-03.10-fd81d44f221-20221014T153426Z-avarab@gmail.com>
Date:   Fri, 14 Oct 2022 11:40:27 -0700
In-Reply-To: <patch-03.10-fd81d44f221-20221014T153426Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 14 Oct
 2022 17:40:15
        +0200")
Message-ID: <xmqqtu468d0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD121718-4BEF-11ED-A7E7-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  bisect.c                 | 19 +++++++++----------
>  builtin/clone.c          | 16 ++++++----------
>  builtin/difftool.c       | 14 ++++++--------
>  builtin/gc.c             | 22 ++++++++--------------
>  builtin/merge.c          | 35 ++++++-----------------------------
>  builtin/remote.c         | 10 ++++------
>  compat/mingw.c           |  8 +++-----
>  ll-merge.c               |  4 +---
>  run-command.c            | 15 +++++++++++++++
>  run-command.h            | 13 +++++++++++--
>  sequencer.c              |  4 +---
>  t/helper/test-fake-ssh.c |  4 +---
>  12 files changed, 71 insertions(+), 93 deletions(-)

Nice.

> @@ -862,11 +858,11 @@ static void write_refspec_config(const char *src_=
ref_prefix,
> =20
>  static void dissociate_from_references(void)
>  {
> -	static const char* argv[] =3D { "repack", "-a", "-d", NULL };

Good to see that this one in a wrong scope can now go away.

>  	char *alternates =3D git_pathdup("objects/info/alternates");
> =20
>  	if (!access(alternates, F_OK)) {
> -		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
> +		if (run_command_l_opt(RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
> +				      "repack",  "-a", "-d", NULL))
>  			die(_("cannot repack to clean up"));


> diff --git a/builtin/remote.c b/builtin/remote.c
> index 910f7b9316a..1d86c14297b 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -92,13 +92,11 @@ static int verbose;
> =20
>  static int fetch_remote(const char *name)
>  {
> -	const char *argv[] =3D { "fetch", name, NULL, NULL };
> -	if (verbose) {
> -		argv[1] =3D "-v";
> -		argv[2] =3D name;
> -	}
>  	printf_ln(_("Updating %s"), name);
> -	if (run_command_v_opt(argv, RUN_GIT_CMD))
> +	if (verbose && run_command_l_opt(RUN_GIT_CMD, "-v", "fetch", name,
> +					 NULL))
> +		return error(_("Could not fetch %s"), name);
> +	else if (run_command_l_opt(RUN_GIT_CMD, "fetch", name, NULL))
>  		return error(_("Could not fetch %s"), name);
>  	return 0;
>  }

This, together with the "merge" one that used to be conditional
(which I take as a sign that new callers can legitimately wish it to
be conditional again), is where the new l_opt() variant is weak.

And the above is wrong.  If verbose option is given and run command
succeeds in running "fetch -v" (another bug is that the updated code
is running "git -v fetch <name>"), we will try running "fetch" without
"-v" option after that.

So, for simplest things (i.e. the majority of places this patch
touches), addition of l_opt() is great.  Use of it for nontrivial
things like this is not.  We need to repeat ourselves, and the use
of API is error prone.

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 901375d5841..4f5392c5796 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -196,17 +196,15 @@ static int read_yes_no_answer(void)
>  static int ask_yes_no_if_possible(const char *format, ...)
>  {
>  	char question[4096];
> -	const char *retry_hook[] =3D { NULL, NULL, NULL };

Good to see that this one in a wrong scope can now go away.

> +	char *retry_hook;
>  	va_list args;
> =20
>  	va_start(args, format);
>  	vsnprintf(question, sizeof(question), format, args);
>  	va_end(args);
> =20
> -	if ((retry_hook[0] =3D mingw_getenv("GIT_ASK_YESNO"))) {
> -		retry_hook[1] =3D question;
> -		return !run_command_v_opt(retry_hook, 0);
> -	}
> +	if ((retry_hook =3D mingw_getenv("GIT_ASK_YESNO")))
> +		return !run_command_l_opt(0, retry_hook, question, NULL);
> =20
>  	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
>  		return 0;
