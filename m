Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10CE220899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbdHNW3v (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:29:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:38578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753022AbdHNW3t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:29:49 -0400
Received: (qmail 28317 invoked by uid 109); 14 Aug 2017 22:29:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 22:29:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6468 invoked by uid 111); 14 Aug 2017 22:30:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 18:30:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 18:29:47 -0400
Date:   Mon, 14 Aug 2017 18:29:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while
 generating patches
Message-ID: <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170810183256.12668-2-kewillf@microsoft.com>
 <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
 <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
 <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
 <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
 <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
 <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 11:35:33AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Perhaps we may want to replace the calls to progress_delay() with a
> > call to a simpler wrapper that does not let the callers give their
> > own delay threashold to simplify the API.
> 
> ... which does not look too bad, but because it makes me wonder if
> we even need to make the delay-threshold customizable per callers,
> I'll wait further discussions before committing to the approach.

For what it's worth, I had a similar "why is this even part of the API"
thought when writing earlier in the thread.

> For example, I do not quite understand why 95 is a good value for
> prune-packed while 0 is a good value for prune.

And I also wondered this same thing. I do not have a good answer.

> The rename detection in diffcore-rename, delay in blame, and
> checkout (via unpack-trees) all of which use 50-percent threshold
> with 1 second delay, sort of make sense to me in that if we
> completed 50 percent within 1 second, it is likely we will finish
> all in 2 seconds (which is the norm for everybody else), perhaps as
> a better version of 0-percent 2 seconds rule.

Just thinking what could go wrong for a moment.

If we reach 51% in one second, would we then never show progress? That
seems like a misfeature when the counter is spiky. E.g., consider
something like object transfer (which doesn't do a delayed progress, but
pretend for a moment as it makes a simple example). Imagine we have 100
objects, 99 of which are 10KB and one of which is 100MB. And that the
big object comes at slot 75.

No matter how the delay works, the counter is going to jump quickly to
75% as we send the small objects, and then appear to stall on the large
one. That's unavoidable without feeding the progress code more data
about the items. But what does the user see?

With (0,2), we start the progress meter at 2 seconds, the user sees it
stall at 75%, and then eventually it unclogs.

With (50,1), we check the percentage after 1 second and see we are
already at 75%. We then disable the meter totally. After 2 seconds, we
get the same stall but the user sees nothing.

So in that case we should always base our decision only on time taken.

And that gives me an answer for your question above: the difference is
whether we expect the counter to move smoothly, or to be spiky.

If it's smooth, the (50,1) case is slightly nicer in that it puts the
progress in front of the user more quickly. I'm not sure if that's
actually worth pushing an additional decision onto the person writing
the calling code, though (especially when we are just now puzzling out
the method for making such a decision from first principles).

So I'd vote to drop that parameter entirely. And if 1 second seems
noticeably snappier, then we should probably just move everything to a 1
second delay (I don't have a strong feeling either way).

-Peff
