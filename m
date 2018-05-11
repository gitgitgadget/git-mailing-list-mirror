Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D86B1F42D
	for <e@80x24.org>; Fri, 11 May 2018 08:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeEKIh0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 04:37:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:35954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752174AbeEKIhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 04:37:25 -0400
Received: (qmail 20756 invoked by uid 109); 11 May 2018 08:37:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 08:37:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31600 invoked by uid 111); 11 May 2018 08:37:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 04:37:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 04:37:23 -0400
Date:   Fri, 11 May 2018 04:37:23 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Fix mem leaks of recent object store conversions.
Message-ID: <20180511083723.GB22086@sigill.intra.peff.net>
References: <20180510195849.28023-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510195849.28023-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 12:58:45PM -0700, Stefan Beller wrote:

> This series replaces the two commits that were queued on sb/object-store-replace,
> fixing memory leaks that were recently introduced.
> 
> Compared to v1, I merged the two independent series from yesterday,
> rewrote the commit message to clear up Junios confusion and addresses Peffs
> comments for the packfiles as well.

Mostly. :)

My one remaining complaint is that the bitmap code may hold on to a
dangling pointer to a packed_git after this series.

I think that is part of a larger problem, though, which is that the
bitmap code's globals need to be part of the struct raw_object_store.
I think this can already cause problems before your series if we were to
try to use bitmaps in both a superproject and a submodule in the same
process, though I think we'd at least hit the "ignoring extra bitmap
file" code path in open_pack_bitmap_1(). So right now it's an annoyance,
but after your series it becomes a potential segfault.

-Peff
