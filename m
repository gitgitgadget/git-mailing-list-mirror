From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 11/44] builtin-am: implement --resolved/--continue
Date: Sun, 28 Jun 2015 22:05:33 +0800
Message-ID: <1435500366-31700-12-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFN-00025p-ED
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbbF1OHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:43 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33307 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbbF1OH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:26 -0400
Received: by padev16 with SMTP id ev16so91885473pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SqnUx4jf6z3HOlJ+mNPw4EqebW1Nc8EUryQc/ZxDwys=;
        b=NuAwOQxy7lEYShDMdZ6ek7LCL1R5KOQloFBD1cg569vVlwVW0Ig2zl6+ZRg/Y4QU/j
         mPQvqocUT4FKK0SVzNetPJ+/IpdVp+eKcyvj1MzrdRrh4zjCKcm12A1zYR1Bt5ObBpcm
         O2Ugk6lhoWCYzVpHdX2XRcB0lKJVRzxG5vszlPd84lSgxicUx6za3ywfBb4EQxBVhvu5
         zZ7DMX7+NV6yWu3x4CNLrrpTklOZAKWEKp2MOXvfi4hvhoZl3zQlhWMmy+WL1rNrqnZD
         hoeh5WXR96o3wRjCW+V5QFDZcFl4aqD8vSh5Jre8O3JG+dk0KMSR378oYNLug15nn8UG
         eBYw==
X-Received: by 10.70.90.103 with SMTP id bv7mr22789310pdb.160.1435500444869;
        Sun, 28 Jun 2015 07:07:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272887>

Since 0c15cc9 (git-am: --resolved., 2005-11-16), git-am supported
resuming from a failed patch application. The user will manually apply
the patch, and the run git am --resolved which will then commit the
resulting index. Re-implement this feature by introducing am_resolve().

Since it makes no sense for the user to run am --resolved when there is
no session in progress, we error out in this case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index f9a641a..f21565b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -836,6 +836,42 @@ next:
 }
 
 /**
+ * Resume the current am session after patch application failure. The user did
+ * all the hard work, and we do not have to do any patch application. Just
+ * trust and commit what the user has in the index and working tree.
+ */
+static void am_resolve(struct am_state *state)
+{
+	if (!state->msg)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "final-commit"));
+
+	if (!state->author_name || !state->author_email || !state->author_date)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "author-script"));
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
@@ -850,13 +886,20 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
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
 
@@ -864,6 +907,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
 
@@ -897,6 +946,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
 
+		if (resume)
+			die(_("Resolve operation not in progress, we are not resuming."));
+
 		for (i = 0; i < argc; i++) {
 			if (is_absolute_path(argv[i]) || !prefix)
 				argv_array_push(&paths, argv[i]);
@@ -909,7 +961,16 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc0.76.gb2c6e93
