Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37097C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2AC207C3
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 11:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgI3Lwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 07:52:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:45256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbgI3Lwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 07:52:42 -0400
Received: (qmail 23579 invoked by uid 109); 30 Sep 2020 11:52:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 11:52:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27568 invoked by uid 111); 30 Sep 2020 11:52:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 07:52:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 07:52:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] combine-diff: handle --find-object in multitree code path
Message-ID: <20200930115240.GA1899467@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing combined diffs, we have two possible code paths:

  - a slower one which independently diffs against each parent, applies
    any filters, and then intersects the resulting paths

  - a faster one which walks all trees simultaneously

When the diff options specify that we must do certain filters, like
pickaxe, then we always use the slow path, since the pickaxe code only
knows how to handle filepairs, not the n-parent entries generated for
combined diffs.

But there are two problems with the slow path:

 1. It's slow. Running:

      git rev-list HEAD | git diff-tree --stdin -r -c

    in git.git takes ~3s on my machine. But adding "--find-object" to
    that increases it to ~6s, even though find-object itself should
    incur only a few extra oid comparisons. On linux.git, it's even
    worse: 35s versus 215s.

 2. It doesn't catch all cases where a particular path is interesting.
    Consider a merge with parent blobs X and Y for a particular path,
    and end result Z. That should be interesting according to "-c",
    because the result doesn't match either parent. And it should be
    interesting even with "--find-object=X", because "X" went away in
    the merge.

    But because we perform each pairwise diff independently, this
    confuses the intersection code. The change from X to Z is still
    interesting according to --find-object. But in the other parent we
    went from Y to Z, so the diff appears empty! That causes the
    intersection code to think that parent didn't change the path, and
    thus it's not interesting for "-c".

This patch fixes both by implementing --find-object for the multitree
code. It's a bit unfortunate that we have to duplicate some logic from
diffcore-pickaxe, but this is the best we can do for now. In an ideal
world, all of the diffcore code would stop thinking about filepairs and
start thinking about n-parent sets, and we could use the multitree walk
with all of it.

Until then, there are some leftover warts:

  - other pickaxe operations, like -S or -G, still suffer from both
    problems. These would be hard to adapt because they rely on having
    a diff_filespec() for each path to look at content. And we'd need to
    define what an n-way "change" means in each case (probably easy for
    "-S", which can compare counts, but not so clear for -G, which is
    about grepping diffs).

  - other options besides --find-object may cause us to use the slow
    pairwise path, in which case we'll go back to producing a different
    (wrong) answer for the X/Y/Z case above.

We may be able to hack around these, but I think the ultimate solution
will be a larger rewrite of the diffcore code. For now, this patch
improves one specific case but leaves the rest.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm a little nervous that the second "wart" may actually be making
things worse, because now we sometimes produce a wrong answer and
sometime a right one, and it can be difficult to know which options
cause which (e.g., rename detection puts us onto the slow path). Is it
worse to sometimes be right and sometimes wrong, or to always be
consistently and predictably wrong? I suppose one could even argue that
the current semantics aren't "wrong", but just what we happen to
produce. But IMHO they are so un-useful as to be considered wrong.

 combine-diff.c          | 43 ++++++++++++++++++++++++++++++--
 t/t4064-diff-oidfind.sh | 55 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 002e0e5438..23bca28746 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1451,6 +1451,42 @@ static struct combine_diff_path *find_paths_multitree(
 	return paths_head.next;
 }
 
+static int match_objfind(struct combine_diff_path *path,
+			 int num_parent,
+			 const struct oidset *set)
+{
+	int i;
+	if (oidset_contains(set, &path->oid))
+		return 1;
+	for (i = 0; i < num_parent; i++) {
+		if (oidset_contains(set, &path->parent[i].oid))
+			return 1;
+	}
+	return 0;
+}
+
+static struct combine_diff_path *combined_objfind(struct diff_options *opt,
+						  struct combine_diff_path *paths,
+						  int num_parent)
+{
+	struct combine_diff_path *ret = NULL, **tail = &ret;
+	struct combine_diff_path *p = paths;
+
+	while (p) {
+		struct combine_diff_path *next = p->next;
+
+		if (match_objfind(p, num_parent, opt->objfind)) {
+			p->next = NULL;
+			*tail = p;
+			tail = &p->next;
+		} else {
+			free(p);
+		}
+		p = next;
+	}
+
+	return ret;
+}
 
 void diff_tree_combined(const struct object_id *oid,
 			const struct oid_array *parents,
@@ -1506,10 +1542,10 @@ void diff_tree_combined(const struct object_id *oid,
 			opt->flags.follow_renames	||
 			opt->break_opt != -1	||
 			opt->detect_rename	||
-			(opt->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)	||
+			(opt->pickaxe_opts &
+			 (DIFF_PICKAXE_KINDS_MASK & ~DIFF_PICKAXE_KIND_OBJFIND)) ||
 			opt->filter;
 
-
 	if (need_generic_pathscan) {
 		/*
 		 * NOTE generic case also handles --stat, as it computes
@@ -1523,6 +1559,9 @@ void diff_tree_combined(const struct object_id *oid,
 		int stat_opt;
 		paths = find_paths_multitree(oid, parents, &diffopts);
 
+		if (opt->pickaxe_opts & DIFF_PICKAXE_KIND_OBJFIND)
+			paths = combined_objfind(opt, paths, num_parent);
+
 		/*
 		 * show stat against the first parent even
 		 * when doing combined diff.
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
index 3bdf317af8..6d8c8986fc 100755
--- a/t/t4064-diff-oidfind.sh
+++ b/t/t4064-diff-oidfind.sh
@@ -65,4 +65,59 @@ test_expect_success 'find a submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up merge tests' '
+	test_commit base &&
+
+	git checkout -b boring base^ &&
+	echo boring >file &&
+	git add file &&
+	git commit -m boring &&
+
+	git checkout -b interesting base^ &&
+	echo interesting >file &&
+	git add file &&
+	git commit -m interesting &&
+
+	blob=$(git rev-parse interesting:file)
+'
+
+test_expect_success 'detect merge which introduces blob' '
+	git checkout -B merge base &&
+	git merge --no-commit boring &&
+	echo interesting >file &&
+	git commit -am "introduce blob" &&
+	git diff-tree --format=%s --find-object=$blob -c --name-status HEAD >actual &&
+	cat >expect <<-\EOF &&
+	introduce blob
+
+	AM	file
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'detect merge which removes blob' '
+	git checkout -B merge interesting &&
+	git merge --no-commit base &&
+	echo boring >file &&
+	git commit -am "remove blob" &&
+	git diff-tree --format=%s --find-object=$blob -c --name-status HEAD >actual &&
+	cat >expect <<-\EOF &&
+	remove blob
+
+	MA	file
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'do not detect merge that does not touch blob' '
+	git checkout -B merge interesting &&
+	git merge -m "untouched blob" base &&
+	git diff-tree --format=%s --find-object=$blob -c --name-status HEAD >actual &&
+	cat >expect <<-\EOF &&
+	untouched blob
+
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.28.0.1173.gad90222cf0
