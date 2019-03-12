Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B1F20248
	for <e@80x24.org>; Tue, 12 Mar 2019 13:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCLNhH (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:37:07 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.57]:55263 "EHLO mta1.cl.cam.ac.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfCLNhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:37:07 -0400
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta1.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hJ0-0002Ms-Aa; Tue, 12 Mar 2019 13:18:54 +0000
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hJ7-0006o2-1o; Tue, 12 Mar 2019 13:19:01 +0000
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH 2/4] revision walk: optionally use sparse reachability
Date:   Tue, 12 Mar 2019 13:18:56 +0000
Message-Id: <20190312131858.26115-3-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
References: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only caller that passes a non-zero value to prepare_revision_walk
after this patch is builtin/pack-objects.  Without this, sparsity seems
to do little good therein, as prepare_revision_walk will densely
propagate UNINTERESTING flags from trees to tree contents, before
mark_edges_uninteresting has a chance to be faster by being sparse.

Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
---
 bisect.c                         |  2 +-
 blame.c                          |  2 +-
 builtin/checkout.c               |  2 +-
 builtin/commit.c                 |  2 +-
 builtin/describe.c               |  2 +-
 builtin/fast-export.c            |  2 +-
 builtin/fmt-merge-msg.c          |  2 +-
 builtin/log.c                    | 10 +++++-----
 builtin/merge.c                  |  2 +-
 builtin/pack-objects.c           |  4 ++--
 builtin/rev-list.c               |  2 +-
 builtin/shortlog.c               |  2 +-
 bundle.c                         |  2 +-
 http-push.c                      |  2 +-
 merge-recursive.c                |  2 +-
 pack-bitmap-write.c              |  2 +-
 pack-bitmap.c                    |  4 ++--
 reachable.c                      |  4 ++--
 ref-filter.c                     |  2 +-
 remote.c                         |  2 +-
 revision.c                       | 10 ++++++----
 revision.h                       |  2 +-
 sequencer.c                      |  6 +++---
 shallow.c                        |  2 +-
 submodule.c                      |  4 ++--
 t/helper/test-revision-walking.c |  2 +-
 26 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3af955c4bc..47f8e3a7cc 100644
