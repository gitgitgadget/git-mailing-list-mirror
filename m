Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54153C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 09:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F385613FB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhEEJs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 05:48:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51171 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhEEJs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 05:48:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3700B7518;
        Wed,  5 May 2021 05:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ya+FsVGerG2z
        joRPrpojZHnZncnPKWPiPSf7aIcf7n0=; b=i56vmIYWIJ+0k6kZXXLNBgBiEWf5
        UZ6ceGFonHaPUcjEGvpRGb4F7UzwEcgmEu33e07zf94BKEkOXHdLU+dWNmhLxdGX
        SlS4g5TozXM/TMBvmAQmM8AAB1+s6pGn4xdnPL0oaaanhAI6XmxDjSxiup7HQ4Zo
        cTfK5FEKJ2u0WDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AC21B7516;
        Wed,  5 May 2021 05:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D4D6B7515;
        Wed,  5 May 2021 05:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
References: <20200404142131.GA679473@coredump.intra.peff.net>
        <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
Date:   Wed, 05 May 2021 18:47:29 +0900
In-Reply-To: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 5 May
 2021 10:40:32 +0200")
Message-ID: <xmqqwnsd3426.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E872ED4A-AD86-11EB-996A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
> appears under -O3 (but not -O2). This makes the build pass under
> DEVELOPER=3D1 without needing a DEVOPTS=3Dno-error.
>
> This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
> clang 7.0.1-8+deb10u2. We've had this warning since
> ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).
>
> As noted in [2] this warning happens because the compiler doesn't
> assume that errno must be non-zero after a failed syscall. Let's work
> around it as suggested in that analysis. We now return -1 ourselves on
> error, and save away the value of errno in a variable the caller
> passes in.
>
> 1.
>
>     trace2/tr2_dst.c: In function =E2=80=98tr2_dst_get_trace_fd.part.5=E2=
=80=99:
>     trace2/tr2_dst.c:296:10: warning: =E2=80=98fd=E2=80=99 may be used =
uninitialized in this function [-Wmaybe-uninitialized]
>       dst->fd =3D fd;
>       ~~~~~~~~^~~~
>     trace2/tr2_dst.c:229:6: note: =E2=80=98fd=E2=80=99 was declared her=
e
>       int fd;
>           ^~
> 2. https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.p=
eff.net/
> ---
>  trace2/tr2_dst.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

The patch makes sense to me, modulo that the way the variable
"saved_errno" introduced by this patch is used and the way a
variable with that name is typically used in our codebase are at
odds.  I.e. we typically call a variable "saved_errno" when it is
used in this pattern:

    if (a_syscall_whose_error_condition_we_care_about()) {
	int saved_errno =3D errno;
	perform_some_cleanup_operation_that_might_clobber_errno();
	return error_errno(..., saved_errno);
	/*
	 * or
	 * errno =3D saved_errno;
	 * return -1;
	 * and let the caller handle 'errno'
	 */
    }

But since I do not think of a better name for this new variable that
is not exactly used like so, let's queue it as-is.

Thanks.

> diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> index ae052a07fe2..c2aba71041b 100644
> --- a/trace2/tr2_dst.c
> +++ b/trace2/tr2_dst.c
> @@ -197,22 +197,25 @@ static int tr2_dst_try_path(struct tr2_dst *dst, =
const char *tgt_value)
>  #define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
>  #define PREFIX_AF_UNIX_DGRAM "af_unix:dgram:"
> =20
> -static int tr2_dst_try_uds_connect(const char *path, int sock_type, in=
t *out_fd)
> +static int tr2_dst_try_uds_connect(const char *path, int sock_type,
> +				   int *out_fd, int *saved_errno)
>  {
>  	int fd;
>  	struct sockaddr_un sa;
> =20
>  	fd =3D socket(AF_UNIX, sock_type, 0);
> -	if (fd =3D=3D -1)
> -		return errno;
> +	if (fd =3D=3D -1) {
> +		*saved_errno =3D errno;
> +		return -1;
> +	}
> =20
>  	sa.sun_family =3D AF_UNIX;
>  	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
> =20
>  	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) =3D=3D -1) {
> -		int e =3D errno;
> +		*saved_errno =3D errno;
>  		close(fd);
> -		return e;
> +		return -1;
>  	}
> =20
>  	*out_fd =3D fd;
> @@ -227,7 +230,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr=
2_dst *dst,
>  {
>  	unsigned int uds_try =3D 0;
>  	int fd;
> -	int e;
> +	int saved_errno;
>  	const char *path =3D NULL;
> =20
>  	/*
> @@ -271,15 +274,15 @@ static int tr2_dst_try_unix_domain_socket(struct =
tr2_dst *dst,
>  	}
> =20
>  	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
> -		e =3D tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd,
> +					     &saved_errno))
>  			goto connected;
> -		if (e !=3D EPROTOTYPE)
> +		if (saved_errno !=3D EPROTOTYPE)
>  			goto error;
>  	}
>  	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
> -		e =3D tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd,
> +					     &saved_errno))
>  			goto connected;
>  	}
> =20
> @@ -287,7 +290,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr=
2_dst *dst,
>  	if (tr2_dst_want_warning())
>  		warning("trace2: could not connect to socket '%s' for '%s' tracing: =
%s",
>  			path, tr2_sysenv_display_name(dst->sysenv_var),
> -			strerror(e));
> +			strerror(saved_errno));
> =20
>  	tr2_dst_trace_disable(dst);
>  	return 0;
