Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9BAC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAFF61BFE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhKQDVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:21:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:60748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhKQDVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:21:16 -0500
Received: (qmail 21888 invoked by uid 109); 17 Nov 2021 03:18:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Nov 2021 03:18:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6788 invoked by uid 111); 17 Nov 2021 03:18:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 22:18:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 22:18:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix parallel build race
Message-ID: <YZR0djZbRUicXcQm@coredump.intra.peff.net>
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 08:25:55AM +0700, Đoàn Trần Công Danh wrote:

> * builtin/bugreport.c includes hook-list.h, hence generated files from
> it must depend on hook-list.h

Good catch. This is trivially reproducible with:

  make clean
  make builtin/bugreport.o

The problem comes from cfe853e66b (hook-list.h: add a generated list of
hooks, like config-list.h, 2021-09-26), as you might expect.

> diff --git a/Makefile b/Makefile
> index 241dc322c0..413503b488 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2222,6 +2222,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>  
>  help.sp help.s help.o: command-list.h
>  hook.sp hook.s hook.o: hook-list.h
> +builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h

This fix looks correct. I grepped for other similar cases, but this is
the only file that needs it.

Curiously, the existing hook.c does not seem to include hook-list.h,
even though you can see a dependency in the context above. Nor does
help.c, which gained a similar dependency in cfe853e66b. Those seem
superfluous, but maybe I'm missing something.

I wondered if contrib/buildsystems/CMakeLists would need a similar
fixup, but it doesn't have any generated header dependencies at all (not
for hook-list.h, but not for the existing command-list.h). So I'll
assume it's fine (as did cfe853e66b).

-Peff
