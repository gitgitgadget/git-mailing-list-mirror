Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8F020357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754452AbdGNPc2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:32:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:40830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754175AbdGNPc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 11:32:27 -0400
Received: (qmail 24637 invoked by uid 109); 14 Jul 2017 15:32:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 15:32:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12187 invoked by uid 111); 14 Jul 2017 15:32:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 11:32:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 11:32:25 -0400
Date:   Fri, 14 Jul 2017 11:32:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Reducing redundant build at Travis?
Message-ID: <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net>
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
 <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
 <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
 <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net>
 <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 07:54:16AM -0700, Junio C Hamano wrote:

> > The "git test" script[1] uses this strategy with git-notes as the
> > storage, and I've found it quite useful. I don't think we can rely on
> > git-notes, but I think Travis gives us some storage options. Even just a
> > best-effort cache directory would probably be sufficient (this is an
> > optimization, after all).
> 
> We do seem to use some persistence to order prove tests already, but
> I do not think it helps the common case, where my end-of-day push
> pushes out 'maint' and 'v2.13.3' at the same time, because the push
> is made with "git push --follow-tags $there maint master next pu"
> and the new tag happens to be at 'maint'.  It would be nice if
> Travis runs were sequential, but I often observe that it creates
> jobs for these multiple branches and tags pushed at the same time,
> and start running a few of them.

Ah, right, I didn't think about how these are racing. You'd need storage
which allows some kind of atomic operation to "claim" the tree as a
work-in-progress (and anybody who loses the race to get the lock would
have to spin waiting for the winner to tell them the real status).

I don't know if Travis's cache storage is up to that challenge. We could
probably build such a lock on top of third-party storage, but things are
rapidly getting more complex.

-Peff
