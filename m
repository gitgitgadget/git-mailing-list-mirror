Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922351F42D
	for <e@80x24.org>; Thu, 31 May 2018 06:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeEaGDC (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 02:03:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:57470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753803AbeEaGDB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 02:03:01 -0400
Received: (qmail 13502 invoked by uid 109); 31 May 2018 06:03:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 06:03:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9553 invoked by uid 111); 31 May 2018 06:03:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 02:03:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 02:02:59 -0400
Date:   Thu, 31 May 2018 02:02:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit
 downstream
Message-ID: <20180531060259.GE17344@sigill.intra.peff.net>
References: <20180529211950.26896-1-avarab@gmail.com>
 <20180529212458.GC7964@sigill.intra.peff.net>
 <xmqqk1rmexng.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1rmexng.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 10:32:19AM +0900, Junio C Hamano wrote:

> If we want to also encourage people to vet their own "fetches", I am
> not against extending documentation.  It just is different from "we
> extended the mechanism to help server side protect their clients"
> that was the focus of (updated, relative to what is in the tarball)
> the description in the release notes.

I haven't tested it, but I suspect that doing multiple fetches could
result in passing bad objects through a fetch.fsckObjects filter.
Because the objects aren't quarantined on fetch, and because
fsck_finish() requires the objects to be installed into place, they may
still exist in the repository even if we end up rejecting them. Would a
subsequent fetch hit the quickfetch() code and update without actually
sending the objects again?

This problem is specific to the .gitmodules thing, I think, because the
other fsck checks are able to die much earlier (before fsck_finish).

I think in the long run fetch should implement a similar quarantine
procedure to what happens on push.

-Peff
