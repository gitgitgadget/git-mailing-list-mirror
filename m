Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3252C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C436E61929
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhKPMX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:23:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:59948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235531AbhKPMWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:22:48 -0500
Received: (qmail 20063 invoked by uid 109); 16 Nov 2021 12:19:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 12:19:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27975 invoked by uid 111); 16 Nov 2021 12:19:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 07:19:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 07:19:43 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Message-ID: <YZOh370ZMMqSADUE@coredump.intra.peff.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116021241.1565740-2-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 02:12:41AM +0000, brian m. carlson wrote:

> The C99 standard was released in January 1999, now 22 years ago.  It
> provides a variety of useful features, including variadic arguments for
> macros, declarations after statements, variable length arrays, and a
> wide variety of other useful features, many of which we already use.

I like the idea of being able to assume C99. And I know this list is
just "here are some things we could do". But I'd like to express caution
over variable length arrays. We've already had problems with alloca()
causing stack exhaustion, and VLAs are basically the same thing. And the
worst part is there's no way to recover; you just get a segfault.

> Let's add a test balloon to git-compat-util.h to see if anyone is using
> an older compiler.  We'll add a comment telling people how to enable
> this functionality on GCC and Clang, even though modern versions of both
> will automatically do the right thing, and ask people still experiencing
> a problem to report that to us on the list.
> 
> Note that C89 compilers don't provide the __STDC_VERSION__ macro, so we
> use a well-known hack of using "- 0".  On compilers with this macro, it
> doesn't change the value, and on C89 compilers, the macro will be
> replaced with nothing, and our value will be 0.

This part makes sense to me. The macro check will complain if any
compiler isn't C99. But this hunk seems like it is going to cause
headaches:

> diff --git a/Makefile b/Makefile
> index 12be39ac49..893d533d22 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1204,7 +1204,7 @@ endif
>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>  # tweaked by config.* below as well as the command-line, both of
>  # which'll override these defaults.
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O2 -Wall -std=gnu99
>  LDFLAGS =
>  CC_LD_DYNPATH = -Wl,-rpath,
>  BASIC_CFLAGS = -I.

Do most compilers understand -std=gnu99? It seems like we're breaking
the out-of-the-box build for everything that isn't gcc or clang.

I understand that older versions of gcc (prior to 5.1.0, from my
digging) default to gnu89, and so they would be broken _without_ this.
So it is a tradeoff one way or the other. But somehow this seems
backwards to me. We should assume that modern compilers support C99 out
of the box, and put the burden on older ones to trigger C99 support in
whatever non-portable way they need.

I also checked clang, and it looks like it has defaulted to gnu11 since
clang-7 (I'm not sure about clang-6; its documentation wasn't clear).

-Peff
