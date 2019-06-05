Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFD31F462
	for <e@80x24.org>; Wed,  5 Jun 2019 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFETlq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 15:41:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726305AbfFETlq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 15:41:46 -0400
Received: (qmail 2611 invoked by uid 109); 5 Jun 2019 19:41:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jun 2019 19:41:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25059 invoked by uid 111); 5 Jun 2019 19:42:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Jun 2019 15:42:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2019 15:41:43 -0400
Date:   Wed, 5 Jun 2019 15:41:43 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5551: test usage of chunked encoding explicitly
Message-ID: <20190605194143.GA12686@sigill.intra.peff.net>
References: <20190605192624.129677-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605192624.129677-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 05, 2019 at 12:26:24PM -0700, Jonathan Tan wrote:

> When run using GIT_TEST_PROTOCOL_VERSION=2, a test in t5551 fails
> because 4 POSTs (probe, ls-refs, probe, fetch) are sent instead of 2
> (probe, fetch).
> 
> One way to resolve this would be to relax the condition (from "= 2" to
> greater than 1, say), but upon further inspection, the test probably
> shouldn't be counting the number of POSTs. This test states that large
> requests are split across POSTs, but this is not correct; the main
> change is that chunked transfer encoding is used, but the request is
> still contained within one POST. (The test coincidentally works because
> Git indeed sends 2 POSTs in the case of a large request, but that is
> because, as stated above, the first POST is a probing RPC - see
> post_rpc() in remote-curl.c for more information.)

That seems reasonable. What I was really going for with this test was
just ensuring that we were actually hitting the "large request" code
path at all. And checking for chunked encoding is another way of doing
that. (And I certainly agree that "split across POSTs" is an inaccurate
way of describing what it was trying for).

> With this change, all tests pass at master with
> GIT_TEST_PROTOCOL_VERSION=2.

Yay. Thanks for your persistence with this.

-Peff
