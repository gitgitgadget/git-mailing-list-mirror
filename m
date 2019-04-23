Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AAF1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 05:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfDWFWC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 01:22:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:37734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725921AbfDWFWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 01:22:02 -0400
Received: (qmail 18784 invoked by uid 109); 23 Apr 2019 05:22:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 05:22:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6166 invoked by uid 111); 23 Apr 2019 05:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Apr 2019 01:22:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Apr 2019 01:21:59 -0400
Date:   Tue, 23 Apr 2019 01:21:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] CDN offloading of fetch response
Message-ID: <20190423052159.GA12530@sigill.intra.peff.net>
References: <cover.1550963965.git.jonathantanmy@google.com>
 <cover.1552073690.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 01:55:12PM -0800, Jonathan Tan wrote:

> Here's my current progress - the only thing that is lacking is more
> tests, maybe, so I think it's ready for review.

A bit belated, but here are some overall thoughts. A lot of my thinking
comes from comparing this to previous work I had done on teaching the
client to fetch first from a bundle and then do a follow-up fetch from
the server.

> This code now starts CDN downloads after closing the first HTTP request,
> and it holds on to the .keep files until after the refs are set. I'll
> leave parallelization of the CDN downloads for later work.

Good. One of the problems with the bundle+followup approach was either
having to hold open or re-establish the connection to the original
server, since that fetch had to be put on hold.

I agree that parallelizing can come later. I do wonder if it's worth
making a new tool rather than trying to reuse git-http-fetch. Yes, it
basically does what we want already, but there's quite a lot of cruft in
that dumb-http code base. Using http_get_file(), or even curl more
directly might be a bit easier.

One problem in particular I'd worry about is that the http code
generally expects authentication to happen through the initial
ref-discovery, and then be set for all subsequent requests. So I doubt
an http_pack_request actually handles auth at all, and retro-fitting it
may be tricky.

> One relatively significant change: someone pointed out that the issue fixed by 
> 50d3413740 ("http: make redirects more obvious", 2016-12-06) could also
> occur here, so I have changed it so that the server is required to send
> the packfile's hash along with the URI.

I have mixed feelings on that. I like how it clearly makes the server
the source of authority. You don't have to care about CDN tampering,
because you know you are getting the bytes the server wanted you to.

I think even without that this is still _mostly_ true, though. You're
going to compute the hash of every object the CDN sends you, and those
objects must fit into the missing gaps in what the server sends you. So
the worst case is that a malicious CDN could send you some extra
objects. That's probably not the end of the world, but I do like the
extra guarantee of knowing that you got byte-for-byte what the server
wanted you to.

> This does mean that Ævar's workflow described in [1] would not work.
> Quoting Ævar:
> 
> > More concretely, I'd like to have a setup where a server can just dumbly
> > point to some URL that probably has most of the data, without having any
> > idea what OIDs are in it. So that e.g. some machine entirely
> > disconnected from the server (and with just a regular clone) can
> > continually generating an up-to-date-enough packfile.
> 
> With 50d3413740, it seems to me that it's important for the server to
> know details about the URIs that it points to, so such a disconnection
> would not work.

I think even without 50d3413740, this is important for your scheme. One
of the weaknesses (and strengths, I suppose) of the bundle+followup
scheme was that the initial bundle generally had to meet the git
repository guarantee. After you fetched the bundle, you'd tell the
server "OK, now I have commit X" just like you were a regular client.

But I really like that your proposal does away with that, and asks for
tighter cooperation between the server and the CDN. It means the CDN can
serve some random subset of the objects. But once we do that, now the
server _has_ to know what was in those URLs it pointed to, because our
protocol has no good way of communicating a random subset of objects (if
they're just blobs, we could enumerate all of them to the server as
haves; yuck.  But as soon as you get a tree or commit from the CDN, you
have to have all of the reachable objects to be able to claim it).

So I think this is pretty inherent to your proposal, and but it's the
right tradeoff to be making here (I think there could still be room for
the other thing, too, but it's just a different feature).

I have a few other comments on the design, but I'll send them in
response to patch 5.

-Peff
