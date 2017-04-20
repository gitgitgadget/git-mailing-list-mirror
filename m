Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07DFD1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 15:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970883AbdDTPuK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 11:50:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:36879 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970831AbdDTPuK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 11:50:10 -0400
Received: (qmail 15077 invoked by uid 109); 20 Apr 2017 15:50:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 15:50:05 +0000
Received: (qmail 4367 invoked by uid 111); 20 Apr 2017 15:50:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 11:50:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 11:50:03 -0400
Date:   Thu, 20 Apr 2017 11:50:03 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
Message-ID: <20170420155003.cugkol6rbv25lpdi@sigill.intra.peff.net>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
 <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
 <alpine.DEB.2.20.1704201231350.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704201231350.3480@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 12:40:52PM +0200, Johannes Schindelin wrote:

> > > Teach register_rename_src() to see if new file pair can simply be
> > > appended to the rename_src[] array before performing the binary search
> > > to find the proper insertion point.
> > 
> > I guess your perf results show some minor improvement. But I suspect
> > this is because your synthetic repo does not resemble the real world
> > very much.
> 
> Please note that the synthetic test repo was added *after* coming up with
> the patch, *after* performance benchmarking on a certain really big
> repository (it is not hard to guess what use case we are optimizing,
> right?).
> 
> In that light, I would like to register the fact that Jeff's performance
> work is trying to improve a very real world, that of more than 2,000
> developers in our company [*1*].

Sure; I didn't think it came out of thin air. What are the benchmarks on
this real-world repository, then?

Specifically, it looks like this optimization isn't really about the
number of files in the repository so much as the number of
additions/deletions in a particular diff (which is what become rename
sources and destinations).

Is it common to add or delete 4 million tiny files and then run "git
status"?

Note that I think the optimization probably _is_ worth doing in the
general case. These "is it sorted" tradeoffs can backfire if we
sometimes get unsorted input, but I don't think that would ever be the
case here. My main complaint is not that it's not worth doing, but that
I'm not excited about sprinkling these checks ad-hoc throughout the code
base.

-Peff
