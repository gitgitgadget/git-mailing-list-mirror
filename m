Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCDB208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 09:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbdHIJUJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 05:20:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:33018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752548AbdHIJUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 05:20:08 -0400
Received: (qmail 26208 invoked by uid 109); 9 Aug 2017 09:20:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 09:20:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25328 invoked by uid 111); 9 Aug 2017 09:20:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 05:20:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 05:20:05 -0400
Date:   Wed, 9 Aug 2017 05:20:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] sha1_file: avoid comparison if no packed hash matches
 the first byte
Message-ID: <20170809092005.tnazbnbgn4piv76r@sigill.intra.peff.net>
References: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
 <xmqq3791adfi.fsf@gitster.mtv.corp.google.com>
 <20170808225231.3l7gyoxxvghsvtv7@sigill.intra.peff.net>
 <20170808225851.kgbyrlqrtlurzc73@sigill.intra.peff.net>
 <xmqqpoc58fq6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoc58fq6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 10:36:33PM -0700, Junio C Hamano wrote:

> > Actually, I take it back. The problem happens when we enter the loop
> > with no entries to look at. But both sha1_pos() and sha1_entry_pos()
> > return early before hitting their do-while loops in that case.
> 
> Ah, I was not looking at that part of the code.  Thanks.
> 
> I still wonder if we want to retire that conditional invocation of
> sha1_entry_pos(), though.

I think so. Digging in the list for it, almost every mention is either
somebody asking "should we scrap this?" or somebody showing benchmarks
in which it is slower than the normal lookup (and then somebody asking
"should we scrap this" :) ).

I just re-ran a simple benchmark and it is indeed slower. I also came
across the hashcmp open-code-versus-memcmp discussion, which shows that
the memcmp in recent glibc is much faster. That has been around long
enough that it's probably worth switching to.

-Peff
