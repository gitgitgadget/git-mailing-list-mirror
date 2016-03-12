From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 11/17] rebase-merge: introduce merge backend for builtin rebase
Date: Sat, 12 Mar 2016 18:46:31 +0800
Message-ID: <1457779597-6918-12-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh56-0005yz-3x
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbcCLKre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:34 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33173 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcCLKra (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:30 -0500
Received: by mail-pa0-f47.google.com with SMTP id fl4so118965312pad.0
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3kU+gOCx73Ays+iGqo/BWveU59yrONCN3GuscZhgOk=;
        b=SQhk0qhrtCVyPf9ZuWWDLC2U7ATcogiq0O96mHgV7RP/iu8ExhgavwxP3Z+fOgapmD
         wFONiXvrshpGw0RHKGltuXZmhwqac28Q9uh4HIFAY1NumqljOJseAdFFbaFoY8KTw75E
         v2gacbDL9MLJnQ2O3Zv66I5dshZmpbda+Riv2S8wuE3YhFDZBZKdq1OzQqb5oWxikpa2
         l/w1bmhO5gjUd4uomhPmLRFszfvGWDmzZcTXulTpnEppjPiitCkuUXRnwa9dC01wVa7/
         55DKIuQbkLaS1T+CWj9nviaRS3SsgHqqp19xKEsHbN4x2xJkGQfbL1KvXjX3NtzYDSUZ
         1ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H3kU+gOCx73Ays+iGqo/BWveU59yrONCN3GuscZhgOk=;
        b=PBQUy8NIpt5olQcx8mjzlWQHrAF9dWqDqi7d7juQMO7C4yjcz58EavKf4IU9iSk3Y5
         abS8PbXuRbozUbQ+dd/u4uIRDhnxOHCl3cYOyGIhLNDM0WFzMwtVtOcMNHZLLqIcWY/r
         GLfYsY5uDGQkMJywpGNtpJjC7Qgp1J+D4KiIRyEmxJXGpykotuEktdzTpChqk1ThwdXl
         Hw2v8OeG4ulFoiwaN/kqYjy+TdDR4KTjqMV6dFt28bk4vlqROgS0G9yiq/mUTUGUX1+b
         Z4q5kE2sI7RTYxUOhXOKbXYu9D6jBdKSKrNfPuF+84WNRyyVA4LBQvl1hD0djjZp+oWH
         lTLQ==
X-Gm-Message-State: AD7BkJL1t2lI8Fpvbx2MJjeoSy0D+DNeI0LUKDAkVexTeo+AHUz8GySlemq4tDKeJAOXIw==
X-Received: by 10.66.178.238 with SMTP id db14mr21231572pac.157.1457779649098;
        Sat, 12 Mar 2016 02:47:29 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:28 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288737>

Since 58634db (rebase: Allow merge strategies to be used when rebasing,
2006-06-21), git-rebase supported rebasing with a merge strategy when
the -m switch is used.

Re-implement a skeletal version of the above method of rebasing in a new
rebase-merge backend for our builtin-rebase. This skeletal version is
only able to re-apply commits using the merge-recursive strategy, and is
unable to resume from a conflict. Subsequent patches will re-implement
all the missing features.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile         |   1 +
 builtin/rebase.c |  17 +++-
 rebase-merge.c   | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rebase-merge.h   |  28 ++++++
 4 files changed, 300 insertions(+), 2 deletions(-)
 create mode 100644 rebase-merge.c
 create mode 100644 rebase-merge.h

diff --git a/Makefile b/Makefile
index a2618ea..d43e068 100644
--- a/Makefile
+++ b/Makefile
@@ -781,6 +781,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-am.o
 LIB_OBJS += rebase-common.o
+LIB_OBJS += rebase-merge.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ec63d3b..6d42115 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -9,10 +9,12 @@
 #include "branch.h"
 #include "refs.h"
 #include "rebase-am.h"
+#include "rebase-merge.h"
 
 enum rebase_type {
 	REBASE_TYPE_NONE = 0,
-	REBASE_TYPE_AM
+	REBASE_TYPE_AM,
+	REBASE_TYPE_MERGE
 };
 
 static const char *rebase_dir(enum rebase_type type)
@@ -20,6 +22,8 @@ static const char *rebase_dir(enum rebase_type type)
 	switch (type) {
 	case REBASE_TYPE_AM:
 		return git_path_rebase_am_dir();
+	case REBASE_TYPE_MERGE:
+		return git_path_rebase_merge_dir();
 	default:
 		die("BUG: invalid rebase_type %d", type);
 	}
@@ -137,6 +141,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct rebase_options rebase_opts;
 	const char *onto_name = NULL;
 	const char *branch_name;
+	int do_merge = 0;
 
 	const char * const usage[] = {
 		N_("git rebase [options] [--onto <newbase>] [<upstream>] [<branch>]"),
@@ -146,6 +151,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Available options are")),
 		OPT_STRING(0, "onto", &onto_name, NULL,
 			N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL('m', "merge", &do_merge,
+			N_("use merging strategies to rebase")),
 		OPT_END()
 	};
 
@@ -225,7 +232,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Run the appropriate rebase backend */
-	{
+	if (do_merge) {
+		struct rebase_merge state;
+		rebase_merge_init(&state, rebase_dir(REBASE_TYPE_MERGE));
+		rebase_options_swap(&state.opts, &rebase_opts);
+		rebase_merge_run(&state);
+		rebase_merge_release(&state);
+	} else {
 		struct rebase_am state;
 		rebase_am_init(&state, rebase_dir(REBASE_TYPE_AM));
 		rebase_options_swap(&state.opts, &rebase_opts);
diff --git a/rebase-merge.c b/rebase-merge.c
new file mode 100644
index 0000000..dc96faf
--- /dev/null
+++ b/rebase-merge.c
@@ -0,0 +1,256 @@
+#include "cache.h"
+#include "rebase-merge.h"
+#include "run-command.h"
+#include "dir.h"
+#include "revision.h"
+
+GIT_PATH_FUNC(git_path_rebase_merge_dir, "rebase-merge");
+
+void rebase_merge_init(struct rebase_merge *state, const char *dir)
+{
+	if (!dir)
+		dir = git_path_rebase_merge_dir();
+	rebase_options_init(&state->opts);
+	state->dir = xstrdup(dir);
+	state->msgnum = 0;
+	state->end = 0;
+	state->prec = 4;
+}
+
+void rebase_merge_release(struct rebase_merge *state)
+{
+	rebase_options_release(&state->opts);
+	free(state->dir);
+}
+
+int rebase_merge_in_progress(const struct rebase_merge *state)
+{
+	const char *dir = state ? state->dir : git_path_rebase_merge_dir();
+	struct stat st;
+
+	if (lstat(dir, &st) || !S_ISDIR(st.st_mode))
+		return 0;
+
+	if (file_exists(mkpath("%s/interactive", dir)))
+		return 0;
+
+	return 1;
+}
+
+static const char *state_path(const struct rebase_merge *state, const char *filename)
+{
+	return mkpath("%s/%s", state->dir, filename);
+}
+
+static int read_state_file(const struct rebase_merge *state, const char *filename, struct strbuf *sb)
+{
+	const char *path = state_path(state, filename);
+	if (strbuf_read_file(sb, path, 0) < 0)
+		return error(_("could not read file %s"), path);
+	strbuf_trim(sb);
+	return 0;
+}
+
+static int read_state_ui(const struct rebase_merge *state, const char *filename, unsigned int *ui)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (read_state_file(state, filename, &sb) < 0) {
+		strbuf_release(&sb);
+		return -1;
+	}
+	if (strtoul_ui(sb.buf, 10, ui) < 0) {
+		strbuf_release(&sb);
+		return error(_("could not parse %s"), state_path(state, filename));
+	}
+	strbuf_release(&sb);
+	return 0;
+}
+
+static int read_state_oid(const struct rebase_merge *state, const char *filename, struct object_id *oid)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (read_state_file(state, filename, &sb) < 0) {
+		strbuf_release(&sb);
+		return -1;
+	}
+	if (sb.len != GIT_SHA1_HEXSZ || get_oid_hex(sb.buf, oid)) {
+		strbuf_release(&sb);
+		return error(_("could not parse %s"), state_path(state, filename));
+	}
+	strbuf_release(&sb);
+	return 0;
+}
+
+static int read_state_msgnum(const struct rebase_merge *state, unsigned int msgnum, struct object_id *oid)
+{
+	char *filename = xstrfmt("cmt.%u", msgnum);
+	int ret = read_state_oid(state, filename, oid);
+	free(filename);
+	return ret;
+}
+
+int rebase_merge_load(struct rebase_merge *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (rebase_options_load(&state->opts, state->dir) < 0)
+		return -1;
+
+	if (read_state_file(state, "onto_name", &sb) < 0)
+		return -1;
+	free(state->opts.onto_name);
+	state->opts.onto_name = strbuf_detach(&sb, NULL);
+
+	if (read_state_ui(state, "msgnum", &state->msgnum) < 0)
+		return -1;
+
+	if (read_state_ui(state, "end", &state->end) < 0)
+		return -1;
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+static void write_state_text(const struct rebase_merge *state, const char *filename, const char *text)
+{
+	write_file(state_path(state, filename), "%s", text);
+}
+
+static void write_state_ui(const struct rebase_merge *state, const char *filename, unsigned int ui)
+{
+	write_file(state_path(state, filename), "%u", ui);
+}
+
+static void write_state_oid(const struct rebase_merge *state, const char *filename, const struct object_id *oid)
+{
+	write_file(state_path(state, filename), "%s", oid_to_hex(oid));
+}
+
+static void rebase_merge_finish(struct rebase_merge *state)
+{
+	rebase_common_finish(&state->opts, state->dir);
+	printf_ln(_("All done."));
+}
+
+/**
+ * Setup commits to be rebased.
+ */
+static unsigned int setup_commits(const char *dir, const struct object_id *upstream, const struct object_id *head)
+{
+	struct rev_info revs;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct commit *commit;
+	unsigned int msgnum = 0;
+
+	init_revisions(&revs, NULL);
+	argv_array_pushl(&args, "rev-list", "--reverse", "--no-merges", NULL);
+	argv_array_pushf(&args, "%s..%s", oid_to_hex(upstream), oid_to_hex(head));
+	setup_revisions(args.argc, args.argv, &revs, NULL);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	while ((commit = get_revision(&revs)))
+		write_file(mkpath("%s/cmt.%u", dir, ++msgnum), "%s", oid_to_hex(&commit->object.oid));
+	reset_revision_walk();
+	argv_array_clear(&args);
+	return msgnum;
+}
+
+/**
+ * Merge HEAD with oid
+ */
+static void do_merge(struct rebase_merge *state, unsigned int msgnum, const struct object_id *oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int ret;
+
+	cp.git_cmd = 1;
+	argv_array_pushf(&cp.env_array, "GITHEAD_%s=HEAD~%u", oid_to_hex(oid), state->end - msgnum);
+	argv_array_pushf(&cp.env_array, "GITHEAD_HEAD=%s", state->opts.onto_name ? state->opts.onto_name : oid_to_hex(&state->opts.onto));
+	argv_array_push(&cp.args, "merge-recursive");
+	argv_array_pushf(&cp.args, "%s^", oid_to_hex(oid));
+	argv_array_push(&cp.args, "--");
+	argv_array_push(&cp.args, "HEAD");
+	argv_array_push(&cp.args, oid_to_hex(oid));
+	ret = run_command(&cp);
+	switch (ret) {
+	case 0:
+		break;
+	case 1:
+		if (state->opts.resolvemsg)
+			fprintf_ln(stderr, "%s", state->opts.resolvemsg);
+		exit(1);
+	case 2:
+		fprintf_ln(stderr, _("Strategy: recursive failed, try another"));
+		if (state->opts.resolvemsg)
+			fprintf_ln(stderr, "%s", state->opts.resolvemsg);
+		exit(1);
+	default:
+		fprintf_ln(stderr, _("Unknown exit code (%d) from command"), ret);
+		exit(1);
+	}
+
+	discard_cache();
+	read_cache();
+}
+
+/**
+ * Commit index
+ */
+static void do_commit(struct rebase_merge *state, unsigned int msgnum, const struct object_id *oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	if (!cache_has_uncommitted_changes()) {
+		printf_ln(_("Already applied: %0*d"), state->prec, msgnum);
+		return;
+	}
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "commit");
+	argv_array_push(&cp.args, "--no-verify");
+	argv_array_pushl(&cp.args, "-C", oid_to_hex(oid), NULL);
+	if (run_command(&cp)) {
+
+		fprintf_ln(stderr, _("Commit failed, please do not call \"git commit\"\n"
+					"directly, but instead do one of the following:"));
+		if (state->opts.resolvemsg)
+			fprintf_ln(stderr, "%s", state->opts.resolvemsg);
+		exit(1);
+	}
+	printf_ln(_("Committed: %0*d"), state->prec, msgnum);
+}
+
+static void do_rest(struct rebase_merge *state)
+{
+	while (state->msgnum <= state->end) {
+		struct object_id oid;
+
+		if (read_state_msgnum(state, state->msgnum, &oid) < 0)
+			die("could not read msgnum commit");
+		write_state_oid(state, "current", &oid);
+		do_merge(state, state->msgnum, &oid);
+		do_commit(state, state->msgnum, &oid);
+		write_state_ui(state, "msgnum", ++state->msgnum);
+	}
+
+	rebase_merge_finish(state);
+}
+
+void rebase_merge_run(struct rebase_merge *state)
+{
+	rebase_common_setup(&state->opts, state->dir);
+
+	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
+		die_errno(_("failed to create directory '%s'"), state->dir);
+
+	rebase_options_save(&state->opts, state->dir);
+	write_state_text(state, "onto_name", state->opts.onto_name ? state->opts.onto_name : oid_to_hex(&state->opts.onto));
+
+	state->msgnum = 1;
+	write_state_ui(state, "msgnum", state->msgnum);
+
+	state->end = setup_commits(state->dir, &state->opts.upstream, &state->opts.orig_head);
+	write_state_ui(state, "end", state->end);
+
+	do_rest(state);
+}
diff --git a/rebase-merge.h b/rebase-merge.h
new file mode 100644
index 0000000..f0b54ef
--- /dev/null
+++ b/rebase-merge.h
@@ -0,0 +1,28 @@
+#ifndef REBASE_MERGE_H
+#define REBASE_MERGE_H
+#include "rebase-common.h"
+
+const char *git_path_rebase_merge_dir(void);
+
+/*
+ * The rebase_merge backend is a merge-based non-interactive mode that copes
+ * well with renamed files.
+ */
+struct rebase_merge {
+	struct rebase_options opts;
+	char *dir;
+	unsigned int msgnum, end;
+	int prec;
+};
+
+void rebase_merge_init(struct rebase_merge *, const char *dir);
+
+void rebase_merge_release(struct rebase_merge *);
+
+int rebase_merge_in_progress(const struct rebase_merge *);
+
+int rebase_merge_load(struct rebase_merge *);
+
+void rebase_merge_run(struct rebase_merge *);
+
+#endif /* REBASE_MERGE_H */
-- 
2.7.0
