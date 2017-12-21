Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D67F1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 15:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbdLUPkB (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 10:40:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:44946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752732AbdLUPj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 10:39:58 -0500
Received: (qmail 8444 invoked by uid 109); 21 Dec 2017 15:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Dec 2017 15:39:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20152 invoked by uid 111); 21 Dec 2017 15:40:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 21 Dec 2017 10:40:19 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Dec 2017 10:39:51 -0500
Date:   Thu, 21 Dec 2017 10:39:51 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/4] status: update short status to use --no-ahead-behind
Message-ID: <20171221153950.GA14411@sigill.intra.peff.net>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-4-git@jeffhostetler.com>
 <20171220162637.GC31149@sigill.intra.peff.net>
 <1c019725-7715-496e-bad6-9d47d2bae834@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c019725-7715-496e-bad6-9d47d2bae834@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 21, 2017 at 09:18:17AM -0500, Jeff Hostetler wrote:

> > This patch will affect "git status --porcelain", too. That's not
> > supposed to change in incompatible ways. I guess it's up for debate
> > whether callers are meant to handle any arbitrary string inside the []
> > (we already show "[gone]" for some cases), since AFAICT the format of
> > the tracking info is left completely vague in the documentation.
> > 
> > (I'd also hope that everybody is using --porcelain=v2 if they can, but
> > we should still avoid breaking v1).
> 
> I hadn't intended to alter V1 output.  I'll disable the new feature
> when V1 is selected.

To be clear, I am on the fence regarding the "is it a breaking change"
line. Certainly if the caller says "--no-ahead-behind", I don't see any
harm in doing what they asked.

But one further complication is that this may be triggered by config.
And that goes for --porcelain=v2, as well. Even though the v2
documentation specifically says "ignore headers you don't recognize",
would any callers be confused if a header is omitted due to a user's
config?

I guess for "branch.ab", the answer is "probably not", since it is
already documented to appear only if certain conditions are met. So
probably "omit branch.ab" is an OK change, as is "add a new header".
But I just wonder if it would be simpler to ignore the config entirely
for porcelain outputs (and require the explicit command-line option).

Personally, I am not a purist when it comes to config and plumbing, and
I'd be fine with having the config impact v2 (it is a hint from the user
that they do not want to spend time on the computation, so having
scripts respect that would be what the user wants). If you really have a
script that is unhappy missing "branch.ab", then you can either choose
not to set that config, or you can fix the script to use "--ahead-behind"
to override the config. But I'm not sure everybody in the community
would necessarily agree with me.

-Peff
