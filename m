From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/8] wt-status: move many global settings to wt_status
 structure
Date: Mon, 10 Aug 2009 01:54:19 -0700
Message-ID: <1249894465-11018-3-git-send-email-gitster@pobox.com>
References: <1249894465-11018-1-git-send-email-gitster@pobox.com>
 <1249894465-11018-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQeT-0007fg-O9
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZHJIyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZHJIyc
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:54:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbZHJIyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:54:31 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F3E569D
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53831569C for
 <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:31 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.173.g72959
In-Reply-To: <1249894465-11018-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6BC6D052-858B-11DE-BA81-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125414>

Turn four global variables (wt_status_use_color, show_tracked_files,
wt_status_relative_paths, and wt_status_submodule_summary) into fields of
wt_status structure.  Get rid of "untracked" field that was used only to
keep track of otherwise available information redundantly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |   87 +++++++++++++++++++++++++++++------------------------
 wt-status.c      |   81 +++++++++++++++++++++++++-------------------------
 wt-status.h      |    9 +++--
 3 files changed, 93 insertions(+), 84 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 3a7e35d..ca36ba2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -343,27 +343,24 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	return false_lock.filename;
 }
 
-static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn)
+static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
+		      struct wt_status *s)
 {
-	struct wt_status s;
-
-	wt_status_prepare(&s);
-	if (wt_status_relative_paths)
-		s.prefix = prefix;
+	if (s->wt_status_relative_paths)
+		s->prefix = prefix;
 
 	if (amend) {
-		s.amend = 1;
-		s.reference = "HEAD^1";
+		s->amend = 1;
+		s->reference = "HEAD^1";
 	}
-	s.verbose = verbose;
-	s.untracked = (show_untracked_files == SHOW_ALL_UNTRACKED_FILES);
-	s.index_file = index_file;
-	s.fp = fp;
-	s.nowarn = nowarn;
+	s->verbose = verbose;
+	s->index_file = index_file;
+	s->fp = fp;
+	s->nowarn = nowarn;
 
-	wt_status_print(&s);
+	wt_status_print(s);
 
-	return s.commitable;
+	return s->commitable;
 }
 
 static int is_a_merge(const unsigned char *sha1)
@@ -417,7 +414,8 @@ static void determine_author_info(void)
 	author_date = date;
 }
 
-static int prepare_to_commit(const char *index_file, const char *prefix)
+static int prepare_to_commit(const char *index_file, const char *prefix,
+			     struct wt_status *s)
 {
 	struct stat statbuf;
 	int commitable, saved_color_setting;
@@ -559,10 +557,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		if (ident_shown)
 			fprintf(fp, "#\n");
 
-		saved_color_setting = wt_status_use_color;
-		wt_status_use_color = 0;
-		commitable = run_status(fp, index_file, prefix, 1);
-		wt_status_use_color = saved_color_setting;
+		saved_color_setting = s->wt_status_use_color;
+		s->wt_status_use_color = 0;
+		commitable = run_status(fp, index_file, prefix, 1, s);
+		s->wt_status_use_color = saved_color_setting;
 	} else {
 		unsigned char sha1[20];
 		const char *parent = "HEAD";
@@ -583,7 +581,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 
 	if (!commitable && !in_merge && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {
-		run_status(stdout, index_file, prefix, 0);
+		run_status(stdout, index_file, prefix, 0, s);
 		return 0;
 	}
 
@@ -695,7 +693,8 @@ static const char *find_author_by_nickname(const char *name)
 
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[],
-				      const char *prefix)
+				      const char *prefix,
+				      struct wt_status *s)
 {
 	int f = 0;
 
@@ -798,11 +797,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (!untracked_files_arg)
 		; /* default already initialized */
 	else if (!strcmp(untracked_files_arg, "no"))
-		show_untracked_files = SHOW_NO_UNTRACKED_FILES;
+		s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
 	else if (!strcmp(untracked_files_arg, "normal"))
-		show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+		s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	else if (!strcmp(untracked_files_arg, "all"))
-		show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+		s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
 	else
 		die("Invalid untracked files mode '%s'", untracked_files_arg);
 
@@ -814,13 +813,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	return argc;
 }
 
