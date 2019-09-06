Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D0B1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 06:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbfIFGTV (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 02:19:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:41736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389455AbfIFGTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 02:19:21 -0400
Received: (qmail 14692 invoked by uid 109); 6 Sep 2019 06:19:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 06:19:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2075 invoked by uid 111); 6 Sep 2019 06:21:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 02:21:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 02:19:20 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
Message-ID: <20190906061919.GA5122@sigill.intra.peff.net>
References: <cover.1567720960.git.me@ttaylorr.com>
 <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 06:04:57PM -0400, Taylor Blau wrote:

> @@ -846,7 +847,11 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  		if (parse_commit_no_graph(*list))
>  			die(_("unable to parse commit %s"),
>  				oid_to_hex(&(*list)->object.oid));
> -		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
> +		tree = get_commit_tree_oid(*list);
> +		if (!tree)
> +			die(_("unable to get tree for %s"),
> +				oid_to_hex(&(*list)->object.oid));
> +		hashwrite(f, tree->hash, hash_len);

Yeah, I think this is a good stop-gap to protect ourselves, until a time
when parse_commit() and friends consistently warn us about the breakage.

> diff --git a/commit.c b/commit.c
> index a98de16e3d..fab22cb740 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -358,7 +358,8 @@ struct tree *repo_get_commit_tree(struct repository *r,
>  
>  struct object_id *get_commit_tree_oid(const struct commit *commit)
>  {
> -	return &get_commit_tree(commit)->object.oid;
> +	struct tree *tree = get_commit_tree(commit);
> +	return tree ? &tree->object.oid : NULL;
>  }

This one in theory benefits lots of other callsites, too, since it means
we'll actually return NULL instead of nonsense like "8". But grepping
around for calls to this function, I found literally zero of them
actually bother checking for a NULL result. So there are probably dozens
of similar segfaults waiting to happen in other code paths.
Discouraging.

This is sort-of attributable to my 834876630b (get_commit_tree(): return
NULL for broken tree, 2019-04-09). Before then it was a BUG(). However,
that state was relatively short-lived. Before 7b8a21dba1 (commit-graph:
lazy-load trees for commits, 2018-04-06), we'd have similarly returned
NULL (and anyway, BUG() is clearly wrong since it's a data error).

None of which argues against your patches, but it's kind of sad that the
issue is present in so many code paths. I wonder if we could be handling
this in a more central way, but I don't see how short of dying.

-Peff
