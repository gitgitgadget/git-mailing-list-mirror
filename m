Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1D420365
	for <e@80x24.org>; Tue,  3 Oct 2017 06:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbdJCGbW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:31:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58664 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750720AbdJCGbV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:31:21 -0400
Received: (qmail 9275 invoked by uid 109); 3 Oct 2017 06:31:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 06:31:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5349 invoked by uid 111); 3 Oct 2017 06:31:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 02:31:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 02:31:19 -0400
Date:   Tue, 3 Oct 2017 02:31:19 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2] oidmap: map with OID as key
Message-ID: <20171003063119.iht5kl7zsiuxpaqz@sigill.intra.peff.net>
References: <20170927221910.164552-1-jonathantanmy@google.com>
 <20170929225422.81467-1-jonathantanmy@google.com>
 <20171002234848.GG5189@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002234848.GG5189@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 04:48:48PM -0700, Brandon Williams wrote:

> > Some replies to v1 [1] [2] seem to indicate that simpler non-duplicated
> > code should be preferred over optimizing away the storage of the 4-byte
> > hash code, and I have no objection to that, so I have updated this code
> > to be a thin wrapper over hashmap with the 4-byte overhead.
> > 
> > After this patch, if the 4-byte overhead is found to be too much, we can
> > migrate to something similar to v1 relatively easily.
> > 
> > I decided not to go with the util pointer method because we will not be
> > able to migrate away from it so easily if need be.
> 
> This makes me a bit sad because I tend to lean more towards making
> things simpler.  I'm still a supporter of the 'util' pointer but I
> understand why we would choose otherwise.

Right, I kind of wonder if this has fallen into an uncanny value where
we have this almost-hashmap infrastructure, but the end result is not
significantly easier to use than a plain-old hashmap.

I.e., it looks like you still have to declare something like:

  struct my_data {
        struct oidmap_entry oid;
	int value; /* mapping to an int */
  };

and handle the allocation of the entry yourself. If we instead just
adding an oidhash() and oidcmpfn(), then callers could those directly.

The invocations are a _little_ longer with a raw hashmap, but not much
(as you can see from the actual oidmap implementation, and the changes
to oidset).

I dunno. I'm not against it per se. The API _is_ a little nicer, but I
just wonder if there's a downside to even the thin wrapper, in that
callers are no longer free to use other parts of the hashmap API. If I
saw some converted callers I might be more convinced.

-Peff
