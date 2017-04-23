Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43663207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046290AbdDWViU (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:38:20 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37432 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046117AbdDWVgp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A2244280E1;
        Sun, 23 Apr 2017 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983343;
        bh=UrBwfuwiJVRQmf7TKB3gji0wYA58498OyPiaLZ3eYoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0gpMGe+Eia6D6VLlZVBH7A75MvzAU2yBsDcqvJim/CPCGYhxPwotI3wGDNJ+cpb3
         6GQb2ApIiL0GJw/Ezsu6rxmUtheFJewN4OQ61SiCvI7L00TV8pA8T8khqYhI5SE2Qt
         wYG2RmxMmocWEm07AHSPr2n16nv438v+0lboTQmmIVntWeks5OhtCzehh1pUwzy4km
         BKmGqgFjrRTALKAdc44nqA9o9FGre2ECQy9gjX06k5PBkwxO/AeHXADEp5xJNiCVMM
         6Xc/8/nIoTZGy/dfBAtDLgnYINxGdvDe1Iv3g9/qrH/rU98glSgPXPQQVj+oPd6T/D
         d6/orzhHMj0wXMZGT0pfNF0oRQN8ZZnapDmyYlVqbmv4hNbs7SwVQExVWMxx2Ix03i
         lhUyHovIfaP+lmgIIQcrBrx0DAGN6mvTxDXo4h89yXyKhAlCoQrjBM13ajkyMVszHz
         5yE6CbG5I8qk6XNfDtR1Uwy+pDYJKqmMKy9vavIAda1TRDRYgbt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 52/53] tree: convert parse_tree_indirect to struct object_id
Date:   Sun, 23 Apr 2017 21:34:52 +0000
Message-Id: <20170423213453.253425-53-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert parse_tree_indirect to take a pointer to struct object_id.
Update all the callers.  This transformation was achieved using the
following semantic patch and manual updates to the declaration and
definition.  Update builtin/checkout.c manually as well, since it uses a
ternary expression not handled by the semantic patch.

@@
expression E1;
@@
- parse_tree_indirect(E1.hash)
+ parse_tree_indirect(&E1)

@@
expression E1;
@@
- parse_tree_indirect(E1->hash)
+ parse_tree_indirect(E1)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c                   | 4 ++--
 builtin/am.c                | 6 +++---
 builtin/checkout.c          | 8 ++++----
 builtin/clone.c             | 2 +-
 builtin/commit.c            | 2 +-
 builtin/ls-files.c          | 2 +-
 builtin/ls-tree.c           | 2 +-
 builtin/merge.c             | 6 +++---
 builtin/read-tree.c         | 2 +-
 builtin/reset.c             | 4 ++--
 diff-lib.c                  | 2 +-
 merge.c                     | 4 ++--
 sequencer.c                 | 2 +-
 t/helper/test-match-trees.c | 4 ++--
 tree.c                      | 4 ++--
 tree.h                      | 2 +-
 16 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/archive.c b/archive.c
index 54701e8bb..b15a922da 100644
--- a/archive.c
+++ b/archive.c
@@ -369,7 +369,7 @@ static void parse_treeish_arg(const char **argv,
 		archive_time = time(NULL);
 	}
 
-	tree = parse_tree_indirect(oid.hash);
+	tree = parse_tree_indirect(&oid);
 	if (tree == NULL)
 		die("not a tree object");
 
@@ -383,7 +383,7 @@ static void parse_treeish_arg(const char **argv,
 		if (err || !S_ISDIR(mode))
 			die("current working directory is untracked");
 
-		tree = parse_tree_indirect(tree_oid.hash);
+		tree = parse_tree_indirect(&tree_oid);
 	}
 	ar_args->tree = tree;
 	ar_args->commit_sha1 = commit_sha1;
