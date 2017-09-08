Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85BA202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 07:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbdIHHtN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 03:49:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:60642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753608AbdIHHtN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 03:49:13 -0400
Received: (qmail 24091 invoked by uid 109); 8 Sep 2017 07:49:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 07:49:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6593 invoked by uid 111); 8 Sep 2017 07:49:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:49:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 03:49:10 -0400
Date:   Fri, 8 Sep 2017 03:49:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0JLQsNC70LXQvdGC0LjQvQ==?= <valiko.ua@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git shortlog -sn --follow -- <path>" counts all commits to
 entire repo
Message-ID: <20170908074910.reoyb47navgsg6kt@sigill.intra.peff.net>
References: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
 <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
 <20170908051015.ybq4egdrddecl4se@sigill.intra.peff.net>
 <xmqqo9qlzodi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9qlzodi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 03:38:17PM +0900, Junio C Hamano wrote:

> > I suspect a better solution might involve actually building on
> > log-tree.c to do the traversal (since this internal traversal is
> > supposed to be equivalent to "git log | git shortlog").
> 
> Probably.  That approach would also have an added benefit that when
> "--follow" is fixed to keep track of which path it is following per
> traversal for "git log", the result from "git shortlog --follow"
> would automatically become correct, I guess?

Yeah. It depends on exactly how such a fix is made. I think one
improvement would be to actually bump --follow handling into the
limit_list() stage, so that we properly handle history simplification
over followed paths. In which case get_revision() would just never
return the uninteresting commits, and the current shortlog code would
Just Work.

That said, I don't think we can go wrong by making shortlog's traversal
more like log's. Any changes we make to --follow will be aimed at and
tested with git-log, so the more code they share the more likely it is
that shortlog won't bitrot.

-Peff
