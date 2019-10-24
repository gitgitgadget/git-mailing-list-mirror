Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245491F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfJXXlN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:41:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730783AbfJXXlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:41:12 -0400
Received: (qmail 27154 invoked by uid 109); 24 Oct 2019 23:41:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 23:41:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6670 invoked by uid 111); 24 Oct 2019 23:44:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 19:44:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 19:41:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/23] remember commit/tag parse failures
Message-ID: <20191024234111.GC32602@sigill.intra.peff.net>
References: <20191018044721.GD17879@sigill.intra.peff.net>
 <20191024232546.70565-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191024232546.70565-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 04:25:46PM -0700, Jonathan Tan wrote:

> Firstly, this patch is not about remembering, but about not setting
> anything, so I think that the title should be something like:
> 
>   commit, tag: set parsed only if no parsing error

True. I had also played with actually remembering via a bit, which I
think is how I ended up thinking about it that way. You could argue that
it is "not forgetting", which is remembering. :) But I think your
suggested title is better.

> Incidentally, the check that you mentioned in PATCH 02 is probably no
> longer necessary. The tests all pass even with the following diff:
> 
> diff --git a/commit.c b/commit.c
> index e12e7998ad..086011d944 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -359,7 +359,7 @@ struct tree *repo_get_commit_tree(struct repository *r,
>  struct object_id *get_commit_tree_oid(const struct commit *commit)
>  {
>         struct tree *tree = get_commit_tree(commit);
> -       return tree ? &tree->object.oid : NULL;
> +       return &tree->object.oid;
>  }

Ah, I see the confusion you had earlier. The check I meant in patch 2
(and here) was the one in write_graph_chunk_data(), which checks for a
non-NULL tree even after we just saw a successful parse.

I agree that getting rid of the check in get_commit_tree_oid() is
unlikely to cause any bugs, but there are still cases where it could
help. Namely if I choose to ignore the parse failure (because I want to
see the parts of the commit struct that we did manage to get), then I'd
like to be able to ask whether we have a valid tree, like:

  oid = get_commit_tree_oid(commit);
  if (!oid)
	do something...

With the revert you showed above, that's dangerous, because we'd get a
bogus value like "8" (because the oid is offset 8 bytes in the struct
which we've dereferenced as NULL).

You could obviously use "get_commit_tree()" instead, which would let you
compare to NULL. But it seemed simpler to leave the extra safety in
place.

-Peff
