Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FC41F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfILOXI (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:23:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:47890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732444AbfILOXH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:23:07 -0400
Received: (qmail 13808 invoked by uid 109); 12 Sep 2019 14:23:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 14:23:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8103 invoked by uid 111); 12 Sep 2019 14:25:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 10:25:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 10:23:06 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912142306.GE23031@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <fdb81ce0-20ee-5880-2a6c-0c8b3f1739b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdb81ce0-20ee-5880-2a6c-0c8b3f1739b9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 08:23:49AM -0400, Derrick Stolee wrote:

> > That creates an interesting problem for commits that have _already_ been
> > parsed using the commit graph. Their commit->object.parsed flag is set,
> > their commit->graph_pos is set, but their commit->maybe_tree may still
> > be NULL. When somebody later calls repo_get_commit_tree(), we see that
> > we haven't loaded the tree oid yet and try to get it from the commit
> > graph. But since it has been freed, we segfault!
> 
> OOPS! That is certainly a bad thing. I'm glad you found it, but I
> am sorry for how you (probably) found it.

Heh. I'll admit it was quite a slog of debugging, but _most_ of that was
figuring out in which circumstance we'd have actually parsed the object.
Finding the problematic end state was pretty easy from a coredump. :)

> > diff --git a/commit-graph.c b/commit-graph.c
> > index 9b02d2c426..bc5dd5913f 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -41,6 +41,8 @@
> >  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
> >  			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
> >  
> > +static int commit_graph_disabled;
> 
> Should we be putting this inside the repository struct instead?

Probably. The only caller will just pass the_repository, but it doesn't
hurt to scope it down now.

It could potentially go into the commit_graph itself, but it looks like
with the incremental work we may have multiple such structs. It could
also go into raw_object_store, but I think conceptually it's a
repo-level thing.

So I put it straight into "struct repository".

> Your patch does not seem to actually cover the "I've already parsed some commits"
> case, as you are only preventing the commit-graph from being prepared. Instead,
> we need to have a short-circuit inside parse_commit() to avoid future parsing
> from the commit-graph file.

Maybe I was too clever, then. :)

I didn't want to have to sprinkle "are we disabled" in parse_commit(),
etc. But any such uses of the commit graph have to do:

  if (!prepare_commit_graph(r))
	return;

to lazy-load it. So the logic to prepare becomes (roughly):

  if (disabled)
	return 0;
  if (already_loaded)
	return 1;
  return actually_load() ? 1 : 0;

and "disabled" takes precedence.

I've added this comment in prepare_commit_graph():

        /*
         * This must come before the "already attempted?" check below, because
         * we want to disable even an already-loaded graph file.
         */
        if (r->commit_graph_disabled)
                return 0;

        if (r->objects->commit_graph_attempted)
                return !!r->objects->commit_graph;
        r->objects->commit_graph_attempted = 1;

Does that make more sense?

Unrelated, but I also notice the top of prepare_commit_graph() has:

        if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
                die("dying as requested by the '%s' variable on commit-graph load!",
                    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);

as the very first thing. Meaning we're calling getenv() as part of every
single parse_commit(), rather than just once per process. Seems like an
easy efficiency win.

-Peff
