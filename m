From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 29/31] am: implement --ignore-date
Date: Thu, 18 Jun 2015 19:25:41 +0800
Message-ID: <1434626743-8552-30-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xz8-0005oK-E5
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbbFRL1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:50 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36367 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538AbbFRL13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:29 -0400
Received: by pdjm12 with SMTP id m12so64665703pdj.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4pTK2KZtP32bvMUPw1+tk7m2uiR3b2pG/1KJjJzcc3w=;
        b=vOIktVRY+1nRuz19LHNY6NS4CLWRaefv+9BIeiBvP18w9yqKBYoda2iMPoGGGXuviP
         VSQAGb+uNqLJaBRpVwt0rNa/3LvAOrbF6J0IwxVaQ3UfNZXU0YBg7fA+bR9PjiCc3KDO
         32HS3e7brc2iGcv3C8B6ukLjI1bcIbUGIRbiZ+f+sn6aQ/iUo5lbWk29P/p1IB+gtt/i
         wJ2H7wB+XBNclQMczUKzzgqZZDrgHxTHmHJvQVNs9Yl4Vbtu3yO74xUU6QVHxljgwX2x
         a+ZdgAJHgomhx3sExgphjKAnXN5E4htw7jdfkhNpKyNTDhANESX/KUqBWXKGVz7kEgcO
         19nQ==
X-Received: by 10.68.131.41 with SMTP id oj9mr20718465pbb.39.1434626848375;
        Thu, 18 Jun 2015 04:27:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271993>

Since a79ec62 (git-am: Add --ignore-date option, 2009-01-24), git-am.sh
supported the --ignore-date option, and would use the current timestamp
instead of the one provided in the patch if the option was set.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3556765..6623b49 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -130,6 +130,8 @@ struct am_state {
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
+	int ignore_date;
+
 	int rebasing;
 };
 
@@ -1131,7 +1133,8 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name.buf, state->author_email.buf,
-			state->author_date.buf, IDENT_STRICT);
+			state->ignore_date ? NULL : state->author_date.buf,
+			IDENT_STRICT);
 
 	if (commit_tree(state->msg.buf, state->msg.len, tree, parents, commit,
 				author, NULL))
@@ -1521,6 +1524,8 @@ static struct option am_options[] = {
 	OPT_CMDMODE(0, "abort", &opt_resume,
 		N_("restore the original branch and abort the patching operation."),
 		RESUME_ABORT),
+	OPT_BOOL(0, "ignore-date", &state.ignore_date,
+		N_("use current timestamp for author date")),
 	OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 		N_("(internal use for git-rebase)")),
 	OPT_END()
-- 
2.1.4
