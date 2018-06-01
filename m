Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21CCD1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 05:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbeFAF5S (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 01:57:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750821AbeFAF5R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 01:57:17 -0400
Received: (qmail 10078 invoked by uid 109); 1 Jun 2018 05:57:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Jun 2018 05:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21262 invoked by uid 111); 1 Jun 2018 05:57:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 01:57:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 01:57:15 -0400
Date:   Fri, 1 Jun 2018 01:57:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit
 downstream
Message-ID: <20180601055715.GD8292@sigill.intra.peff.net>
References: <20180529211950.26896-1-avarab@gmail.com>
 <20180529212458.GC7964@sigill.intra.peff.net>
 <xmqqk1rmexng.fsf@gitster-ct.c.googlers.com>
 <20180531060259.GE17344@sigill.intra.peff.net>
 <xmqq4linb7vb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4linb7vb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 01, 2018 at 10:42:00AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I haven't tested it, but I suspect that doing multiple fetches could
> > result in passing bad objects through a fetch.fsckObjects filter.
> > Because the objects aren't quarantined on fetch, and because
> > fsck_finish() requires the objects to be installed into place, they may
> > ...
> > I think in the long run fetch should implement a similar quarantine
> > procedure to what happens on push.
> 
> Interesting.
> 
> I wonder if we can teach quickfetch codepath to notice the presence
> of fsckObjects, instead of doing a full quarantine.  We can easily
> enumerate those objects that were already in the object database but
> outside of the reachability chain before we pretend that we fetched
> them and make them reachable, and check the content integrity of
> them, no?

Yes, we could. But it kind of feels like plugging holes in the dike.
That saves "fetch" from referencing them accidentally, but other git
programs may see and react to them. E.g., you're just an "update-ref"
away from referencing the bad history. I don't expect that most
attackers can then convince a victim to reference the rejected objects,
but it feels a lot more hand-wavy than just saying "we don't let these
objects into the repository in the first place".

-Peff