diff --git a/builtin/am.c b/builtin/am.c
index 210ecc554..c21059e6e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2046,11 +2046,11 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	struct tree *head_tree, *remote_tree, *index_tree;
 	struct object_id index;
 
-	head_tree = parse_tree_indirect(head->hash);
+	head_tree = parse_tree_indirect(head);
 	if (!head_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(head));
 
-	remote_tree = parse_tree_indirect(remote->hash);
+	remote_tree = parse_tree_indirect(remote);
 	if (!remote_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(remote));
 
@@ -2062,7 +2062,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (write_cache_as_tree(index.hash, 0, NULL))
 		return -1;
 
-	index_tree = parse_tree_indirect(index.hash);
+	index_tree = parse_tree_indirect(&index);
 	if (!index_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(&index));
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7f1eeea94..13365fb62 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -527,10 +527,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			setup_standard_excludes(topts.dir);
 		}
 		tree = parse_tree_indirect(old->commit ?
-					   old->commit->object.oid.hash :
-					   EMPTY_TREE_SHA1_BIN);
+					   &old->commit->object.oid :
+					   &empty_tree_oid);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(new->commit->object.oid.hash);
+		tree = parse_tree_indirect(&new->commit->object.oid);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
@@ -1050,7 +1050,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	new->commit = lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
 		/* not a commit */
-		*source_tree = parse_tree_indirect(rev->hash);
+		*source_tree = parse_tree_indirect(rev);
 	} else {
 		parse_commit_or_die(new->commit);
 		*source_tree = new->commit->tree;
diff --git a/builtin/clone.c b/builtin/clone.c
index 646f28792..da2d3c1ae 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -739,7 +739,7 @@ static int checkout(int submodule_progress)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-	tree = parse_tree_indirect(oid.hash);
+	tree = parse_tree_indirect(&oid);
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)
diff --git a/builtin/commit.c b/builtin/commit.c
index d349d48ef..1d625e49e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -313,7 +313,7 @@ static void create_base_index(const struct commit *current_head)
 	opts.dst_index = &the_index;
 
 	opts.fn = oneway_merge;
-	tree = parse_tree_indirect(current_head->object.oid.hash);
+	tree = parse_tree_indirect(&current_head->object.oid);
 	if (!tree)
 		die(_("failed to unpack HEAD tree object"));
 	parse_tree(tree);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 948c7066c..cac802ff9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -414,7 +414,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 
 	if (get_oid(tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
-	tree = parse_tree_indirect(oid.hash);
+	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("bad tree-ish %s", tree_name);
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5baac3ef2..ee7b293b1 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -180,7 +180,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len = pathspec.items[i].len;
 	pathspec.has_wildcard = 0;
-	tree = parse_tree_indirect(oid.hash);
+	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
 	return !!read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
diff --git a/builtin/merge.c b/builtin/merge.c
index 5ea7f7da9..a4a098f40 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -605,13 +605,13 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
-	trees[nr_trees] = parse_tree_indirect(common->hash);
+	trees[nr_trees] = parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] = parse_tree_indirect(head->hash);
+	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] = parse_tree_indirect(one->hash);
+	trees[nr_trees] = parse_tree_indirect(one);
 	if (!trees[nr_trees++])
 		return -1;
 	opts.fn = threeway_merge;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 92eff23e4..6d45175f6 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -29,7 +29,7 @@ static int list_tree(struct object_id *oid)
 
 	if (nr_trees >= MAX_UNPACK_TREES)
 		die("I cannot read more than %d trees", MAX_UNPACK_TREES);
-	tree = parse_tree_indirect(oid->hash);
+	tree = parse_tree_indirect(oid);
 	if (!tree)
 		return -1;
 	trees[nr_trees++] = tree;
diff --git a/builtin/reset.c b/builtin/reset.c
index 3415dac5d..c782739c2 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -84,7 +84,7 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		return -1;
 
 	if (reset_type == MIXED || reset_type == HARD) {
-		tree = parse_tree_indirect(oid->hash);
+		tree = parse_tree_indirect(oid);
 		prime_cache_tree(&the_index, tree);
 	}
 
