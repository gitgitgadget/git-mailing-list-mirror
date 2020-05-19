Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D3C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15848207D3
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgESSkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 14:40:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:51104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726447AbgESSkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 14:40:05 -0400
Received: (qmail 26296 invoked by uid 109); 19 May 2020 18:40:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 May 2020 18:40:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14615 invoked by uid 111); 19 May 2020 18:40:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 May 2020 14:40:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 May 2020 14:40:04 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] remote-curl: fix deadlocks when remote server
 disconnects
Message-ID: <20200519184004.GA88536@coredump.intra.peff.net>
References: <cover.1589816718.git.liu.denton@gmail.com>
 <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 06:53:53AM -0400, Denton Liu wrote:

> Changes since v2:
> 
> * Use if-else tower in "transport: extract common fetch_pack() call"
> 
> * Rename to `lenbuf_hex` and remove null-terminator sentence in
>   "pkt-line: extern packet_length()"
> 
> * Fix "a a" typo in "remote-curl: error on incomplete packet"
> 
> * Don't send flush packet after response end packet
> 
> * Move stateless delimiter checks closer to where message processing
>   happens in do_fetch_pack_v2()

This looks good to me, modulo the minor comment fixup from Eric. I did
have one final question, though. Our discussion focused a lot on
checking the 0002 packets in the success case. But we didn't discuss how
fetch-pack would deal with an unexpected 0002 packet (i.e., the case
that the server response is truncated, but then remote-curl tacks on its
0002).

It _seems_ to work, because that's the case your invalid-shallow test is
covering. I'm just not sure if it works consistently, or what error we
might produce in some cases (e.g., saying "woah, what's the weird 0002
packet" instead of "the server response ended unexpectedly" or
something).

I suspect any remaining issues there are cosmetic, and it might be OK to
just discover them organically through use. But if you happen to have
done some poking around there, it would be nice to hear it.

Thanks for working on this. When we had the initial discussion, I was
really worried the solution was going to be quite nasty, but I think it
turned out to be reasonably nice.

-Peff
