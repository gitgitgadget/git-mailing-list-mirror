From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 11/45] builtin-am: implement --resolved/--continue
Date: Mon, 20 Jul 2015 00:10:03 +0800
Message-ID: <1437322237-29863-12-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBS-000691-08
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbbGSQLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:18 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34267 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbbGSQLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:17 -0400
Received: by pdbbh15 with SMTP id bh15so44237343pdb.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fsr4kYoEfELqbnwMEeq90sytRrl4B8jv32+ILPudkSQ=;
        b=Y/MLDfF7n0LS3MiTl+FjGAmiu2Y7Ou5mwGUJXLU/Sw4xiazWnEMkC5bGP6KbGttEVi
         5WrXyIG39VDq/cZetNZS17lTgVPvZOlbU9v1GWo/kJDdy5dfZRNoDRn8QWYTkc+bSQiB
         HBtgorUUc9mipwVG6zfVqygcy4J9mqwUk11JG1UBeMsjcOIPyGR6H1dObLyHItzpldmb
         t7GSTEtad2W+7mp9IsoQasqfRxh55j2ldHNeFg+3cUC3DDTFTmO7U+nFAU87jlLKIZtE
         GosnS+9IJwZ04z0TWS5l9hJzerj5gvxDkxGZFNXqli7OhM6NQ3Vwsybm5ych3U8hyak/
         jHCA==
X-Received: by 10.66.101.104 with SMTP id ff8mr9633444pab.59.1437322276505;
        Sun, 19 Jul 2015 09:11:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274234>

Since 0c15cc9 (git-am: --resolved., 2005-11-16), git-am supported
resuming from a failed patch application. The user will manually apply
the patch, and the run git am --resolved which will then commit the
resulting index. Re-implement this feature by introducing am_resolve().

Since it makes no sense for the user to run am --resolved when there is
no session in progress, we error out in this case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v6
    
    * Extracted out the validation of the state directory for resuming into
      a separate validate_resume_state() function, so that it can be shared
      with the next patch.

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
2.5.0.rc2.110.gb39b692
