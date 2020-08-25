Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A92DC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD1F20738
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYVqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:46:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:40790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHYVqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 17:46:16 -0400
Received: (qmail 3137 invoked by uid 109); 25 Aug 2020 21:46:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 21:46:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3306 invoked by uid 111); 25 Aug 2020 21:46:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 17:46:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 17:46:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 0/7] Better threaded delta resolution in index-pack
 (another try)
Message-ID: <20200825214615.GA1476535@coredump.intra.peff.net>
References: <20200824220829.GA802799@coredump.intra.peff.net>
 <20200825181145.1091378-1-jonathantanmy@google.com>
 <20200825211836.GA1448402@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825211836.GA1448402@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 05:18:36PM -0400, Jeff King wrote:

> Still maxes out at the number of physical cores (not unexpected, but
> that was the thing I was most curious about ;) ). I may run it on the
> 40-core machine, too. It's possible that with the new threading we're
> able to do better going past 20-threads. I doubt it, because I think
> it's mostly a function of Git's locking granularity, but worth checking.

For the curious (I know you were all on the edge of your seat):

  5302.3: index-pack 0 threads                    519.23(479.10+40.10) 
  5302.4: index-pack 1 threads                    525.94(476.27+49.64) 
  5302.5: index-pack 2 threads                    271.82(458.93+55.52) 
  5302.6: index-pack 5 threads                    115.88(463.84+50.69) 
  5302.7: index-pack 10 threads                   67.26(478.37+57.38)  
  5302.8: index-pack 20 threads                   43.02(524.01+77.33)  
  5302.9: index-pack 40 threads                   33.42(709.86+100.24) 
  5302.10: index-pack 80 threads                  32.02(1030.75+228.28)
  5302.11: index-pack default number of threads   43.58(551.13+68.92)  

So it actually does do a slight improvement to go from 20 to 40 threads
on this repository/machine combo. Not enough to make me revise the code
I sent the other day, though. And we still get nothing from going past
the number of physical cores.

-Peff
