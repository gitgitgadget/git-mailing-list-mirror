From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 21/45] builtin-am: implement --rebasing mode
Date: Mon, 20 Jul 2015 00:10:13 +0800
Message-ID: <1437322237-29863-22-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBv-0006N1-Cr
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbbGSQLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:47 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35124 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbbGSQLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:41 -0400
Received: by pdrg1 with SMTP id g1so89728029pdr.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xi95rPPbzfhA8Xds8wr8d70zyLHzVXDA/ybhMrwiAd0=;
        b=L6j/Xg1kRWN514yjs46tUdzHMCISOySP2IT7YpLXKBz1mSnJ6n+BSxUWYgMkPnIbGX
         C9/wxn5qOqJrtmjgdH1+LU7hLvmDi7SepDmu6MpXdZrbyJsWSkUpkUI/t50IXSZG2Zpw
         2DQPSVnrHniKAxGANOt2gJ1NoExhIM46gww9wHFRA/c6KeWJFlUaydVfZG4GDa7aQmE/
         EIKQE7NuxyVjDuaKhD/7r1H8jESJqr+4TIPdW9UnXGce/sSTQiJdmFlzwlylVEz+Ce79
         osaLYhFE9dGq9ZM0CNkwVbcFAgz9zJe2nGQcpagrqCoTJS8zH2u0hXrjC00sScMKxP+k
         mY5A==
X-Received: by 10.68.209.227 with SMTP id mp3mr49450144pbc.100.1437322301212;
        Sun, 19 Jul 2015 09:11:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274245>

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
 builtin/am.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7237fff..3107aba 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -89,6 +89,7 @@ struct am_state {
 	int quiet;
 	int append_signoff;
 	const char *resolvemsg;
+	int rebasing;
 };
 
 /**
@@ -366,6 +367,8 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "sign", 1);
 	state->append_signoff = !strcmp(sb.buf, "t");
 
+	state->rebasing = !!file_exists(am_path(state, "rebasing"));
+
 	strbuf_release(&sb);
 }
 
@@ -544,18 +547,29 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
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
@@ -1056,8 +1070,14 @@ next:
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
@@ -1326,6 +1346,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
+			N_("(internal use for git-rebase)")),
 		OPT_END()
 	};
 
-- 
2.5.0.rc2.110.gb39b692
