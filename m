Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366AB1F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdH2Qul (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 12:50:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:52042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751180AbdH2Quk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 12:50:40 -0400
Received: (qmail 27595 invoked by uid 109); 29 Aug 2017 16:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 16:50:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11830 invoked by uid 111); 29 Aug 2017 16:51:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 12:51:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 12:50:38 -0400
Date:   Tue, 29 Aug 2017 12:50:38 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH 2/3] merge-recursive: remove return value from
 get_files_dirs
Message-ID: <20170829165038.xk6yluuqnzbujodq@sigill.intra.peff.net>
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-3-kewillf@microsoft.com>
 <20170829081752.nq5r776rjyf2amzh@sigill.intra.peff.net>
 <DM2PR21MB0041575B6D9EE53A07C7D3EDB79F0@DM2PR21MB0041.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM2PR21MB0041575B6D9EE53A07C7D3EDB79F0@DM2PR21MB0041.namprd21.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 03:58:00PM +0000, Kevin Willford wrote:

> > > The return value of the get_files_dirs call is never being used.
> > > Looking at the history of the file and it was originally only
> > > being used for debug output statements.  Also when
> > > read_tree_recursive return value is non zero it is changed to
> > > zero.  This leads me to believe that it doesn't matter if
> > > read_tree_recursive gets an error.
> > 
> > Or that the function is buggy. :)
> 
> That was one of my questions as well.  Should read_tree_recursive
> be propagating a -1 and merge_trees be checking for that and bail
> when the call to get_files_dirs return is < 0?  I made a commit with
> this change and ran the tests and they all still passed so either this
> return really doesn't matter or there are not sufficient tests covering
> it.

Right, in a normal flow I'd say that it should propagate the -1, etc.
But since the only possible error is parse_tree() failing, which happens
in a corrupt repository, I think it would be OK to just die(). That
saves having to deal with error propagation. It's not very graceful,
perhaps, but the important thing is that we don't quietly ignore the
error.

> I went with this change because it was not changing any of the
> current functionality and if we find a case where it matters that
> read_tree_recursive fails due to bad tree or something else we
> can address it then.

I think it's worth doing while we're thinking about it now, but it
certainly can be a separate patch.

-Peff
