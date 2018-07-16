Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087A41F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeGPUKb (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:10:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:48294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728290AbeGPUKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:10:31 -0400
Received: (qmail 11752 invoked by uid 109); 16 Jul 2018 19:41:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 19:41:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14783 invoked by uid 111); 16 Jul 2018 19:41:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 15:41:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 15:41:36 -0400
Date:   Mon, 16 Jul 2018 15:41:36 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716194136.GA25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716190949.GB11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 12:09:49PM -0700, Jonathan Nieder wrote:

> >>> So while I completely agree that it's not a great thing to encourage
> >>> users to blindly run "git prune", I think it _is_ actionable.
> >>
> >> To flesh this out a little more: what user action do you suggest?  Could
> >> we carry out that action automatically?
> >
> > Er, the action is to run "git prune", like the warning says. :)
> 
> I don't think we want to recommend that, especially when "git gc --auto"
> does the right thing automatically.

But that's the point. This warning is written literally after running
"git gc --auto" _didn't_ do the right thing. Yes, it would be nicer if
it could do the right thing. But it doesn't yet know how to.

See the thread I linked earlier on putting unreachable objects into a
pack, which I think is the real solution.

> > The warning that is deleted by this patch is: you _just_ ran gc, and hey
> > we even did it automatically for you, but we're still in a funky state
> > afterwards. You might need to clean up this state.
> 
> This sounds awful.  It sounds to me like you're saying "git gc --auto"
> is saying "I just did the wrong thing, and here is how you can clean
> up after me".  That's not how I want a program to behave.

Sure, it would be nice if it did the right thing. Nobody has written
that yet. Until they do, we have to deal with the fallout.

> > If you do that without anything further, then it will break the
> > protection against repeatedly running auto-gc, as I described in the
> > previous email.
> 
> Do you mean ratelimiting for the message, or do you actually mean
> repeatedly running auto-gc itself?
> 
> If we suppress warnings, there would still be a gc.log while "git gc
> --auto" is running, just as though there had been no warnings at all.
> I believe this is close to the intended behavior; it's the same as
> what you'd get without daemon mode, except that you lose the warning.

I mean that if you do not write a persistent log, then "gc --auto" will
do an unproductive gc every time it is invoked. I.e., it will see "oh,
there are too many loose objects", and then waste a bunch of CPU every
time you commit.

> > Any of those would work similarly to the "just detect warnings" I
> > suggested earlier, with respect to keeping the "1 day" expiration
> > intact, so I'd be OK with them. In theory they'd be more robust than
> > scraping the "warning:" prefix. But in practice, I think you have to
> > resort to scraping anyway, if you are interested in treating warnings
> > from sub-processes the same way.
> 
> Can you say more about this for me?  I am not understanding what
> you're saying necessitates scraping the output.  I would strongly
> prefer to avoid scraping the output.

A daemonized git-gc runs a bunch of sub-commands (e.g., "git prune")
with their stderr redirected into the logfile. If you want to have
warnings go somewhere else, then either:

  - you need some way to tell those sub-commands to send the warnings
    elsewhere (i.e., _not_ stderr)

    or

  - you have to post-process the output they send to separate warnings
    from other errors. Right now that means scraping. If you are
    proposing a system of machine-readable output, it would need to work
    not just for git-gc, but for every sub-command it runs.

-Peff
