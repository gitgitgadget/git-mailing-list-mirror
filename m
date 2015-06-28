From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 16/44] builtin-am: exit with user friendly message on failure
Date: Sun, 28 Jun 2015 22:05:38 +0800
Message-ID: <1435500366-31700-17-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFf-0002Hn-S2
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbbF1OID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:03 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33357 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbF1OHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:38 -0400
Received: by padev16 with SMTP id ev16so91886852pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eqTDrGWbOduFY7Hx7tZpd6rQS/KAoo0gxzckI1NCKVM=;
        b=rUVxpZL+DP4GSo/i5J2RU1P998WL+/6YQstiJxq44BW4DY613N0BvDVle5ljwUpPyO
         nZFgjlL4lg+8wNcWrWVqRqlShX1J1DutLauFaTypOEb6FBaI4g8keXvnQcms/MvmjWmP
         Ry1tRGyqFuVS4MHf3btRQfbVRluWKWYaCJglKMjw0lbKdzI6kRgkxfSeW8HOGLqGQgsT
         7YeK5On9JSNxSVaPllsdlOwcr4EubAH57TSLyIiVTO5inE21muS1yDEca/GyXB5rjBYy
         tShWfACgKPM7kime7RzkL1UnS7iO55mRY7fwm0rlsG6LZ+3Hk/Gi5TqR//5G1Cj+9JMl
         gOoQ==
X-Received: by 10.69.26.4 with SMTP id iu4mr22204532pbd.140.1435500458367;
        Sun, 28 Jun 2015 07:07:38 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272892>

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
 builtin/am.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 2643b04..7832ecf 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -82,6 +82,9 @@ struct am_state {
 	int prec;
 
 	int quiet;
+
+	/* override error message when patch failure occurs */
+	const char *resolvemsg;
 };
 
 /**
@@ -674,6 +677,25 @@ static int index_has_changes(struct strbuf *sb)
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
@@ -733,7 +755,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	if (is_empty_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty. Was it split wrong?"));
-		exit(128);
+		die_user_resolve(state);
 	}
 
 	strbuf_addstr(&msg, "\n\n");
@@ -874,7 +896,7 @@ static void am_run(struct am_state *state)
 				printf_ln(_("The copy of the patch that failed is found in: %s"),
 						am_path(state, "patch"));
 
-			exit(128);
+			die_user_resolve(state);
 		}
 
 		do_commit(state);
@@ -908,13 +930,13 @@ static void am_resolve(struct am_state *state)
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
@@ -1138,6 +1160,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
+		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
+			N_("override error message when patch failure occurs")),
 		OPT_CMDMODE(0, "continue", &resume,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-- 
2.5.0.rc0.76.gb2c6e93
