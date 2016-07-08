Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C8B72023C
	for <e@80x24.org>; Fri,  8 Jul 2016 06:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbcGHG45 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 02:56:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:41810 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753875AbcGHG4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 02:56:54 -0400
Received: (qmail 31845 invoked by uid 102); 8 Jul 2016 06:56:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 02:56:55 -0400
Received: (qmail 11260 invoked by uid 107); 8 Jul 2016 06:57:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 02:57:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 02:56:51 -0400
Date:	Fri, 8 Jul 2016 02:56:51 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: ignore return value of write_file()
Message-ID: <20160708065650.GA10664@sigill.intra.peff.net>
References: <577EB546.1090007@web.de>
 <20160707203157.GA11804@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607080834340.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607080834340.6426@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 08:37:35AM +0200, Johannes Schindelin wrote:

> > We have two forms of write_file(): one that dies, and one
> > that returns an error. However, the latter has only a single
> > caller, which immediately dies anyway (after producing a
> > message that is not really any more informative than
> > write_file's generic die(), and arguably worse because it
> > does not give the actual filename).
> 
> This is more an illustration of unnecessarily duplicated code, isn't it?
> There are *tons* of instances in Git's code where writing to a file is
> implemented separately (and differently).
> 
> It would make tons of sense to consolidate all of these instances,
> methinks. The diffstat should look *very* pleasing.

I grepped for O_WRONLY, and there are fewer instances than I would have
thought. Most of the obvious write_file() candidates are in the merge
code, which is probably why you saw so many of them. :)

I started at converting a few sites, but it's actually a little awkward
because they all have strbufs (with a ptr/len combo that _could_ contain
NULs, but probably doesn't), and write_file() wants to take a format
string.

I think we can clean that up, though. I'll hopefully have a series in a
few minutes.

-Peff
