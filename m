Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB9320285
	for <e@80x24.org>; Sun, 27 Aug 2017 15:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdH0Plz (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 11:41:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:50358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751182AbdH0Ply (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 11:41:54 -0400
Received: (qmail 19806 invoked by uid 109); 27 Aug 2017 15:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 15:41:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28065 invoked by uid 111); 27 Aug 2017 15:42:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 11:42:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Aug 2017 11:41:52 -0400
Date:   Sun, 27 Aug 2017 11:41:52 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170827154152.4n2ykna7e4l27fyn@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170827073732.546-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 09:37:32AM +0200, Martin Ågren wrote:

> The static-ness was silently dropped in commit 70428d1a5 ("pkt-line: add
> packet_write_fmt_gently()", 2016-10-16). As a result, for each call to
> packet_write_fmt_1, we allocate and leak a buffer.
> 
> We could keep the strbuf non-static and instead make sure we always
> release it before returning (but not before we die, so that we don't
> touch errno). That would also prepare us for threaded use. But until
> that needs to happen, let's just restore the static-ness so that we get
> back to a situation where we (eventually) do not continuosly keep
> allocating memory.

Ouch. So this means that git since v2.11 is basically leaking every
non-byte pack sent by upload-pack (so all of the ref advertisement and
want/have negotiation).

I'm surprised nobody noticed the extra memory use, but I guess those
things aren't usually _too_ big.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> I waffled between "fixing the memory leak" by releasing the buffer and
> "fixing the static-ness" as in this patch. I can see arguments both ways
> and don't have any strong opinion.

I think this is a good fix for now as it takes as back to the pre-bug
state.  The only downside with the static buffer is that it's not
reentrant.  Since the function is just inherently writing out the result
and then forgetting it, in a single thread there's no opportunity for a
sub-function to try writing another packet. And I don't think we have
any code paths that write packets from multiple threads. That may be
something we do eventually, but we can deal with it then (and until
then, it's nice to avoid the malloc/free overhead).

-Peff
