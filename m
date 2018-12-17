Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D6F1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 19:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbeLQTjw (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 14:39:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:44052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726598AbeLQTjw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 14:39:52 -0500
Received: (qmail 16644 invoked by uid 109); 17 Dec 2018 19:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 19:39:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6067 invoked by uid 111); 17 Dec 2018 19:39:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 14:39:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 14:39:50 -0500
Date:   Mon, 17 Dec 2018 14:39:50 -0500
From:   Jeff King <peff@peff.net>
To:     Farhan Khan <khanzf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: pack file object size question
Message-ID: <20181217193949.GC9853@sigill.intra.peff.net>
References: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 04:52:13PM -0500, Farhan Khan wrote:

> It seems that there is a 12 byte header (signature, version, number of
> objects), then it immediately jumps into each individual object. The
> object consists of the object header, then the zlib deflated object,
> followed by a SHA1 of the above. Is this accurate?

Others discussed the length confusion, but I wanted to point out one
more thing: the packfile does not contain the sha1 of each object. That
is computed by index-pack (but there is a sha1 of the contents of the
_entire_ packfile).

A bit error on the wire will be detected by the whole-pack sha1. A bit
error on the sender's disk generally be detected by zlib, but not
always. The ultimate check that the receiver does is make sure it has
all of the expected objects by walking the object graph from the
proposed ref updates. Any object which has an undetected bit error will
appear to be be missing (as well as any object that the sender actually
just failed to send).

-Peff
