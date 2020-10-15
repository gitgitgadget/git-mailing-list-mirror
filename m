Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C6C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3695020714
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392018AbgJOT54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:57:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392015AbgJOT54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:57:56 -0400
Received: (qmail 24389 invoked by uid 109); 15 Oct 2020 19:57:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:57:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32619 invoked by uid 111); 15 Oct 2020 19:57:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:57:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:57:54 -0400
From:   Jeff King <peff@peff.net>
To:     Leam Hall <leamhall@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Branch Management questions
Message-ID: <20201015195754.GD1490964@coredump.intra.peff.net>
References: <595540a9-0000-8dcd-c555-3168d1b2d066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <595540a9-0000-8dcd-c555-3168d1b2d066@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 05:51:39AM -0400, Leam Hall wrote:

> 1. Two developers.
>   Dev A is working on Branch A, off a release_candidate branch.
>   Dev B is working on Branch B, off the same release_candidate branch.
>   Branches usually run 1-4 weeks.
>   Dev A does some work that would help Branch B.
>   How does Dev A get the Branch B work that is needed, in a
>     way that does not confuse the merge process at the end
>     of the release cycle?

If Dev A is OK getting _all_ of branch B, the best thing is to simply:

  git checkout branch-a
  git merge branch-b

That goes from:

  old -- a1 -- a2 -- a3   <-- branch-A
     \
      b1 -- b2 -- b3       <-- branch-B

to: 

  old -- a1 -- a2 -- a3 -- M  <-- branch-A
     \                    /
      b1 -- b2 -- b3 ----+    <-- branch-B

and then later when they merge again (either separately, or into
release_candidate), Git knows that "M" is the merge-base instead of
"old":

  old -- a1 -- a2 -- a3 -- M -- a4 -- a5 -- a6 <-- branch-A
     \                    /
      b1 -- b2 -- b3 ----+-- b4 -- b5 -- b6    <-- branch-B

If you need just parts of the work on b, then you'd probably have to
cherry-pick them. They should usually merge together cleanly eventually,
but if you further modify them (or touch nearby areas), that may result
in a conflict on merge into release_candidate.

> 2. One developer.
>   Working on Branch P, realizes that a new functionality X is
>     needed.
>   X isn't specific to Branch P, but critical to it.
>   What is the best way to deal with X, knowing that further work
>     on X will need to be done?

Create a new branch X for the shared topic, and base it not on P but on
whatever the fork point of P is (i.e., your release_candidate or
whatever). Then do some work on X, and merge X into P as needed.
Likewise for any other branch that builds on X.

If you've already built part of X on top of P, then you could
cherry-pick those parts onto the new branch X, and then either:

  - rebase P on top of X (which will drop the redundant bits)

  - merge X into P. You may have to resolve conflicts around the
    redundant parts, and you'll have some redundant commits left in the
    history (but the new merge will become the base for further merges
    between the branches)

-Peff
