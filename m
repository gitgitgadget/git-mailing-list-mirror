Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42F2C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877D3613DC
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhGAVjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:39:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:39284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGAVjW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 17:39:22 -0400
Received: (qmail 29012 invoked by uid 109); 1 Jul 2021 21:36:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 21:36:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19388 invoked by uid 111); 1 Jul 2021 21:36:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 17:36:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 17:36:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/3] tree-diff: use pathspec tries
Message-ID: <YN41crLqEwmRTy4G@coredump.intra.peff.net>
References: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree-diff currently matches each pathspec against every
entry of the tree. For the common case of a handful of
pathspecs, this is not a big deal. However, if you have a
large number of pathspecs, it gets noticeably slow.

Now that we have the pathspec_trie optimization, we can do
much better (at least for simple cases without wildcards).
Here are numbers for running "git rev-list" with limiting
pathspecs of varying sizes, both before and after this
patch:

Test                 origin              HEAD
---------------------------------------------------------------
4001.2: size=1       0.12(0.11+0.00)     0.12(0.12+0.00) +0.0%
4001.3: size=2       0.17(0.16+0.00)     0.16(0.15+0.01) -5.9%
4001.4: size=4       0.17(0.17+0.00)     0.17(0.17+0.00) +0.0%
4001.5: size=8       0.21(0.20+0.00)     0.20(0.20+0.00) -4.8%
4001.6: size=16      0.25(0.24+0.00)     0.21(0.20+0.00) -16.0%
4001.7: size=32      0.31(0.31+0.00)     0.21(0.20+0.00) -32.3%
4001.8: size=64      0.43(0.41+0.01)     0.21(0.21+0.00) -51.2%
4001.9: size=128     0.73(0.72+0.00)     0.22(0.21+0.00) -69.9%
4001.10: size=256    2.02(2.02+0.00)     0.37(0.36+0.00) -81.7%
4001.11: size=512    6.78(6.78+0.00)     0.64(0.64+0.00) -90.6%
4001.12: size=1024   23.67(23.67+0.02)   1.22(1.20+0.01) -94.8%

For small pathspecs, we produce no real difference (which is
good; we know we are asymptotically better, but we have not
regressed our constant factor). Between 16 and 32 pathspecs we
start to see some small improvement, and the benefit keeps
growing with the number of pathspecs.

Obviously these large-pathspec cases are unusual. But you
might use them, for example, if the pathspecs were generated
programatically (e.g., if you want the history of all files
that are in Documentation/ _now_, not what was historically
ever there, you would expand the pathspec at the current
tree, and feed the result to rev-list).

Signed-off-by: Jeff King <peff@peff.net>
---
This commit message is the original from 2014. The perf script got
bumped to p4002, but the results today are similar (actually, the
"before" code is slower, but perhaps that's because we have a lot more
commits in git.git these days).

 t/perf/p4002-diff-pathspec.sh |  26 +++++++++
 tree-diff.c                   | 102 +++++++++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 13 deletions(-)
 create mode 100755 t/perf/p4002-diff-pathspec.sh

diff --git a/t/perf/p4002-diff-pathspec.sh b/t/perf/p4002-diff-pathspec.sh
new file mode 100755
index 0000000000..3d35b3579d
--- /dev/null
+++ b/t/perf/p4002-diff-pathspec.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='diff performance with many pathspecs'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+sizes='1 2 4 8 16 32 64 128 256 512 1024'
+
+test_expect_success 'create pathspec lists' '
+	git ls-tree --name-only -r HEAD >all &&
+	for i in $sizes; do
+		{
+			printf "%s\n" -- &&
+			head -$i all
+		} >ps-$i
+	done
+'
+
+for i in $sizes; do
+	test_perf "size=$i" "
+		git rev-list HEAD --stdin <ps-$i >/dev/null
+	"
+done
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index 1572615bd9..47836941dd 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -28,7 +28,8 @@
 static struct combine_diff_path *ll_diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
-	struct strbuf *base, struct diff_options *opt);
+	struct strbuf *base, struct diff_options *opt,
+	struct pathspec_trie *pst);
 static void ll_diff_tree_oid(const struct object_id *old_oid,
 			     const struct object_id *new_oid,
 			     struct strbuf *base, struct diff_options *opt);
@@ -179,7 +180,7 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	struct strbuf *base, struct diff_options *opt, int nparent,
 	struct tree_desc *t, struct tree_desc *tp,
-	int imin)
+	int imin, struct pathspec_trie *pst)
 {
 	unsigned short mode;
 	const char *path;
@@ -283,23 +284,95 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 			parents_oid[i] = tpi_valid ? &tp[i].entry.oid : NULL;
 		}
 
+		/*
+		 * As we recurse through the tree objects, move through
+		 * our pathspec trie, as well. The one exception is if
+		 * we already hit a terminal node. This means we have a strict
+		 * prefix match (e.g., "foo/" matched, and we are in
+		 * "foo/bar"). We don't have to bother with checking the
+		 * pathspec at all anymore in that case.
+		 *
+		 * Note that the "pos < 0" case should not happen here,
+		 * as we would have skipped the tree entry as uninteresting
+		 * earlier. As a safety measure, we turn off the trie
+		 * optimization and fall back to doing regular pathspec
+		 * matching in this case.
+		 */
+		if (pst && !pst->terminal) {
+			int pos = pathspec_trie_lookup(pst, path, pathlen);
+			if (pos < 0)
+				pst = NULL;
+			else
+				pst = pst->entries[pos];
+		}
+
 		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
