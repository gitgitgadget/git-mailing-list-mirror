Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F6D1F462
	for <e@80x24.org>; Tue, 28 May 2019 21:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfE1VaH (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:30:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:40530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726492AbfE1VaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:30:06 -0400
Received: (qmail 5621 invoked by uid 109); 28 May 2019 21:30:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 21:30:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18513 invoked by uid 111); 28 May 2019 21:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 17:30:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 17:30:04 -0400
Date:   Tue, 28 May 2019 17:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Message-ID: <20190528213004.GF24650@sigill.intra.peff.net>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 06:45:18PM +0000, Vanak, Ibrahim wrote:

> BUT still I have significant slowness(50 times slower than clone on
> linux machine) while cloning. HPUX box is having very good H/W
> configuration and network is also stable.

From your output:

> [hpux]
> Receiving objects: 100% (63627/63627), 681.90 MiB | 111.00 KiB/s, done.
> [linux]
> Receiving objects: 100% (63627/63627), 681.90 MiB | 5.59 MiB/s, done.

The main things going on there are:

  1. we're getting the bytes over the network

  2. we're computing a sha1 on the stream we're getting

  3. we're zlib inflating any non-delta objects we find and computing
     their sha1

  4. we're checking the filesystem to see if we have other copies of any
     of those objects

For (2) and (3) it could be that the sha1 implementation is not quite as
fast. But 50x is much larger than I'd expect. If you've built Git from
source, you could try running "t/helper/test-sha1 <big-file" and timing
the result. That would isolate sha1 performance.  If it's slow, try
building with "make BLK_SHA1=Yes" or "make OPENSSL_SHA1=Yes" and see if
that's faster.

For (4), we'll have to stat() in .git/objects to see if we have a loose
version of the object. That can be slow if you have a really terrible
NFS setup, for example. But I doubt that would still be slow in v2.21.
There we should be using the new loose-cache which will only readdir()
the object directories once.

If neither of those pan out, it seems like the network is slow? Or maybe
ssh? Or pipes passing data from clone to index-pack?

-Peff