-static int dry_run_commit(int argc, const char **argv, const char *prefix)
+static int dry_run_commit(int argc, const char **argv, const char *prefix,
+			  struct wt_status *s)
 {
 	int commitable;
 	const char *index_file;
 
 	index_file = prepare_index(argc, argv, prefix, 1);
-	commitable = run_status(stdout, index_file, prefix, 0);
+	commitable = run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
 
 	return commitable ? 0 : 1;
@@ -828,14 +828,18 @@ static int dry_run_commit(int argc, const char **argv, const char *prefix)
 
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
-	git_config(git_status_config, NULL);
-	if (wt_status_use_color == -1)
-		wt_status_use_color = git_use_color_default;
+	struct wt_status s;
+
+	wt_status_prepare(&s);
+	git_config(git_status_config, &s);
+	if (s.wt_status_use_color == -1)
+		s.wt_status_use_color = git_use_color_default;
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
 
-	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
-	return dry_run_commit(argc, argv, prefix);
+	argc = parse_and_validate_options(argc, argv, builtin_status_usage,
+					  prefix, &s);
+	return dry_run_commit(argc, argv, prefix, &s);
 }
 
 static void print_summary(const char *prefix, const unsigned char *sha1)
@@ -887,10 +891,12 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
+	struct wt_status *s = cb;
+
 	if (!strcmp(k, "commit.template"))
 		return git_config_string(&template_file, k, v);
 
-	return git_status_config(k, v, cb);
+	return git_status_config(k, v, s);
 }
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
@@ -903,21 +909,24 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	int allow_fast_forward = 1;
+	struct wt_status s;
 
-	git_config(git_commit_config, NULL);
+	wt_status_prepare(&s);
+	git_config(git_commit_config, &s);
 
-	if (wt_status_use_color == -1)
-		wt_status_use_color = git_use_color_default;
+	if (s.wt_status_use_color == -1)
+		s.wt_status_use_color = git_use_color_default;
 
-	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
+	argc = parse_and_validate_options(argc, argv, builtin_commit_usage,
+					  prefix, &s);
 	if (dry_run)
-		return dry_run_commit(argc, argv, prefix);
+		return dry_run_commit(argc, argv, prefix, &s);
 
 	index_file = prepare_index(argc, argv, prefix, 0);
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
-	if (!prepare_to_commit(index_file, prefix)) {
+	if (!prepare_to_commit(index_file, prefix, &s)) {
 		rollback_index_files();
 		return 1;
 	}
diff --git a/wt-status.c b/wt-status.c
index 97fedfa..c84a18a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -11,9 +11,6 @@
 #include "run-command.h"
 #include "remote.h"
 
-int wt_status_relative_paths = 1;
-int wt_status_use_color = -1;
-static int wt_status_submodule_summary;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
@@ -23,8 +20,6 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
 };
 
-enum untracked_status_type show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-
 static int parse_status_slot(const char *var, int offset)
 {
 	if (!strcasecmp(var+offset, "header"))
@@ -43,9 +38,9 @@ static int parse_status_slot(const char *var, int offset)
 	die("bad config variable '%s'", var);
 }
 
-static const char *color(int slot)
+static const char *color(int slot, struct wt_status *s)
 {
-	return wt_status_use_color > 0 ? wt_status_colors[slot] : "";
+	return s->wt_status_use_color > 0 ? wt_status_colors[slot] : "";
 }
 
 void wt_status_prepare(struct wt_status *s)
@@ -54,6 +49,9 @@ void wt_status_prepare(struct wt_status *s)
 	const char *head;
 
 	memset(s, 0, sizeof(*s));
