Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729371FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbdEPQNV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:13:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbdEPQNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:13:21 -0400
Received: (qmail 13612 invoked by uid 109); 16 May 2017 16:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 16:13:17 +0000
Received: (qmail 28868 invoked by uid 111); 16 May 2017 16:13:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 12:13:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 12:13:15 -0400
Date:   Tue, 16 May 2017 12:13:15 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] hashmap: hashmap_get_next passes through keydata as well
Message-ID: <20170516161315.oraebpe2zuzuo3q3@sigill.intra.peff.net>
References: <20170512200244.25245-1-sbeller@google.com>
 <20170513085050.plmau5ffvzn6ibfp@sigill.intra.peff.net>
 <CAGZ79kZxN5-K19R+gd-pZ1Uc30_JRKugjMTJZ4er2dF71pStPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZxN5-K19R+gd-pZ1Uc30_JRKugjMTJZ4er2dF71pStPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 07:06:35AM -0700, Stefan Beller wrote:

> > I think I figured it out, but I have a feeling it is violating the
> > intent of the "keydata" parameter.  That parameter is typically used not
> > as a pointer to arbitrary auxiliary data, but as a trick for finding a
> > hash entry without having to allocate a struct for it.
> 
> Yes, I was violating the intent exactly as you describe. I'll adapt my patches
> accordingly.
> 
> I do not really buy into the trick though, because when the overhead of
> allocating a 'key' struct filling in the key parts only leaving out the value
> is so much more expensive than giving the key via this keydata argument,
> then there are serious issues with your data structure IMHO.
> Example:
> [...]

Sure, in your example it works to allocate a partial structure on the
stack. But if you look at the users of the hashmap, quite a few are
structs with final flex-array members, which cannot easily do that
without allocating a new struct on the heap.  You can work around it by
converting them to flex-ptrs (at the cost of an extra 8 bytes per
struct) and having the "key only" version be an oddball by pointing
outside the struct. But I do think having the flexibility in hashmap is
nice.

I actually wish that it did not even require the hashmap entry to be at
the beginning of the struct; it makes it hard to put the same structure
into multiple hashes/lists. See for example the pack MRU, which is in
both a hash and a doubly-linked list. Fortunately the list code is
flexible enough to allow its pointers anywhere in the struct.

So yeah, we could design all of our data structures to fit into the
hashmap's world-view. But I think it's handy for it to be flexible.

> > It works out in the current code because the chaining is purely linear,
> > and doesn't care about order. So we can rehash and just stick the
> > elements into a new list. But if it were switched out for a different
> > data structure (e.g., a tree), then the hashmap code would need to be
> > able to compare elements.
> 
> Note that most compare functions do not return an order, but only
> a boolean [no]match, so putting it into an ordered tree could only
> rely on the hash that we already know without aid from the compare function.
> Of course we could fix our compare functions before doing such a
> refactoring, but I want to point out how involved that would be.

Good point, I didn't think of that. Moving to any non-linear lookup
within a single bucket would require totally changing the cmp_fn
contract, and that's not likely to happen (and anyway, if we're starting
to care about intra-bucket lookup times, that's probably a sign we
should be growing the table more aggressively).

So my concern was just nonsense.

> > I don't think we have any particular plans for such a change, but I
> > wonder if we should avoid encouraging callers to rely on the current
> > implementation.
> 
> After a night of sleep it is easy to fix my code to behave as the API
> intended. Yesterday I could not see how to fix it.

Yay, then. :)

-Peff
