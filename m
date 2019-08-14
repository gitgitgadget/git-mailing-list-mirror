Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A44B1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfHNOwV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 10:52:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:43294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfHNOwV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 10:52:21 -0400
Received: (qmail 16867 invoked by uid 109); 14 Aug 2019 14:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Aug 2019 14:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16733 invoked by uid 111); 14 Aug 2019 14:53:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2019 10:53:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Aug 2019 10:52:20 -0400
From:   Jeff King <peff@peff.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: How to reset selected lines?
Message-ID: <20190814145219.GA12093@sigill.intra.peff.net>
References: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
 <20190813154239.GA22514@sigill.intra.peff.net>
 <20190814114844.gvb5znje7cpzehkd@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814114844.gvb5znje7cpzehkd@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 14, 2019 at 05:18:44PM +0530, Pratyush Yadav wrote:

> > So "git add -p", for example, also works by creating diffs, modifying
> > them, and feeding the result to "apply". You can see the implementation
> > in git-add--interactive.perl, where it literally calls diff and apply
> > commands.
> > 
> > And that leads us to the answer to the first question. That script
> > implements "add -p", but also "checkout -p" (which is what you want),
> > "reset -p", "stash -p", etc. They differ only in what we diff and how we
> > apply the result; the main engine of slicing and dicing the diff through
> > user interaction is the same. See the %patch_modes hash for the list.
> 
> Ah, so that means I do have to dive into generating diffs. Too bad, I 
> was hoping for a cleaner (read: easier) way.
> 
> On that note, I don't suppose there is a way to use 
> git-add--interactive's diff engine from a script, is there?  That'd 
> allow me to not write potentially buggy code and solve problems someone 
> already solved.

The actual diffing is all done by lower-level commands. So I'm not sure
there's much "engine" to reuse from the script. It takes care of asking
the user about which lines to look at, how to split the diff, etc, but
that's the part you'd want a totally different interface for.

The one thing you _might_ want to pick up is the line recounting bits.
We used to just call "apply --recount", but I think there were some
corner cases that it couldn't handle well. The details are in 2b8ea7f3c7
(add -p: calculate offset delta for edited patches, 2018-03-05) and
3a8522f41f (add -p: don't rely on apply's '--recount' option,
2018-03-05), and probably some mailing list around those.

You could probably start with just not handling those corner cases,
though (either relying on "apply --recount", or just using whatever
git-gui already does now for staging).

-Peff
