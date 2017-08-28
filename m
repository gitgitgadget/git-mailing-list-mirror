Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7DC208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 17:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdH1R66 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 13:58:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:51094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751198AbdH1R66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 13:58:58 -0400
Received: (qmail 27833 invoked by uid 109); 28 Aug 2017 17:58:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Aug 2017 17:58:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3493 invoked by uid 111); 28 Aug 2017 17:59:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Aug 2017 13:59:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Aug 2017 13:58:56 -0400
Date:   Mon, 28 Aug 2017 13:58:56 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170828175855.vs2s7lpxxhwlfhdi@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <CAGZ79ka3+T+TgakKDcHSmoc83mOdSDgoN=S=P5PtaYygo0nGWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka3+T+TgakKDcHSmoc83mOdSDgoN=S=P5PtaYygo0nGWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2017 at 10:52:51AM -0700, Stefan Beller wrote:

> >> I'm curious, too. I don't think the valgrind setup in our test suite is
> >> great for finding leaks right now.
> 
> This discussion comes up every once in a while,
> the last time I was involved in this discussion I proposed
> to have an "optional_free(void *)", which only frees memory
> in e.g. the developer build/debug build.
> 
> That way we can have a strict "no leaks in developer build"
> policy (as it is easy to detect!), but it doesn't slow down the
> widely distributed version of Git.

Personally I am not that worried about slowing down program-exit with
some free() calls (though I would reserve judgement to see how slow it
actually is).

It is that I do not want to deal with the complexity and maintenance
headache of dropping values which are program-lifetime caches. If we
introduce a free-all-object-structs function, now everybody needs to
remember to call it (even if they didn't realize they were allocating
object structs in the first place, as it may have happened under the
hood of a sub-function). And we have to wonder what might happen when
somebody calls that function _not_ at program exit.

If we can declare "reachable things are not leaks" (and certainly
valgrind is aware of that distinction), then all of that goes away. And
you're just left with local variables in main() (or our cmd_*
equivalents) that appear as leaks. And then we can solve that either by
freeing them, or just calling them program-lifetime and telling the
compiler that it's so by declaring them "static".

-Peff
