From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 16/19] am: exit with user friendly message on patch failure
Date: Thu, 11 Jun 2015 18:22:02 +0800
Message-ID: <1434018125-31804-17-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:23:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdp-0008CG-D9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbbFKKXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:23:15 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35114 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbbFKKXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:23:02 -0400
Received: by pdbnf5 with SMTP id nf5so1992789pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVah5Eb3PW5qCDNgnoZKJrVwz/KND7bGqRtATM87uTg=;
        b=QEstqJrx5dpWbWL/PE2db7NsOOzJOdMqkGLdbImdGLISq5GD5k5TDK6akPhar8Rysc
         TYeyP5WK7ooA+fkXn5thlZv5yFg55J7GNlFIXPjwKmWlshnZLv3loq+ZVVx6Hq64qQmr
         zQ3B8cbAa36I3SKZ41Mtk9OxwiA2p0cN4ihygAZ5fNC5DcO9f9MjnB5y0LIU435z0Sno
         ZZuQCxRAyrTowgMqaxkLv7OkTqLSF9AQuuy0qhIPRm3edRGnbHdAs+3nkiWNp0b5vH6N
         QzTBJs2NzGlkurTCfqPfLsTTYsToLiboqyZfzEQpKNrWDt6OadLGwYmAWSL7CikOZSLK
         BN/g==
X-Received: by 10.66.139.41 with SMTP id qv9mr13638916pab.35.1434018181633;
        Thu, 11 Jun 2015 03:23:01 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:23:00 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271397>

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
 builtin/am.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 795b672..4cd21b8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -70,6 +70,9 @@ struct am_state {
 	int prec;
 
 	int quiet;
+
+	/* override error message when patch failure occurs */
+	const char *resolvemsg;
 };
 
 /**
@@ -629,6 +632,21 @@ static int parse_patch(struct am_state *state, const char *patch)
 	return 0;
 }
 
+/**
+ * Dies with a user-friendly message on how to proceed after resolving the
+ * problem. This message can be overridden with state->resolvemsg.
+ */
+static void NORETURN die_user_resolve(const struct am_state *state)
+{
+	if (state->resolvemsg)
+		printf_ln("%s", state->resolvemsg);
+	else
+		printf_ln(_("When you have resolved this problem, run \"git am --continue\".\n"
+			"If you prefer to skip this patch, run \"git am --skip\" instead.\n"
+			"To restore the original branch and stop patching, run \"git am --abort\"."));
+	exit(128);
+}
+
 /*
  * Applies current patch with git-apply. Returns 0 on success, -1 otherwise.
  */
@@ -736,7 +754,7 @@ static void am_run(struct am_state *state)
 				printf_ln(_("The copy of the patch that failed is found in: %s"),
 						am_path(state, "patch"));
 
-			exit(128);
+			die_user_resolve(state);
 		}
 
 		do_commit(state);
@@ -761,13 +779,13 @@ static void am_resolve(struct am_state *state)
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
@@ -981,6 +999,8 @@ static struct option am_options[] = {
 	OPT__QUIET(&state.quiet, N_("be quiet")),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
+	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
+		N_("override error message when patch failure occurs")),
 	OPT_CMDMODE(0, "continue", &opt_resume,
 		N_("continue applying patches after resolving a conflict"),
 		RESUME_RESOLVED),
-- 
2.1.4
