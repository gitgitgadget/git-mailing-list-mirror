From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 05/45] builtin-am: split out mbox/maildir patches with git-mailsplit
Date: Mon, 20 Jul 2015 00:09:57 +0800
Message-ID: <1437322237-29863-6-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBE-00062B-Tl
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbbGSQLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:03 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33124 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbbGSQK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:10:59 -0400
Received: by padck2 with SMTP id ck2so88782308pad.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2z7Q6l+05zjYJTLN3TvL+XoTT5DukEHv5ptahC+Hf8=;
        b=zE2s0Xm0V+i/TxECR9o3LdY5NUBAuk3ki2tleh3+/ndCvgq1bOpvTtV1VkydpgvVzd
         4GmzUrIy45eJxVxFaEKP1oH4tKlAyo0aiiw+Mh9yIiYBV1ug1QSW1BDyo6JJJa9btoM8
         wIr8SxEEMXxIOIzC9u/KEDD7m/fIsgxqft89IHxG3mpvv0E5SePqlz77VPSiT8VG+jIj
         ezDiXZEXrhbrdd93lcwo5Ky5WUhe6ffrfnpL3O9i6RsQQ0pFfPe5gRNuIdkqSK3SuHmi
         3cWnWCO8ch5DhguusNXmZ6nFzVC8UJGArO4SwEmQ+lqTihOwf+Gl51PP+KoG6+rdrwBd
         nGfg==
X-Received: by 10.68.68.133 with SMTP id w5mr49347299pbt.96.1437322258916;
        Sun, 19 Jul 2015 09:10:58 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.10.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:10:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274230>

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
 builtin/am.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index ac172c4..5f3c131 100644
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
@@ -117,13 +128,71 @@ static void am_destroy(const struct am_state *state)
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
@@ -159,9 +228,25 @@ static void am_run(struct am_state *state)
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
@@ -169,6 +254,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
+			N_("format the patch(es) are in"),
+			parse_opt_patchformat),
 		OPT_END()
 	};
 
@@ -195,8 +283,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
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
2.5.0.rc2.110.gb39b692
