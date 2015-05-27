From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 4/8] am: split out mbox/maildir patches with git-mailsplit
Date: Wed, 27 May 2015 21:33:34 +0800
Message-ID: <1432733618-25629-5-git-send-email-pyokagan@gmail.com>
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
	id 1YxbTq-0006FL-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbbE0Neg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:36 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33410 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbE0Nee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:34 -0400
Received: by pdbqa5 with SMTP id qa5so15506046pdb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eynKGdvxtGVNGtxthWkHVqCwe+aZcM49zLrE5gYVsYg=;
        b=iMdfBNMdFyfxRjdtUqW0BEJ1jTR0hkPYHE0bYFpaTDTHlVS33AGoZIz0l6bWSz3HES
         anv0TRNl96xBYB1N5vWdwfSW6On94KhtuFRUJfFIVOd0gY5N3az+GTQOR0/2Qyonx9Vr
         7c5m+QiByxzdKrmYmiQDnA08zjJprK1/+zflRwnHbx2Tcd9oA2dppdDAFy5niMtNwVjE
         JOaEUF22Ddqxu8VEi2oteDY9hTe8jP+bAMjygnI+W86QTvxMgVTLT10jgiBdpouIiv/1
         u77wzMhJ1AOyncQj3NDOiqQi0UBYxjVbQ+wnweI6uetAANUTDLv+C1KmEPQ2gIZO5NBj
         hS8Q==
X-Received: by 10.70.93.69 with SMTP id cs5mr58251435pdb.165.1432733674304;
        Wed, 27 May 2015 06:34:34 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270050>

git-am.sh supports mbox, stgit and mercurial patches. Re-implement
support for splitting out mbox/maildirs using git-mailsplit, while also
implementing the framework required to support other patch formats in
the future.

Re-implement support for the --patch-format option (since a5a6755
(git-am foreign patch support: introduce patch_format, 2009-05-27)) to
allow the user to choose between the different patch formats.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6c00009..9c7b058 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -6,11 +6,18 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "run-command.h"
+
+enum patch_format {
+	PATCH_FORMAT_UNKNOWN = 0,
+	PATCH_FORMAT_MBOX
+};
 
 struct am_state {
 	struct strbuf dir;            /* state directory path */
 	int cur;                      /* current patch number */
 	int last;                     /* last patch number */
+	int prec;                     /* number of digits in patch filename */
 };
 
 /**
@@ -21,6 +28,7 @@ static void am_state_init(struct am_state *state)
 	memset(state, 0, sizeof(*state));
 
 	strbuf_init(&state->dir, 0);
+	state->prec = 4;
 }
 
 /**
@@ -101,13 +109,67 @@ static void am_destroy(const struct am_state *state)
 }
 
 /**
+ * Splits out individual patches from `paths`, where each path is either a mbox
+ * file or a Maildir. Return 0 on success, -1 on failure.
+ */
+static int split_patches_mbox(struct am_state *state, struct string_list *paths)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	struct strbuf last = STRBUF_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "mailsplit");
+	argv_array_pushf(&cp.args, "-d%d", state->prec);
+	argv_array_pushf(&cp.args, "-o%s", state->dir.buf);
+	argv_array_push(&cp.args, "-b");
+	argv_array_push(&cp.args, "--");
+
+	for_each_string_list_item(item, paths)
+		argv_array_push(&cp.args, item->string);
+
+	if (capture_command(&cp, &last, 8))
+		return -1;
+
+	state->cur = 1;
+	state->last = strtol(last.buf, NULL, 10);
+
+	return 0;
+}
+
+/**
+ * Splits out individual patches, of patch_format, contained within paths.
+ * These patches will be stored in the state directory, with each patch's
+ * filename being its index, padded to state->prec digits. state->cur will be
+ * set to the index of the first patch, and state->last will be set to the
+ * index of the last patch. Returns 0 on success, -1 on failure.
+ */
+static int split_patches(struct am_state *state, enum patch_format patch_format,
+		struct string_list *paths)
+{
+	switch (patch_format) {
+		case PATCH_FORMAT_MBOX:
+			return split_patches_mbox(state, paths);
+		default:
+			die("BUG: invalid patch_format");
+	}
+	return -1;
+}
+
+/**
  * Setup a new am session for applying patches
  */
-static void am_setup(struct am_state *state)
+static void am_setup(struct am_state *state, enum patch_format patch_format,
+		struct string_list *paths)
 {
 	if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir.buf);
 
+	if (split_patches(state, patch_format, paths) < 0) {
+		am_destroy(state);
+		die(_("Failed to split patches."));
+	}
+
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
@@ -128,13 +190,32 @@ static void am_next(struct am_state *state)
  */
 static void am_run(struct am_state *state)
 {
-	while (state->cur <= state->last)
+	while (state->cur <= state->last) {
+		/* patch application not implemented yet */
+
 		am_next(state);
+	}
 
 	am_destroy(state);
 }
 
+/**
+ * parse_options() callback that validates and sets opt->value to the
+ * PATCH_FORMAT_* enum value corresponding to `arg`.
+ */
+static int parse_opt_patchformat(const struct option *opt, const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	if (!strcmp(arg, "mbox"))
+		*opt_value = PATCH_FORMAT_MBOX;
+	else
+		return -1;
+	return 0;
+}
+
 struct am_state state;
+int opt_patch_format;
 
 static const char * const am_usage[] = {
 	N_("git am [options] [(<mbox>|<Maildir>)...]"),
@@ -142,6 +223,8 @@ static const char * const am_usage[] = {
 };
 
 static struct option am_options[] = {
+	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
+		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_END()
 };
 
@@ -156,8 +239,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	if (am_in_progress(&state))
 		am_state_load(&state);
-	else
-		am_setup(&state);
+	else {
+		struct string_list paths = STRING_LIST_INIT_DUP;
+		int i;
+
+		for (i = 0; i < argc; i++) {
+			if (is_absolute_path(argv[i]) || !prefix)
+				string_list_append(&paths, argv[i]);
+			else
+				string_list_append(&paths, mkpath("%s/%s", prefix, argv[i]));
+		}
+
+		am_setup(&state, opt_patch_format, &paths);
+
+		string_list_clear(&paths, 0);
+	}
 
 	am_run(&state);
 
-- 
2.1.4
