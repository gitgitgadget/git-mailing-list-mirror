Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5417C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7629F61D81
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhF3ByD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 21:54:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:36928 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhF3ByC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 21:54:02 -0400
Received: (qmail 22152 invoked by uid 109); 30 Jun 2021 01:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 01:51:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 849 invoked by uid 111); 30 Jun 2021 01:51:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 21:51:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 21:51:33 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] connected: implement connectivity check using
 bitmaps
Message-ID: <YNvOJQDYRWpFa+4S@coredump.intra.peff.net>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 07:33:15AM +0200, Patrick Steinhardt wrote:

> As expected, performance doesn't change in cases where we do not have a
> bitmap available given that the old code path still kicks in. In case we
> do have bitmaps, this is kind of a mixed bag: while git-receive-pack(1)
> is slower in a "normal" clone of linux.git, it is significantly faster
> for a clone with lots of references. The slowness can potentially be
> explained by the overhead of loading the bitmap. On the other hand, the
> new code is faster as expected in repos which have lots of references
> given that we do not have to mark all negative references anymore.

Hmm. We _do_ still have to mark those negative references now, though
(the bitmap code still considers each as a reachability tip for the
"have" side of the traversal). It's just that we may have to do less
traversal on them, if they're mentioned by other bitmaps.

So in that sense I don't think your "a ref for every commit" cases are
all that interesting. Any bitmap near the tip of history is going to
include a bit for all those old commits, because our fake set of refs
are all reachable. A much more interesting history is when you have a
bunch of little unreachable spikes coming off the main history.

This is common if you have a lot of branches in the repo, but also if
you maintain a lot of book-keeping refs (like the refs/pull/* we do at
GitHub; I assume GitLab does something similar).

Here are some real-world numbers from one of the repos that gives us
frequent problems with bitmaps. refs/pull/9937/head in this case is an
unmerged PR with 8 commits on it.

  [without bitmaps, full check but with count to suppress output]
  $ time git rev-list --count refs/pull/9937/head --objects --not --all
  0
  real	0m1.280s
  user	0m1.131s
  sys	0m0.148s

  [same, but with bitmaps]
  $ time git rev-list --count refs/pull/9937/head --objects --not --all --use-bitmap-index
  0
  
  real	1m38.146s
  user	1m30.015s
  sys	0m3.443s

Yikes. Now this is a pretty extreme case, as it has a lot of bookkeeping
refs. If we limited ourselves to just the branches (in which case our
unmerged PR will appear to have a couple new commits), though, we still
get:

  $ time git rev-list --count refs/pull/9937/head --objects --not --branches
  64
  real	0m0.366s
  user	0m0.272s
  sys	0m0.093s

  $ time git rev-list --count refs/pull/9937/head --objects --not --branches --use-bitmap-index
  61
  real	0m10.372s
  user	0m9.633s
  sys	0m0.736s

which is still a pretty bad regression (the difference in the output is
expected; the regular traversal is not as thorough at finding objects
which appear in non-contiguous sections of history).

Again, this is one of the repositories that routinely gives us problems.
But even on git/git, which is usually not a problematic repo, I get:

  $ time git rev-list refs/pull/986/head --objects --not --all
  real	0m0.121s
  user	0m0.024s
  sys	0m0.097s

  $ time git rev-list refs/pull/986/head --objects --not --all --use-bitmap-index
  real	0m12.406s
  user	0m5.843s
  sys	0m0.734s

So even if this tradeoff might help on balance, it really makes some
cases pathologically bad.

-Peff
