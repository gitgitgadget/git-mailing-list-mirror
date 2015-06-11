From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 12/19] am: implement --resolved/--continue
Date: Thu, 11 Jun 2015 18:21:58 +0800
Message-ID: <1434018125-31804-13-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdV-00080A-W4
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbbFKKW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:57 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34978 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbbFKKWw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:52 -0400
Received: by pdbnf5 with SMTP id nf5so1990034pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7dlQ7FkpJNepaloam6OsDRy/bg8UnfOqwV95+aRldMA=;
        b=lefoggy7QxWPaC4MxaGd1CCD2Q7BjxO7NfVpG812PUe9GLolhbPuXbXbHqFWfXjatk
         CfCL3CLdjOJrQYqrCDrk0vfWhfySCTZ2v1PyLO5+1Ru50Xv1wkyf09i5MvFYcPZe+D6I
         Cy8x60Ka4/NPshokx6CVdF1AMQEfc80egco7Ja2cQdQfJmT//BrpU1zLhj+UXs2hO7+7
         D+KH03ES6g6D4ZlYtfl4VzR8bxxeSaXP6vLqpkOtgnS9qtTRumNpxjTGJNuMj1wOuV7W
         TPOoarQpTqAIx+9OX0RJe1w2MwXZGSnG8QqWKzdACAuBKgsu65EsIdqf02QFEXvlhvkx
         fL5A==
X-Received: by 10.70.131.33 with SMTP id oj1mr13638426pdb.3.1434018171586;
        Thu, 11 Jun 2015 03:22:51 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:50 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271393>

Since 0c15cc9 (git-am: --resolved., 2005-11-16), git-am supported
resuming from a failed patch application. The user will manually apply
the patch, and the run git am --resolved which will then commit the
resulting index. Re-implement this feature by introducing am_resolve().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 234762c..935ffcb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -697,6 +697,34 @@ next:
 }
 
 /**
+ * Resume the current am session after patch application failure. The user did
+ * all the hard work, and we do not have to do any patch application. Just
+ * trust and commit what the user has in the index and working tree.
+ */
+static void am_resolve(struct am_state *state)
+{
+	printf_ln(_("Applying: %s"), firstline(state->msg.buf));
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
@@ -711,17 +739,30 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 	return 0;
 }
 
+enum resume_mode {
+	RESUME_FALSE = 0,
+	RESUME_RESOLVED
+};
+
 static struct am_state state;
 static int opt_patch_format;
+static enum resume_mode opt_resume;
 
 static const char * const am_usage[] = {
 	N_("git am [options] [(<mbox>|<Maildir>)...]"),
+	N_("git am [options] --continue"),
 	NULL
 };
 
 static struct option am_options[] = {
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
+	OPT_CMDMODE(0, "continue", &opt_resume,
+		N_("continue applying patches after resolving a conflict"),
+		RESUME_RESOLVED),
+	OPT_CMDMODE('r', "resolved", &opt_resume,
+		N_("synonyms for --continue"),
+		RESUME_RESOLVED),
 	OPT_END()
 };
 
@@ -762,7 +803,16 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		string_list_clear(&paths, 0);
 	}
 
-	am_run(&state);
+	switch (opt_resume) {
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
2.1.4
