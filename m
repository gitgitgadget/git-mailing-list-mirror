From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 05/44] builtin-am: split out mbox/maildir patches with git-mailsplit
Date: Sun, 28 Jun 2015 22:05:27 +0800
Message-ID: <1435500366-31700-6-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DEv-0001lW-2I
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbbF1OHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:17 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34744 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbbF1OHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:08 -0400
Received: by pabvl15 with SMTP id vl15so91964286pab.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62ci+LtTzDdqHRrR1CJ9e//sZqhUGSMrZzwa+vjMypo=;
        b=GGzbzgcPrkH+4+X4M5QcCgocNMn12KVYdbRGigonmFY4EFDlD4GclM5FONYvmRernZ
         oj+0Evf/XYMCvQqNUtK2NPnRcIYr1MN+/vjijbXrokxjwzK2DH64DVFYmYIMpPjRyt2T
         5oJ1MQBmjYcxrS6fy5swcjkunYtg+ZBfprqrtK/LuIcGlMYce3qmjkQuCf+KAFij51SW
         lQgEeKkBWtj/fL5ISb/uFqc9qLTJf5rjmljnp4kVSwEr/OtzU94PIvrJpuSF/DrhFmSU
         mxwxwQ2mAYeqoCi5ZbOzU5KGVaC33ppv+t9PHEqMJS+/opWLL59RQBsQBtYsB7y22OXy
         09xQ==
X-Received: by 10.70.103.132 with SMTP id fw4mr22197039pdb.5.1435500427940;
        Sun, 28 Jun 2015 07:07:07 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272882>

git-am.sh supports mbox, stgit and mercurial patches. Re-implement
support for splitting out mbox/maildirs using git-mailsplit, while also
implementing the framework required to support other patch formats in
the future.

Re-implement support for the --patch-format option (since a5a6755
(git-am foreign patch support: introduce patch_format, 2009-05-27)) to
allow the user to choose between the different patch formats.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v4
    
    * The term "patch" was overloaded to mean "the RFC2822 mail" and the
      "patch diff". To avoid confusion, use "mail" to refer to the RFC2822
      mail, and thus split_patches() has been renamed to split_mail().
    
    * An argv_array is used for `paths` instead of a string_list to avoid
      clunkiness with string_list_item in later patches.

 builtin/am.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5b4e9af..136ccc6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -8,6 +8,12 @@
 #include "exec_cmd.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "run-command.h"
+
+enum patch_format {
+	PATCH_FORMAT_UNKNOWN = 0,
+	PATCH_FORMAT_MBOX
+};
 
 struct am_state {
 	/* state directory path */
@@ -16,6 +22,9 @@ struct am_state {
 	/* current and last patch numbers, 1-indexed */
 	int cur;
 	int last;
+
+	/* number of digits in patch filename */
+	int prec;
 };
 
 /**
@@ -28,6 +37,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	assert(dir);
 	state->dir = xstrdup(dir);
+
+	state->prec = 4;
 }
 
 /**
@@ -120,13 +131,71 @@ static void am_destroy(const struct am_state *state)
 }
 
 /**
+ * Splits out individual email patches from `paths`, where each path is either
+ * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
+ */
+static int split_mail_mbox(struct am_state *state, const char **paths)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf last = STRBUF_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "mailsplit");
+	argv_array_pushf(&cp.args, "-d%d", state->prec);
+	argv_array_pushf(&cp.args, "-o%s", state->dir);
+	argv_array_push(&cp.args, "-b");
+	argv_array_push(&cp.args, "--");
+	argv_array_pushv(&cp.args, paths);
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
+ * Splits a list of files/directories into individual email patches. Each path
+ * in `paths` must be a file/directory that is formatted according to
+ * `patch_format`.
+ *
+ * Once split out, the individual email patches will be stored in the state
+ * directory, with each patch's filename being its index, padded to state->prec
+ * digits.
+ *
+ * state->cur will be set to the index of the first mail, and state->last will
+ * be set to the index of the last mail.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int split_mail(struct am_state *state, enum patch_format patch_format,
+			const char **paths)
+{
+	switch (patch_format) {
+	case PATCH_FORMAT_MBOX:
+		return split_mail_mbox(state, paths);
+	default:
+		die("BUG: invalid patch_format");
+	}
+	return -1;
+}
+
+/**
  * Setup a new am session for applying patches
  */
-static void am_setup(struct am_state *state)
+static void am_setup(struct am_state *state, enum patch_format patch_format,
+			const char **paths)
 {
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
 
+	if (split_mail(state, patch_format, paths) < 0) {
+		am_destroy(state);
+		die(_("Failed to split patches."));
+	}
+
 	/*
 	 * NOTE: Since the "next" and "last" files determine if an am_state
 	 * session is in progress, they should be written last.
@@ -162,9 +231,25 @@ static void am_run(struct am_state *state)
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
+		return error(_("Invalid value for --patch-format: %s"), arg);
+	return 0;
+}
+
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int patch_format = PATCH_FORMAT_UNKNOWN;
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
@@ -172,6 +257,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
+			N_("format the patch(es) are in"),
+			parse_opt_patchformat),
 		OPT_END()
 	};
 
@@ -198,8 +286,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	if (am_in_progress(&state))
 		am_load(&state);
-	else
-		am_setup(&state);
+	else {
+		struct argv_array paths = ARGV_ARRAY_INIT;
+		int i;
+
+		for (i = 0; i < argc; i++) {
+			if (is_absolute_path(argv[i]) || !prefix)
+				argv_array_push(&paths, argv[i]);
+			else
+				argv_array_push(&paths, mkpath("%s/%s", prefix, argv[i]));
+		}
+
+		am_setup(&state, patch_format, paths.argv);
+
+		argv_array_clear(&paths);
+	}
 
 	am_run(&state);
 
-- 
2.5.0.rc0.76.gb2c6e93
