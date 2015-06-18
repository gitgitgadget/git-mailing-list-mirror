From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 12/31] am: implement --resolved/--continue
Date: Thu, 18 Jun 2015 19:25:24 +0800
Message-ID: <1434626743-8552-13-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XyD-0004yj-1A
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbbFRL0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:52 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34134 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbbFRL0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:45 -0400
Received: by pdbki1 with SMTP id ki1so64749992pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dkkuk+go61eII+zpiJqfav/xZU10/d77D0+mFSMmO7o=;
        b=Rd0ViVtHfsTwdwnZz6dC5UhOzcU7R8iWhfn436W7gTcHv+FJCXTmytCAtBtHq6pQPs
         lTeF9ULMbkp2gC2q3LkI7SZq1XIQJFDlI9oufktAdSVX0QVQEsfFOFtuxQ3HQRSqFgef
         uiilePoQH8TzUD9t7Xjsk0EGn+HojOXZK4OP2FKROrjO8iHMPxXJWutwXy9TV86knhaP
         hcc95NajjUWUmGjEF/NC7Y2P2xrO97+ahWvi0t2pEivhJtHQ8+g+gWm2Dh9HfifrxTM3
         ooZA7W1ppUxecuCXWIkEkTUue0Pr7fF/YAkZvBQ602zxkRQ6Kq+nRIvU73JNNko6wR2p
         GYkw==
X-Received: by 10.70.6.161 with SMTP id c1mr20235980pda.76.1434626804816;
        Thu, 18 Jun 2015 04:26:44 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271977>

Since 0c15cc9 (git-am: --resolved., 2005-11-16), git-am supported
resuming from a failed patch application. The user will manually apply
the patch, and the run git am --resolved which will then commit the
resulting index. Re-implement this feature by introducing am_resolve().

Since it makes no sense for the user to run am --resolved when there is
no session in progress, we error out in this case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9d6ab2a..4381164 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -707,6 +707,34 @@ next:
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
@@ -721,17 +749,30 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
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
 
@@ -768,6 +809,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		struct string_list paths = STRING_LIST_INIT_DUP;
 		int i;
 
+		if (opt_resume)
+			die(_("Resolve operation not in progress, we are not resuming."));
+
 		for (i = 0; i < argc; i++) {
 			if (is_absolute_path(argv[i]) || !prefix)
 				string_list_append(&paths, argv[i]);
@@ -780,7 +824,16 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
