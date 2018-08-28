Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D137C1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH2BQW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:16:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:59526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727438AbeH2BQW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:16:22 -0400
Received: (qmail 29809 invoked by uid 109); 28 Aug 2018 21:22:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 21:22:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5829 invoked by uid 111); 28 Aug 2018 21:22:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 17:22:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 17:22:48 -0400
Date:   Tue, 28 Aug 2018 17:22:48 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 5/9] convert "oidcmp() != 0" to "!oideq()"
Message-ID: <20180828212248.GE11036@sigill.intra.peff.net>
References: <20180828212126.GA7039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the flip side of the previous two patches: checking
for a non-zero oidcmp() can be more strictly expressed as
inequality. Like those patches, we write "!= 0" in the
coccinelle transformation, which covers by isomorphism the
more common:

  if (oidcmp(E1, E2))

As with the previous two patches, this patch can be achieved
almost entirely by running "make coccicheck"; the only
differences are manual line-wrap fixes to match the original
code.

There is one thing to note for anybody replicating this,
though: coccinelle 1.0.4 seems to miss the case in
builtin/tag.c, even though it's basically the same as all
the others. Running with 1.0.7 does catch this, so
presumably it's just a coccinelle bug that was fixed in the
interim.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c                           | 2 +-
 blame.c                            | 4 ++--
 builtin/fmt-merge-msg.c            | 4 ++--
 builtin/merge.c                    | 2 +-
 builtin/pull.c                     | 2 +-
 builtin/rm.c                       | 2 +-
 builtin/show-branch.c              | 4 ++--
 builtin/tag.c                      | 2 +-
 bundle.c                           | 2 +-
 commit-graph.c                     | 6 +++---
 commit.c                           | 2 +-
 contrib/coccinelle/object_id.cocci | 6 ++++++
 diff-lib.c                         | 2 +-
 diff.c                             | 6 +++---
 diffcore-rename.c                  | 2 +-
 dir.c                              | 6 +++---
 fast-import.c                      | 4 ++--
 fetch-pack.c                       | 2 +-
 match-trees.c                      | 2 +-
 notes.c                            | 2 +-
 read-cache.c                       | 2 +-
 refs.c                             | 8 ++++----
 refs/files-backend.c               | 2 +-
 refs/packed-backend.c              | 2 +-
 refs/ref-cache.c                   | 2 +-
 remote.c                           | 2 +-
 sequencer.c                        | 8 ++++----
 sha1-file.c                        | 6 +++---
 submodule-config.c                 | 4 ++--
 t/helper/test-dump-cache-tree.c    | 2 +-
 tree-diff.c                        | 2 +-
 31 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/bisect.c b/bisect.c
index 41c56a665e..7c1d8f1a6d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -595,7 +595,7 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
-			if (oidcmp(&cur->item->object.oid, current_bad_oid))
+			if (!oideq(&cur->item->object.oid, current_bad_oid))
 				return cur;
 			if (previous)
 				return previous;
diff --git a/blame.c b/blame.c
index c47d7050d9..d5f7b7237c 100644
--- a/blame.c
+++ b/blame.c
@@ -1832,7 +1832,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 
 		sb->revs->children.name = "children";
 		while (c->parents &&
-		       oidcmp(&c->object.oid, &sb->final->object.oid)) {
+		       !oideq(&c->object.oid, &sb->final->object.oid)) {
 			struct commit_list *l = xcalloc(1, sizeof(*l));
 
 			l->item = c;
@@ -1842,7 +1842,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 			c = c->parents->item;
 		}
 
