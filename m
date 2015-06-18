From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 21/31] am: --rebasing
Date: Thu, 18 Jun 2015 19:25:33 +0800
Message-ID: <1434626743-8552-22-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xym-0005MN-5k
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbbFRL1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:25 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36106 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbbFRL1I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:08 -0400
Received: by pdjm12 with SMTP id m12so64660356pdj.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iQ/t3EI/XnAgyZ9QUwuWAXcu6UaN5rnAmjOb0YQ4pyU=;
        b=TzKfYvfvM+B+SkzlATHvPzmOmpx1Bdw1gh0l7i4g3tXs4xqwdmWXdJL28R0+M4qiwl
         09J+KArIzf+j1zQnnIPiuqBbwWhg+Is/Zn84KULoEquOiWPIcAJD5O4uwQdYs1seGzPD
         IuGilNpk/Kywc9JnzZcqKFqkEri4UWZhwtJKQnttRDKWhoQKKWHzWE8Owm7r9Q5G3A4j
         2cqlirSwOit2wN4Xz5685NxiaRQay75pdKeonJFu7Lpf7SXbctncR48gP+Lai17WkqgQ
         rPKYqby3IyEZJ/aezMWThkt+K1qc7trRG0XyrF/T/xPwI+XqAOOm4e4hX6msOrwwbhTN
         0Gqw==
X-Received: by 10.70.103.10 with SMTP id fs10mr19972749pdb.141.1434626828577;
        Thu, 18 Jun 2015 04:27:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:07 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271988>

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
 builtin/am.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e154c87..9afa3bb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -80,6 +80,8 @@ struct am_state {
 
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
+
+	int rebasing;
 };
 
 /**
@@ -305,6 +307,8 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "sign"), 2, 1);
 	state->sign = !strcmp(sb.buf, "t");
 
+	state->rebasing = !!file_exists(am_path(state, "rebasing"));
+
 	strbuf_release(&sb);
 }
 
@@ -484,6 +488,9 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die(_("Failed to split patches."));
 	}
 
+	if (state->rebasing)
+		state->threeway = 1;
+
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
@@ -494,12 +501,20 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "sign"), 1, state->sign ? "t" : "f");
 
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
 }
 
@@ -921,7 +936,8 @@ next:
 		am_next(state);
 	}
 
-	am_destroy(state);
+	if (!state->rebasing)
+		am_destroy(state);
 }
 
 /**
@@ -1175,6 +1191,8 @@ static struct option am_options[] = {
 	OPT_CMDMODE(0, "abort", &opt_resume,
 		N_("restore the original branch and abort the patching operation."),
 		RESUME_ABORT),
+	OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
+		N_("(internal use for git-rebase)")),
 	OPT_END()
 };
 
-- 
2.1.4
