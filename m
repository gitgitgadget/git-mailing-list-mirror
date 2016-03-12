From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 06/17] rebase-am: introduce am backend for builtin rebase
Date: Sat, 12 Mar 2016 18:46:26 +0800
Message-ID: <1457779597-6918-7-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4x-0005u9-7q
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbcCLKrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:22 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35759 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbcCLKrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:14 -0500
Received: by mail-pf0-f173.google.com with SMTP id n5so63106367pfn.2
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yPyUKvYTjhq0n8hrp4DxIdXWVt4C9i0jWs1JaZ5/1LQ=;
        b=fwVoy1eUY8P7BteKlCsSiaODBh/ONYBzVfAfv+9p6t9wCGtP2dD8vVtUP8mRntWnJf
         01zEym425dBoe2GA/5M3nBSJCKrLPQQXBfl4geH8eGEOvU5GT97Bic8q7dDNKkt+Wzx3
         VgXq89sdAx6C1+hHRSI3SLV9cHDHf+NzIdjCizW+36/U7co24w2PDvySugg+HOr4Plfx
         pES2gmy0Yv/K1ADnRfPCcZfJur6fFuFR9m9fjg5iwZE+WTb1e7V8KkXNXorwQK7vO0In
         egwdXsKIeCVahkGWNHLpRpUoaRmQ3XN0w0/Whm9JcaHMKtKRIPek5Kg2Dfu0u86PXlLm
         qUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yPyUKvYTjhq0n8hrp4DxIdXWVt4C9i0jWs1JaZ5/1LQ=;
        b=BNX05tP49WVuwPd0CWqFCLtVp+9TGSZ80RduKYBGRusn431sTLZNVAJFY4UFvXiBGA
         Da16ZyWj+qnB/CldsNsX2xwK8zgEJKk20NbzZSv9BFkxcE+Y20Sv75onReUcGzunjR5M
         PbL6vrAUR/40vB2Z33UVni9SsP+yRpFPLTfmjJ5kQaDoLNd81BD5Zqn1QVTvQML9dafN
         f1jxTgFPH23vUfwFKG4gWZ21ahT4VqxZiIZc4oty2Zl2Hf/NUMDVrKG9EScW7d6TXhDH
         4IIhOIhjvwUbtSNJsCnYaDS31B1zqXFOwqGcFLukcZBi6D1xUXscrF2D6hRLrVdPruAq
         V0Vw==
X-Gm-Message-State: AD7BkJJo0cAVSplYa9/pwP6RiC884UwhJSODi77ChBDf2qUHQsGhr8t1EHW17nzmaFnMgA==
X-Received: by 10.98.86.146 with SMTP id h18mr14949858pfj.9.1457779633506;
        Sat, 12 Mar 2016 02:47:13 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:12 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288736>

Since 7f59dbb (Rewrite rebase to use git-format-patch piped to git-am.,
2005-11-14), git-rebase will by default use "git am" to rebase commits.
This is done by first checking out to the new base commit, generating a
series of patches with the commits to replay, and then applying them
with git-am. Finally, if orig_head is a branch, it is updated to point
to the tip of the new rebased commit history.

Implement a skeletal version of this method of rebasing commits by
introducing a new rebase-am backend for our builtin-rebase. This
skeletal version can only call git-format-patch and git-am to perform a
rebase, and is unable to resume from a failed rebase. Subsequent
patches will re-implement all the missing features.

The symmetric difference between upstream...orig_head is used because in
a later patch, we will add an additional exclusion revision in order to
handle fork points correctly.  See b6266dc (rebase--am: use
--cherry-pick instead of --ignore-if-in-upstream, 2014-07-15).

The initial steps of checking out the new base commit, and the final
cleanup steps of updating refs are common between the am backend and
merge backend. As such, we implement the common setup and teardown
sequence in the shared functions rebase_common_setup() and
rebase_common_finish(), so we can share code with the merge backend when
it is implemented in a later patch.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile         |   1 +
 builtin/rebase.c |  25 +++++++++++++
 rebase-am.c      | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rebase-am.h      |  22 +++++++++++
 rebase-common.c  |  81 ++++++++++++++++++++++++++++++++++++++++
 rebase-common.h  |   6 +++
 6 files changed, 245 insertions(+)
 create mode 100644 rebase-am.c
 create mode 100644 rebase-am.h

diff --git a/Makefile b/Makefile
index b29c672..a2618ea 100644
--- a/Makefile
+++ b/Makefile
@@ -779,6 +779,7 @@ LIB_OBJS += prompt.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
+LIB_OBJS += rebase-am.o
 LIB_OBJS += rebase-common.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 40176ca..ec63d3b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -8,6 +8,22 @@
 #include "remote.h"
 #include "branch.h"
 #include "refs.h"
