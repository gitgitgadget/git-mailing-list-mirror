From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 17/45] builtin-am: exit with user friendly message on failure
Date: Mon, 20 Jul 2015 00:10:09 +0800
Message-ID: <1437322237-29863-18-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBo-0006JF-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbbGSQLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:38 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36645 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbbGSQLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:32 -0400
Received: by pdjr16 with SMTP id r16so91398598pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7osJIp3jIb7pbfZaa1SqdZvVF1VFoEG79nlbTH5EbnE=;
        b=lAKTBJsmUJSVh2Fo8oA0dubRO7E1TOVkGMX9EUNfpeAG1PcoMle4+IkAnWWx216pwB
         vElEyqEBqT7KlKG2uNp5mA40t09upaZme4b2W+6ZC5sdy8q034KoSOa4g27zsryAl5q6
         vIhA3mb/rXxCGLps6GCnLmjKU3VmfMH1tfJV8g4SBPy4M4eeQyw2tKPni5AnwGhuE2vq
         /yEy/tVU80qswAqKzCf8B9fJ/PSacNLGk/UUIYjhVQNctaV8FoNv0K7+y+RbCcH5Rmyb
         BeB2fgiCIzyklcp7gm79Zo38ckWPRutsUxwJq2qMiqe2Ka05RrNC3kuKRquDZSjaXdEG
         2mUQ==
X-Received: by 10.68.130.98 with SMTP id od2mr49375098pbb.73.1437322291727;
        Sun, 19 Jul 2015 09:11:31 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274240>

Since ced9456 (Give the user a hint for how to continue in the case that
git-am fails because it requires user intervention, 2006-05-02), git-am
prints additional information on how the user can re-invoke git-am to
resume patch application after resolving the failure. Re-implement this
through the die_user_resolve() function.

Since cc12005 (Make git rebase interactive help match documentation.,
2006-05-13), git-am supports the --resolvemsg option which is used by
git-rebase to override the message printed out when git-am fails.
Re-implement this option.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e0b86d1..fb428f9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -83,6 +83,7 @@ struct am_state {
 
 	/* various operating modes and command line options */
 	int quiet;
+	const char *resolvemsg;
 };
 
 /**
@@ -647,6 +648,25 @@ static int index_has_changes(struct strbuf *sb)
 }
 
 /**
+ * Dies with a user-friendly message on how to proceed after resolving the
+ * problem. This message can be overridden with state->resolvemsg.
+ */
+static void NORETURN die_user_resolve(const struct am_state *state)
+{
+	if (state->resolvemsg) {
+		printf_ln("%s", state->resolvemsg);
+	} else {
+		const char *cmdline = "git am";
+
+		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
+		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
+		printf_ln(_("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
+	}
+
+	exit(128);
+}
+
+/**
  * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
  * state->msg will be set to the patch message. state->author_name,
  * state->author_email and state->author_date will be set to the patch author's
@@ -706,7 +726,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	if (is_empty_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty. Was it split wrong?"));
-		exit(128);
+		die_user_resolve(state);
 	}
 
 	strbuf_addstr(&msg, "\n\n");
@@ -871,7 +891,7 @@ static void am_run(struct am_state *state, int resume)
 				printf_ln(_("The copy of the patch that failed is found in: %s"),
 						am_path(state, "patch"));
 
-			exit(128);
+			die_user_resolve(state);
 		}
 
 		do_commit(state);
@@ -899,13 +919,13 @@ static void am_resolve(struct am_state *state)
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
 			"If there is nothing left to stage, chances are that something else\n"
 			"already introduced the same changes; you might want to skip this patch."));
-		exit(128);
+		die_user_resolve(state);
 	}
 
 	if (unmerged_cache()) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
 			"Did you forget to use 'git add'?"));
-		exit(128);
+		die_user_resolve(state);
 	}
 
 	do_commit(state);
@@ -1132,6 +1152,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
+		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
+			N_("override error message when patch failure occurs")),
 		OPT_CMDMODE(0, "continue", &resume,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-- 
2.5.0.rc2.110.gb39b692
