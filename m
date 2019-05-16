Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE72A1F461
	for <e@80x24.org>; Thu, 16 May 2019 04:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfEPEEx (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 00:04:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:58976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725835AbfEPEEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 00:04:53 -0400
Received: (qmail 4813 invoked by uid 109); 16 May 2019 04:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 04:04:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27090 invoked by uid 111); 16 May 2019 04:05:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 00:05:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 00:04:51 -0400
Date:   Thu, 16 May 2019 00:04:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190516040451.GF4596@sigill.intra.peff.net>
References: <cover.1557868134.git.jonathantanmy@google.com>
 <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
 <20190515231617.GA1395@sigill.intra.peff.net>
 <xmqqk1er5g48.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1er5g48.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 10:43:03AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree that the current implementation (and probably any sane
> > implementation) would not send us a delta if we have not provided any
> > haves. But this does mean that a malicious server could send a client
> > into an infinite loop.
> >
> > Pretty unlikely, but should we put some kind of circuit-breaker into the
> > client to ensure this?
> 
> That's a pretty good point.  Would it be suffice to have a new
> option to tell index-pack that fattens a thin pack and unpack-objects
> that expands objects in a small incoming packfile into loose objects
> that they are forbidden from on-demand fatching during this invocation,
> as it is an error for the packfile they are digesting to depend on a
> lazy objects?

Yeah, that's what I was thinking. The parent index-pack sets an
environment variable for "do not recurse to get partials" when it calls
fetch. But that said...

> > I dunno. Maybe we should just ignore it. It's a fundamental issue with
> > partial clones that we're going to have to fetch extra junk here anyway,
> 
> Would it be an option not to ask for a thin pack in the first place?

Yes, that seems much simpler. The flag is really "do not ask for a thin
pack, and do not pass --fix-thin to index-pack". And this recursion
should not kick in when --fix-thin is not in effect (I didn't check
Jonathan's patch to see whether that is the case, but I think that ought
to be the rule regardless of how we decide to address the recursion
issue).

One snag: I don't think unpack-objects understands --fix-thin. It just
looks in the object database and finds either a recently-written object
or one we already have, and it doesn't care about the difference.

For that matter, does unpack-objects need the same treatment here? I
guess not, because it does not disable fetch_if_missing in the same way.
I guess it is already susceptible to the infinite-recursion thing, then.
Or maybe not. We always use index-pack for promisor remotes. So even
though the _first_ fetch which yields REF_DELTA may be from a
non-promisor, any subsequent one would be. So we'd never recurse more
than once. So I think the emergent behavior does what we want. ;)

I worked up some patches a while ago to try to replace unpack-objects
with an index-pack mode that explodes objects (just so we could stop
keeping two almost-the-same code bases around, both of which are
security-critical as they take in untrusted objects, and one of which
clearly gets a lot more attention than the other). But I got hung up a
bit on their strategies for handling base objects. IIRC, the
unpack-objects one does things in a different order that's more
efficient for some cases, and I worried that somebody would care.

I can resurrect that if there's interest (though I do think by the
reasoning above that it's orthogonal to this particular patch series).

> > If we're willing to modify the format, one thing we _could_ do is have
> > the server communicate the expectations for each base. I.e., introduce a
> > new THIN_DELTA type that behaves exactly as a REF_DELTA, but with the
> > extra 1-bit of knowledge that the server knows it is not including the
> > base in the pack. I'm not sure how painful that retro-fitting would be.
> > It would need at least a new capability and options to pack-objects and
> > index-pack. We might be tight on bits in the packfile type field.
> 
> The type field is tight, but I wonder how much such a new
> representation would help.  Unless the receiving end blindly trusts
> what the sender says, there needs to be a logic to detect cyclic
> dependencies while following such a delta chain to lazy-fill
> promised objects on the receiving end anyway, no?

It would let the client know how the server expects it to handle each
delta. The client can then (without trusting the server) say:

  - this is REF_DELTA; the server claims that the base is in this pack,
    so I will not prefetch it. If it turns out not to be, then it is an
    error and I will reject the pack (and _not_ try to fetch it on
    demand)

  - this is THIN_DELTA; I will try to fetch it from the promisor remote,
    and not recurse (because the promisor fetch will not ask for a
    thin-pack). If it also turns out to be in the pack, so be it. We'll
    have two copies and will have wasted the server's bandwidth.

So the client gets to optimize by following the server's directions, but
the worst case for a lying server is not a big deal (it's just more
pessimal).

-Peff
