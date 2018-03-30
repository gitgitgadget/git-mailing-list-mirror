Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162401F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeC3U7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:59:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752568AbeC3U7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:59:08 -0400
Received: (qmail 31688 invoked by uid 109); 30 Mar 2018 20:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 20:59:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 522 invoked by uid 111); 30 Mar 2018 21:00:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 17:00:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 16:59:06 -0400
Date:   Fri, 30 Mar 2018 16:59:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 08/13] pack-objects: shrink z_delta_size field in
 struct object_entry
Message-ID: <20180330205905.GG14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-9-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-9-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:48AM +0100, Nguyễn Thái Ngọc Duy wrote:

> We only cache deltas when it's smaller than a certain limit. This limit
> defaults to 1000 but save its compressed length in a 64-bit field.
> Shrink that field down to 16 bits, so you can only cache 65kb deltas.
> Larger deltas must be recomputed at when the pack is written down.

Unlike the depth, I don't think there's any _inherent_ reason you
couldn't throw, say, 1MB deltas into the cache (if you sized it large
enough). But I doubt such deltas are really all that common. Here are
the top 10 in linux.git:

  $ git cat-file --batch-all-objects --batch-check='%(deltabase) %(objectsize:disk)' |
    grep -v ^00000 | sort -k 2nr | head
  a02b6794337286bc12c907c33d5d75537c240bd0 769103
  b28d4b64c05da02c5e8c684dcb9422876225ebdc 327116
  1e98ce86ed19aff9ba721d13a749ff08088c9922 325257
  a02b6794337286bc12c907c33d5d75537c240bd0 240647
  c550d99286c01867dfb26e432417f3106acf8611 177896
  5977795854f852c2b95dd023fd03cace023ee41c 119737
  4ccf9681c45d01d17376f7e0d266532a4460f5f8 112671
  b39fb6821faa9e7bc36de738152a2817b4bf3654 112657
  2645d6239b74bebd661436762e819b831095b084 103980
  b8ce7fe5d8def58dc63b7ae099eff7bd07e4e845 101014

It's possible some weird workload would want to tweak this. Say you were
storing a ton of delta-capable files that were big and always differed
by a megabyte. And it was somehow really important to you to tradeoff
memory for CPU during the write phase of a pack.

That seems pretty unlikely to bite anybody (and that was the best I
could come up with as a devil's advocate against it).

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt |  3 ++-
>  builtin/pack-objects.c   | 22 ++++++++++++++++------
>  pack-objects.h           |  3 ++-
>  3 files changed, 20 insertions(+), 8 deletions(-)

Patch looks OK.

-Peff
