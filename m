From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6.1 8/8] log -L: implement move/copy detection (-M/-C)
Date: Tue, 14 Dec 2010 23:54:15 +0100
Message-ID: <581d171bc4ae048ca07dfe1d51bac3533a2788aa.1292366984.git.trast@student.ethz.ch>
References: <cover.1292366984.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:55:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdls-0003SV-T8
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab0LNWyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:54:31 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:10668 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760167Ab0LNWyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:54:22 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 23:54:12 +0100
Received: from localhost.localdomain (84.74.105.24) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 23:54:18 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <cover.1292366984.git.trast@student.ethz.ch>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163713>

From: Bo Yang <struggleyb.nku@gmail.com>

The basic idea is:

* Keep a list of "candidate snippets".  Start out empty.

* Go through all candidates (determined by the level of detection
  chosen) and diff them against the target file.

  - For each common part in the diff, put it in the "candidate
    snippets" if it's "worth it".  (Notably there is no point in
    adding a snippet that is fully contained in another.)

* Score the snippets.  Lines with alphanumeric characters count more.

* Filter out snippets with low score.  Where there are overlaps,
  favour higher scores.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 line.c                          |  556 ++++++++++++++++++++++++++++++++++++++-
 t/t4303-log-line-move-detect.sh |  238 +++++++++++++++++
 t/t4304-log-line-copy-detect.sh |  220 +++++++++++++++
 3 files changed, 1001 insertions(+), 13 deletions(-)
 create mode 100755 t/t4303-log-line-move-detect.sh
 create mode 100755 t/t4304-log-line-copy-detect.sh

diff --git a/line.c b/line.c
index 742c17f..ae176da 100644
--- a/line.c
+++ b/line.c
@@ -17,6 +17,7 @@ struct print_range {
 	int start, end;		/* Line range of post-image */
 	int pstart, pend;	/* Line range of pre-image */
 	int line_added : 1;	/* whether this range is added */
+	int copied : 1;
 };
 
 struct print_pair {
@@ -30,6 +31,7 @@ struct line_range {
 	long pstart, pend;	/* The corresponding range of parent commit */
 	struct print_pair pair;
 			/* The changed lines inside this range */
+	int copy_score;
 	unsigned int diff:1;
 };
 
@@ -66,6 +68,7 @@ static inline void print_range_init(struct print_range *r)
 	r->start = r->end = 0;
 	r->pstart = r->pend = 0;
 	r->line_added = 0;
+	r->copied = 0;
 }
 
 static inline void print_pair_init(struct print_pair *p)
@@ -104,6 +107,7 @@ static inline void line_range_clear(struct line_range *r)
 	r->start = r->end = 0;
 	r->pstart = r->pend = 0;
 	print_pair_clear(&r->pair);
+	r->copy_score = 0;
 	r->diff = 0;
 }
 
