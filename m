From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 04/44] builtin-am: implement patch queue mechanism
Date: Tue,  7 Jul 2015 22:20:22 +0800
Message-ID: <1436278862-2638-5-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:21:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTke-00043x-IP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbbGGOVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:21:33 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33304 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216AbbGGOV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:28 -0400
Received: by pdbdz6 with SMTP id dz6so31975299pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yhALz/nLj6AJcziJvc/h2lF4hMsicp3XLujCOInXzSQ=;
        b=ExriuWWF5pPOjGL748nBuO7q5Y36H0P7hW3skMN5nuowXQI0hDF7gHLNF61eh+lBKA
         /8Ov/Vv+DiBNw/XLoEKp0Jk5AlEwHNl9m2VRdSkwh+s7+Jw6JuK3k3IMjjW8KltFD1th
         G4ue3SzzdVBnKogh3Ni0xVJG79ZnHFb6loTUCzV6V22CjAo2CeNf3f8CtPBeG0rUkB4k
         nEAHzkW96ejCyA63uJ5giZn5/HcPbSpDP+pFaRJ6lb3r0lxua/hTzdjbGEppKYuVcrvH
         /CswrQY4126gTWAtW6oMvAptGqyrgneSAOycYsMDKooHvK1PR4OTwIRRg3anrSHXxust
         uSqQ==
X-Received: by 10.68.175.35 with SMTP id bx3mr9372493pbc.128.1436278888125;
        Tue, 07 Jul 2015 07:21:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273524>

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
 builtin/am.c | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index fd32caf..292f793 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -6,9 +6,174 @@
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
+	if (state->dir)
+		free(state->dir);
+}
+
+/**
+ * Returns path relative to the am_state directory.
+ */
+static inline const char *am_path(const struct am_state *state, const char *path)
+{
+	assert(state->dir);
+	assert(path);
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
@@ -25,5 +190,20 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc1.76.gf60a929
