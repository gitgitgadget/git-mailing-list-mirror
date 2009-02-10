From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 01:51:07 +0100
Message-ID: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 01:52:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWgrv-0004Dr-FY
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 01:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZBJAvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 19:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbZBJAvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 19:51:16 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38374 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZBJAvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 19:51:15 -0500
Received: by bwz5 with SMTP id 5so2074454bwz.13
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 16:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ACvEokD71Sf/mRQPJyKBI+10KYKjkxxvxbkxa6ao9mI=;
        b=lT27iLLz/DxKA/yoWAPlJFbvqqrE9+Elsj4JN5aNB4IBERHaPS5sYbFFxHl3i6mGyH
         iNjWaJhPUxZll75BmApHN06Ldu9i775UlZvYwdE3kqtc/nszWkI+5EcCwlLY6j4enMCY
         UAbGd1ihHDoLQ/MLMB7aaho81HGePOkHMYXVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G251jdkA9JCR4HOkHAFEFGuqIUMLIMXqoiRaIW7JZFkU+C2FOYqrWg/vOiJHZ83nEc
         YnN6hOYEgWy02cvgOM+nm/GvRVrbfsEhgg26kMwsnE9PvTYKQbNrX5L8sCoxGODBHR36
         0QT34h2k1bLsSEZRFUCFGsPONmD1OvMwnUFsM=
Received: by 10.103.228.19 with SMTP id f19mr423604mur.32.1234227072131;
        Mon, 09 Feb 2009 16:51:12 -0800 (PST)
Received: from localhost (p54BBDC9B.dip.t-dialin.net [84.187.220.155])
        by mx.google.com with ESMTPS id y2sm579722mug.15.2009.02.09.16.51.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Feb 2009 16:51:11 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.11.gc8cd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109169>

As discussed recently I started taking Junio's shortstatus patch
from October 25th 2008 and integrated it into current master.

This revision does work as advertised by Junio and v0 also did.

This revision also implements an experimental --mini param to
shortstatus which prints the following:
 anything modified          -> * (working)
 anything added             -> + (working)
 anything untracked/unknown -> ? (not yet implemented)

So if you have a repo where one file is modified,
a new file is added and an unknown file exists and
is not ignored 'shortstatus --mini' prints:
+*?.

This is really useful for enhancing a Git enabled
shell prompt with small but important information.

Right now this is basically Junio's shortstatus
from Oct 25th 2008 with no substantial change
except a line or two.

Adding git 'shortstatus --mini' to PS1 is not noticeable or 1sec
maximum in my tree. As a worst case it takes 10secs in a clone
of WebKit.git.

TODO:
 - print ? if untracked/unknown found
 - maybe implement git-ministatus instead of git-shortstatus --mini
 - as Junio mentioned maybe we should not print the index_score
 - peer review (mini clause/mode, especially the switch-case)
 - peer review rest of the patch

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
.gitignore       |    1 
 Makefile         |    1 
 builtin-commit.c |   92 +++++++++++++++++++++++
 builtin-revert.c |    1 
 builtin.h        |    1 
 git.c            |    1 
 wt-status.c      |  213 +++++++++++++++++++++++++++++++++++++++++++------------
 wt-status.h      |    9 ++
 8 files changed, 273 insertions(+), 46 deletions(-)

diff --git a/.gitignore b/.gitignore
index 13311f1..055eb54 100644
--- a/.gitignore
+++ b/.gitignore
@@ -115,6 +115,7 @@ git-send-pack
 git-sh-setup
 git-shell
 git-shortlog
+git-shortstatus
 git-show
 git-show-branch
 git-show-index
diff --git a/Makefile b/Makefile
index 27b9569..a0ca137 100644
--- a/Makefile
+++ b/Makefile
@@ -330,6 +330,7 @@ BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
+BUILT_INS += git-shortstatus$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
diff --git a/builtin-commit.c b/builtin-commit.c
index d6a3a62..9267d26 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -14,6 +14,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "revision.h"
+#include "string-list.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "refs.h"
@@ -21,7 +22,6 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
-#include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
 
