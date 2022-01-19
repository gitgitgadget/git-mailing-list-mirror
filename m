Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4000C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiASTRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 14:17:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54312 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiASTRM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 14:17:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59F3416FB3A;
        Wed, 19 Jan 2022 14:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oCAlyfzmYWy8
        MebVuWfD3d2RhKdl/0CgKg/wemu3stg=; b=TwtA5bTF4z4/9rS1RZx0e7q6l3Na
        ZitV1tdFmMbDukyz3/dnvvrudYDh1MZ++ADHJr7QaPf04FAR662hOchNBDAAHsGc
        uDm57WxLsTRLOHk+UvmuAKfMUEZLT/L6s5kS01Y+I1DsxLMB0xbRo+qfkhXvHjuB
        BWO5AM+u2Dflzpk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5177E16FB39;
        Wed, 19 Jan 2022 14:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD42916FB35;
        Wed, 19 Jan 2022 14:17:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] cache.h: auto-detect if zlib has uncompress2()
References: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
        <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
Date:   Wed, 19 Jan 2022 11:17:08 -0800
In-Reply-To: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 19 Jan
 2022 10:45:35
        +0100")
Message-ID: <xmqq1r13o7rf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 66061A1A-795C-11EC-A9FA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the NO_UNCOMPRESS2=3DY setting to auto-detect those older zlib
> versions that don't have uncompress2().
>
> This makes the compilation of git less annoying on older systems.
> Since the inclusion of a322920d0bb (Provide zlib's uncompress2 from
> compat/zlib-compat.c, 2021-10-07) in v2.35.0-rc0 our default
> dependency on a zlib 1.2.9 or newer, unless NO_UNCOMPRESS2=3DY is
> specified. This results in new errors when git is compiled on older
> systems, requiring the packager to define NO_UNCOMPRESS2=3DY.
>
> To get around those errors we've needed to bundle config.mak.uname
> changes such as 68d1da41c4e (build: NonStop ships with an older zlib,
> 2022-01-10), and ffb9f298090 (build: centos/RHEL 7 ships with an older
> gcc and zlib, 2022-01-15).
>
> Let's instead rely on ZLIB_VERNUM, as we in zlib.c already for
> NO_DEFLATE_BOUND. See 9da3acfb194 ([PATCH] compat: support pre-1.2
> zlib, 2005-04-30) and 609a2289d76 (Improve accuracy of check for
> presence of deflateBound., 2007-11-07) for that prior art.

> With this change it should be safe to remove the NO_UNCOMPRESS2=3DY
> lines from config.mak.uname, but let's leave them in place for now.

It is not a big deal but I think removing is probably a more
sensible decision.  If ZLIB_VERNUM does not misdetect for them, they
will not be harmed.  And if it does, we'd rather hear from them
about the misdetection.

> Ideally we'd add compat/zlib-uncompress2.o to COMPAT_OBJS, but it's
> being added to our zlib.c instead. This is because we need to look at
> ZLIB_VERNUM to know if we need it. Hoisting that logic over to the
> Makefile would be inconvenient (we'd need shell out to "cc -E" or
> equivalent just to get the macro value). The zlib.c file already has
> the similar deflateBound() compatibility macro added in 9da3acfb194.

I am still unhappy about this part (meaning, I am happier about
everything else, compared to the previous iteration), that zlib.o
becomes mixture of our code and borrowed code.

The COMPAT mechanism have been that compat/foo.o is only compiled
and linked on a platform that lack foo and needs our replacement.
But in this case, I think the best would be to enclose the bulk of
zlib-uncompress2.c file inside a "#if ZLIB_VERNUM < ... #endif"
block and _always_ comiple and link the resulting zlib-uncompress2.o
file.  We probably need to include a throw-away global symbol,
either a variable or a function, that is externally visible but
otherwise unused, to appease compilers linkers that do not want to
deal with an absolutely empty object file on platforms with a
working uncompress2() in their system zlib.

That way, we do not have to touch an unrelated file (zlib.c) for
this, which may be a lot cleaner.

> diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
> index 722610b9718..8592dc3dab5 100644
> --- a/compat/zlib-uncompress2.c
> +++ b/compat/zlib-uncompress2.c
> @@ -8,7 +8,6 @@
> =20
>  */
> =20
> -#include "../reftable/system.h"
>  #define z_const
> =20
>  /*
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 1229c8296b9..0c5e373e917 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1386,6 +1386,13 @@ void unleak_memory(const void *ptr, size_t len);
>  #define UNLEAK(var) do {} while (0)
>  #endif
> =20
> +#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
> +#include <zlib.h>
> +#define GIT_NO_UNCOMPRESS2 1
> +int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
> +		uLong *sourceLen);
> +#endif

It is odd that we did not include <zlib.h> in this file, as the
design goal of git-compat-util.h is to free individual sources from
having to worry about order of inclusion and proprocessor symbols we
need to define before including certain system headers, etc. (for
example, defining z_const before including <zlib.h> would change the
"behaviour" of <zlib.h> header).

We are including <zlib.h> in <cache.h>, way after including the
<git-compat-util.h> file.  I have a feeling that it may become
cleaner (and more correct) if we unconditionally include <zlib.h>
*BEFORE* we check ZLIB_VERNUM here, and lost the inclusion of
<zlib.h> from <cache.h>.  With the posted patch, where are we
getting ZLIB_VERNUM from, which is used to decide if we declare
uncompress2() ourselves here?



