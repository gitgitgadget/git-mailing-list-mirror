From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 31/45] builtin-am: implement --committer-date-is-author-date
Date: Tue,  4 Aug 2015 21:51:52 +0800
Message-ID: <1438696326-19590-32-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfj-0002iy-LD
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbbHDNyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:20 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35182 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964938AbbHDNyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:18 -0400
Received: by pasy3 with SMTP id y3so9207088pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDFvP7CtJj1JtT1FmQPbro/fmcJaJ6OMc7HxM3NF4ig=;
        b=rPq+mXaC4YWbQ5SvjdOe9Rn+7Nbq8aMnnkgUY1EMbs9wX320UjGD3PPiA6MC7ndNFM
         EI0+ryP3/J5HqISba4Y7qbRBhRFRtxHMCPeE4+8gEOXXqh9dRGkHwgvxVAawJsmIGYet
         FpbdHrTxjMhWBPS25sdVQruIx551rJJH4wL7XfwFiwdt++Y50WNhZ8CKyONbTnwNnHEL
         8gdajXc9OZGENRR/7X3Afk7PZbBcue9P92UDX8vlAwb7ZXSo5073LMZ7kwDOsa3HYWWa
         36b6ce+iCNpb3gDz9fQnsSGORnPEQ+Zp3omw4XVxSNDgaNtHuxv9JyVWArEpv+hmipLG
         fuow==
X-Received: by 10.68.168.161 with SMTP id zx1mr8163633pbb.35.1438696457987;
        Tue, 04 Aug 2015 06:54:17 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275295>

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
index 84d3e05..1561580 100644
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
@@ -1221,6 +1222,10 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
+	if (state->committer_date_is_author_date)
+		setenv("GIT_COMMITTER_DATE",
+			state->ignore_date ? "" : state->author_date, 1);
+
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
 		die(_("failed to write commit object"));
@@ -1663,6 +1668,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
