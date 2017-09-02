Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C13C208CD
	for <e@80x24.org>; Sat,  2 Sep 2017 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbdIBIFn (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 04:05:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:55618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751510AbdIBIFm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 04:05:42 -0400
Received: (qmail 26042 invoked by uid 109); 2 Sep 2017 08:05:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 08:05:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9125 invoked by uid 111); 2 Sep 2017 08:06:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 04:06:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Sep 2017 04:05:35 -0400
Date:   Sat, 2 Sep 2017 04:05:35 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
Message-ID: <20170902080535.j7dommmxowpbk2no@sigill.intra.peff.net>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830185922.10107-2-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 06:59:22PM +0000, Jeff Hostetler wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This is to address concerns raised by ThreadSanitizer on the
> mailing list about threaded unprotected R/W access to map.size with my previous
> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).  See:
> https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
> 
> Add API to hashmap to disable item counting and to disable automatic rehashing.  
> Also include APIs to re-enable item counting and automatica rehashing.

It may be worth summarizing the discussion at that thread here.

At first glance, it looks like this is woefully inadequate for allowing
multi-threaded access. But after digging, the issue is that we're really
trying to accommodate one specific callers which is doing its own
per-bucket locking, and which needs the internals of the hashmap to be
truly read-only.

I suspect the code might be easier to follow if that pattern were pushed
into its own threaded_hashmap that disabled the size and handled the
mod-n locking, but I don't insist on that as a blocker to this fix.

-Peff
