Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82E31F461
	for <e@80x24.org>; Sun, 19 May 2019 18:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfESSeI (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 14:34:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:33540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfESSeI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 14:34:08 -0400
Received: (qmail 20800 invoked by uid 109); 19 May 2019 05:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 19 May 2019 05:07:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28044 invoked by uid 111); 19 May 2019 05:08:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 19 May 2019 01:08:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 May 2019 01:07:24 -0400
Date:   Sun, 19 May 2019 01:07:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git ransom campaign incident report - May 2019
Message-ID: <20190519050724.GA26179@sigill.intra.peff.net>
References: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com>
 <8736lfwnks.fsf@evledraar.gmail.com>
 <20190516042739.GH4596@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet>
 <20190517222031.GA17966@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517222031.GA17966@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 06:20:31PM -0400, Jeff King wrote:

> What if we did this:
> 
>   1. Do not ever write the password part of a URL into config.
> 
>   2. When we extract the user/pass out of a URL, put them into the
>      credential struct, so that when we successfully authenticate, we
>      trigger storage. This _might_ actually happen already, but we
>      should definitely confirm it.
> 
>   3. If the user has no credential helper defined, then do one of:
> 
>      a. Warn them that the credential was not recorded, but that they
>         can use "git clone -c credential.helper=store" as a fallback
> 	(but probably worded in a way to recommend using something
> 	stronger if possible).
> 
> 	This is slightly annoying because following the advice requires
> 	re-cloning. Fixing it up from there is more like:
> 
> 	  git config credential.helper store
> 	  git fetch
> 	  [interactively input password]
> 
>      b. Just use credential-store. Optionally notify them of what
>          happened (and that they might want to choose a better helper).

So here are patches to do that. Step 2 is indeed how things work
already, so nothing was needed there (there are still 3 patches because
there was a bit of prep-work ;) ).

I did 3b here: automagically enabling credential-store. I'm still on the
fence on whether that's a good idea or not.

I don't have any data on how many victims of this ransom campaign might
have been helped by this. But it certainly seems like a decent best
practice. I'd hope that _most_ people have moved on to using a
credential helper and supplying the initial password interactively these
days; this is really just aimed at people who don't know better. So the
goal is making them a bit more secure, but also educating them about the
other options. Hopefully without breaking any workflows. :)

-Peff

  [1/3]: transport_anonymize_url(): support retaining username
  [2/3]: clone: avoid storing URL passwords in config
  [3/3]: clone: auto-enable git-credential-store when necessary

 builtin/clone.c            | 37 +++++++++++++++++++++++++++++++++++--
 credential.c               | 13 +++++++++++++
 credential.h               |  6 ++++++
 t/t5550-http-fetch-dumb.sh | 12 ++++++++++++
 transport.c                | 21 ++++++++++++++-------
 transport.h                | 11 ++++++++++-
 6 files changed, 90 insertions(+), 10 deletions(-)
