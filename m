Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED071C63777
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0C206D9
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 08:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgKXIED (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 03:04:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:39928 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbgKXIED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 03:04:03 -0500
Received: (qmail 321 invoked by uid 109); 24 Nov 2020 08:04:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 08:04:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12319 invoked by uid 111); 24 Nov 2020 08:04:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 03:04:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 03:04:01 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] clone: --filter=tree:0 implies fetch.recurseSubmodules=no
Message-ID: <X7y+cZ3MPqqmGXx/@coredump.intra.peff.net>
References: <pull.797.git.1605904586929.gitgitgadget@gmail.com>
 <20201121000436.GB353076@coredump.intra.peff.net>
 <8a31af0e-4440-d957-11fb-48c4d2abd5c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a31af0e-4440-d957-11fb-48c4d2abd5c7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 10:18:42AM -0500, Derrick Stolee wrote:

> > If I clone with tree:0, I'm still going to get the tree for the thing
> > I'm actually checking out (assuming a non-bare repo). It would be
> > reasonable to recursively fetch the submodules in that commit to
> > check them out (assuming you specified --recurse-submodules).
> > 
> > If I then fetch again, I'll end up with another tree that I'm about to
> > checkout. So likewise, would it make sense to fetch any updates from
> > there?
> 
> One thing that is different is that we will fetch the trees we need
> _during that checkout_, so why do it preemptively in the fetch?
> 
> Further, the number of trees being fetched is _not_ the number of ref
> tips, but seems to be related to the total number of commits different.
> There must be a rev walk looking for which commits changed the modules
> file or the commit link in the root tree.

Yeah, that's exactly what the "on-demand" thing is. I said before it was
looking for .gitmodules, but I think it has to be looking for updated
gitlinks. I'm pretty sure the logic only kicks in if we have a
.gitmodules, though, to avoid the extra traversal when you're not using
submodules (but I guess we're all now paying that traversal cost in
git.git, even if we don't populate the modules).

I think the goal is to do all of the fetches at once, so after "git
fetch" you can then run checkout, merge, etc, without worrying that
you'll need network access later.

But it's not actually "checkout" that does the fetching. It will update
the gitlink, but that will just show a diff against the content of the
submodule. You have to actually "git submodule update" to update the
repository, which will then auto-fetch (though I suspect with
appropriate config or command-line options, checkout can be convinced to
trigger "submodule update").

So in that sense, maybe your patch is the most sensible thing. If you're
not checking out immediately, we probably have no business in a partial
clone guessing at trees you _might_ check out later, especially if it
involves demand-fetching them from the server. And if you do check out
and "submodule update" immediately, then we'd do the fetch then anyway.

We can punt on the logic to walk the trees, only looking at ones we
actually _do_ have locally, until somebody else wants to work on it.

> >   - during its poking, should it set the necessary variables so that it
> >     never demand-fetches from a promisor remote? I suspect this part
> >     may be hard, because "fetch" and "checkout" are distinct operations
> >     (so during the "fetch" we don't yet have the new tree demand-fetched
> >     by checkout; in fact the user might not even be interested in
> >     checking it out yet).
> 
> I also think this is a good idea. In particular, should we consider
> making the "submodule fetch" be part of the "promisor"? That is, we
> only fetch our submodule on checkout? Can we assume that the commit
> will still exist on the remote, to some extent?

I think issues of whether the commit will exist are outside the scope
here. "submodule update" has to decide if we have it, or how to get it
(if it can). But it won't fail a checkout in that case; you'll just be
left with a diff between the gitlink and what's in the submodule repo.

I'm not quite sure what you're asking with the rest of it. From this:

> Naturally, this only really applies for --filter=tree:0, since in cases
> like blobless clones, we would still want the commits and trees from the
> submodule.

it sounds like you're asking whether the submodule should also be using
the same filter. Maybe, but I think it would depend on the workflow and
the module (and probably is something that you'd want to be able to
configure independently). At any rate, I think that's orthogonal to this
issue.

> > Given the difficulties in the latter case, this may be the best we can
> > do. But in that case, what happens when we _do_ care about submodules,
> > and do:
> > 
> >   git clone --recurse-submodules --filter=tree:0 ...
> >   git fetch
> >   git merge origin
> > 
> > Will we correctly fetch-on-demand the submodules we need during the
> > merge operation? If so, then that user experience is probably pretty
> > reasonable.

Answering my own question: no, you'd run "git submodule update"
afterwards.

> Hopefully. Notably, the filter option does _not_ apply recursively
> to the submodules, so even if we try to make the superproject a partial
> clone, the submodule is not partial.

Yep, but I do think that's orthogonal.

> More research is required. Let's drop this patch, as I don't currently
> have time to do the necessary deep dive. If someone else has time to
> look into this, I'd be happy to review a better patch.

I don't mind dropping it, but I've actually come around to the idea that
your patch or something like it is probably a strict improvement.

-Peff
