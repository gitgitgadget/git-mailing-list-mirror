From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 34/44] builtin-am: invoke applypatch-msg hook
Date: Sun, 28 Jun 2015 22:05:56 +0800
Message-ID: <1435500366-31700-35-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGg-0002zM-Dr
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbbF1OJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:05 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35444 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbbF1OIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:31 -0400
Received: by pdbci14 with SMTP id ci14so101362675pdb.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4MfeMaPP5xZF2tXWoxVP5ShDrBJrCav+GShzQWH3/dA=;
        b=KmBk5WsSz5w+Mu7Z/xhEbICbJMaAeGMSw9xfjNLjcKmy4EKzatUvlzkcsNfHFEY3vK
         F/eU66L4preaFEk0V8DfCpyxX9i7hshmyjF2a0kyxIdgcnGJamsYS0ReDKsYb6YsIIbY
         MP/QVtqEli6J+hwM/ho/FRxa82DWP3G94g7TamJq2l+2rudRC7GiCFiPE59W7VbziuDn
         T1Yfu33ToTwCniU57y6/5mOXc0hCSVWE3vjRKsQJMIvPdQcfRc3Gn4tMI65NBz/ugAXp
         FFfS6uY2iE/OthWxw7IiCvjws150157Y5FFNpIj+JSM8aucyJh1xXEiqhzsHM/yDUkoC
         zuIg==
X-Received: by 10.66.122.5 with SMTP id lo5mr22354200pab.141.1435500510746;
        Sun, 28 Jun 2015 07:08:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272911>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the applypatch-msg hooks just after extracting the
patch message. If the applypatch-msg hook exits with a non-zero status,
git-am.sh abort before even applying the patch to the index.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    No tests in master.

 builtin/am.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index f618ff1..814a8b7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -496,6 +496,27 @@ static void am_destroy(const struct am_state *state)
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
@@ -1439,6 +1460,9 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_commit_msg(state);
 
+		if (run_applypatch_msg_hook(state))
+			exit(1);
+
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 		apply_status = run_apply(state, NULL);
-- 
2.5.0.rc0.76.gb2c6e93