+#include "rebase-am.h"
+
+enum rebase_type {
+	REBASE_TYPE_NONE = 0,
+	REBASE_TYPE_AM
+};
+
+static const char *rebase_dir(enum rebase_type type)
+{
+	switch (type) {
+	case REBASE_TYPE_AM:
+		return git_path_rebase_am_dir();
+	default:
+		die("BUG: invalid rebase_type %d", type);
+	}
+}
 
 /**
  * Used by get_curr_branch_upstream_name() as a for_each_remote() callback to
@@ -208,6 +224,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("Failed to resolve '%s' as a valid revision."), "HEAD");
 	}
 
+	/* Run the appropriate rebase backend */
+	{
+		struct rebase_am state;
+		rebase_am_init(&state, rebase_dir(REBASE_TYPE_AM));
+		rebase_options_swap(&state.opts, &rebase_opts);
+		rebase_am_run(&state);
+		rebase_am_release(&state);
+	}
+
 	rebase_options_release(&rebase_opts);
 	return 0;
 }
diff --git a/rebase-am.c b/rebase-am.c
new file mode 100644
index 0000000..53e8798
--- /dev/null
+++ b/rebase-am.c
@@ -0,0 +1,110 @@
+#include "cache.h"
+#include "rebase-am.h"
+#include "run-command.h"
+
+GIT_PATH_FUNC(git_path_rebase_am_dir, "rebase-apply");
+
+void rebase_am_init(struct rebase_am *state, const char *dir)
+{
+	if (!dir)
+		dir = git_path_rebase_am_dir();
+	rebase_options_init(&state->opts);
+	state->dir = xstrdup(dir);
+}
+
+void rebase_am_release(struct rebase_am *state)
+{
+	rebase_options_release(&state->opts);
+	free(state->dir);
+}
+
+int rebase_am_in_progress(const struct rebase_am *state)
+{
+	const char *dir = state ? state->dir : git_path_rebase_am_dir();
+	struct stat st;
+
+	return !lstat(dir, &st) && S_ISDIR(st.st_mode);
+}
+
+int rebase_am_load(struct rebase_am *state)
+{
+	if (rebase_options_load(&state->opts, state->dir) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int run_format_patch(const char *patches, const struct object_id *left,
+		const struct object_id *right)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int ret;
+
+	cp.git_cmd = 1;
+	cp.out = xopen(patches, O_WRONLY | O_CREAT, 0777);
+	argv_array_push(&cp.args, "format-patch");
+	argv_array_push(&cp.args, "-k");
+	argv_array_push(&cp.args, "--stdout");
+	argv_array_push(&cp.args, "--full-index");
+	argv_array_push(&cp.args, "--cherry-pick");
+	argv_array_push(&cp.args, "--right-only");
+	argv_array_push(&cp.args, "--src-prefix=a/");
+	argv_array_push(&cp.args, "--dst-prefix=b/");
+	argv_array_push(&cp.args, "--no-renames");
+	argv_array_push(&cp.args, "--no-cover-letter");
+	argv_array_pushf(&cp.args, "%s...%s", oid_to_hex(left), oid_to_hex(right));
+
+	ret = run_command(&cp);
+	close(cp.out);
+	return ret;
+}
+
+static int run_am(const struct rebase_am *state, const char *patches)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int ret;
+
+	cp.git_cmd = 1;
+	cp.in = xopen(patches, O_RDONLY);
+	argv_array_push(&cp.args, "am");
+	argv_array_push(&cp.args, "--rebasing");
+	if (state->opts.resolvemsg)
+		argv_array_pushf(&cp.args, "--resolvemsg=%s", state->opts.resolvemsg);
+
+	ret = run_command(&cp);
+	close(cp.in);
+	return ret;
+}
+
+void rebase_am_run(struct rebase_am *state)
+{
+	char *patches;
+	int ret;
+
+	rebase_common_setup(&state->opts, state->dir);
+
+	patches = git_pathdup("rebased-patches");
+	ret = run_format_patch(patches, &state->opts.upstream, &state->opts.orig_head);
+	if (ret) {
+		unlink_or_warn(patches);
+		fprintf_ln(stderr, _("\ngit encountered an error while preparing the patches to replay\n"
+			"these revisions:\n"
+			"\n"
+			"    %s...%s\n"
+			"\n"
+			"As a result, git cannot rebase them."),
+				oid_to_hex(&state->opts.upstream),
+				oid_to_hex(&state->opts.orig_head));
+		exit(ret);
+	}
+
+	ret = run_am(state, patches);
+	unlink_or_warn(patches);
+	if (ret) {
+		rebase_options_save(&state->opts, state->dir);
+		exit(ret);
+	}
+
+	free(patches);
+	rebase_common_finish(&state->opts, state->dir);
+}
diff --git a/rebase-am.h b/rebase-am.h
new file mode 100644
index 0000000..0b4348c
--- /dev/null
+++ b/rebase-am.h
@@ -0,0 +1,22 @@
+#ifndef REBASE_AM_H
+#define REBASE_AM_H
+#include "rebase-common.h"
+
+const char *git_path_rebase_am_dir(void);
+
+struct rebase_am {
+	struct rebase_options opts;
+	char *dir;
+};
+
+void rebase_am_init(struct rebase_am *, const char *dir);
+
+void rebase_am_release(struct rebase_am *);
+
+int rebase_am_in_progress(const struct rebase_am *);
+
+int rebase_am_load(struct rebase_am *);
+
+void rebase_am_run(struct rebase_am *);
+
+#endif /* REBASE_AM_H */
diff --git a/rebase-common.c b/rebase-common.c
index 1835f08..8169fb6 100644
--- a/rebase-common.c
+++ b/rebase-common.c
@@ -1,5 +1,8 @@
 #include "cache.h"
 #include "rebase-common.h"
