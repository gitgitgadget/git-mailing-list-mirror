Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E532F1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 00:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfILASr (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 20:18:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:47336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726761AbfILASr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 20:18:47 -0400
Received: (qmail 25192 invoked by uid 109); 12 Sep 2019 00:18:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 00:18:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3125 invoked by uid 111); 12 Sep 2019 00:20:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2019 20:20:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Sep 2019 20:18:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912001846.GA31370@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912000414.GA31334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 08:04:14PM -0400, Jeff King wrote:

> When the client has asked for certain shallow options like
> "deepen-since", we do a custom rev-list walk that pretends to be
> shallow. Before doing so, we have to disable the commit-graph, since it
> is not compatible with the shallow view of the repository. That's
> handled by 829a321569 (commit-graph: close_commit_graph before shallow
> walk, 2018-08-20). That commit literally closes and frees our
> repo->objects->commit_graph struct.

A few notes and curiosities on my patch and this general area.

The test suite passes with my patch both with and without
GIT_TEST_COMMIT_GRAPH=1. But to my surprise, it also passes if I delete
the close_commit_graph() line added by 829a321569!

So it's not clear to me whether this whole thing is truly unnecessary
(and Stolee was just being overly cautious because the code is related
to shallow-ness, even though it is OK doing a true-parent traversal
itself), or if we just don't have good test coverage for the case that
requires it.

If it _is_ necessary, I'm a little worried there are other problems
lurking. The whole issue is that we've seen and parsed some commits
before we get to this shallow deepen-since code-path. So just disabling
commit-graphs isn't enough. Even without them, we might have parsed some
commits the old-fashioned way and filled in their parent pointers. Is
that a problem?

If so, then I think we either have to "unparse" all of the existing
in-memory commits, or call out to a rev-list process with a fresh memory
space.

One especially interesting bit is this:

> +#  - we must use protocol v2, because it handles the "have" negotiation before
> +#    processing the shallow direectives

In the v0 protocol, we handle shallows at the end of receive_needs(). So
it happens before we call into get_common_commits(), which may do
further traversal. That makes it much more likely for the shallow code
to see a "clean" slate. Should v2 be ordering things in the same way?
But then would the have negotiation see the shallow parents? If so, is
that good or bad?

I'm pretty ignorant of how the shallow bits of upload-pack are supposed
to work.

> That creates an interesting problem for commits that have _already_ been
> parsed using the commit graph. Their commit->object.parsed flag is set,
> their commit->graph_pos is set, but their commit->maybe_tree may still
> be NULL. When somebody later calls repo_get_commit_tree(), we see that
> we haven't loaded the tree oid yet and try to get it from the commit
> graph. But since it has been freed, we segfault!

I was surprised we ever called repo_get_commit_tree() at all, since
we're literally just traversing commits here. It looks like
list-objects.c is very happy to queue pending trees for each commit,
even if we're just going to throw them away when we get to
process_tree()! I wonder if could be checking revs->tree_objects here
and saving ourselves some work.

> The new test in t5500 triggers this segfault, but see the comments there
> for how horribly intimate it has to be with how both upload-pack and
> commit graphs work.

This bug was triggered by a real world case. I'm not entirely clear what
the client-side state was; I had to reverse engineer the whole thing out
of the server-side coredump. The test here is my attempt to cut it down
to a minimum. I don't like having to manually generate the upload-pack
input, but I had trouble finding a fetch command that would trigger it.
And anyway, given how weirdly specific the requirements are for
generating this case, it seemed sensible to me to keep the input close
to the source of the problem.

-Peff
