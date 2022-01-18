Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5368DC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 17:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347046AbiARRTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:19:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57637 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiARRTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 12:19:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 343741699B5;
        Tue, 18 Jan 2022 12:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GrDZRBscJKY0
        FxIEZ5cW1vCzvp+pj6msVfPc0Fe8rXQ=; b=PYFaZ7OjNM8GSmvGv9XitdBhLt30
        SrF7RGM575+zFoZHw4D08VwFYPB/xrRpKl07ePKI3lyGSJd2dszBzm7xGDAcXXqc
        SgWRxsMPU0GEIAKE+ZwW7Fo5rWDZMwBv3GEbXajvc9xyS8Y8gt919J5aS+yeRwQh
        P/DOfCeIwnR51+U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C6B81699B4;
        Tue, 18 Jan 2022 12:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91F361699B3;
        Tue, 18 Jan 2022 12:19:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, fuz@fuz.su
Subject: Re: [PATCH] config.mak.dev: fix DEVELOPER=1 on FreeBSD with -std=gnu99
References: <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <patch-1.1-06cc12be94d-20220118T151234Z-avarab@gmail.com>
Date:   Tue, 18 Jan 2022 09:19:12 -0800
In-Reply-To: <patch-1.1-06cc12be94d-20220118T151234Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 18 Jan
 2022 16:14:17 +0100")
Message-ID: <xmqqbl09t10v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1EB4650-7882-11EC-8098-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The inherent problem is that __has_extension() is a way to ask
> Clang (and GCC) whether the compiler supports that feature, but the
> -Wc11-extensions warning will be issued on the basis of the selected
> __STDC_VERSION__. With -std=3Dgnu99 the __has_extension() built-in will
> return true, but the warning will still fire.
>
> Let's narrowly work around this by checking whether:

The end result, if and when a change along this line proves OK for
all versions of FreeBSD we care about, may be narrow, but as a band
aid to discuss just before the final release, I do not know if
anybody can sensibly assess the ramifications of such a change,
except for somebody whose primary development environment has been
FreeBSD for the past 6 months or more.

This looks way more than we can take comfortably at this point in
the release cycle, compared to "fixing" the developer build by
kicking developers on FreeBSD out of the "we are C99 or below at
this point" enforcement mechanism.

>  A. We are under FreeBSD
>  B. We are using a C standard older than C11
>
> In that case we'll include sys/cdefs.h, and undefine FreeBSD's
> __generic() wrapper if it's been defined. We'll then load libgen.h,
> and restore whatever __generic definition we temporarily undefined
> earlier.
>
> An alternate solution would be to simply define NO_LIBGEN_H=3DY in
> config.mak.uname for FreeBSD, but this way we'll use its OS-provided
> basename() and dirname(), and in the general case ensure that nothing
> changes outside of DEVELOPER=3D1 builds.
>
> 1. https://github.com/freebsd/freebsd-src/commit/62b7f85d4749
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  git-compat-util.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 1229c8296b9..69d9b5f202f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -318,7 +318,25 @@ static inline int setitimer(int which, const struc=
t itimerval *value, struct iti
>  #endif
> =20
>  #ifndef NO_LIBGEN_H
> +/*
> + * FreeBSD's libgen.h inadvertently requires C11 features, due to its
> + * sys/cdefs.h using _Generic() if
> + * __has_extension(c_generic_selections) is true, regardless of
> + * __STDC_VERSION__....
> + */
> +#if defined(__FreeBSD__) && __STDC_VERSION__ - 0 < 201112L
> +#include <sys/cdefs.h>
> +#ifdef __generic
> +#define __fbsd_generic __generic
> +#endif
> +#undef __generic
> +#endif
>  #include <libgen.h>
> +/* ...continue FreeBSD-specific hack above */
> +#ifdef __fbsd_generic
> +#define __generic __fbsd_generic
> +#undef __fbsd_generic
> +#endif
>  #else
>  #define basename gitbasename
>  char *gitbasename(char *);
