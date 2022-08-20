Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C915C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 09:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbiHTJCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 05:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbiHTJCu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 05:02:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD54205CB
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 02:02:49 -0700 (PDT)
Received: (qmail 21900 invoked by uid 109); 20 Aug 2022 09:02:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 09:02:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10043 invoked by uid 111); 20 Aug 2022 09:02:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 05:02:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 05:02:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 4/6] verify_one_sparse(): drop unused repository parameter
Message-ID: <YwCjOETsh1o8u0Og@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9O+HDMLKglLcqY@coredump.intra.peff.net>
 <9829e1cf-21aa-0c10-0b64-c8a2ffdbc943@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9829e1cf-21aa-0c10-0b64-c8a2ffdbc943@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 10:48:47AM +0200, René Scharfe wrote:

> > diff --git a/cache-tree.c b/cache-tree.c
> > index 56db0b5026..c97111cccf 100644
> > --- a/cache-tree.c
> > +++ b/cache-tree.c
> > @@ -857,9 +857,7 @@ int cache_tree_matches_traversal(struct cache_tree *root,
> >  	return 0;
> >  }
> >
> > -static void verify_one_sparse(struct repository *r,
> > -			      struct index_state *istate,
> > -			      struct cache_tree *it,
> > +static void verify_one_sparse(struct index_state *istate,
> 
> This also removes the cache_tree parameter, which has never been used as
> well, but is not mentioned in the commit message.  A good change, to be
> sure.

Good catch. I wrote the patch itself over a year ago (whenever the
commit made it into 'next' and failed my compilation), but I didn't
write the commit message until recently. And when re-reading the patch I
totally missed that _two_ parameters went away.

Given that and Stolee's earlier comment, here's a proposed commit
message that explains it better:

-- >8 --
Subject: verify_one_sparse(): drop unused parameters

This function has never used its repository or cache_tree parameters
since it was introduced in 9ad2d5ea71 (sparse-index: loose integration
with cache_tree_verify(), 2021-03-30).

As that commit notes, it may eventually be extended further, and that
might require looking at more data. But we can easily add them back if
necessary (and the repository is even included in the index_state these
days already). In the mean time, dropping them makes the code shorter
and appeases -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 56db0b5026..c97111cccf 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -857,9 +857,7 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 	return 0;
 }
 
-static void verify_one_sparse(struct repository *r,
-			      struct index_state *istate,
-			      struct cache_tree *it,
+static void verify_one_sparse(struct index_state *istate,
 			      struct strbuf *path,
 			      int pos)
 {
@@ -910,7 +908,7 @@ static int verify_one(struct repository *r,
 			return 1;
 
 		if (pos >= 0) {
-			verify_one_sparse(r, istate, it, path, pos);
+			verify_one_sparse(istate, path, pos);
 			return 0;
 		}
 
-- 
2.37.2.964.g6266ca593d

