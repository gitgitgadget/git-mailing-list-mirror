Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37AC83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjHaGR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHaGR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:17:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139F1B1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:17:55 -0700 (PDT)
Received: (qmail 21139 invoked by uid 109); 31 Aug 2023 06:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:17:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2951 invoked by uid 111); 31 Aug 2023 06:17:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:17:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:17:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/10] tree-walk: reduce stack size for recursive functions
Message-ID: <20230831061754.GA3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The traverse_trees() and traverse_trees_recursive() functions call each
other recursively. In a deep tree, this can result in running out of
stack space and crashing.

There's obviously going to be some limit here based on available stack,
but the problem is exacerbated by a few large structs, many of which we
over-allocate. For example, in traverse_trees() we store a name_entry
and tree_desc_x per tree, both of which contain an object_id (which is
now 32 bytes). And we allocate 8 of them (from MAX_TRAVERSE_TREES), even
though many traversals will only look at 1 or 2.

Interestingly, we used to allocate these on the heap, prior to
8dd40c0472 (traverse_trees(): use stack array for name entries,
2020-01-30). That commit was trying to simplify away allocation size
computations, and naively assumed that the sizes were small enough not
to matter. And they don't in normal cases, but on my stock Debian system
I see a crash running "git archive" on a tree with ~3600 entries.
That's deep enough we wouldn't see it in practice, but probably shallow
enough that we'd prefer not to make it a hard limit. Especially because
other systems may have even smaller stacks.

We can replace these stack variables with a few malloc invocations. This
reduces the stack sizes for the two functions from 1128 and 752 bytes,
respectively, down to 40 and 92 bytes. That allows a depth of ~13000 on
my machine (the improvement isn't in linear proportion because my
numbers don't count the size of parameters and other function overhead).

The possible downsides are:

  1. We now have to remember to free(). But both functions have an easy
     single exit (and already had to clean up other bits anyway).

  2. The extra malloc()/free() overhead might be measurable. I tested
     this by setting up a 3000-depth tree with a single blob and running
     "git archive" on it. After switching to the heap, it consistently
     runs 2-3% faster! Presumably this is because the 1K+ of wasted
     stack space penalized memory caches.

On a more real-world case like linux.git, the speed difference isn't
measurable at all, simply because most trees aren't that deep and
there's so much other work going on (like accessing the objects
themselves). So the improvement I saw should be taken as evidence that
we're not making anything worse, but isn't really that interesting on
its own. The main motivation here is that we're now less likely to run
out of stack space and crash.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-walk.c    | 10 ++++++----
 unpack-trees.c |  9 +++++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 29ead71be1..ad49d55290 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -442,9 +442,9 @@ int traverse_trees(struct index_state *istate,
 		   struct traverse_info *info)
 {
 	int error = 0;
-	struct name_entry entry[MAX_TRAVERSE_TREES];
+	struct name_entry *entry;
 	int i;
-	struct tree_desc_x tx[ARRAY_SIZE(entry)];
+	struct tree_desc_x *tx;
 	struct strbuf base = STRBUF_INIT;
 	int interesting = 1;
 	char *traverse_path;
@@ -455,8 +455,8 @@ int traverse_trees(struct index_state *istate,
 	if (traverse_trees_cur_depth > traverse_trees_max_depth)
 		traverse_trees_max_depth = traverse_trees_cur_depth;
 
-	if (n >= ARRAY_SIZE(entry))
-		BUG("traverse_trees() called with too many trees (%d)", n);
+	ALLOC_ARRAY(entry, n);
+	ALLOC_ARRAY(tx, n);
 
 	for (i = 0; i < n; i++) {
 		tx[i].d = t[i];
@@ -551,6 +551,8 @@ int traverse_trees(struct index_state *istate,
 	}
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
+	free(tx);
+	free(entry);
 	free(traverse_path);
 	info->traverse_path = NULL;
 	strbuf_release(&base);
diff --git a/unpack-trees.c b/unpack-trees.c
index 87517364dc..a203f9a3d7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -864,8 +864,8 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	struct unpack_trees_options *o = info->data;
 	int i, ret, bottom;
 	int nr_buf = 0;
-	struct tree_desc t[MAX_UNPACK_TREES];
-	void *buf[MAX_UNPACK_TREES];
+	struct tree_desc *t;
+	void **buf;
 	struct traverse_info newinfo;
 	struct name_entry *p;
 	int nr_entries;
@@ -902,6 +902,9 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.pathlen = st_add3(newinfo.pathlen, tree_entry_len(p), 1);
 	newinfo.df_conflicts |= df_conflicts;
 
+	ALLOC_ARRAY(t, n);
+	ALLOC_ARRAY(buf, n);
+
 	/*
 	 * Fetch the tree from the ODB for each peer directory in the
 	 * n commits.
@@ -937,6 +940,8 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 
 	for (i = 0; i < nr_buf; i++)
 		free(buf[i]);
+	free(buf);
+	free(t);
 
 	return ret;
 }
-- 
2.42.0.561.gaa987ecc69

