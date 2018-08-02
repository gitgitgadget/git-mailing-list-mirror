Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609811F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeHBVbr (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:31:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:40860 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726791AbeHBVbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:31:47 -0400
Received: (qmail 24408 invoked by uid 109); 2 Aug 2018 19:39:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 19:39:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27408 invoked by uid 111); 2 Aug 2018 19:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 15:39:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 15:39:13 -0400
Date:   Thu, 2 Aug 2018 15:39:13 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pack-objects: document about thread synchronization
Message-ID: <20180802193912.GB29084@sigill.intra.peff.net>
References: <20180729153605.27298-1-pclouds@gmail.com>
 <CACsJy8AKHo4g5607GdiuLVBy1746gEEFbsYjB2RLwvQvE24Sgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AKHo4g5607GdiuLVBy1746gEEFbsYjB2RLwvQvE24Sgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 29, 2018 at 05:46:17PM +0200, Duy Nguyen wrote:

> tOn Sun, Jul 29, 2018 at 5:36 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> >
> > These extra comments should be make it easier to understand how to use
> > locks in pack-objects delta search code. For reference, see
> 
> Side note. I wonder if we could take progress_lock() less often in
> find_deltas() to reduce contention. Right now we take the lock every
> time we check out one object_entry but we could pull like 16 items out
> of the list per lock. I don't know how much actual contention on this
> lock though so maybe not worth doing.

I doubt it really matters that much, since we hold it for such a small
amount of time (basically just a few pointer/integer tweaks). Compared
to the heavy lifting of actually loading objects, you're not likely to
see a huge amount of contention, since at any given moment most threads
will be doing that work (or actually computing deltas).

Of course I could be wrong. If you hit a point where many threads are
skipping work (e.g., because they are considering deltas from objects in
the same pack, and skip forward without actually doing any work), then
they'd be ripping through the find_deltas() loop pretty quickly.

OTOH, in cases like that (and the ultimate case would just be running
"git repack -ad" twice in a row), the compression phase seems to go
quite quickly, implying we're not spending a lot of time there.

-Peff
