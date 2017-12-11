Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C141F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbdLKOOG (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:14:06 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:28253 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbdLKONt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:49 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOq4eBiw7; Mon, 11 Dec 2017 14:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001629;
        bh=tPF3bixair+pa9seBaZfHbjydUvx2ztX8EFMxPUOzSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ZLJtLdYpS62Ot6OEAXffWPWGym5E9Ph71JdqLy6mNgJFRKZAgDOOumtFaMKmwNdHL
         05KA2kL4Y1L5zVP24PhdEAEjDKpwXFh0/+WRcuAAmF1mjzyTbkTbb/GNKaALDTbntX
         0h2Dn9CXxbpqLlVLpBqAe1ra/EjqePJK/zFzAV5s=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=wCDodDw9Ewchy9PJPCEA:9
 a=pzV2rJyJFlvamdHe:21 a=fRi6gA69vdXXY4sx:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 7/9] sequencer: load commit related config
Date:   Mon, 11 Dec 2017 14:13:28 +0000
Message-Id: <20171211141330.23566-8-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCJMr5CICHb1u3txFxYlws6YcZKnl2kjKZseArAEf+5Tzv46SemVG3vV71rRmYEiIW+As/U8V0ARtVoet8/bh48vterxwRJ0YYcDJylnDpPm9YoekfJH
 CA2BQWPOfcVnJMAqiRzYORE54jRCa+off9fxKB3BGxPHcBkzezrBzMnFmrsMwr2HmVZSlBd3OaLJWkqHFon+iOmRgPIoewf1LDPKbZ2quGjyI0xgKL+V4Cts
 PrpTaJoMGhD44mkrU8I2h3dUkLtVqkGuaZpucZCyH/pwZ1cya//4w2j+3INTZcvjbi367bC4kAqoskgQtn2bMcpVKfUjEwANSY7Qs/wAQmdAeNBJevl3EwVZ
 FB3WYx9zvW/ZWR5f38H9GgAeC7jboMuLStewJumk3jN4a8TcdN4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Load default values for message cleanup, gpg signing of commits and
basic diff configuration in preparation for committing without forking
'git commit'. Note that we interpret commit.cleanup=scissors to mean
COMMIT_MSG_CLEANUP_SPACE to be consistent with 'git commit'.

The sequencer should probably have been calling
git_diff_basic_config() before as it creates a patch when there are
conflicts. The shell version uses 'diff-index' to create the patch so
calling git_diff_basic_config() should match that. Although 'git
commit' calls git_diff_ui_config() I don't think the output of
print_commit_summary() is affected by anything that is loaded by that
as print_commit_summary() always turns on rename detection so would
ignore the value in the user's configuration anyway. The other values
loaded by git_diff_ui_config() are about the formatting of patches so
are not relevant to print_commit_summary().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v4:
     - reworked config handling to call git_diff_basic_config() and store
       defaults in struct replay_opts rather than using global variables.
     - added a warning if there is an invalid value for commit.cleanup.
    
    changes since v3:
     - interpret commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE
       to match 'git commit'
    
    changes since v1:
     - renamed git_revert_config() to common_config()
     - prefixed cleanup_mode constants to reflect the changes to patch 2
       in this series

 builtin/rebase--helper.c |  2 +-
 builtin/revert.c         |  4 ++--
 sequencer.c              | 45 +++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h              |  3 +++
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f8519363a393862b6857acab037e74367c7f2134..decb8f7a09e42eb94bed264164985e54e13a32f6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -39,7 +39,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	sequencer_init_config(&opts);
 
 	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
diff --git a/builtin/revert.c b/builtin/revert.c
index b9d927eb09c9ed87c84681df1396f4e6d9b13c97..76f0a35b074b858ab4cb3e3894bc7c877401b7e8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -208,7 +208,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
-	git_config(git_default_config, NULL);
+	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
@@ -221,7 +221,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	opts.action = REPLAY_PICK;
-	git_config(git_default_config, NULL);
+	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
diff --git a/sequencer.c b/sequencer.c
index 4966dd1b9359aaa82064608c05a7f5b18cea2d7a..3ce1e5b71474f1cd25b232a319fb7b0e13dc6e14 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -132,6 +132,51 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 
+static int git_sequencer_config(const char *k, const char *v, void *cb)
+{
+	struct replay_opts *opts = cb;
+	int status;
+
+	if (!strcmp(k, "commit.cleanup")) {
+		const char *s;
+
+		status = git_config_string(&s, k, v);
+		if (status)
+			return status;
+
+		if (!strcmp(s, "verbatim"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
+		else if (!strcmp(s, "whitespace"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
+		else if (!strcmp(s, "strip"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
+		else if (!strcmp(s, "scissors"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
+		else
+			warning(_("invalid commit message cleanup mode '%s'"),
+				  s);
+
+		return status;
+	}
+
+	if (!strcmp(k, "commit.gpgsign")) {
+		opts->gpg_sign = git_config_bool(k, v) ? "" : NULL;
+		return 0;
+	}
+
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
+
+	return git_diff_basic_config(k, v, NULL);
+}
+
+void sequencer_init_config(struct replay_opts *opts)
+{
+	opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
+	git_config(git_sequencer_config, opts);
+}
+
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
 	return opts->action == REPLAY_INTERACTIVE_REBASE;
diff --git a/sequencer.h b/sequencer.h
index bf72e339adbb81900283d8811ed51569aa3e05ee..3a5072c2ab9088c237b83d92deae3c801289e543 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -36,6 +36,7 @@ struct replay_opts {
 	int mainline;
 
 	char *gpg_sign;
+	enum commit_msg_cleanup_mode default_msg_cleanup;
 
 	/* Merge strategy */
 	char *strategy;
@@ -47,6 +48,8 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { -1 }
 
+/* Call this to setup defaults before parsing command line options */
+void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
 int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
-- 
2.15.1

