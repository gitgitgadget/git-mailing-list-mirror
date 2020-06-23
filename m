Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DCC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477EE207F9
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbgFWSzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:55:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:40680 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733170AbgFWSy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:54:59 -0400
Received: (qmail 13081 invoked by uid 109); 23 Jun 2020 18:54:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 18:54:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19663 invoked by uid 111); 23 Jun 2020 18:54:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 14:54:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 14:54:58 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] remote-curl: use strlen() instead of magic numbers
Message-ID: <20200623185458.GD1444619@coredump.intra.peff.net>
References: <cover.1592119902.git.liu.denton@gmail.com>
 <cover.1592934880.git.liu.denton@gmail.com>
 <cb8683837c9f583274780057621255a65a1c4c9f.1592934880.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb8683837c9f583274780057621255a65a1c4c9f.1592934880.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 01:55:32PM -0400, Denton Liu wrote:

> When we are dealing with a packet-line length header, we use the magic
> literal `4`, representing the length of "0000" and "0001", the packet
> line length headers. Use `strlen("000x")` so that we do not have to use
> the magic literal.

I'm not a huge fan of using strlen() for this, because it's _still_
magical (you cannot change "0000" in one place without changing it in
another"). And while it helps with understanding that "4" matches the
length of that string, IMHO it's harder to read because now I have to
make sure that those much longer strings all match up.

This refactoring also implies to me that if you changed all of "0000" on
one line you'd be fine, but that's emphatically not true. The magic
number "4" is used to size the buffer earlier in the function, and would
have to match (and of course since this is a network protocol, it's not
like you could even change those in isolation).

So I dunno. I kind of think the raw "4" is the most readable. It's quite
obvious to me in the context of a memcpy() what's going on. I don't mind
memcpy_literal() or similar that hides the repetition, but I think it's
hard to do here because of the arithmetic on the destination.

-Peff
