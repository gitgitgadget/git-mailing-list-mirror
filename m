Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FE11F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 08:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeCUIYq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 04:24:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:37216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751514AbeCUIYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 04:24:43 -0400
Received: (qmail 4297 invoked by uid 109); 21 Mar 2018 08:24:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 08:24:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8435 invoked by uid 111); 21 Mar 2018 08:25:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 04:25:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 04:24:41 -0400
Date:   Wed, 21 Mar 2018 04:24:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180321082441.GB25537@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180318142526.9378-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 03:25:15PM +0100, Nguyễn Thái Ngọc Duy wrote:

> v6 fixes the one optimization that I just couldn't get right, fixes
> two off-by-one error messages and a couple commit message update
> (biggest change is in 11/11 to record some numbers from AEvar)

I was traveling during some of the earlier rounds, so I finally got a
chance to take a look at this.

I hate to be a wet blanket, but am I the only one who is wondering
whether the tradeoffs is worth it? 8% memory reduction doesn't seem
mind-bogglingly good, and I'm concerned about two things:

  1. The resulting code is harder to read and reason about (things like
     the DELTA() macros), and seems a lot more brittle (things like the
     new size_valid checks).

  2. There are lots of new limits. Some of these are probably fine
     (e.g., the cacheable delta size), but things like the
     number-of-packs limit don't have very good user-facing behavior.
     Yes, having that many packs is insane, but that's going to be small
     consolation to somebody whose automated maintenance program now
     craps out at 16k packs, when it previously would have just worked
     to fix the situation.

Saving 8% is nice, but the number of objects in linux.git grew over 12%
in the last year. So you've bought yourself 8 months before the problem
is back. Is it worth making these changes that we'll have to deal with
for many years to buy 8 months of memory savings?

I think ultimately to work on low-memory machines we'll need a
fundamentally different approach that scales with the objects since the
last pack, and not with the complete history.

-Peff
