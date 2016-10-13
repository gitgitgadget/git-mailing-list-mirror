Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873E020989
	for <e@80x24.org>; Thu, 13 Oct 2016 17:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754840AbcJMRL2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 13:11:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:57065 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753897AbcJMRL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 13:11:27 -0400
Received: (qmail 29149 invoked by uid 109); 13 Oct 2016 17:04:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 17:04:45 +0000
Received: (qmail 31016 invoked by uid 111); 13 Oct 2016 17:05:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 13:05:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2016 13:04:43 -0400
Date:   Thu, 13 Oct 2016 13:04:43 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: use "quick" has_sha1_file for tag following
Message-ID: <20161013170443.43slna3zvcvrse5r@sigill.intra.peff.net>
References: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
 <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
 <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
 <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 12:53:44PM -0400, Jeff King wrote:

> -- >8 --
> Subject: [PATCH] fetch: use "quick" has_sha1_file for tag following

A few comments on my own patch...

> This patch teaches fetch to use HAS_SHA1_QUICK to sacrifice
> accuracy for speed, in cases where we might be racy with a
> simultaneous repack. This is similar to the fix in 0eeb077
> (index-pack: avoid excessive re-reading of pack directory,
> 2015-06-09). As with that case, it's OK for has_sha1_file()
> occasionally say "no I don't have it" when we do, because
> the worst case is not a corruption, but simply that we may
> fail to auto-follow a tag that points to it.

Failing in this direction doesn't make me feel great. I had hoped it
would fail the _other_ way, and request an object that we might already
have.

There are two alternatives that might be worth pursuing:

  1. The thing that makes this really painful is the quadratic
     duplicate-search in prepare_packed_git_one(). We could speed that
     up pretty easily by keeping a hash of the packs indexed by their
     names, and looking up in that.

     That drops the quadratic factor, but it's still going to be
     O(nr_tags * nr_packs), as we have to at the very least readdir()
     all of objects/pack to see that nothing new showed up.

     I wonder if we could trust the timestamp on the objects/pack
     directory to avoid re-reading it at all. That turns it into a
     single stat() call.

  2. We could stop bothering to reprepare_packed_git() only after the
     nth time it is called. This basically turns on the "sacrifice
     accuracy for speed" behavior automatically, but it means that most
     cases would never do so, because it wouldn't be creating a
     performance issue in the first place.

     It feels weird and flaky that git might behave differently based on
     the number of unfetched tags the remote happens to have, though.

> Here are results from the included perf script, which sets
> up a situation similar to the one described above:
> 
> Test            HEAD^               HEAD
> ----------------------------------------------------------
> 5550.4: fetch   11.21(10.42+0.78)   0.08(0.04+0.02) -99.3%

The situation in this perf script is obviously designed to show off this
one specific optimization. It feels a bit overly specific, and I doubt
anybody will be all that interested in running it again once the fix is
in. OTOH, I did want to document my reproduction steps, and this seemed
like the only reasonable place to do so. And as the perf suite is
already pretty expensive, perhaps nobody minds adding to it too much.

-Peff
