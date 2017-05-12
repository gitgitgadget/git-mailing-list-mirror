Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F9820188
	for <e@80x24.org>; Fri, 12 May 2017 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756785AbdELJAh (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 05:00:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:50214 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756114AbdELJAf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 05:00:35 -0400
Received: (qmail 2760 invoked by uid 109); 12 May 2017 09:00:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 09:00:34 +0000
Received: (qmail 22356 invoked by uid 111); 12 May 2017 09:01:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 05:01:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 05:00:33 -0400
Date:   Fri, 12 May 2017 05:00:33 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] interpret-trailers + commit -v bugfix
Message-ID: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
References: <20170512050347.30765-1-bmalehorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512050347.30765-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:03:44PM -0700, Brian Malehorn wrote:

> This patch series addresses a bug in interpret-trailers. If the commit
> that is being editted is "verbose", it will contain a scissors string
> ("-- >8 --") and a diff. interpret-trailers doesn't interpret the
> scissors and therefore places trailer information after the diff. A
> simple reproduction is:
> 
> 	git config commit.verbose true
> 	GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
> 		git commit --amend

Ah, I should have read your cover letter more carefully before
responding to the third patch (or alternatively, you should have put
your motivating example into the third patch's commit message :) ).

Your example definitely makes sense. But it does make me wonder if this
should be an option to interpret-trailers, so that it doesn't
accidentally trigger. Unfortunately you'd have to manually specify it
(even though you'd presumably have commit.verbose in your config and
have long forgotten about it). And at that point, you might as well just
say "--no-verbose" on the commit command-line.

> P.S. This is my first patch series to the git mailing list, to feel free
> to point out any mistakes I made when submitting.

My responses so far have all been critical, so let me be positive for a
moment. :)

Welcome to the community. Everything in your patches generally looks
well-formatted, etc. And I do think you're on the right track with your
solution.

As I said, I'm a little iffy on doing this unconditionally, but it may
be the least-bad solution. I'd just worry about collateral damage to
somebody who doesn't use commit.verbose, but has something scissors-like
in their commit message.

If you were to switch out is_scissors_line() for checking the exact
cut_line[] from wt-status.c, I think that would be a big improvement.
We'd still have the possibility of a false positive, but it would be
much less likely in practice.

-Peff
