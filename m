Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1106FC6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCXTKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCXTKL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:10:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FCC109
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:10:10 -0700 (PDT)
Received: (qmail 6173 invoked by uid 109); 24 Mar 2023 19:10:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Mar 2023 19:10:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4733 invoked by uid 111); 24 Mar 2023 19:10:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Mar 2023 15:10:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Mar 2023 15:10:09 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <20230324191009.GA536967@coredump.intra.peff.net>
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 01:23:32PM -0400, Derrick Stolee wrote:

> Could you make sure to run 'git commit-graph write --reachable' before
> testing again?
> 
> When the commit-graph exists on disk, the algorithm does do a single
> reachability walk from all the initial points. If it does not exist,
> then each starting point triggers its own reachability walk, which
> is significantly slower. See repo_is_descendant_of() in commit-reach.c
> for more information on this split.

I'm a bit confused by that reference. We do switch behavior based on the
presence of generation numbers in repo_is_descendant_of(). But
ref-filter calls that function from commit_contains(), which is only fed
one ref at a time. So we'll still do several walks, one per ref.

In commit_contains() we'll use the "tag algo" instead of calling
repo_is_descendant_of(). It still sees the refs individually, but it
keeps a cache to avoid walking over the same parts of history. We didn't
traditionally use that algorithm for branches because it has a tendency
to walk down to the roots (which is OK for tags, where you have old ones
that require walking down that far anyway, but not for branches, where
you can usually stop at a recent merge base). But now that we have
reliable generation numbers, we can stop that traversal early.

But it doesn't look like we actually trigger the tag algo for anything
but git-tag. I.e., I wonder if we should be doing something like this:

diff --git a/commit-reach.c b/commit-reach.c
index 7c0c39fd286..16c1a341bf5 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -712,7 +712,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache)
 {
-	if (filter->with_commit_tag_algo)
+	if (filter->with_commit_tag_algo ||
+	    generation_numbers_enabled(the_repository))
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
 	return repo_is_descendant_of(the_repository, commit, list);
 }

The speedup is pretty minor compared to using commit-graphs at all.
Doing "git for-each-ref --format='%(refname)' --contains HEAD" on a
clone of linux.git gets me:

  - with no commit graph: 1m40s
  - after "commit-graph write --reachable": 30ms
  - plus the patch above; 23ms

So most of the help comes from not parsing the commit objects (courtesy
of the commit graph) and perhaps some early cutoffs (due to the use of
generation numbers in repo_is_descendant_of()). Using the cached walk
helps a little, but it may be more so for certain patterns of data.

I also scratched my head a little that we are still using
commit_contains() at all. I thought we now had functions to do a single
walk that would give us an answer for each ref, and that we could
trigger that in filter_refs(). And we do have reach_filter() there, but
I think it only handles --merged/--no-merged.

I admit I haven't kept up with the state of things here, so I'm not sure
what tools we have available.

-Peff
