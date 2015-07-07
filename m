From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 31/44] builtin-am: implement -S/--gpg-sign, commit.gpgsign
Date: Tue,  7 Jul 2015 22:20:49 +0800
Message-ID: <1436278862-2638-32-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmL-00057X-SW
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbbGGOXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:13 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35978 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757592AbbGGOWl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:41 -0400
Received: by pddu5 with SMTP id u5so39245233pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JmyQItKIIubxW7iVY9XWEI9fdEtmuoBNGOY4gjgpZbg=;
        b=aUo00i10qB5f6lRiU0QM0bMkcNLwkRCGLQDQP49cQ97Q0SOip5piFSokOA1Q+8csZW
         Z7qjfP+1yltx4jgHRW4is8sfa8FphxqfZkVQ8K3W1r0ZOE4XbnBA+WWonja5ADDyLO8R
         NCkvM20R5toWQ8ScCrkUK0yudcGd3lNli87CSttbqEemy4z5AsFjvX94oeoqc6ao8vRV
         dtdC26GSsa/1UoqFV6P713v9u/cRv+UPXWxEWULMiat/Gp55gna5RjTg7/XaMwjuTFoS
         Z9GRs1PQ8W1/B7kV+AS01XtonK/AWqo4PL2d41Tc4wl8P+HhussuWGVq5/jHtRlIvKg8
         Fu3w==
X-Received: by 10.66.156.68 with SMTP id wc4mr9538866pab.126.1436278960295;
        Tue, 07 Jul 2015 07:22:40 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273546>

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

Notes:
    v5
    
    * Renamed local "sign_commit" variable in am_state_init() to "gpgsign"
      to aid code review.

 builtin/am.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index d7bb159..81b3e31 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -124,6 +124,8 @@ struct am_state {
 
 	int ignore_date;
 
+	const char *sign_commit;
+
 	int rebasing;
 };
 
@@ -133,6 +135,8 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state, const char *dir)
 {
+	int gpgsign;
+
 	memset(state, 0, sizeof(*state));
 
 	assert(dir);
@@ -149,6 +153,9 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
+
+	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
+		state->sign_commit = gpgsign ? "" : NULL;
 }
 
 /**
@@ -1266,7 +1273,7 @@ static void do_commit(const struct am_state *state)
 			state->ignore_date ? "" : state->author_date, 1);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
-				author, NULL))
+				author, state->sign_commit))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
@@ -1688,6 +1695,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc1.76.gf60a929