-		if (oidcmp(&c->object.oid, &sb->final->object.oid))
+		if (!oideq(&c->object.oid, &sb->final->object.oid))
 			die(_("--reverse --first-parent together require range along first-parent chain"));
 	}
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4c82c234cb..268f0c20ca 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -78,9 +78,9 @@ static struct merge_parent *find_merge_parent(struct merge_parents *table,
 {
 	int i;
 	for (i = 0; i < table->nr; i++) {
-		if (given && oidcmp(&table->item[i].given, given))
+		if (given && !oideq(&table->item[i].given, given))
 			continue;
-		if (commit && oidcmp(&table->item[i].commit, commit))
+		if (commit && !oideq(&table->item[i].commit, commit))
 			continue;
 		return &table->item[i];
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 57abff999b..8d85d31a61 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1521,7 +1521,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * HEAD^^" would be missed.
 			 */
 			common_one = get_merge_bases(head_commit, j->item);
-			if (oidcmp(&common_one->item->object.oid, &j->item->object.oid)) {
+			if (!oideq(&common_one->item->object.oid, &j->item->object.oid)) {
 				up_to_date = 0;
 				break;
 			}
diff --git a/builtin/pull.c b/builtin/pull.c
index a720f58a96..09b02695de 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -902,7 +902,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		oidclr(&curr_head);
 
 	if (!is_null_oid(&orig_head) && !is_null_oid(&curr_head) &&
-			oidcmp(&orig_head, &curr_head)) {
+			!oideq(&orig_head, &curr_head)) {
 		/*
 		 * The fetch involved updating the current branch.
 		 *
diff --git a/builtin/rm.c b/builtin/rm.c
index 2cbe89e0ae..17086d3d97 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -180,7 +180,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		if (no_head
 		     || get_tree_entry(head, name, &oid, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
-		     || oidcmp(&ce->oid, &oid))
+		     || !oideq(&ce->oid, &oid))
 			staged_changes = 1;
 
 		/*
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 363cf8509a..5f9432861b 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -412,7 +412,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_oid(refname + ofs, &tmp) || oidcmp(&tmp, oid))
+	if (get_oid(refname + ofs, &tmp) || !oideq(&tmp, oid))
 		ofs = 5;
 	return append_ref(refname + ofs, oid, 0);
 }
@@ -427,7 +427,7 @@ static int append_remote_ref(const char *refname, const struct object_id *oid,
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_oid(refname + ofs, &tmp) || oidcmp(&tmp, oid))
+	if (get_oid(refname + ofs, &tmp) || !oideq(&tmp, oid))
 		ofs = 5;
 	return append_ref(refname + ofs, oid, 0);
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 9a19ffb49f..f623632186 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -559,7 +559,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
-	if (force && !is_null_oid(&prev) && oidcmp(&prev, &object))
+	if (force && !is_null_oid(&prev) && !oideq(&prev, &object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag,
 		       find_unique_abbrev(&prev, DEFAULT_ABBREV));
 
diff --git a/bundle.c b/bundle.c
index 24cbe40986..14f2cfc248 100644
--- a/bundle.c
+++ b/bundle.c
@@ -369,7 +369,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		 * commit that is referenced by the tag, and not the tag
 		 * itself.
 		 */
-		if (oidcmp(&oid, &e->item->oid)) {
+		if (!oideq(&oid, &e->item->oid)) {
 			/*
 			 * Is this the positive end of a range expressed
 			 * in terms of a tag (e.g. v2.0 from the range
diff --git a/commit-graph.c b/commit-graph.c
index 050c516b0d..7aed9f5371 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -765,7 +765,7 @@ void write_commit_graph(const char *obj_dir,
 
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
-		if (oidcmp(&oids.list[i-1], &oids.list[i]))
+		if (!oideq(&oids.list[i - 1], &oids.list[i]))
 			count_distinct++;
 	}
 
@@ -960,7 +960,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 			continue;
 		}
 
-		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+		if (!oideq(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
 			   get_commit_tree_oid(odb_commit)))
 			graph_report("root tree OID for commit %s in commit-graph is %s != %s",
 				     oid_to_hex(&cur_oid),
@@ -977,7 +977,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				break;
 			}
 
-			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
+			if (!oideq(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
 				graph_report("commit-graph parent for %s is %s != %s",
 					     oid_to_hex(&cur_oid),
 					     oid_to_hex(&graph_parents->item->object.oid),
diff --git a/commit.c b/commit.c
index 1a6e632185..1b94a8c96f 100644
--- a/commit.c
+++ b/commit.c
@@ -46,7 +46,7 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	struct commit *c = lookup_commit_reference(the_repository, oid);
 	if (!c)
 		die(_("could not parse %s"), ref_name);
-	if (oidcmp(oid, &c->object.oid)) {
+	if (!oideq(oid, &c->object.oid)) {
 		warning(_("%s %s is not a commit!"),
 			ref_name, oid_to_hex(oid));
 	}
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index d90ba8a040..4e1f1a7431 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -123,3 +123,9 @@ expression E1, E2;
 - hashcmp(E1, E2) == 0
 + hasheq(E1, E2)
   ...>}
+
+@@
+expression E1, E2;
+@@
+- oidcmp(E1, E2) != 0
++ !oideq(E1, E2)
diff --git a/diff-lib.c b/diff-lib.c
index c1f5a52654..8866b1d60c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -342,7 +342,7 @@ static int show_modified(struct rev_info *revs,
 	}
 
 	if (revs->combine_merges && !cached &&
-	    (oidcmp(oid, &old_entry->oid) || oidcmp(&old_entry->oid, &new_entry->oid))) {
+	    (!oideq(oid, &old_entry->oid) || !oideq(&old_entry->oid, &new_entry->oid))) {
 		struct combine_diff_path *p;
 		int pathlen = ce_namelen(new_entry);
 
diff --git a/diff.c b/diff.c
index 5cada68267..5d3219b600 100644
--- a/diff.c
+++ b/diff.c
@@ -3765,7 +3765,7 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 	 * This is not the sha1 we are looking for, or
 	 * unreusable because it is not a regular file.
 	 */
-	if (oidcmp(oid, &ce->oid) || !S_ISREG(ce->ce_mode))
+	if (!oideq(oid, &ce->oid) || !S_ISREG(ce->ce_mode))
 		return 0;
 
 	/*
@@ -4170,7 +4170,7 @@ static void fill_metainfo(struct strbuf *msg,
 	default:
 		*must_show_header = 0;
 	}
-	if (one && two && oidcmp(&one->oid, &two->oid)) {
+	if (one && two && !oideq(&one->oid, &two->oid)) {
 		const unsigned hexsz = the_hash_algo->hexsz;
 		int abbrev = o->flags.full_index ? hexsz : DEFAULT_ABBREV;
 
@@ -5457,7 +5457,7 @@ static void diff_resolve_rename_copy(void)
 			else
 				p->status = DIFF_STATUS_RENAMED;
 		}
-		else if (oidcmp(&p->one->oid, &p->two->oid) ||
+		else if (!oideq(&p->one->oid, &p->two->oid) ||
 			 p->one->mode != p->two->mode ||
 			 p->one->dirty_submodule ||
 			 p->two->dirty_submodule ||
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d775183c2f..daddd9b28a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -286,7 +286,7 @@ static int find_identical_files(struct hashmap *srcs,
 		struct diff_filespec *source = p->filespec;
 
 		/* False hash collision? */
-		if (oidcmp(&source->oid, &target->oid))
+		if (!oideq(&source->oid, &target->oid))
 			continue;
 		/* Non-regular files? If so, the modes must match! */
 		if (!S_ISREG(source->mode) || !S_ISREG(target->mode)) {
diff --git a/dir.c b/dir.c
index aceb0d4869..8ee9fe81b4 100644
--- a/dir.c
+++ b/dir.c
@@ -1282,7 +1282,7 @@ static void prep_exclude(struct dir_struct *dir,
 		 * order, though, if you do that.
 		 */
 		if (untracked &&
-		    oidcmp(&oid_stat.oid, &untracked->exclude_oid)) {
+		    !oideq(&oid_stat.oid, &untracked->exclude_oid)) {
 			invalidate_gitignore(dir->untracked, untracked);
 			oidcpy(&untracked->exclude_oid, &oid_stat.oid);
 		}
@@ -2248,12 +2248,12 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
-	if (oidcmp(&dir->ss_info_exclude.oid,
+	if (!oideq(&dir->ss_info_exclude.oid,
 		   &dir->untracked->ss_info_exclude.oid)) {
 		invalidate_gitignore(dir->untracked, root);
 		dir->untracked->ss_info_exclude = dir->ss_info_exclude;
 	}
-	if (oidcmp(&dir->ss_excludes_file.oid,
+	if (!oideq(&dir->ss_excludes_file.oid,
 		   &dir->untracked->ss_excludes_file.oid)) {
 		invalidate_gitignore(dir->untracked, root);
 		dir->untracked->ss_excludes_file = dir->ss_excludes_file;
diff --git a/fast-import.c b/fast-import.c
index a731088f96..67a53b79cb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2649,7 +2649,7 @@ static int parse_from(struct branch *b)
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
-		if (oidcmp(&b->oid, &oe->idx.oid)) {
+		if (!oideq(&b->oid, &oe->idx.oid)) {
 			oidcpy(&b->oid, &oe->idx.oid);
 			if (oe->pack_id != MAX_PACK_ID) {
 				unsigned long size;
@@ -2667,7 +2667,7 @@ static int parse_from(struct branch *b)
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
 
-	if (b->branch_tree.tree && oidcmp(&oid, &b->branch_tree.versions[1].oid)) {
+	if (b->branch_tree.tree && !oideq(&oid, &b->branch_tree.versions[1].oid)) {
 		release_tree_content_recursive(b->branch_tree.tree);
 		b->branch_tree.tree = NULL;
 	}
diff --git a/fetch-pack.c b/fetch-pack.c
index 88a078e9be..75047a4b2a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -599,7 +599,7 @@ static void filter_refs(struct fetch_pack_args *args,
 			continue;
 		if (parse_oid_hex(ref->name, &oid, &p) ||
 		    *p != '\0' ||
-		    oidcmp(&oid, &ref->old_oid))
+		    !oideq(&oid, &ref->old_oid))
 			continue;
 
 		if ((allow_unadvertised_object_request &
diff --git a/match-trees.c b/match-trees.c
index 37653308d3..2b6d31ef9d 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -106,7 +106,7 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 			update_tree_entry(&two);
 		} else {
 			/* path appears in both */
-			if (oidcmp(one.entry.oid, two.entry.oid)) {
+			if (!oideq(one.entry.oid, two.entry.oid)) {
 				/* they are different */
 				score += score_differs(one.entry.mode,
 						       two.entry.mode,
diff --git a/notes.c b/notes.c
index 33d16c1ec3..25cdce28b7 100644
--- a/notes.c
+++ b/notes.c
@@ -206,7 +206,7 @@ static void note_tree_remove(struct notes_tree *t,
 	if (GET_PTR_TYPE(*p) != PTR_TYPE_NOTE)
 		return; /* type mismatch, nothing to remove */
 	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-	if (oidcmp(&l->key_oid, &entry->key_oid))
+	if (!oideq(&l->key_oid, &entry->key_oid))
 		return; /* key mismatch, nothing to remove */
 
 	/* we have found a matching entry */
diff --git a/read-cache.c b/read-cache.c
index eb4919e77f..88bb80326b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2029,7 +2029,7 @@ int read_index_from(struct index_state *istate, const char *path,
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
-	if (oidcmp(&split_index->base_oid, &split_index->base->oid))
+	if (!oideq(&split_index->base_oid, &split_index->base->oid))
 		die("broken index, expect %s in %s, got %s",
 		    base_oid_hex, base_path,
 		    oid_to_hex(&split_index->base->oid));
diff --git a/refs.c b/refs.c
index de81c7be7c..a7a75b4cc0 100644
--- a/refs.c
+++ b/refs.c
@@ -702,7 +702,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 				    pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
-		} else if (oidcmp(&actual_old_oid, old_oid)) {
+		} else if (!oideq(&actual_old_oid, old_oid)) {
 			strbuf_addf(err, _("unexpected object ID when writing '%s'"),
 				    pseudoref);
 			rollback_lock_file(&lock);
@@ -744,7 +744,7 @@ static int delete_pseudoref(const char *pseudoref, const struct object_id *old_o
 		}
 		if (read_ref(pseudoref, &actual_old_oid))
 			die(_("could not read ref '%s'"), pseudoref);
-		if (oidcmp(&actual_old_oid, old_oid)) {
+		if (!oideq(&actual_old_oid, old_oid)) {
 			error(_("unexpected object ID when deleting '%s'"),
 			      pseudoref);
 			rollback_lock_file(&lock);
@@ -875,13 +875,13 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		 */
 		if (!is_null_oid(&cb->ooid)) {
 			oidcpy(cb->oid, noid);
-			if (oidcmp(&cb->ooid, noid))
+			if (!oideq(&cb->ooid, noid))
 				warning(_("log for ref %s has gap after %s"),
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
 			oidcpy(cb->oid, noid);
-		else if (oidcmp(noid, cb->oid))
+		else if (!oideq(noid, cb->oid))
 			warning(_("log for ref %s unexpectedly ended on %s"),
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa45f5317f..16ef9325e0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -841,7 +841,7 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 			return 0;
 		}
 	}
-	if (old_oid && oidcmp(&lock->old_oid, old_oid)) {
+	if (old_oid && !oideq(&lock->old_oid, old_oid)) {
 		strbuf_addf(err, "ref '%s' is at %s but expected %s",
 			    lock->ref_name,
 			    oid_to_hex(&lock->old_oid),
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index d447a731da..74e2996e93 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1160,7 +1160,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 						    "reference already exists",
 						    update->refname);
 					goto error;
-				} else if (oidcmp(&update->old_oid, iter->oid)) {
+				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
 						    "is at %s but expected %s",
 						    update->refname,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 9b110c8494..b7052f72e2 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -272,7 +272,7 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 		/* This is impossible by construction */
 		die("Reference directory conflict: %s", ref1->name);
 
-	if (oidcmp(&ref1->u.value.oid, &ref2->u.value.oid))
+	if (!oideq(&ref1->u.value.oid, &ref2->u.value.oid))
 		die("Duplicated ref, and SHA1s don't match: %s", ref1->name);
 
 	warning("Duplicated ref: %s", ref1->name);
diff --git a/remote.c b/remote.c
index 6f1ee9d640..e23b7675c8 100644
--- a/remote.c
+++ b/remote.c
@@ -1403,7 +1403,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 * branch.
 		 */
 		if (ref->expect_old_sha1) {
-			if (oidcmp(&ref->old_oid, &ref->old_oid_expect))
+			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
 			else
 				/* If the ref isn't stale then force the update. */
diff --git a/sequencer.c b/sequencer.c
index 5f823c9ec7..b14e5dc13c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1188,7 +1188,7 @@ static int parse_head(struct commit **head)
 		current_head = lookup_commit_reference(the_repository, &oid);
 		if (!current_head)
 			return error(_("could not parse HEAD"));
-		if (oidcmp(&oid, &current_head->object.oid)) {
+		if (!oideq(&oid, &current_head->object.oid)) {
 			warning(_("HEAD %s is not a commit!"),
 				oid_to_hex(&oid));
 		}
@@ -3034,7 +3034,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		struct commit_list *p = commit->parents->next;
 
 		for (j = to_merge; j && p; j = j->next, p = p->next)
-			if (oidcmp(&j->item->object.oid,
+			if (!oideq(&j->item->object.oid,
 				   &p->item->object.oid)) {
 				can_fast_forward = 0;
 				break;
@@ -3566,7 +3566,7 @@ static int commit_staged_changes(struct replay_opts *opts,
 		if (get_oid_hex(rev.buf, &to_amend))
 			return error(_("invalid contents: '%s'"),
 				rebase_path_amend());
-		if (!is_clean && oidcmp(&head, &to_amend))
+		if (!is_clean && !oideq(&head, &to_amend))
 			return error(_("\nYou have uncommitted changes in your "
 				       "working tree. Please, commit them\n"
 				       "first and then run 'git rebase "
@@ -4545,7 +4545,7 @@ int skip_unnecessary_picks(void)
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (oidcmp(parent_oid, oid))
+		if (!oideq(parent_oid, oid))
 			break;
 		oid = &item->commit->object.oid;
 	}
diff --git a/sha1-file.c b/sha1-file.c
index 71f49ee56d..cc8a196349 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -825,7 +825,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 
 	if (map) {
 		hash_object_file(map, size, type, &real_oid);
-		return oidcmp(oid, &real_oid) ? -1 : 0;
+		return !oideq(oid, &real_oid) ? -1 : 0;
 	}
 
 	st = open_istream(oid, &obj_type, &size, NULL);
@@ -852,7 +852,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 	}
 	the_hash_algo->final_fn(real_oid.hash, &c);
 	close_istream(st);
-	return oidcmp(oid, &real_oid) ? -1 : 0;
+	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -1671,7 +1671,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_fn(parano_oid.hash, &c);
-	if (oidcmp(oid, &parano_oid) != 0)
+	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
diff --git a/submodule-config.c b/submodule-config.c
index fc2c41b947..e04ba756d9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -45,7 +45,7 @@ static int config_path_cmp(const void *unused_cmp_data,
 	const struct submodule_entry *b = entry_or_key;
 
 	return strcmp(a->config->path, b->config->path) ||
-	       oidcmp(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
+	       !oideq(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
 }
 
 static int config_name_cmp(const void *unused_cmp_data,
@@ -57,7 +57,7 @@ static int config_name_cmp(const void *unused_cmp_data,
 	const struct submodule_entry *b = entry_or_key;
 
 	return strcmp(a->config->name, b->config->name) ||
-	       oidcmp(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
+	       !oideq(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
 }
 
 static struct submodule_cache *submodule_cache_alloc(void)
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 98a4891f1d..6a3f88f5f5 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -33,7 +33,7 @@ static int dump_cache_tree(struct cache_tree *it,
 	}
 	else {
 		dump_one(it, pfx, "");
-		if (oidcmp(&it->oid, &ref->oid) ||
+		if (!oideq(&it->oid, &ref->oid) ||
 		    ref->entry_count != it->entry_count ||
 		    ref->subtree_nr != it->subtree_nr) {
 			/* claims to be valid but is lying */
diff --git a/tree-diff.c b/tree-diff.c
index 553bc0e63a..425668e1e0 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -491,7 +491,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 						continue;
 
 					/* diff(t,pi) != ø */
-					if (oidcmp(t.entry.oid, tp[i].entry.oid) ||
+					if (!oideq(t.entry.oid, tp[i].entry.oid) ||
 					    (t.entry.mode != tp[i].entry.mode))
 						continue;
 
-- 
2.19.0.rc0.584.g84d5b2a847

