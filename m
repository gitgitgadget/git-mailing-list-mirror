Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F4C43461
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2265611CA
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhDJPWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234839AbhDJPWv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E5796078B;
        Sat, 10 Apr 2021 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068155;
        bh=JY3GQKtefUZpIj8TN8+22r4QUOJu75Ra03UVyrHd/AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LqMCi9rlH/W0dY/iASTSJcbSeQdukCp9n1xULaViP4v5KCSPGLFwFnZb2HJN6VnJT
         /hpa1ksKaPYCFRV3MkjjbmLy8g2jKZVrkYxgFXgqYWVrSbXPgbeaKAbTIekvOyWL9m
         ea9lcwqk6ZHd+bX+X2eVz91tp+ZUZdRbM37CWoPH2aJhFOwooHyjwOqoovxXqEGBSQ
         Lo84Wtj7xzv8NgFLT12ZAIYvTQjSlMT3A3NmLiwg8bF4Am+DXxBMHzBKvJ/QSAt3e6
         VwXtUVOl3jsU2YN/N3nHULXAB3rA1WYbYm3E0grk0LPcqv3uTldK87sSCvC3t+cVyH
         w3JFrY3FWKV/pQKK7y1TI3h2R7KfAb4kGkM1rVuw94H9ZiBR8z+3h0eao0K7NTmIJg
         U1ljX2QKGbhNUdgwzoY+bagFJ33JaY32DXJ+u0KFeopP8zHk/f0xXgNHp/VljJm9zS
         SDPReGqyqpdbWoZQgfSr2LTAzTNAghtB4v6Ae2D52o8sJkUdGDx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 10/15] hash: provide per-algorithm null OIDs
Date:   Sat, 10 Apr 2021 15:21:35 +0000
Message-Id: <20210410152140.3525040-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Up until recently, object IDs did not have an algorithm member, only a
hash.  Consequently, it was possible to share one null (all-zeros)
object ID among all hash algorithms.  Now that we're going to be
handling objects from multiple hash algorithms, it's important to make
sure that all object IDs have a correct algorithm field.

Introduce a per-algorithm null OID, and add it to struct hash_algo.
Introduce a wrapper function as well, and use it everywhere we used to
use the null_oid constant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c                                    |  4 ++-
 blame.c                                      |  2 +-
 branch.c                                     |  2 +-
 builtin/checkout.c                           |  6 ++--
 builtin/clone.c                              |  2 +-
 builtin/describe.c                           |  2 +-
 builtin/diff.c                               |  2 +-
 builtin/fast-export.c                        | 10 +++----
 builtin/grep.c                               |  2 +-
 builtin/ls-files.c                           |  2 +-
 builtin/rebase.c                             |  4 +--
 builtin/receive-pack.c                       |  2 +-
 builtin/submodule--helper.c                  | 29 ++++++++++----------
 builtin/unpack-objects.c                     |  3 +-
 builtin/worktree.c                           |  4 +--
 combine-diff.c                               |  2 +-
 connect.c                                    |  2 +-
 diff-lib.c                                   |  6 ++--
 diff-no-index.c                              |  2 +-
 diff.c                                       |  4 +--
 dir.c                                        |  2 +-
 grep.c                                       |  2 +-
 hash.h                                       |  7 +++--
 log-tree.c                                   |  2 +-
 merge-ort.c                                  | 20 +++++++-------
 merge-recursive.c                            | 10 +++----
 notes-merge.c                                |  2 +-
 notes.c                                      |  2 +-
 object-file.c                                | 15 +++++++++-
 parse-options-cb.c                           |  2 +-
 range-diff.c                                 |  2 +-
 refs.c                                       |  4 +--
 refs/debug.c                                 |  2 +-
 refs/files-backend.c                         |  2 +-
 reset.c                                      |  2 +-
 sequencer.c                                  |  4 +--
 submodule-config.c                           |  2 +-
 submodule.c                                  | 26 ++++++++++--------
 t/helper/test-submodule-nested-repo-config.c |  2 +-
 tree-diff.c                                  |  4 +--
 wt-status.c                                  |  4 +--
 xdiff-interface.c                            |  2 +-
 42 files changed, 117 insertions(+), 95 deletions(-)

