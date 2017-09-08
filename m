Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CCC20286
	for <e@80x24.org>; Fri,  8 Sep 2017 03:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbdIHDeG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 23:34:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752110AbdIHDeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 23:34:06 -0400
Received: (qmail 8105 invoked by uid 109); 8 Sep 2017 03:34:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:34:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5465 invoked by uid 111); 8 Sep 2017 03:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 23:34:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 23:34:03 -0400
Date:   Thu, 7 Sep 2017 23:34:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170908033403.q7e6dj7benasrjes@sigill.intra.peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 11:40:21AM +0900, Junio C Hamano wrote:

> Our "git fsck" already treats certain brokenness (like a tree whose
> entry has mode that is 0-padded to the left) as broken but still
> tolerate them.  I am not sure if it is sufficient to diagnose and
> declare broken and invalid when we see sha3-content that records
> these "mechanically derivable but expensive to compute" pieces of
> information incorrectly.
> 
> I am leaning towards saying "yes, catching in fsck is enough" and
> suggesting to add generation number to sha3-content of the commit
> objects, and to add even the "original sha1 name" thing if we find
> good use of it.  But I cannot shake this nagging feeling off that I
> am missing some huge problems that adding these fields and opening
> ourselves to more classes of broken objects.

I share your nagging feeling.

I have two thoughts on the "fsck can catch it" line of reasoning.

  1. It's harder to fsck generation numbers than other syntactic
     elements of an object, because it inherently depends on the links.
     So I can't fsck a commit object in isolation. I have to open its
     parents and check _their_ generation numbers.

     In some sense that isn't a big deal. A real fsck wants to know that
     we _have_ the parents in the first place. But traditionally we've
     separated "is this syntactically valid" from "do we have full
     connectivity". And features like shallow clones rely on us fudging
     the latter but not the former. A shallow history could never
     properly fsck the generation numbers.

     A multiple-hash field doesn't have this problem. It's purely a
     function of the bytes in the object.

  2. I wouldn't classify the current fsck checks as a wild success in
     containing breakages. If a buggy implementation produces invalid
     objects, the same buggy implementation generally lets people (and
     their colleagues) unwittingly build on top of those objects. It's
     only later (sometimes much later) that they interact with a
     non-buggy implementation whose fsck complains.

     And what happens then? If they're lucky, the invalid objects
     haven't spread far, and the worst thing is that they have to learn
     to use filter-branch (which itself is punishment enough). But
     sometimes a significant bit of history has been built on top, and
     it's awkward or impossible to rewrite it.

     That puts the burden on whoever is running the non-buggy
     implementation that wants to reject the objects. Do they accept
     these broken objects? If so, what do they do to mitigate the wrong
     answers that Git will return?

I'm much more in favor of keeping that data outside the object-hash
computation, and caching the pre-computed results as necessary. Those
cache can disagree with the objects, of course, but the cost to dropping
and re-building them is much lower than a history rewrite.

I'm speaking primarily to the generation-number thing, where I really
don't think there's any benefit to embedding it in the object beyond the
obvious "well, it has to go _somewhere_, and this saves us implementing
a local cache layer".  I haven't thought hard enough on the
multiple-hash thing to know if there's some other benefit to having it
inside the objects.

-Peff
