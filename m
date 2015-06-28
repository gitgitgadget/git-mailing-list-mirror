From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 29/44] builtin-am: implement --ignore-date
Date: Sun, 28 Jun 2015 22:05:51 +0800
Message-ID: <1435500366-31700-30-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGO-0002lh-WD
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbbF1OIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:49 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33510 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbbF1OIT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:19 -0400
Received: by padev16 with SMTP id ev16so91891288pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tl4NJaxLrr+ZMCfufxy02d1J4nDwoZI0lYmJxbkwu6s=;
        b=XAoRCiKjAMHAtSm3A+MrIY2cNlW4f4q7lj9c9P80qfEdHp1z1pEf5PnXRRyHvqBedY
         6ErUlHO8Q5QXlelQuu4ce+MW3TeTBSG41aMrqCSfM4bP7J+gV49CjyfQ9Ljg12VxGr4H
         28ibEKNRmwpLPZBITxuOZGu8SEwGZh0WdZMp2XTvveCJhi+ECuMoSeria2KR97SwiM75
         uP/e31Ok/3fC27jnaCGSS7NEyopxDR1/CP/ip7tsGIV4VDI/TLwc3OyvnB5H/FsXe6/I
         aIeaK0azGy5z0dF7W2f2FQ9NnnRSW0ske3xC7Tl/qF8JnI4B3GlVGIK3Mapeej3Cwn3v
         UaFA==
X-Received: by 10.66.66.130 with SMTP id f2mr22984174pat.120.1435500498960;
        Sun, 28 Jun 2015 07:08:18 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272906>

Since a79ec62 (git-am: Add --ignore-date option, 2009-01-24), git-am.sh
supported the --ignore-date option, and would use the current timestamp
instead of the one provided in the patch if the option was set.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5aab627..d4164de 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -120,6 +120,8 @@ struct am_state {
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
+	int ignore_date;
+
 	int rebasing;
 };
 
@@ -1260,7 +1262,8 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
-			state->author_date, IDENT_STRICT);
+			state->ignore_date ? NULL : state->author_date,
+			IDENT_STRICT);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
@@ -1680,6 +1683,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_BOOL(0, "ignore-date", &state.ignore_date,
+			N_("use current timestamp for author date")),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
-- 
2.5.0.rc0.76.gb2c6e93