@@ -35,6 +35,11 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
+static const char * const builtin_shortstatus_usage[] = {
+	"git shortstatus [options] [--] <filepattern>...",
+	NULL
+};
+
 static unsigned char head_sha1[20], merge_head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
@@ -51,7 +56,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty;
+static int quiet, verbose, no_verify, allow_empty, mini;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -107,6 +112,7 @@ static struct option builtin_commit_options[] = {
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
+	OPT_BOOLEAN(0, "mini", &mini, "print mini shortstatus"),
 
 	OPT_END()
 };
@@ -821,6 +827,88 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	return argc;
 }
 
+int cmd_shortstatus(int argc, const char **argv, const char *prefix)
+{
+	struct wt_status s;
+	int i;
+	int c, a, u;
+
+	c = a = u = 0;
+
+	argc = parse_and_validate_options(argc, argv, builtin_shortstatus_usage, prefix);
+	read_cache();
+	refresh_cache(REFRESH_QUIET);
+	wt_status_prepare(&s);
+	wt_status_collect_changes(&s);
+	if (mini) {
+		for (i = 0; i < s.change.nr; i++) {
+			struct wt_status_change_data *d;
+			struct string_list_item *it;
+
+			it = &(s.change.items[i]);
+			d = it->util;
+			switch (d->index_status) {
+				case DIFF_STATUS_ADDED:
+					a = 1;
+					break;
+				case 0:
+				case DIFF_STATUS_COPIED:
+				case DIFF_STATUS_DELETED:
+				case DIFF_STATUS_MODIFIED:
+				case DIFF_STATUS_RENAMED:
+				case DIFF_STATUS_TYPE_CHANGED:
+					c = 1;
+					break;
+				default:
+				case DIFF_STATUS_UNKNOWN:
+				case DIFF_STATUS_UNMERGED:
+					u = 1;
+					break;
+			}
+		}
+		if (c)
+			printf("*");
+		if (a)
+			printf("+");
+		if (u)
+			printf("?");
+	} else {
+		for (i = 0; i < s.change.nr; i++) {
+			struct wt_status_change_data *d;
+			struct string_list_item *it;
+			char pfx[1 + 3 + 1 + 1];
+
+			it = &(s.change.items[i]);
+			d = it->util;
+			switch (d->index_status) {
+				case DIFF_STATUS_COPIED:
+				case DIFF_STATUS_RENAMED:
+					sprintf(pfx, "%c%3d",
+							d->index_status,
+							(int)(d->index_score * 100 / MAX_SCORE));
+					break;
+				case 0:
+					memcpy(pfx, "	", 4);
+					break;
+				default:
+					sprintf(pfx, "%c	  ", d->index_status);
+					break;
+			}
+			if (!d->worktree_status)
+				pfx[4] = ' ';
+			else
+				pfx[4] = d->worktree_status;
+			pfx[5] = '\0';
+			printf("%s ", pfx);
+			if (d->head_path)
+				printf("%s -> ", d->head_path);
+			printf("%s\n", it->string);
+		}
+
+	}
+	return 0;
+}
+
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	const char *index_file;
diff --git a/builtin-revert.c b/builtin-revert.c
index d48313c..7dd7646 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
+#include "string-list.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "exec_cmd.h"
diff --git a/builtin.h b/builtin.h
index 1495cf6..f054fc7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -94,6 +94,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_shortstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index c2b181e..4c0fa44 100644
--- a/git.c
+++ b/git.c
@@ -344,6 +344,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
+		{ "shortstatus", cmd_shortstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
diff --git a/wt-status.c b/wt-status.c
index 96ff2f8..18042dc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "string-list.h"
 #include "wt-status.h"
 #include "color.h"
 #include "object.h"
@@ -56,6 +57,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
+	s->change.strdup_strings = 1;
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -98,18 +100,23 @@ static void wt_status_print_trailer(struct wt_status *s)
 
 #define quote_path quote_path_relative
 
-static void wt_status_print_filepair(struct wt_status *s,
-				     int t, struct diff_filepair *p)
+static void wt_status_print_change_data(struct wt_status *s,
+						int t,
+						int status,
+						char *one_name,
+						char *two_name,
+						int score)
 {
 	const char *c = color(t);
 	const char *one, *two;
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
 
-	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
-	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
+	one = quote_path(one_name, -1, &onebuf, s->prefix);
+	two = quote_path(two_name, -1, &twobuf, s->prefix);
+
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-	switch (p->status) {
+	switch (status) {
 	case DIFF_STATUS_ADDED:
 		color_fprintf(s->fp, c, "new file:   %s", one);
 		break;
@@ -135,64 +142,88 @@ static void wt_status_print_filepair(struct wt_status *s,
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
+							struct diff_options *options,
+							void *data)
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
-		}
-		wt_status_print_filepair(s, WT_STATUS_UPDATED, q->queue[i]);
+		struct diff_filepair *p;
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+
+		p = q->queue[i];
+
+		d = xcalloc(1, sizeof(*d));
+		d->worktree_status = p->status;
+		it = string_list_insert(p->one->path, &s->change);
+		it->util = d;
 	}
-	if (shown_header)
-		wt_status_print_trailer(s);
 }
 
-static void wt_status_print_changed_cb(struct diff_queue_struct *q,
-                        struct diff_options *options,
-                        void *data)
+static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
+							struct diff_options *options,
+							void *data)
 {
 	struct wt_status *s = data;
 	int i;
-	if (q->nr) {
-		int has_deleted = 0;
-		s->workdir_dirty = 1;
-		for (i = 0; i < q->nr; i++)
-			if (q->queue[i]->status == DIFF_STATUS_DELETED) {
-				has_deleted = 1;
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
+		d->index_status = p->status;
+		switch (p->status) {
+			case DIFF_STATUS_COPIED:
+			case DIFF_STATUS_RENAMED:
+				d->head_path = xstrdup(p->one->path);
+				d->index_score = p->score;
 				break;
-			}
-		wt_status_print_dirty_header(s, has_deleted);
+		}
 	}
-	for (i = 0; i < q->nr; i++)
-		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
-	if (q->nr)
-		wt_status_print_trailer(s);
 }
 
