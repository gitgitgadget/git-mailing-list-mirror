Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A9C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E8D23A24
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbhAUPgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:36:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:34030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732962AbhAUPfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 10:35:11 -0500
Received: (qmail 5067 invoked by uid 109); 21 Jan 2021 15:34:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 15:34:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2006 invoked by uid 111); 21 Jan 2021 15:34:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 10:34:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 10:34:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAmfAjZYDHoXBevr@coredump.intra.peff.net>
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
 <87lfco801g.fsf@evledraar.gmail.com>
 <YAiKQ0M0/14Q13Ee@coredump.intra.peff.net>
 <874kja8u2i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kja8u2i.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 11:26:13AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > So we are not just saving the client from sending a "want", but making a
> > second full connection to do so. That seems to be an optimization worth
> > continuing to have.
> 
> Correct. Suppose a history COMMIT(TAG) history like:
> 
>     mainline: A(X) -> B(Y) -> C
>     topic:    A(X) -> B(Y) -> D(Z)
> 
> You only want the "mainline" history and its tags in your fetch. Now a
> server will give you tags X & Y for free, ignoring Z.
> 
> The note in protocol-capabilities.txt supposes that you'll need to only
> get A/B/C in one fetch, then do another one where you see from the OIDs
> you have and advertised (peeled) OIDs for the tags and know you just
> need X/Y, not Z.

Right. That note basically indicates that what the server is doing is
"best effort". If it sends you B, it will also send you Y. But it is
ultimately up to the client to decide if they want or need a tag the
server didn't send and do the follow-up.

So include-tag is an optimization, but it works often enough that it
frequently saves the second fetch from happening at all.

> So we could also just fetch Z, then do our own walk on the client to see
> if it's reachable, and throw it away if not. Although I suppose that'll
> need a list of "bad" tags on the client so we don't repeat the process
> the next time around, hrm...

Not only that, but now you've fetched "D" that you never wanted. If it's
one commit, that's not so bad. But it could be pulling in arbitrary
amounts of reachable history that you don't want.

> > You seem to be against auto-following at all. And certainly I can see an
> > argument that it is not worth the trouble it causes. But it is the
> > default behavior, and I suspect many people are relying on it. Fetching
> > every tag indiscriminately is going to grab a bunch of extra unwanted
> > objects in some repos. An obvious case is any time "clone
> > --single-branch --depth" is used.
> 
> I wonder if the use-cases for --depth in the wild aren't 99.9%
> --depth=1, in which case the peeled commit on the main branch being
> advertised by a tag would alredy give you this information.

I'd have thought there was basically no use for anything but --depth=1,
but people seem really enamored with the notion of --depth=50. Many CI
systems use that for some reason.

--depth is just one case where you might not have all of history,
though. Even without it, --single-branch means you wouldn't want to get
the history of all of the other branches. They may only be a few commits
ahead of the main history, in which case fetching extra tags that point
to them might not be a big deal. But it really depends on how your repo
is shaped, what tags point to, etc.

Even without any options, your repo may have a disjoint chunk of history
mentioned by a tag (e.g., a tag pointing to a segment of history that is
meant to be grafted on, or even an archived version of history from
before filter-branch rewrite).

Perhaps if we were designing from scratch we might write those off as
unusual cases we don't need to care about. But I'd be very hesitant to
change the way tag following works now, after so many years. If we were
to make any change, I think one plausible one would be to have clone set
up refspecs to fetch all tags (and then avoid sending include-tag, since
we know we're not auto-following). That would let people still use
auto-follow when they wanted to, but make things simpler to reason
about. And after all, clone already fetches all of the tags.

But I haven't thought too hard about it.

> > Maybe I'm not quite understanding what you're proposing.
> 
> Not much really, just that looking deeper into this area might be a
> useful exercise. I.e. it's a case of server<->client cooperation where
> we offlod the work to one or the other based on an old design decision,
> maybe that trade-off is not optimal in most cases anymore.

I don't think it's very much work on the server, though. Sure, iterating
the tags is O(nr_tags). But we do that iteration lots of other places,
too (the advertisement unless the client asks for a very narrow prefix,
or upload-pack's ref-marking for reachability).

And saving us from sending unwanted objects is a potential win on the
server (even a single unlucky delta where we have to reconstruct and
re-deflate an object will likely blow a ref iteration out of the water).
Likewise, preventing the client from connecting a second time is a win
for the server, which doesn't have to spin up a new upload-pack
(likewise for the client of course; it might even have to prompt the
user for auth again!).

-Peff
