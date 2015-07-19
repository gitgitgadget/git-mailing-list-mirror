From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 30/45] builtin-am: implement --ignore-date
Date: Mon, 20 Jul 2015 00:10:22 +0800
Message-ID: <1437322237-29863-31-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCG-0006Yf-L7
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbbGSQMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:06 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35865 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbbGSQMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:03 -0400
Received: by pachj5 with SMTP id hj5so89285942pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f7RQUTGbJ6WLjrPphJ14WY6z7CQnNOjHlyOFyDuaMCI=;
        b=eBTiRDqbsKR0YVjEfOq/Lt7FRMoomiX0XpFm6UZokej3btSVhWZ06zcJba7GrrWoEH
         wv2sKwzV2TYEC+8p1YFoDlYD1guiaET65Kz9Z3H9GqeX8d9W8nJRgvLtXEztIB3ffVq1
         3OpB/RUF3GAx6ax7Rkc5gQaLMR5+wVrGODJntFEzjwz6Xm/1jmCY8N0pQbXtHpZORrMj
         2xSyiFlwaQIGfCheAQnJsMd40sCRTZW3rjhvjd0/kZufrLsluOGTnHaqUKz1KZcDHr9h
         xMbzJwIqDJWnhMuDcMuj98kV0uLoGfthF0fLDX9rPxY8RdtzFLAZAY7X/8l/jK//5BiQ
         KUtQ==
X-Received: by 10.68.200.100 with SMTP id jr4mr48792761pbc.168.1437322322809;
        Sun, 19 Jul 2015 09:12:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274251>

Since a79ec62 (git-am: Add --ignore-date option, 2009-01-24), git-am.sh
supported the --ignore-date option, and would use the current timestamp
instead of the one provided in the patch if the option was set.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9ff0736..7f068e2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -108,6 +108,7 @@ struct am_state {
 	int scissors; /* enum scissors_type */
 	struct argv_array git_apply_opts;
 	const char *resolvemsg;
+	int ignore_date;
 	int rebasing;
 };
 
@@ -1219,7 +1220,8 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
-			state->author_date, IDENT_STRICT);
+			state->ignore_date ? NULL : state->author_date,
+			IDENT_STRICT);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
@@ -1662,6 +1664,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_BOOL(0, "ignore-date", &state.ignore_date,
+			N_("use current timestamp for author date")),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
-- 
2.5.0.rc2.110.gb39b692
