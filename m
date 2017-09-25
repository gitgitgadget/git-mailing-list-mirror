Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2648320281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934556AbdIYKLZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:25 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:2445 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbdIYKLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:15 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM6dIVJ7; Mon, 25 Sep 2017 11:11:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334275; bh=Cj/XL+IEfD4EMRhAHO1u2JEXtwM6iItuLEcfUXZvsFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UsiiRemoMdsIzipjWjCpeUxHixEcMmB83vjxmieRefnlR9nRqpdcT6ev/6aLj2yD1
         CXUd5an0JObPHoGYv2jZoSOX31+uu8tNTgmTCMPkrCS2mEeGtmL14rV8zxW6jmanRL
         GuZBvKAFNJnq0jeJUT8e1OHHTK9y10h6b9Yp+46M=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=hhem9MKJMQqjwKMfhLMA:9
 a=9vbKWusSeVLwZd4Y:21 a=-dTo4nX9AYJ3Wh06:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 7/8] sequencer: load commit related config
Date:   Mon, 25 Sep 2017 11:10:40 +0100
Message-Id: <20170925101041.18344-8-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDHwm/11zIkXscG7s73x299dNuRiv6EDq5zeYvoG+NzTSxo3FsOb1sWojYWzyArQugoZXr4iFbRBYfSMKQuz0XNpfhjEt77EC71ytIXvAcDDrojYVAp4
 T1SALIOJjqwBT8fa0tDKOpM+yPyL9+7kslMz2w9ss133jAFb126rCZEa+lcTOFo0JXtsKm3hClbquH1nOy2G30Ihtq/mcowX5pWSrr7MJUZudWRs7wHiuWca
 T4y3PxurB3LLCCQCpYe3JQ0FY5t0sjtB8cH9F3ZnfSE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Load default values for message cleanup and gpg signing of commits in
preparation for committing without forking 'git commit'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase--helper.c | 13 ++++++++++++-
 builtin/revert.c         | 15 +++++++++++++--
 sequencer.c              | 30 ++++++++++++++++++++++++++++++
 sequencer.h              |  1 +
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index c82b4dce6838fa039e9c2cfc769c7cd17a8ef562..3a99f9f8f1396ee5a040c7c4e9367688fe04c9a4 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -9,6 +9,17 @@ static const char * const builtin_rebase_helper_usage[] = {
 	NULL
 };
 
+static int git_rebase_helper_config (const char *k, const char *v, void *cb)
+{
+	int status;
+
+	status = git_sequencer_config (k, v, NULL);
+	if (status)
+		return status;
+
+	return git_default_config(k, v, NULL);
+}
+
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
@@ -24,7 +35,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_rebase_helper_config, NULL);
 
 	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
diff --git a/builtin/revert.c b/builtin/revert.c
index b9d927eb09c9ed87c84681df1396f4e6d9b13c97..2883f9eb71be1c2b205fd0f1d962748438f4c4b8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -31,6 +31,17 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
+static int git_revert_config (const char *k, const char *v, void *cb)
+{
+	int status;
+
+	status = git_sequencer_config (k, v, NULL);
+	if (status)
+		return status;
+
+	return git_default_config(k, v, NULL);
+}
+
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
@@ -208,7 +219,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
-	git_config(git_default_config, NULL);
+	git_config(git_revert_config, NULL);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
@@ -221,7 +232,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	opts.action = REPLAY_PICK;
-	git_config(git_default_config, NULL);
+	git_config(git_revert_config, NULL);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
diff --git a/sequencer.c b/sequencer.c
index e9060e3ca50777687c578ff09c62cd901efcfb0e..230bdb8535a422b1263429e5894e3f8b1733e844 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -687,6 +687,36 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	return run_command(&cmd);
 }
 
+static enum cleanup_mode default_msg_cleanup = CLEANUP_NONE;
+static char *default_gpg_sign;
+
+int git_sequencer_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "commit.cleanup")) {
+		int status;
+		const char *s;
+
+		status = git_config_string(&s, k, v);
+		if (!strcmp(s, "verbatim"))
+			default_msg_cleanup = CLEANUP_NONE;
+		else if (!strcmp(s, "whitespace"))
+			default_msg_cleanup = CLEANUP_SPACE;
+		else if (!strcmp(s, "strip"))
+			default_msg_cleanup = CLEANUP_ALL;
+		else if (!strcmp(s, "scissors"))
+			default_msg_cleanup = CLEANUP_NONE;
+
+		return status;
+	}
+
+	if (!strcmp(k, "commit.gpgsign")) {
+		default_gpg_sign = git_config_bool(k, v) ? "" : NULL;
+		return 0;
+	}
+
+	return git_gpg_config(k, v, NULL);
+}
+
 static int rest_is_empty(const struct strbuf *sb, int start)
 {
 	int i, eol;
diff --git a/sequencer.h b/sequencer.h
index d491f5cae2e6152859d114a08bbd7c935d1e80a6..2759ca2f7d1aba1268c88dc8bd94eb3e593897fe 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,6 +49,7 @@ extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
+int git_sequencer_config(const char *k, const char *v, void *cb);
 
 enum cleanup_mode {
 	CLEANUP_SPACE,
-- 
2.14.1

