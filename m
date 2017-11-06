Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B25B202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbdKFL3v (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:29:51 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:10561 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdKFL3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:29:50 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfauewtys; Mon, 06 Nov 2017 11:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967787; bh=WRt1pWfrRHF1vQqFInO7epPQvXA0scIhEjSYKE+Wl9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=HU8f2DtEJP7KUNAMLfDyuOvex0n3OSEqRWXhpn3Pi/b4M8Rdyb9VLJHpLayUoRxK7
         NNTL8enhr8o9oPAB4db8BS8ftcYiJiuVclWEsdukf/ve36qegR8nRCwRWax7Rl+eom
         zwuZORZb+6vT9R4CCAxApDQuCHP9glAopHXMD18M=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=hhem9MKJMQqjwKMfhLMA:9
 a=mpvpwA4Vyn_j4kpM:21 a=uKiNRZWEO6slr6lB:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 7/8] sequencer: load commit related config
Date:   Mon,  6 Nov 2017 11:27:08 +0000
Message-Id: <20171106112709.2121-8-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171106112709.2121-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDuHTcnHjuV3PHmf5vY5/knUCzg0m1GOczye6W3RocdpS+r1C8ZP9VZRON9IV93S3FRVCKX3AFI5K+0rmSC79Ep3R6pP5P2oQhn+al0ciE39Z4CmxBA7
 sbtx1G7hTimykvubWTKZV7+GQnlgWY1xPJ0f2jSYUPpgKgmYm/WNA+Y3yoBACkfSk2BkbLRPln1QVzOz50ei3Sg8dRP5far50CU1394QKCNgMB4wEj72/TT3
 sgnyJIv/G8V09GRSq0e4Fg4pLhg+7ZlSLWAwtoyvlDuIsOBvN1Hv5g6Vif3o3dlF
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
 sequencer.c              | 33 +++++++++++++++++++++++++++++++++
 sequencer.h              |  1 +
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f8519363a393862b6857acab037e74367c7f2134..68194d3aed950f327a8bc624fa1991478dfea01e 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -9,6 +9,17 @@ static const char * const builtin_rebase_helper_usage[] = {
 	NULL
 };
 
+static int git_rebase_helper_config(const char *k, const char *v, void *cb)
+{
+	int status;
+
+	status = git_sequencer_config(k, v, NULL);
+	if (status)
+		return status;
+
+	return git_default_config(k, v, NULL);
+}
+
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
@@ -39,7 +50,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_rebase_helper_config, NULL);
 
 	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
diff --git a/builtin/revert.c b/builtin/revert.c
index b9d927eb09c9ed87c84681df1396f4e6d9b13c97..b700dc7f7fd8657ed8cd2450a8537fe98371783f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -31,6 +31,17 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
+static int git_revert_config(const char *k, const char *v, void *cb)
+{
+	int status;
+
+	status = git_sequencer_config(k, v, NULL);
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
index 3e4c3bbb265db58df22cfcb5a321fb74d822327e..b8cf679751449591d6f97102904e060ebee9d7a1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -688,6 +688,39 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
+		if (status)
+			return status;
+
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
index 0e3c2c9fd416349fb704a7ebc72c93a9b9a67703..944ba50e96d160caac241291377aeece4af2558e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -57,6 +57,7 @@ extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
+int git_sequencer_config(const char *k, const char *v, void *cb);
 
 enum cleanup_mode {
 	CLEANUP_SPACE,
-- 
2.14.3