diff --git a/archive.c b/archive.c
index 6cfb9e42d6..ff2bb54f62 100644
--- a/archive.c
+++ b/archive.c
@@ -275,9 +275,11 @@ int write_archive_entries(struct archiver_args *args,
 	int err;
 	struct strbuf path_in_archive = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
-	struct object_id fake_oid = null_oid;
+	struct object_id fake_oid;
 	int i;
 
+	oidcpy(&fake_oid, null_oid());
+
 	if (args->baselen > 0 && args->base[args->baselen - 1] == '/') {
 		size_t len = args->baselen;
 
diff --git a/blame.c b/blame.c
index 5018bb8fb2..206c295660 100644
--- a/blame.c
+++ b/blame.c
@@ -242,7 +242,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (opt->flags.allow_textconv &&
-			    textconv_object(r, read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
+			    textconv_object(r, read_from, mode, null_oid(), 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
diff --git a/branch.c b/branch.c
index 9c9dae1eae..8db10f8496 100644
--- a/branch.c
+++ b/branch.c
@@ -322,7 +322,7 @@ void create_branch(struct repository *r,
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf,
-					   &oid, forcing ? NULL : &null_oid,
+					   &oid, forcing ? NULL : null_oid(),
 					   0, msg, &err) ||
 		    ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4c696ef480..8a12b92c5f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -106,8 +106,8 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 			      int changed)
 {
 	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
+			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
+			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
 			   changed ? "1" : "0", NULL);
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
@@ -638,7 +638,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	init_checkout_metadata(&opts.meta, info->refname,
-			       info->commit ? &info->commit->object.oid : &null_oid,
+			       info->commit ? &info->commit->object.oid : null_oid(),
 			       NULL);
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
diff --git a/builtin/clone.c b/builtin/clone.c
index f6b0c48bed..eeb74c0217 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -820,7 +820,7 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
+	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
diff --git a/builtin/describe.c b/builtin/describe.c
index 40482d8e9f..e912ba50d7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -502,7 +502,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 {
 	struct rev_info revs;
 	struct strvec args = STRVEC_INIT;
-	struct process_commit_data pcd = { null_oid, oid, dst, &revs};
+	struct process_commit_data pcd = { *null_oid(), oid, dst, &revs};
 
 	strvec_pushl(&args, "internal: The first arg is not parsed",
 		     "--objects", "--in-commit-order", "--reverse", "HEAD",
diff --git a/builtin/diff.c b/builtin/diff.c
index 617b9a4101..2d87c37a17 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -98,7 +98,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 
 	stuff_change(&revs->diffopt,
 		     blob[0]->mode, canon_mode(st.st_mode),
-		     &blob[0]->item->oid, &null_oid,
+		     &blob[0]->item->oid, null_oid(),
 		     1, 0,
 		     blob[0]->path ? blob[0]->path : path,
 		     path);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85a76e0ef8..3c20f164f0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -870,7 +870,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				p = rewrite_commit((struct commit *)tagged);
 				if (!p) {
 					printf("reset %s\nfrom %s\n\n",
-					       name, oid_to_hex(&null_oid));
+					       name, oid_to_hex(null_oid()));
 					free(buf);
 					return;
 				}
@@ -884,7 +884,7 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (tagged->type == OBJ_TAG) {
 		printf("reset %s\nfrom %s\n\n",
-		       name, oid_to_hex(&null_oid));
+		       name, oid_to_hex(null_oid()));
 	}
 	skip_prefix(name, "refs/tags/", &name);
 	printf("tag %s\n", name);
@@ -1016,7 +1016,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				 * it.
 				 */
 				printf("reset %s\nfrom %s\n\n",
-				       name, oid_to_hex(&null_oid));
+				       name, oid_to_hex(null_oid()));
 				continue;
 			}
 
@@ -1035,7 +1035,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				if (!reference_excluded_commits) {
 					/* delete the ref */
 					printf("reset %s\nfrom %s\n\n",
-					       name, oid_to_hex(&null_oid));
+					       name, oid_to_hex(null_oid()));
 					continue;
 				}
 				/* set ref to commit using oid, not mark */
@@ -1146,7 +1146,7 @@ static void handle_deletes(void)
 			continue;
 
 		printf("reset %s\nfrom %s\n\n",
-				refspec->dst, oid_to_hex(&null_oid));
+				refspec->dst, oid_to_hex(null_oid()));
 	}
 }
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 5de725f904..e0e326004e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -421,7 +421,7 @@ static int grep_submodule(struct grep_opt *opt,
 	struct grep_opt subopt;
 	int hit;
 
-	sub = submodule_from_path(superproject, &null_oid, path);
+	sub = submodule_from_path(superproject, null_oid(), path);
 
 	if (!is_submodule_active(superproject, path))
 		return 0;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01..c589eb7f89 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -210,7 +210,7 @@ static void show_submodule(struct repository *superproject,
 {
 	struct repository subrepo;
 	const struct submodule *sub = submodule_from_path(superproject,
-							  &null_oid, path);
+							  null_oid(), path);
 
 	if (repo_submodule_init(&subrepo, superproject, sub))
 		return;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 783b526f6e..c9206b40ea 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -485,7 +485,7 @@ static const char * const builtin_rebase_interactive_usage[] = {
 int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options opts = REBASE_OPTIONS_INIT;
-	struct object_id squash_onto = null_oid;
+	struct object_id squash_onto = *null_oid();
 	enum action command = ACTION_NONE;
 	struct option options[] = {
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
@@ -1139,7 +1139,7 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 
 	merge_bases = get_merge_bases(onto, head);
 	if (!merge_bases || merge_bases->next) {
-		oidcpy(merge_base, &null_oid);
+		oidcpy(merge_base, null_oid());
 		goto done;
 	}
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6bc12c828a..a34742513a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -329,7 +329,7 @@ static void write_head_info(void)
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
 	if (!sent_capabilities)
-		show_ref("capabilities^{}", &null_oid);
+		show_ref("capabilities^{}", null_oid());
 
 	advertise_shallow_grafts(1);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d505a6329..d55f6262e9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -426,7 +426,8 @@ static int module_list(int argc, const char **argv, const char *prefix)
 		const struct cache_entry *ce = list.entries[i];
 
 		if (ce_stage(ce))
-			printf("%06o %s U\t", ce->ce_mode, oid_to_hex(&null_oid));
+			printf("%06o %s U\t", ce->ce_mode,
+			       oid_to_hex(null_oid()));
 		else
 			printf("%06o %s %d\t", ce->ce_mode,
 			       oid_to_hex(&ce->oid), ce_stage(ce));
@@ -466,7 +467,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 
 	displaypath = get_submodule_displaypath(path, info->prefix);
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -623,7 +624,7 @@ static void init_submodule(const char *path, const char *prefix,
 
 	displaypath = get_submodule_displaypath(path, prefix);
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -783,14 +784,14 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
 
-	if (!submodule_from_path(the_repository, &null_oid, path))
+	if (!submodule_from_path(the_repository, null_oid(), path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		      path);
 
 	displaypath = get_submodule_displaypath(path, prefix);
 
 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
-		print_status(flags, 'U', path, &null_oid, displaypath);
+		print_status(flags, 'U', path, null_oid(), displaypath);
 		goto cleanup;
 	}
 
@@ -916,7 +917,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(_("git submodule--helper name <path>"));
 
-	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
+	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -1040,7 +1041,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	char *errmsg = NULL;
 	int total_commits = -1;
 
-	if (!info->cached && oideq(&p->oid_dst, &null_oid)) {
+	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
 		if (S_ISGITLINK(p->mod_dst)) {
 			struct ref_store *refs = get_submodule_ref_store(p->sm_path);
 			if (refs)
@@ -1177,7 +1178,7 @@ static void prepare_submodule_summary(struct summary_cb *info,
 
 		if (info->for_status && p->status != 'A' &&
 		    (sub = submodule_from_path(the_repository,
-					       &null_oid, p->sm_path))) {
+					       null_oid(), p->sm_path))) {
 			char *config_key = NULL;
 			const char *value;
 			int ignore_all = 0;
@@ -1373,7 +1374,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (!is_submodule_active(the_repository, path))
 		return;
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
@@ -1525,7 +1526,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	struct strbuf sb_config = STRBUF_INIT;
 	char *sub_git_dir = xstrfmt("%s/.git", path);
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub || !sub->name)
 		goto cleanup;
@@ -1925,7 +1926,7 @@ static void determine_submodule_update_strategy(struct repository *r,
 						const char *update,
 						struct submodule_update_strategy *out)
 {
-	const struct submodule *sub = submodule_from_path(r, &null_oid, path);
+	const struct submodule *sub = submodule_from_path(r, null_oid(), path);
 	char *key;
 	const char *val;
 
@@ -2077,7 +2078,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
-	sub = submodule_from_path(the_repository, &null_oid, ce->name);
+	sub = submodule_from_path(the_repository, null_oid(), ce->name);
 
 	if (suc->recursive_prefix)
 		displaypath = relative_path(suc->recursive_prefix,
@@ -2395,7 +2396,7 @@ static const char *remote_submodule_branch(const char *path)
 	const char *branch = NULL;
 	char *key;
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 	if (!sub)
 		return NULL;
 
@@ -2533,7 +2534,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 
 	path = argv[1];
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 	if (!sub)
 		BUG("We could get the submodule handle before?");
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6ac90dc5f7..4a9466295b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -421,7 +421,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			 * has not been resolved yet.
 			 */
 			oidclr(&obj_list[nr].oid);
-			add_delta_to_list(nr, &null_oid, base_offset, delta_data, delta_size);
+			add_delta_to_list(nr, null_oid(), base_offset,
+					  delta_data, delta_size);
 			return;
 		}
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8771453493..f754978e47 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -331,7 +331,7 @@ static int add_worktree(const char *path, const char *refname,
 	 */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "%s", oid_to_hex(&null_oid));
+	write_file(sb.buf, "%s", oid_to_hex(null_oid()));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
@@ -394,7 +394,7 @@ static int add_worktree(const char *path, const char *refname,
 			cp.argv = NULL;
 			cp.trace2_hook_name = "post-checkout";
 			strvec_pushl(&cp.args, absolute_path(hook),
-				     oid_to_hex(&null_oid),
+				     oid_to_hex(null_oid()),
 				     oid_to_hex(&commit->object.oid),
 				     "1", NULL);
 			ret = run_command(&cp);
diff --git a/combine-diff.c b/combine-diff.c
index 06635f91bc..7d925ce9ce 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1068,7 +1068,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
-			fill_filespec(df, &null_oid, 0, st.st_mode);
+			fill_filespec(df, null_oid(), 0, st.st_mode);
 			result_size = fill_textconv(opt->repo, textconv, df, &result);
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
diff --git a/connect.c b/connect.c
index 40b5c15f81..70b13389ba 100644
--- a/connect.c
+++ b/connect.c
@@ -254,7 +254,7 @@ static int process_dummy_ref(const struct packet_reader *reader)
 		return 0;
 	name++;
 
-	return oideq(&null_oid, &oid) && !strcmp(name, "capabilities^{}");
+	return oideq(null_oid(), &oid) && !strcmp(name, "capabilities^{}");
 }
 
 static void check_no_capabilities(const char *line, int len)
diff --git a/diff-lib.c b/diff-lib.c
index e5a58c9259..c2ac9250fe 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -232,7 +232,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				   ce_intent_to_add(ce)) {
 				newmode = ce_mode_from_stat(ce, st.st_mode);
 				diff_addremove(&revs->diffopt, '+', newmode,
-					       &null_oid, 0, ce->name, 0);
+					       null_oid(), 0, ce->name, 0);
 				continue;
 			}
 
@@ -249,7 +249,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		}
 		oldmode = ce->ce_mode;
 		old_oid = &ce->oid;
-		new_oid = changed ? &null_oid : &ce->oid;
+		new_oid = changed ? null_oid() : &ce->oid;
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    old_oid, new_oid,
 			    !is_null_oid(old_oid),
@@ -307,7 +307,7 @@ static int get_stat_data(const struct index_state *istate,
 						    0, dirty_submodule);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
-			oid = &null_oid;
+			oid = null_oid();
 		}
 	}
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 7814eabfe0..308922e2b3 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -83,7 +83,7 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 	if (!name)
 		name = "/dev/null";
 	s = alloc_filespec(name);
-	fill_filespec(s, &null_oid, 0, mode);
+	fill_filespec(s, null_oid(), 0, mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
 	return s;
diff --git a/diff.c b/diff.c
index 97c62f47df..7c730fe644 100644
--- a/diff.c
+++ b/diff.c
@@ -4190,7 +4190,7 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 				die_errno("readlink(%s)", name);
 			prep_temp_blob(r->index, name, temp, sb.buf, sb.len,
 				       (one->oid_valid ?
-					&one->oid : &null_oid),
+					&one->oid : null_oid()),
 				       (one->oid_valid ?
 					one->mode : S_IFLNK));
 			strbuf_release(&sb);
@@ -4199,7 +4199,7 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 			/* we can borrow from the file in the work tree */
 			temp->name = name;
 			if (!one->oid_valid)
-				oid_to_hex_r(temp->hex, &null_oid);
+				oid_to_hex_r(temp->hex, null_oid());
 			else
 				oid_to_hex_r(temp->hex, &one->oid);
 			/* Even though we may sometimes borrow the
diff --git a/dir.c b/dir.c
index 813dd7ba53..037474337f 100644
--- a/dir.c
+++ b/dir.c
@@ -3556,7 +3556,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 			 */
 			i++;
 
-		sub = submodule_from_path(&subrepo, &null_oid, ce->name);
+		sub = submodule_from_path(&subrepo, null_oid(), ce->name);
 		if (!sub || !is_submodule_active(&subrepo, ce->name))
 			/* .gitmodules broken or inactive sub */
 			continue;
diff --git a/grep.c b/grep.c
index c5c348be55..8f91af1cb0 100644
--- a/grep.c
+++ b/grep.c
@@ -1494,7 +1494,7 @@ static int fill_textconv_grep(struct repository *r,
 		fill_filespec(df, gs->identifier, 1, 0100644);
 		break;
 	case GREP_SOURCE_FILE:
-		fill_filespec(df, &null_oid, 0, 0100644);
+		fill_filespec(df, null_oid(), 0, 0100644);
 		break;
 	default:
 		BUG("attempt to textconv something without a path?");
diff --git a/hash.h b/hash.h
index 3b114f053e..5fabf6e1ec 100644
--- a/hash.h
+++ b/hash.h
@@ -170,6 +170,9 @@ struct git_hash_algo {
 
 	/* The OID of the empty blob. */
 	const struct object_id *empty_blob;
+
+	/* The all-zeros OID. */
+	const struct object_id *null_oid;
 };
 extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
 
@@ -190,7 +193,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 
 #define the_hash_algo the_repository->hash_algo
 
-extern const struct object_id null_oid;
+const struct object_id *null_oid(void);
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
@@ -226,7 +229,7 @@ static inline int oideq(const struct object_id *oid1, const struct object_id *oi
 
 static inline int is_null_oid(const struct object_id *oid)
 {
-	return oideq(oid, &null_oid);
+	return oideq(oid, null_oid());
 }
 
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
diff --git a/log-tree.c b/log-tree.c
index f3178a66a9..7b823786c2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -419,7 +419,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 {
 	const char *extra_headers = opt->extra_headers;
 	const char *name = oid_to_hex(opt->zero_commit ?
-				      &null_oid : &commit->object.oid);
+				      null_oid() : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 
diff --git a/merge-ort.c b/merge-ort.c
index 5e118a85ee..3e552cfd21 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1291,7 +1291,7 @@ static int handle_content_merge(struct merge_options *opt,
 		two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
 
 		merge_status = merge_3way(opt, path,
-					  two_way ? &null_oid : &o->oid,
+					  two_way ? null_oid() : &o->oid,
 					  &a->oid, &b->oid,
 					  pathnames, extra_marker_size,
 					  &result_buf);
@@ -1313,7 +1313,7 @@ static int handle_content_merge(struct merge_options *opt,
 	} else if (S_ISGITLINK(a->mode)) {
 		int two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
 		clean = merge_submodule(opt, pathnames[0],
-					two_way ? &null_oid : &o->oid,
+					two_way ? null_oid() : &o->oid,
 					&a->oid, &b->oid, &result->oid);
 		if (opt->priv->call_depth && two_way && !clean) {
 			result->mode = o->mode;
@@ -2123,7 +2123,7 @@ static int process_renames(struct merge_options *opt,
 			if (type_changed) {
 				/* rename vs. typechange */
 				/* Mark the original as resolved by removal */
-				memcpy(&oldinfo->stages[0].oid, &null_oid,
+				memcpy(&oldinfo->stages[0].oid, null_oid(),
 				       sizeof(oldinfo->stages[0].oid));
 				oldinfo->stages[0].mode = 0;
 				oldinfo->filemask &= 0x06;
@@ -2762,7 +2762,7 @@ static void process_entry(struct merge_options *opt,
 			if (ci->filemask & (1 << i))
 				continue;
 			ci->stages[i].mode = 0;
-			oidcpy(&ci->stages[i].oid, &null_oid);
+			oidcpy(&ci->stages[i].oid, null_oid());
 		}
 	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
 		/*
@@ -2808,7 +2808,7 @@ static void process_entry(struct merge_options *opt,
 				continue;
 			/* zero out any entries related to directories */
 			new_ci->stages[i].mode = 0;
-			oidcpy(&new_ci->stages[i].oid, &null_oid);
+			oidcpy(&new_ci->stages[i].oid, null_oid());
 		}
 
 		/*
@@ -2909,11 +2909,11 @@ static void process_entry(struct merge_options *opt,
 			new_ci->merged.result.mode = ci->stages[2].mode;
 			oidcpy(&new_ci->merged.result.oid, &ci->stages[2].oid);
 			new_ci->stages[1].mode = 0;
-			oidcpy(&new_ci->stages[1].oid, &null_oid);
+			oidcpy(&new_ci->stages[1].oid, null_oid());
 			new_ci->filemask = 5;
 			if ((S_IFMT & b_mode) != (S_IFMT & o_mode)) {
 				new_ci->stages[0].mode = 0;
-				oidcpy(&new_ci->stages[0].oid, &null_oid);
+				oidcpy(&new_ci->stages[0].oid, null_oid());
 				new_ci->filemask = 4;
 			}
 
@@ -2921,11 +2921,11 @@ static void process_entry(struct merge_options *opt,
 			ci->merged.result.mode = ci->stages[1].mode;
 			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
 			ci->stages[2].mode = 0;
-			oidcpy(&ci->stages[2].oid, &null_oid);
+			oidcpy(&ci->stages[2].oid, null_oid());
 			ci->filemask = 3;
 			if ((S_IFMT & a_mode) != (S_IFMT & o_mode)) {
 				ci->stages[0].mode = 0;
-				oidcpy(&ci->stages[0].oid, &null_oid);
+				oidcpy(&ci->stages[0].oid, null_oid());
 				ci->filemask = 2;
 			}
 
@@ -3042,7 +3042,7 @@ static void process_entry(struct merge_options *opt,
 		/* Deleted on both sides */
 		ci->merged.is_null = 1;
 		ci->merged.result.mode = 0;
-		oidcpy(&ci->merged.result.oid, &null_oid);
+		oidcpy(&ci->merged.result.oid, null_oid());
 		ci->merged.clean = !ci->path_conflict;
 	}
 
diff --git a/merge-recursive.c b/merge-recursive.c
index ed31f9496c..03f5c0769e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -486,7 +486,7 @@ static int get_tree_entry_if_blob(struct repository *r,
 
 	ret = get_tree_entry(r, tree, path, &dfs->oid, &dfs->mode);
 	if (S_ISDIR(dfs->mode)) {
-		oidcpy(&dfs->oid, &null_oid);
+		oidcpy(&dfs->oid, null_oid());
 		dfs->mode = 0;
 	}
 	return ret;
@@ -1604,7 +1604,7 @@ static int handle_file_collision(struct merge_options *opt,
 
 	/* Store things in diff_filespecs for functions that need it */
 	null.path = (char *)collide_path;
-	oidcpy(&null.oid, &null_oid);
+	oidcpy(&null.oid, null_oid());
 	null.mode = 0;
 
 	if (merge_mode_and_contents(opt, &null, a, b, collide_path,
@@ -2789,11 +2789,11 @@ static int process_renames(struct merge_options *opt,
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
-			if (oideq(&src_other.oid, &null_oid) &&
+			if (oideq(&src_other.oid, null_oid()) &&
 			    ren1->dir_rename_original_type == 'A') {
 				setup_rename_conflict_info(RENAME_VIA_DIR,
 							   opt, ren1, NULL);
-			} else if (oideq(&src_other.oid, &null_oid)) {
+			} else if (oideq(&src_other.oid, null_oid())) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   opt, ren1, NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
@@ -2812,7 +2812,7 @@ static int process_renames(struct merge_options *opt,
 						      1, /* update_cache */
 						      0  /* update_wd    */))
 					clean_merge = -1;
-			} else if (!oideq(&dst_other.oid, &null_oid)) {
+			} else if (!oideq(&dst_other.oid, null_oid())) {
 				/*
 				 * Probably not a clean merge, but it's
 				 * premature to set clean_merge to 0 here,
diff --git a/notes-merge.c b/notes-merge.c
index d2771fa3d4..53c587f750 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -600,7 +600,7 @@ int notes_merge(struct notes_merge_options *o,
 	/* Find merge bases */
 	bases = get_merge_bases(local, remote);
 	if (!bases) {
-		base_oid = &null_oid;
+		base_oid = null_oid();
 		base_tree_oid = the_hash_algo->empty_tree;
 		if (o->verbosity >= 4)
 			printf("No merge base found; doing history-less merge\n");
diff --git a/notes.c b/notes.c
index 1dfe9e2b9f..3f48a2aac3 100644
--- a/notes.c
+++ b/notes.c
@@ -1327,7 +1327,7 @@ int copy_note(struct notes_tree *t,
 	if (note)
 		return add_note(t, to_obj, note, combine_notes);
 	else if (existing_note)
-		return add_note(t, to_obj, &null_oid, combine_notes);
+		return add_note(t, to_obj, null_oid(), combine_notes);
 
 	return 0;
 }
diff --git a/object-file.c b/object-file.c
index 5f1fa05c4e..50bb5b6ca4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -55,7 +55,6 @@
 	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
 	"\x18\x13"
 
-const struct object_id null_oid;
 static const struct object_id empty_tree_oid = {
 	EMPTY_TREE_SHA1_BIN_LITERAL,
 	GIT_HASH_SHA1,
@@ -64,6 +63,9 @@ static const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL,
 	GIT_HASH_SHA1,
 };
+const struct object_id null_oid_sha1 = {
+	{0}, GIT_HASH_SHA1,
+};
 static const struct object_id empty_tree_oid_sha256 = {
 	EMPTY_TREE_SHA256_BIN_LITERAL,
 	GIT_HASH_SHA256,
@@ -72,6 +74,9 @@ static const struct object_id empty_blob_oid_sha256 = {
 	EMPTY_BLOB_SHA256_BIN_LITERAL,
 	GIT_HASH_SHA256,
 };
+static const struct object_id null_oid_sha256 = {
+	{0}, GIT_HASH_SHA256,
+};
 
 static void git_hash_sha1_init(git_hash_ctx *ctx)
 {
@@ -172,6 +177,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_unknown_final_oid,
 		NULL,
 		NULL,
+		NULL,
 	},
 	{
 		"sha1",
@@ -187,6 +193,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_sha1_final_oid,
 		&empty_tree_oid,
 		&empty_blob_oid,
+		&null_oid_sha1,
 	},
 	{
 		"sha256",
@@ -202,9 +209,15 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_sha256_final_oid,
 		&empty_tree_oid_sha256,
 		&empty_blob_oid_sha256,
+		&null_oid_sha256,
 	}
 };
 
+const struct object_id *null_oid(void)
+{
+	return the_hash_algo->null_oid;
+}
+
 const char *empty_tree_oid_hex(void)
 {
 	static char buf[GIT_MAX_HEXSZ + 1];
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 4542d4d3f9..3c811e1e4a 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -140,7 +140,7 @@ int parse_opt_object_id(const struct option *opt, const char *arg, int unset)
 	struct object_id *target = opt->value;
 
 	if (unset) {
-		*target = null_oid;
+		oidcpy(target, null_oid());
 		return 0;
 	}
 	if (!arg)
diff --git a/range-diff.c b/range-diff.c
index 116fb0735c..1a4471fe4c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -445,7 +445,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
-	fill_filespec(spec, &null_oid, 0, 0100644);
+	fill_filespec(spec, null_oid(), 0, 0100644);
 	spec->data = (char *)p;
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
diff --git a/refs.c b/refs.c
index 261fd82beb..996063fdf4 100644
--- a/refs.c
+++ b/refs.c
@@ -1107,7 +1107,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (!new_oid || is_null_oid(new_oid))
 		BUG("create called without valid new_oid");
 	return ref_transaction_update(transaction, refname, new_oid,
-				      &null_oid, flags, msg, err);
+				      null_oid(), flags, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
@@ -1119,7 +1119,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (old_oid && is_null_oid(old_oid))
 		BUG("delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
-				      &null_oid, old_oid,
+				      null_oid(), old_oid,
 				      flags, msg, err);
 }
 
diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6a..2665f94309 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -243,7 +243,7 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
 
-	oidcpy(oid, &null_oid);
+	oidcpy(oid, null_oid());
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
 					    type);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 119972ee16..3f29f8c143 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1084,7 +1084,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			&null_oid, &r->oid, NULL);
+			null_oid(), &r->oid, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
diff --git a/reset.c b/reset.c
index 2f4fbd07c5..4bea758053 100644
--- a/reset.c
+++ b/reset.c
@@ -128,7 +128,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	}
 	if (run_hook)
 		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : &null_oid),
+			    oid_to_hex(orig ? orig : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
 
 leave_reset_head:
diff --git a/sequencer.c b/sequencer.c
index fd183b5593..dbee779243 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -524,7 +524,7 @@ static int fast_forward_to(struct repository *r,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn && !is_rebase_i(opts) ?
-				   &null_oid : from,
+				   null_oid() : from,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1131,7 +1131,7 @@ int update_head_with_reflog(const struct commit *old_head,
 	transaction = ref_transaction_begin(err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", new_head,
-				   old_head ? &old_head->object.oid : &null_oid,
+				   old_head ? &old_head->object.oid : null_oid(),
 				   0, sb.buf, err) ||
 	    ref_transaction_commit(transaction, err)) {
 		ret = -1;
diff --git a/submodule-config.c b/submodule-config.c
index f502505566..2026120fb3 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -671,7 +671,7 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 
 	parameter.cache = repo->submodule_cache;
 	parameter.treeish_name = NULL;
-	parameter.gitmodules_oid = &null_oid;
+	parameter.gitmodules_oid = null_oid();
 	parameter.overwrite = 1;
 
 	return parse_config(var, value, &parameter);
diff --git a/submodule.c b/submodule.c
index 9767ba9893..7eeaf7d203 100644
--- a/submodule.c
+++ b/submodule.c
@@ -113,7 +113,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(the_repository, &null_oid, oldpath);
+	submodule = submodule_from_path(the_repository, null_oid(), oldpath);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
@@ -142,7 +142,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(the_repository, &null_oid, path);
+	submodule = submodule_from_path(the_repository, null_oid(), path);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
@@ -188,7 +188,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
 	const struct submodule *submodule = submodule_from_path(the_repository,
-								&null_oid, path);
+								null_oid(),
+								path);
 	if (submodule) {
 		const char *ignore;
 		char *key;
@@ -244,7 +245,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 	const struct string_list *sl;
 	const struct submodule *module;
 
-	module = submodule_from_path(repo, &null_oid, path);
+	module = submodule_from_path(repo, null_oid(), path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -745,7 +746,7 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	if (!should_update_submodules())
 		return NULL;
 
-	return submodule_from_path(the_repository, &null_oid, ce->name);
+	return submodule_from_path(the_repository, null_oid(), ce->name);
 }
 
 static struct oid_array *submodule_commits(struct string_list *submodules,
@@ -1037,7 +1038,7 @@ int find_unpushed_submodules(struct repository *r,
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(r, &null_oid, name->string);
+		submodule = submodule_from_name(r, null_oid(), name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1224,7 +1225,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(r, &null_oid, name->string);
+		submodule = submodule_from_name(r, null_oid(), name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1361,7 +1362,7 @@ static struct fetch_task *fetch_task_create(struct repository *r,
 	struct fetch_task *task = xmalloc(sizeof(*task));
 	memset(task, 0, sizeof(*task));
 
-	task->sub = submodule_from_path(r, &null_oid, path);
+	task->sub = submodule_from_path(r, null_oid(), path);
 	if (!task->sub) {
 		/*
 		 * No entry in .gitmodules? Technically not a submodule,
@@ -1917,7 +1918,7 @@ int submodule_move_head(const char *path,
 	if (old_head && !is_submodule_populated_gently(path, error_code_ptr))
 		return 0;
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub)
 		BUG("could not get submodule information for '%s'", path);
@@ -2076,7 +2077,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
-	sub = submodule_from_path(the_repository, &null_oid, path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
@@ -2135,7 +2136,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		* superproject did not rewrite the git file links yet,
 		* fix it now.
 		*/
-		sub = submodule_from_path(the_repository, &null_oid, path);
+		sub = submodule_from_path(the_repository, null_oid(), path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		connect_work_tree_and_git_dir(path,
@@ -2283,7 +2284,8 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		sub = submodule_from_path(the_repository, &null_oid, submodule);
+		sub = submodule_from_path(the_repository, null_oid(),
+					  submodule);
 		if (!sub) {
 			ret = -1;
 			goto cleanup;
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index c5fd4527dc..e3f11ff5a7 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -18,7 +18,7 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv)
 
 	setup_git_directory();
 
-	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
+	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
 	if (repo_submodule_init(&subrepo, the_repository, sub)) {
 		die_usage(argv, "Submodule not found.");
 	}
diff --git a/tree-diff.c b/tree-diff.c
index 7cebbb327e..1572615bd9 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -161,7 +161,7 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	memcpy(p->path + base->len, path, pathlen);
 	p->path[len] = 0;
 	p->mode = mode;
-	oidcpy(&p->oid, oid ? oid : &null_oid);
+	oidcpy(&p->oid, oid ? oid : null_oid());
 
 	return p;
 }
@@ -243,7 +243,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 				mode_i = tp[i].entry.mode;
 			}
 			else {
-				oid_i = &null_oid;
+				oid_i = null_oid();
 				mode_i = 0;
 			}
 
diff --git a/wt-status.c b/wt-status.c
index 1aed68c43c..7603c1b198 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1687,10 +1687,10 @@ void wt_status_get_state(struct repository *r,
 	if (!sequencer_get_last_command(r, &action)) {
 		if (action == REPLAY_PICK) {
 			state->cherry_pick_in_progress = 1;
-			oidcpy(&state->cherry_pick_head_oid, &null_oid);
+			oidcpy(&state->cherry_pick_head_oid, null_oid());
 		} else {
 			state->revert_in_progress = 1;
-			oidcpy(&state->revert_head_oid, &null_oid);
+			oidcpy(&state->revert_head_oid, null_oid());
 		}
 	}
 	if (get_detached_from)
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4d20069302..609615db2c 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -172,7 +172,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 	unsigned long size;
 	enum object_type type;
 
-	if (oideq(oid, &null_oid)) {
+	if (oideq(oid, null_oid())) {
 		ptr->ptr = xstrdup("");
 		ptr->size = 0;
 		return;
