Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE631F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750801AbeCXGkN (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:40:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:41174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750769AbeCXGkN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:40:13 -0400
Received: (qmail 1728 invoked by uid 109); 24 Mar 2018 06:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Mar 2018 06:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4549 invoked by uid 111); 24 Mar 2018 06:41:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 24 Mar 2018 02:41:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Mar 2018 02:40:10 -0400
Date:   Sat, 24 Mar 2018 02:40:10 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180324064010.GA30422@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
 <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
 <20180323024609.GA12229@sigill.intra.peff.net>
 <20180323055027.GA30227@sigill.intra.peff.net>
 <4395a668-845e-a66f-2a14-f6a4474c3d4b@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4395a668-845e-a66f-2a14-f6a4474c3d4b@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 04:01:50PM +0000, Ramsay Jones wrote:

> Not that it matters, but I assume this was something like:
> 
>   $ time (echo HEAD | git cat-file --batch-check="%(objectsize:disk)")
> 
> ... and I suspect it was on the linux.git repo, yes?

Yes to both.

> If I do this on my biggest repo (ffmpeg), I get:
> 
>   $ cd ../ffmpeg/
> 
>   $ time (echo HEAD | git cat-file --batch-check="%(objectsize:disk)")
>   227
> 
>   real	0m0.037s
>   user	0m0.020s
>   sys	0m0.004s
> 
>   $ time (echo HEAD | ../git/git-cat-file --batch-check="%(objectsize:disk)")
>   227
> 
>   real	0m0.146s
>   user	0m0.112s
>   sys	0m0.012s
> 
>   $ 
> 
> Where I'm using a version with my patch applied, rather than
> reverting commit 8b8dfd5132. A 395% slowdown is bad enough, but
> not as bad as a factor of 11! I bet you have a much more modern
> system (with a fast SSD) than my old laptop. :-D

Yes, though it was all being run out of disk cache anyway. I also have a
lot of RAM. :)

The ffmpeg repository only has ~550k objects. So that's log(19), and
we'd expect radix to be something like 8-9x faster than a comparison
sort. But at some point the constants take over too (each O(n) round the
radix sort actually has to look at the items twice, and of course there
are negative cache effects when duplicating the array).

So your numbers match what I'd expect.

> Thanks for looking into this, even if it was a wild
> goose chase. :)

No problem. I think it's nice to sanity check my own hand-waving once in
a while. ;)

-Peff