@@ -594,7 +598,7 @@ static void add_line_range(struct rev_info *revs, struct commit *commit,
 	ret = lookup_decoration(&revs->line_range, &commit->object);
 	if (ret && r)
 		diff_line_range_merge(ret, r);
-	else
+	else if (r != NULL)
 		add_decoration(&revs->line_range, &commit->object, r);
 
 	if (r)
@@ -620,6 +624,16 @@ static void clear_commit_line_range(struct rev_info *revs, struct commit *commit
 	return ret;
 }
 
+struct diff_line_range *delete_line_range(struct rev_info *revs, struct commit *commit)
+{
+	struct diff_line_range *ret = NULL;
+
+	ret = lookup_decoration(&revs->line_range, &commit->object);
+	add_decoration(&revs->line_range, &commit->object, NULL);
+
+	return ret;
+}
+
 void line_log_init(struct rev_info *rev, struct diff_line_range *r)
 {
 	struct commit *commit = NULL;
@@ -647,6 +661,515 @@ struct take_range_cb_data {
 		 * commit and its parent */
 };
 
+struct map {
+	long start, end;
+	long pstart, pend;
+	struct diff_filespec *spec;
+	int score;
+};
+
+struct mac_cb_data {
+	long plno, tlno;
+	int nr;
+	int alloc;
+	struct map *maps;
+	struct diff_filespec *spec;
+};
+
+struct mac_state {
+	int nr;
+	int alloc;
+	struct map *maps;
+};
+
+static void mac_state_init(struct mac_state *state)
+{
+	state->nr = state->alloc = 0;
+	state->maps = NULL;
+}
+
+static void mac_cb(void *data, long same, long p_next, long t_next)
+{
+	struct mac_cb_data *d = data;
+	long p_start = d->plno + 1, t_start = d->tlno + 1;
+	long p_end = p_start + same - t_start, t_end = same;
+
+	if (t_end >= t_start) {
+		ALLOC_GROW(d->maps, (d->nr + 1), d->alloc);
+		d->maps[d->nr].start = t_start;
+		d->maps[d->nr].end = t_end;
+		d->maps[d->nr].pstart = p_start;
+		d->maps[d->nr].pend = p_end;
+		d->maps[d->nr].spec = d->spec;
+		d->nr++;
+	}
+
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
+static void mac_state_insert(struct mac_state *state, long s_start, long s_end,
+		long start, long end, struct diff_filespec *spec)
+{
+	int i = 0;
+	struct map *maps;
+
+	for (; i < state->nr; i++) {
+		if (state->maps[i].start > end)
+			break;
+	}
+
+	state->nr++;
+	ALLOC_GROW(state->maps, state->nr, state->alloc);
+	maps = state->maps;
+	memmove(maps + i + 1, maps + i, (state->nr - i - 1) * sizeof(*maps));
+	maps[i].start = s_start;
+	maps[i].end = s_end;
+	maps[i].pstart = start;
+	maps[i].pend = end;
+	maps[i].spec = spec;
+	spec->count++;
+}
+
+static void mac_state_remove(struct mac_state *state, long s_start, long s_end,
+		long start, long end)
+{
+	int i = 0;
+	struct map *maps = state->maps;
+
+	while (i < state->nr) {
+		if (maps[i].start < start && maps[i].end > start) {
+			maps[i].end = s_start - 1;
+			maps[i].pend -= start - s_start;
+		}
+		if (maps[i].start < end && maps[i].end > end) {
+			maps[i].start = s_end + 1;
+			maps[i].pstart += end - s_end;
+		}
+		if (maps[i].start >=start && maps[i].end <= end) {
+			memmove(maps + i, maps + i + 1, (state->nr - i - 1) * sizeof(*maps));
+			state->nr--;
+			i--;
+		}
+
+		i++;
+	}
+}
+
+/*
+ * Generally, the 'struct line_range's pstart/pend is used to store
+ * the pre-image of current range. But here, we use it to store the
+ * line range of the 'artificial' memory file.
+ */
+static struct mac_state *merge_mac(struct mac_cb_data *data,
+		struct mac_state *state, long lines)
+{
+	struct map *maps = data->maps;
+	int i = 0;
+
+	assert(state);
+
+	while (i < data->nr) {
+		int j = 0;
+		long start = maps[i].start;
+		long end = maps[i].end;
+		int should_insert = 0;
+		long should_start = start;
+		long should_end = end;
+		long may_start = start, may_end = end;
+		long start_range_len = 0, end_range_len = 0;
+
+		/* first round: finds whether this range should be inserted */
+		if (!state->nr)
+			should_insert = 1;
+		while (state && j < state->nr) {
+			if (state->maps[j].end <= start) {
+				if (j+1 == state->nr)
+					should_insert = 1;
+				j++;
+				continue;
+			}
+			if (state->maps[j].start > end)
+				should_insert = 1;
+			else {
+				if (state->maps[j].start <= start) {
+					if (state->maps[j].end >= end)
+						should_insert = 0;
+					else {
+						should_insert = 1;
+						may_start = state->maps[j].end + 1;
+						start_range_len = state->maps[j].end -
+							state->maps[j].start + 1;
+					}
+				} else {
+					if (state->maps[j].end > end) {
+						should_insert = 1;
+						may_end = state->maps[j].start - 1;
+						end_range_len = state->maps[j].end -
+							state->maps[j].start + 1;
+					} else
+						should_insert = 1;
+				}
+			}
+
+			j++;
+		}
+
+		/* second round: insert the new range and adjust the current one */
+		if (should_insert) {
+			/* We always keep the longest range in prior */
+			if (start_range_len > end_range_len) {
+				if (start_range_len > should_end - should_start + 1)
+					should_start = may_start;
+				if (end_range_len > should_end - should_start + 1)
+					should_end = may_end;
+			} else {
+				if (end_range_len > should_end - should_start + 1)
+					should_end = may_end;
+				if (start_range_len > should_end - should_start + 1)
+					should_start = may_start;
+			}
+
+			mac_state_remove(state, should_start, should_end,
+					maps[i].start, maps[i].end);
+
+			start = maps[i].pstart + should_start - maps[i].start;
+			end = maps[i].pend - (maps[i].end - should_end);
+			mac_state_insert(state, should_start, should_end, start, end, data->spec);
+		}
+
+		i++;
+	}
+
+	return state;
+}
+
+static struct mac_state *find_mac_in_file(mmfile_t *file_p, mmfile_t *file_t,
+		long lines, unsigned char *scores, struct diff_filespec *spec,
+		struct mac_state *state)
+{
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	struct mac_cb_data cb = {0, 0, 0, 0, NULL, spec};
+
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = xecfg.interhunkctxlen = 0;
+
+	xdi_diff_hunks(file_p, file_t, mac_cb, &cb, &xpp, &xecfg);
+
+	if (cb.tlno < lines) {
+		ALLOC_GROW(cb.maps, (cb.nr + 1), cb.alloc);
+		cb.maps[cb.nr].start = cb.tlno + 1;
+		cb.maps[cb.nr].end = lines;
+		cb.maps[cb.nr].pstart = cb.plno + 1;
+		cb.maps[cb.nr].pend = cb.plno + lines - cb.tlno;
+		cb.maps[cb.nr].spec = spec;
+		cb.nr++;
+	}
+
+	if (cb.nr)
+		state = merge_mac(&cb, state, lines);
+	free(cb.maps);
+
+	return state;
+}
+
+#define LINE_SCORE 6
+#define TRIVIAL_SCORE 2
+static void setup_mac_file(struct diff_filespec *spec, mmfile_t *lines,
+		unsigned char *scores, long start, long end)
+{
+	int i = 0;
+	int line = 1;
+	int size = 0;
+	char *data = spec->data;
+
+	memset(scores, TRIVIAL_SCORE, end - start + 1);
+	while (i < spec->size) {
+		int index = line - start;
+		if (line < start) {
+			if (data[i] == '\n')
+				line++;
+			i++;
+			continue;
+		}
+		if (line > end)
+			break;
+		if (size == 0)
+			lines->ptr = data + i;
+		size++;
+		if (scores[index] == TRIVIAL_SCORE && data[i] <= 'z' && data[i] >= 'a')
+			scores[index] = LINE_SCORE;
+		if (scores[index] == TRIVIAL_SCORE && data[i] <= 'Z' && data[i] >= 'A')
+			scores[index] = LINE_SCORE;
+		if (scores[index] == TRIVIAL_SCORE && data[i] <= '9' && data[i] >= '0')
+			scores[index] = LINE_SCORE;
+		if (data[i] == '\n')
+			line++;
+
+		i++;
+	}
+
+	lines->size = size;
+}
+
+static void mac_state_cal_score(long lines, unsigned char *scores, struct mac_state *state)
+{
+	struct map *maps = state->maps;
+	int i = 0;
+
+	while (i < state->nr) {
+		int score = 0;
+		int j = maps[i].start;
+		while (j <= maps[i].end) {
+			assert(j <= lines);
+			score += scores[j - 1];
+			j++;
+		}
+
+		maps[i].score = score;
+		i++;
+	}
+}
+
+#define MIN_GAP 3
+#define RANGE_MIN_SCORE 20
+static struct diff_line_range *mac_combine_remove(struct diff_line_range *range)
+{
+	struct diff_line_range *r = range, *prev = range, *ret = range;
+
+	// Firstly to combine adjacent-enough range
+	while (r) {
+		int i = 0;
+		struct line_range *rs = r->ranges;
+		for (; i < r->nr; i++) {
+			if (i + 1 < r->nr &&
+				(rs[i + 1].end - rs[i].start < MIN_GAP)) {
+				rs[i].end = rs[i + 1].end;
+				rs[i].copy_score += rs[i + 1].copy_score;
+				memmove(rs + i + 1, rs + i + 2, (r->nr - i - 1) * sizeof(*rs));
+				r->nr--;
+				i--;
+			}
+		}
+		r = r->next;
+	}
+
+	// then delete the trivial ones
+	r = range;
+	while (r) {
+		int i = 0;
+		struct line_range *rs = r->ranges;
+		for (; i < r->nr; i++) {
+			if (rs[i].copy_score < RANGE_MIN_SCORE) {
+				memmove(rs + i, rs + i + 1, (r->nr - i) * sizeof(*rs));
+				r->nr--;
+				i--;
+			}
+		}
+		r = r->next;
+	}
+
+	// then delete the empty diff_line_range
+	r = range;
+	while (r) {
+		struct diff_line_range *next = r->next;
+		if (!r->nr) {
+			diff_line_range_clear(r);
+			free(r);
+			if (ret == r) {
+				ret = next;
+				prev = next;
+			}
+		} else if (prev != r) {
+				prev->next = r;
+				prev = r;
+		}
+
+		r = next;
+	}
+
+	return ret;
+}
+
+static struct diff_line_range *mac_state_to_line_range(struct mac_state *state)
+{
+	struct diff_line_range *ret = NULL;
+	struct diff_line_range *prev = NULL;
+	struct map *maps = state->maps;
+	int i = 0;
+	struct line_range *rg = NULL;
+
+	while (i < state->nr) {
+		struct diff_line_range *r = ret;
+		while (r) {
+			if (r->spec == maps[i].spec) {
+				rg = diff_line_range_insert(r, NULL, maps[i].pstart,
+						maps[i].pend);
+				rg->copy_score += maps[i].score;
+				break;
+			}
+			r = r->next;
+		}
+
+		if (!r) {
+			r = xmalloc(sizeof(*r));
+			diff_line_range_init(r);
+			r->spec = maps[i].spec;
+			rg = diff_line_range_insert(r, NULL, maps[i].pstart, maps[i].pend);
+			rg->copy_score += maps[i].score;
+
+			if (!ret) {
+				ret = r;
+				prev = r;
+			} else {
+				prev->next = r;
+				prev = r;
+			}
+		}
+
+		i++;
+	}
+
+	return mac_combine_remove(ret);
+}
+
+struct mac_state *find_mac_in_one_file(struct commit *p,
+		char *path, mmfile_t *file_t, long lines,
+		unsigned char *scores)
+{
+	struct diff_filespec *spec = alloc_filespec(path);
+	unsigned char sha1[20];
+	unsigned mode;
+	mmfile_t file_p;
+	struct mac_state *ret = xmalloc(sizeof(*ret));
+
+	mac_state_init(ret);
+	if (get_tree_entry(p->object.sha1, path, sha1, &mode))
+		return NULL;
+	fill_filespec(spec, sha1, mode);
+	diff_populate_filespec(spec, 0);
+	file_p.ptr = spec->data;
+	file_p.size = spec->size;
+
+	ret = find_mac_in_file(&file_p, file_t, lines, scores, spec, ret);
+	mac_state_cal_score(lines, scores, ret);
+
+	return ret;
+}
+
+struct mac_state *find_mac_in_all_file(struct rev_info *rev, struct commit *c,
+		struct commit *p, mmfile_t *file_t, long lines,
+		unsigned char *scores)
+{
+	struct diff_options diff_opts;
+	const char *paths[1];
+	int j = 0;
+	struct mac_state *state = xmalloc(sizeof(*state));
+
+	mac_state_init(state);
+	/* ok, we can start to do the move/copy detect now */
+	diff_setup(&diff_opts);
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	paths[0] = NULL;
+	diff_tree_setup_paths(paths, &diff_opts);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("diff-setup in line.c");
+	if (DIFF_OPT_TST(&rev->diffopt, FIND_COPIES_HARDER))
+		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
+
+	diff_tree_sha1(p->tree->object.sha1, c->tree->object.sha1,
+			"", &diff_opts);
+	for (j = 0; j < diff_queued_diff.nr; j++) {
+		struct diff_filepair *p = diff_queued_diff.queue[j];
+		mmfile_t file_p;
+
+		if (!DIFF_FILE_VALID(p->one))
+			continue;
+		if (S_ISGITLINK(p->one->mode))
+			continue;
+		diff_populate_filespec(p->one, 0);
+		file_p.ptr = p->one->data;
+		file_p.size = p->one->size;
+
+		p->one->count++;
+		state = find_mac_in_file(&file_p, file_t, lines, scores, p->one, state);
+	}
+
+	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
+
+	mac_state_cal_score(lines, scores, state);
+
+	return state;
+}
+
+static void find_mac_for_range(struct rev_info *rev,
+		struct commit *c, struct commit *p,
+		struct diff_line_range *r, struct print_range *pr)
+{
+	unsigned char *scores;
+	struct mac_state *state;
+	mmfile_t lines = {NULL, 0};
+	struct diff_line_range *copied = NULL;
+
+	/* Do not search for source of ranges shorter than 3 lines */
+	if (pr->line_added && (pr->end - pr->start) < 3)
+		return;
+
+	scores = xmalloc(pr->end - pr->start + 1);
+	setup_mac_file(r->spec, &lines, scores, pr->start, pr->end);
+
+	if (rev->diffopt.detect_rename == DIFF_DETECT_RENAME)
+		state = find_mac_in_one_file(p, r->spec->path, &lines,
+					     pr->end - pr->start + 1, scores);
+	else
+		state = find_mac_in_all_file(rev, c, p, &lines,
+					     pr->end - pr->start + 1, scores);
+
+	copied = mac_state_to_line_range(state);
+	if (copied) {
+		add_line_range(rev, p, copied);
+		pr->copied = 1;
+	}
+	free(scores);
+}
+
+/*
+ * Find the code move/copy, here we reuse the '-M/-C' options in diff options.
+ * -M means that finds the code in the same file;
+ * -C means that finds the code in all the files in parent commit.
+ */
+static void find_mac(struct rev_info *rev, struct commit *c)
+{
+	struct diff_line_range *r = lookup_line_range(rev, c);
+	struct diff_line_range *prange = NULL;
+	struct commit *p = NULL;
+
+	if (c->parents == NULL)
+		return;
+
+	assert(c->parents->next == NULL);
+	p = c->parents->item;
+	parse_commit(p);
+
+	while (r) {
+		int n;
+		for (n = 0; n < r->nr; n++) {
+			struct print_pair *pair = &r->ranges[n].pair;
+			int i;
+			for (i = 0; i < pair->nr; i++)
+				find_mac_for_range(rev, c, p, r, &pair->ranges[i]);
+		}
+
+		r = r->next;
+	}
+
+	add_line_range(rev, p, prange);
+}
+
 #define SCALE_FACTOR 4
 /*
  * [p_start, p_end] represents the pre-image of current diff hunk,
@@ -942,7 +1465,7 @@ static int assign_range_to_parent(struct rev_info *rev, struct commit *commit,
 	void *tree1 = NULL, *tree2 = NULL;
 	struct tree_desc desc1, desc2;
 	struct diff_queue_struct *queue;
-	struct take_range_cb_data cb_data = {NULL, cur_range, 0, 0};
+	struct take_range_cb_data cb_data = {NULL, cur_range, 0, 0, 0};
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	int i, diff = 0;
@@ -1083,15 +1606,6 @@ static int assign_range_to_parent(struct rev_info *rev, struct commit *commit,
 		assert(parent);
 		assert(final_range->spec);
 		add_line_range(rev, parent, final_range);
-	} else {
-		/*
-		 * If there is no new ranges assigned to the parent,
-		 * we should mark it as a 'root' commit.
-		 */
-		if (commit->parents && !commit->parents->next) {
-			free(commit->parents);
-			commit->parents = NULL;
-		}
 	}
 
 	/* and the ranges of current commit is updated */
@@ -1120,6 +1634,18 @@ static void diff_update_parent_range(struct rev_info *rev,
 	}
 
 	assign_range_to_parent(rev, commit, c, r, &rev->diffopt, 1);
+
+	if (rev->diffopt.detect_rename > 0)
+		find_mac(rev, commit);
+
+	/*
+	 * If there is no new ranges assigned to the parent,
+	 * we should mark it as a 'root' commit.
+	 */
+	if (c != NULL && lookup_line_range(rev, c) == NULL) {
+		free(commit->parents);
+		commit->parents = NULL;
+	}
 }
 
 struct commit_state {
@@ -1306,8 +1832,12 @@ static void diff_flush_range(struct diff_options *opt, struct line_chunk *chunk,
 		if (!pr->line_added)
 			flush_lines(opt, &chunk->one, chunk->one_end,
 				pr->pstart, pr->pend, &chunk->lone, old, '-');
-		flush_lines(opt, &chunk->two, chunk->two_end,
-			pr->start, pr->end, &chunk->ltwo, new, '+');
+		if (pr->copied)
+			flush_lines(opt, &chunk->two, chunk->two_end,
+				pr->start, pr->end, &chunk->ltwo, new, ' ');
+		else
+			flush_lines(opt, &chunk->two, chunk->two_end,
+				pr->start, pr->end, &chunk->ltwo, new, '+');
 
 		cur = pr->end + 1;
 	}
diff --git a/t/t4303-log-line-move-detect.sh b/t/t4303-log-line-move-detect.sh
new file mode 100755
index 0000000..0462ec0
--- /dev/null
+++ b/t/t4303-log-line-move-detect.sh
@@ -0,0 +1,238 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with code movement'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+
+void output()
+{
+	printf("hello world");
+}
+EOF
+
+test_expect_success 'add path0 and commit.' '
+	git add path0 &&
+	git commit -m "Base commit"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+
+void output()
+{
+	int d = 3;
+	int e = 5;
+	printf("hello world");
+	printf("bye!");
+}
+EOF
+
+test_expect_success 'Change the some lines of path0.' '
+	git add path0 &&
+	git commit -m "Change some lines of path0"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+
+void output()
+{
+	int d = 3;
+	int e = 5;
+	printf("hello world");
+	printf("bye!");
+}
+
+void comb()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+	int d = 3;
+	int e = 5;
+	printf("hello world");
+	printf("bye!");
+}
+EOF
+
+test_expect_success 'Move two functions into one' '
+	git add path0 &&
+	git commit -m "Move two functions into one"
+'
+
+cat >path0 <<\EOF
+void comb()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+	printf("hello world");
+	printf("bye!");
+}
+EOF
+
+test_expect_success 'Final change of path0.' '
+	git add path0 &&
+	git commit -m "Final change of path0"
+'
+
+sed -e 's/Q/ /g' -e 's/#$//' >expected-no-M <<\EOF
+* Final change of path0
+| #
+| diff --git a/path0 b/path0
+| index 495f978..b744a93 100644
+| --- a/path0
+| +++ b/path0
+| @@ -17,11 +1,9 @@
+|  void comb()
+|  {
+|QQ	int a = 0;
+|QQ	int b = 1;
+|QQ	int c;
+|QQ	c = a + b;
+| -	int d = 3;
+| -	int e = 5;
+|QQ	printf("hello world");
+|QQ	printf("bye!");
+|  }
+|  #
+* Move two functions into one
+  #
+  diff --git a/path0 b/path0
+  index cd42622..495f978 100644
+  --- a/path0
+  +++ b/path0
+  @@ -0,0 +17,11 @@
+  +void comb()
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +	int d = 3;
+  +	int e = 5;
+  +	printf("hello world");
+  +	printf("bye!");
+  +}
+EOF
+
+sed -e 's/Q/ /g' -e 's/#$//' >expected-M <<\EOF
+* Final change of path0
+| #
+| diff --git a/path0 b/path0
+| index 495f978..b744a93 100644
+| --- a/path0
+| +++ b/path0
+| @@ -17,11 +1,9 @@
+|  void comb()
+|  {
+|QQ	int a = 0;
+|QQ	int b = 1;
+|QQ	int c;
+|QQ	c = a + b;
+| -	int d = 3;
+| -	int e = 5;
+|QQ	printf("hello world");
+|QQ	printf("bye!");
+|  }
+|  #
+* Move two functions into one
+| #
+| diff --git a/path0 b/path0
+| index cd42622..495f978 100644
+| --- a/path0
+| +++ b/path0
+| @@ -0,0 +17,11 @@
+|  void comb()
+|  {
+|QQ	int a = 0;
+|QQ	int b = 1;
+|QQ	int c;
+|QQ	c = a + b;
+|QQ	int d = 3;
+|QQ	int e = 5;
+|QQ	printf("hello world");
+|QQ	printf("bye!");
+|  }
+|  #
+* Change some lines of path0
+| #
+| diff --git a/path0 b/path0
+| index f5e09df..cd42622 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,5 +2,5 @@
+|  {
+|QQ	int a = 0;
+|QQ	int b = 1;
+|QQ	int c;
+|QQ	c = a + b;
+| @@ -11,2 +11,5 @@
+| +	int d = 3;
+| +	int e = 5;
+|QQ	printf("hello world");
+| +	printf("bye!");
+|  }
+|  #
+* Base commit
+  #
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..f5e09df
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,5 @@
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  @@ -0,0 +11,2 @@
+  +	printf("hello world");
+  +}
+EOF
+
+test_expect_success 'Show the line level log of path0' '
+	git log --pretty=format:%s%n%b --graph -L /comb/,/^}/:path0 > current-no-M
+'
+
+test_expect_success 'validate the path0 output.' '
+	test_cmp current-no-M expected-no-M
+'
+
+test_expect_success 'Show the line level log of path0 with -M' '
+	git log --pretty=format:%s%n%b --graph -M -L /comb/,/^}/:path0 > current-M
+'
+
+test_expect_success 'validate the path1 output.' '
+	test_cmp current-M expected-M
+'
+
+test_done
diff --git a/t/t4304-log-line-copy-detect.sh b/t/t4304-log-line-copy-detect.sh
new file mode 100755
index 0000000..de0e004
--- /dev/null
+++ b/t/t4304-log-line-copy-detect.sh
@@ -0,0 +1,220 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with -C'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+EOF
+
+cat >path1 <<\EOF
+void output()
+{
+	printf("hello world");
+}
+EOF
+
+test_expect_success 'add path0/path1 and commit.' '
+	git add path0 path1 &&
+	git commit -m "Base commit"
+'
+
+cat >path1 <<\EOF
+void output()
+{
+	int d = 3;
+	int e = 5;
+	printf("hello world");
+	printf("bye!");
+}
+EOF
+
+test_expect_success 'Change the some lines of path1.' '
+	git add path1 &&
+	git commit -m "Change some lines of path1"
+'
+
+cat >path2 <<\EOF
+void comb()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+	int d = 3;
+	int e = 5;
+	printf("hello world");
+	printf("bye!");
+}
+EOF
+
+test_expect_success 'Move two functions into one in path2' '
+	git add path2 &&
+	git rm path0 path1 &&
+	git commit -m "Move two functions into path2"
+'
+
+cat >path2 <<\EOF
+void comb()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+	printf("hello world");
+	printf("bye!");
+}
+EOF
+
+test_expect_success 'Final change of path2.' '
+	git add path2 &&
+	git commit -m "Final change of path2"
+'
+
+sed -e 's/Q/ /g' -e 's/#$//' >expected-no-C <<\EOF
+* Final change of path2
+| #
+| diff --git a/path2 b/path2
+| index ca6a800..b744a93 100644
+| --- a/path2
+| +++ b/path2
+| @@ -1,11 +1,9 @@
+|  void comb()
+|  {
+|QQ	int a = 0;
+|QQ	int b = 1;
+|QQ	int c;
+|QQ	c = a + b;
+| -	int d = 3;
+| -	int e = 5;
+|QQ	printf("hello world");
+|QQ	printf("bye!");
+|  }
+|  #
+* Move two functions into path2
+  #
+  diff --git a/path2 b/path2
+  new file mode 100644
+  index 0000000..ca6a800
+  --- /dev/null
+  +++ b/path2
+  @@ -0,0 +1,11 @@
+  +void comb()
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +	int d = 3;
+  +	int e = 5;
+  +	printf("hello world");
+  +	printf("bye!");
+  +}
+EOF
+
+sed -e 's/Q/ /g' -e 's/#$//' >expected-C <<\EOF
+* Final change of path2
+| #
+| diff --git a/path2 b/path2
+| index ca6a800..b744a93 100644
+| --- a/path2
+| +++ b/path2
+| @@ -1,11 +1,9 @@
+|  void comb()
+|  {
+|QQ	int a = 0;
+|QQ	int b = 1;
+|QQ	int c;
+|QQ	c = a + b;
+| -	int d = 3;
+| -	int e = 5;
+|QQ	printf("hello world");
+|QQ	printf("bye!");
+|  }
+|  #
+* Move two functions into path2
+| #
+| diff --git a/path2 b/path2
+| new file mode 100644
+| index 0000000..ca6a800
+| --- /dev/null
+| +++ b/path2
+| @@ -0,0 +1,11 @@
+|  void comb()
+|  {
+|QQ	int a = 0;
+|QQ	int b = 1;
+|QQ	int c;
+|QQ	c = a + b;
+|QQ	int d = 3;
+|QQ	int e = 5;
+|QQ	printf("hello world");
+|QQ	printf("bye!");
+|  }
+|  #
+* Change some lines of path1
+| #
+| diff --git a/path1 b/path1
+| index 52be2a5..bf3a80f 100644
+| --- a/path1
+| +++ b/path1
+| @@ -2,3 +2,6 @@
+|  {
+| +	int d = 3;
+| +	int e = 5;
+|QQ	printf("hello world");
+| +	printf("bye!");
+|  }
+|  #
+* Base commit
+  #
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..52be2a5
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +2,3 @@
+  +{
+  +	printf("hello world");
+  +}
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,5 @@
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+EOF
+
+test_expect_success 'Show the line level log of path2' '
+	git log --pretty=format:%s%n%b --graph -L /comb/,/^}/:path2 > current-no-C
+'
+
+test_expect_success 'validate the path2 output.' '
+	test_cmp current-no-C expected-no-C
+'
+
+test_expect_success 'Show the line level log of path2 with -C' '
+	git log --pretty=format:%s%n%b --graph -C -L /comb/,/^}/:path2 > current-C
+'
+
+test_expect_success 'validate the path2 output.' '
+	test_cmp current-C expected-C
+'
+
+test_done
-- 
1.7.3.3.807.g6ee1f
