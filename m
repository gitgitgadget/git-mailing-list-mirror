Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEE3C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 06:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjEKG2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 02:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjEKG2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 02:28:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7543C103
        for <git@vger.kernel.org>; Wed, 10 May 2023 23:28:25 -0700 (PDT)
Received: (qmail 21950 invoked by uid 109); 11 May 2023 06:28:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 May 2023 06:28:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7065 invoked by uid 111); 11 May 2023 06:28:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 May 2023 02:28:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 May 2023 02:28:24 -0400
From:   Jeff King <peff@peff.net>
To:     PEEX Gamer <czupux@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unable to cross compile git. http.c generating errors.
Message-ID: <20230511062824.GA1971463@coredump.intra.peff.net>
References: <CALpgS-OQzoopjKd2a3NBkaefHoqR_wLop5x3Y7U8e0eVUO7XJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALpgS-OQzoopjKd2a3NBkaefHoqR_wLop5x3Y7U8e0eVUO7XJQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 06, 2023 at 08:38:40PM +0200, PEEX Gamer wrote:

> I was trying to compile git for x86_64 FreeBSD 13.2 on x86_64 linux
> without any success.
> I was using clang toolchain that worked for native Freebsd 13.2 compilation.
> The errors i had:
> First thing was that config.mak.uname was trying to include sysinfo
> because of host machine being linux which was weird. I ommited this
> error by replacing linux section with freebsd and everythink was
> smooth until http.c which generates output attached in email. 

Looks like you're having problems with fileno() being passed a void
pointer. Try compiling with:

  make FILENO_IS_A_MACRO=Yes

That is generally set automatically on FreeBSD via config.mak.uname;
perhaps you missed it when moving things around there.

I've never tried cross-compiling Git, but I'd guess that your best bet
is to override the uname_* variables, like:

  make uname_S=FreeBSD uname_R=13.2

(there are others, but those are the main ones we use to set defaults
for various Makefile knobs). Of course you can tweak all the Makefile
knobs yourself, but that may be tedious.

-Peff
