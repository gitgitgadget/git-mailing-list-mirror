Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EB420193
	for <e@80x24.org>; Thu, 11 Aug 2016 17:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbcHKRUz (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 13:20:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:53652 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751212AbcHKRUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 13:20:54 -0400
Received: (qmail 25870 invoked by uid 109); 11 Aug 2016 17:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 17:20:53 +0000
Received: (qmail 11157 invoked by uid 111); 11 Aug 2016 17:20:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 13:20:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 13:20:50 -0400
Date:	Thu, 11 Aug 2016 13:20:50 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: Re: [PATCH] gc: default aggressive depth to 50
Message-ID: <20160811172050.44abuvwcn6gmcgk7@sigill.intra.peff.net>
References: <20160811161309.ecmebaafcz6rkg6o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160811161309.ecmebaafcz6rkg6o@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 12:13:09PM -0400, Jeff King wrote:

> Here are the numbers for linux.git:
> 
>    depth |  size |  %    | rev-list |  %     | log -Sfoo |   %
>   -------+-------+-------+----------+--------+-----------+-------
>     250  | 967MB |  n/a  | 48.159s  |   n/a  | 378.088   |   n/a
>     100  | 971MB | +0.4% | 41.471s  | -13.9% | 342.060   |  -9.5%
>      50  | 979MB | +1.2% | 37.778s  | -21.6% | 311.040s  | -17.7%
>      10  | 1.1GB | +6.6% | 32.518s  | -32.5% | 279.890s  | -25.9%
> [...]
> 
> You can see that that the CPU savings for regular operations improves as we
> decrease the depth. The savings are less for "rev-list" on a smaller repository
> than they are for blob-accessing operations, or even rev-list on a larger
> repository. This may mean that a larger delta cache would help (though setting
> core.deltaBaseCacheLimit by itself doesn't).

The problem with deltaBaseCacheLimit is that it only changes the memory
parameter, but there are a fixed number of slots in the data structure.
Bumping it like this:

diff --git a/sha1_file.c b/sha1_file.c
index 02940f1..ca79703 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2073,7 +2073,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	return buffer;
 }
 
-#define MAX_DELTA_CACHE (256)
+#define MAX_DELTA_CACHE (1024)
 
 static size_t delta_base_cached;
 

along with the cache size does help (this was discussed a year or two
ago, but nobody ever followed up with numbers or patches).

Here are best-of-3 numbers for rev-list on linux.git at each depth with
that patch and "-c core.deltabasecachelimit=256m":

  depth |   time
  ----------------
   250  | 36.524s
   100  | 33.200s
    50  | 31.065s
    10  | 28.266s

So there's clearly a lot of room for improvement on the reading side in
general. And doing so clearly lessens the impact of the delta chains.
But you still get a 15% improvement moving to depth=50, versus only a
1.2% storage increase. So I don't think it fundamentally changes the
conclusion of the "depth=50" patch I'm responding to.

I don't think bumping MAX_DELTA_CACHE naively is a good idea, though. I
seem to recall that it has scaling problems as it grows, so we may want
a better data structure (but I haven't looked at it recently enough to
say anything intelligent). I might work on it in the near future, but if
anybody is interested, please be my guest.

-Peff
