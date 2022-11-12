Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE54C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiKLQre (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 11:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLQrc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 11:47:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7F815827
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 08:47:31 -0800 (PST)
Received: (qmail 5295 invoked by uid 109); 12 Nov 2022 16:47:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 12 Nov 2022 16:47:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21695 invoked by uid 111); 12 Nov 2022 16:47:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 12 Nov 2022 11:47:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 12 Nov 2022 11:47:30 -0500
From:   Jeff King <peff@peff.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify that credential discards unrecognised
 attributes
Message-ID: <Y2/OIrSz+xrqkd+C@coredump.intra.peff.net>
References: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
 <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
 <CAGJzqsmH0DpEZDVZYU=6XpBO_vPfbirrK7KaWm2RmKG3aAk0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsmH0DpEZDVZYU=6XpBO_vPfbirrK7KaWm2RmKG3aAk0oA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 02:21:24AM +0000, M Hickford wrote:

> On Tue, 25 Oct 2022 at 00:59, Jeff King <peff@peff.net> wrote:
> >
> > On Mon, Oct 24, 2022 at 07:57:48AM +0000, M Hickford via GitGitGadget wrote:
> >
> > > It was previously unclear how unrecognised attributes are handled.
> >
> > Yeah, this was always part of the intended behavior, but I agree we did
> > not say it very explicitly (aside from an in-code comment!). Both the
> > intent and content of your patch look good to me.
> 
> Thanks. What happens next? I should look for this change in the seen
> branch? https://git-scm.com/docs/MyFirstContribution#after-approval

Usually the maintainer would pick it up, it would end up in seen, then
eventually 'next', and then eventually 'master'. You can check the
periodic "What's Cooking" messages from the maintainer to see more
discussion of various topic branches.

In this case, though, I don't see any indication that the maintainer
picked saw it. It sometimes happens that a topic is simply overlooked,
even if it received positive reviews.

The usual thing to do is repost it, cc-ing the maintainer. I've also
cc'd the interim maintainer here, so that may get things moving. :)

> > We did discuss patches a long time ago that would let Git carry
> > arbitrary keys between helpers, even if Git itself didn't understand it.
> > One of the intended uses was to let helpers talk to each other about
> > TTLs. So if you had say:
> >
> >   [credential]
> >   helper = generate-some-token
> >   helper = cache
> >
> > where the first helper generates a token, and the second caches it, the
> > first one could shove a "ttl" or "expiration" key into the protocol,
> > which the cache could then learn to respect.
> 
> Composing helpers like this is how I encourage users to configure
> git-credential-oauth [1][2]. Note that the storage helper should come
> *before* the generator, so that `credential fill` finds a stored
> credential before it generates a fresh credential.

Right, it's been a while since I've constructed an example like this. ;)

What you're doing works fine with the code as-is; you just can't carry
extra data (like a ttl) between the two.

The thread I linked earlier also discusses (in the very top-level patch)
a change in behavior that would break the flow you're relying on here
(because it may unexpectedly propagate credentials between helpers). But
I don't think anybody is interested in pursuing that, and it has been 10
years now.

> > But we never merged such a thing, and in practice I think people would
> > just implement both parts as a single helper for simplicity.
> 
> Composing helpers has the advantage that the user can choose their
> preferred storage. Generated credentials aren't necessarily short
> lived. GitHub OAuth tokens, for example, are good for at least one
> year [3].

Yeah, the composability was one of the goals of the system. I just think
in practice that not many people use it. You can also compose outside of
Git (I think the thread I linked earlier has an example of a wrapper
that does so), but again, I don't think anybody really does so in
practice.

I agree for GitHub's tokens that the times involved make auto-expiration
not that important. The example back in that thread was something more
time-limited (like minutes or hours). I don't know how often that kind
of things is in the wild.

-Peff
