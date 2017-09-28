Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA5220A2A
	for <e@80x24.org>; Thu, 28 Sep 2017 20:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdI1UGA (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 16:06:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750775AbdI1UF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 16:05:59 -0400
Received: (qmail 28256 invoked by uid 109); 28 Sep 2017 20:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 20:05:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30231 invoked by uid 111); 28 Sep 2017 20:06:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 16:06:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2017 16:05:57 -0400
Date:   Thu, 28 Sep 2017 16:05:57 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
Message-ID: <20170928200556.grysihlj7cbzocfq@sigill.intra.peff.net>
References: <20170927221910.164552-1-jonathantanmy@google.com>
 <20170928004137.GD68699@google.com>
 <20170928104616.be61b394b50dc5193be275be@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170928104616.be61b394b50dc5193be275be@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 10:46:16AM -0700, Jonathan Tan wrote:

> > To me it seems like a much simpler API for a map would be to just allow
> > callers to store a 'void *' as the value.
> 
> I agree that the API would be simpler.
> 
> My main motivation with this design is indeed to save memory, and not
> inconvenience the user too much (in the case where you're storing things
> larger than one pointer, you just need to remember to put the special
> struct at the beginning of your struct), but if memory is not so
> important, I agree that we can switch to the "util" design.

When I saw that you were implementing "oidset" in terms of "oidmap", I
was all ready to be crabby about this extra memory. But then I saw that
the implementation tries hard not to waste any memory. :)

All of which is to say I gave this some thought when I was in the "ready
to be crabby" phase, and came to the conclusion that it probably isn't
that painful. An unused pointer is 8 bytes per entry. We're already
spending 20 for the oid itself (which is likely to grow to 32
eventually), plus 8 for the chained "next" pointer. Plus potentially 8
for a padded version of the hash, if we just use a straight hashmap that
duplicates the hash field.

So depending how you count it, we're wasting between 28% (sha1 and no
extra hash) and 16% (sha256 plus reusing hashmap). That's not great, but
it's probably not breaking the bank.

Another way of thinking about it. Large-ish (but not insane) repos have
on the order of 5-10 million objects. If we had an oidset that mentioned
every single object in the repository, that's 40-80MB wasted in the
worst case. For current uses of oidset, that's probably fine. It's
generally used only to collect ref tips (so probably two orders of
magnitude less).

If you're planning on using an oidset to mark every object in a
100-million-object monorepo, we'd probably care more. But I'd venture to
say that any scheme which involves generating that hash table on the fly
is doing it wrong. At at that scale we'd want to look at compact
mmap-able on-disk representations.

So I think we may be better off going with the solution here that's
simpler and requires introducing less code. If it does turn out to be a
memory problem in the future, this is a _really_ easy thing to optimize
after the fact, because we have these nice abstractions.

-Peff
