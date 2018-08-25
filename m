Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DBA1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHYLph (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 07:45:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:55700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbeHYLph (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 07:45:37 -0400
Received: (qmail 4868 invoked by uid 109); 25 Aug 2018 08:07:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:07:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2354 invoked by uid 111); 25 Aug 2018 08:07:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:07:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:07:15 -0400
Date:   Sat, 25 Aug 2018 04:07:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 3/9] convert "oidcmp() == 0" to oideq()
Message-ID: <20180825080715.GC737@sigill.intra.peff.net>
References: <20180825080031.GA32139@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180825080031.GA32139@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the more restrictive oideq() should, in the long run,
give the compiler more opportunities to optimize these
callsites. For now, this conversion should be a complete
noop with respect to the generated code.

The result is also perhaps a little more readable, as it
avoids the "zero is equal" idiom. Since it's so prevalent in
C, I think seasoned programmers tend not to even notice it
anymore, but it can sometimes make for awkward double
negations (e.g., we can drop a few !!oidcmp() instances
here).

This patch was generated almost entirely by the included
coccinelle patch. This mechanical conversion should be
completely safe, because we check explicitly for cases where
oidcmp() is compared to 0, which is what oideq() is doing
under the hood. Note that we don't have to catch "!oidcmp()"
separately; coccinelle's standard isomorphisms make sure the
two are treated equivalently.

I say "almost" because I did hand-edit the coccinelle output
to fix up a few style violations (it mostly keeps the
original formatting, but sometimes unwraps long lines).

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c                           |  4 ++--
 blame.c                            |  4 ++--
 builtin/am.c                       |  2 +-
 builtin/checkout.c                 |  2 +-
 builtin/describe.c                 |  4 ++--
 builtin/diff.c                     |  2 +-
 builtin/difftool.c                 |  4 ++--
 builtin/fast-export.c              |  2 +-
 builtin/fetch.c                    |  4 ++--
 builtin/fmt-merge-msg.c            |  2 +-
 builtin/index-pack.c               |  4 ++--
 builtin/log.c                      |  6 +++---
 builtin/merge-tree.c               |  2 +-
 builtin/merge.c                    |  4 ++--
 builtin/pack-objects.c             |  4 ++--
 builtin/pull.c                     |  2 +-
 builtin/receive-pack.c             |  4 ++--
 builtin/remote.c                   |  2 +-
 builtin/replace.c                  |  6 +++---
 builtin/unpack-objects.c           |  2 +-
 builtin/update-index.c             |  4 ++--
 bulk-checkin.c                     |  2 +-
 cache-tree.c                       |  2 +-
 cache.h                            |  4 ++--
 combine-diff.c                     |  4 ++--
 commit-graph.c                     |  2 +-
 connect.c                          |  2 +-
 contrib/coccinelle/object_id.cocci |  6 ++++++
 diff-lib.c                         |  2 +-
 diff.c                             |  6 +++---
 diffcore-break.c                   |  2 +-
 fast-import.c                      |  6 +++---
 http-push.c                        |  2 +-
 log-tree.c                         |  6 +++---
 merge-recursive.c                  |  4 ++--
 notes-merge.c                      | 24 +++++++++++-----------
 notes.c                            |  4 ++--
 pack-write.c                       |  2 +-
 read-cache.c                       |  2 +-
 ref-filter.c                       |  2 +-
 refs/files-backend.c               |  4 ++--
 remote.c                           |  6 +++---
 revision.c                         |  2 +-
 sequencer.c                        | 32 +++++++++++++++---------------
 sha1-array.c                       |  2 +-
 sha1-file.c                        |  4 ++--
 sha1-name.c                        |  2 +-
 submodule.c                        |  2 +-
 transport.c                        |  2 +-
 unpack-trees.c                     |  6 +++---
 wt-status.c                        | 10 +++++-----
 xdiff-interface.c                  |  2 +-
 52 files changed, 117 insertions(+), 111 deletions(-)

