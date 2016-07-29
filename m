Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042771F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbcG2AVo (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:21:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:50692 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752309AbcG2AVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:21:43 -0400
Received: (qmail 12585 invoked by uid 102); 29 Jul 2016 00:21:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:21:44 -0400
Received: (qmail 29936 invoked by uid 107); 29 Jul 2016 00:22:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:22:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 20:21:40 -0400
Date:	Thu, 28 Jul 2016 20:21:40 -0400
From:	Jeff King <peff@peff.net>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
Message-ID: <20160729002140.GC9646@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 04:35:58PM -0700, Linus Torvalds wrote:

> Now, it would be lovely if the new builtin git-am really was *so* fast
> that it applies a 100+-patch series in under a second, but no, that's
> not it. It's just that it only looks up the current time once.
> 
> That seems entirely accidental, I think that what happened is that
> "ident_default_date()" just ends up initializing the default date
> string once, and then the date is cached there, because it's now run
> as a single process for the whole series.
> 
> I think I'd rather get the "real" commit dates, even if they show that
> git only does a handful of commits a second rather than hundreds of
> commits..
> 
> Something that just clears git_default_date in between "git am"
> iterations, perhaps?

Yeah, your analysis makes sense and I think clearing the date between
patches is a reasonable solution.

I do wonder if you would be happier giving each commit a "fake"
monotonically increasing time, so they are correctly ordered by commit
date. I think that runs into some bizarre corner cases, though, like
adding 100 patches in 5 seconds, and ending up with commit timestamps
just slightly in the future (which is fine if you're then quiet, but
skews if you then follow-up in the next 95 seconds with another commit).
Compared to skew, having chunks of 20 commits with identical time stamps
is probably slightly less bad. At least it reflects reality.

-Peff
