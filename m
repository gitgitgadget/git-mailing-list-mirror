From: Jeff King <peff@peff.net>
Subject: [PATCH v3 08/22] convert trivial cases to ALLOC_ARRAY
Date: Mon, 22 Feb 2016 17:44:25 -0500
Message-ID: <20160222224425.GH10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:44:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzDV-00051t-JE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbcBVWo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:44:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:47074 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756015AbcBVWo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:44:27 -0500
Received: (qmail 21670 invoked by uid 102); 22 Feb 2016 22:44:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:27 -0500
Received: (qmail 23045 invoked by uid 107); 22 Feb 2016 22:44:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:25 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286979>

Each of these cases can be converted to use ALLOC_ARRAY or
REALLOC_ARRAY, which has two advantages:

  1. It automatically checks the array-size multiplication
     for overflow.

  2. It always uses sizeof(*array) for the element-size,
     so that it can never go out of sync with the declared
     type of the array.

Signed-off-by: Jeff King <peff@peff.net>
---
 alias.c                  |  2 +-
 attr.c                   |  2 +-
 bisect.c                 |  4 ++--
 builtin/blame.c          |  3 ++-
 builtin/clean.c          |  2 +-
 builtin/fast-export.c    |  2 +-
 builtin/index-pack.c     |  4 ++--
 builtin/merge-base.c     |  2 +-
 builtin/mv.c             |  3 ++-
 builtin/pack-objects.c   |  7 ++++---
 builtin/pack-redundant.c |  2 +-
 builtin/receive-pack.c   |  5 ++---
 column.c                 |  2 +-
 combine-diff.c           |  4 ++--
 commit.c                 |  2 +-
 compat/mingw.c           |  6 +++---
 diffcore-order.c         |  4 ++--
 dir.c                    |  6 +++---
 fast-import.c            |  5 +++--
 fsck.c                   |  3 ++-
 graph.c                  | 10 ++++------
 khash.h                  |  2 +-
 levenshtein.c            |  8 +++++---
 line-log.c               |  8 ++++----
 notes.c                  |  2 +-
 pack-check.c             |  2 +-
 pack-revindex.c          | 12 ++++++++----
 pathspec.c               |  5 +++--
 remote-curl.c            |  3 ++-
 sha1_file.c              |  4 ++--
 shallow.c                |  6 +++---
 show-index.c             |  3 ++-
 transport.c              |  2 +-
 xdiff-interface.c        |  2 +-
 34 files changed, 75 insertions(+), 64 deletions(-)

diff --git a/alias.c b/alias.c
index a11229d..3b90397 100644
--- a/alias.c
+++ b/alias.c
@@ -23,7 +23,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 	int src, dst, count = 0, size = 16;
 	char quoted = 0;
 
-	*argv = xmalloc(sizeof(**argv) * size);
+	ALLOC_ARRAY(*argv, size);
 
 	/* split alias_string */
 	(*argv)[count++] = cmdline;
diff --git a/attr.c b/attr.c
index 086c08d..c83ec49 100644
--- a/attr.c
+++ b/attr.c
@@ -799,7 +799,7 @@ int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
 			++count;
 	}
 	*num = count;