+	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+	s->wt_status_use_color = -1;
+	s->wt_status_relative_paths = 1;
 	head = resolve_ref("HEAD", sha1, 0, NULL);
 	s->branch = head ? xstrdup(head) : NULL;
 	s->reference = "HEAD";
@@ -64,7 +62,7 @@ void wt_status_prepare(struct wt_status *s)
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
 {
-	const char *c = color(WT_STATUS_HEADER);
+	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
 	if (!s->is_initial)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
@@ -76,7 +74,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 
 static void wt_status_print_cached_header(struct wt_status *s)
 {
-	const char *c = color(WT_STATUS_HEADER);
+	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
 	if (!s->is_initial) {
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
@@ -89,7 +87,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 static void wt_status_print_dirty_header(struct wt_status *s,
 					 int has_deleted)
 {
-	const char *c = color(WT_STATUS_HEADER);
+	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
 	if (!has_deleted)
 		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
@@ -101,7 +99,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 
 static void wt_status_print_untracked_header(struct wt_status *s)
 {
-	const char *c = color(WT_STATUS_HEADER);
+	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Untracked files:");
 	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
 	color_fprintf_ln(s->fp, c, "#");
@@ -109,7 +107,7 @@ static void wt_status_print_untracked_header(struct wt_status *s)
 
 static void wt_status_print_trailer(struct wt_status *s)
 {
-	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
 
 #define quote_path quote_path_relative
@@ -117,13 +115,13 @@ static void wt_status_print_trailer(struct wt_status *s)
 static void wt_status_print_unmerged_data(struct wt_status *s,
 					  struct string_list_item *it)
 {
-	const char *c = color(WT_STATUS_UNMERGED);
+	const char *c = color(WT_STATUS_UNMERGED, s);
 	struct wt_status_change_data *d = it->util;
 	struct strbuf onebuf = STRBUF_INIT;
 	const char *one, *how = "bug";
 
 	one = quote_path(it->string, -1, &onebuf, s->prefix);
-	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 	switch (d->stagemask) {
 	case 1: how = "both deleted:"; break;
 	case 2: how = "added by us:"; break;
@@ -142,7 +140,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 					struct string_list_item *it)
 {
 	struct wt_status_change_data *d = it->util;
-	const char *c = color(change_type);
+	const char *c = color(change_type, s);
 	int status = status;
 	char *one_name;
 	char *two_name;
@@ -164,7 +162,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	one = quote_path(one_name, -1, &onebuf, s->prefix);
 	two = quote_path(two_name, -1, &twobuf, s->prefix);
 
-	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 	switch (status) {
 	case DIFF_STATUS_ADDED:
 		color_fprintf(s->fp, c, "new file:   %s", one);
@@ -450,7 +448,7 @@ static void wt_status_print_submodule_summary(struct wt_status *s)
 		NULL
 	};
 
-	sprintf(summary_limit, "%d", wt_status_submodule_summary);
+	sprintf(summary_limit, "%d", s->wt_status_submodule_summary);
 	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
 
 	memset(&sm_summary, 0, sizeof(sm_summary));
@@ -471,8 +469,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 	struct strbuf buf = STRBUF_INIT;
 
 	memset(&dir, 0, sizeof(dir));
-
-	if (!s->untracked)
+	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
@@ -487,8 +484,8 @@ static void wt_status_print_untracked(struct wt_status *s)
 			wt_status_print_untracked_header(s);
 			shown_header = 1;
 		}
-		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s",
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED, s), "%s",
 				quote_path(ent->name, ent->len,
 					&buf, s->prefix));
 	}
@@ -532,15 +529,15 @@ static void wt_status_print_tracking(struct wt_status *s)
 		return;
 
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
 				 "# %.*s", (int)(ep - cp), cp);
-	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
 
 void wt_status_print(struct wt_status *s)
 {
 	unsigned char sha1[20];
-	const char *branch_color = color(WT_STATUS_HEADER);
+	const char *branch_color = color(WT_STATUS_HEADER, s);
 
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
 	if (s->branch) {
@@ -550,10 +547,10 @@ void wt_status_print(struct wt_status *s)
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
-			branch_color = color(WT_STATUS_NOBRANCH);
+			branch_color = color(WT_STATUS_NOBRANCH, s);
 			on_what = "Not currently on any branch.";
 		}
-		color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
 		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
@@ -562,17 +559,17 @@ void wt_status_print(struct wt_status *s)
 	wt_status_collect_changes(s);
 
 	if (s->is_initial) {
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commit");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 	}
 
 	wt_status_print_unmerged(s);
 	wt_status_print_updated(s);
 	wt_status_print_changed(s);
-	if (wt_status_submodule_summary)
+	if (s->wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
-	if (show_untracked_files)
+	if (s->show_untracked_files)
 		wt_status_print_untracked(s);
 	else if (s->commitable)
 		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
@@ -590,7 +587,7 @@ void wt_status_print(struct wt_status *s)
 			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)
 			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
-		else if (!show_untracked_files)
+		else if (!s->show_untracked_files)
 			printf("nothing to commit (use -u to show untracked files)\n");
 		else
 			printf("nothing to commit (working directory clean)\n");
@@ -599,15 +596,17 @@ void wt_status_print(struct wt_status *s)
 
 int git_status_config(const char *k, const char *v, void *cb)
 {
+	struct wt_status *s = cb;
+
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
-		wt_status_submodule_summary = git_config_bool_or_int(k, v, &is_bool);
-		if (is_bool && wt_status_submodule_summary)
-			wt_status_submodule_summary = -1;
+		s->wt_status_submodule_summary = git_config_bool_or_int(k, v, &is_bool);
+		if (is_bool && s->wt_status_submodule_summary)
+			s->wt_status_submodule_summary = -1;
 		return 0;
 	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
-		wt_status_use_color = git_config_colorbool(k, v, -1);
+		s->wt_status_use_color = git_config_colorbool(k, v, -1);
 		return 0;
 	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
@@ -618,21 +617,21 @@ int git_status_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "status.relativepaths")) {
-		wt_status_relative_paths = git_config_bool(k, v);
+		s->wt_status_relative_paths = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "status.showuntrackedfiles")) {
 		if (!v)
 			return config_error_nonbool(k);
 		else if (!strcmp(v, "no"))
-			show_untracked_files = SHOW_NO_UNTRACKED_FILES;
+			s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
 		else if (!strcmp(v, "normal"))
-			show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+			s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 		else if (!strcmp(v, "all"))
-			show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+			s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
 		else
 			return error("Invalid untracked files mode '%s'", v);
 		return 0;
 	}
-	return git_diff_ui_config(k, v, cb);
+	return git_diff_ui_config(k, v, NULL);
 }
diff --git a/wt-status.h b/wt-status.h
index f80142f..3d7fe30 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -18,7 +18,6 @@ enum untracked_status_type {
 	SHOW_NORMAL_UNTRACKED_FILES,
 	SHOW_ALL_UNTRACKED_FILES
 };
-extern enum untracked_status_type show_untracked_files;
 
 struct wt_status_change_data {
 	int worktree_status;
@@ -33,8 +32,12 @@ struct wt_status {
 	const char *reference;
 	int verbose;
 	int amend;
-	int untracked;
 	int nowarn;
+	int wt_status_use_color;
+	int wt_status_relative_paths;
+	int wt_status_submodule_summary;
+	enum untracked_status_type show_untracked_files;
+
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
@@ -46,8 +49,6 @@ struct wt_status {
 };
 
 int git_status_config(const char *var, const char *value, void *cb);
-extern int wt_status_use_color;
-extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect_changes(struct wt_status *s);
-- 
1.6.4.173.g72959
