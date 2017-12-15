Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8F81F406
	for <e@80x24.org>; Fri, 15 Dec 2017 10:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755466AbdLOKDz (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 05:03:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:40494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754835AbdLOKDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 05:03:52 -0500
Received: (qmail 31766 invoked by uid 109); 15 Dec 2017 10:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Dec 2017 10:03:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8088 invoked by uid 111); 15 Dec 2017 10:04:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 15 Dec 2017 05:04:16 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Dec 2017 05:03:50 -0500
Date:   Fri, 15 Dec 2017 05:03:50 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        sbeller@google.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH] decorate: clean up and document API
Message-ID: <20171215100350.GB3567@sigill.intra.peff.net>
References: <20171208001424.81712-1-jonathantanmy@google.com>
 <20171208095510.GA29626@sigill.intra.peff.net>
 <20171211103249.e34385be4688734442659e71@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171211103249.e34385be4688734442659e71@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 10:32:49AM -0800, Jonathan Tan wrote:

> > Other than that philosophical point, the documentation you added looks
> > pretty good to me. Two possible improvements to the API we could do on
> > top:
> > 
> >   1. Should there be a DECORATION_INIT macro (possibly taking the "name"
> >      as an argument)? (Actually, the whole name thing seems like a
> >      confusing and bad API design in the first place).
> 
> Agreed about the "name" thing. I'll add a DECORATION_INIT when I make
> the next reroll, but I think that having it with no argument is best
> (and instantiating "name" with NULL).

That will leave callers like the one in log-tree unable to use the
macro, since it uses a static initializer. I didn't dig, though. That
may be the only one. Most of the rest seem to just get explicitly
zero-initialized (some via xcalloc of a larger struct, so maybe we
should just promise that zero-initialization is always OK).

> >   2. This is really just an oidmap to a void pointer. I wonder if we
> >      ought to be wrapping that code (I think we still want some
> >      interface so that the caller doesn't have to declare their own
> >      structs).
> 
> It is slightly different from oidmap in that this uses "struct object *"
> as a key whereas oidmap uses "struct object_id", meaning that a user of
> "decorate" must already have objects allocated or be willing to allocate
> them, whereas a user of "oidmap" doesn't.

Ah, right. I was thinking the difference was only on the "value" half
being a pointer versus a struct.

It's nice in the current code that decorations do not incur the extra
cost of storing the oid twice (once in the "struct object", and then
again in the map key).  OTOH, that might well be premature optimization.

-Peff
