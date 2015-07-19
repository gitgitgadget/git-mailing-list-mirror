From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 42/45] builtin-am: implement -i/--interactive
Date: Mon, 20 Jul 2015 00:10:34 +0800
Message-ID: <1437322237-29863-43-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCk-0006ms-5v
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbbGSQMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:38 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35501 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbbGSQMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:35 -0400
Received: by pdrg1 with SMTP id g1so89736537pdr.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ppP0ylXe+6+cL3vie9neYOp9UqKZPpOVi+yziqXuvWc=;
        b=POKQyZTS45OQG8I253Wpme5/cRhzgAvMvivyHoDRDn8v7CbThrG6uBAPwfk+dnUf5A
         b1Rz36A1cCJSwLFK1/Qkxivh+D11d3Z2LGuVJfDEl79vy/UeealGaZuAsTzpoYM//8uh
         fdk1kIdane3IrO2CJVFxpleUqbB+TRdup7vbwc/VkCkU2pidz5B6rui1bSq1SpyOXjuG
         gu1PWN/ofaf6aae3YJuM1lSJIIzI5nuCk4Enl00/BICNP76SL7DWvtzspxlin4O8a3TC
         jt1eLU4F78DAfixTrAGYoF/iF46MjG6cVPmuBqU+APEuoF0GzOFF0SDyC7BYR9ab5Xds
         Rfsw==
X-Received: by 10.68.209.227 with SMTP id mp3mr49456568pbc.100.1437322354580;
        Sun, 19 Jul 2015 09:12:34 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274259>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the --interactive mode. After parsing the patch mail
and extracting the patch, commit message and authorship info, an
interactive session will begin that allows the user to choose between:

* applying the patch

* applying the patch and all subsequent patches (by disabling
  interactive mode in subsequent patches)

* skipping the patch

* editing the commit message

Since f89ad67 (Add [v]iew patch in git-am interactive., 2005-10-25),
git-am.sh --interactive also supported viewing the patch to be applied.

When --resolved-ing in --interactive mode, we need to take care to
update the patch with the contents of the index, such that the correct
patch will be displayed when the patch is viewed in interactive mode.

Re-implement the above in builtin/am.c

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    Can't be tested because even with test_terminal isatty(0) still returns
    false.

 builtin/am.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8fe616e..39ea3c7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -25,6 +25,7 @@
 #include "log-tree.h"
 #include "notes-utils.h"
 #include "rerere.h"
+#include "prompt.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -119,6 +120,7 @@ struct am_state {
 	int prec;
 
 	/* various operating modes and command line options */
+	int interactive;
 	int threeway;
 	int quiet;
 	int append_signoff;
@@ -1173,7 +1175,7 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 	if (state->resolvemsg) {
 		printf_ln("%s", state->resolvemsg);
 	} else {
-		const char *cmdline = "git am";
+		const char *cmdline = state->interactive ? "git am -i" : "git am";
 
 		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
 		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
@@ -1406,6 +1408,36 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 }
 
 /**
+ * Writes the diff of the index against HEAD as a patch to the state
+ * directory's "patch" file.
+ */
+static void write_index_patch(const struct am_state *state)
+{
+	struct tree *tree;
+	unsigned char head[GIT_SHA1_RAWSZ];
+	struct rev_info rev_info;
+	FILE *fp;
+
+	if (!get_sha1_tree("HEAD", head))
+		tree = lookup_tree(head);
+	else
+		tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
+
+	fp = xfopen(am_path(state, "patch"), "w");
+	init_revisions(&rev_info, NULL);
+	rev_info.diff = 1;
+	rev_info.disable_stdin = 1;
+	rev_info.no_commit_id = 1;
+	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev_info.diffopt.use_color = 0;
+	rev_info.diffopt.file = fp;
+	rev_info.diffopt.close_file = 1;
+	add_pending_object(&rev_info, &tree->object, "");
+	diff_setup_done(&rev_info.diffopt);
+	run_diff_index(&rev_info, 1);
+}
+
+/**
  * Like parse_mail(), but parses the mail by looking up its commit ID
  * directly. This is used in --rebasing mode to bypass git-mailinfo's munging
  * of patches.
@@ -1657,6 +1689,65 @@ static void validate_resume_state(const struct am_state *state)
 }
 
 /**
+ * Interactively prompt the user on whether the current patch should be
+ * applied.
+ *
+ * Returns 0 if the user chooses to apply the patch, 1 if the user chooses to
+ * skip it.
+ */
+static int do_interactive(struct am_state *state)
+{
+	assert(state->msg);
+
+	if (!isatty(0))
+		die(_("cannot be interactive without stdin connected to a terminal."));
+
+	for (;;) {
+		const char *reply;
+
+		puts(_("Commit Body is:"));
+		puts("--------------------------");
+		printf("%s", state->msg);
+		puts("--------------------------");
+
+		/*
+		 * TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+		 * in your translation. The program will only accept English
+		 * input at this point.
+		 */
+		reply = git_prompt(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "), PROMPT_ECHO);
+
+		if (!reply) {
+			continue;
+		} else if (*reply == 'y' || *reply == 'Y') {
+			return 0;
+		} else if (*reply == 'a' || *reply == 'A') {
+			state->interactive = 0;
+			return 0;
+		} else if (*reply == 'n' || *reply == 'N') {
+			return 1;
+		} else if (*reply == 'e' || *reply == 'E') {
+			struct strbuf msg = STRBUF_INIT;
+
+			if (!launch_editor(am_path(state, "final-commit"), &msg, NULL)) {
+				free(state->msg);
+				state->msg = strbuf_detach(&msg, &state->msg_len);
+			}
+			strbuf_release(&msg);
+		} else if (*reply == 'v' || *reply == 'V') {
+			const char *pager = git_pager(1);
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			if (!pager)
+				pager = "cat";
+			argv_array_push(&cp.args, pager);
+			argv_array_push(&cp.args, am_path(state, "patch"));
+			run_command(&cp);
+		}
+	}
+}
+
+/**
  * Applies all queued mail.
  *
  * If `resume` is true, we are "resuming". The "msg" and authorship fields, as
@@ -1704,6 +1795,9 @@ static void am_run(struct am_state *state, int resume)
 			write_commit_msg(state);
 		}
 
+		if (state->interactive && do_interactive(state))
+			goto next;
+
 		if (run_applypatch_msg_hook(state))
 			exit(1);
 
@@ -1789,10 +1883,17 @@ static void am_resolve(struct am_state *state)
 		die_user_resolve(state);
 	}
 
+	if (state->interactive) {
+		write_index_patch(state);
+		if (do_interactive(state))
+			goto next;
+	}
+
 	rerere(0);
 
 	do_commit(state);
 
+next:
 	am_next(state);
 	am_run(state, 0);
 }
@@ -2037,6 +2138,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT_BOOL('i', "interactive", &state.interactive,
+			N_("run interactively")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
-- 
2.5.0.rc2.110.gb39b692
