From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 30/44] builtin-am: implement --committer-date-is-author-date
Date: Tue,  7 Jul 2015 22:20:48 +0800
Message-ID: <1436278862-2638-31-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmN-00057X-8k
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799AbbGGOXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36741 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724AbbGGOWi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:38 -0400
Received: by pacgz10 with SMTP id gz10so40448933pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zoVaDTQ5M1KGS5S6M6fCd6QLSJE8Rte80sCAC9JbOns=;
        b=GD7alRal1hd33T/NzlEKrIvlLLQepXYhTfkrgSyg1oNpjbEhvukirIffOiMfpWtJT3
         zsd0GzxPkWexNccBWYwS+ctIdaK1hNdiWVi4Rt7fs5NG1emBHSxT6mUCdOTfqi14gmuF
         hLugUB9aNS6IjKUp27Vx/GLohI58gfYe/FRZoS3PRJmAGz7rdZh3FE70ETNfHql6GsWt
         LZBAP9RjuBhMmsASiDIbfK5ZGvujcxNIK8IuT3SQ6zqjlepbpG3owTuFGa81QrQO9/q9
         +VPWULoA53L1ivsyiwI0dUozcjidPezBKX05RlRvFXbzrHhmQ/ES8oUWf5/d3kG54q+z
         Q5Ig==
X-Received: by 10.66.160.1 with SMTP id xg1mr9444123pab.27.1436278958117;
        Tue, 07 Jul 2015 07:22:38 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273549>

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
index e9eacf0..d7bb159 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -120,6 +120,8 @@ struct am_state {
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
+	int committer_date_is_author_date;
+
 	int ignore_date;
 
 	int rebasing;
@@ -1259,6 +1261,10 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
+	if (state->committer_date_is_author_date)
+		setenv("GIT_COMMITTER_DATE",
+			state->ignore_date ? "" : state->author_date, 1);
+
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
 		die(_("failed to write commit object"));
@@ -1677,6 +1683,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc1.76.gf60a929
