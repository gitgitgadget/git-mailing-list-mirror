Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89147C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DAC20757
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 15:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCPUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:20:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:46128 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgKCPTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 10:19:01 -0500
Received: (qmail 6141 invoked by uid 109); 3 Nov 2020 15:19:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 15:19:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1517 invoked by uid 111); 3 Nov 2020 15:19:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 10:19:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 10:18:59 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/4] Doc: push with --base
Message-ID: <20201103151859.GA444466@coredump.intra.peff.net>
References: <cover.1604362701.git.jonathantanmy@google.com>
 <6250c13897e3cc01f247d80c148cf8dc5e7f3ad0.1604362701.git.jonathantanmy@google.com>
 <20201103053554.GC948115@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103053554.GC948115@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 09:35:54PM -0800, Jonathan Nieder wrote:

> I think you're saying that we don't need a "push" v2 because v0
> already has what a user would want.
> 
> Git protocol v2 for fetch brought two major changes:
> 
> - it changed the response for the initial request, allowing
>   abbreviating the ref advertisement at last
> 
> - it defined a structure for requests and responses, simplifying the
>   addition of later protocol improvements.  In particular, because the
>   initial response is a capability advertisement, it allows changing
>   the ref advertisement format more in the future.
> 
> Both of those changes would be valuable for push.  The ref
> advertisements are large, and matching the structure of commands used
> by fetchv2 would make debugging easier.
> 
> There are some specific applications I'm interested in after that
> (e.g., pushing symrefs), but the fundamental extensibility improvement
> is larger than any particular application I could think of.

You pretty much summed up what I was going to respond. :)

But I'd go further here...

> That said, I'm not against experimenting with extra parameters before
> we go there, as a way of getting more information about what a
> workable negotiation for push looks like.

I'd prefer to avoid doing this as an extra parameter for a few reasons:

  - once it's in a released version, it's much harder for us to take it
    away

  - the extra parameters area is a hack that helped us bootstrap v2. We
    could probably use the same hack to bootstrap v3, etc. But it has
    limitations for stuffing in arbitrary data. An obvious one is size.
    We can transmit a single base, but would be limited if we wanted to
    be able to send multiple. We already ran into this once with the
    "symref=foo:bar" capability overflowing pkt-line limits. Here I'm
    not even sure what the limits might be (it's subject to things like
    how big an HTTP header a proxy will pass, or how large an
    environment variable an ssh implementation supports)

  - it potentially pushes more data/work outside of the git protocol
    itself. E.g., web servers have to translate Git-Protocol headers
    into the GIT_PROTOCOL environment for v2. I guess this new field
    works in our tests because we copy the header's value entirely in
    our apache.conf. But I wonder how many systems in the wild may only
    work if it contains "version=2".

-Peff
