Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFB420899
	for <e@80x24.org>; Thu, 27 Jul 2017 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdG0Or2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 10:47:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:50558 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751556AbdG0Or1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 10:47:27 -0400
Received: (qmail 4428 invoked by uid 109); 27 Jul 2017 14:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 14:47:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1945 invoked by uid 111); 27 Jul 2017 14:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 10:47:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jul 2017 10:47:25 -0400
Date:   Thu, 27 Jul 2017 10:47:25 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Devin Lehmacher <lehmacdj@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] credential-cache: interpret an ECONNRESET as on EOF
Message-ID: <20170727144725.a72cybli746ipiko@sigill.intra.peff.net>
References: <ab9124d9-6630-49f3-d645-2f4251f88764@ramsayjones.plus.com>
 <20170727141723.q7eeeajrdkwext5z@sigill.intra.peff.net>
 <6574cd23-5d95-c23c-8179-755798472a9d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6574cd23-5d95-c23c-8179-755798472a9d@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2017 at 03:42:36PM +0100, Ramsay Jones wrote:

> yep, I did think about adding a FLAG_EXIT (or somesuch) and passing
> it down through the call stack to send_request() so that I could do
> the check only for the 'exit' command. I decided against it in the
> end, obviously! ;-)

I had the same thought. I don't think it's worth the trouble, either.

> > So I don't think this really changes the robustness much. If we did want
> > to address those cases, we'd require actual end-of-record framing in the
> > protocol. But I don't think it's worth caring too much about (this is,
> > after all, a local and internal socket between two relatively simple
> > programs).
> 
> Adding the framing to the protocol was actually my first (very fleeting)
> idea. However, I didn't want to get into the 'supporting old/new client
> and server combos' problem.

One nice thing about this protocol is that it's just between the caching
client and server, which ship together and which run for a default of 5
minutes. I think it would probably be OK to just assume you have a
matched pair, and change the protocol as you like.

So I'd be fine if somebody wanted to tackle this, but I don't think it
matters that much. After all, it's proxying requests that came over the
credential helper protocol, which also isn't framed. And changing that
one _would_ be a compatibility problem.

-Peff
