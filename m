Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0786420195
	for <e@80x24.org>; Tue, 19 Jul 2016 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbcGSWNf (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 18:13:35 -0400
Received: from siwi.pair.com ([209.68.5.199]:20807 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbcGSWNb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 18:13:31 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 7725484640;
	Tue, 19 Jul 2016 18:13:30 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, gitster@pobox.com, jeffhost@microsoft.com
Subject: [PATCH v1 3/6] Per-file output for Porcelain Status V2
Date:	Tue, 19 Jul 2016 18:10:55 -0400
Message-Id: <1468966258-11191-4-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This commit sets up version 2 porcelain status and
defines the format of detail lines.  This includes
the usual XY and pathname fields.  It adds the various
file modes and SHAs and the rename score.  For regular
entries these values reflect the head, index and
worktree. For unmerged entries these values reflect
the stage 1, 2, and 3 values.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/commit.c |   9 ++
 wt-status.c      | 398 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 wt-status.h      |  13 ++
 3 files changed, 419 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 892d7f7..b5ec9b9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -153,6 +153,8 @@ static int opt_parse_porcelain(const struct option *opt, const char *arg, int un
 		int n = strtol(arg, NULL, 10);
 		if (n == 1)
 			*value = STATUS_FORMAT_PORCELAIN;
+		else if (n == 2)
+			*value = STATUS_FORMAT_PORCELAIN_V2;
 		else
 			die("unsupported porcelain version");
 	} else {
@@ -521,6 +523,9 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
 		break;
+	case STATUS_FORMAT_PORCELAIN_V2:
+		wt_porcelain_v2_print(s);
+		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
 		break;
@@ -1120,6 +1125,7 @@ static struct status_deferred_config {
 static void finalize_deferred_config(struct wt_status *s)
 {
 	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN &&
+				   status_format != STATUS_FORMAT_PORCELAIN_V2 &&
 				   !s->null_termination);
 
 	if (s->null_termination) {
@@ -1409,6 +1415,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
 		break;
+	case STATUS_FORMAT_PORCELAIN_V2:
+		wt_porcelain_v2_print(&s);
+		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
 		break;
diff --git a/wt-status.c b/wt-status.c
index c19b52c..2d4829e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -406,6 +406,89 @@ static void wt_status_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
+
+/* Copy info for both sides of a head-vs-index change
+ * into the Porcelain V2 data.
+ */
+static void porcelain_v2_updated_entry(
+	struct wt_status_change_data *d,
+	struct diff_filepair *p)
+{
+	switch (p->status) {
+	case DIFF_STATUS_ADDED:
+		d->porcelain_v2.mode_index = p->two->mode;
+		hashcpy(d->porcelain_v2.sha1_index, p->two->sha1);
+		break;
+
+	case DIFF_STATUS_DELETED:
+		d->porcelain_v2.mode_head = p->one->mode;
+		hashcpy(d->porcelain_v2.sha1_head, p->one->sha1);
+		break;
+
+	case DIFF_STATUS_RENAMED:
+		d->porcelain_v2.rename_score = p->score * 100 / MAX_SCORE;
+	case DIFF_STATUS_COPIED:
+	case DIFF_STATUS_MODIFIED:
+	case DIFF_STATUS_TYPE_CHANGED:
+	case DIFF_STATUS_UNMERGED:
+		d->porcelain_v2.mode_head = p->one->mode;
+		d->porcelain_v2.mode_index = p->two->mode;
+		hashcpy(d->porcelain_v2.sha1_head, p->one->sha1);
+		hashcpy(d->porcelain_v2.sha1_index, p->two->sha1);
+		break;
+
+	case DIFF_STATUS_UNKNOWN:
+		/* This should never happen. */
+		break;
+	}
+}
+
+/* Copy info for both sides of an index-vs-worktree change
+ * into the very verbose porcelain data.
+ */
+static void porcelain_v2_changed_entry(
+	struct wt_status_change_data *d,
+	const struct diff_filepair *p)
+{
+	switch (p->status) {
+	case DIFF_STATUS_ADDED:
+		d->porcelain_v2.mode_worktree = p->two->mode;
+		/* don't bother with worktree sha, since it is almost always zero. */
+		break;
+
+	case DIFF_STATUS_DELETED:
+		d->porcelain_v2.mode_index = p->one->mode;
+		hashcpy(d->porcelain_v2.sha1_index, p->one->sha1);
+		break;
+
+	case DIFF_STATUS_COPIED:
+	case DIFF_STATUS_MODIFIED:
+	case DIFF_STATUS_RENAMED:
+	case DIFF_STATUS_TYPE_CHANGED:
+		d->porcelain_v2.mode_index = p->one->mode;
+		d->porcelain_v2.mode_worktree = p->two->mode;
+		hashcpy(d->porcelain_v2.sha1_index, p->one->sha1);
+		/* don't bother with worktree sha, since it is almost always zero. */
+		break;
+
+	case DIFF_STATUS_UNKNOWN:
+		/* This should never happen. */
+		break;
+
+	case DIFF_STATUS_UNMERGED:
+		/* This should never happen. */
+		break;
+	}
+}
+
+static void porcelain_v2_added_initial_entry(
+	struct wt_status_change_data *d,
+	const struct cache_entry *ce)
+{
+	d->porcelain_v2.mode_index = ce->ce_mode;
+	hashcpy(d->porcelain_v2.sha1_index, ce->sha1);
+}
+
 static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -433,6 +516,9 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		d->dirty_submodule = p->two->dirty_submodule;
 		if (S_ISGITLINK(p->two->mode))
 			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
+
+		if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
+			porcelain_v2_changed_entry(d, p);
 	}
 }
 
@@ -486,6 +572,9 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			d->stagemask = unmerged_mask(p->two->path);
 			break;
 		}
+
+		if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
+			porcelain_v2_updated_entry(d, p);
 	}
 }
 
