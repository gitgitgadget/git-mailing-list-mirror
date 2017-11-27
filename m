Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2968D20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 22:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbdK0WuY (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 17:50:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:41882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751771AbdK0WuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 17:50:23 -0500
Received: (qmail 13220 invoked by uid 109); 27 Nov 2017 22:50:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 22:50:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6964 invoked by uid 111); 27 Nov 2017 22:50:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 17:50:40 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 17:50:21 -0500
Date:   Mon, 27 Nov 2017 17:50:21 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171127225020.GA29384@sigill.intra.peff.net>
References: <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
 <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
 <20171127044314.GA6236@sigill>
 <20171127205731.GB27469@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171127205731.GB27469@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 12:57:31PM -0800, Jonathan Nieder wrote:

> > I actually consider "--no-optional-locks" to be such an aspirational
> > feature. I didn't go digging for other cases (though I'm fairly certain
> > that "diff" has one), but hoped to leave it for further bug reports ("I
> > used the option, ran command X, and saw lock contention").
> 
> I am worried that the project is not learning from what happened here.
> 
> My main issue with the --no-optional-locks name is that it does not
> connect to the underlying user need.  Your main argument for it is
> that it exactly describes the underlying user need.  One of us has to
> be wrong.

Or there's a false dichotomy. ;) We could be talking about two different
users.

> So let me describe my naive reading:
> 
> As a user, I want to inspect the state of the repository without
> disrupting it in any way.  That means not breaking concurrent
> processes and not upsetting permissions.  --read-only seems to
> describe this use case to me perfectly.

That does not match the request that I got from real script writers who
were having a problem. They wanted to avoid lock contention with
background tasks.  They don't care if the repository is modified as long
as it is done in a safe and non-conflicting way.

I agree (as I think I've said already in this thread) that --read-only
would be a superset of that. And that it would probably be OK to have
just gone there in the first place, sacrificing a small amount of
specificity in the name of having fewer knobs for the user to turn.

> If I understood correctly, your objection is that --read-only is not
> specific enough.  What I really want, you might say, is not to break
> concurrent processes.  Any other aspects of being read-only are not
> relevant.  E.g. if I can refresh the on-disk index using O_APPEND
> without disrupting concurrent processes then I should be satisfied
> with that.

Do I have an objection? It's not clear to me that anybody is actually
proposing anything concrete for me to object to.

Are we adding "--read-only"? Are we going back to "status
--no-lock-index"? In either case, are we deprecating
"--no-optional-locks"?

It sounds like you are arguing for the first, and it sounds like Dscho
is arguing for the second. Frankly, I don't really care that much. I've
said all that I can on why I chose the direction I did, and I remain
unconvinced that we have evidence that the current option is somehow
impossible to find. If somebody wants to take us down one of the other
roads, that's fine by me.

> Fair enough, though that feels like overengineering.  But I *still*
> don't see what that has to do with the name "no-optional-locks".  When
> is a lock *optional*?  And how am I supposed to discover this option?

I kind of feel like any answer I give to these questions is just going
to be waved aside. But here are my earnest answers:

  1. You are bit by lock contention, where running operation X ends up
     with some error like "unable to create index.lock: file exists".
     "X" is probably something like "commit".

  2. You search the documentation for options related to locks. You're
     not likely to find it in the manpage for X, since the root of the
     problem actually has nothing to do with X in the first place. It's
     a background task running "status" that is the problem.

  3. You might find it in git(1) while searching for information on
     locks, since "lock" is in the name of the option (and is in fact
     the only hit in that page). The index is also mentioned there
     (though searching for "index" yields a lot more hits).

  4. You might find it in git-status(1) if you suspect that "status" is
     at work. Searching for "index" or "lock" turns up the addition I
     just proposed yesterday.

There are obviously a lot of places where that sequence might fail to
find a hit. But the same is true of just about any option, including
putting "--read-only" into git(1).

> This also came up during review, and I am worried that this review
> feedback is being ignored.  In other words, I have no reason to
> believe it won't happen again.

I'm having a hard time figuring out what you mean here. Do you mean that
I ignored feedback on this topic during the initial review?

Looking at the original thread, I just don't see it. There was some
question about the name. I tried to lay out my thinking here:

  https://public-inbox.org/git/20170921050835.mrbgx2zryy3jusdk@sigill.intra.peff.net/

and ended with:

  I am open to a better name, but I could not come up with one.

There was no meaningful response on the topic. When I reposted v2, I
tried to bring attention to that with:

    - there was some discussion over the name. I didn't see other
      suggestions, and I didn't come up with anything better.

So...am I missing something? Am I misunderstanding your point?

> > I would be fine with having a further aspirational "read only" mode.
> 
> Excellent, we seem to agree on this much.  If I can find time for it
> today then I'll write a patch.

Great.

-Peff