-		p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
+		p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt, pst);
 		FAST_ARRAY_FREE(parents_oid, nparent);
 	}
 
 	strbuf_setlen(base, old_baselen);
 	return p;
 }
 
+static enum interesting match_pathspec_trie_entry(struct pathspec_trie *pst,
+						  const struct name_entry *entry)
+{
+	int pos;
+
+	/*
+	 * If our base directory is matched, then everything below is
+	 * interesting (i.e., a prefix match).
+	 */
+	if (pst->terminal)
+		return entry_interesting;
+
+	/*
+	 * Otherwise, look up the actual entry. If we don't mention it at all,
+	 * it's definitely uninteresting. But furthermore, if we're at the
+	 * end of our sorted list, we know that nothing after it is
+	 * interesting, either.
+	 *
+	 * XXX It seems like we should have to make special consideration here
+	 * for the sort order of trees. But tree_entry_interesting does not
+	 * seem to. Is it OK, is tree_entry_interesting buggy too, or am I
+	 * reading it wrong? This optimization gives substantial speedups, so
+	 * we really need to keep it or something like it.
+	 */
+	pos = pathspec_trie_lookup(pst, entry->path, tree_entry_len(entry));
+	if (pos < 0) {
+		if (-pos - 1 == pst->nr)
+			return all_entries_not_interesting;
+		else
+			return entry_not_interesting;
+	}
+
+	/*
+	 * We definitely have the entry. First we have to resolve any directory
+	 * restrictions; if there aren't any, then it's definitely interesting.
+	 *
+	 * Note that we do not need to check the "terminal" flag of the
+	 * resulting trie node. If it is not set, then this particular entry
+	 * does not match our pathspec, but we do still need to traverse
+	 * through it to get to the interesting things inside. It's interesting
+	 * either way.
+	 */
+	if (pst->entries[pos]->must_be_dir)
+		return !!S_ISDIR(entry->mode);
+	return entry_interesting;
+}
+
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
-			       struct diff_options *opt)
+			       struct diff_options *opt,
+			       struct pathspec_trie *pst)
 {
 	enum interesting match;
 
 	while (t->size) {
-		match = tree_entry_interesting(opt->repo->index, &t->entry,
+		match = pst ?
+			match_pathspec_trie_entry(pst, &t->entry) :
+			tree_entry_interesting(opt->repo->index, &t->entry,
 					       base, 0, &opt->pathspec);
 		if (match) {
 			if (match == all_entries_not_interesting)
@@ -310,7 +383,6 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 	}
 }
 
-
 /*
  * generate paths for combined diff D(sha1,parents_oid[])
  *
@@ -406,7 +478,8 @@ static inline void update_tp_entries(struct tree_desc *tp, int nparent)
 static struct combine_diff_path *ll_diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
-	struct strbuf *base, struct diff_options *opt)
+	struct strbuf *base, struct diff_options *opt,
+	struct pathspec_trie *pst)
 {
 	struct tree_desc t, *tp;
 	void *ttree, **tptree;
@@ -438,9 +511,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			break;
 
 		if (opt->pathspec.nr) {
-			skip_uninteresting(&t, base, opt);
+			skip_uninteresting(&t, base, opt, pst);
 			for (i = 0; i < nparent; i++)
-				skip_uninteresting(&tp[i], base, opt);
+				skip_uninteresting(&tp[i], base, opt, pst);
 		}
 
 		/* comparing is finished when all trees are done */
@@ -505,7 +578,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			/* D += {δ(t,pi) if pi=p[imin];  "+a" if pi > p[imin]} */
 			p = emit_path(p, base, opt, nparent,
-					&t, tp, imin);
+					&t, tp, imin, pst);
 
 		skip_emit_t_tp:
 			/* t↓,  ∀ pi=p[imin]  pi↓ */
@@ -517,7 +590,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		else if (cmp < 0) {
 			/* D += "+t" */
 			p = emit_path(p, base, opt, nparent,
-					&t, /*tp=*/NULL, -1);
+					&t, /*tp=*/NULL, -1, pst);
 
 			/* t↓ */
 			update_tree_entry(&t);
@@ -533,7 +606,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			}
 
 			p = emit_path(p, base, opt, nparent,
-					/*t=*/NULL, tp, imin);
+					/*t=*/NULL, tp, imin, pst);
 
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
@@ -555,7 +628,10 @@ struct combine_diff_path *diff_tree_paths(
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
-	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
+	/* XXX if base is not empty, we need to walk its paths
+	 * to get to the right level of the trie */
+	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt,
+			       opt->pathspec.trie);
 
 	/*
 	 * free pre-allocated last element, if any
-- 
2.32.0.359.g3de86e008e.dirty
