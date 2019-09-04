Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EE11F4B7
	for <e@80x24.org>; Wed,  4 Sep 2019 03:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfIDDE5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 23:04:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:38594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727374AbfIDDE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 23:04:57 -0400
Received: (qmail 9652 invoked by uid 109); 4 Sep 2019 03:04:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 03:04:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10969 invoked by uid 111); 4 Sep 2019 03:06:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Sep 2019 23:06:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Sep 2019 23:04:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <20190904030456.GA28836@sigill.intra.peff.net>
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 03, 2019 at 10:22:57PM -0400, Taylor Blau wrote:

> When we write a commit graph chunk, we process a given list of 'struct
> commit *'s and parse out the parent(s) and tree OID in order to write
> out its information.
> 
> We do this by calling 'parse_commit_no_graph', and then checking the
> result of 'get_commit_tree_oid' to write the tree OID. This process
> assumes that 'parse_commit_no_graph' parses the commit successfully.
> When this isn't the case, 'get_commit_tree_oid(*list)' may return NULL,
> in which case trying to '->hash' it causes a SIGSEGV.
> 
> Instead, teach 'write_graph_chunk_data' to stop when a commit isn't able
> to be parsed, at the peril of failing to write a commit-graph.

Yeah, I think it makes sense for commit-graph to bail completely if it
can't parse here. In theory it could omit the entry from the
commit-graph file (and a reader would just fall back to trying to access
the object contents itself), but I think we're too late in the process
for that. And besides, this should generally only happen in a corrupt
repository.

However...

> diff --git a/commit-graph.c b/commit-graph.c
> index f2888c203b..6aa6998ecd 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -843,7 +843,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  		uint32_t packedDate[2];
>  		display_progress(ctx->progress, ++ctx->progress_cnt);
>  
> -		parse_commit_no_graph(*list);
> +		if (parse_commit_no_graph(*list))
> +			die(_("unable to parse commit %s"),
> +				oid_to_hex(&(*list)->object.oid));
>  		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);

I don't think parse_commit_no_graph() returning 0 assures us that
get_commit_tree() and friends will return non-NULL.

This is similar to the case discussed recently where a failed parse of a
tag may leave "tag->tagged == NULL" even though "tag->obj.parsed" is
set.

Here an earlier parsing error could cause (*list)->object.parsed to be
true, but with (*list)->maybe_tree still NULL. Our call to
parse_commit_no_graph() here would silently return "yep, already tried
to parse this", and then we'd still segfault.

We _could_ check:

  if (parse_commit_no_graph(*list))
	die("unable to parse...");
  tree = get_commit_tree_oid(*list);
  if (!tree)
	die("unable to get tree for %s...");

but trees are just one piece of data. In fact, the situation is much
worse for parents: there a NULL parent pointer is valid data, so worse
than segfaulting, we'd write invalid data to the commit graph, skipping
one or more parents!

And I think there's literally no way for this function to tell the
difference between "no parent" and "there was an earlier error, but we
set the parsed flag anyway and the parent flag is invalid".

I think that argues against Junio's response in:

  https://public-inbox.org/git/xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com/

about how we can use the parsed flag to look at "slightly corrupt"
objects. I think we'd need at least an extra flag for "corrupt", though
I think it is simpler just _not_ setting "parsed" and letting the next
caller spend the extra cycles to rediscover the problem if they're
interested.

(All of this presupposes that you can convince another piece of code in
the same process to parse the commit buffer and ignore the error. I have
no idea if that's possible or not in this case, but it sure would be
nice not to have to care).

-Peff
