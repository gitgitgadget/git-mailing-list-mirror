From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 16/44] builtin-am: exit with user friendly message on failure
Date: Tue,  7 Jul 2015 22:20:34 +0800
Message-ID: <1436278862-2638-17-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTlu-0004qP-1x
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716AbbGGOWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:35 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36422 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbbGGOWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:02 -0400
Received: by pacgz10 with SMTP id gz10so40441313pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=du3l9T5hDueFlSOzRWHwlj6Wb9rdYo96KEkuGNlaXk4=;
        b=UmrhE1XOqjh0li/Q1YHsy/uHtN/zzOOMvOsEdpHcUzRjrQGozXB03mfIuFn9aPJdwx
         JpGBGllMKxlBbH3NCjzBUMnRXf1z4Kls4IkyVgZN3h+9nRYr5fl5uLtQKmbO6q3UqcJp
         rHg9ic682h0BGTRVFT+Hun0Z9WKmk/x0sBusYkrRe2S/ErWiI2+BLNI5AvxCoN/LXEnn
         XKvim9YEszYdY9ebi3EWrW6JUQGDzsU6+r2MxjLZ5oQI0aucfDvyWFFnxGTwdJeD0MjL
         8duDOT0bZ3DbYWZReu7j0IAQsSgYRRI3et1OwyE+a/i07w2Ssphd1gLFm/qkBqg5Rq3J
         lNLA==
X-Received: by 10.68.69.11 with SMTP id a11mr9392182pbu.169.1436278921694;
        Tue, 07 Jul 2015 07:22:01 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273535>

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
index 61c2ad3..7eb23b9 100644
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
@@ -668,6 +671,25 @@ static int index_has_changes(struct strbuf *sb)
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
@@ -727,7 +749,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	if (is_empty_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty. Was it split wrong?"));
-		exit(128);
+		die_user_resolve(state);
 	}
 
 	strbuf_addstr(&msg, "\n\n");
@@ -868,7 +890,7 @@ static void am_run(struct am_state *state)
 				printf_ln(_("The copy of the patch that failed is found in: %s"),
 						am_path(state, "patch"));
 
-			exit(128);
+			die_user_resolve(state);
 		}
 
 		do_commit(state);
@@ -902,13 +924,13 @@ static void am_resolve(struct am_state *state)
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
@@ -1132,6 +1154,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
+		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
+			N_("override error message when patch failure occurs")),
 		OPT_CMDMODE(0, "continue", &resume,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-- 
2.5.0.rc1.76.gf60a929
