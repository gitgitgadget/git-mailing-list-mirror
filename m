Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7338A20285
	for <e@80x24.org>; Wed, 30 Aug 2017 19:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdH3TxX (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 15:53:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:53540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750756AbdH3TxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 15:53:23 -0400
Received: (qmail 20012 invoked by uid 109); 30 Aug 2017 19:53:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 19:53:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22986 invoked by uid 111); 30 Aug 2017 19:53:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 15:53:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Aug 2017 15:53:20 -0400
Date:   Wed, 30 Aug 2017 15:53:20 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170830195320.27w5mhnrcd2uosvz@sigill.intra.peff.net>
References: <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <3e632fd3-7db9-4c38-c524-b56a06cfaa87@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e632fd3-7db9-4c38-c524-b56a06cfaa87@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 08:55:01AM +0200, Michael Haggerty wrote:

> > +	tempfile->active = 0;
> > +	for (p = &tempfile_list; *p; p = &(*p)->next) {
> > +		if (*p == tempfile) {
> > +			*p = tempfile->next;
> > +			break;
> > +		}
> >  	}
> >  }
> 
> `deactivate_tempfile()` is O(N) in the number of active tempfiles. This
> could get noticeable for, say, updating 30k references, which involves
> obtaining 30k reference locks. I think that code adds the locks in
> alphabetical order and also removes them in alphabetical order, so the
> overall effort would go like O(N²). I'm guessing that this would be
> measurable but not fatal for realistic numbers of references, but it
> should at least be benchmarked.
> 
> There are three obvious ways to make this O(1) again:
> 
> * Make the list doubly-linked.

Yeah, I noticed this when writing it, and the doubly-linked list was my
first thought. It's much more straight-forward than making guesses about
traversal order, and we already have a nice implementation in list.h.

What made me hesitate for this demonstration was that it turns the
removal into _two_ pointer updates. That made me more nervous about the
racy case where we get a single handler while already deleting
something. Specifically when we have "a <-> b <-> c" and we've updated
"a->next" to point to "c" but "c->prev" still points to "b".

But even with the singly-linked list we're not fully race-proof
(somebody could set *p to NULL between the time we look at it and
dereference it). What we really care about is not two versions of the
function running simultaneously, but one version getting interrupted by
another and having the second one see a sane state (because we'll never
return to the first signal handler; the second one will raise() and
die).

And I think we're fine there even with a doubly-linked list. It's still
the single update of the "next" pointer that controls that second
traversal.

-Peff
