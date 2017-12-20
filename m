Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95641F404
	for <e@80x24.org>; Wed, 20 Dec 2017 16:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755642AbdLTQhP (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 11:37:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:44258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754502AbdLTQhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 11:37:13 -0500
Received: (qmail 23411 invoked by uid 109); 20 Dec 2017 16:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 16:37:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14419 invoked by uid 111); 20 Dec 2017 16:37:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 11:37:39 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 11:37:11 -0500
Date:   Wed, 20 Dec 2017 11:37:11 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/4] stat_tracking_info: return +1 when branch and
 upstream differ
Message-ID: <20171220163711.GA5551@sigill.intra.peff.net>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-3-git@jeffhostetler.com>
 <20171220161407.GB31149@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220161407.GB31149@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 11:14:07AM -0500, Jeff King wrote:

> On Wed, Dec 20, 2017 at 02:42:43PM +0000, Jeff Hostetler wrote:
> 
> > Extend stat_tracking_info() to return 1 when the branch is
> > not up to date with its upstream branch and only return 0
> > when they are equal.
> 
> This means that callers all need to be updated, but there's no change
> that the compiler could catch. You've updated all of the calls here, but
> any topics in flight would need to be fixed, too.
> 
> I don't see any any in pu, but there are a number of long-running forks
> hanging around these days.
> 
> Is it worth introducing a small change so that any other callers which
> get merged in force a human to look at them? I'm wondering if we could
> just re-order the "upstream_name" argument or something.

Having seen the change in the next patch, I wonder if we should add a
flag field to specify "don't bother doing extra work" rather than
passing NULL for the ours/theirs parameters. I.e., most callers would
become:

  if (stat_tracking_info(branch, &ours, &theirs, &base, 0) >= 0)

and the ones you touch later in the series would become:

  
  if (stat_tracking_info(branch, NULL, NULL, &base, TRACKING_QUICK) >= 0)

or similar. And then any newly added calls would get flagged by the
compiler as missing the final parameter.

-Peff
