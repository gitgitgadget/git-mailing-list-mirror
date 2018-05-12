Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D171F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbeELJlI (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:41:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:37142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750722AbeELJlI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:41:08 -0400
Received: (qmail 25302 invoked by uid 109); 12 May 2018 09:41:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:41:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13807 invoked by uid 111); 12 May 2018 09:41:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:41:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:41:06 -0400
Date:   Sat, 12 May 2018 05:41:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/12] Die commit->util, die!
Message-ID: <20180512094105.GH28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:00:16AM +0200, Nguyễn Thái Ngọc Duy wrote:

> There's not much to write here. It's basically a copy from 12/12:
> 
> This 'util' pointer can be used for many different purposes,
> controlled in different ways. Some are not even contained in a command
> code, but buried deep in common code with no clue who will use it and
> how. For example, if revs.show_source is set, then it's used for
> storing path name, but if you happen to call get_merge_parent() then
> some 'util' may end up storing another thing.
> 
> The move to using commit-slab gives us a much better picture of how
> some piece of data is associated with a commit and what for. Since
> nobody uses 'util' pointer anymore, we can retire it so that nobody will
> abuse it again. commit-slab will be the way forward for associating
> data to a commit.
> 
> As a side benefit, this shrinks struct commit by 8 bytes (on 64-bit
> architecture) which should help reduce memory usage for reachability
> test a bit. This is also what commit-slab is invented for [1].

I left a few comments, but overall this looks pretty good. A few of the
conversions get tricky with the number of pointer dereferences, but most
of those were pretty tricky to begin with (that weight stuff in
bisect.c...yikes!).

I love the result. More maintainable code, less possibility of conflicts
in the util field, and a memory savings to boot.

-Peff
