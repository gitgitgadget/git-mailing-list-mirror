From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 17/45] builtin-am: exit with user friendly message on failure
Date: Tue,  4 Aug 2015 21:51:38 +0800
Message-ID: <1438696326-19590-18-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfJ-0002W9-68
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbbHDNxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:42 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33936 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbbHDNxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:40 -0400
Received: by pawu10 with SMTP id u10so9242701paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e8mAFMynW6ANuwHrAMDkvDgbx0OU837kOEdCS65khuY=;
        b=Ld680P7IB2yyWhsElvxjmKjx8GxHPg0N4kW9kro9Kzb2ezOm3ojjJLOxjg2k3vH44B
         xeA7Y0Pm/lF4G+7OanoLg0ajUlLLcz/FYb0anOZwzPOce1BYJaHZShIBa4rHhpnF1WxO
         s9wxPtlbM9zLldpPD4wuMcBgMQoDOHPI0TwYqWGaPW4FV/t1L2xFiQZcfqOK+JczWdDu
         ZgJh3Fw1eZ0dWXxr5iG8p52T/fukKPu9D3TcxyjlXpZz0qAATmb3jNTWiYMwG4UaWA7Y
         DohmK9bmZRLprN3gx7rpEgff2huX05CDjaM8jCVlkwd1d41zg9Ji0LdQ/n6yo8PEejS8
         NkbQ==
X-Received: by 10.68.95.4 with SMTP id dg4mr8163924pbb.132.1438696419797;
        Tue, 04 Aug 2015 06:53:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275286>

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
index 0875e69..8b8f2da 100644
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
@@ -1133,6 +1153,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
+		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
+			N_("override error message when patch failure occurs")),
 		OPT_CMDMODE(0, "continue", &resume,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-- 
2.5.0.280.gd88bd6e
