Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB745202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 17:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbdJSRxV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 13:53:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:57920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754431AbdJSRxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 13:53:18 -0400
Received: (qmail 29340 invoked by uid 109); 19 Oct 2017 17:53:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:53:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10385 invoked by uid 111); 19 Oct 2017 17:53:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 13:53:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 13:53:16 -0400
Date:   Thu, 19 Oct 2017 13:53:16 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH 2/4] remote: handle broken symrefs
Message-ID: <20171019175315.aewiewjk3fvhifa4@sigill.intra.peff.net>
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
 <20171019174730.urelfyc2kj37fokg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019174730.urelfyc2kj37fokg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 01:47:30PM -0400, Jeff King wrote:

> This is hard to trigger in practice, since this function is
> used as a callback to for_each_ref(), which will skip broken
> refs in the first place (so it would have to be broken
> racily, or for us to see a transient filesystem error).
> 
> If we see such a racy broken outcome let's treat it as "not
> a symref". This is exactly the same thing that would happen
> in the non-racy case (our function would not be called at
> all, as for_each_ref would skip the broken symref).

The fact that we have to re-resolve the ref here to find the symref
points to a short-coming in the for_each_ref() interface. It resolved
the ref already to get us the oid, so it should (or at least could) know
the symref details already. But it doesn't record them or make them
available to callers.

Ditto for patch 3. It doesn't use for_each_ref(), but I suspect it could
be recording the value of HEAD more carefully from the prior lookup,
avoiding the re-resolution completely.

Refactoring for_each_ref() is probably a bit big for a #leftoverbits,
but looking into the case in patch 3 might not be.

-Peff
