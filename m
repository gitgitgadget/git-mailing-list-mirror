From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] wt-status.c: rework the way changes to the index and
 work tree are summarized
Date: Wed,  5 Aug 2009 02:15:44 -0700
Message-ID: <1249463746-21538-4-git-send-email-gitster@pobox.com>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYcbV-00082b-44
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933918AbZHEJQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933837AbZHEJQD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:16:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933832AbZHEJP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:15:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 846C4210B7
	for <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B2678210B5 for
 <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:57 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.18.g07a4a
In-Reply-To: <1249463746-21538-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 966005DE-81A0-11DE-A02C-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124881>

Introduce a new infrastructure to find and summarize changes in a single
string list, and rewrite wt_status_print_{updated,changed} functions using
it.

The goal of this change is to give more information on conflicted paths in
the status output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |   13 ++-
 wt-status.c      |  252 ++++++++++++++++++++++++++++++++++++++++++++----------
 wt-status.h      |   11 +++
 3 files changed, 226 insertions(+), 50 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 4bcce06..6d12c2e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -217,12 +217,15 @@ static void create_base_index(void)
 		exit(128); /* We've already reported the error, finish dying */
 }
 
-static char *prepare_index(int argc, const char **argv, const char *prefix)
+static char *prepare_index(int argc, const char **argv, const char *prefix, int is_status)
 {
 	int fd;
 	struct string_list partial;
 	const char **pathspec = NULL;
+	int refresh_flags = REFRESH_QUIET;
 
+	if (is_status)
+		refresh_flags |= REFRESH_UNMERGED;
 	if (interactive) {
 		if (interactive_add(argc, argv, prefix) != 0)
 			die("interactive add failed");
@@ -253,7 +256,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	if (all || (also && pathspec && *pathspec)) {
 		int fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
-		refresh_cache(REFRESH_QUIET);
+		refresh_cache(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die("unable to write new_index file");
@@ -272,7 +275,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	 */
 	if (!pathspec || !*pathspec) {
 		fd = hold_locked_index(&index_lock, 1);
-		refresh_cache(REFRESH_QUIET);
+		refresh_cache(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(&index_lock))
 			die("unable to write new_index file");
@@ -825,7 +828,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
 
-	index_file = prepare_index(argc, argv, prefix);
+	index_file = prepare_index(argc, argv, prefix, 1);
 
 	commitable = run_status(stdout, index_file, prefix, 0);
 
@@ -907,7 +910,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
 
-	index_file = prepare_index(argc, argv, prefix);
+	index_file = prepare_index(argc, argv, prefix, 0);
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
diff --git a/wt-status.c b/wt-status.c
index 47735d8..1614352 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -20,6 +20,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
 	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
 	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
+	GIT_COLOR_YELLOW, /* WT_STATUS_UNMERGED */
 };
 
 enum untracked_status_type show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
@@ -56,6 +57,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
+	s->change.strdup_strings = 1;
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -98,18 +100,35 @@ static void wt_status_print_trailer(struct wt_status *s)
 
 #define quote_path quote_path_relative
 
-static void wt_status_print_filepair(struct wt_status *s,
-				     int t, struct diff_filepair *p)
+static void wt_status_print_change_data(struct wt_status *s,
+					int change_type,
+					struct string_list_item *it)
 {
-	const char *c = color(t);
+	struct wt_status_change_data *d = it->util;
+	const char *c = color(change_type);
+	int status = status;
+	char *one_name;
+	char *two_name;
 	const char *one, *two;
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
 
-	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
-	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
+	one_name = two_name = it->string;
+	switch (change_type) {
+	case WT_STATUS_UPDATED:
+		status = d->index_status;
+		if (d->head_path)
+			one_name = d->head_path;
+		break;
+	case WT_STATUS_CHANGED:
+		status = d->worktree_status;
+		break;
+	}
+
+	one = quote_path(one_name, -1, &onebuf, s->prefix);
+	two = quote_path(two_name, -1, &twobuf, s->prefix);
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-	switch (p->status) {
+	switch (status) {
 	case DIFF_STATUS_ADDED:
 		color_fprintf(s->fp, c, "new file:   %s", one);
 		break;
@@ -135,64 +154,114 @@ static void wt_status_print_filepair(struct wt_status *s,
 		color_fprintf(s->fp, c, "unmerged:   %s", one);
 		break;
 	default:
-		die("bug: unhandled diff status %c", p->status);
+		die("bug: unhandled diff status %c", status);
 	}
 	fprintf(s->fp, "\n");
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
 }
 
-static void wt_status_print_updated_cb(struct diff_queue_struct *q,
-		struct diff_options *options,
-		void *data)
+static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
 {
 	struct wt_status *s = data;
-	int shown_header = 0;
 	int i;
+
+	if (!q->nr)
+		return;
+	s->workdir_dirty = 1;
 	for (i = 0; i < q->nr; i++) {
-		if (q->queue[i]->status == 'U')
-			continue;
-		if (!shown_header) {
-			wt_status_print_cached_header(s);
-			s->commitable = 1;
-			shown_header = 1;
+		struct diff_filepair *p;
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+
+		p = q->queue[i];
+		it = string_list_insert(p->one->path, &s->change);
+		d = it->util;
+		if (!d) {
+			d = xcalloc(1, sizeof(*d));
+			it->util = d;
 		}
-		wt_status_print_filepair(s, WT_STATUS_UPDATED, q->queue[i]);
+		if (!d->worktree_status)
+			d->worktree_status = p->status;
 	}
-	if (shown_header)
-		wt_status_print_trailer(s);
 }
 
-static void wt_status_print_changed_cb(struct diff_queue_struct *q,
-                        struct diff_options *options,
-                        void *data)
+static int unmerged_mask(const char *path)
+{
+	int pos, mask;
+	struct cache_entry *ce;
+
+	pos = cache_name_pos(path, strlen(path));
+	if (0 <= pos)
+		return 0;
+
+	mask = 0;
+	pos = -pos-1;
+	while (pos <= active_nr) {
+		ce = active_cache[pos++];
+		if (strcmp(ce->name, path))
+			break;
+		mask |= (1 << ce_stage(ce));
+	}
+	return mask;
+}
+
+static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
 {
 	struct wt_status *s = data;
 	int i;
-	if (q->nr) {
-		int has_deleted = 0;
-		s->workdir_dirty = 1;
-		for (i = 0; i < q->nr; i++)
-			if (q->queue[i]->status == DIFF_STATUS_DELETED) {
-				has_deleted = 1;
-				break;
-			}
-		wt_status_print_dirty_header(s, has_deleted);
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p;
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+
+		p = q->queue[i];
+		it = string_list_insert(p->two->path, &s->change);
+		d = it->util;
+		if (!d) {
+			d = xcalloc(1, sizeof(*d));
+			it->util = d;
+		}
+		if (!d->index_status)
+			d->index_status = p->status;
+		switch (p->status) {
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			d->head_path = xstrdup(p->one->path);
+			break;
+		case DIFF_STATUS_UNMERGED:
+			d->stagemask = unmerged_mask(p->two->path);
+			break;
+		}
 	}
-	for (i = 0; i < q->nr; i++)
-		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
-	if (q->nr)
-		wt_status_print_trailer(s);
 }
 
-static void wt_status_print_updated(struct wt_status *s)
+static void wt_status_collect_changes_worktree(struct wt_status *s)
+{
+	struct rev_info rev;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = wt_status_collect_changed_cb;
+	rev.diffopt.format_callback_data = s;
+	run_diff_files(&rev, 0);
+}
+
+static void wt_status_collect_changes_index(struct wt_status *s)
 {
 	struct rev_info rev;
+
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev,
 		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_updated_cb;
+	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 200;
@@ -200,15 +269,106 @@ static void wt_status_print_updated(struct wt_status *s)
 	run_diff_index(&rev, 1);
 }
 
+static void wt_status_collect_changes_initial(struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < active_nr; i++) {
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+		struct cache_entry *ce = active_cache[i];
+
+		it = string_list_insert(ce->name, &s->change);
+		d = it->util;
+		if (!d) {
+			d = xcalloc(1, sizeof(*d));
+			it->util = d;
+		}
+		if (ce_stage(ce)) {
+			d->index_status = DIFF_STATUS_UNMERGED;
+			d->stagemask |= (1 << (ce_stage(ce) - 1));
+		}
+		else
+			d->index_status = DIFF_STATUS_ADDED;
+	}
+}
+
+void wt_status_collect_changes(struct wt_status *s)
+{
+	wt_status_collect_changes_worktree(s);
+
+	if (s->is_initial)
+		wt_status_collect_changes_initial(s);
+	else
+		wt_status_collect_changes_index(s);
+}
+
+static void wt_status_print_updated(struct wt_status *s)
+{
+	int shown_header = 0;
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (!d->index_status ||
+		    d->index_status == DIFF_STATUS_UNMERGED)
+			continue;
+		if (!shown_header) {
+			wt_status_print_cached_header(s);
+			s->commitable = 1;
+			shown_header = 1;
+		}
+		wt_status_print_change_data(s, WT_STATUS_UPDATED, it);
+	}
+	if (shown_header)
+		wt_status_print_trailer(s);
+}
+
+/*
+ * -1 : has delete
+ *  0 : no change
+ *  1 : some change but no delete
+ */
+static int wt_status_check_worktree_changes(struct wt_status *s)
+{
+	int i;
+	int changes = 0;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		d = s->change.items[i].util;
+		if (!d->worktree_status)
+			continue;
+		changes = 1;
+		if (d->worktree_status == DIFF_STATUS_DELETED)
+			return -1;
+	}
+	return changes;
+}
+
 static void wt_status_print_changed(struct wt_status *s)
 {
-	struct rev_info rev;
-	init_revisions(&rev, "");
-	setup_revisions(0, NULL, &rev, NULL);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_changed_cb;
-	rev.diffopt.format_callback_data = s;
-	run_diff_files(&rev, 0);
+	int i;
+	int worktree_changes = wt_status_check_worktree_changes(s);
+
+	if (!worktree_changes)
+		return;
+
+	wt_status_print_dirty_header(s, worktree_changes < 0);
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (!d->worktree_status)
+			continue;
+		wt_status_print_change_data(s, WT_STATUS_CHANGED, it);
+	}
+	wt_status_print_trailer(s);
 }
 
 static void wt_status_print_submodule_summary(struct wt_status *s)
@@ -337,6 +497,8 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
+	wt_status_collect_changes(s);
+
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit");
diff --git a/wt-status.h b/wt-status.h
index 78add09..f80142f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -2,6 +2,7 @@
 #define STATUS_H
 
 #include <stdio.h>
+#include "string-list.h"
 
 enum color_wt_status {
 	WT_STATUS_HEADER,
@@ -9,6 +10,7 @@ enum color_wt_status {
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
+	WT_STATUS_UNMERGED,
 };
 
 enum untracked_status_type {
@@ -18,6 +20,13 @@ enum untracked_status_type {
 };
 extern enum untracked_status_type show_untracked_files;
 
+struct wt_status_change_data {
+	int worktree_status;
+	int index_status;
+	int stagemask;
+	char *head_path;
+};
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -33,6 +42,7 @@ struct wt_status {
 	const char *index_file;
 	FILE *fp;
 	const char *prefix;
+	struct string_list change;
 };
 
 int git_status_config(const char *var, const char *value, void *cb);
@@ -40,5 +50,6 @@ extern int wt_status_use_color;
 extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+void wt_status_collect_changes(struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.6.4.18.g07a4a