--- a/bisect.c
+++ b/bisect.c
@@ -655,7 +655,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 
 static void bisect_common(struct rev_info *revs)
 {
-	if (prepare_revision_walk(revs))
+	if (prepare_revision_walk(revs, 0))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
 		mark_edges_uninteresting(revs, NULL, 0);
diff --git a/blame.c b/blame.c
index 5c07dec190..13270ba07b 100644
--- a/blame.c
+++ b/blame.c
@@ -1833,7 +1833,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 	 * bottom commits we would reach while traversing as
 	 * uninteresting.
 	 */
-	if (prepare_revision_walk(sb->revs))
+	if (prepare_revision_walk(sb->revs, 0))
 		die(_("revision walk setup failed"));
 
 	if (sb->reverse && sb->revs->first_parent_only) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6037b296..8d6773cbaf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -997,7 +997,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	for_each_ref(add_pending_uninteresting_ref, &revs);
 	add_pending_oid(&revs, "HEAD", &new_commit->object.oid, UNINTERESTING);
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die(_("internal error in revision walk"));
 	if (!(old_commit->object.flags & UNINTERESTING))
 		suggest_reattach(old_commit, &revs);
diff --git a/builtin/commit.c b/builtin/commit.c
index f17537474a..5072e1c85e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1001,7 +1001,7 @@ static const char *find_author_by_nickname(const char *name)
 	revs.mailmap = &mailmap;
 	read_mailmap(revs.mailmap, NULL);
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die(_("revision walk setup failed"));
 	commit = get_revision(&revs);
 	if (commit) {
diff --git a/builtin/describe.c b/builtin/describe.c
index 1409cedce2..0e0d9c5173 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -493,7 +493,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
 		BUG("setup_revisions could not handle all args?");
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die("revision walk setup failed");
 
 	traverse_commit_list(&revs, process_commit, process_object, &pcd);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9e283482ef..7962b4a96c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1148,7 +1148,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	get_tags_and_duplicates(&revs.cmdline);
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
 	revs.diffopt.format_callback_data = &paths_of_changed_objects;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a4615587fd..d38af04e0c 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -356,7 +356,7 @@ static void shortlog(const char *name,
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
 	head->object.flags |= UNINTERESTING;
-	if (prepare_revision_walk(rev))
+	if (prepare_revision_walk(rev, 0))
 		die("revision walk setup failed");
 	while ((commit = get_revision(rev)) != NULL) {
 		struct pretty_print_context ctx = {0};
diff --git a/builtin/log.c b/builtin/log.c
index ab859f5904..e2f12a88bb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -378,7 +378,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	if (rev->early_output)
 		setup_early_output(rev);
 
-	if (prepare_revision_walk(rev))
+	if (prepare_revision_walk(rev, 0))
 		die(_("revision walk setup failed"));
 
 	if (rev->early_output)
@@ -936,7 +936,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	o2->flags ^= UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
 	add_pending_object(&check_rev, o2, "o2");
-	if (prepare_revision_walk(&check_rev))
+	if (prepare_revision_walk(&check_rev, 0))
 		die(_("revision walk setup failed"));
 
 	while ((commit = get_revision(&check_rev)) != NULL) {
@@ -1424,7 +1424,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	base->object.flags |= UNINTERESTING;
 	add_pending_object(&revs, &base->object, "base");
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die(_("revision walk setup failed"));
 	/*
 	 * Traverse the commits list, get prerequisite patch ids
@@ -1800,7 +1800,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		get_patch_ids(&rev, &ids);
 	}
 
-	if (prepare_revision_walk(&rev))
+	if (prepare_revision_walk(&rev, 0))
 		die(_("revision walk setup failed"));
 	rev.boundary = 1;
 	while ((commit = get_revision(&rev)) != NULL) {
@@ -2090,7 +2090,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		die(_("Unknown commit %s"), limit);
 
 	/* reverse the list of commits */
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die(_("revision walk setup failed"));
 	while ((commit = get_revision(&revs)) != NULL) {
 		commit_list_insert(commit, &list);
diff --git a/builtin/merge.c b/builtin/merge.c
index 5ce8946d39..1fbb4069cf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -406,7 +406,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 		add_pending_object(&rev, &j->item->object, NULL);
 
 	setup_revisions(0, NULL, &rev, NULL);
-	if (prepare_revision_walk(&rev))
+	if (prepare_revision_walk(&rev, 0))
 		die(_("revision walk setup failed"));
 
 	ctx.abbrev = rev.abbrev;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a154fc29f6..c4ff6f79af 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3134,7 +3134,7 @@ static void get_object_list(int ac, const char **av)
 	if (use_delta_islands)
 		load_delta_islands(the_repository);
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, sparse))
 		die(_("revision walk setup failed"));
 	mark_edges_uninteresting(&revs, show_edge, sparse);
 
@@ -3149,7 +3149,7 @@ static void get_object_list(int ac, const char **av)
 		if (add_unseen_recent_objects_to_traversal(&revs,
 				unpack_unreachable_expiration))
 			die(_("unable to add recent objects"));
-		if (prepare_revision_walk(&revs))
+		if (prepare_revision_walk(&revs, sparse))
 			die(_("revision walk setup failed"));
 		traverse_commit_list(&revs, record_recent_commit,
 				     record_recent_object, NULL);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5b5b6dbb1c..f192bfdce8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -543,7 +543,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
 		mark_edges_uninteresting(&revs, show_edge, 0);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 65cd41392c..8a236aa317 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -188,7 +188,7 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 {
 	struct commit *commit;
 
-	if (prepare_revision_walk(rev))
+	if (prepare_revision_walk(rev, 0))
 		die(_("revision walk setup failed"));
 	while ((commit = get_revision(rev)) != NULL)
 		shortlog_add_commit(log, commit);
diff --git a/bundle.c b/bundle.c
index b45666c49b..b1ffa02a70 100644
--- a/bundle.c
+++ b/bundle.c
@@ -160,7 +160,7 @@ int verify_bundle(struct repository *r,
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die(_("revision walk setup failed"));
 
 	i = req_nr;
diff --git a/http-push.c b/http-push.c
index b22c7caea0..ba9416f2e0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1931,7 +1931,7 @@ int cmd_main(int argc, const char **argv)
 
 		/* Generate a list of objects that need to be pushed */
 		pushing = 0;
-		if (prepare_revision_walk(&revs))
+		if (prepare_revision_walk(&revs, 0))
 			die("revision walk setup failed");
 		mark_edges_uninteresting(&revs, NULL, 0);
 		objects_to_send = get_delta(&revs, ref_lock);
diff --git a/merge-recursive.c b/merge-recursive.c
index 6c40c61c47..adf218f66b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1141,7 +1141,7 @@ static int find_first_merges(struct repository *repo,
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
 
 	/* save all revisions from the above list that contain b */
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5566e94abe..e317550020 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -296,7 +296,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 			add_pending_object(&revs, object, "");
 			revs.include_check_data = base;
 
-			if (prepare_revision_walk(&revs))
+			if (prepare_revision_walk(&revs, 0))
 				die("revision walk setup failed");
 
 			traverse_commit_list(&revs, show_commit, show_object, base);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4695aaf6b4..21bbbab063 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -584,7 +584,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		revs->include_check = should_include;
 		revs->include_check_data = &incdata;
 
-		if (prepare_revision_walk(revs))
+		if (prepare_revision_walk(revs, 0))
 			die("revision walk setup failed");
 
 		show_data.bitmap_git = bitmap_git;
@@ -987,7 +987,7 @@ void test_bitmap_walk(struct rev_info *revs)
 
 	result_popcnt = bitmap_popcount(result);
 
-	if (prepare_revision_walk(revs))
+	if (prepare_revision_walk(revs, 0))
 		die("revision walk setup failed");
 
 	tdata.bitmap_git = bitmap_git;
diff --git a/reachable.c b/reachable.c
index 0d00a91de4..0339adc074 100644
--- a/reachable.c
+++ b/reachable.c
@@ -234,7 +234,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
 	 */
-	if (prepare_revision_walk(revs))
+	if (prepare_revision_walk(revs, 0))
 		die("revision walk setup failed");
 	traverse_commit_list(revs, mark_commit, mark_object, &cp);
 
@@ -242,7 +242,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 		revs->ignore_missing_links = 1;
 		if (add_unseen_recent_objects_to_traversal(revs, mark_recent))
 			die("unable to mark recent objects");
-		if (prepare_revision_walk(revs))
+		if (prepare_revision_walk(revs, 0))
 			die("revision walk setup failed");
 		traverse_commit_list(revs, mark_commit, mark_object, &cp);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index 3aca105307..a5e16f3b80 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2071,7 +2071,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	add_pending_object(&revs, &filter->merge_commit->object, "");
 
 	revs.limited = 1;
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die(_("revision walk setup failed"));
 
 	old_nr = array->nr;
diff --git a/remote.c b/remote.c
index 9cc3b07d21..4ddd93d5c7 100644
--- a/remote.c
+++ b/remote.c
@@ -1944,7 +1944,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(argv.argc, argv.argv, &revs, NULL);
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die(_("revision walk setup failed"));
 
 	/* ... and count the commits on each side. */
diff --git a/revision.c b/revision.c
index eb8e51bc63..d108fe49bb 100644
--- a/revision.c
+++ b/revision.c
@@ -389,7 +389,8 @@ void add_pending_oid(struct rev_info *revs, const char *name,
 }
 
 static struct commit *handle_commit(struct rev_info *revs,
-				    struct object_array_entry *entry)
+				    struct object_array_entry *entry,
+				    int sparse)
 {
 	struct object *object = entry->item;
 	const char *name = entry->name;
@@ -456,7 +457,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (!revs->tree_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
-			mark_tree_contents_uninteresting(revs->repo, tree);
+			if (!sparse)
+				mark_tree_contents_uninteresting(revs->repo, tree);
 			return NULL;
 		}
 		add_pending_object_with_path(revs, object, name, mode, path);
@@ -3289,7 +3291,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	}
 }
 
-int prepare_revision_walk(struct rev_info *revs)
+int prepare_revision_walk(struct rev_info *revs, int sparse)
 {
 	int i;
 	struct object_array old_pending;
@@ -3301,7 +3303,7 @@ int prepare_revision_walk(struct rev_info *revs)
 	revs->pending.objects = NULL;
 	for (i = 0; i < old_pending.nr; i++) {
 		struct object_array_entry *e = old_pending.objects + i;
-		struct commit *commit = handle_commit(revs, e);
+		struct commit *commit = handle_commit(revs, e, sparse);
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
diff --git a/revision.h b/revision.h
index 4134dc6029..2e921c515a 100644
--- a/revision.h
+++ b/revision.h
@@ -320,7 +320,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags, unsigned revarg_opt);
 
 void reset_revision_walk(void);
-int prepare_revision_walk(struct rev_info *revs);
+int prepare_revision_walk(struct rev_info *revs, int sparse);
 struct commit *get_revision(struct rev_info *revs);
 char *get_revision_mark(const struct rev_info *revs,
 			const struct commit *commit);
diff --git a/sequencer.c b/sequencer.c
index 95dda23eee..df32dc1e71 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1990,7 +1990,7 @@ static int prepare_revs(struct replay_opts *opts)
 	if (opts->action == REPLAY_PICK && !opts->revs->no_walk)
 		opts->revs->reverse ^= 1;
 
-	if (prepare_revision_walk(opts->revs))
+	if (prepare_revision_walk(opts->revs, 0))
 		return error(_("revision walk setup failed"));
 
 	return 0;
@@ -4062,7 +4062,7 @@ int sequencer_pick_revisions(struct repository *r,
 	    opts->revs->no_walk &&
 	    !opts->revs->cmdline.rev->flags) {
 		struct commit *cmit;
-		if (prepare_revision_walk(opts->revs))
+		if (prepare_revision_walk(opts->revs, 0))
 			return error(_("revision walk setup failed"));
 		cmit = get_revision(opts->revs);
 		if (!cmit)
@@ -4529,7 +4529,7 @@ int sequencer_make_script(struct repository *r, FILE *out,
 	if (setup_revisions(argc, argv, &revs, NULL) > 1)
 		return error(_("make_script: unhandled options"));
 
-	if (prepare_revision_walk(&revs) < 0)
+	if (prepare_revision_walk(&revs, 0) < 0)
 		return error(_("make_script: error preparing revisions"));
 
 	if (rebase_merges)
diff --git a/shallow.c b/shallow.c
index ce45297940..e9f3886a59 100644
--- a/shallow.c
+++ b/shallow.c
@@ -196,7 +196,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&revs, 0))
 		die("revision walk setup failed");
 	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_list);
 
diff --git a/submodule.c b/submodule.c
index 21cf50ca15..2b18f888ca 100644
--- a/submodule.c
+++ b/submodule.c
@@ -456,7 +456,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 		add_pending_object(rev, &list->item->object,
 			oid_to_hex(&list->item->object.oid));
 	}
-	return prepare_revision_walk(rev);
+	return prepare_revision_walk(rev, 0);
 }
 
 static void print_submodule_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
@@ -843,7 +843,7 @@ static void collect_changed_submodules(struct repository *r,
 
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
-	if (prepare_revision_walk(&rev))
+	if (prepare_revision_walk(&rev, 0))
 		die("revision walk setup failed");
 
 	while ((commit = get_revision(&rev))) {
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 625b2dbf82..dc1ff31d5c 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -34,7 +34,7 @@ static int run_revision_walk(void)
 
 	repo_init_revisions(the_repository, &rev, NULL);
 	setup_revisions(argc, argv, &rev, NULL);
-	if (prepare_revision_walk(&rev))
+	if (prepare_revision_walk(&rev, 0))
 		die("revision walk setup failed");
 
 	while ((commit = get_revision(&rev)) != NULL) {
-- 
2.17.1

