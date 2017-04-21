Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F68207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 20:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162388AbdDUUUC (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 16:20:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:37949 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161533AbdDUUUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 16:20:01 -0400
Received: (qmail 19641 invoked by uid 109); 21 Apr 2017 20:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 20:19:59 +0000
Received: (qmail 19992 invoked by uid 111); 21 Apr 2017 20:20:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 16:20:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 16:19:57 -0400
Date:   Fri, 21 Apr 2017 16:19:57 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
Message-ID: <20170421201957.ztwnyw6mut4b5u53@sigill.intra.peff.net>
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
 <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com>
 <CAM0VKjm=JMuYzsS-OTx+p-vFF8PmWJGbFnndag9dWw6xCe3g6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjm=JMuYzsS-OTx+p-vFF8PmWJGbFnndag9dWw6xCe3g6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 10:14:48PM +0200, SZEDER Gábor wrote:

> >> This is flexible enough for me, but it's possible somebody would want
> >> this on a per-repo basis. I don't know that we want to read from `git
> >> config`, though, because it's relatively expensive to do so. People who
> >> want per-repo settings are probably better off with a hook that triggers
> >> when they "cd" around, and sets up their preferences.
> 
> We could discern between more than just empty vs. non-empty state of
> the environment variable, e.g.:
> 
>   - if empty/unset, then include "DWIM" suggestions.
>   - if set to 'config', then query the 'completion.checkoutNoGuess'
>     configuration variable, and omit "DWIM" suggestions if its true.
>   - if set to something else, then omit "DWIM" suggestions.
> 
> Then users can themselves decide, whether the per-repo configurability
> is worth the overhead of running 'git config'.

Yep, that would work. I wasn't going to bother with that complexity
unless somebody really wanted it. The important thing is not to paint
ourselves into a corner. By the rules you gave above, it would probably
be fine to extend my patch later to match. But we could also be more
specific (e.g., look for some positive value like "1").

> >> +# You can set the following environment variables to influence the behavior of
> >> +# the completion routines:
> >> +#
> >> +#   GIT_COMPLETION_CHECKOUT_NO_GUESS
> 
> That's one long variable name :)
> Of course it has to start with the 'GIT_COMPLETION_' prefix, and you
> can't win from there...

Yeah, I had the same thought. I also considered using "DWIM", which is
the name by which I know the feature. But since "--no-guess" is the
matching option, I went with that.

> >> @@ -1248,7 +1256,8 @@ _git_checkout ()
> >>               # check if --track, --no-track, or --no-guess was specified
> >>               # if so, disable DWIM mode
> >>               local flags="--track --no-track --no-guess" track_opt="--track"
> >> -             if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
> >> +             if [ -n "$GIT_COMPLETION_CHECKOUT_NO_GUESS" -o \
> >> +                  -n "$(__git_find_on_cmdline "$flags")" ]; then
> 
> || would be better than '-o', because the former short-circuits when
> the first condition is true, but the latter doesn't.

Ah, I didn't know that. Usually I use "||", but I thought "-o" was
generally preferred in bash-specific scripts. We definitely want to
short circuit here.

-Peff
