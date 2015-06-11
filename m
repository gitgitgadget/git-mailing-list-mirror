From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 04/19] am: implement patch queue mechanism
Date: Thu, 11 Jun 2015 18:21:50 +0800
Message-ID: <1434018125-31804-5-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zd9-0007iP-QM
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbbFKKWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34499 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbbFKKW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:28 -0400
Received: by payr10 with SMTP id r10so1869200pay.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SNwqFu11K05KNyEFseKtN6ZFG5mtHAjHRN1290jKp1k=;
        b=gwTLjIXPG8SujBe1QDr+nPF5vGAypDZr4Wv2Mqn0WEfrf2rTXvFsbNkLCA/l47pPFf
         neCy6Nw8uq3BoA43tS9RUwPLHtTGPpP38wmmeHZlnlWrefHPIJlB1roxE3n8q29w5PWP
         HS93DMCZuKCMav3+4Heui5SWyAv8k5Tfr1Asb1T5nTTPFP41WXVqo/lxVyvGJ4c2rbk2
         pAamOvZcNTxzYzKe5DFMCr1H1hycKygY869Bu0F6aPY1/vJ9ZJRKO4niHY/3cl9UkixJ
         qV7KK5trm1pL3Mlbxh92yDTc7R3UYsUjmifMos1NKbHgSKZSSnSt1x4Eq/fbYqAl+0NX
         nOSA==
X-Received: by 10.66.122.37 with SMTP id lp5mr13711270pab.17.1434018146763;
        Thu, 11 Jun 2015 03:22:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271385>

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

Notes:
    v2
    
    * Declare struct am_state as static

 builtin/am.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 0ccbe33..f061d21 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -6,6 +6,154 @@
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
+			strbuf_rtrim(sb);
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
+	while (state->cur <= state->last)
+		am_next(state);
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
@@ -16,5 +164,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			die_errno("could not exec %s", path);
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
