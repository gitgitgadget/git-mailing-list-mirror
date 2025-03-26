Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA9255E55
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020399; cv=none; b=G/fsnEpharF8Z3OUD+jRQ/HDwb8GfTsolvkgp8HocV+nzAgcKK3Awl3rI1eoLAODXSyaXpObAV8m4Ipofae55zpVV+W4Y1kQqQf0/eqMluWpBHoszORjFPxSIPn7+HHguM6eI/sff7SUELP+F0lOVHTHhIqzx1D+BB3FM34Skuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020399; c=relaxed/simple;
	bh=Qb8O1CLZbww2BvKRKk4p2z5pz2dFNkLVnqaU5euU7bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOpHpo/Za0wfq9aSAMqB2vfRvymKIDJKHMpFWyX4CiOzy8zhzmiMmJ0qSdNttcffQ17YdTLVN2KF/IBea/csyWAHKSHnCl65DEhTZJr5CEYQvtr9JUwkPP85sDJormZfIBp5HW6/Rwt+fFhwK4laiMtMj+MfMRoTh5S94Q7nRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=KM+kWJnC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="KM+kWJnC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICR27UkxxjH7++DZkx80GSOaDA5KH2fxXg7+Kx5RtxA=;
	b=KM+kWJnCryy86YhHUBJ7LNJVaWchB2wa7tBinsZfB2wJvph3C3i+NyVKTkZhVbdzx6HdlA
	TyXwpK8hiyTUmwibku3IDga4L7Ar1jkZPRiZpp1gNo8cv9hVQnKrSAo3BCIYJr9ojFvvT3
	uObccpLUYr7GaRlqGNHBwRhYkCt5/GM=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Mar 2025 21:18:31 +0100
Subject: [PATCH 7/8] tree-diff: use pathspec tries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-toon-blame-tree-v1-7-4173133f3786@iotcl.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

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
4003.2: size=1       0.12(0.11+0.00)     0.12(0.12+0.00) +0.0%
4003.3: size=2       0.17(0.16+0.00)     0.16(0.15+0.01) -5.9%
4003.4: size=4       0.17(0.17+0.00)     0.17(0.17+0.00) +0.0%
4003.5: size=8       0.21(0.20+0.00)     0.20(0.20+0.00) -4.8%
4003.6: size=16      0.25(0.24+0.00)     0.21(0.20+0.00) -16.0%
4003.7: size=32      0.31(0.31+0.00)     0.21(0.20+0.00) -32.3%
4003.8: size=64      0.43(0.41+0.01)     0.21(0.21+0.00) -51.2%
4003.9: size=128     0.73(0.72+0.00)     0.22(0.21+0.00) -69.9%
4003.10: size=256    2.02(2.02+0.00)     0.37(0.36+0.00) -81.7%
4003.11: size=512    6.78(6.78+0.00)     0.64(0.64+0.00) -90.6%
4003.12: size=1024   23.67(23.67+0.02)   1.22(1.20+0.01) -94.8%

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
 t/perf/p4003-diff-pathspec.sh | 26 ++++++++++++
 tree-diff.c                   | 98 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/t/perf/p4003-diff-pathspec.sh b/t/perf/p4003-diff-pathspec.sh
new file mode 100755
index 0000000000..02312d1b0c
--- /dev/null
+++ b/t/perf/p4003-diff-pathspec.sh
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
+		} >ps-$i || return 1
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
index 2a744dfaec..f3d916201b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -120,7 +120,8 @@ static void ll_diff_tree_paths(
 	struct combine_diff_path ***tail, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt,
-	int depth);
+	int depth, struct pathspec_trie *pst);
+
 static void ll_diff_tree_oid(const struct object_id *old_oid,
 			     const struct object_id *new_oid,
 			     struct strbuf *base, struct diff_options *opt);
@@ -205,7 +206,7 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
 static void emit_path(struct combine_diff_path ***tail,
 		      struct strbuf *base, struct diff_options *opt,
 		      int nparent, struct tree_desc *t, struct tree_desc *tp,
-		      int imin, int depth)
+		      int imin, int depth, struct pathspec_trie *pst)
 {
 	unsigned short mode;
 	const char *path;
@@ -309,23 +310,95 @@ static void emit_path(struct combine_diff_path ***tail,
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
 		ll_diff_tree_paths(tail, oid, parents_oid, nparent, base, opt,
-				   depth + 1);
+				   depth + 1, pst);
 		FAST_ARRAY_FREE(parents_oid, nparent);
 	}
 
 	strbuf_setlen(base, old_baselen);
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
 					       base, &opt->pathspec);
 		if (match) {
 			if (match == all_entries_not_interesting)
@@ -433,7 +506,7 @@ static void ll_diff_tree_paths(
 	struct combine_diff_path ***tail, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt,
-	int depth)
+	int depth, struct pathspec_trie *pst)
 {
 	struct tree_desc t, *tp;
 	void *ttree, **tptree;
@@ -468,9 +541,9 @@ static void ll_diff_tree_paths(
 			break;
 
 		if (opt->pathspec.nr) {
-			skip_uninteresting(&t, base, opt);
+			skip_uninteresting(&t, base, opt, pst);
 			for (i = 0; i < nparent; i++)
-				skip_uninteresting(&tp[i], base, opt);
+				skip_uninteresting(&tp[i], base, opt, pst);
 		}
 
 		/* comparing is finished when all trees are done */
@@ -535,7 +608,7 @@ static void ll_diff_tree_paths(
 
 			/* D += {δ(t,pi) if pi=p[imin];  "+a" if pi > p[imin]} */
 			emit_path(tail, base, opt, nparent,
-				  &t, tp, imin, depth);
+				  &t, tp, imin, depth, pst);
 
 		skip_emit_t_tp:
 			/* t↓,  ∀ pi=p[imin]  pi↓ */
@@ -547,7 +620,7 @@ static void ll_diff_tree_paths(
 		else if (cmp < 0) {
 			/* D += "+t" */
 			emit_path(tail, base, opt, nparent,
-				  &t, /*tp=*/NULL, -1, depth);
+				  &t, /*tp=*/NULL, -1, depth, pst);
 
 			/* t↓ */
 			update_tree_entry(&t);
@@ -563,7 +636,7 @@ static void ll_diff_tree_paths(
 			}
 
 			emit_path(tail, base, opt, nparent,
-				  /*t=*/NULL, tp, imin, depth);
+				  /*t=*/NULL, tp, imin, depth, pst);
 
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
@@ -584,7 +657,8 @@ struct combine_diff_path *diff_tree_paths(
 	struct strbuf *base, struct diff_options *opt)
 {
 	struct combine_diff_path *head = NULL, **tail = &head;
-	ll_diff_tree_paths(&tail, oid, parents_oid, nparent, base, opt, 0);
+	ll_diff_tree_paths(&tail, oid, parents_oid, nparent, base, opt,
+			   0, opt->pathspec.trie);
 	return head;
 }
 

-- 
2.49.0.rc2

