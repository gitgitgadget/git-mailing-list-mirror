Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B374C432BE
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 14:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D69760F6D
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 14:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhHGOke (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 10:40:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:41856 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhHGOkd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 10:40:33 -0400
Received: (qmail 20823 invoked by uid 109); 7 Aug 2021 14:40:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Aug 2021 14:40:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20028 invoked by uid 111); 7 Aug 2021 14:40:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Aug 2021 10:40:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Aug 2021 10:40:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Message-ID: <YQ6bTm6DxeJLhmeA@coredump.intra.peff.net>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com>
 <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
 <875ywiyn4y.fsf@evledraar.gmail.com>
 <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
 <8735rlz5r2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735rlz5r2.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 07, 2021 at 04:26:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > That would probably be better. I would be curious to hear from somebody
> > with a mac if this technique gives more sensible version numbers for the
> > Apple-clang compiler.
> 
> It does, on the gcc304 box on the gccfarm (recent apple M1 Mac Mini):
> 
>     avar@minimac ~ % uname -a
>     Darwin minimac.moose.housegordon.com 20.4.0 Darwin Kernel Version 20.4.0: Thu Apr 22 21:46:41 PDT 2021; root:xnu-7195.101.2~1/RELEASE_ARM64_T8101 arm64    
>     avar@minimac ~ % clang --version
>     Apple clang version 12.0.5 (clang-1205.0.22.9)
>     Target: arm64-apple-darwin20.4.0
>     Thread model: posix
>     InstalledDir: /Library/Developer/CommandLineTools/usr/bin
> 
>     avar@minimac ~ % cat >f  
>     GNUC=__GNUC__
>     GNUC_MINOR=__GNUC_MINOR__
>     GNUC_PATCHLEVEL=__GNUC_PATCHLEVEL__
>     clang=__clang__
>     clang_major=__clang_major__
>     clang_minor=__clang_minor__
>     clang_patchlevel=__clang_patchlevel__
>     
>     ^C
> 
>     avar@minimac ~ % clang -E - <f
>     # 1 "<stdin>"
>     # 1 "<built-in>" 1
>     # 1 "<built-in>" 3
>     # 384 "<built-in>" 3
>     # 1 "<command line>" 1
>     # 1 "<built-in>" 2
>     # 1 "<stdin>" 2
>     GNUC=4
>     GNUC_MINOR=2
>     GNUC_PATCHLEVEL=1
>     clang=1
>     clang_major=12
>     clang_minor=0
>     clang_patchlevel=5

Hmm, now I'm really confused, though. Is that really clang 12 (for which
there is no 12.0.5; 12.0.1 is the latest version, shipped in July)? Or
is it XCode 12, shipping with LLVM 11, according to the table in:

  https://en.wikipedia.org/wiki/Xcode#Xcode_11.x_-_13.x_(since_SwiftUI_framework)

(sorry, there are actually _two_ tables with that same anchor on the
page; the one you want is the second one, under "Toolchain versions").

The distinction does not matter for our script (where we only care about
"clang4" and up). I guess the most relevant test would be to get XCode
8.x and see what it says. I expect it to claim "clang 8.1.0" or similar,
but actually be clang-3. And therefore not support
-Wtautological-constant-out-of-range-compare.

If we can't get easily get hold of such a platform, then maybe that is a
good indication that this conversation is too academic for now, and we
should wait until somebody wants to add a more recent version-specifier
to config.mak.dev. ;)

-Peff