-	*check = xmalloc(sizeof(**check) * count);
+	ALLOC_ARRAY(*check, count);
 	j = 0;
 	for (i = 0; i < attr_nr; i++) {
 		const char *value = check_all_attr[i].value;
diff --git a/bisect.c b/bisect.c
index 06ec54e..7996c29 100644
--- a/bisect.c
+++ b/bisect.c
@@ -708,10 +708,10 @@ static struct commit *get_commit_reference(const unsigned char *sha1)
 
 static struct commit **get_bad_and_good_commits(int *rev_nr)
 {
-	int len = 1 + good_revs.nr;
-	struct commit **rev = xmalloc(len * sizeof(*rev));
+	struct commit **rev;
 	int i, n = 0;
 
+	ALLOC_ARRAY(rev, 1 + good_revs.nr);
 	rev[n++] = get_commit_reference(current_bad_oid->hash);
 	for (i = 0; i < good_revs.nr; i++)
 		rev[n++] = get_commit_reference(good_revs.sha1[i]);
diff --git a/builtin/blame.c b/builtin/blame.c
index 55bf5fa..b4ed462 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2059,7 +2059,8 @@ static int prepare_lines(struct scoreboard *sb)
 	for (p = buf; p < end; p = get_next_line(p, end))
 		num++;
 
-	sb->lineno = lineno = xmalloc(sizeof(*sb->lineno) * (num + 1));
+	ALLOC_ARRAY(sb->lineno, num + 1);
+	lineno = sb->lineno;
 
 	for (p = buf; p < end; p = get_next_line(p, end))
 		*lineno++ = p - buf;
diff --git a/builtin/clean.c b/builtin/clean.c
index 7b08237..8229f7e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -543,7 +543,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 	int eof = 0;
 	int i;
 
-	chosen = xmalloc(sizeof(int) * stuff->nr);
+	ALLOC_ARRAY(chosen, stuff->nr);
 	/* set chosen as uninitialized */
 	for (i = 0; i < stuff->nr; i++)
 		chosen[i] = -1;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2471297..8164b58 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1021,7 +1021,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		const char **refspecs_str;
 		int i;
 
-		refspecs_str = xmalloc(sizeof(*refspecs_str) * refspecs_list.nr);
+		ALLOC_ARRAY(refspecs_str, refspecs_list.nr);
 		for (i = 0; i < refspecs_list.nr; i++)
 			refspecs_str[i] = refspecs_list.items[i].string;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6a01509..a60bcfa 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1346,7 +1346,7 @@ static void fix_unresolved_deltas(struct sha1file *f)
 	 * before deltas depending on them, a good heuristic is to start
 	 * resolving deltas in the same order as their position in the pack.
 	 */
-	sorted_by_pos = xmalloc(nr_ref_deltas * sizeof(*sorted_by_pos));
+	ALLOC_ARRAY(sorted_by_pos, nr_ref_deltas);
 	for (i = 0; i < nr_ref_deltas; i++)
 		sorted_by_pos[i] = &ref_deltas[i];
 	qsort(sorted_by_pos, nr_ref_deltas, sizeof(*sorted_by_pos), delta_pos_compare);
@@ -1759,7 +1759,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (show_stat)
 		show_pack_info(stat_only);
 
-	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
+	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
 	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_sha1);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a891162..c0d1822 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -252,7 +252,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	if (argc < 2)
 		usage_with_options(merge_base_usage, options);
 
-	rev = xmalloc(argc * sizeof(*rev));
+	ALLOC_ARRAY(rev, argc);
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
 	return show_merge_base(rev, rev_nr, show_all);
diff --git a/builtin/mv.c b/builtin/mv.c
index d1d4316..9a9813a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -24,7 +24,8 @@ static const char **internal_copy_pathspec(const char *prefix,
 					   int count, unsigned flags)
 {
 	int i;
-	const char **result = xmalloc((count + 1) * sizeof(const char *));
+	const char **result;
+	ALLOC_ARRAY(result, count + 1);
 	memcpy(result, pathspec, count * sizeof(const char *));
 	result[count] = NULL;
 	for (i = 0; i < count; i++) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4dae5b1..b4f1fa6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -624,7 +624,7 @@ static struct object_entry **compute_write_order(void)
 {
 	unsigned int i, wo_end, last_untagged;
 
-	struct object_entry **wo = xmalloc(to_pack.nr_objects * sizeof(*wo));
+	struct object_entry **wo;
 	struct object_entry *objects = to_pack.objects;
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
@@ -657,6 +657,7 @@ static struct object_entry **compute_write_order(void)
 	 * Give the objects in the original recency order until
 	 * we see a tagged tip.
 	 */
+	ALLOC_ARRAY(wo, to_pack.nr_objects);
 	for (i = wo_end = 0; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
 			break;
@@ -769,7 +770,7 @@ static void write_pack_file(void)
 
 	if (progress > pack_to_stdout)
 		progress_state = start_progress(_("Writing objects"), nr_result);
-	written_list = xmalloc(to_pack.nr_objects * sizeof(*written_list));
+	ALLOC_ARRAY(written_list, to_pack.nr_objects);
 	write_order = compute_write_order();
 
 	do {
@@ -2129,7 +2130,7 @@ static void prepare_pack(int window, int depth)
 	if (!to_pack.nr_objects || !window || !depth)
 		return;
 
-	delta_list = xmalloc(to_pack.nr_objects * sizeof(*delta_list));
+	ALLOC_ARRAY(delta_list, to_pack.nr_objects);
 	nr_deltas = n = 0;
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index d0532f6..72c8158 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -53,7 +53,7 @@ static inline struct llist_item *llist_item_get(void)
 		free_nodes = free_nodes->next;
 	} else {
 		int i = 1;
-		new = xmalloc(sizeof(struct llist_item) * BLKSIZE);
+		ALLOC_ARRAY(new, BLKSIZE);
 		for (; i < BLKSIZE; i++)
 			llist_item_put(&new[i]);
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 932afab..3dc3868 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1591,8 +1591,7 @@ static void prepare_shallow_update(struct command *commands,
 {
 	int i, j, k, bitmap_size = (si->ref->nr + 31) / 32;
 
-	si->used_shallow = xmalloc(sizeof(*si->used_shallow) *
-				   si->shallow->nr);
+	ALLOC_ARRAY(si->used_shallow, si->shallow->nr);
 	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
 
 	si->need_reachability_test =
@@ -1658,7 +1657,7 @@ static void update_shallow_info(struct command *commands,
 		return;
 	}
 
-	ref_status = xmalloc(sizeof(*ref_status) * ref->nr);
+	ALLOC_ARRAY(ref_status, ref->nr);
 	assign_shallow_commits_to_refs(si, NULL, ref_status);
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (is_null_sha1(cmd->new_sha1))
diff --git a/column.c b/column.c
index 786abe6..f9fda68 100644
--- a/column.c
+++ b/column.c
@@ -164,7 +164,7 @@ static void display_table(const struct string_list *list,
 	data.colopts = colopts;
 	data.opts = *opts;
 
-	data.len = xmalloc(sizeof(*data.len) * list->nr);
+	ALLOC_ARRAY(data.len, list->nr);
 	for (i = 0; i < list->nr; i++)
 		data.len[i] = item_length(colopts, list->items[i].string);
 
diff --git a/combine-diff.c b/combine-diff.c
index 5571304..a698016 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1372,7 +1372,7 @@ static struct combine_diff_path *find_paths_multitree(
 	struct combine_diff_path paths_head;
 	struct strbuf base;
 
-	parents_sha1 = xmalloc(nparent * sizeof(parents_sha1[0]));
+	ALLOC_ARRAY(parents_sha1, nparent);
 	for (i = 0; i < nparent; i++)
 		parents_sha1[i] = parents->sha1[i];
 
@@ -1483,7 +1483,7 @@ void diff_tree_combined(const unsigned char *sha1,
 	if (opt->orderfile && num_paths) {
 		struct obj_order *o;
 
-		o = xmalloc(sizeof(*o) * num_paths);
+		ALLOC_ARRAY(o, num_paths);
 		for (i = 0, p = paths; p; p = p->next, i++)
 			o[i].obj = p;
 		order_objects(opt->orderfile, path_path, o, num_paths);
diff --git a/commit.c b/commit.c
index 40388d7..31cd91f 100644
--- a/commit.c
+++ b/commit.c
@@ -903,7 +903,7 @@ static int remove_redundant(struct commit **array, int cnt)
 
 	work = xcalloc(cnt, sizeof(*work));
 	redundant = xcalloc(cnt, 1);
-	filled_index = xmalloc(sizeof(*filled_index) * (cnt - 1));
+	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
 		parse_commit(array[i]);
diff --git a/compat/mingw.c b/compat/mingw.c
index fbe69b8..7803f30 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -893,7 +893,7 @@ static char **get_path_split(void)
 	if (!n)
 		return NULL;
 
-	path = xmalloc((n+1)*sizeof(char *));
+	ALLOC_ARRAY(path, n + 1);
 	p = envpath;
 	i = 0;
 	do {
@@ -978,7 +978,7 @@ static wchar_t *make_environment_block(char **deltaenv)
 		i++;
 
 	/* copy the environment, leaving space for changes */
-	tmpenv = xmalloc((size + i) * sizeof(char*));
+	ALLOC_ARRAY(tmpenv, size + i);
 	memcpy(tmpenv, environ, size * sizeof(char*));
 
 	/* merge supplied environment changes into the temporary environment */
@@ -1168,7 +1168,7 @@ static int try_shell_exec(const char *cmd, char *const *argv)
 		int argc = 0;
 		const char **argv2;
 		while (argv[argc]) argc++;
-		argv2 = xmalloc(sizeof(*argv) * (argc+1));
+		ALLOC_ARRAY(argv2, argc + 1);
 		argv2[0] = (char *)cmd;	/* full path to the script file */
 		memcpy(&argv2[1], &argv[1], sizeof(*argv) * argc);
 		pid = mingw_spawnv(prog, argv2, 1);
diff --git a/diffcore-order.c b/diffcore-order.c
index 97dd3d0..69d41f7 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -52,7 +52,7 @@ static void prepare_order(const char *orderfile)
 		}
 		if (pass == 0) {
 			order_cnt = cnt;
-			order = xmalloc(sizeof(*order) * cnt);
+			ALLOC_ARRAY(order, cnt);
 		}
 	}
 }
@@ -120,7 +120,7 @@ void diffcore_order(const char *orderfile)
 	if (!q->nr)
 		return;
 
-	o = xmalloc(sizeof(*o) * q->nr);
+	ALLOC_ARRAY(o, q->nr);
 	for (i = 0; i < q->nr; i++)
 		o[i].obj = q->queue[i];
 	order_objects(orderfile, pair_pathtwo, o, q->nr);
diff --git a/dir.c b/dir.c
index f0b6d0a..66c93c1 100644
--- a/dir.c
+++ b/dir.c
@@ -2484,14 +2484,14 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	ud.untracked_alloc = value;
 	ud.untracked_nr	   = value;
 	if (ud.untracked_nr)
-		ud.untracked = xmalloc(sizeof(*ud.untracked) * ud.untracked_nr);
+		ALLOC_ARRAY(ud.untracked, ud.untracked_nr);
 	data = next;
 
 	next = data;
 	ud.dirs_alloc = ud.dirs_nr = decode_varint(&next);
 	if (next > end)
 		return -1;
-	ud.dirs = xmalloc(sizeof(*ud.dirs) * ud.dirs_nr);
+	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
 	data = next;
 
 	len = strlen((const char *)data);
@@ -2611,7 +2611,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	rd.data	      = next;
 	rd.end	      = end;
 	rd.index      = 0;
-	rd.ucd        = xmalloc(sizeof(*rd.ucd) * len);
+	ALLOC_ARRAY(rd.ucd, len);
 
 	if (read_one_dir(&uc->root, &rd) || rd.index != len)
 		goto done;
diff --git a/fast-import.c b/fast-import.c
index bf01b34..a6467cb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -814,7 +814,8 @@ static struct tree_entry *new_tree_entry(void)
 	if (!avail_tree_entry) {
 		unsigned int n = tree_entry_alloc;
 		total_allocd += n * sizeof(struct tree_entry);
-		avail_tree_entry = e = xmalloc(n * sizeof(struct tree_entry));
+		ALLOC_ARRAY(e, n);
+		avail_tree_entry = e;
 		while (n-- > 1) {
 			*((void**)e) = e + 1;
 			e++;
@@ -898,7 +899,7 @@ static const char *create_index(void)
 	struct object_entry_pool *o;
 
 	/* Build the table of object IDs. */
-	idx = xmalloc(object_count * sizeof(*idx));
+	ALLOC_ARRAY(idx, object_count);
 	c = idx;
 	for (o = blocks; o; o = o->next_pool)
 		for (e = o->next_free; e-- != o->entries;)
diff --git a/fsck.c b/fsck.c
index c637f66..ca4c685 100644
--- a/fsck.c
+++ b/fsck.c
@@ -199,7 +199,8 @@ void fsck_set_msg_type(struct fsck_options *options,
 
 	if (!options->msg_type) {
 		int i;
-		int *msg_type = xmalloc(sizeof(int) * FSCK_MSG_MAX);
+		int *msg_type;
+		ALLOC_ARRAY(msg_type, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
 			msg_type[i] = fsck_msg_type(i, options);
 		options->msg_type = msg_type;
diff --git a/graph.c b/graph.c
index c25a09a..1350bdd 100644
--- a/graph.c
+++ b/graph.c
@@ -234,12 +234,10 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 * We'll automatically grow columns later if we need more room.
 	 */
 	graph->column_capacity = 30;
-	graph->columns = xmalloc(sizeof(struct column) *
-				 graph->column_capacity);
-	graph->new_columns = xmalloc(sizeof(struct column) *
-				     graph->column_capacity);
-	graph->mapping = xmalloc(sizeof(int) * 2 * graph->column_capacity);
-	graph->new_mapping = xmalloc(sizeof(int) * 2 * graph->column_capacity);
+	ALLOC_ARRAY(graph->columns, graph->column_capacity);
+	ALLOC_ARRAY(graph->new_columns, graph->column_capacity);
+	ALLOC_ARRAY(graph->mapping, 2 * graph->column_capacity);
+	ALLOC_ARRAY(graph->new_mapping, 2 * graph->column_capacity);
 
 	/*
 	 * The diff output prefix callback, with this we can make
diff --git a/khash.h b/khash.h
index 376475a..c0da40d 100644
--- a/khash.h
+++ b/khash.h
@@ -117,7 +117,7 @@ static const double __ac_HASH_UPPER = 0.77;
 			if (new_n_buckets < 4) new_n_buckets = 4;					\
 			if (h->size >= (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j = 0;	/* requested size is too small */ \
 			else { /* hash table size to be changed (shrink or expand); rehash */ \
-				new_flags = (khint32_t*)xmalloc(__ac_fsize(new_n_buckets) * sizeof(khint32_t));	\
+				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
 				if (!new_flags) return -1;								\
 				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)); \
 				if (h->n_buckets < new_n_buckets) {	/* expand */		\
diff --git a/levenshtein.c b/levenshtein.c
index fc28159..d263269 100644
--- a/levenshtein.c
+++ b/levenshtein.c
@@ -42,11 +42,13 @@ int levenshtein(const char *string1, const char *string2,
 		int w, int s, int a, int d)
 {
 	int len1 = strlen(string1), len2 = strlen(string2);
-	int *row0 = xmalloc(sizeof(int) * (len2 + 1));
-	int *row1 = xmalloc(sizeof(int) * (len2 + 1));
-	int *row2 = xmalloc(sizeof(int) * (len2 + 1));
+	int *row0, *row1, *row2;
 	int i, j;
 
+	ALLOC_ARRAY(row0, len2 + 1);
+	ALLOC_ARRAY(row1, len2 + 1);
+	ALLOC_ARRAY(row2, len2 + 1);
+
 	for (j = 0; j <= len2; j++)
 		row1[j] = j * a;
 	for (i = 0; i < len1; i++) {
diff --git a/line-log.c b/line-log.c
index 5877986..bbe31ed 100644
--- a/line-log.c
+++ b/line-log.c
@@ -522,7 +522,7 @@ static void fill_line_ends(struct diff_filespec *spec, long *lines,
 	if (diff_populate_filespec(spec, 0))
 		die("Cannot read blob %s", sha1_to_hex(spec->sha1));
 
-	ends = xmalloc(size * sizeof(*ends));
+	ALLOC_ARRAY(ends, size);
 	ends[cur++] = 0;
 	data = spec->data;
 	while (num < spec->size) {
@@ -1142,9 +1142,9 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	if (nparents > 1 && rev->first_parent_only)
 		nparents = 1;
 
-	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
-	cand = xmalloc(nparents * sizeof(*cand));
-	parents = xmalloc(nparents * sizeof(*parents));
+	ALLOC_ARRAY(diffqueues, nparents);
+	ALLOC_ARRAY(cand, nparents);
+	ALLOC_ARRAY(parents, nparents);
 
 	p = commit->parents;
 	for (i = 0; i < nparents; i++) {
diff --git a/notes.c b/notes.c
index c1e5035..88cf474 100644
--- a/notes.c
+++ b/notes.c
@@ -1035,7 +1035,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
 	struct string_list_item *item;
 	int counter = 0;
 	struct notes_tree **trees;
-	trees = xmalloc((refs->nr+1) * sizeof(struct notes_tree *));
+	ALLOC_ARRAY(trees, refs->nr + 1);
 	for_each_string_list_item(item, refs) {
 		struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
 		init_notes(t, item->string, combine_notes_ignore, flags);
diff --git a/pack-check.c b/pack-check.c
index 433bd86..1da89a4 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -89,7 +89,7 @@ static int verify_packfile(struct packed_git *p,
 	 * we do not do scan-streaming check on the pack file.
 	 */
 	nr_objects = p->num_objects;
-	entries = xmalloc((nr_objects + 1) * sizeof(*entries));
+	ALLOC_ARRAY(entries, nr_objects + 1);
 	entries[nr_objects].offset = pack_sig_ofs;
 	/* first sort entries by pack offset, since unpacking them is more efficient that way */
 	for (i = 0; i < nr_objects; i++) {
diff --git a/pack-revindex.c b/pack-revindex.c
index 155a8a3..96d51c3 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -44,10 +44,14 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 	 * keep track of them with alias pointers, always sorting from "from"
 	 * to "to".
 	 */
-	struct revindex_entry *tmp = xmalloc(n * sizeof(*tmp));
-	struct revindex_entry *from = entries, *to = tmp;
+	struct revindex_entry *tmp, *from, *to;
 	int bits;
-	unsigned *pos = xmalloc(BUCKETS * sizeof(*pos));
+	unsigned *pos;
+
+	ALLOC_ARRAY(pos, BUCKETS);
+	ALLOC_ARRAY(tmp, n);
+	from = entries;
+	to = tmp;
 
 	/*
 	 * If (max >> bits) is zero, then we know that the radix digit we are
@@ -121,7 +125,7 @@ static void create_pack_revindex(struct packed_git *p)
 	unsigned i;
 	const char *index = p->index_data;
 
-	p->revindex = xmalloc(sizeof(*p->revindex) * (num_ent + 1));
+	ALLOC_ARRAY(p->revindex, num_ent + 1);
 	index += 4 * 256;
 
 	if (p->index_version > 1) {
diff --git a/pathspec.c b/pathspec.c
index 9304ee3..c9e9b6c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -406,7 +406,8 @@ void parse_pathspec(struct pathspec *pathspec,
 		n++;
 
 	pathspec->nr = n;
-	pathspec->items = item = xmalloc(sizeof(*item) * n);
+	ALLOC_ARRAY(pathspec->items, n);
+	item = pathspec->items;
 	pathspec->_raw = argv;
 	prefixlen = prefix ? strlen(prefix) : 0;
 
@@ -483,7 +484,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	*dst = *src;
-	dst->items = xmalloc(sizeof(struct pathspec_item) * dst->nr);
+	ALLOC_ARRAY(dst->items, dst->nr);
 	memcpy(dst->items, src->items,
 	       sizeof(struct pathspec_item) * dst->nr);
 }
diff --git a/remote-curl.c b/remote-curl.c
index 42deeec..5259b7e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -696,9 +696,10 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 {
 	struct walker *walker;
-	char **targets = xmalloc(nr_heads * sizeof(char*));
+	char **targets;
 	int ret, i;
 
+	ALLOC_ARRAY(targets, nr_heads);
 	if (options.depth)
 		die("dumb http transport does not support --depth");
 	for (i = 0; i < nr_heads; i++)
diff --git a/sha1_file.c b/sha1_file.c
index aab1872..2f1c6d3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1942,7 +1942,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
-			poi_stack = xmalloc(sizeof(off_t)*poi_stack_alloc);
+			ALLOC_ARRAY(poi_stack, poi_stack_alloc);
 			memcpy(poi_stack, small_poi_stack, sizeof(off_t)*poi_stack_nr);
 		} else {
 			ALLOC_GROW(poi_stack, poi_stack_nr+1, poi_stack_alloc);
@@ -2308,7 +2308,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		if (delta_stack_nr >= delta_stack_alloc
 		    && delta_stack == small_delta_stack) {
 			delta_stack_alloc = alloc_nr(delta_stack_nr);
-			delta_stack = xmalloc(sizeof(*delta_stack)*delta_stack_alloc);
+			ALLOC_ARRAY(delta_stack, delta_stack_alloc);
 			memcpy(delta_stack, small_delta_stack,
 			       sizeof(*delta_stack)*delta_stack_nr);
 		} else {
diff --git a/shallow.c b/shallow.c
index 60f1505..71163bf 100644
--- a/shallow.c
+++ b/shallow.c
@@ -315,8 +315,8 @@ void prepare_shallow_info(struct shallow_info *info, struct sha1_array *sa)
 	info->shallow = sa;
 	if (!sa)
 		return;
-	info->ours = xmalloc(sizeof(*info->ours) * sa->nr);
-	info->theirs = xmalloc(sizeof(*info->theirs) * sa->nr);
+	ALLOC_ARRAY(info->ours, sa->nr);
+	ALLOC_ARRAY(info->theirs, sa->nr);
 	for (i = 0; i < sa->nr; i++) {
 		if (has_sha1_file(sa->sha1[i])) {
 			struct commit_graft *graft;
@@ -487,7 +487,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	struct paint_info pi;
 
 	trace_printf_key(&trace_shallow, "shallow: assign_shallow_commits_to_refs\n");
-	shallow = xmalloc(sizeof(*shallow) * (info->nr_ours + info->nr_theirs));
+	ALLOC_ARRAY(shallow, info->nr_ours + info->nr_theirs);
 	for (i = 0; i < info->nr_ours; i++)
 		shallow[nr_shallow++] = info->ours[i];
 	for (i = 0; i < info->nr_theirs; i++)
diff --git a/show-index.c b/show-index.c
index d9e4903..acf8d54 100644
--- a/show-index.c
+++ b/show-index.c
@@ -50,7 +50,8 @@ int main(int argc, char **argv)
 			unsigned char sha1[20];
 			uint32_t crc;
 			uint32_t off;
-		} *entries = xmalloc(nr * sizeof(entries[0]));
+		} *entries;
+		ALLOC_ARRAY(entries, nr);
 		for (i = 0; i < nr; i++)
 			if (fread(entries[i].sha1, 20, 1, stdin) != 1)
 				die("unable to read sha1 %u/%u", i, nr);
diff --git a/transport.c b/transport.c
index c92f8ae..3b4e644 100644
--- a/transport.c
+++ b/transport.c
@@ -977,7 +977,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 		 * This condition shouldn't be met in a non-deepening fetch
 		 * (see builtin/fetch.c:quickfetch()).
 		 */
-		heads = xmalloc(nr_refs * sizeof(*heads));
+		ALLOC_ARRAY(heads, nr_refs);
 		for (rm = refs; rm; rm = rm->next)
 			heads[nr_heads++] = rm;
 	}
diff --git a/xdiff-interface.c b/xdiff-interface.c
index cb67c1c..54236f2 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -265,7 +265,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 	for (i = 0, regs->nr = 1; value[i]; i++)
 		if (value[i] == '\n')
 			regs->nr++;
-	regs->array = xmalloc(regs->nr * sizeof(struct ff_reg));
+	ALLOC_ARRAY(regs->array, regs->nr);
 	for (i = 0; i < regs->nr; i++) {
 		struct ff_reg *reg = regs->array + i;
 		const char *ep = strchr(value, '\n'), *expression;
-- 
2.7.2.645.g4e1306c
