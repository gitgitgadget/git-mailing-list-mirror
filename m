Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55A21F404
	for <e@80x24.org>; Wed,  4 Apr 2018 19:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeDDTRB (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 15:17:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751482AbeDDTQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 15:16:59 -0400
Received: (qmail 18066 invoked by uid 109); 4 Apr 2018 19:16:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 19:16:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7324 invoked by uid 111); 4 Apr 2018 19:18:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 15:18:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 15:16:57 -0400
Date:   Wed, 4 Apr 2018 15:16:57 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@gmail.com, larsxschneider@gmail.com,
        bmwill@google.com
Subject: Re: [PATCH 7/6] ref-filter: use generation number for --contains
Message-ID: <20180404191657.GA13543@sigill.intra.peff.net>
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404182242.GA9055@sigill.intra.peff.net>
 <1cc07683-8d2e-e9fa-ffee-2663057704be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cc07683-8d2e-e9fa-ffee-2663057704be@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 03:06:26PM -0400, Derrick Stolee wrote:

> > > @@ -1615,8 +1619,20 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
> > >   					      struct contains_cache *cache)
> > >   {
> > >   	struct contains_stack contains_stack = { 0, 0, NULL };
> > > -	enum contains_result result = contains_test(candidate, want, cache);
> > > +	enum contains_result result;
> > > +	uint32_t cutoff = GENERATION_NUMBER_UNDEF;
> > > +	const struct commit_list *p;
> > > +
> > > +	for (p = want; p; p = p->next) {
> > > +		struct commit *c = p->item;
> > > +		parse_commit_or_die(c);
> > > +		if (c->generation < cutoff)
> > > +			cutoff = c->generation;
> > > +	}
> 
> Now that you mention it, let me split out the portion you are probably
> talking about as incorrect:
> 
> > > +	if (cutoff == GENERATION_NUMBER_UNDEF)
> > > +		cutoff = GENERATION_NUMBER_NONE;
> 
> You're right, we don't want this. Since GENERATION_NUMBER_NONE == 0, we get
> no benefit from this. If we keep it GENERATION_NUMBER_UNDEF, then our walk
> will be limited to commits NOT in the commit-graph (which we hope is small
> if proper hygiene is followed).

I think it's more than that. If we leave it at UNDEF, that's wrong,
because contains_test() compares:

  candidate->generation < cutoff

which would _always_ be true. In other words, we're saying that our
"want" has an insanely high generation number, and traversing can never
find it. Which is clearly wrong.

So we have to put it at "0", to say "you should always traverse, we
can't tell you that this is a dead end". So that part of the logic is
currently correct.

But what I was getting at is that the loop behavior can't just pick the
min cutoff. The min is effectively "0" if there's even a single ref for
which we don't have a generation number, because we cannot ever stop
traversing (we might get to that commit if we kept going).

(It's also possible I'm confused about how UNDEF and NONE are used; I'm
assuming commits for which we don't have a generation number available
would get UNDEF in their commit->generation field).

If you could make the assumption that when we have a generation for
commit X, then we have a generation for all of its ancestors, things get
easier. Because then if you hit commit X with a generation number and
want to compare it to a cutoff, you know that either:

  1. The cutoff is defined, in which case you can stop traversing if
     we've gone past the cutoff.

  2. The cutoff is undefined, in which case we cannot possibly reach
     our "want" by traversing. Even if it has a smaller generation
     number than us, it's on an unrelated line of development.

I don't know that the reachability property is explicitly promised by
your work, but it seems like it would be a natural fallout (after all,
you have to know the generation of each ancestor in order to compute the
later ones, so you're really just promising that you've actually stored
all the ones you've computed).

> > I wonder to what degree it's worth traversing to come up with a
> > generation number for the "want" commits. If we walked, say, 50 commits
> > to do it, you'd probably save a lot of work (since the alternative is
> > walking thousands of commits until you realize that some ancient "v1.0"
> > tag is not useful).
> > 
> > I'd actually go so far as to say that any amount of traversal is
> > generally going to be worth it to come up with the correct generation
> > cutoff here. You can come up with pathological cases where you only have
> > one really recent tag or something, but in practice every repository
> > where performance is a concern is going to end up with refs much further
> > back than it would take to reach the cutoff condition.
> 
> Perhaps there is some value in walking to find the correct cutoff value, but
> it is difficult to determine how far we are from commits with correct
> generation numbers _a priori_. I'd rather rely on the commit-graph being in
> a good state, not too far behind the refs. An added complexity of computing
> generation numbers dynamically is that we would need to add a dependence on
> the commit-graph file's existence at all.

If you could make the reachability assumption, I think this question
just goes away. As soon as you hit a commit with _any_ generation
number, you could quit traversing down that path.

-Peff
