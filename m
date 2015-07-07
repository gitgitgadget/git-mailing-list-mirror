From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 20/44] builtin-am: implement --rebasing mode
Date: Tue,  7 Jul 2015 22:20:38 +0800
Message-ID: <1436278862-2638-21-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmq-0005PY-2J
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbbGGOXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:34 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33578 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648AbbGGOWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:14 -0400
Received: by pacws9 with SMTP id ws9so115529035pac.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mCjC58p9QXUGQZ2o/KoqI6iKjk//jJO61ZTDFvBLaMc=;
        b=nbvHjDV1u4zpXvK5cXKyRIf0PxXzFf+x+ECOf+yRMNnvkdzW1RP8UCUQEZ3rhaizIv
         YOw8Rq21vBAtdjFudCv95dY9XVNJ8icM8cMzn+nEvRoCwzq8P3NZYFV3s2uY/HCa1+ou
         6NZNZanO9Q19RAKr++Ai+7JJZkOhBXDeo3Eqj7fTzLZ5FADE/pAnOZ47A7/PL4y3gpWn
         /lbMtNZnWO7J5cW4Ruu5zJ/RMr+NvFw38q4zqyBYNOqJv6nJ0FjLJ5piEzY/8qK0rdLZ
         sSAg1tQDOFejGlYvQdtuZuYvfLT0Sl59dCDvdtZWvB4GL9bxwn0JhwXMriyJ3957AGmj
         dL+w==
X-Received: by 10.70.128.34 with SMTP id nl2mr9577156pdb.43.1436278934100;
        Tue, 07 Jul 2015 07:22:14 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273552>

Since 3041c32 (am: --rebasing, 2008-03-04), git-am.sh supported the
--rebasing option, which is used internally by git-rebase to tell git-am
that it is being used for its purpose. It would create the empty file
$state_dir/rebasing to help "completion" scripts tell if the ongoing
operation is am or rebase.

As of 0fbb95d (am: don't call mailinfo if $rebasing, 2012-06-26),
--rebasing also implies --3way as well.

Since a1549e1 (am: return control to caller, for housekeeping,
2013-05-12), git-am.sh would only clean up the state directory when it
is not --rebasing, instead deferring cleanup to git-rebase.sh.

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index af22c35..b68dcc5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -92,6 +92,8 @@ struct am_state {
 
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
+
+	int rebasing;
 };
 
 /**
@@ -386,6 +388,8 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "sign", 1);
 	state->append_signoff = !strcmp(sb.buf, "t");
 
+	state->rebasing = !!file_exists(am_path(state, "rebasing"));
+
 	strbuf_release(&sb);
 }
 
@@ -564,18 +568,29 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die(_("Failed to split patches."));
 	}
 
+	if (state->rebasing)
+		state->threeway = 1;
+
 	write_file(am_path(state, "threeway"), 1, state->threeway ? "t" : "f");
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
 	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
 
+	if (state->rebasing)
+		write_file(am_path(state, "rebasing"), 1, "%s", "");
+	else
+		write_file(am_path(state, "applying"), 1, "%s", "");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
-		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		if (!state->rebasing)
+			update_ref("am", "ORIG_HEAD", curr_head, NULL, 0,
+					UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		write_file(am_path(state, "abort-safety"), 1, "%s", "");
-		delete_ref("ORIG_HEAD", NULL, 0);
+		if (!state->rebasing)
+			delete_ref("ORIG_HEAD", NULL, 0);
 	}
 
 	/*
@@ -1057,8 +1072,14 @@ next:
 		am_next(state);
 	}
 
-	am_destroy(state);
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	/*
+	 * In rebasing mode, it's up to the caller to take care of
+	 * housekeeping.
+	 */
+	if (!state->rebasing) {
+		am_destroy(state);
+		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	}
 }
 
 /**
@@ -1330,6 +1351,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
+			N_("(internal use for git-rebase)")),
 		OPT_END()
 	};
 
-- 
2.5.0.rc1.76.gf60a929
