Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAF1C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F1064E6B
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhBXSYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:24:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:43294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhBXSYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 13:24:33 -0500
Received: (qmail 863 invoked by uid 109); 24 Feb 2021 18:23:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 18:23:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16227 invoked by uid 111); 24 Feb 2021 18:23:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Feb 2021 13:23:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Feb 2021 13:23:50 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] wrapper: add workaround for open() returning EINTR
Message-ID: <YDaZtqRvdZWkyQVp@coredump.intra.peff.net>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
 <acb282ee-fc55-bbe0-8272-087bde180ea2@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acb282ee-fc55-bbe0-8272-087bde180ea2@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 08:20:57AM +0100, Johannes Sixt wrote:

> Am 24.02.21 um 05:43 schrieb Jeff King:
> > The workaround here is enabled all the time, without a Makefile knob,
> > since it's a complete noop if open() never returns EINTR. I did push it
> > into its own compat/ source file, though, since it has to #undef our
> > macro redirection. Putting it in a file with other code risks confusion
> > if more code is added after that #undef.
> 
> I'm not so much opposed to "enable it all the time" in general, but when
> we already have an override of open(), like for the Windows case in
> compat/mingw.h, I find it a bit rough to put another wrapper around it,
> even more so since we won't have the EINTR problem on Windows due to the
> absence of signals.

That's fair. I don't think my new wrapper would interact well with
mingw_open(). They are both trying to #define open. I think since mine
comes later in git-compat-util.h, it is probably overriding mingw_open()
completely on Windows, which is quite bad (we call into my function in
wrapper.c, but then its "#undef open" means we get the original open(),
not the previously defined wrapper).

-Peff
