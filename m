Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77850C56202
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4374723A6B
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgKUAEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:04:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:37242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgKUAEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 19:04:38 -0500
Received: (qmail 7413 invoked by uid 109); 21 Nov 2020 00:04:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Nov 2020 00:04:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12591 invoked by uid 111); 21 Nov 2020 00:04:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Nov 2020 19:04:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Nov 2020 19:04:36 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] clone: --filter=tree:0 implies fetch.recurseSubmodules=no
Message-ID: <20201121000436.GB353076@coredump.intra.peff.net>
References: <pull.797.git.1605904586929.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.797.git.1605904586929.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 08:36:26PM +0000, Derrick Stolee via GitGitGadget wrote:

> I decided that even if I did populate the submodules, the nature of
> treeless clones makes me not want to care about the contents of commits
> other than those that I am explicitly navigating to.
> 
> This loop of tree fetches can be avoided by adding
> --no-recurse-submodules to the 'git fetch' command or setting
> fetch.recurseSubmodules=no.
> 
> To make this as painless as possible for future users of treeless
> clones, automatically set fetch.recurseSubmodules=no at clone time.

I think it's definitely worth adjusting the defaults here to make this
less painful out of the box. But I wonder if this is too big a hammer,
and the on-demand logic just needs to be a bit less aggressive.

If I clone with tree:0, I'm still going to get the tree for the thing
I'm actually checking out (assuming a non-bare repo). It would be
reasonable to recursively fetch the submodules in that commit to
check them out (assuming you specified --recurse-submodules).

If I then fetch again, I'll end up with another tree that I'm about to
checkout. So likewise, would it make sense to fetch any updates from
there?

I.e., I think the problem is that whether or not cared about submodules
in the first place, the default "on-demand" setting of fetch.submodules
is very eager to poke through history looking at the .gitmodules file to
see if there is anything worth also fetching. But:

  - if we know there are no active submodules in the first place
    (because you did not say --recurse-submodules), should it skip that
    poking? That seems like it shouldn't be too hard.

  - during its poking, should it set the necessary variables so that it
    never demand-fetches from a promisor remote? I suspect this part
    may be hard, because "fetch" and "checkout" are distinct operations
    (so during the "fetch" we don't yet have the new tree demand-fetched
    by checkout; in fact the user might not even be interested in
    checking it out yet).

Given the difficulties in the latter case, this may be the best we can
do. But in that case, what happens when we _do_ care about submodules,
and do:

  git clone --recurse-submodules --filter=tree:0 ...
  git fetch
  git merge origin

Will we correctly fetch-on-demand the submodules we need during the
merge operation? If so, then that user experience is probably pretty
reasonable.

-Peff