@@ -565,8 +654,12 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			d->index_status = DIFF_STATUS_UNMERGED;
 			d->stagemask |= (1 << (ce_stage(ce) - 1));
 		}
-		else
+		else {
 			d->index_status = DIFF_STATUS_ADDED;
+
+			if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
+				porcelain_v2_added_initial_entry(d, ce);
+		}
 	}
 }
 
@@ -1753,3 +1846,306 @@ void wt_porcelain_print(struct wt_status *s)
 	s->no_gettext = 1;
 	wt_shortstatus_print(s);
 }
+
+/* Convert various submodule status values into a
+ * string of characters in the buffer provided.
+ */
+static void wt_porcelain_v2_submodule_state(
+	struct wt_status_change_data *d,
+	char sub[5])
+{
+	int k = 0;
+
+	if (S_ISGITLINK(d->porcelain_v2.mode_head) ||
+		S_ISGITLINK(d->porcelain_v2.mode_index) ||
+		S_ISGITLINK(d->porcelain_v2.mode_worktree)) {
+		/* We have a submodule */
+		sub[k++] = 'S';
+
+		/* Sub-flags for each type of dirt */
+		if (d->new_submodule_commits)
+			sub[k++] = 'C';
+		if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+			sub[k++] = 'M';
+		if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+			sub[k++] = 'U';
+	} else {
+		/* Not a submodule */
+		sub[k++] = 'N';
+	}
+
+	sub[k] = 0;
+}
+
+/* Various fix-up steps before we start printing an item.
+ */
+static void wt_porcelain_v2_fix_up_status(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+
+	if (!d->index_status) {
+		if (d->worktree_status == DIFF_STATUS_MODIFIED ||
+			d->worktree_status == DIFF_STATUS_DELETED) {
+			/* X=' ' Y=[MD]
+			 * The item did not change in head-vs-index scan so the head
+			 * column was never set. (The index column was set during the
+			 * index-vs-worktree scan.)
+			 * Force set the head column to make the output complete.
+			 */
+			d->porcelain_v2.mode_head = d->porcelain_v2.mode_index;
+			hashcpy(d->porcelain_v2.sha1_head, d->porcelain_v2.sha1_index);
+		}
+	}
+
+	if (!d->worktree_status) {
+		if (d->index_status == DIFF_STATUS_MODIFIED ||
+			d->index_status == DIFF_STATUS_ADDED ||
+			d->index_status == DIFF_STATUS_RENAMED ||
+			d->index_status == DIFF_STATUS_COPIED) {
+			/* X=[MARC] Y=' '
+			 * The item did not changed in the index-vs-worktree scan so
+			 * the worktree column was never set.
+			 * Force set the worktree mode to make the output complete.
+			 */
+			d->porcelain_v2.mode_worktree = d->porcelain_v2.mode_index;
+		}
+	}
+}
+
+/*
+ * Define a single format for tracked entries. This includes:
+ * normal changes, rename changes, and unmerged changes.
+ *
+ * The meanings of modes_[abcd] and sha_[abc] depends on the
+ * change type, but are always present.
+ *
+ * Path(s) are C-Quoted if necessary. Current path is ALWAYS
+ * first. The rename source path is only present when necessary.
+ * A single TAB separates them (because paths can contain spaces
+ * and C-Quoting converts actual tabs in pathnames to a C escape
+ * sequence).
+ */
+static void wt_porcelain_v2_print_tracked_entry(
+	FILE *fp,
+	char x_staged,
+	char y_unstaged,
+	const char *submodule,
+	int mode_a,
+	int mode_b,
+	int mode_c,
+	int mode_d,
+	const unsigned char sha_a[GIT_SHA1_RAWSZ],
+	const unsigned char sha_b[GIT_SHA1_RAWSZ],
+	const unsigned char sha_c[GIT_SHA1_RAWSZ],
+	int rename_score,
+	const char *path_current,
+	const char *path_rename_src,
+	int null_termination)
+{
+	char sep_char = null_termination ? '\0' : '\t';
+	char eol_char = null_termination ? '\0' : '\n';
+
+	if (path_rename_src)
+		fprintf(fp, "%c%c %s %06o %06o %06o %06o %s %s %s R%d %s%c%s%c",
+				x_staged, y_unstaged, submodule,
+				mode_a, mode_b, mode_c, mode_d,
+				sha1_to_hex(sha_a), sha1_to_hex(sha_b), sha1_to_hex(sha_c),
+				rename_score,
+				path_current, sep_char, path_rename_src,
+				eol_char);
+	else
+		fprintf(fp, "%c%c %s %06o %06o %06o %06o %s %s %s R%d %s%c",
+				x_staged, y_unstaged, submodule,
+				mode_a, mode_b, mode_c, mode_d,
+				sha1_to_hex(sha_a), sha1_to_hex(sha_b), sha1_to_hex(sha_c),
+				rename_score,
+				path_current,
+				eol_char);
+}
+
+/*
+ * Print porcelain V2 info for normal tracked entries.
+ */
+static void wt_porcelain_v2_print_normal_entry(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	static const unsigned char sha_zero[GIT_SHA1_RAWSZ] = {0};
+	struct wt_status_change_data *d = it->util;
+	struct strbuf buf_current = STRBUF_INIT;
+	struct strbuf buf_rename_src = STRBUF_INIT;
+	const char *path_current = NULL;
+	const char *path_rename_src = NULL;
+	char x_staged, y_unstaged;
+	char submodule[5];
+
+	wt_porcelain_v2_fix_up_status(it, s);
+	x_staged = d->index_status ? d->index_status : '.';
+	y_unstaged = d->worktree_status ? d->worktree_status : '.';
+	wt_porcelain_v2_submodule_state(d, submodule);
+
+	if (s->null_termination) {
+		path_current = it->string;
+		path_rename_src = d->head_path;
+	} else {
+		path_current = quote_path(it->string, s->prefix, &buf_current);
+		if (d->head_path)
+			path_rename_src = quote_path(d->head_path, s->prefix, &buf_rename_src);
+	}
+
+	wt_porcelain_v2_print_tracked_entry(
+		s->fp,
+		x_staged, y_unstaged, submodule,
+		d->porcelain_v2.mode_head,
+		d->porcelain_v2.mode_index,
+		d->porcelain_v2.mode_worktree,
+		0,
+		d->porcelain_v2.sha1_head,
+		d->porcelain_v2.sha1_index,
+		sha_zero,
+		d->porcelain_v2.rename_score,
+		path_current,
+		path_rename_src,
+		s->null_termination);
+
+	strbuf_release(&buf_current);
+	strbuf_release(&buf_rename_src);
+}
+
+/*
+ * Print very verbose porcelain status info for unmerged entries.
+ */
+static void wt_porcelain_v2_print_unmerged_entry(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	const struct cache_entry *ce;
+	struct strbuf buf_current = STRBUF_INIT;
+	const char *path_current = NULL;
+	int pos, stage;
+	struct {
+		int mode;
+		unsigned char sha1[GIT_SHA1_RAWSZ];
+	} stages[3];
+	char x_us = 'U', y_them = 'U';
+	char submodule[5];
+
+	switch (d->stagemask) {
+	case 1: x_us = 'D'; y_them = 'D'; break; /* both deleted */
+	case 2: x_us = 'A'; y_them = 'U'; break; /* added by us */
+	case 3: x_us = 'U'; y_them = 'D'; break; /* deleted by them */
+	case 4: x_us = 'U'; y_them = 'A'; break; /* added by them */
+	case 5: x_us = 'D'; y_them = 'U'; break; /* deleted by us */
+	case 6: x_us = 'A'; y_them = 'A'; break; /* both added */
+	case 7: x_us = 'U'; y_them = 'U'; break; /* both modified */
+	}
+
+	wt_porcelain_v2_submodule_state(d, submodule);
+
+	/*
+	 * Disregard the V2 {mode,sha} values for head and index
+	 * that we computed from the diffs and lookup the actual
+	 * stage data.
+	 */
+	memset(stages, 0, sizeof(stages));
+	pos = cache_name_pos(it->string, strlen(it->string));
+	assert(pos < 0);
+	pos = -pos-1;
+	while (pos < active_nr) {
+		ce = active_cache[pos++];
+		stage = ce_stage(ce);
+		if (strcmp(ce->name, it->string) || !stage)
+			break;
+		stages[stage - 1].mode = ce->ce_mode;
+		hashcpy(stages[stage - 1].sha1, ce->sha1);
+	}
+
+	if (s->null_termination)
+		path_current = it->string;
+	else
+		path_current = quote_path(it->string, s->prefix, &buf_current);
+
+	wt_porcelain_v2_print_tracked_entry(
+		s->fp, x_us, y_them, submodule,
+		stages[0].mode, /* stage 1 */
+		stages[1].mode, /* stage 2 */
+		stages[2].mode, /* stage 3 */
+		d->porcelain_v2.mode_worktree,
+		stages[0].sha1, /* stage 1 */
+		stages[1].sha1, /* stage 2 */
+		stages[2].sha1, /* stage 3 */
+		0,
+		path_current,
+		NULL,
+		s->null_termination);
+
+	strbuf_release(&buf_current);
+}
+
+/*
+ * Print porcelain V2 status info for untracked and ignored entries.
+ */
+static void wt_porcelain_v2_print_other(
+	struct string_list_item *it,
+	struct wt_status *s,
+	const char *sign)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *path;
+	char eol;
+
+	if (s->null_termination) {
+		path = it->string;
+		eol = '\0';
+	} else {
+		path = quote_path(it->string, s->prefix, &buf);
+		eol = '\n';
+	}
+
+	fprintf(s->fp, "%s %s%c", sign, path, eol);
+
+	strbuf_release(&buf);
+}
+
+/* Print porcelain V2 status.
+ *
+ * [<v2_branch>]
+ * [<v2_tracked_items>]*
+ * [<v2_untracked_items>]*
+ * [<v2_ignored_items>]*
+ *
+ */
+void wt_porcelain_v2_print(struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+
+		it = &(s->change.items[i]);
+		d = it->util;
+
+		if (d->stagemask)
+			wt_porcelain_v2_print_unmerged_entry(it, s);
+		else
+			wt_porcelain_v2_print_normal_entry(it, s);
+	}
+
+	for (i = 0; i < s->untracked.nr; i++) {
+		struct string_list_item *it;
+
+		it = &(s->untracked.items[i]);
+		wt_porcelain_v2_print_other(it, s, "??");
+	}
+
+	for (i = 0; i < s->ignored.nr; i++) {
+		struct string_list_item *it;
+
+		it = &(s->ignored.items[i]);
+		wt_porcelain_v2_print_other(it, s, "!!");
+	}
+}
diff --git a/wt-status.h b/wt-status.h
index fc80341..c062e30 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -39,6 +39,17 @@ struct wt_status_change_data {
 	int index_status;
 	int stagemask;
 	char *head_path;
+
+	struct
+	{
+		int rename_score;
+		int mode_head;
+		int mode_index;
+		int mode_worktree;
+		unsigned char sha1_head[GIT_SHA1_RAWSZ];
+		unsigned char sha1_index[GIT_SHA1_RAWSZ];
+	} porcelain_v2;
+
 	unsigned dirty_submodule       : 2;
 	unsigned new_submodule_commits : 1;
 };
@@ -48,6 +59,7 @@ struct wt_status_change_data {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_PORCELAIN_V2,
 
 	STATUS_FORMAT_UNSPECIFIED
  };
@@ -119,6 +131,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
+void wt_porcelain_v2_print(struct wt_status *s);
 
 __attribute__((format (printf, 3, 4)))
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
-- 
2.8.0.rc4.17.gac42084.dirty

