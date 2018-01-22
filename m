Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BFC1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeAVXe3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:34:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:53840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751031AbeAVXe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:34:28 -0500
Received: (qmail 10107 invoked by uid 109); 22 Jan 2018 23:34:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Jan 2018 23:34:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12244 invoked by uid 111); 22 Jan 2018 23:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 18:35:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:34:26 -0500
Date:   Mon, 22 Jan 2018 18:34:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Rene Scharfe <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Use MOVE_ARRAY
Message-ID: <20180122233426.GA27144@sigill.intra.peff.net>
References: <d81743e5-d5ba-a565-23f7-072007493499@web.de>
 <20180122175009.20178-1-szeder.dev@gmail.com>
 <20180122224410.GA21604@sigill.intra.peff.net>
 <xmqq372xjwzg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq372xjwzg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 03:26:59PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Most of these are "shift part of the array". I wonder if it would make
> > sense to encapsulate that pattern in a helper, like:
> >
> >   #define SHIFT_ARRAY(a, nr, pos, slots) \
> >     MOVE_ARRAY(a + pos + slots, a + pos, nr - pos - slots)
> >   ...
> >   SHIFT_ARRAY(it->down, it->subtree_nr, pos, 1);
> 
> Exactly my thought when I was queuing it, but I was wondering about
> this more from "can we use the higher level abstraction for reducing
> errors?" point of view.  If we are shifting an array by 3 slots to
> the right, we should at least have enough slots allocated to hold
> them (i.e. a->nr - a->alloc must be 3 or more).  But after realizing
> that the level these macros operate at is still a bit too low to do
> something like that, I quickly lost interest ;-)

Yeah, you'd need to know the "alloc" number to right-shift correctly,
since by definition we're pushing off the end of a->nr. Left-shifts just
need to make sure they don't go past "0", which we can do here, but I'd
think they're pretty uncommon.

The right macro level may actually be something more like "make room for
N items at pos". E.g.:

  #define CREATE_ARRAY_HOLE(a, nr, alloc, pos, slots) do { \
          ALLOC_GROW(a, nr + slots, alloc);
	  MOVE_ARRAY(a + pos + slots, a + pos, nr - pos - slots);
  } while (0)

but I didn't investigate the surrounding code. And it surely would need
a catchier name. ;)

-Peff
