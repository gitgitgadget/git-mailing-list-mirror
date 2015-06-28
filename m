From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 30/44] builtin-am: implement --committer-date-is-author-date
Date: Sun, 28 Jun 2015 22:05:52 +0800
Message-ID: <1435500366-31700-31-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGO-0002lh-DP
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbbF1OIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:47 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36320 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbbF1OIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:23 -0400
Received: by pdcu2 with SMTP id u2so101485652pdc.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=07WQ8YvtB924jEnakbK2AHfEFORu28NTHzIjKRMGMdY=;
        b=ZvUj7w4lskpXbrPFRLYXdDjpafsiyeVfc3n3zyjssWg3px9QIODB7idz3wT8iTBUhJ
         9/3tJcq79TrG6KGapLBzNOoPkHSPEvtl56pXn5ne2tEeld3FyDslnQZAwmHjcgjf682o
         NUu5dQj8uZwQ/uciQhXPyth0SmmpG+QgJJePJ79L5AlJJdfNkgmD3cikf0jVUzl4YH7g
         hxJ/oQ9fshEMKhRXJuvV76YktBITEmhhgraNdpcmb9BhbcoYBXRXMqEgFNAxpIetoGne
         YhAHZlV+801BVaqxfqbqthL4WMEh6Y0+pTUQ84c9UiOSXy8O72iU+radk8m0zpfM8VST
         omiQ==
X-Received: by 10.66.63.70 with SMTP id e6mr22222137pas.62.1435500501856;
        Sun, 28 Jun 2015 07:08:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272905>

Since 3f01ad6 (am: Add --committer-date-is-author-date option,
2009-01-22), git-am.sh implemented the --committer-date-is-author-date
option, which tells git-am to use the timestamp recorded in the email
message as both author and committer date.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index d4164de..80850e8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -120,6 +120,8 @@ struct am_state {
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
+	int committer_date_is_author_date;
+
 	int ignore_date;
 
 	int rebasing;
@@ -1265,6 +1267,10 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
+	if (state->committer_date_is_author_date)
+		setenv("GIT_COMMITTER_DATE",
+			state->ignore_date ? "" : state->author_date, 1);
+
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
 		die(_("failed to write commit object"));
@@ -1683,6 +1689,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc0.76.gb2c6e93
