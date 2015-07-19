From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 32/45] builtin-am: implement -S/--gpg-sign, commit.gpgsign
Date: Mon, 20 Jul 2015 00:10:24 +0800
Message-ID: <1437322237-29863-33-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrD7-0006yY-Rp
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbbGSQML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:11 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35743 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbbGSQMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:08 -0400
Received: by pabkd10 with SMTP id kd10so17167448pab.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7IOJgPDXkIm+Z7T4l+l7mqdLCOdJRd9NM/9Aj1UH3JM=;
        b=fsVVPPZIX5SLFovJryfEDe4XoARELLBDS7RkNyn0RqU9sBQBbyml1saFAw99MK4+rN
         bSiQ8UmNZ22yledO231yqrBZqcl37AlANl5YNNlq1OWExEsTEr/HHwT1Gyv9rTGG+z26
         OMwLYj2A+1KNY+eUMBH2vxZCfiYN2LP9aLcP1fsFtFzW4F+wm/UjDH9fq9Pp00P0Ahb9
         AG+LK7RHxgjbli9ZlIgO5ELXRcyUPBT5xukMsSDsbTWG1q6DOtfT5FyTPC1w8p8dFg8q
         ICoFBmD1ndePvCmVgjZmpfrEf6+2dUTqYkxytuNhLo5OqZ/hgVBkbp4P47vCWX3MREXF
         +NaA==
X-Received: by 10.70.134.70 with SMTP id pi6mr49470042pdb.100.1437322328291;
        Sun, 19 Jul 2015 09:12:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274266>

Since 3b4e395 (am: add the --gpg-sign option, 2014-02-01), git-am.sh
supported the --gpg-sign option, and would pass it to git-commit-tree,
thus GPG-signing the commit object.

Re-implement this option in builtin/am.c.

git-commit-tree would also sign the commit by default if the
commit.gpgsign setting is true. Since we do not run commit-tree, we
re-implement this behavior by handling the commit.gpgsign setting
ourselves.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1080df6..3612bb3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -110,6 +110,7 @@ struct am_state {
 	const char *resolvemsg;
 	int committer_date_is_author_date;
 	int ignore_date;
+	const char *sign_commit;
 	int rebasing;
 };
 
@@ -119,6 +120,8 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state, const char *dir)
 {
+	int gpgsign;
+
 	memset(state, 0, sizeof(*state));
 
 	assert(dir);
@@ -135,6 +138,9 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
+
+	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
+		state->sign_commit = gpgsign ? "" : NULL;
 }
 
 /**
@@ -1229,7 +1235,7 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? "" : state->author_date, 1);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
-				author, NULL))
+				author, state->sign_commit))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
@@ -1674,6 +1680,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc2.110.gb39b692
