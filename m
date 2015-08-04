From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 04/45] builtin-am: implement patch queue mechanism
Date: Tue,  4 Aug 2015 21:51:25 +0800
Message-ID: <1438696326-19590-5-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:59:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMckS-0005BG-FO
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934302AbbHDN7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:59:15 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35324 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934170AbbHDNxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:10 -0400
Received: by pasy3 with SMTP id y3so9185523pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qTW3DRv8d2v2bh9NJIGoLF72z5TKMggSlUbUrxs5EyY=;
        b=cGCrSZ3YHV1GfXwQhkLIgocAhv8CoBKV/P7IYqDjnc5rM+YCCtiFIyX1hNnTKv1Z1D
         6RC97+/bbqMBJ9kIsFGIv5XA8DiElsGz5qL6A9923o3a7eN26OL6jNtxwst1UhPHyAIC
         AA2ho2abTsc5SdSK305C0eA4SKrNY+S+gVBpn0DUJ0y8klqOODWgQLx9zqnjepWbgXTH
         f/SRvq1imOQlXFh9tm2+4K+Bqp450fO3H0w/5tz5yLtDEdVicbRgK8B1qS5BqdSVx53r
         kknlZe2nsDGjVFHL1vI3DyZA6P8vk1TJdFaa0GAAqIh4uKNmsRuXgZhRD+z5O6bHRuZe
         uhPg==
X-Received: by 10.68.166.196 with SMTP id zi4mr7938443pbb.83.1438696388662;
        Tue, 04 Aug 2015 06:53:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275318>

git-am applies a series of patches. If the process terminates
abnormally, we want to be able to resume applying the series of patches.
This requires the session state to be saved in a persistent location.

Implement the mechanism of a "patch queue", represented by 2 integers --
the index of the current patch we are applying and the index of the last
patch, as well as its lifecycle through the following functions:

* am_setup(), which will set up the state directory
  $GIT_DIR/rebase-apply. As such, even if the process exits abnormally,
  the last-known state will still persist.

* am_load(), which is called if there is an am session in
  progress, to load the last known state from the state directory so we
  can resume applying patches.

* am_run(), which will do the actual patch application. After applying a
  patch, it calls am_next() to increment the current patch index. The
  logic for applying and committing a patch is not implemented yet.

* am_destroy(), which is finally called when we successfully applied all
  the patches in the queue, to clean up by removing the state directory
  and its contents.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Stefan Beller <sbeller@google.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index fd32caf..ac172c4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -6,9 +6,171 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "parse-options.h"
+#include "dir.h"
+
+struct am_state {
+	/* state directory path */
+	char *dir;
+
+	/* current and last patch numbers, 1-indexed */
+	int cur;
+	int last;
+};
+
+/**
+ * Initializes am_state with the default values. The state directory is set to
+ * dir.
+ */
+static void am_state_init(struct am_state *state, const char *dir)
+{
+	memset(state, 0, sizeof(*state));
+
+	assert(dir);
+	state->dir = xstrdup(dir);
+}
+
+/**
+ * Releases memory allocated by an am_state.
+ */
+static void am_state_release(struct am_state *state)
+{
+	free(state->dir);
+}
+
+/**
+ * Returns path relative to the am_state directory.
+ */
+static inline const char *am_path(const struct am_state *state, const char *path)
+{
+	return mkpath("%s/%s", state->dir, path);
+}
+
+/**
+ * Returns 1 if there is an am session in progress, 0 otherwise.
+ */
+static int am_in_progress(const struct am_state *state)
+{
+	struct stat st;
+
+	if (lstat(state->dir, &st) < 0 || !S_ISDIR(st.st_mode))
+		return 0;
+	if (lstat(am_path(state, "last"), &st) || !S_ISREG(st.st_mode))
+		return 0;
+	if (lstat(am_path(state, "next"), &st) || !S_ISREG(st.st_mode))
+		return 0;
+	return 1;
+}
+
+/**
+ * Reads the contents of `file` in the `state` directory into `sb`. Returns the
+ * number of bytes read on success, -1 if the file does not exist. If `trim` is
+ * set, trailing whitespace will be removed.
+ */
+static int read_state_file(struct strbuf *sb, const struct am_state *state,
+			const char *file, int trim)
+{
+	strbuf_reset(sb);
+
+	if (strbuf_read_file(sb, am_path(state, file), 0) >= 0) {
+		if (trim)
+			strbuf_trim(sb);
+
+		return sb->len;
+	}
+
+	if (errno == ENOENT)
+		return -1;
+
+	die_errno(_("could not read '%s'"), am_path(state, file));
+}
+
+/**
+ * Loads state from disk.
+ */
+static void am_load(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (read_state_file(&sb, state, "next", 1) < 0)
+		die("BUG: state file 'next' does not exist");
+	state->cur = strtol(sb.buf, NULL, 10);
+
+	if (read_state_file(&sb, state, "last", 1) < 0)
+		die("BUG: state file 'last' does not exist");
+	state->last = strtol(sb.buf, NULL, 10);
+
+	strbuf_release(&sb);
+}
+
+/**
+ * Removes the am_state directory, forcefully terminating the current am
+ * session.
+ */
+static void am_destroy(const struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, state->dir);
+	remove_dir_recursively(&sb, 0);
+	strbuf_release(&sb);
+}
+
+/**
+ * Setup a new am session for applying patches
+ */
+static void am_setup(struct am_state *state)
+{
+	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
+		die_errno(_("failed to create directory '%s'"), state->dir);
+
+	/*
+	 * NOTE: Since the "next" and "last" files determine if an am_state
+	 * session is in progress, they should be written last.
+	 */
+
+	write_file(am_path(state, "next"), 1, "%d", state->cur);
+
+	write_file(am_path(state, "last"), 1, "%d", state->last);
+}
+
+/**
+ * Increments the patch pointer, and cleans am_state for the application of the
+ * next patch.
+ */
+static void am_next(struct am_state *state)
+{
+	state->cur++;
+	write_file(am_path(state, "next"), 1, "%d", state->cur);
+}
+
+/**
+ * Applies all queued mail.
+ */
+static void am_run(struct am_state *state)
+{
+	while (state->cur <= state->last) {
+
+		/* NEEDSWORK: Patch application not implemented yet */
+
+		am_next(state);
+	}
+
+	am_destroy(state);
+}
 
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
+	struct am_state state;
+
+	const char * const usage[] = {
+		N_("git am [options] [(<mbox>|<Maildir>)...]"),
+		NULL
+	};
+
+	struct option options[] = {
+		OPT_END()
+	};
 
 	/*
 	 * NEEDSWORK: Once all the features of git-am.sh have been
@@ -25,5 +187,20 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 	}
 
+	git_config(git_default_config, NULL);
+
+	am_state_init(&state, git_path("rebase-apply"));
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (am_in_progress(&state))
+		am_load(&state);
+	else
+		am_setup(&state);
+
+	am_run(&state);
+
+	am_state_release(&state);
+
 	return 0;
 }
-- 
2.5.0.280.gd88bd6e
