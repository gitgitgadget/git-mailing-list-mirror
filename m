From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 32/45] builtin-am: implement -S/--gpg-sign, commit.gpgsign
Date: Tue,  4 Aug 2015 21:51:53 +0800
Message-ID: <1438696326-19590-33-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfk-0002iy-7f
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbbHDNyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33597 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964940AbbHDNyU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:20 -0400
Received: by padck2 with SMTP id ck2so9398031pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/G6n80nZrgmjnWQ42IT9nmZXZ0tsVJlS78pf5ydzUTs=;
        b=COvgVjaF02LLALl8y/HWpbeM+kS6N8FuL+1FwbFUk4b+gA7/KROGyQDPy8pigTi99C
         xS2iRDwOA7KXDDOeJ0jSSUyilbzAs7Jp9FIU0WcAmugyKpVFPtuHftLBBaXIwStjXGX2
         C3k8RjmmS2EBWZc7CkiyLb9PEobJeclNx4bsi4CPgFWwZLJO3P3I54u+Ul0mA3KMozNg
         rLvHTw0knqrge5ZUZ2LeikJCxF3n+1flMmZ6RIbo2G5e76K+SuZI2zXiItsUkm4JdlQ1
         crxIdQ/Ai10L899LW5UYKor9YfZog9qOpmCo6ZUtv50PuMODeMqLuWJZIxkPNOeSIgqu
         rLag==
X-Received: by 10.68.244.137 with SMTP id xg9mr8022355pbc.27.1438696460227;
        Tue, 04 Aug 2015 06:54:20 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275298>

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
index 1561580..18611fa 100644
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
@@ -133,6 +136,9 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
+
+	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
+		state->sign_commit = gpgsign ? "" : NULL;
 }
 
 /**
@@ -1227,7 +1233,7 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? "" : state->author_date, 1);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
-				author, NULL))
+				author, state->sign_commit))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
@@ -1673,6 +1679,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
