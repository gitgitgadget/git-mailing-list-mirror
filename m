Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE741F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbcGTNkc (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:40:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:47470 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753683AbcGTNkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:40:31 -0400
Received: (qmail 10228 invoked by uid 102); 20 Jul 2016 13:40:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:40:30 -0400
Received: (qmail 20637 invoked by uid 107); 20 Jul 2016 13:40:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:40:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:40:27 -0600
Date:	Wed, 20 Jul 2016 07:40:27 -0600
From:	Jeff King <peff@peff.net>
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
Message-ID: <20160720134027.GA19194@sigill.intra.peff.net>
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
 <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
 <CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com>
 <CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
 <xmqq8twxfn4j.fsf@gitster.mtv.corp.google.com>
 <20160719195347.GF29326@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160719195347.GF29326@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 12:53:47PM -0700, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> 
> > Even if it is conservative, I wonder if it is truly a good idea to
> > make it exponentially grow forever from that point of view.  Would
> > it give essentially the same result to you if we discard the patch
> > in question and just raise LARGE_FLUSH to 10k instead?
> 
> I don't think it would be essentially the same result.  As discussed
> before, unlike the bidi (ssh:// and git:// protocols) case, linear
> growth is expensive in the stateless-rpc (https://) case --- each
> round of negotiation requires re-sending the existing 'have's and
> requires the peer repeatedly processing this increasingly large list
> of 'have's.
> 
> For comparison, in the bidi case, linear growth of next_flush means
> sending a bounded number of 'have's per round and is quite sensible.
> 
> In the stateless-rpc case, linear growth means getting a bounded
> number of 'have's worth of benefit (new 'have's) in each round, in
> exchange for a linearly increasing cost (existing 'have's).  That is a
> high cost for limited benefit.  Exponential growth is a better deal.

This kind of reasoning would be great in the commit message (and if
possible, numbers showing empirical improvement). On reading it, I
understood the "what", but not why or to what extent the slower growth
is a problem.

-Peff
