Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8053220248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfCUUCd (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:02:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:59794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728093AbfCUUCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:02:33 -0400
Received: (qmail 25863 invoked by uid 109); 21 Mar 2019 20:02:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 20:02:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12742 invoked by uid 111); 21 Mar 2019 20:02:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 16:02:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 16:02:31 -0400
Date:   Thu, 21 Mar 2019 16:02:31 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
Message-ID: <20190321200231.GD19427@sigill.intra.peff.net>
References: <20190321174719.151877-1-jonathantanmy@google.com>
 <20190321195536.GC19427@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321195536.GC19427@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 03:55:37PM -0400, Jeff King wrote:

> I am a little confused about v2 here, though. It should hit the initial
> info/refs endpoint the same as usual. If it's a noop fetch, then it's
> done. Otherwise, we'd hit the git-upload-pack and expect to require
> authentication. That should work after your switch to using post_rpc,
> shouldn't it?
> 
> And I guess it does, because you did not delete the test before "clone
> from auth-only-for-objects repository", which would actually do the
> second half of that conversation, and require authentication. You're
> only deleting the part that does the noop fetch.
> 
> Puzzled...

Ah, nevermind. I forgot that v2 really will make two requests for this
noop case. The initial endpoint hit only returns the capabilities and
nothing else. And that's inherent in the protocol.

I'm OK with dropping this test, but I think my reasoning is slightly
different than what you wrote. The interesting bits are actually
happening in the test _before_ this one, which are exercising the
gzipped auth-retry code. And that happens in both protocol v0 and v2.

The test you're deleting is basically just verifying that our apache
config is indeed "half-auth". Because in v0, the server is never even
going to ask for credentials, so no interesting code paths in the client
are triggered. So it's not actually testing anything of interest.

-Peff