@@ -311,7 +311,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		struct tree *tree;
 		if (get_sha1_treeish(rev, oid.hash))
 			die(_("Failed to resolve '%s' as a valid tree."), rev);
-		tree = parse_tree_indirect(oid.hash);
+		tree = parse_tree_indirect(&oid);
 		if (!tree)
 			die(_("Could not parse object '%s'."), rev);
 		oidcpy(&oid, &tree->object.oid);
diff --git a/diff-lib.c b/diff-lib.c
index ee9df0f84..2982bf055 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -486,7 +486,7 @@ static int diff_cache(struct rev_info *revs,
 	struct tree_desc t;
 	struct unpack_trees_options opts;
 
-	tree = parse_tree_indirect(tree_oid->hash);
+	tree = parse_tree_indirect(tree_oid);
 	if (!tree)
 		return error("bad tree object %s",
 			     tree_name ? tree_name : oid_to_hex(tree_oid));
diff --git a/merge.c b/merge.c
index b0cffe16f..1d441ad94 100644
--- a/merge.c
+++ b/merge.c
@@ -79,10 +79,10 @@ int checkout_fast_forward(const struct object_id *head,
 	opts.fn = twoway_merge;
 	setup_unpack_trees_porcelain(&opts, "merge");
 
-	trees[nr_trees] = parse_tree_indirect(head->hash);
+	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] = parse_tree_indirect(remote->hash);
+	trees[nr_trees] = parse_tree_indirect(remote);
 	if (!trees[nr_trees++])
 		return -1;
 	for (i = 0; i < nr_trees; i++) {
diff --git a/sequencer.c b/sequencer.c
index ed48c4c29..a2aa77f46 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -446,7 +446,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (is_rebase_i(opts))
 		o.buffer_output = 2;
 
-	head_tree = parse_tree_indirect(head->hash);
+	head_tree = parse_tree_indirect(head);
 	next_tree = next ? next->tree : empty_tree();
 	base_tree = base ? base->tree : empty_tree();
 
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index e93950286..356d8edef 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -12,10 +12,10 @@ int cmd_main(int ac, const char **av)
 		die("cannot parse %s as an object name", av[1]);
 	if (get_oid(av[2], &hash2))
 		die("cannot parse %s as an object name", av[2]);
-	one = parse_tree_indirect(hash1.hash);
+	one = parse_tree_indirect(&hash1);
 	if (!one)
 		die("not a tree-ish %s", av[1]);
-	two = parse_tree_indirect(hash2.hash);
+	two = parse_tree_indirect(&hash2);
 	if (!two)
 		die("not a tree-ish %s", av[2]);
 
diff --git a/tree.c b/tree.c
index 28ce930b9..9adcd8bd4 100644
--- a/tree.c
+++ b/tree.c
@@ -232,9 +232,9 @@ void free_tree_buffer(struct tree *tree)
 	tree->object.parsed = 0;
 }
 
-struct tree *parse_tree_indirect(const unsigned char *sha1)
+struct tree *parse_tree_indirect(const struct object_id *oid)
 {
-	struct object *obj = parse_object(sha1);
+	struct object *obj = parse_object(oid->hash);
 	do {
 		if (!obj)
 			return NULL;
diff --git a/tree.h b/tree.h
index 2b2c8dbbe..0d4734b94 100644
--- a/tree.h
+++ b/tree.h
@@ -24,7 +24,7 @@ static inline int parse_tree(struct tree *tree)
 void free_tree_buffer(struct tree *tree);
 
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
-struct tree *parse_tree_indirect(const unsigned char *sha1);
+struct tree *parse_tree_indirect(const struct object_id *oid);
 
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const unsigned char *, struct strbuf *, const char *, unsigned int, int, void *);