-static void wt_status_print_updated(struct wt_status *s)
+static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
 	struct rev_info rev;
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
+{
+	struct rev_info rev;
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
@@ -200,15 +231,107 @@ static void wt_status_print_updated(struct wt_status *s)
 	run_diff_index(&rev, 1);
 }
 
+static void wt_status_collect_changes_initial(struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < active_nr; i++) {
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+
+		it = string_list_insert(active_cache[i]->name, &s->change);
+		d = it->util;
+		if (!d) {
+			d = xcalloc(1, sizeof(*d));
+			it->util = d;
+		}
+		d->index_status = DIFF_STATUS_ADDED;
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
+		if (!d->index_status)
+			continue;
+		if (!shown_header) {
+			wt_status_print_cached_header(s);
+			s->commitable = 1;
+			shown_header = 1;
+		}
+		wt_status_print_change_data(s, WT_STATUS_UPDATED,
+				d->index_status,
+				d->head_path ? d->head_path : it->string,
+				it->string,
+				d->index_score);
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
+		wt_status_print_change_data(s, WT_STATUS_CHANGED,
+				d->worktree_status,
+				it->string,
+				it->string,
+				0);
+	}
+	wt_status_print_trailer(s);
 }
 
 static void wt_status_print_submodule_summary(struct wt_status *s)
@@ -338,6 +461,8 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
+	wt_status_collect_changes(s);
+
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit");
diff --git a/wt-status.h b/wt-status.h
index 78add09..00508c3 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -18,6 +18,13 @@ enum untracked_status_type {
 };
 extern enum untracked_status_type show_untracked_files;
 
+struct wt_status_change_data {
+	int worktree_status;
+	int index_status;
+	int index_score;
+	char *head_path;
+};
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -33,6 +40,7 @@ struct wt_status {
 	const char *index_file;
 	FILE *fp;
 	const char *prefix;
+	struct string_list change;
 };
 
 int git_status_config(const char *var, const char *value, void *cb);
@@ -40,5 +48,6 @@ extern int wt_status_use_color;
 extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+void wt_status_collect_changes(struct wt_status *s);
 
 #endif /* STATUS_H */
