From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 30/31] am: implement --committer-date-is-author-date
Date: Thu, 18 Jun 2015 19:25:42 +0800
Message-ID: <1434626743-8552-31-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XzI-0005sK-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbbFRL1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:54 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35998 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065AbbFRL1b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:31 -0400
Received: by paceq1 with SMTP id eq1so35066470pac.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4JdNdNEapCJvfeoiuOIj6XtvtcoJJ72fvMT8sNduQr0=;
        b=jakDcf5dWSVxYNk0nMuLz/ImIElHQfjQyRjb7dZ8riBFKeJyMGQm9COvDkurc5bYVu
         yB5q9xrJgzVYIVGUNFF5fd7izCtlXWX1fs6RQ/gB1duXVbv8+fAVXk2kBxG0UhbSCCQk
         eDqu9SCZFSgTB+B7xi3b+HDYi1pEsFIXK7SRfqDTc64YpJ8HC5aQoL5egGmrbvZLtg0Q
         j08uZEYs+9QBmmugCuWhU3yBkRc2PhtJ0oEA1ruxhTQ38fF8BDBMN2QPnjwifHWVdwlj
         hyaiObv3ayDC3KA1we5DEQNBetXPXqso1R/3osu2Jgmu9DTrl6ozIHXtwiEmJNXjZ3Pl
         KLYw==
X-Received: by 10.68.235.38 with SMTP id uj6mr20388196pbc.57.1434626850611;
        Thu, 18 Jun 2015 04:27:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271996>

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
index 6623b49..608a2da 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -130,6 +130,8 @@ struct am_state {
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
+	int committer_date_is_author_date;
+
 	int ignore_date;
 
 	int rebasing;
@@ -1136,6 +1138,10 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? NULL : state->author_date.buf,
 			IDENT_STRICT);
 
+	if (state->committer_date_is_author_date)
+		setenv("GIT_COMMITTER_DATE",
+			state->ignore_date ? "" : state->author_date.buf, 1);
+
 	if (commit_tree(state->msg.buf, state->msg.len, tree, parents, commit,
 				author, NULL))
 		die(_("failed to write commit object"));
@@ -1524,6 +1530,9 @@ static struct option am_options[] = {
 	OPT_CMDMODE(0, "abort", &opt_resume,
 		N_("restore the original branch and abort the patching operation."),
 		RESUME_ABORT),
+	OPT_BOOL(0, "committer-date-is-author-date",
+		&state.committer_date_is_author_date,
+		N_("lie about committer date")),
 	OPT_BOOL(0, "ignore-date", &state.ignore_date,
 		N_("use current timestamp for author date")),
 	OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
-- 
2.1.4
