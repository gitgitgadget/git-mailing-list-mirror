Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F8BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9638F61001
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 21:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhFHV7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:59:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:49624 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234195AbhFHV7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 17:59:37 -0400
Received: (qmail 32425 invoked by uid 109); 8 Jun 2021 21:57:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 21:57:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14995 invoked by uid 111); 8 Jun 2021 21:57:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 17:57:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 17:57:41 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: use starts_with() when checking scissors
Message-ID: <YL/n1b641m+wuVHG@coredump.intra.peff.net>
References: <20190401215334.18678-1-rybak.a.v@gmail.com>
 <20210608204841.2793591-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608204841.2793591-1-rybak.a.v@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 10:48:41PM +0200, Andrei Rybak wrote:

> Existing checks for scissors characters using memcmp(3) never read past
> the end of the line, because all substrings we are interested in are two
> characters long, and the outer loop guarantees we have at least one
> character.  So at most we will look at the NUL.
> 
> However, this is too subtle and may lead to bugs in code which copies
> this behavior without realizing substring length requirement.  So use
> starts_with() instead, which will stop at NUL regardless of the length
> of the prefix.  Remove extra pair of parentheses while we are here.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  mailinfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This patch was originally part of:
> https://public-inbox.org/git/20190401215334.18678-1-rybak.a.v@gmail.com/
> I've finally gotten around to sending it on its own.

Well, after seeing the date I don't feel too bad for not remembering it. :)

I think this is an improvement in safety and readability, and worth
applying. I'd also be fine going further and using skip_prefix(), which
would let us drop the magic-number "2", though:

  - as Junio said in that earlier thread, we hope people aren't
    encouraged to add more versions of scissors here anyway).

  - I am not 100% sure that the increment of "c" in the conditional
    is not also relying on that "2", as well (i.e., it is incrementing
    one, and then the for-loop increments one). There's a non-trivial
    risk of introducing off-by-one errors or even more subtlety here. :)

So I'm OK leaving that. Thanks for resurrecting this cleanup.

-Peff
