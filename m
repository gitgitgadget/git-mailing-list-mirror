Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A66AC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD4664EDB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBZGSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:18:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:45534 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBZGSP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 01:18:15 -0500
Received: (qmail 11902 invoked by uid 109); 26 Feb 2021 06:17:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 06:17:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16455 invoked by uid 111); 26 Feb 2021 06:17:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 01:17:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 01:17:33 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] wrapper: add workaround for open() returning EINTR
Message-ID: <YDiSfXczltBTM+/T@coredump.intra.peff.net>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
 <acb282ee-fc55-bbe0-8272-087bde180ea2@kdbg.org>
 <YDaZtqRvdZWkyQVp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDaZtqRvdZWkyQVp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 01:23:51PM -0500, Jeff King wrote:

> > I'm not so much opposed to "enable it all the time" in general, but when
> > we already have an override of open(), like for the Windows case in
> > compat/mingw.h, I find it a bit rough to put another wrapper around it,
> > even more so since we won't have the EINTR problem on Windows due to the
> > absence of signals.
> 
> That's fair. I don't think my new wrapper would interact well with
> mingw_open(). They are both trying to #define open. I think since mine
> comes later in git-compat-util.h, it is probably overriding mingw_open()
> completely on Windows, which is quite bad (we call into my function in
> wrapper.c, but then its "#undef open" means we get the original open(),
> not the previously defined wrapper).

Thanks again for pointing out mingw_open(). The v2 I posted should avoid
any bad interactions there, even if we do end up enabling it all the
time.

By the way, I did notice something funny when looking at mingw_open().
It unconditionally does:

          va_start(args, oflags);
          mode = va_arg(args, int);
          va_end(args);

no matter what we see in oflags. But callers who are not passing O_CREAT
will not provide a third argument at all. So probably it is loading
random trash from the stack and passing it around in the "mode"
variable. This doesn't hurt anything, because ultimately we pass the
trash along to the real open function, which will ignore it without
O_CREAT. But it is definitely undefined behavior to call va_arg() at all
in this instance.

-Peff
