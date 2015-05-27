From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 3/8] am: implement patch queue mechanism
Date: Wed, 27 May 2015 21:33:33 +0800
Message-ID: <1432733618-25629-4-git-send-email-pyokagan@gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:34:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbTp-0006FL-UK
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbE0Nec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:32 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34210 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbbE0Nea (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:30 -0400
Received: by pdbki1 with SMTP id ki1so15461889pdb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W4xD//I8cGoAUfvDhRMxg0exf/4/Kzf+/jomy4DwYpE=;
        b=lY/PUVvcLKCSNkX6aWUeow+DU2Vq4ueLvomyro4MAtBSGiq5KTVqwh3ehMi0cg3RgW
         mpArduexhvEpSzMqQysdRb9TejFkZSlL0CUsvoHNIbJSJRiWXy/YMUh4mTMgfw4KTb+s
         K4Rf7nPbg2GBy6OPKPRPPdXQUA03FM2CwdSQ/A0Nk6kOja1yP/yll1uoikZA/K0gBaZM
         9/tX3/JJu9s7fc2Xl3/DPEdSuxqmjzOuoQN2zg7zAGx9TzY45zX01SeMTbjJ3W9vfQOZ
         O6KZbvQ8Zyz87TnO/4aXa1OAcyLkaVg47h6EBnvj86MgpYUGzVorsdlAZeh6sOUyjGln
         +NcA==
X-Received: by 10.70.30.193 with SMTP id u1mr57946980pdh.59.1432733669972;
        Wed, 27 May 2015 06:34:29 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:28 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270052>

git-am applies a series of patches. If the process terminates
abnormally, we want to be able to resume applying the series of patches.
This requires the session state to be saved in a persistent location.

Implement the mechanism of a "patch queue", represented by 2 integers --
the index of the current patch we are applying and the index of the last
patch, as well as its lifecycle through the following functions:

* am_setup(), which will set up the state directory
  $GIT_DIR/rebase-apply. As such, even if the process exits abnormally,
  the last-known state will still persist.

* am_state_load(), which is called if there is an am session in
  progress, to load the last known state from the state directory so we
  can resume applying patches.

* am_run(), which will do the actual patch application. After applying a
  patch, it calls am_next() to increment the current patch index. The
  logic for applying and committing a patch is not implemented yet.

* am_destroy(), which is finally called when we successfully applied all
  the patches in the queue, to clean up by removing the state directory
  and its contents.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile     |   2 +-
 builtin.h    |   1 +
 builtin/am.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git.c        |   1 +
 4 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 builtin/am.c

diff --git a/Makefile b/Makefile
index 323c401..57a7c8c 100644
--- a/Makefile
+++ b/Makefile
@@ -466,7 +466,6 @@ TEST_PROGRAMS_NEED_X =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
@@ -812,6 +811,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
diff --git a/builtin.h b/builtin.h
index b87df70..d50c9d1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -30,6 +30,7 @@ extern int textconv_object(const char *path, unsigned mode, const unsigned char
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
diff --git a/builtin/am.c b/builtin/am.c
new file mode 100644
index 0000000..6c00009
--- /dev/null
+++ b/builtin/am.c
@@ -0,0 +1,167 @@
+/*
+ * Builtin "git am"
+ *
+ * Based on git-am.sh by Junio C Hamano.
+ */
+#include "cache.h"
+#include "parse-options.h"
+#include "dir.h"
+
+struct am_state {
+	struct strbuf dir;            /* state directory path */
+	int cur;                      /* current patch number */
+	int last;                     /* last patch number */
+};
+
+/**
+ * Initializes am_state with the default values.
+ */
+static void am_state_init(struct am_state *state)
+{
+	memset(state, 0, sizeof(*state));
+
+	strbuf_init(&state->dir, 0);
+}
+
+/**
+ * Release memory allocated by an am_state.
+ */
+static void am_state_release(struct am_state *state)
+{
+	strbuf_release(&state->dir);
+}
+
+/**
+ * Returns path relative to the am_state directory.
+ */
+static inline const char *am_path(const struct am_state *state, const char *path)
+{
+	return mkpath("%s/%s", state->dir.buf, path);
+}
+
+/**
+ * Returns 1 if there is an am session in progress, 0 otherwise.
+ */
+static int am_in_progress(const struct am_state *state)
+{
+	struct stat st;
+
+	if (lstat(state->dir.buf, &st) < 0 || !S_ISDIR(st.st_mode))
+		return 0;
+	if (lstat(am_path(state, "last"), &st) || !S_ISREG(st.st_mode))
+		return 0;
+	if (lstat(am_path(state, "next"), &st) || !S_ISREG(st.st_mode))
+		return 0;
+	return 1;
+}
+
+/**
+ * Reads the contents of `file`. The third argument can be used to give a hint
+ * about the file size, to avoid reallocs. Returns 0 on success, -1 if the file
+ * does not exist.
+ */
+static int read_state_file(struct strbuf *sb, const char *file, size_t hint) {
+	strbuf_reset(sb);
+
+	if (!strbuf_read_file(sb, file, hint))
+		return 0;
+
+	if (errno == ENOENT)
+		return -1;
+
+	die_errno(_("could not read '%s'"), file);
+}
+
+/**
+ * Loads state from disk.
+ */
+static void am_state_load(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	read_state_file(&sb, am_path(state, "next"), 8);
+	state->cur = strtol(sb.buf, NULL, 10);
+
+	read_state_file(&sb, am_path(state, "last"), 8);
+	state->last = strtol(sb.buf, NULL, 10);
+
+	strbuf_release(&sb);
+}
+
+/**
+ * Remove the am_state directory.
+ */
+static void am_destroy(const struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, state->dir.buf);
+	remove_dir_recursively(&sb, 0);
+	strbuf_release(&sb);
+}
+
+/**
+ * Setup a new am session for applying patches
+ */
+static void am_setup(struct am_state *state)
+{
+	if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
+		die_errno(_("failed to create directory '%s'"), state->dir.buf);
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
+ * Applies all queued patches.
+ */
+static void am_run(struct am_state *state)
+{
+	while (state->cur <= state->last)
+		am_next(state);
+
+	am_destroy(state);
+}
+
+struct am_state state;
+
+static const char * const am_usage[] = {
+	N_("git am [options] [(<mbox>|<Maildir>)...]"),
+	NULL
+};
+
+static struct option am_options[] = {
+	OPT_END()
+};
+
+int cmd_am(int argc, const char **argv, const char *prefix)
+{
+	git_config(git_default_config, NULL);
+
+	am_state_init(&state);
+	strbuf_addstr(&state.dir, git_path("rebase-apply"));
+
+	argc = parse_options(argc, argv, prefix, am_options, am_usage, 0);
+
+	if (am_in_progress(&state))
+		am_state_load(&state);
+	else
+		am_setup(&state);
+
+	am_run(&state);
+
+	am_state_release(&state);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 44374b1..42328ed 100644
--- a/git.c
+++ b/git.c
@@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive },
-- 
2.1.4
