Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A20FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 08:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKAIBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiKAIBR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 04:01:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B601838C
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 01:01:13 -0700 (PDT)
Received: (qmail 4828 invoked by uid 109); 1 Nov 2022 08:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 08:01:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20526 invoked by uid 111); 1 Nov 2022 08:01:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 04:01:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 04:01:12 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation/howto/maintain-git.txt: a pair of
 bugfixes
Message-ID: <Y2DSSM8ujceSgp+b@coredump.intra.peff.net>
References: <cover.1667260044.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667260044.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:47:33PM -0400, Taylor Blau wrote:

> The documentation on how to use the scripts in 'todo' has a couple of
> small typos that make it confusing when generating the Meta/redo-jch.sh
> and Meta/redo-seen.sh scripts the first time.
> 
> Correct these to avoid any confusion in the future.

Thanks for writing these up. A little back-story: Taylor and I had
looked at this together off-list, because the results of following the
documentation to the letter made little sense.

So both look good to me, with the giant grain of salt that I was party
to the original head-scratching that led to the patches. Given that
there's no urgency (unless you are hit by a bus in the next few weeks),
it probably makes sense to queue these fixes and wait for Junio to
review and (hopefully) merge them.

There is one thing we wondered about, and I think only Junio can answer.
The instructions after these patches yield two files, redo-jch.sh and
redo-seen.sh. The first one has two sections separated by a "###"
marker: the ones that are in 'next', and the ones that are in 'jch'.
The third ones has topics that are only in 'seen' (which also contains
all of the others).

Why not have a single file with all of the topics, with two "###"
markers? I.e., something like:

  # build the topic list from what's in 'seen' now
  Meta/Reintegrate master..seen >Meta/redo.sh

  # rebuild the first part of jch, which is everything in next
  git checkout -B master jch
  Meta/redo.sh -c1

  # now build actual next, which should end up with the same tree
  git checkout next
  git merge master ;# if necessary
  Meta/redo.sh -c1 -e ;# -e to annotate any topics
  git diff jch next ;# should be identical

  # now build the rest of jch
  git checkout jch
  Meta/redo.sh -c2

  # now build seen
  git checkout -B seen master
  Meta/redo.sh ;# no -c, do it all

I _think_ the two are equivalent, and it seems more convenient to keep
all of the topic names in one file (since they'd migrate across the cut
to go from seen to jch, then jch to next). But maybe you (Junio) find it
more convenient to keep them separate. The 'seen' list is a bit more
fluid, and I'm sure you figured out how to copy lines between two
different buffers in emacs. :)

Mostly just curious.

-Peff
