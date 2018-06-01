Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF321F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 05:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbeFAFar (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 01:30:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750795AbeFAFar (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 01:30:47 -0400
Received: (qmail 8857 invoked by uid 109); 1 Jun 2018 05:30:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Jun 2018 05:30:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21148 invoked by uid 111); 1 Jun 2018 05:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 01:30:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 01:30:44 -0400
Date:   Fri, 1 Jun 2018 01:30:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 4/4] color.ui config: add "isatty" setting
Message-ID: <20180601053044.GA8292@sigill.intra.peff.net>
References: <20180530210641.19771-1-avarab@gmail.com>
 <20180530210641.19771-5-avarab@gmail.com>
 <20180531053810.GD17068@sigill.intra.peff.net>
 <874liofgv6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874liofgv6.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 09:01:49AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Is there some case where a pager can only handle color if _it's_ output
> > is going to a tty, and otherwise not?
> 
> Maybe I'm missing something but how is that something we can deal with?
> We just:
> 
>  1. use isatty() to see if we're attached to a terminal
>  2a. If yes and no pager is invoked (e.g. git status) and "auto" we use colors
>  2b. If yes and we're invoking a pager (e.g. git log) and "auto" we use colors
>      3b. At this point we're writing to the pager so isatty() is false,
>          but we set our own GIT_PAGER_IN_USE and turn on colors if "auto"
> 
> I suppose we can imagine a pager that sometimes emits to a terminal and
> sometimes e.g. opens a browser with the output, and we could ourselves
> somehow detect this...

I was imagining something where we remembered the original isatty()
value (from before the pager) and then reacted to that. But no, I don't
actually have a use case there. I was trying to think through possible
reasons to want this "isatty" version of color.ui.

> As noted in the cover letter I started writing this whole thing before
> understanding some of the subtleties, and now I think this "isatty"
> thing is probably pretty useless, and was wondering if others wanted it.

OK, I agree that it doesn't seem all that useful.

> Reasons to take it are:
> 
>  1) To make user intent clearer. I.e. we could just also make it a
>     synonym for color.ui=auto & color.pager=false and those used to
>     isatty semantics skimming the docs would more easily find the right
>     thing.

I'd much prefer just having a documentation patch that uses the word
"isatty", if that's something we think a user might search for (which
seems plausible to me).

>  2) If there are any cases where isatty() is true, but we can detect via
>     other means (e.g. inspecting other env variables) that non-pager
>     output can't handle colors some of the time. Of course if we find
>     such cases isatty() would suck more, but that's presumably what
>     isatty() purists want :)

Yeah, I think we can punt on that until such an "other means" comes
along.

-Peff
