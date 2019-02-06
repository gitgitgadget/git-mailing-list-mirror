Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686DE1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 21:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfBFV3b (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 16:29:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:35154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725982AbfBFV3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 16:29:31 -0500
Received: (qmail 23244 invoked by uid 109); 6 Feb 2019 21:29:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 21:29:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5931 invoked by uid 111); 6 Feb 2019 21:29:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 16:29:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 16:29:29 -0500
Date:   Wed, 6 Feb 2019 16:29:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 8/8] remote-curl: in v2, fill credentials if needed
Message-ID: <20190206212928.GB12737@sigill.intra.peff.net>
References: <cover.1549411880.git.jonathantanmy@google.com>
 <8d5ff2fc224e2ce7981bcae492de02a622889208.1549411880.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d5ff2fc224e2ce7981bcae492de02a622889208.1549411880.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 04:21:22PM -0800, Jonathan Tan wrote:

> In post_rpc(), remote-curl calls credential_fill() if HTTP_REAUTH is
> returned, but this is not true in proxy_request(). Do this in
> proxy_request() too.

Can we do this as a general rule? If we look at the code in post_rpc(),
there are two cases: when large_request is set and when it is not.

When it's not, we have the whole request in a buffer, and we can happily
resend it.

But when it's not, we cannot restart it, because we'll have thrown away
some of the data. So we send an initial probe_rpc() as a sanity check.
If that works and we later get a 401 on the real request, we still fail
anyway.

In the case of proxy_request(), we don't know ahead of time whether the
request is large or not; we just proxy the data through. And we don't do
the probe thing at all. So wouldn't we dropping some data for the
follow-up request?

-Peff
