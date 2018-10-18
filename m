Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A690E1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 17:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeJSBLa (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 21:11:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:44976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727391AbeJSBLa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 21:11:30 -0400
Received: (qmail 18439 invoked by uid 109); 18 Oct 2018 17:09:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Oct 2018 17:09:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32213 invoked by uid 111); 18 Oct 2018 17:08:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Oct 2018 13:08:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2018 13:09:34 -0400
Date:   Thu, 18 Oct 2018 13:09:34 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] config.mak.dev: enable -Wunused-function
Message-ID: <20181018170934.GA21138@sigill.intra.peff.net>
References: <20181018070522.GA29499@sigill.intra.peff.net>
 <CACsJy8BOL+QOb3Vdh8RKbra-DDbJVyznTbCJgjK5h8L2y0H7yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BOL+QOb3Vdh8RKbra-DDbJVyznTbCJgjK5h8L2y0H7yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 05:48:16PM +0200, Duy Nguyen wrote:

> >   - conditional compilation, where we may or may not need a
> >     static helper. These generally fall into one of two
> >     categories:
> >
> >       - the call should not be conditional, but rather the
> >         function body itself should be (and may just be a
> >         no-op on one side of the #if). That keeps the
> >         conditional pollution out of the main code.
> >
> >       - call-chains of static helpers should all be in the
> >         same #if block, so they are all-or-nothing
> 
> Grouping is not always desired because it could break better function
> layout. Have a look at read-cache.c where _ieot_extension functions
> are #if'd because the only call sites are from pthread code (#if'd far
> away).

True, though as long as they are triggered by the same set of #if
conditions, that is fine. Putting them in the same block  is just an
easy way to make sure that is the case. ;)

> In this particular case though I think we should be able to avoid so
> much #if if we make a wrapper for pthread api that would return an
> error or something when pthread is not available. But similar
> situation may happen elsewhere too.

Yeah, I think that is generally the preferred method anyway, just
because of readability and simplicity.

> Having said that, if people do consider MAYBE_UNUSED before #if'ing
> everywhere (and opening up more conditional build problems in future),
> I think this change is fine.

I'd like to use it as a last resort, certainly. Mostly the fact that we
compile cleanly _now_ makes me think that it probably won't be that hard
to keep it going.

I think the biggest potential problem with this is going to be obscure
configurations where some functions are used or not used. So somebody
silencing a compiler warning may inadvertently break another case if
they're not careful. But that's already a problem to some degree (and
part of why we try to push the conditionality out to the whole-function
level).

-Peff