diff --git a/bisect.c b/bisect.c
index e1275ba79e..41c56a665e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -807,7 +807,7 @@ static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
-		if (!oidcmp(mb, current_bad_oid)) {
+		if (oideq(mb, current_bad_oid)) {
 			handle_bad_merge_base();
 		} else if (0 <= oid_array_lookup(&good_revs, mb)) {
 			continue;
@@ -988,7 +988,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	bisect_rev = &revs.commits->item->object.oid;
 
-	if (!oidcmp(bisect_rev, current_bad_oid)) {
+	if (oideq(bisect_rev, current_bad_oid)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
diff --git a/blame.c b/blame.c
index 08c0c6cf73..10d72e36dd 100644
--- a/blame.c
+++ b/blame.c
@@ -1459,14 +1459,14 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 			porigin = find(p, origin);
 			if (!porigin)
 				continue;
-			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
+			if (oideq(&porigin->blob_oid, &origin->blob_oid)) {
 				pass_whole_blame(sb, origin, porigin);
 				blame_origin_decref(porigin);
 				goto finish;
 			}
 			for (j = same = 0; j < i; j++)
 				if (sg_origin[j] &&
-				    !oidcmp(&sg_origin[j]->blob_oid, &porigin->blob_oid)) {
+				    oideq(&sg_origin[j]->blob_oid, &porigin->blob_oid)) {
 					same = 1;
 					break;
 				}
diff --git a/builtin/am.c b/builtin/am.c
index 9f7ecf6ecb..e54110d474 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2077,7 +2077,7 @@ static int safe_to_abort(const struct am_state *state)
 	if (get_oid("HEAD", &head))
 		oidclr(&head);
 
-	if (!oidcmp(&head, &abort_safety))
+	if (oideq(&head, &abort_safety))
 		return 1;
 
 	warning(_("You seem to have moved HEAD since the last 'am' failure.\n"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29ef50013d..082e3a9f19 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -96,7 +96,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	if (pos >= 0) {
 		struct cache_entry *old = active_cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
-		    !oidcmp(&ce->oid, &old->oid)) {
+		    oideq(&ce->oid, &old->oid)) {
 			old->ce_flags |= CE_UPDATE;
 			discard_cache_entry(ce);
 			return 0;
diff --git a/builtin/describe.c b/builtin/describe.c
index 41606c8a90..1e7c75ba82 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -190,7 +190,7 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 
 	/* Is it annotated? */
 	if (!peel_ref(path, &peeled)) {
-		is_annotated = !!oidcmp(oid, &peeled);
+		is_annotated = !oideq(oid, &peeled);
 	} else {
 		oidcpy(&peeled, oid);
 		is_annotated = 0;
@@ -469,7 +469,7 @@ static void process_object(struct object *obj, const char *path, void *data)
 {
 	struct process_commit_data *pcd = data;
 
-	if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
+	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
 		describe_commit(&pcd->current_commit, pcd->dst);
 		strbuf_addf(pcd->dst, ":%s", path);
diff --git a/builtin/diff.c b/builtin/diff.c
index 361a3c3ed3..b3a8ba488f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -41,7 +41,7 @@ static void stuff_change(struct diff_options *opt,
 	struct diff_filespec *one, *two;
 
 	if (!is_null_oid(old_oid) && !is_null_oid(new_oid) &&
-	    !oidcmp(old_oid, new_oid) && (old_mode == new_mode))
+	    oideq(old_oid, new_oid) && (old_mode == new_mode))
 		return;
 
 	if (opt->flags.reverse_diff) {
diff --git a/builtin/difftool.c b/builtin/difftool.c
index cdd585ca76..b41a9199ff 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -116,7 +116,7 @@ static int use_wt_file(const char *workdir, const char *name,
 			if (is_null_oid(oid)) {
 				oidcpy(oid, &wt_oid);
 				use = 1;
-			} else if (!oidcmp(oid, &wt_oid))
+			} else if (oideq(oid, &wt_oid))
 				use = 1;
 		}
 	}
@@ -438,7 +438,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "Subproject commit %s",
 				    oid_to_hex(&roid));
-			if (!oidcmp(&loid, &roid))
+			if (oideq(&loid, &roid))
 				strbuf_addstr(&buf, "-dirty");
 			add_left_or_right(&submodules, dst_path, buf.buf, 1);
 			continue;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9bd8a14b57..74f3bf5c96 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -384,7 +384,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 				string_list_insert(changed, spec->path);
 				putchar('\n');
 
-				if (!oidcmp(&ospec->oid, &spec->oid) &&
+				if (oideq(&ospec->oid, &spec->oid) &&
 				    ospec->mode == spec->mode)
 					break;
 			}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213..32b1d5d383 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -507,7 +507,7 @@ static void adjust_refcol_width(const struct ref *ref)
 	int max, rlen, llen, len;
 
 	/* uptodate lines are only shown on high verbosity level */
-	if (!verbosity && !oidcmp(&ref->peer_ref->old_oid, &ref->old_oid))
+	if (!verbosity && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
 		return;
 
 	max    = term_columns();
@@ -644,7 +644,7 @@ static int update_local_ref(struct ref *ref,
 	if (type < 0)
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
-	if (!oidcmp(&ref->old_oid, &ref->new_oid)) {
+	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			format_display(display, '=', _("[up to date]"), NULL,
 				       remote, pretty_ref, summary_width);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index f35ff1612b..4c82c234cb 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -582,7 +582,7 @@ static void find_merge_parents(struct merge_parents *result,
 	while (parents) {
 		struct commit *cmit = pop_commit(&parents);
 		for (i = 0; i < result->nr; i++)
-			if (!oidcmp(&result->item[i].commit, &cmit->object.oid))
+			if (oideq(&result->item[i].commit, &cmit->object.oid))
 				result->item[i].used = 1;
 	}
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9582ead950..edcb0a3dca 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -719,9 +719,9 @@ static void find_ref_delta_children(const struct object_id *oid,
 		*last_index = -1;
 		return;
 	}
-	while (first > 0 && !oidcmp(&ref_deltas[first - 1].oid, oid))
+	while (first > 0 && oideq(&ref_deltas[first - 1].oid, oid))
 		--first;
-	while (last < end && !oidcmp(&ref_deltas[last + 1].oid, oid))
+	while (last < end && oideq(&ref_deltas[last + 1].oid, oid))
 		++last;
 	*first_index = first;
 	*last_index = last;
diff --git a/builtin/log.c b/builtin/log.c
index e094560d9a..98d668b56f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -992,7 +992,7 @@ static char *find_branch_name(struct rev_info *rev)
 	tip_oid = &rev->cmdline.rev[positive].item->oid;
 	if (dwim_ref(ref, strlen(ref), &branch_oid, &full_ref) &&
 	    skip_prefix(full_ref, "refs/heads/", &v) &&
-	    !oidcmp(tip_oid, &branch_oid))
+	    oideq(tip_oid, &branch_oid))
 		branch = xstrdup(v);
 	free(full_ref);
 	return branch;
@@ -1703,7 +1703,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* Don't say anything if head and upstream are the same. */
 		if (rev.pending.nr == 2) {
 			struct object_array_entry *o = rev.pending.objects;
-			if (oidcmp(&o[0].item->oid, &o[1].item->oid) == 0)
+			if (oideq(&o[0].item->oid, &o[1].item->oid))
 				return 0;
 		}
 		get_patch_ids(&rev, &ids);
@@ -1949,7 +1949,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	/* Don't say anything if head and upstream are the same. */
 	if (revs.pending.nr == 2) {
 		struct object_array_entry *o = revs.pending.objects;
-		if (oidcmp(&o[0].item->oid, &o[1].item->oid) == 0)
+		if (oideq(&o[0].item->oid, &o[1].item->oid))
 			return 0;
 	}
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index f8023bae1e..8cea8a74f2 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -155,7 +155,7 @@ static int same_entry(struct name_entry *a, struct name_entry *b)
 {
 	return	a->oid &&
 		b->oid &&
-		!oidcmp(a->oid, b->oid) &&
+		oideq(a->oid, b->oid) &&
 		a->mode == b->mode;
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 8f4a5065c2..57abff999b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1189,7 +1189,7 @@ static int merging_a_throwaway_tag(struct commit *commit)
 	tag_ref = xstrfmt("refs/tags/%s",
 			  ((struct tag *)merge_remote_util(commit)->obj)->tag);
 	if (!read_ref(tag_ref, &oid) &&
-	    !oidcmp(&oid, &merge_remote_util(commit)->obj->oid))
+	    oideq(&oid, &merge_remote_util(commit)->obj->oid))
 		is_throwaway_tag = 0;
 	else
 		is_throwaway_tag = 1;
@@ -1448,7 +1448,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
-			!oidcmp(&common->item->object.oid, &head_commit->object.oid)) {
+			oideq(&common->item->object.oid, &head_commit->object.oid)) {
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d1144a8f7e..64156f676b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1202,7 +1202,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	 */
 	for (neigh = 0; neigh < 8; neigh++) {
 		ent = pbase_tree_cache[my_ix];
-		if (ent && !oidcmp(&ent->oid, oid)) {
+		if (ent && oideq(&ent->oid, oid)) {
 			ent->ref++;
 			return ent;
 		}
@@ -1384,7 +1384,7 @@ static void add_preferred_base(struct object_id *oid)
 		return;
 
 	for (it = pbase_tree; it; it = it->next) {
-		if (!oidcmp(&it->pcache.oid, &tree_oid)) {
+		if (oideq(&it->pcache.oid, &tree_oid)) {
 			free(data);
 			return;
 		}
diff --git a/builtin/pull.c b/builtin/pull.c
index 53bc5facfd..27db0c69eb 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -799,7 +799,7 @@ static int run_rebase(const struct object_id *curr_head,
 	struct argv_array args = ARGV_ARRAY_INIT;
 
 	if (!get_octopus_merge_base(&oct_merge_base, curr_head, merge_head, fork_point))
-		if (!is_null_oid(fork_point) && !oidcmp(&oct_merge_base, fork_point))
+		if (!is_null_oid(fork_point) && oideq(&oct_merge_base, fork_point))
 			fork_point = NULL;
 
 	argv_array_push(&args, "rebase");
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c17ce94e12..5bb163d4d2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1222,8 +1222,8 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 
 	dst_cmd = (struct command *) item->util;
 
-	if (!oidcmp(&cmd->old_oid, &dst_cmd->old_oid) &&
-	    !oidcmp(&cmd->new_oid, &dst_cmd->new_oid))
+	if (oideq(&cmd->old_oid, &dst_cmd->old_oid) &&
+	    oideq(&cmd->new_oid, &dst_cmd->new_oid))
 		return;
 
 	dst_cmd->skip_update = 1;
diff --git a/builtin/remote.c b/builtin/remote.c
index 07bd51f8eb..54a763cf90 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -412,7 +412,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 
 		if (is_null_oid(&ref->new_oid)) {
 			info->status = PUSH_STATUS_DELETE;
-		} else if (!oidcmp(&ref->old_oid, &ref->new_oid))
+		} else if (oideq(&ref->old_oid, &ref->new_oid))
 			info->status = PUSH_STATUS_UPTODATE;
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
diff --git a/builtin/replace.c b/builtin/replace.c
index 4f05791f3e..8e67e09819 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -343,7 +343,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	}
 	free(tmpfile);
 
-	if (!oidcmp(&old_oid, &new_oid))
+	if (oideq(&old_oid, &new_oid))
 		return error(_("new object is the same as the old one: '%s'"), oid_to_hex(&old_oid));
 
 	return replace_object_oid(object_ref, &old_oid, "replacement", &new_oid, force);
@@ -414,7 +414,7 @@ static int check_one_mergetag(struct commit *commit,
 		if (get_oid(mergetag_data->argv[i], &oid) < 0)
 			return error(_("not a valid object name: '%s'"),
 				     mergetag_data->argv[i]);
-		if (!oidcmp(&tag->tagged->oid, &oid))
+		if (oideq(&tag->tagged->oid, &oid))
 			return 0; /* found */
 	}
 
@@ -474,7 +474,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 
 	strbuf_release(&buf);
 
-	if (!oidcmp(&old_oid, &new_oid)) {
+	if (oideq(&old_oid, &new_oid)) {
 		if (gentle) {
 			warning(_("graft for '%s' unnecessary"), oid_to_hex(&old_oid));
 			return 0;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 30d9413b4b..ad438f5b41 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -303,7 +303,7 @@ static void added_object(unsigned nr, enum object_type type,
 	struct delta_info *info;
 
 	while ((info = *p) != NULL) {
-		if (!oidcmp(&info->base_oid, &obj_list[nr].oid) ||
+		if (oideq(&info->base_oid, &obj_list[nr].oid) ||
 		    info->base_offset == obj_list[nr].offset) {
 			*p = info->next;
 			p = &delta_list;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index fe84003b4f..e7fab78b3b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -669,7 +669,7 @@ static int unresolve_one(const char *path)
 		ret = -1;
 		goto free_return;
 	}
-	if (!oidcmp(&ce_2->oid, &ce_3->oid) &&
+	if (oideq(&ce_2->oid, &ce_3->oid) &&
 	    ce_2->ce_mode == ce_3->ce_mode) {
 		fprintf(stderr, "%s: identical in both, skipping.\n",
 			path);
@@ -754,7 +754,7 @@ static int do_reupdate(int ac, const char **av,
 			old = read_one_ent(NULL, &head_oid,
 					   ce->name, ce_namelen(ce), 0);
 		if (old && ce->ce_mode == old->ce_mode &&
-		    !oidcmp(&ce->oid, &old->oid)) {
+		    oideq(&ce->oid, &old->oid)) {
 			discard_cache_entry(old);
 			continue; /* unchanged */
 		}
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9f3b644811..409ecb566b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -72,7 +72,7 @@ static int already_written(struct bulk_checkin_state *state, struct object_id *o
 
 	/* Might want to keep the list sorted */
 	for (i = 0; i < state->nr_written; i++)
-		if (!oidcmp(&state->written[i]->oid, oid))
+		if (oideq(&state->written[i]->oid, oid))
 			return 1;
 
 	/* This is a new object we need to keep */
diff --git a/cache-tree.c b/cache-tree.c
index 16ea022c46..b49bb5c5be 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -714,7 +714,7 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 
 	it = find_cache_tree_from_traversal(root, info);
 	it = cache_tree_find(it, ent->path);
-	if (it && it->entry_count > 0 && !oidcmp(ent->oid, &it->oid))
+	if (it && it->entry_count > 0 && oideq(ent->oid, &it->oid))
 		return it->entry_count;
 	return 0;
 }
diff --git a/cache.h b/cache.h
index f6d227fac7..d090f71706 100644
--- a/cache.h
+++ b/cache.h
@@ -1100,7 +1100,7 @@ static inline int is_empty_blob_sha1(const unsigned char *sha1)
 
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
-	return !oidcmp(oid, the_hash_algo->empty_blob);
+	return oideq(oid, the_hash_algo->empty_blob);
 }
 
 static inline int is_empty_tree_sha1(const unsigned char *sha1)
@@ -1110,7 +1110,7 @@ static inline int is_empty_tree_sha1(const unsigned char *sha1)
 
 static inline int is_empty_tree_oid(const struct object_id *oid)
 {
-	return !oidcmp(oid, the_hash_algo->empty_tree);
+	return oideq(oid, the_hash_algo->empty_tree);
 }
 
 const char *empty_tree_oid_hex(void);
diff --git a/combine-diff.c b/combine-diff.c
index de7695e728..0fed4ca529 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1138,8 +1138,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	for (i = 0; i < num_parent; i++) {
 		int j;
 		for (j = 0; j < i; j++) {
-			if (!oidcmp(&elem->parent[i].oid,
-				     &elem->parent[j].oid)) {
+			if (oideq(&elem->parent[i].oid,
+				  &elem->parent[j].oid)) {
 				reuse_combine_diff(sline, cnt, i, j);
 				break;
 			}
diff --git a/commit-graph.c b/commit-graph.c
index 8a1bec7b8a..050c516b0d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -779,7 +779,7 @@ void write_commit_graph(const char *obj_dir,
 	num_extra_edges = 0;
 	for (i = 0; i < oids.nr; i++) {
 		int num_parents = 0;
-		if (i > 0 && !oidcmp(&oids.list[i-1], &oids.list[i]))
+		if (i > 0 && oideq(&oids.list[i - 1], &oids.list[i]))
 			continue;
 
 		commits.list[commits.nr] = lookup_commit(the_repository, &oids.list[i]);
diff --git a/connect.c b/connect.c
index 94547e5056..24281b6082 100644
--- a/connect.c
+++ b/connect.c
@@ -224,7 +224,7 @@ static int process_dummy_ref(const char *line)
 		return 0;
 	name++;
 
-	return !oidcmp(&null_oid, &oid) && !strcmp(name, "capabilities^{}");
+	return oideq(&null_oid, &oid) && !strcmp(name, "capabilities^{}");
 }
 
 static void check_no_capabilities(const char *line, int len)
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 5869979be7..548c02336d 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -108,3 +108,9 @@ expression E1, E2;
 @@
 - hashcpy(E1.hash, E2->hash)
 + oidcpy(&E1, E2)
+
+@@
+expression E1, E2;
+@@
+- oidcmp(E1, E2) == 0
++ oideq(E1, E2)
diff --git a/diff-lib.c b/diff-lib.c
index 88a98b1c06..c1f5a52654 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -366,7 +366,7 @@ static int show_modified(struct rev_info *revs,
 	}
 
 	oldmode = old_entry->ce_mode;
-	if (mode == oldmode && !oidcmp(oid, &old_entry->oid) && !dirty_submodule &&
+	if (mode == oldmode && oideq(oid, &old_entry->oid) && !dirty_submodule &&
 	    !revs->diffopt.flags.find_copies_harder)
 		return 0;
 
diff --git a/diff.c b/diff.c
index 145cfbae59..5cada68267 100644
--- a/diff.c
+++ b/diff.c
@@ -3404,7 +3404,7 @@ static void builtin_diff(const char *name_a,
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !o->flags.binary) {
-			if (!oidcmp(&one->oid, &two->oid)) {
+			if (oideq(&one->oid, &two->oid)) {
 				if (must_show_header)
 					emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
 							 header.buf, header.len,
@@ -3569,7 +3569,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		return;
 	}
 
-	same_contents = !oidcmp(&one->oid, &two->oid);
+	same_contents = oideq(&one->oid, &two->oid);
 
 	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
 		data->is_binary = 1;
@@ -5323,7 +5323,7 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	 * dealing with a change.
 	 */
 	if (one->oid_valid && two->oid_valid &&
-	    !oidcmp(&one->oid, &two->oid) &&
+	    oideq(&one->oid, &two->oid) &&
 	    !one->dirty_submodule && !two->dirty_submodule)
 		return 1; /* no change */
 	if (!one->oid_valid && !two->oid_valid)
diff --git a/diffcore-break.c b/diffcore-break.c
index c64359f489..e11fcfdb39 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -58,7 +58,7 @@ static int should_break(struct diff_filespec *src,
 	}
 
 	if (src->oid_valid && dst->oid_valid &&
-	    !oidcmp(&src->oid, &dst->oid))
+	    oideq(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
diff --git a/fast-import.c b/fast-import.c
index 89bb0c9db3..a731088f96 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -572,7 +572,7 @@ static struct object_entry *find_object(struct object_id *oid)
 	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
 	struct object_entry *e;
 	for (e = object_table[h]; e; e = e->next)
-		if (!oidcmp(oid, &e->idx.oid))
+		if (oideq(oid, &e->idx.oid))
 			return e;
 	return NULL;
 }
@@ -583,7 +583,7 @@ static struct object_entry *insert_object(struct object_id *oid)
 	struct object_entry *e = object_table[h];
 
 	while (e) {
-		if (!oidcmp(oid, &e->idx.oid))
+		if (oideq(oid, &e->idx.oid))
 			return e;
 		e = e->next;
 	}
@@ -1533,7 +1533,7 @@ static int tree_content_set(
 			if (!*slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
-						&& !oidcmp(&e->versions[1].oid, oid))
+						&& oideq(&e->versions[1].oid, oid))
 					return 0;
 				e->versions[1].mode = mode;
 				oidcpy(&e->versions[1].oid, oid);
diff --git a/http-push.c b/http-push.c
index 5eaf551b51..283495c18a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1859,7 +1859,7 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 
-		if (!oidcmp(&ref->old_oid, &ref->peer_ref->new_oid)) {
+		if (oideq(&ref->old_oid, &ref->peer_ref->new_oid)) {
 			if (push_verbosely)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			if (helper_status)
diff --git a/log-tree.c b/log-tree.c
index 7443e5fcc7..2edff78cff 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -472,7 +472,7 @@ static int which_parent(const struct object_id *oid, const struct commit *commit
 	const struct commit_list *parent;
 
 	for (nth = 0, parent = commit->parents; parent; parent = parent->next) {
-		if (!oidcmp(&parent->item->object.oid, oid))
+		if (oideq(&parent->item->object.oid, oid))
 			return nth;
 		nth++;
 	}
@@ -506,8 +506,8 @@ static int show_one_mergetag(struct commit *commit,
 	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		strbuf_addstr(&verify_message, "malformed mergetag\n");
 	else if (is_common_merge(commit) &&
-		 !oidcmp(&tag->tagged->oid,
-			  &commit->parents->next->item->object.oid))
+		 oideq(&tag->tagged->oid,
+		       &commit->parents->next->item->object.oid))
 		strbuf_addf(&verify_message,
 			    "merged tag '%s'\n", tag->tag);
 	else if ((nth = which_parent(&tag->tagged->oid, commit)) < 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index dcdc93019c..2904cb825e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -156,7 +156,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 		shift_tree_by(&one->object.oid, &two->object.oid, &shifted,
 			      subtree_shift);
 	}
-	if (!oidcmp(&two->object.oid, &shifted))
+	if (oideq(&two->object.oid, &shifted))
 		return two;
 	return lookup_tree(the_repository, &shifted);
 }
@@ -179,7 +179,7 @@ static int oid_eq(const struct object_id *a, const struct object_id *b)
 {
 	if (!a && !b)
 		return 2;
-	return a && b && oidcmp(a, b) == 0;
+	return a && b && oideq(a, b);
 }
 
 enum rename_type {
diff --git a/notes-merge.c b/notes-merge.c
index 76ab19e702..0a47e54cf8 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -151,7 +151,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 		mp = find_notes_merge_pair_pos(changes, len, &obj, 1, &occupied);
 		if (occupied) {
 			/* We've found an addition/deletion pair */
-			assert(!oidcmp(&mp->obj, &obj));
+			assert(oideq(&mp->obj, &obj));
 			if (is_null_oid(&p->one->oid)) { /* addition */
 				assert(is_null_oid(&mp->remote));
 				oidcpy(&mp->remote, &p->two->oid);
@@ -218,7 +218,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 			continue;
 		}
 
-		assert(!oidcmp(&mp->obj, &obj));
+		assert(oideq(&mp->obj, &obj));
 		if (is_null_oid(&p->two->oid)) { /* deletion */
 			/*
 			 * Either this is a true deletion (1), or it is part
@@ -229,7 +229,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 			 * (3) mp->local is uninitialized; set it to null_sha1
 			 *     (will be overwritten by following addition)
 			 */
-			if (!oidcmp(&mp->local, &uninitialized))
+			if (oideq(&mp->local, &uninitialized))
 				oidclr(&mp->local);
 		} else if (is_null_oid(&p->one->oid)) { /* addition */
 			/*
@@ -241,7 +241,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 			 * (3) mp->local is null_sha1;     set to p->two->sha1
 			 */
 			assert(is_null_oid(&mp->local) ||
-			       !oidcmp(&mp->local, &uninitialized));
+			       oideq(&mp->local, &uninitialized));
 			oidcpy(&mp->local, &p->two->oid);
 		} else { /* modification */
 			/*
@@ -249,8 +249,8 @@ static void diff_tree_local(struct notes_merge_options *o,
 			 * match mp->base, and mp->local shall be uninitialized.
 			 * Set mp->local to p->two->sha1.
 			 */
-			assert(!oidcmp(&p->one->oid, &mp->base));
-			assert(!oidcmp(&mp->local, &uninitialized));
+			assert(oideq(&p->one->oid, &mp->base));
+			assert(oideq(&mp->local, &uninitialized));
 			oidcpy(&mp->local, &p->two->oid);
 		}
 		trace_printf("\t\tStored local change for %s: %.7s -> %.7s\n",
@@ -480,14 +480,14 @@ static int merge_changes(struct notes_merge_options *o,
 		       oid_to_hex(&p->local),
 		       oid_to_hex(&p->remote));
 
-		if (!oidcmp(&p->base, &p->remote)) {
+		if (oideq(&p->base, &p->remote)) {
 			/* no remote change; nothing to do */
 			trace_printf("\t\t\tskipping (no remote change)\n");
-		} else if (!oidcmp(&p->local, &p->remote)) {
+		} else if (oideq(&p->local, &p->remote)) {
 			/* same change in local and remote; nothing to do */
 			trace_printf("\t\t\tskipping (local == remote)\n");
-		} else if (!oidcmp(&p->local, &uninitialized) ||
-			   !oidcmp(&p->local, &p->base)) {
+		} else if (oideq(&p->local, &uninitialized) ||
+			   oideq(&p->local, &p->base)) {
 			/* no local change; adopt remote change */
 			trace_printf("\t\t\tno local change, adopted remote\n");
 			if (add_note(t, &p->obj, &p->remote,
@@ -621,14 +621,14 @@ int notes_merge(struct notes_merge_options *o,
 			oid_to_hex(&local->object.oid),
 			oid_to_hex(base_oid));
 
-	if (!oidcmp(&remote->object.oid, base_oid)) {
+	if (oideq(&remote->object.oid, base_oid)) {
 		/* Already merged; result == local commit */
 		if (o->verbosity >= 2)
 			printf("Already up to date!\n");
 		oidcpy(result_oid, &local->object.oid);
 		goto found_result;
 	}
-	if (!oidcmp(&local->object.oid, base_oid)) {
+	if (oideq(&local->object.oid, base_oid)) {
 		/* Fast-forward; result == remote commit */
 		if (o->verbosity >= 2)
 			printf("Fast-forward\n");
diff --git a/notes.c b/notes.c
index 32d3dbcc1e..b3386d6c36 100644
--- a/notes.c
+++ b/notes.c
@@ -266,9 +266,9 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	case PTR_TYPE_NOTE:
 		switch (type) {
 		case PTR_TYPE_NOTE:
-			if (!oidcmp(&l->key_oid, &entry->key_oid)) {
+			if (oideq(&l->key_oid, &entry->key_oid)) {
 				/* skip concatenation if l == entry */
-				if (!oidcmp(&l->val_oid, &entry->val_oid))
+				if (oideq(&l->val_oid, &entry->val_oid))
 					return 0;
 
 				ret = combine_notes(&l->val_oid,
diff --git a/pack-write.c b/pack-write.c
index a9d46bc03f..7d14716c40 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -124,7 +124,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		}
 		hashwrite(f, obj->oid.hash, the_hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
-		    (i && !oidcmp(&list[-2]->oid, &obj->oid)))
+		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
 			    oid_to_hex(&obj->oid));
 	}
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..eb4919e77f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -767,7 +767,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	/* It was suspected to be racily clean, but it turns out to be Ok */
 	was_same = (alias &&
 		    !ce_stage(alias) &&
-		    !oidcmp(&alias->oid, &ce->oid) &&
+		    oideq(&alias->oid, &ce->oid) &&
 		    ce->ce_mode == alias->ce_mode);
 
 	if (pretend)
diff --git a/ref-filter.c b/ref-filter.c
index 0bccfceff2..ccca317ce1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1710,7 +1710,7 @@ struct contains_stack {
 static int in_commit_list(const struct commit_list *want, struct commit *c)
 {
 	for (; want; want = want->next)
-		if (!oidcmp(&want->item->object.oid, &c->object.oid))
+		if (oideq(&want->item->object.oid, &c->object.oid))
 			return 1;
 	return 0;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1f1a98e4cb..aa45f5317f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2307,7 +2307,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 			 struct strbuf *err)
 {
 	if (!(update->flags & REF_HAVE_OLD) ||
-		   !oidcmp(oid, &update->old_oid))
+		   oideq(oid, &update->old_oid))
 		return 0;
 
 	if (is_null_oid(&update->old_oid))
@@ -2443,7 +2443,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {
 		if (!(update->type & REF_ISSYMREF) &&
-		    !oidcmp(&lock->old_oid, &update->new_oid)) {
+		    oideq(&lock->old_oid, &update->new_oid)) {
 			/*
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
diff --git a/remote.c b/remote.c
index 7f6277a145..6f1ee9d640 100644
--- a/remote.c
+++ b/remote.c
@@ -1388,7 +1388,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 		ref->deletion = is_null_oid(&ref->new_oid);
 		if (!ref->deletion &&
-			!oidcmp(&ref->old_oid, &ref->new_oid)) {
+			oideq(&ref->old_oid, &ref->new_oid)) {
 			ref->status = REF_STATUS_UPTODATE;
 			continue;
 		}
@@ -2049,7 +2049,7 @@ struct ref *guess_remote_head(const struct ref *head,
 	/* If refs/heads/master could be right, it is. */
 	if (!all) {
 		r = find_ref_by_name(refs, "refs/heads/master");
-		if (r && !oidcmp(&r->old_oid, &head->old_oid))
+		if (r && oideq(&r->old_oid, &head->old_oid))
 			return copy_ref(r);
 	}
 
@@ -2057,7 +2057,7 @@ struct ref *guess_remote_head(const struct ref *head,
 	for (r = refs; r; r = r->next) {
 		if (r != head &&
 		    starts_with(r->name, "refs/heads/") &&
-		    !oidcmp(&r->old_oid, &head->old_oid)) {
+		    oideq(&r->old_oid, &head->old_oid)) {
 			*tail = copy_ref(r);
 			tail = &((*tail)->next);
 			if (!all)
diff --git a/revision.c b/revision.c
index de4dce600d..a2a569bb3b 100644
--- a/revision.c
+++ b/revision.c
@@ -3238,7 +3238,7 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 		struct commit_list *p;
 		for (p = revs->previous_parents; p; p = p->next)
 			if (p->item == NULL || /* first commit */
-			    !oidcmp(&p->item->object.oid, &commit->object.oid))
+			    oideq(&p->item->object.oid, &commit->object.oid))
 				break;
 		revs->linear = p != NULL;
 	}
diff --git a/sequencer.c b/sequencer.c
index 6a11f49651..66ed7c7b28 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -610,7 +610,7 @@ static int is_index_unchanged(void)
 	if (!(cache_tree_oid = get_cache_tree_oid()))
 		return -1;
 
-	return !oidcmp(cache_tree_oid, get_commit_tree_oid(head_commit));
+	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
 }
 
 static int write_author_script(const char *message)
@@ -1258,9 +1258,9 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		goto out;
 	}
 
-	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
-					      get_commit_tree_oid(current_head) :
-					      the_hash_algo->empty_tree, &tree)) {
+	if (!(flags & ALLOW_EMPTY) && oideq(current_head ?
+					    get_commit_tree_oid(current_head) :
+					    the_hash_algo->empty_tree, &tree)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
 	}
@@ -1365,7 +1365,7 @@ static int is_original_commit_empty(struct commit *commit)
 		ptree_oid = the_hash_algo->empty_tree; /* commit is root */
 	}
 
-	return !oidcmp(ptree_oid, get_commit_tree_oid(commit));
+	return oideq(ptree_oid, get_commit_tree_oid(commit));
 }
 
 /*
@@ -1645,7 +1645,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		unborn = get_oid("HEAD", &head);
 		/* Do we want to generate a root commit? */
 		if (is_pick_or_similar(command) && opts->have_squash_onto &&
-		    !oidcmp(&head, &opts->squash_onto)) {
+		    oideq(&head, &opts->squash_onto)) {
 			if (is_fixup(command))
 				return error(_("cannot fixup root commit"));
 			flags |= CREATE_ROOT_COMMIT;
@@ -1688,7 +1688,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			oid_to_hex(&commit->object.oid));
 
 	if (opts->allow_ff && !is_fixup(command) &&
-	    ((parent && !oidcmp(&parent->object.oid, &head)) ||
+	    ((parent && oideq(&parent->object.oid, &head)) ||
 	     (!parent && unborn))) {
 		if (is_rebase_i(opts))
 			write_author_script(msg.message);
@@ -2393,7 +2393,7 @@ static int rollback_is_safe(void)
 	if (get_oid("HEAD", &actual_head))
 		oidclr(&actual_head);
 
-	return !oidcmp(&actual_head, &expected_head);
+	return oideq(&actual_head, &expected_head);
 }
 
 static int reset_for_rollback(const struct object_id *oid)
@@ -2954,7 +2954,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	}
 
 	if (opts->have_squash_onto &&
-	    !oidcmp(&head_commit->object.oid, &opts->squash_onto)) {
+	    oideq(&head_commit->object.oid, &opts->squash_onto)) {
 		/*
 		 * When the user tells us to "merge" something into a
 		 * "[new root]", let's simply fast-forward to the merge head.
@@ -3023,8 +3023,8 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	 * commit, we cannot fast-forward.
 	 */
 	can_fast_forward = opts->allow_ff && commit && commit->parents &&
-		!oidcmp(&commit->parents->item->object.oid,
-			&head_commit->object.oid);
+		oideq(&commit->parents->item->object.oid,
+		      &head_commit->object.oid);
 
 	/*
 	 * If any merge head is different from the original one, we cannot
@@ -3102,8 +3102,8 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	write_message("no-ff", 5, git_path_merge_mode(the_repository), 0);
 
 	bases = get_merge_bases(head_commit, merge_commit);
-	if (bases && !oidcmp(&merge_commit->object.oid,
-			     &bases->item->object.oid)) {
+	if (bases && oideq(&merge_commit->object.oid,
+			   &bases->item->object.oid)) {
 		ret = 0;
 		/* skip merging an ancestor of HEAD */
 		goto leave_merge;
@@ -3349,9 +3349,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				 */
 				if (item->command == TODO_REWORD &&
 				    !get_oid("HEAD", &oid) &&
-				    (!oidcmp(&item->commit->object.oid, &oid) ||
+				    (oideq(&item->commit->object.oid, &oid) ||
 				     (opts->have_squash_onto &&
-				      !oidcmp(&opts->squash_onto, &oid))))
+				      oideq(&opts->squash_onto, &oid))))
 					to_amend = 1;
 
 				return res | error_with_patch(item->commit,
@@ -3578,7 +3578,7 @@ static int commit_staged_changes(struct replay_opts *opts,
 		 * the commit message and if there was a squash, let the user
 		 * edit it.
 		 */
-		if (is_clean && !oidcmp(&head, &to_amend) &&
+		if (is_clean && oideq(&head, &to_amend) &&
 		    opts->current_fixup_count > 0 &&
 		    file_exists(rebase_path_stopped_sha())) {
 			const char *p = opts->current_fixups.buf;
diff --git a/sha1-array.c b/sha1-array.c
index 265941fbf4..b94e0ec0f5 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -69,7 +69,7 @@ int oid_array_for_each_unique(struct oid_array *array,
 
 	for (i = 0; i < array->nr; i++) {
 		int ret;
-		if (i > 0 && !oidcmp(array->oid + i, array->oid + i - 1))
+		if (i > 0 && oideq(array->oid + i, array->oid + i - 1))
 			continue;
 		ret = fn(array->oid + i, data);
 		if (ret)
diff --git a/sha1-file.c b/sha1-file.c
index 97b7423848..71f49ee56d 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -149,10 +149,10 @@ static struct cached_object *find_cached_object(const struct object_id *oid)
 	struct cached_object *co = cached_objects;
 
 	for (i = 0; i < cached_object_nr; i++, co++) {
-		if (!oidcmp(&co->oid, oid))
+		if (oideq(&co->oid, oid))
 			return co;
 	}
-	if (!oidcmp(oid, the_hash_algo->empty_tree))
+	if (oideq(oid, the_hash_algo->empty_tree))
 		return &empty_tree;
 	return NULL;
 }
diff --git a/sha1-name.c b/sha1-name.c
index c9cc1318b7..a0c8451d55 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -44,7 +44,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 		oidcpy(&ds->candidate, current);
 		ds->candidate_exists = 1;
 		return;
-	} else if (!oidcmp(&ds->candidate, current)) {
+	} else if (oideq(&ds->candidate, current)) {
 		/* the same as what we already have seen */
 		return;
 	}
diff --git a/submodule.c b/submodule.c
index 50cbf5f13e..a2ce58e9e7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -536,7 +536,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 			fast_backward = 1;
 	}
 
-	if (!oidcmp(one, two)) {
+	if (oideq(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
diff --git a/transport.c b/transport.c
index 06ffea2774..1c76d64aba 100644
--- a/transport.c
+++ b/transport.c
@@ -1228,7 +1228,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 		nr_refs++;
 		if (rm->peer_ref &&
 		    !is_null_oid(&rm->old_oid) &&
-		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid))
+		    oideq(&rm->peer_ref->old_oid, &rm->old_oid))
 			continue;
 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
 		heads[nr_heads++] = rm;
diff --git a/unpack-trees.c b/unpack-trees.c
index f25089b878..4056a92d55 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -630,7 +630,7 @@ static int switch_cache_bottom(struct traverse_info *info)
 
 static inline int are_same_oid(struct name_entry *name_j, struct name_entry *name_k)
 {
-	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
+	return name_j->oid && name_k->oid && oideq(name_j->oid, name_k->oid);
 }
 
 static int traverse_trees_recursive(int n, unsigned long dirmask,
@@ -1484,7 +1484,7 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
 	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
 		return 0;
 	return a->ce_mode == b->ce_mode &&
-	       !oidcmp(&a->oid, &b->oid);
+	       oideq(&a->oid, &b->oid);
 }
 
 
@@ -1616,7 +1616,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!sub_head && !oidcmp(&oid, &ce->oid))
+		if (!sub_head && oideq(&oid, &ce->oid))
 			return 0;
 		return verify_clean_submodule(sub_head ? NULL : oid_to_hex(&oid),
 					      ce, error_type, o);
diff --git a/wt-status.c b/wt-status.c
index 5ffab61015..1c8746d0ea 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -453,8 +453,8 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			d->worktree_status = p->status;
 		if (S_ISGITLINK(p->two->mode)) {
 			d->dirty_submodule = p->two->dirty_submodule;
-			d->new_submodule_commits = !!oidcmp(&p->one->oid,
-							    &p->two->oid);
+			d->new_submodule_commits = !oideq(&p->one->oid,
+							  &p->two->oid);
 			if (s->status_format == STATUS_FORMAT_SHORT)
 				d->worktree_status = short_submodule_status(d);
 		}
@@ -1487,10 +1487,10 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 
 	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
 	    /* sha1 is a commit? match without further lookup */
-	    (!oidcmp(&cb.noid, &oid) ||
+	    (oideq(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
 	     ((commit = lookup_commit_reference_gently(the_repository, &oid, 1)) != NULL &&
-	      !oidcmp(&cb.noid, &commit->object.oid)))) {
+	      oideq(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
 			skip_prefix(from, "refs/remotes/", &from);
@@ -1500,7 +1500,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 			xstrdup(find_unique_abbrev(&cb.noid, DEFAULT_ABBREV));
 	oidcpy(&state->detached_oid, &cb.noid);
 	state->detached_at = !get_oid("HEAD", &oid) &&
-			     !oidcmp(&oid, &state->detached_oid);
+			     oideq(&oid, &state->detached_oid);
 
 	free(ref);
 	strbuf_release(&cb.buf);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index ec6e574e4a..e7af95db86 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -186,7 +186,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 	unsigned long size;
 	enum object_type type;
 
-	if (!oidcmp(oid, &null_oid)) {
+	if (oideq(oid, &null_oid)) {
 		ptr->ptr = xstrdup("");
 		ptr->size = 0;
 		return;
-- 
2.19.0.rc0.412.g7005db4e88

