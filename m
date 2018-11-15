Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79D21F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 14:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbeKPA5E (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 19:57:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:40622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387839AbeKPA5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 19:57:03 -0500
Received: (qmail 3856 invoked by uid 109); 15 Nov 2018 14:48:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 14:48:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16328 invoked by uid 111); 15 Nov 2018 14:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 09:48:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 09:48:54 -0500
Date:   Thu, 15 Nov 2018 09:48:54 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: approxidate woes
Message-ID: <20181115144854.GB16450@sigill.intra.peff.net>
References: <20181115134528.GA21242@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115134528.GA21242@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 02:45:28PM +0100, Andreas Krey wrote:

> I've now located why our backup repo shrinks every month:
> 
>   git gc --prune=2d
> 
> doesn't do what I expected, and differs a lot from --prune=48h.

Yeah, it understands "2 days", but not "d" as a unit.

I don't think "48h" does what you expect either:

  $ t/helper/test-date approxidate now
  now -> 2018-11-15 14:43:32 +0000

  $ t/helper/test-date approxidate 48h
  48h -> 2018-11-15 14:43:34 +0000

  $ t/helper/test-date approxidate 48.hours
  48.hours -> 2018-11-13 14:43:38 +0000

It might be reasonable to teach approxidate these obvious shorthands
(one tricky one is "m"; normally I'd say "minute", but in Git timescales
"month" is more likely).

> Mildly irritating, and worse, hard to find in the documentation.
> I failed at the latter and fell back to the sources, finding
> './bin-wrappers/test-date approxidate' for trying.
> 
> Where would I look?

I don't think approxidate is really documented at all. It started as
Linus's idea of "handle what people would probably say", and the fixes
over the years have mostly been "eh, that's crazy, let's do better with
this input".

You'd have to reverse engineer it a bit from the source, unfortunately.

-Peff
