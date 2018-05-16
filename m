Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A581F406
	for <e@80x24.org>; Wed, 16 May 2018 20:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeEPURi (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 16:17:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:43464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750953AbeEPURh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 16:17:37 -0400
Received: (qmail 17818 invoked by uid 109); 16 May 2018 20:17:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 May 2018 20:17:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26690 invoked by uid 111); 16 May 2018 20:17:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 16 May 2018 16:17:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2018 13:17:28 -0700
Date:   Wed, 16 May 2018 13:17:28 -0700
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Martin Fick <mfick@codeaurora.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180516201727.GD4036@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net>
 <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
 <20180516193744.GA4036@sigill.intra.peff.net>
 <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 04:02:53PM -0400, Konstantin Ryabitsev wrote:

> On 05/16/18 15:37, Jeff King wrote:
> > Yes, that's pretty close to what we do at GitHub. Before doing any
> > repacking in the mother repo, we actually do the equivalent of:
> > 
> >   git fetch --prune ../$id.git +refs/*:refs/remotes/$id/*
> >   git repack -Adl
> > 
> > from each child to pick up any new objects to de-duplicate (our "mother"
> > repos are not real repos at all, but just big shared-object stores).
> 
> Yes, I keep thinking of doing the same, too -- instead of using
> torvalds/linux.git for alternates, have an internal repo where objects
> from all forks are stored. This conversation may finally give me the
> shove I've been needing to poke at this. :)
> 
> Is your delta-islands patch heading into upstream, or is that something
> that's going to remain external?

I have vague plans to submit it upstream, but I'm still not convinced
it's quite optimal. The resulting packs tend to be a fair bit larger
than they could be when packed by themselves, because we miss many delta
opportunities (and it's important to "repack -f --window=250" once in a
while, since we're throwing away so many delta candidates).

There's an alternative way of doing it, too, which I think git.or.cz
uses: it "layers" forks in a hierarchy. So if I fork torvalds/linux.git,
then I get my own repo that uses torvalds/linux as an alternate. And if
somebody forks my repo, then I'm their alternate, and they recursively
depend on torvalds/linux. So each fork basically layers a slice of its
own pack on top of the parent.

This is all from recollections of past discussions (which were sadly not
on the list -- I don't know if they've written up their scheme anywhere
public), so I may have some details wrong. But I think that their
repacking is done hierarchically, too: any objects which the root fork
might drop get migrated up to the children instead, and so forth, until
the leaf nodes can actually throw away objects.

The big problem with this is that Git tends to behave better when
objects are in the same pack:

  1. We don't bother looking for new deltas within the same pack,
     whereas a clone of a fork may actually try to find new deltas
     between the layers.

  2. Reachability bitmaps can't cross pack boundaries (due to the way
     they're implemented, but also the current on-disk format). So you
     can only bitmap the root repo, not any of the other layers.

> I feel like a whitepaper on "how we deal with bajillions of forks at
> GitHub" would be nice. :) I was previously told that it's unlikely such
> paper could be written due to so many custom-built things at GH, but I
> would be very happy if that turned out not to be the case.

We have a few engineering blog posts on the subject, like:

  https://githubengineering.com/counting-objects/
  https://githubengineering.com/introducing-dgit/
  https://githubengineering.com/building-resilience-in-spokes/

but we haven't done a very good job of keeping that up. I think a
summary whitepaper would interesting. Maybe one day...:)

-Peff
