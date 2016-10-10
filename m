Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1853120989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbcJJUwr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:52:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:55336 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbcJJUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:52:46 -0400
Received: (qmail 16431 invoked by uid 109); 10 Oct 2016 20:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 20:52:46 +0000
Received: (qmail 1859 invoked by uid 111); 10 Oct 2016 20:53:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 16:53:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 16:52:44 -0400
Date:   Mon, 10 Oct 2016 16:52:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_add_unique_abbrev() for adding short hashes,
 part 3
Message-ID: <20161010205243.fejhhvoos5tmqggh@sigill.intra.peff.net>
References: <c830e99d-4fc9-b001-cce3-38f66dc2c678@web.de>
 <20161010000035.mfcf55wqfcbcnarh@sigill.intra.peff.net>
 <af55f6d7-e1b1-272b-4fbe-a6eb2422b3be@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af55f6d7-e1b1-272b-4fbe-a6eb2422b3be@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 10:46:21PM +0200, René Scharfe wrote:

> Good question.  ALLOC_GROW() doesn't double exactly, but indeed the
> number of reallocations depends on the size of the added pieces.  I
> always thought of strbuf_addf() as an expensive function for
> convenience, but never timed it.
> 
> Numbers vary a bit, but here's what I get for the crude test program
> at the end:
> 
> $ time t/helper/test-strbuf strbuf_addf 123 123456789012345678901234567890
> 123123456789012345678901234567890
> 
> real    0m0.168s
> user    0m0.164s
> sys     0m0.000s
> $ time t/helper/test-strbuf strbuf_addstr 123 123456789012345678901234567890
> 123123456789012345678901234567890
> 
> real    0m0.141s
> user    0m0.140s
> sys     0m0.000s
> 
> Just a data-point, but it confirms my bias, so I stop here. :)

Heh. I'm surprised it's that big a difference, as processing simple
printf strings should be pretty quick. I guess what happens in your
program is that your strings almost always require a re-allocation
(because you've just released, and we start small), and we literally end
up doing a partial copy via vsnprintf(), realizing we're out of space,
reallocating, and then running it again.

So it's noticeably worse when we _do_ reallocate, but usually that
should be amortized across many calls (and if it isn't, then you are
paying the much bigger price of lots of mallocs, and you should optimize
that first :) ).

That being said, it doesn't seem like it would be _worse_ to move from
addf to multiple addstrs.

-Peff