+#include "dir.h"
+#include "run-command.h"
+#include "refs.h"
 
 void rebase_options_init(struct rebase_options *opts)
 {
@@ -95,3 +98,81 @@ void rebase_options_save(const struct rebase_options *opts, const char *dir)
 	write_state_text(dir, "onto", oid_to_hex(&opts->onto));
 	write_state_text(dir, "orig-head", oid_to_hex(&opts->orig_head));
 }
+
+static int detach_head(const struct object_id *commit, const char *onto_name)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int status;
+	const char *reflog_action = getenv("GIT_REFLOG_ACTION");
+	if (!reflog_action || !*reflog_action)
+		reflog_action = "rebase";
+	cp.git_cmd = 1;
+	argv_array_pushf(&cp.env_array, "GIT_REFLOG_ACTION=%s: checkout %s",
+			reflog_action, onto_name ? onto_name : oid_to_hex(commit));
+	argv_array_push(&cp.args, "checkout");
+	argv_array_push(&cp.args, "-q");
+	argv_array_push(&cp.args, "--detach");
+	argv_array_push(&cp.args, oid_to_hex(commit));
+	status = run_command(&cp);
+
+	/* reload cache as checkout will have modified it */
+	discard_cache();
+	read_cache();
+
+	return status;
+}
+
+void rebase_common_setup(struct rebase_options *opts, const char *dir)
+{
+	/* Detach HEAD and reset the tree */
+	printf_ln(_("First, rewinding head to replay your work on top of it..."));
+	if (detach_head(&opts->onto, opts->onto_name))
+		die(_("could not detach HEAD"));
+	update_ref("rebase", "ORIG_HEAD", opts->orig_head.hash, NULL, 0,
+			UPDATE_REFS_DIE_ON_ERR);
+}
+
+void rebase_common_destroy(struct rebase_options *opts, const char *dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addstr(&sb, dir);
+	remove_dir_recursively(&sb, 0);
+	strbuf_release(&sb);
+}
+
+static void move_to_original_branch(struct rebase_options *opts)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id curr_head;
+
+	if (!opts->orig_refname || !starts_with(opts->orig_refname, "refs/"))
+		return;
+
+	if (get_sha1("HEAD", curr_head.hash) < 0)
+		die("get_sha1() failed");
+
+	strbuf_addf(&sb, "rebase finished: %s onto %s", opts->orig_refname, oid_to_hex(&opts->onto));
+	if (update_ref(sb.buf, opts->orig_refname, curr_head.hash, opts->orig_head.hash, 0, UPDATE_REFS_MSG_ON_ERR))
+		goto fail;
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "rebase finished: returning to %s", opts->orig_refname);
+	if (create_symref("HEAD", opts->orig_refname, sb.buf))
+		goto fail;
+
+	strbuf_release(&sb);
+
+	return;
+fail:
+	die(_("Could not move back to %s"), opts->orig_refname);
+}
+
+void rebase_common_finish(struct rebase_options *opts, const char *dir)
+{
+	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
+
+	move_to_original_branch(opts);
+	close_all_packs();
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	rebase_common_destroy(opts, dir);
+}
diff --git a/rebase-common.h b/rebase-common.h
index 051c056..067ad0b 100644
--- a/rebase-common.h
+++ b/rebase-common.h
@@ -24,4 +24,10 @@ int rebase_options_load(struct rebase_options *, const char *dir);
 
 void rebase_options_save(const struct rebase_options *, const char *dir);
 
+void rebase_common_setup(struct rebase_options *, const char *dir);
+
+void rebase_common_destroy(struct rebase_options *, const char *dir);
+
+void rebase_common_finish(struct rebase_options *, const char *dir);
+
 #endif /* REBASE_COMMON_H */
-- 
2.7.0
