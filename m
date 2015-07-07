From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 34/44] builtin-am: invoke applypatch-msg hook
Date: Tue,  7 Jul 2015 22:20:52 +0800
Message-ID: <1436278862-2638-35-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:25:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCToH-0006E2-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbbGGOXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:22 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33045 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757733AbbGGOWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:48 -0400
Received: by pdbdz6 with SMTP id dz6so31993633pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7rlckGrnlJFXJXUhAaZ0mIpTQw3qNhwvYo7Gzan5ep8=;
        b=aIf+rv8H7QjWnDb5QtdcyAkAdqiFCDxupeWnhZwuA1+4w3KIATtoApKstEMlwgSJUj
         OAL+WvZJC5sSEm5DtuhuquPQ1YqdLdhBha0Dxw+IE60nVloZund+E9/kqYGRMtAs72nx
         CU8jgev0s5Q5WuXK5Vl1QvdFVgqBXmlceA/c6f0kgaa8j1AYhIl8wcFgawVQDsXNM+wL
         B/BRHl6OueJ2H6a04RSOb/Ydb/K9NGEvVgMUUmgdh1hI2yF1PiNR5aWAc6KqlGav9V2w
         oqNLLNEjd+1B+IOQwWXJHUWCWnD8uPHh76sUoh3PtNLpEFLtFmSid3w+WEnLh97wOLeN
         MjGA==
X-Received: by 10.69.27.39 with SMTP id jd7mr9491583pbd.49.1436278968135;
        Tue, 07 Jul 2015 07:22:48 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273563>

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
index 2255a1e..f856d3b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -491,6 +491,27 @@ static void am_destroy(const struct am_state *state)
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
@@ -1434,6 +1455,9 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_commit_msg(state);
 
+		if (run_applypatch_msg_hook(state))
+			exit(1);
+
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 		apply_status = run_apply(state, NULL);
-- 
2.5.0.rc1.76.gf60a929
