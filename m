Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3ACC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 03:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiKDDZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 23:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiKDDYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 23:24:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EEA25EAD
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 20:21:00 -0700 (PDT)
Received: (qmail 17100 invoked by uid 109); 4 Nov 2022 03:20:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 03:20:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25286 invoked by uid 111); 4 Nov 2022 03:21:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Nov 2022 23:21:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Nov 2022 23:20:58 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2SFGmQnx7CXtTEI@coredump.intra.peff.net>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <221104.86bkpnzdqi.gmgdl@evledraar.gmail.com>
 <Y2R3vJf1A2KOZwA7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2R3vJf1A2KOZwA7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 10:23:56PM -0400, Taylor Blau wrote:

> But I think you make a compelling point (which doesn't match my own
> workflow, but I can see the utility of nonetheless).
> 
> I was thinking that we could rely on something similar to the ci-config
> ref stuff from back in e76eec35540 (ci: allow per-branch config for
> GitHub Actions, 2020-05-07), but it looks like it'll be a little
> trickier than that, maybe impossible.
> 
> We need to know about the state of the ci-config branch before we set
> the concurrency bits. So I think you *could* do something like:

As an aside, I wish there was a way to interpret per-repo environment
variables in the actual action config. The current ci-config stuff
works, but it's pretty horrible because (if I understand correctly) it
spins up a VM just to evaluate a glob and say "nope, no CI needed on
this branch". So:

  1. It's wasteful of resources, compared to a system where the Actions
     parser can evaluate a variable.

  2. It makes the Actions results page for a repo ugly, because skipped
     branches clutter the output with "yes, I passed CI" even though all
     they passed was a trivial job to say "don't bother running more
     CI".

  3. The problem you mention: it happens too late to affect the overall
     Actions flow, and instead individual jobs have to take it into
     account.

When I wrote the original ci-config stuff I looked for an alternative.
You _can_ set per-repo variables in the form of secrets, but I couldn't
find a way to evaluate them at the top-level of the yaml file. But maybe
that has improved in the meantime. I had looked against as recently as a
month or two ago and didn't find anything, but I'm far from an expert on
Actions.

-Peff
