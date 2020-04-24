Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0131AC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D3E2075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgDXFm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:42:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:38414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725554AbgDXFm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 01:42:28 -0400
Received: (qmail 19904 invoked by uid 109); 24 Apr 2020 05:42:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 05:42:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23374 invoked by uid 111); 24 Apr 2020 05:53:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 01:53:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Apr 2020 01:42:27 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 4/4] pack-bitmap: pass object filter to fill-in traversal
Message-ID: <20200424054227.GE1648190@coredump.intra.peff.net>
References: <cover.1587597151.git.me@ttaylorr.com>
 <65467a058e7dca6cf1e2db9cdab81513989b5db0.1587597151.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65467a058e7dca6cf1e2db9cdab81513989b5db0.1587597151.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 05:13:35PM -0600, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> Sometimes a bitmap traversal still has to walk some commits manually,
> because those commits aren't included in the bitmap packfile (e.g., due
> to a push or commit since the last full repack). If we're given an
> object filter, we don't pass it down to this traversal. It's not
> necessary for correctness because the bitmap code has its own filters to
> post-process the bitmap result (which it must, to filter out the objects
> that _are_ mentioned in the bitmapped packfile).
> 
> And with blob filters, there was no performance reason to pass along
> those filters, either. The fill-in traversal could omit them from the
> result, but it wouldn't save us any time to do so, since we'd still have
> to walk each tree entry to see if it's a blob or not.
> 
> But now that we support tree filters, there's opportunity for savings. A
> tree:depth=0 filter means we can avoid accessing trees entirely, since
> we know we won't them (or any of the subtrees or blobs they point to).

s/won't them/won't include them/ perhaps

> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> index b629a211f9..95379b1d4e 100755
> --- a/t/perf/p5310-pack-bitmaps.sh
> +++ b/t/perf/p5310-pack-bitmaps.sh
> @@ -95,4 +95,9 @@ test_perf 'pack to file (partial bitmap)' '
>  	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
>  '
>  
> +test_perf 'rev-list with tree filter (partial bitmap)' '
> +	git rev-list --use-bitmap-index --count --objects --all \
> +		--filter=tree:0 >/dev/null
> +'

This covers perf testing of this partial-bitmap state, but we shoudl
make sure that we are covering correctness, too. I think so, because
t6113 creates a similar state for all of its tests.

-Peff
