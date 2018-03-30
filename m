Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40191FAE5
	for <e@80x24.org>; Fri, 30 Mar 2018 20:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeC3Uxt (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:53:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:49430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752568AbeC3Uxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:53:48 -0400
Received: (qmail 31446 invoked by uid 109); 30 Mar 2018 20:53:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 20:53:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 487 invoked by uid 111); 30 Mar 2018 20:54:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 16:54:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 16:53:46 -0400
Date:   Fri, 30 Mar 2018 16:53:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 07/13] pack-objects: refer to delta objects by index
 instead of pointer
Message-ID: <20180330205346.GF14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-8-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-8-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:47AM +0100, Nguyễn Thái Ngọc Duy wrote:

> These delta pointers always point to elements in the objects[] array
> in packing_data struct. We can only hold maximum 4G of those objects
> because the array size in nr_objects is uint32_t. We could use
> uint32_t indexes to address these elements instead of pointers. On
> 64-bit architecture (8 bytes per pointer) this would save 4 bytes per
> pointer.
> 
> Convert these delta pointers to indexes. Since we need to handle NULL
> pointers as well, the index is shifted by one [1].
> 
> [1] This means we can only index 2^32-2 objects even though nr_objects
>     could contain 2^32-1 objects. It should not be a problem in
>     practice because when we grow objects[], nr_alloc would probably
>     blow up long before nr_objects hits the wall.

Hmm, that may be something we eventually fix. I suspect all of this code
does some pretty horrible things as you approach 2^32 objects, though.
I've never tried to make such a pack, but it may be within the realm of
possibility. The .idx file would be 80+GB, but the packfile might not be
much bigger if specially crafted.

I guess that's outside the realm of reasonable, though, so we can assume
that nobody would _really_ want to do that anytime soon. And anything
malicious would probably die long before this code triggers.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/pack-objects.c | 116 ++++++++++++++++++++++-------------------
>  pack-objects.h         |  67 ++++++++++++++++++++++--
>  2 files changed, 124 insertions(+), 59 deletions(-)

The patch itself looks OK. This is one of the nicer ones, because it
really doesn't involve any extra storage management, just some accessor
functions.

-Peff
