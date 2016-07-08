Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BC52023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbcGHJEK (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:04:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:41831 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754193AbcGHJEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:04:04 -0400
Received: (qmail 4698 invoked by uid 102); 8 Jul 2016 09:04:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:04:05 -0400
Received: (qmail 11746 invoked by uid 107); 8 Jul 2016 09:04:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:04:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:04:01 -0400
Date:	Fri, 8 Jul 2016 05:04:01 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] write_file cleanups
Message-ID: <20160708090400.GA26594@sigill.intra.peff.net>
References: <577EB546.1090007@web.de>
 <20160707203157.GA11804@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607080834340.6426@virtualbox>
 <20160708065650.GA10664@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708065650.GA10664@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 02:56:50AM -0400, Jeff King wrote:

> > This is more an illustration of unnecessarily duplicated code, isn't it?
> > There are *tons* of instances in Git's code where writing to a file is
> > implemented separately (and differently).
> > 
> > It would make tons of sense to consolidate all of these instances,
> > methinks. The diffstat should look *very* pleasing.
> 
> I grepped for O_WRONLY, and there are fewer instances than I would have
> thought. Most of the obvious write_file() candidates are in the merge
> code, which is probably why you saw so many of them. :)
> 
> I started at converting a few sites, but it's actually a little awkward
> because they all have strbufs (with a ptr/len combo that _could_ contain
> NULs, but probably doesn't), and write_file() wants to take a format
> string.
> 
> I think we can clean that up, though. I'll hopefully have a series in a
> few minutes.

Here it is. There actually weren't that many spots to clean up, as quite
a few of them have a "twist" where they want to do something clever,
like open the file and feed the descriptor to a sub-function, or open
with funny things like O_EXCL.

But still, the diffstat is pleasing:

 builtin/am.c     | 25 +++++++----------
 builtin/branch.c |  5 +---
 builtin/config.c |  2 +-
 builtin/merge.c  | 45 ++++--------------------------
 cache.h          | 17 ++++++++++--
 wrapper.c        | 52 ++++++++---------------------------
 6 files changed, 44 insertions(+), 102 deletions(-)

and that even includes adding some function documentation.

The most interesting thing is that I also found a real bug, albeit a
fairly minor one. I floated that up to the front of the series.

  [1/8]: config: fix bogus fd check when setting up default config
  [2/8]: am: ignore return value of write_file()
  [3/8]: branch: use non-gentle write_file for branch description
  [4/8]: write_file: drop "gently" form
  [5/8]: write_file: use xopen
  [6/8]: write_file: add pointer+len variant
  [7/8]: write_file: add format attribute
  [8/8]: use write_file_buf where applicable

-Peff
