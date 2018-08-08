Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E404F208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 18:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeHHUpb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 16:45:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:47066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727295AbeHHUpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 16:45:31 -0400
Received: (qmail 5171 invoked by uid 109); 8 Aug 2018 18:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 18:24:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28922 invoked by uid 111); 8 Aug 2018 18:24:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 14:24:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 14:24:36 -0400
Date:   Wed, 8 Aug 2018 14:24:36 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: Help with "fatal: unable to read ...." error during GC?
Message-ID: <20180808182436.GA19096@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
 <20180808160612.GC1607@sigill.intra.peff.net>
 <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 08, 2018 at 01:35:30PM -0400, Paul Smith wrote:

> Thanks for the note!  Unhappily for me none of these operations seem to
> find any actionable problems...
> [...]

Drat.

One other option is that it _could_ be related to the "old unreachable
objects that are reachable from recent unreachable objects should be
kept" code. That's supposed to quietly ignore broken links in
unreachable objects, but there could be a bug.

Let's narrow it down first and make sure we're dying where I expect. Can
you try:

  GIT_TRACE=1 git gc

and confirm the program running when the fatal error is produced?

From what you've shown it's going to be git-repack, but what I'm not
clear on is whether it is repack itself that is complaining, or the
pack-objects process it spawns. I'd guess the latter.

If so, can you try running it under gdb and getting a stack trace?
Something like:

  gdb git
  [and then inside gdb...]
  set args pack-objects --all --reflog --indexed-objects foo </dev/null
  break die
  run
  bt

That might give us a clue where the broken object reference is coming
from.

-Peff
