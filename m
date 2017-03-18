Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD132095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdCRVWh (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:22:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46150 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751045AbdCRVWe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:22:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0E81A280BB;
        Sat, 18 Mar 2017 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872004;
        bh=oPIzC1KPY0va/3WFeA0Cbsi+HJD2pe3Q9BlnoU3zAbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwWpzOIXYOTm/MdsVRw2fBz8xx8B0+Aj8zj09KUHyYQlhNHf4NOf+9YsPDxYRsz0q
         mLijVTNxXARvyP69lfsVsPB0Fz4mfaWZiK/5DUwpzyD1z8jg227HGzXgKuwO1688XU
         8+Q3nkubh1guqK1N8+wG9KWCP5bqlbNiNRNlUGg9rSqldeoWaXBtH2hgsssFNY23Wr
         1H0Ep/O2WechDrvjvjSLV5EiN9iwuDonQkPbMQLGck9+5FUbirKkmeEgvltxhuJtkv
         zQbv7du4ibUW8vn4mSVCgnVq9QDecGvGgbSn1wp/b/hsoeVhieIRSPMFx4ZmztzKxa
         +UzQOliu6/jXdnAh5uMcGZ3EIsQdiIo9ZAksun7CrgVlzjy2avT6GIuNLDRxdk17HS
         Kk2SkMJJBFS4ChUZy9D9jy/vKbxEExY9B3CKdFFsgYWeoH86vGmhLndWnBTeYRaGg8
         XJAynx/zcWBG6EXKYUsQD1Z6S+GN3CYMSi2gl4I/4Qirn7PCz3C
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/20] sha1-array: convert internal storage for struct sha1_array to object_id
Date:   Sat, 18 Mar 2017 21:19:48 +0000
Message-Id: <20170318211954.564030-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the internal storage for struct sha1_array use an array of struct
object_id internally.  Update the users of this struct which inspect its
internals.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c               | 14 +++++++-------
 builtin/pull.c         | 22 +++++++++++-----------
 builtin/receive-pack.c |  4 ++--
 combine-diff.c         |  6 +++---
 fetch-pack.c           | 12 ++++++------
 fsck.c                 |  4 ++--
 remote-curl.c          |  2 +-
 send-pack.c            |  2 +-
 sha1-array.c           | 22 +++++++++++-----------
 sha1-array.h           |  2 +-
 shallow.c              | 26 +++++++++++++-------------
 11 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/bisect.c b/bisect.c
index 21c3e34636..ebaf7b05ba 100644
--- a/bisect.c
+++ b/bisect.c
@@ -457,7 +457,7 @@ static char *join_sha1_array_hex(struct sha1_array *array, char delim)
 	int i;
 
 	for (i = 0; i < array->nr; i++) {
-		strbuf_addstr(&joined_hexs, sha1_to_hex(array->sha1[i]));
+		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));
 		if (i + 1 < array->nr)
 			strbuf_addch(&joined_hexs, delim);
 	}
@@ -621,7 +621,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	argv_array_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
 	for (i = 0; i < good_revs.nr; i++)
 		argv_array_pushf(&rev_argv, good_format,
-				 sha1_to_hex(good_revs.sha1[i]));
+				 oid_to_hex(good_revs.oid + i));
 	argv_array_push(&rev_argv, "--");
 	if (read_paths)
 		read_bisect_paths(&rev_argv);
@@ -701,11 +701,11 @@ static int bisect_checkout(const unsigned char *bisect_rev, int no_checkout)
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
 }
 
-static struct commit *get_commit_reference(const unsigned char *sha1)
+static struct commit *get_commit_reference(const struct object_id *oid)
 {
-	struct commit *r = lookup_commit_reference(sha1);
+	struct commit *r = lookup_commit_reference(oid->hash);
 	if (!r)
-		die(_("Not a valid commit name %s"), sha1_to_hex(sha1));
+		die(_("Not a valid commit name %s"), oid_to_hex(oid));
 	return r;
 }
 
