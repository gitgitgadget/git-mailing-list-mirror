From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 31/31] am: implement -S/--gpg-sign, commit.gpgsign
Date: Thu, 18 Jun 2015 19:25:43 +0800
Message-ID: <1434626743-8552-32-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:28:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XzJ-0005sK-25
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbbFRL16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:58 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35660 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbbFRL1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:33 -0400
Received: by pacyx8 with SMTP id yx8so59564823pac.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s4hbo3CnNwdzgduhIiGMaHaUzTKRguRaIdCc851wuIs=;
        b=xPL7AqdfuSFYqsO3yw4ODy21fJzLA/4PxsMBthO5L/itzAnOoro1Nwq7gunC0sRixH
         A9tYT85v0Ik6lNfkF0k34avGdHfNjJLYMZ9jXVCiXTHSzO/Bdeek14xqUUdHWK7CtnBo
         UYuuyGpz7oqrLcBDa8u5BBJ4ZpmBn9RkfIwrDviqzfQdiVG3vhhBNT0+QFcChSWYItEd
         wtrswA7un8CJarKoRjm2z+7RBe8QHwU4w4vZ8pDe+tJDq480OrLgQuDiVAKW+6nXkxPi
         e5+ZZETYVC9BSjqnASmifFVgTQ/unz2ysAHXKmOdRGgcHDhlqIAsUJ680rxI2cdhNwBb
         YENA==
X-Received: by 10.68.178.68 with SMTP id cw4mr20441703pbc.112.1434626852820;
        Thu, 18 Jun 2015 04:27:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271994>

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
index 608a2da..91dae92 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -134,6 +134,8 @@ struct am_state {
 
 	int ignore_date;
 
+	const char *sign_commit;
+
 	int rebasing;
 };
 
@@ -143,6 +145,7 @@ struct am_state {
 static void am_state_init(struct am_state *state)
 {
 	const char *quiet;
+	int sign_commit;
 
 	memset(state, 0, sizeof(*state));
 
@@ -164,6 +167,9 @@ static void am_state_init(struct am_state *state)
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
+
+	if (!git_config_get_bool("commit.gpgsign", &sign_commit))
+		state->sign_commit = sign_commit ? "" : NULL;
 }
 
 /**
@@ -1143,7 +1149,7 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? "" : state->author_date.buf, 1);
 
 	if (commit_tree(state->msg.buf, state->msg.len, tree, parents, commit,
-				author, NULL))
+				author, state->sign_commit))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
@@ -1535,6 +1541,9 @@ static struct option am_options[] = {
 		N_("lie about committer date")),
 	OPT_BOOL(0, "ignore-date", &state.ignore_date,
 		N_("use current timestamp for author date")),
+	{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
+	  N_("GPG-sign commits"),
+	  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 		N_("(internal use for git-rebase)")),
 	OPT_END()
-- 
2.1.4
