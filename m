From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 17/31] am: exit with user friendly message on patch failure
Date: Thu, 18 Jun 2015 19:25:29 +0800
Message-ID: <1434626743-8552-18-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XyY-0005HE-MM
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbbFRL1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:13 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35194 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbbFRL06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:58 -0400
Received: by pacyx8 with SMTP id yx8so59555261pac.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ib16VbPCTuT2jk5uBhy60njf94ty8o/A8HXWRhNYeVQ=;
        b=o7UWi5Lrd1YVwEY2p8M8YX0JwvopaNjifNaakUbDsP8f35d3yuGhPxyKMVRb+686yG
         7YkNteRaluEJLhA3pSbpC1PCYe7SsgYORxuyFV98+lX4LHzyko2ydiZ6x47vrFZ4jShI
         kiMoqlJpZvtZT2vxiZ8Bnnot0J/vgcfafXT/52fyxN6tlBczsd5W/o/Annxs25py4XTx
         lqxOPxlPs78lyxLrtOAZkRWNPIyj44U/b1DLf00m8l9zTiUIjbJFcGtKIbspUmpr25P2
         aYuENuwxmZB+94itzGY20sK95nvw4QinTtogoEv94LUwFTzz82dMN5yIYqB7wXbqZTLj
         y+BA==
X-Received: by 10.68.65.66 with SMTP id v2mr20586694pbs.9.1434626817472;
        Thu, 18 Jun 2015 04:26:57 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:56 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271980>

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
index 5f38264..1807d12 100644
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
@@ -636,6 +639,21 @@ static int parse_patch(struct am_state *state, const char *patch)
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
@@ -746,7 +764,7 @@ static void am_run(struct am_state *state)
 				printf_ln(_("The copy of the patch that failed is found in: %s"),
 						am_path(state, "patch"));
 
-			exit(128);
+			die_user_resolve(state);
 		}
 
 		do_commit(state);
@@ -771,13 +789,13 @@ static void am_resolve(struct am_state *state)
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
@@ -991,6 +1009,8 @@ static struct option am_options[] = {
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
