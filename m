From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 04/31] am: implement patch queue mechanism
Date: Thu, 18 Jun 2015 19:25:16 +0800
Message-ID: <1434626743-8552-5-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xxx-0004e3-9J
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbbFRL0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:36 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33639 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbbFRL0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:23 -0400
Received: by pdjn11 with SMTP id n11so64826324pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ig0T91kIB9jkPQ09b4CvyF8JK8MBEJE0pabDV4GvJGc=;
        b=Pt6KJ3heDPkbLZAYXQdfYK2goeUEhqx7eVdE0SeB9MxX/erwdhiCGW+RB5xli2wwKb
         emZxxHudqauBClrDq4csOyoR4X72VhBs3JU3c8+IxNzcbShnjCFXCBkR8QEgDTSNUW/L
         hjEs8Ypxy4Vy6gs0/E7XOSoCtvruz5+9yuyRu9TXDRfAY8wvWI6e0KZaNGuBbW32un/5
         HxPt6/z/RB9SHfNY7gpJz6Qsm3XDgnCCCWSbdCFA3Q8gAssAMhIpx44k3B2Ne67VPHKd
         0u8y6IwWcOzRLx+InPAGF9u9WJvdqNUAI7/xflYf3LWJ982eGyDxc6l/bBChHW3boiLP
         0z4A==
X-Received: by 10.68.163.68 with SMTP id yg4mr20364573pbb.4.1434626782450;
        Thu, 18 Jun 2015 04:26:22 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:21 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271972>

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

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index dbc8836..af68c51 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -6,6 +6,158 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "parse-options.h"
+#include "dir.h"
+
+struct am_state {
+	/* state directory path */
+	struct strbuf dir;
+
+	/* current and last patch numbers, 1-indexed */
+	int cur;
+	int last;
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
+ * about the file size, to avoid reallocs. Returns number of bytes read on
+ * success, -1 if the file does not exist. If trim is set, trailing whitespace
+ * will be removed from the file contents.
+ */
+static int read_state_file(struct strbuf *sb, const char *file, size_t hint, int trim)
+{
+	strbuf_reset(sb);
+	if (strbuf_read_file(sb, file, hint) >= 0) {
+		if (trim)
+			strbuf_trim(sb);
+
+		return sb->len;
+	}
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
+static void am_load(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	read_state_file(&sb, am_path(state, "next"), 8, 1);
+	state->cur = strtol(sb.buf, NULL, 10);
+
+	read_state_file(&sb, am_path(state, "last"), 8, 1);
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
+	while (state->cur <= state->last) {
+
+		/* TODO: Patch application not implemented yet */
+
+		am_next(state);
+	}
+
+	am_destroy(state);
+}
+
+static struct am_state state;
+
+static const char * const am_usage[] = {
+	N_("git am [options] [(<mbox>|<Maildir>)...]"),
+	NULL
+};
+
+static struct option am_options[] = {
+	OPT_END()
+};
 
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
@@ -24,5 +176,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 	}
 
+	git_config(git_default_config, NULL);
+
+	am_state_init(&state);
+	strbuf_addstr(&state.dir, git_path("rebase-apply"));
+
+	argc = parse_options(argc, argv, prefix, am_options, am_usage, 0);
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
2.1.4
