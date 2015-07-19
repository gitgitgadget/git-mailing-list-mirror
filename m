From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 31/45] builtin-am: implement --committer-date-is-author-date
Date: Mon, 20 Jul 2015 00:10:23 +0800
Message-ID: <1437322237-29863-32-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCS-0006cj-FR
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbbGSQMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:12 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35882 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbbGSQMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:05 -0400
Received: by pachj5 with SMTP id hj5so89286321pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YkBoFxEIsj5NaxO56e9w5tBbZnF32XjnOvjPs4aOPPw=;
        b=Jg6vSSpTcXlIPXYNOQK/fwtvllyofsJ6ikiLJwrMl1t3aNE3S5sNGkJdIiC9PP2c7h
         9CrLylkl+mfQmxoZSuP+VgJqOD64LHvFeQZtVzTFYottFyxFBQ8PG1TAFFYJiT9Dxa4B
         Im4B7GS1cXgAGI2ZAnkF9lbYpSeku3ADrIDxnmqAD7XXkNFnDF1OTKMIAfkrwAvLTd8W
         KJmthHgrtSqzKCYoHBJGO9iUUyQNneLt1njJUgkgzCq7vlIJyYV9pcR4zg6nU7Mczrxt
         hiaCzE0llsblbWbtwzTuTRyYG89tFgwMhO82vVfGEekQAi0/HYXWzz0WdcDKofiQVFtK
         GO6Q==
X-Received: by 10.68.178.67 with SMTP id cw3mr49497674pbc.86.1437322325232;
        Sun, 19 Jul 2015 09:12:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274253>

Since 3f01ad6 (am: Add --committer-date-is-author-date option,
2009-01-22), git-am.sh implemented the --committer-date-is-author-date
option, which tells git-am to use the timestamp recorded in the email
message as both author and committer date.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7f068e2..1080df6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -108,6 +108,7 @@ struct am_state {
 	int scissors; /* enum scissors_type */
 	struct argv_array git_apply_opts;
 	const char *resolvemsg;
+	int committer_date_is_author_date;
 	int ignore_date;
 	int rebasing;
 };
@@ -1223,6 +1224,10 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
+	if (state->committer_date_is_author_date)
+		setenv("GIT_COMMITTER_DATE",
+			state->ignore_date ? "" : state->author_date, 1);
+
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
 		die(_("failed to write commit object"));
@@ -1664,6 +1669,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			&state.committer_date_is_author_date,
+			N_("lie about committer date")),
 		OPT_BOOL(0, "ignore-date", &state.ignore_date,
 			N_("use current timestamp for author date")),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
-- 
2.5.0.rc2.110.gb39b692
