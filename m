From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 11/45] builtin-am: implement --resolved/--continue
Date: Tue,  4 Aug 2015 21:51:32 +0800
Message-ID: <1438696326-19590-12-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:59:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMckC-00054J-BP
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934297AbbHDN67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:58:59 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35549 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934262AbbHDNx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:26 -0400
Received: by pasy3 with SMTP id y3so9191264pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bvHMZ+kXgbi7HtWhT1vpGcV1g1m+n1rNPkocGHJsFpo=;
        b=Nukevpx+tTZ7tqUY+ogFVzyhgJsr2YrQpiU73ymKGzEbhPj3ZrRgfyQYuDenwqc3Bp
         uAVP93Q4sSL0K24jU/h9mfYcsxVE3tjgb2RQREgS9PUo7nlATGyxhxqjfHu9gxp90EOG
         /D6A4vu7IKJoTSNos6wsRV/IiyUB5idLd3q5vQ8BmqV+YaBammwA5JJouT3zW9/3Y2MO
         w1IflDgp+tx0+Rs3lPEnZAN3foCf9ajwLTxJPEj2mU/3X/4QAu9fCT2ayOgCZTEZhGuD
         3mA9+DeksqcwuAxGSAwVR45EDAIOn81VtsS2x9rFGv8M+tZ8pmkn2mY5zXvBqm9lusJL
         Xp4w==
X-Received: by 10.68.174.35 with SMTP id bp3mr8192924pbc.124.1438696406234;
        Tue, 04 Aug 2015 06:53:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275316>

Since 0c15cc9 (git-am: --resolved., 2005-11-16), git-am supported
resuming from a failed patch application. The user will manually apply
the patch, and the run git am --resolved which will then commit the
resulting index. Re-implement this feature by introducing am_resolve().

Since it makes no sense for the user to run am --resolved when there is
no session in progress, we error out in this case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 537ad62..fd26721 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -760,6 +760,21 @@ static void do_commit(const struct am_state *state)
 }
 
 /**
+ * Validates the am_state for resuming -- the "msg" and authorship fields must
+ * be filled up.
+ */
+static void validate_resume_state(const struct am_state *state)
+{
+	if (!state->msg)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "final-commit"));
+
+	if (!state->author_name || !state->author_email || !state->author_date)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "author-script"));
+}
+
+/**
  * Applies all queued mail.
  */
 static void am_run(struct am_state *state)
@@ -814,6 +829,36 @@ next:
 }
 
 /**
+ * Resume the current am session after patch application failure. The user did
+ * all the hard work, and we do not have to do any patch application. Just
+ * trust and commit what the user has in the index and working tree.
+ */
+static void am_resolve(struct am_state *state)
+{
+	validate_resume_state(state);
+
+	printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+
+	if (!index_has_changes(NULL)) {
+		printf_ln(_("No changes - did you forget to use 'git add'?\n"
+			"If there is nothing left to stage, chances are that something else\n"
+			"already introduced the same changes; you might want to skip this patch."));
+		exit(128);
+	}
+
+	if (unmerged_cache()) {
+		printf_ln(_("You still have unmerged paths in your index.\n"
+			"Did you forget to use 'git add'?"));
+		exit(128);
+	}
+
+	do_commit(state);
+
+	am_next(state);
+	am_run(state);
+}
+
+/**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
  */
@@ -828,13 +873,20 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 	return 0;
 }
 
+enum resume_mode {
+	RESUME_FALSE = 0,
+	RESUME_RESOLVED
+};
+
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
+	enum resume_mode resume = RESUME_FALSE;
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
+		N_("git am [options] --continue"),
 		NULL
 	};
 
@@ -842,6 +894,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
+		OPT_CMDMODE(0, "continue", &resume,
+			N_("continue applying patches after resolving a conflict"),
+			RESUME_RESOLVED),
+		OPT_CMDMODE('r', "resolved", &resume,
+			N_("synonyms for --continue"),
+			RESUME_RESOLVED),
 		OPT_END()
 	};
 
@@ -875,6 +933,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
 
+		if (resume)
+			die(_("Resolve operation not in progress, we are not resuming."));
+
 		for (i = 0; i < argc; i++) {
 			if (is_absolute_path(argv[i]) || !prefix)
 				argv_array_push(&paths, argv[i]);
@@ -887,7 +948,16 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		argv_array_clear(&paths);
 	}
 
-	am_run(&state);
+	switch (resume) {
+	case RESUME_FALSE:
+		am_run(&state);
+		break;
+	case RESUME_RESOLVED:
+		am_resolve(&state);
+		break;
+	default:
+		die("BUG: invalid resume value");
+	}
 
 	am_state_release(&state);
 
-- 
2.5.0.280.gd88bd6e
