Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630EB1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 05:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeKBO2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:28:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37638 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727350AbeKBO2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:28:53 -0400
Received: (qmail 26574 invoked by uid 109); 2 Nov 2018 05:23:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 05:23:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 638 invoked by uid 111); 2 Nov 2018 05:22:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 01:22:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 01:22:59 -0400
Date:   Fri, 2 Nov 2018 01:22:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] rev-list: handle flags for --indexed-objects
Message-ID: <20181102052258.GA19234@sigill.intra.peff.net>
References: <20181102052239.GA19162@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102052239.GA19162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a traversal sees the --indexed-objects option, it adds
all blobs and valid cache-trees from the index to the
traversal using add_index_objects_to_pending(). But that
function totally ignores its flags parameter!

That means that doing:

  git rev-list --objects --indexed-objects

and

  git rev-list --objects --not --indexed-objects

produce the same output, because we ignore the UNINTERESTING
flag when walking the index in the second example.

Nobody noticed because this feature was added as a way for
tools like repack to increase their coverage of reachable
objects, meaning it would only be used like the first
example above.

But since it's user facing (and because the documentation
describes it "as if the objects are listed on the command
line"), we should make sure the negative case behaves
sensibly.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c               | 15 +++++++++------
 t/t6000-rev-list-misc.sh |  7 +++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index a1ddb9e11c..8e56c9641f 100644
--- a/revision.c
+++ b/revision.c
@@ -1321,13 +1321,14 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
-			   struct strbuf *path)
+			   struct strbuf *path, unsigned int flags)
 {
 	size_t baselen = path->len;
 	int i;
 
 	if (it->entry_count >= 0) {
 		struct tree *tree = lookup_tree(revs->repo, &it->oid);
+		tree->object.flags |= flags;
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
@@ -1335,14 +1336,15 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *sub = it->down[i];
 		strbuf_addf(path, "%s%s", baselen ? "/" : "", sub->name);
-		add_cache_tree(sub->cache_tree, revs, path);
+		add_cache_tree(sub->cache_tree, revs, path, flags);
 		strbuf_setlen(path, baselen);
 	}
 
 }
 
 static void do_add_index_objects_to_pending(struct rev_info *revs,
-					    struct index_state *istate)
+					    struct index_state *istate,
+					    unsigned int flags)
 {
 	int i;
 
@@ -1356,13 +1358,14 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 		blob = lookup_blob(revs->repo, &ce->oid);
 		if (!blob)
 			die("unable to add index blob to traversal");
+		blob->object.flags |= flags;
 		add_pending_object_with_path(revs, &blob->object, "",
 					     ce->ce_mode, ce->name);
 	}
 
 	if (istate->cache_tree) {
 		struct strbuf path = STRBUF_INIT;
-		add_cache_tree(istate->cache_tree, revs, &path);
+		add_cache_tree(istate->cache_tree, revs, &path, flags);
 		strbuf_release(&path);
 	}
 }
@@ -1372,7 +1375,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	struct worktree **worktrees, **p;
 
 	read_index(revs->repo->index);
-	do_add_index_objects_to_pending(revs, revs->repo->index);
+	do_add_index_objects_to_pending(revs, revs->repo->index, flags);
 
 	if (revs->single_worktree)
 		return;
@@ -1388,7 +1391,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 		if (read_index_from(&istate,
 				    worktree_git_path(wt, "index"),
 				    get_worktree_git_dir(wt)) > 0)
-			do_add_index_objects_to_pending(revs, &istate);
+			do_add_index_objects_to_pending(revs, &istate, flags);
 		discard_index(&istate);
 	}
 	free_worktrees(worktrees);
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index fb4d295aa0..0507999729 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -90,11 +90,18 @@ test_expect_success 'rev-list can show index objects' '
 	9200b628cf9dc883a85a7abc8d6e6730baee589c two
 	EOF
 	echo only-in-index >only-in-index &&
+	test_when_finished "git reset --hard" &&
 	git add only-in-index &&
 	git rev-list --objects --indexed-objects >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list can negate index objects' '
+	git rev-parse HEAD >expect &&
+	git rev-list -1 --objects HEAD --not --indexed-objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--bisect and --first-parent can not be combined' '
 	test_must_fail git rev-list --bisect --first-parent HEAD
 '
-- 
2.19.1.1336.g081079ac04

