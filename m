From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 31/44] builtin-am: implement -S/--gpg-sign, commit.gpgsign
Date: Sun, 28 Jun 2015 22:05:53 +0800
Message-ID: <1435500366-31700-32-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGV-0002qz-Cu
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbbF1OIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:55 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34403 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbbF1OIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:24 -0400
Received: by pdbep18 with SMTP id ep18so79687273pdb.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dH8GnA6OQg0DoZEAUlioYcAd4PN50W2w29P1ySdT/8U=;
        b=oj7Mnsx7JVIIVL+3cLY2kUy2hsbKUml69LPPkwTIUpQsAtMe8E3HKCJv87BYLhP+so
         zeoxpisSDROEZlb5OOOUyBntCCFdbQlP2wWqPCMwJ7W3UU6Hf5XydRxeZ5hUY9RCe381
         IfxwlfSLy6VLcrcURuxfSCFi/D2M5Po1vjeP96mwtgiBs3K/z5bqw/fcflYB9jEQ8wED
         Gm9wnRpIxVBw7gCznXAzh6hvAIy/RVADg5QK5GH7yxn7vTjiAV4LfeULKc6UmgXKXKVA
         snhQKUsBp7yVe2x75KbFmSsbs1DSH+/u51sWSPkcgLBbmPseQWAuQySZJlLVRgmzv09V
         d8dg==
X-Received: by 10.66.157.202 with SMTP id wo10mr22521687pab.44.1435500503960;
        Sun, 28 Jun 2015 07:08:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272907>

Since 3b4e395 (am: add the --gpg-sign option, 2014-02-01), git-am.sh
supported the --gpg-sign option, and would pass it to git-commit-tree,
thus GPG-signing the commit object.

Re-implement this option in builtin/am.c.

git-commit-tree would also sign the commit by default if the
commit.gpgsign setting is true. Since we do not run commit-tree, we
re-implement this behavior by handling the commit.gpgsign setting
ourselves.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 80850e8..d44f5e2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -124,6 +124,8 @@ struct am_state {
 
 	int ignore_date;
 
+	const char *sign_commit;
+
 	int rebasing;
 };
 
@@ -134,6 +136,7 @@ struct am_state {
 static void am_state_init(struct am_state *state, const char *dir)
 {
 	const char *quiet;
+	int sign_commit;
 
 	memset(state, 0, sizeof(*state));
 
@@ -155,6 +158,9 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
+
+	if (!git_config_get_bool("commit.gpgsign", &sign_commit))
+		state->sign_commit = sign_commit ? "" : NULL;
 }
 
 /**
@@ -1272,7 +1278,7 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? "" : state->author_date, 1);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
-				author, NULL))
+				author, state->sign_commit))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
@@ -1694,6 +1700,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("lie about committer date")),
 		OPT_BOOL(0, "ignore-date", &state.ignore_date,
 			N_("use current timestamp for author date")),
+		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
+		  N_("GPG-sign commits"),
+		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
-- 
2.5.0.rc0.76.gb2c6e93