@@ -715,9 +715,9 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
 	int i, n = 0;
 
 	ALLOC_ARRAY(rev, 1 + good_revs.nr);
-	rev[n++] = get_commit_reference(current_bad_oid->hash);
+	rev[n++] = get_commit_reference(current_bad_oid);
 	for (i = 0; i < good_revs.nr; i++)
-		rev[n++] = get_commit_reference(good_revs.sha1[i]);
+		rev[n++] = get_commit_reference(good_revs.oid + i);
 	*rev_nr = n;
 
 	return rev;
diff --git a/builtin/pull.c b/builtin/pull.c
index 704ce1f042..c007900ab5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -514,7 +514,7 @@ static int run_fetch(const char *repo, const char **refspecs)
 /**
  * "Pulls into void" by branching off merge_head.
  */
-static int pull_into_void(const unsigned char *merge_head,
+static int pull_into_void(const struct object_id *merge_head,
 		const struct object_id *curr_head)
 {
 	/*
@@ -523,10 +523,10 @@ static int pull_into_void(const unsigned char *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head, 0))
+	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head->hash, 0))
 		return 1;
 
-	if (update_ref("initial pull", "HEAD", merge_head, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
+	if (update_ref("initial pull", "HEAD", merge_head->hash, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
 		return 1;
 
 	return 0;
@@ -693,13 +693,13 @@ static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,
  */
 static int get_octopus_merge_base(struct object_id *merge_base,
 		const struct object_id *curr_head,
-		const unsigned char *merge_head,
+		const struct object_id *merge_head,
 		const struct object_id *fork_point)
 {
 	struct commit_list *revs = NULL, *result;
 
 	commit_list_insert(lookup_commit_reference(curr_head->hash), &revs);
-	commit_list_insert(lookup_commit_reference(merge_head), &revs);
+	commit_list_insert(lookup_commit_reference(merge_head->hash), &revs);
 	if (!is_null_oid(fork_point))
 		commit_list_insert(lookup_commit_reference(fork_point->hash), &revs);
 
@@ -718,7 +718,7 @@ static int get_octopus_merge_base(struct object_id *merge_base,
  * appropriate arguments and returns its exit status.
  */
 static int run_rebase(const struct object_id *curr_head,
-		const unsigned char *merge_head,
+		const struct object_id *merge_head,
 		const struct object_id *fork_point)
 {
 	int ret;
@@ -754,12 +754,12 @@ static int run_rebase(const struct object_id *curr_head,
 		warning(_("ignoring --verify-signatures for rebase"));
 
 	argv_array_push(&args, "--onto");
-	argv_array_push(&args, sha1_to_hex(merge_head));
+	argv_array_push(&args, oid_to_hex(merge_head));
 
 	if (fork_point && !is_null_oid(fork_point))
 		argv_array_push(&args, oid_to_hex(fork_point));
 	else
-		argv_array_push(&args, sha1_to_hex(merge_head));
+		argv_array_push(&args, oid_to_hex(merge_head));
 
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
@@ -856,7 +856,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (is_null_oid(&orig_head)) {
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
-		return pull_into_void(*merge_heads.sha1, &curr_head);
+		return pull_into_void(merge_heads.oid, &curr_head);
 	}
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
@@ -867,13 +867,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		head = lookup_commit_reference(orig_head.hash);
 		commit_list_insert(head, &list);
-		merge_head = lookup_commit_reference(merge_heads.sha1[0]);
+		merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
 		if (is_descendant_of(merge_head, list)) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
 			return run_merge();
 		}
-		return run_rebase(&curr_head, *merge_heads.sha1, &rebase_fork_point);
+		return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
 	} else {
 		return run_merge();
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b1aef26443..7dfbb5f46b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -842,7 +842,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		if (si->used_shallow[i] &&
 		    (si->used_shallow[i][cmd->index / 32] & mask) &&
 		    !delayed_reachability_test(si, i))
-			sha1_array_append(&extra, si->shallow->sha1[i]);
+			sha1_array_append(&extra, si->shallow->oid[i].hash);
 
 	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
@@ -859,7 +859,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	 * not lose these new roots..
 	 */
 	for (i = 0; i < extra.nr; i++)
-		register_shallow(extra.sha1[i]);
+		register_shallow(extra.oid[i].hash);
 
 	si->shallow_ref[cmd->index] = 0;
 	sha1_array_clear(&extra);
diff --git a/combine-diff.c b/combine-diff.c
index 59501db99a..a5b86d7eb9 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1335,7 +1335,7 @@ static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
 			opt->output_format = stat_opt;
 		else
 			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_tree_sha1(parents->sha1[i], sha1, "", opt);
+		diff_tree_sha1(parents->oid[i].hash, sha1, "", opt);
 		diffcore_std(opt);
 		paths = intersect_paths(paths, i, num_parent);
 
@@ -1369,7 +1369,7 @@ static struct combine_diff_path *find_paths_multitree(
 
 	ALLOC_ARRAY(parents_sha1, nparent);
 	for (i = 0; i < nparent; i++)
-		parents_sha1[i] = parents->sha1[i];
+		parents_sha1[i] = parents->oid[i].hash;
 
 	/* fake list head, so worker can assume it is non-NULL */
 	paths_head.next = NULL;
@@ -1462,7 +1462,7 @@ void diff_tree_combined(const unsigned char *sha1,
 		if (stat_opt) {
 			diffopts.output_format = stat_opt;
 
-			diff_tree_sha1(parents->sha1[0], sha1, "", &diffopts);
+			diff_tree_sha1(parents->oid[0].hash, sha1, "", &diffopts);
 			diffcore_std(&diffopts);
 			if (opt->orderfile)
 				diffcore_order(opt->orderfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce30..543e8aa9e1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1039,10 +1039,10 @@ static void update_shallow(struct fetch_pack_args *args,
 		 * after get_pack() and reprepare_packed_git())
 		 */
 		struct sha1_array extra = SHA1_ARRAY_INIT;
-		unsigned char (*sha1)[20] = si->shallow->sha1;
+		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
-			if (has_sha1_file(sha1[i]))
-				sha1_array_append(&extra, sha1[i]);
+			if (has_object_file(&oid[i]))
+				sha1_array_append(&extra, oid[i].hash);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
 						&alternate_shallow_file,
@@ -1071,16 +1071,16 @@ static void update_shallow(struct fetch_pack_args *args,
 		 * refs.
 		 */
 		struct sha1_array extra = SHA1_ARRAY_INIT;
-		unsigned char (*sha1)[20] = si->shallow->sha1;
+		struct object_id *oid = si->shallow->oid;
 		assign_shallow_commits_to_refs(si, NULL, NULL);
 		if (!si->nr_ours && !si->nr_theirs) {
 			sha1_array_clear(&ref);
 			return;
 		}
 		for (i = 0; i < si->nr_ours; i++)
-			sha1_array_append(&extra, sha1[si->ours[i]]);
+			sha1_array_append(&extra, oid[si->ours[i]].hash);
 		for (i = 0; i < si->nr_theirs; i++)
-			sha1_array_append(&extra, sha1[si->theirs[i]]);
+			sha1_array_append(&extra, oid[si->theirs[i]].hash);
 		setup_alternate_shallow(&shallow_lock,
 					&alternate_shallow_file,
 					&extra);
diff --git a/fsck.c b/fsck.c
index aff4ae6fd4..8f41e692bb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -158,8 +158,8 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 			die("Invalid SHA-1: %s", buffer);
 		sha1_array_append(&skiplist, oid.hash);
 		if (sorted && skiplist.nr > 1 &&
-				hashcmp(skiplist.sha1[skiplist.nr - 2],
-					oid.hash) > 0)
+				oidcmp(&skiplist.oid[skiplist.nr - 2],
+				       &oid) > 0)
 			sorted = 0;
 	}
 	close(fd);
diff --git a/remote-curl.c b/remote-curl.c
index 34a97e7328..5e712e4aa1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -230,7 +230,7 @@ static void free_discovery(struct discovery *d)
 	if (d) {
 		if (d == last_discovery)
 			last_discovery = NULL;
-		free(d->shallow.sha1);
+		free(d->shallow.oid);
 		free(d->buf_alloc);
 		free_refs(d->refs);
 		free(d);
diff --git a/send-pack.c b/send-pack.c
index d2d2a49a02..b3040391cd 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -98,7 +98,7 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 	 */
 	po_in = xfdopen(po.in, "w");
 	for (i = 0; i < extra->nr; i++)
-		feed_object(extra->sha1[i], po_in, 1);
+		feed_object(extra->oid[i].hash, po_in, 1);
 
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
diff --git a/sha1-array.c b/sha1-array.c
index c1cc25cd95..093d158003 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -4,39 +4,39 @@
 
 void sha1_array_append(struct sha1_array *array, const unsigned char *sha1)
 {
-	ALLOC_GROW(array->sha1, array->nr + 1, array->alloc);
-	hashcpy(array->sha1[array->nr++], sha1);
+	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
+	hashcpy(array->oid[array->nr++].hash, sha1);
 	array->sorted = 0;
 }
 
 static int void_hashcmp(const void *a, const void *b)
 {
-	return hashcmp(a, b);
+	return oidcmp(a, b);
 }
 
 static void sha1_array_sort(struct sha1_array *array)
 {
-	QSORT(array->sha1, array->nr, void_hashcmp);
+	QSORT(array->oid, array->nr, void_hashcmp);
 	array->sorted = 1;
 }
 
 static const unsigned char *sha1_access(size_t index, void *table)
 {
-	unsigned char (*array)[20] = table;
-	return array[index];
+	struct object_id *array = table;
+	return array[index].hash;
 }
 
 int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1)
 {
 	if (!array->sorted)
 		sha1_array_sort(array);
-	return sha1_pos(sha1, array->sha1, array->nr, sha1_access);
+	return sha1_pos(sha1, array->oid, array->nr, sha1_access);
 }
 
 void sha1_array_clear(struct sha1_array *array)
 {
-	free(array->sha1);
-	array->sha1 = NULL;
+	free(array->oid);
+	array->oid = NULL;
 	array->nr = 0;
 	array->alloc = 0;
 	array->sorted = 0;
@@ -53,9 +53,9 @@ int sha1_array_for_each_unique(struct sha1_array *array,
 
 	for (i = 0; i < array->nr; i++) {
 		int ret;
-		if (i > 0 && !hashcmp(array->sha1[i], array->sha1[i-1]))
+		if (i > 0 && !oidcmp(array->oid + i, array->oid + i - 1))
 			continue;
-		ret = fn(array->sha1[i], data);
+		ret = fn(array->oid[i].hash, data);
 		if (ret)
 			return ret;
 	}
diff --git a/sha1-array.h b/sha1-array.h
index b3230be0dd..c1f706acba 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -2,7 +2,7 @@
 #define SHA1_ARRAY_H
 
 struct sha1_array {
-	unsigned char (*sha1)[20];
+	struct object_id *oid;
 	int nr;
 	int alloc;
 	int sorted;
diff --git a/shallow.c b/shallow.c
index 11f7dde9d9..dc7b67a294 100644
--- a/shallow.c
+++ b/shallow.c
@@ -273,7 +273,7 @@ static int write_shallow_commits_1(struct strbuf *out, int use_pack_protocol,
 	if (!extra)
 		return data.count;
 	for (i = 0; i < extra->nr; i++) {
-		strbuf_addstr(out, sha1_to_hex(extra->sha1[i]));
+		strbuf_addstr(out, oid_to_hex(extra->oid + i));
 		strbuf_addch(out, '\n');
 		data.count++;
 	}
@@ -396,9 +396,9 @@ void prepare_shallow_info(struct shallow_info *info, struct sha1_array *sa)
 	ALLOC_ARRAY(info->ours, sa->nr);
 	ALLOC_ARRAY(info->theirs, sa->nr);
 	for (i = 0; i < sa->nr; i++) {
-		if (has_sha1_file(sa->sha1[i])) {
+		if (has_object_file(sa->oid + i)) {
 			struct commit_graft *graft;
-			graft = lookup_commit_graft(sa->sha1[i]);
+			graft = lookup_commit_graft(sa->oid[i].hash);
 			if (graft && graft->nr_parent < 0)
 				continue;
 			info->ours[info->nr_ours++] = i;
@@ -417,13 +417,13 @@ void clear_shallow_info(struct shallow_info *info)
 
 void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 {
-	unsigned char (*sha1)[20] = info->shallow->sha1;
+	struct object_id *oid = info->shallow->oid;
 	int i, dst;
 	trace_printf_key(&trace_shallow, "shallow: remove_nonexistent_theirs_shallow\n");
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		if (has_sha1_file(sha1[info->theirs[i]]))
+		if (has_object_file(oid + info->theirs[i]))
 			dst++;
 	}
 	info->nr_theirs = dst;
@@ -559,7 +559,7 @@ static void post_assign_shallow(struct shallow_info *info,
 void assign_shallow_commits_to_refs(struct shallow_info *info,
 				    uint32_t **used, int *ref_status)
 {
-	unsigned char (*sha1)[20] = info->shallow->sha1;
+	struct object_id *oid = info->shallow->oid;
 	struct sha1_array *ref = info->ref;
 	unsigned int i, nr;
 	int *shallow, nr_shallow = 0;
@@ -599,18 +599,18 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
-		struct commit *c = lookup_commit(sha1[shallow[i]]);
+		struct commit *c = lookup_commit(oid[shallow[i]].hash);
 		c->object.flags |= BOTTOM;
 	}
 
 	for (i = 0; i < ref->nr; i++)
-		paint_down(&pi, ref->sha1[i], i);
+		paint_down(&pi, ref->oid[i].hash, i);
 
 	if (used) {
 		int bitmap_size = ((pi.nr_bits + 31) / 32) * sizeof(uint32_t);
 		memset(used, 0, sizeof(*used) * info->shallow->nr);
 		for (i = 0; i < nr_shallow; i++) {
-			const struct commit *c = lookup_commit(sha1[shallow[i]]);
+			const struct commit *c = lookup_commit(oid[shallow[i]].hash);
 			uint32_t **map = ref_bitmap_at(&pi.ref_bitmap, c);
 			if (*map)
 				used[shallow[i]] = xmemdupz(*map, bitmap_size);
@@ -664,7 +664,7 @@ static void post_assign_shallow(struct shallow_info *info,
 				struct ref_bitmap *ref_bitmap,
 				int *ref_status)
 {
-	unsigned char (*sha1)[20] = info->shallow->sha1;
+	struct object_id *oid = info->shallow->oid;
 	struct commit *c;
 	uint32_t **bitmap;
 	int dst, i, j;
@@ -679,7 +679,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		c = lookup_commit(sha1[info->theirs[i]]);
+		c = lookup_commit(oid[info->theirs[i]].hash);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -700,7 +700,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_ours; i++) {
 		if (i != dst)
 			info->ours[dst] = info->ours[i];
-		c = lookup_commit(sha1[info->ours[i]]);
+		c = lookup_commit(oid[info->ours[i]].hash);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -722,7 +722,7 @@ static void post_assign_shallow(struct shallow_info *info,
 int delayed_reachability_test(struct shallow_info *si, int c)
 {
 	if (si->need_reachability_test[c]) {
-		struct commit *commit = lookup_commit(si->shallow->sha1[c]);
+		struct commit *commit = lookup_commit(si->shallow->oid[c].hash);
 
 		if (!si->commits) {
 			struct commit_array ca;
