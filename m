From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 11/44] builtin-am: implement --resolved/--continue
Date: Tue,  7 Jul 2015 22:20:29 +0800
Message-ID: <1436278862-2638-12-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmC-00051M-0m
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666AbbGGOWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:15 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36313 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542AbbGGOVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:49 -0400
Received: by pacgz10 with SMTP id gz10so40438796pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DCaJb8OuO4SDaeTSVPHDF3epjt4fvd4iZHc+3avKNc4=;
        b=P0Y48BcTUbyz7zjJhZCfVZwH/uUX22Qyxi2Eh5cSzAUjqHbnuxNbZbEl+vvs0A876x
         ru5lfH2MmndGJELflSajVQuLkxaKm9Ey+ogOfjVjZ7HWeCkWnrvdaMgZehW1ScLXZClM
         7PAEwdXBENTdYNRr+nx6DIQaCZY17iK4ZK0HeS8XYF9RJC0+2YHClzWM8vNyLjN87byY
         pC9zj0r9JShI3JjKJzJnQam55PfUrKD/6pQCvyPw+8DVC8wQY/mGY9/wDagSydH7M3rc
         Y6NLBmphL3+RTY2lNWxQ3sdvvx3gT3Uds8fp3Ks2E6Ycj8DGczCDaZhREj0JMGEZl9DH
         Rx5Q==
X-Received: by 10.70.52.103 with SMTP id s7mr9335007pdo.117.1436278908495;
        Tue, 07 Jul 2015 07:21:48 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273542>

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
2.5.0.rc1.76.gf60a929
