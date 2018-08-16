Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6FE1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeHPWqD (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 18:46:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725835AbeHPWqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 18:46:03 -0400
Received: (qmail 14816 invoked by uid 109); 16 Aug 2018 19:45:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 19:45:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18881 invoked by uid 111); 16 Aug 2018 19:45:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 15:45:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 15:45:38 -0400
Date:   Thu, 16 Aug 2018 15:45:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/7] speeding up cat-file by reordering object access
Message-ID: <20180816194537.GA5813@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
 <fc30f98e-0aa0-89d3-ee32-3d86cc5b342a@gmail.com>
 <20180816173934.GC882@sigill.intra.peff.net>
 <xmqqmutmdu02.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmutmdu02.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 11:52:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think that makes sense. We already see duplicates from
> > for_each_packed_object() when they're in multiple packs, and callers
> > just need to be ready to deal with it (and depending on what you're
> > doing, you may actually _want_ the duplicates).
> 
> You of course would also see dups between loose and packed until
> prune-packed is run.

Yes, although there are two separate calls to look at those two sources,
so it's a bit more obvious that the caller has to de-dup. I'm not
opposed to a flag to ask the function to de-dup for us, but it really
only makes sense if we do a combined for_each_object() call.
De-duping is potentially expensive, and there's little point in
de-duping the packs if we have to then de-dup the result with the loose
objects.

One benefit of having the iterator function de-dup is that it _could_ be
done more efficiently. Right now, even before my recent patches the
cat-file de-dup happens by creating a secondary list, sorting it, and
then skipping the duplicates.

But if a function knew _all_ of the sources we were going to look at
(any loose directories, including alternates, and all available packs),
and it could walk each individual source in sorted order (easy for packs
by .idx, not too bad for loose by sorting the readdir() results), then
we could do it as an online list-merge, with a single walk through the
results.

In practice I don't know if it's worth the effort. If you're accessing
the object contents, sorted order really is bad. And if you're just
collecting the hashes, then you're likely generating some data structure
for future lookups, and you can just de-dup as part of that process.

> I also was thinking about the same thing after Derrick's response,
> but unless you are very specialized caller, it does not allow you do
> very much to learn that object X exists as a loose object locally,
> also as a loose object in our alternate, and also in pack A, but not
> in other packs.  You need a way to say "Read the contents of object
> X from that place, not from any other place", "Remove that copy of
> object X at that place, but not at any other place" etc. to make
> effective use of that kind of information.

We do have those functions, and use them. E.g., fsck uses
read_loose_object() to actually check that particular copy of the
object. That's obviously a specialized caller as you note, but then
anybody iterating over all of the objects is pretty specialized already.

> The codepath that implements runtime access has "I found a copy
> here, but it is unusable, so let's go on to look for another usable
> copy" fallback.  This is a tangent but it is something we should not
> lose in the midx-enabled world.

Yeah, good catch. That's orthogonal to most of this discussion, I think,
but it's a possible downside of the midx because it has literally
discarded those duplicate index entries (or at least that's my
understanding). If we kept the .idx for each pack as a fallback for
older Gits, then it's easy to solve: in the unlikely case the
.midx-referenced copy fails, you look in each individual pack for
another copy.

But I think eventually you'd want to stop generating those .idx files,
too, if you know that you'll only use a modern version of Git. I wonder
if the .midx format should have an extension for "here are all the
duplicates I found". They could even be part of the main index (it's
easy enough for a binary-search lookup to always point to the start of a
run of duplicates), but if you had a ton of duplicates they would slow
your binary searches a little.

I'll leave all that to Stolee to ponder. :)

-Peff
