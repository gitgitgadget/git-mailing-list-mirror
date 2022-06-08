Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7EDC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 23:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiFHXRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiFHXRl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 19:17:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221631347
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 16:17:39 -0700 (PDT)
Received: (qmail 6107 invoked by uid 109); 8 Jun 2022 23:17:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jun 2022 23:17:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Wed, 8 Jun 2022 19:17:39 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: commit-graph overflow generation chicken and egg
Message-ID: <YqEuE2iAmMVLlUSu@coredump.intra.peff.net>
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 08, 2022 at 04:08:03PM -0400, Derrick Stolee wrote:

> I'd love to see the full binary, but for the sake of sharing on the
> list, could you give the following output?
> 
> 	xxd .git/objects/info/commit-graph | head
> 
> or any other command that shows the first few hex bytes along with
> their ASCII equivalents. Here is one that used Git 2.34.0:
> [...]

Interesting. My earlier email was a bit misleading. I do in fact have a
GDA2 chunk. And looking at the timestamp on the commit-graph file, it's
from May 24th. I hadn't been keeping the repo up to date regularly, but
I did occasionally pull and rebuild. So I think it was a much more
recent version of Git that built the problematic file, though it's
possible it was carrying forward bad data.

So 6dbf4b8172ef may be a bit of a red herring, if the file has a GDA2
section that was simply ignored before that commit.

Looking at my reflog, my best guess for the version of Git that produced
the file is e46751e96fa.

> However, the lack of the large offset chunk could be due to the bug fixed by
> 75979d9460 (commit-graph: fix ordering bug in generation numbers,
> 2022-03-01). Perhaps that was the thing that was missing from your version?

So I _think_ I would have had that, though there's a good chance that an
older version of the commit-graph file was written using a version of
Git without it.

> But otherwise, I'm stumped. I'd be very interested to see a repro from a
> fresh repository. That is: what situation do we need to be in to write such
> an offset without including the large offset chunk?

Not exactly a fresh reproduction, but you can grab my broken file from:

  https://peff.net/tmp/broken-commit-graph

Dropping it into a fresh clone of git.git shows the problem.

I tried a few obvious from-scratch reproductions like building a file
with 75979d9460^ (so with the generation number bug), and then jumping
forward to e46751e96fa (so bug fixed, but now we write GDA2), but
couldn't get it to trigger.

It may not be worth spending too much time on, if this is a weird
one-off caused by a mix of buggy unreleased versions of Git. If real
users aren't seeing it, and we know the nuclear option is "rm
commit-graph", then that may be enough.

-Peff
