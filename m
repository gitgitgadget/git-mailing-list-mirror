From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 35/45] builtin-am: invoke applypatch-msg hook
Date: Mon, 20 Jul 2015 00:10:27 +0800
Message-ID: <1437322237-29863-36-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCT-0006cj-MH
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbbGSQMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:18 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34642 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbGSQMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:15 -0400
Received: by pacan13 with SMTP id an13so89912395pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=euIe5ohbHbaJU3b0jCsOSfSxclyWAcf55CTeBBvg/aU=;
        b=mkJhGUqdSG2FiBHkGuQqyovmTG87YGoEPq1zgDPA0oglU9YYcMECu+WxrJpZsxfdPt
         ENJsxn3c7+FLDIUfzxALS0EC1NoGPQZoARz0bU6giBsLYB0pQ7YHhwYmJlf+czpxciFZ
         +VoP99GKBWYqiPoxjFnVaG63LlI+mj0jGEmYQ9lzX6RibKz25o4cQnAC0b3eOYd993/E
         y0Hvc7tx68tUv3/lRK1I4fv6OK28os8QPY6HexqbPl9lvl4+bmFispS0Z+hV4PzXZwyb
         DRHkLW71KFSHkk8n+zQu6tUV9Mkqp9nNqCb6NjiEu07ndxXVHPKeceq4Nahl6KHimta8
         oHVA==
X-Received: by 10.68.240.40 with SMTP id vx8mr50165608pbc.14.1437322334598;
        Sun, 19 Jul 2015 09:12:14 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274256>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the applypatch-msg hooks just after extracting the
patch message. If the applypatch-msg hook exits with a non-zero status,
git-am.sh abort before even applying the patch to the index.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 64b467f..764e955 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -458,6 +458,27 @@ static void am_destroy(const struct am_state *state)
 }
 
 /**
+ * Runs applypatch-msg hook. Returns its exit code.
+ */
+static int run_applypatch_msg_hook(struct am_state *state)
+{
+	int ret;
+
+	assert(state->msg);
+	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+
+	if (!ret) {
+		free(state->msg);
+		state->msg = NULL;
+		if (read_commit_msg(state) < 0)
+			die(_("'%s' was deleted by the applypatch-msg hook"),
+				am_path(state, "final-commit"));
+	}
+
+	return ret;
+}
+
+/**
  * Runs post-rewrite hook. Returns it exit code.
  */
 static int run_post_rewrite_hook(const struct am_state *state)
@@ -1422,6 +1443,9 @@ static void am_run(struct am_state *state, int resume)
 			write_commit_msg(state);
 		}
 
+		if (run_applypatch_msg_hook(state))
+			exit(1);
+
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 		apply_status = run_apply(state, NULL);
-- 
2.5.0.rc2.110.gb39b692
