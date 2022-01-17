Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6628C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiAQS1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:27:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59408 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiAQS1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:27:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 317B0186A35;
        Mon, 17 Jan 2022 13:27:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4ERyCZUgYio6
        +Z7MEGeIFbHleQfGyGxPyaX6aT449AY=; b=AiD+bXfK5Oy7BPvb4pCHxTVlUHWE
        B+o2HOc5AzGHPn/I/8KT7PqOGFEhchQaGlxIQV5G9abp0PYHhrX0K+DGECfwMrU9
        zdCMoAxg+hj74oH9OBB9ohnmMd0+E2k8FjRHMrsrqEl/oO/sC4Jb3pAdbUe2R/aI
        /z+pQs+xaM5ocYU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 296EF186A34;
        Mon, 17 Jan 2022 13:27:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 96835186A33;
        Mon, 17 Jan 2022 13:27:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] cache.h: auto-detect if zlib has uncompress2()
References: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
Date:   Mon, 17 Jan 2022 10:27:45 -0800
In-Reply-To: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 17 Jan
 2022 18:13:42 +0100")
Message-ID: <xmqq7dayw732.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2B0E237A-77C3-11EC-A2CC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 5580859afdb..3e90820bbfd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -256,7 +256,10 @@ all::
>  #
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
> -# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
> +# Define NO_UNCOMPRESS2 if your zlib is older than v1.2.9 and does not
> +# have uncompress2. You should not need to define this unless your
> +# zlib's ZLIB_VERNUM is broken. We'll auto-detect this on the basis of
> +# that macro.

If their ZLIB_VERNUM is broken, and their library lacks
uncompress2() but ZLIB_VERNUM makes us think they do, then thanks to

> +#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290

in <cache.h>, we would use our own, and everybody is happy.

If their library does have uncompress2() but ZLIB_VERNUM makes us
think they don't, there is no way to correct for that, is there?

With or without NO_UNCOMPRESS2 defined, ZLIB_VERNUM that is broken
will lead us to redefine and override uncompress2().  Which is not
the end of the world as the linker should know what to do, but then
what we'd end up with is a more brittle alternative to always using
our own replacement, which is not satisfactory, either.

> @@ -1728,7 +1731,6 @@ endif
> =20
>  ifdef NO_UNCOMPRESS2
>  	BASIC_CFLAGS +=3D -DNO_UNCOMPRESS2
> -	REFTABLE_OBJS +=3D compat/zlib-uncompress2.o

I very much like this; with or without auto detection, this "compat"
thinkg should have been in LIB_OBJS from day one---there is no
reason to expect reftable will remain to be the only user of the
uncompress2() function (it should be part of COMPAT_OBJS).

> diff --git a/cache.h b/cache.h
> index 281f00ab1b1..02b355fcf08 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -29,6 +29,11 @@ typedef struct git_zstream {
>  	unsigned char *next_out;
>  } git_zstream;
> =20
> +#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
> +#define GIT_NO_UNCOMPRESS2 1
> +int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
> +		uLong *sourceLen);
> +#endif

I mentioned the other side of the coin already.  <git-compat-util.h>
would be a better home for this change.  I do not think <cache.h> is
the right place to do this (notice the zstream things around this
area are all about _our_ invention and _our_ use pattern).

>  void git_inflate_init(git_zstream *);
>  void git_inflate_init_gzip_only(git_zstream *);
>  void git_inflate_end(git_zstream *);


> diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
> index 722610b9718..915796e85ac 100644
> --- a/compat/zlib-uncompress2.c
> +++ b/compat/zlib-uncompress2.c
> @@ -8,15 +8,12 @@
> =20
>  */
> =20
> -#include "../reftable/system.h"

Again, I very much in favor of this lossage, as compat/ that depends
on reftable feels backwards.

> -#define z_const

OK, the reason why we lose this is because we do not include the
<zlib.h> header from here [*].

	Side note: it is a way to tell <zlib.h> that whenever they
	say z_const (because they know the thing is not modified),
	we do not want to use "const".

>  /*
>   * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Ad=
ler
>   * For conditions of distribution and use, see copyright notice in zli=
b.h
>   */
> =20
> -#include <zlib.h>
> +/* No "#include <zlib.h>", done in cache.h */

So, if we lose this include, we should lose #define z_const", too.

> diff --git a/config.mak.uname b/config.mak.uname

Losing these, and more importantly, not having to worry about
maintaining, is refreshing ;-)

> diff --git a/reftable/block.c b/reftable/block.c
> index 855e3f5c947..946edd0f34e 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
>  #include "record.h"
>  #include "reftable-error.h"
>  #include "system.h"
> -#include <zlib.h>
> +#include "zlib.h"

I do not think this is warranted.

Isn't it that using "<header.h>" with "-I<location>" a more
language-laywers kosher way to include even our headers than using
double-quotes (which is implementation-defined) anyway?  Going the
other direction needs to be seriously justified.

If the upstream author wants to differentiate <a-system-header.h>
and "our-header.h", let them do so [*].

	Side note: even though my personal preference is to use <>
	consistently, that is not project preference.  And use of ""
	over <> is even less.

> diff --git a/reftable/system.h b/reftable/system.h
> index 4907306c0c5..2cebbc94d4d 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -15,17 +15,7 @@ license that can be found in the LICENSE file or at
>  #include "strbuf.h"
>  #include "hash.h" /* hash ID, sizes.*/
>  #include "dir.h" /* remove_dir_recursively, for tests.*/
> -
> -#include <zlib.h>
> -
> -#ifdef NO_UNCOMPRESS2
> -/*
> - * This is uncompress2, which is only available in zlib >=3D 1.2.9
> - * (released as of early 2017)
> - */
> -int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
> -		uLong *sourceLen);
> -#endif
> +#include "zlib.h"

Likewise.

> diff --git a/zlib.c b/zlib.c
> index d594cba3fc9..d9440dfb784 100644
> --- a/zlib.c
> +++ b/zlib.c
> @@ -3,6 +3,9 @@
>   * at init time.
>   */
>  #include "cache.h"
> +#ifdef GIT_NO_UNCOMPRESS2
> +#include "compat/zlib-uncompress2.c"
> +#endif

I am not sure if this is a good place to add it.  Everything in this
file is _ours_, and zlib.o is on LIB_OBJS because it is all _ours_.

I agree that it is a convenient place to hook into, though.

I like the basic idea of the patch, but I am afraid that it is way
too late in the cycle.  I would unconditionally be happy to see a
change like this one as part of an earliest batch after the release,
but there isn't enough in here to convince me that it is safe enough
or urgent enough to be in the upcoming release.
