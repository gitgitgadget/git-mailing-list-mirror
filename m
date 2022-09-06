Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E593C38145
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 21:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiIFVCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIFVCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 17:02:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F26A8CC7
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 14:02:14 -0700 (PDT)
Received: (qmail 19329 invoked by uid 109); 6 Sep 2022 21:02:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 21:02:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5760 invoked by uid 111); 6 Sep 2022 21:02:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 17:02:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 17:02:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] lookup_commit_in_graph(): use prepare_commit_graph() to
 check for graph
Message-ID: <Yxe1VbyYovwprPgQ@coredump.intra.peff.net>
References: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We exit early from lookup_commit_in_graph() if the commit_graph pointer
is NULL, under the assumption that we don't have a graph to look at. But
the graph pointer is lazy-loaded; if no other code happens to have
called prepare_commit_graph(), we'll incorrectly assume that one isn't
available at all.

This has a pretty small performance impact in practice, because the
fallback will generally be to call parse_object() instead. That ends up
in parse_commit_buffer(), which loads the graph data itself. So the
first commit we see won't use the graph, but subsequent ones will. Since
using the graph is just an optimization there's generally no
user-visible difference, but if you instrument rev-list like so:

  diff --git a/revision.c b/revision.c
  index ee702e498a..63c488ffb6 100644
  --- a/revision.c
  +++ b/revision.c
  @@ -381,6 +381,9 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
           * parsing commit data from disk.
           */
          commit = lookup_commit_in_graph(revs->repo, oid);
  +       warning("%s %s in commit graph",
  +               commit ? "found" : "did not find",
  +               name);
          if (commit)
                  object = &commit->object;
          else

and run (in git.git):

  git commit-graph write --reachable
  git rev-list origin/master origin/next >/dev/null

you'll see that we fail to find the first one:

  warning: did not find origin/master in commit graph
  warning: found origin/next in commit graph

After this patch, you'll see that we find both:

  warning: found origin/master in commit graph
  warning: found origin/next in commit graph

Even though the performance implication is small here, there are two
important reasons to do this:

  - it's downright confusing if you are hunting a bug triggered by the
    use of the commit graph. It may or may not trigger depending on the
    number and ordering of tips you ask for.

  - prepare_commit_graph() has other policy logic, too. In particular,
    if we've loaded a commit graph and then disabled the graph via
    disable_commit_graph(), that should take precedence.

    I'm not sure if this can trigger bad behavior in practice. The only
    caller there is upload-pack's deepen_by_rev_list(), which should be
    avoiding the commit graph for its traversal tips, but probably
    wasn't before this patch. Whether you could come up with a case
    where that mattered is unclear. Still, this is obviously the right
    thing to be doing.

Signed-off-by: Jeff King <peff@peff.net>
---
I couldn't find any other reason to avoid calling prepare_commit_graph()
here (especially since it ends up lazy-loaded as discussed above). The
cost of the call should not be high; after the first call, it is
simplified down to a few integer checks.

 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index f2a36032f8..aef076e145 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -901,7 +901,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 	struct commit *commit;
 	uint32_t pos;
 
-	if (!repo->objects->commit_graph)
+	if (!prepare_commit_graph(repo))
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-- 
2.37.3.1134.gfd534b3986

