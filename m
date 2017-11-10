Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951021F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 11:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbdKJLK0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:10:26 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:53686 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbdKJLKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:10:09 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id D7C7etmv6mITaD7CJeDJlY; Fri, 10 Nov 2017 11:10:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510312208;
        bh=+tsRO0uoHzdSuI7rrqDPAgEis1kWaIeRkVdkxaNLUA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=VsqvMZnXNMLp9DvaC4r0kxkYXJcBrb4HMG/mkRw3nR8Y9Hkv0J3Ydb+TFVD8/Z6Ev
         w2Sa86K/HUawq/JTDMU8X5CLBIQ0D7ijxYPniR3g2zMylYJ3a3/uMOkuDeFDo8w2Hn
         rLaEgTLhvbMCAYFh7jQVrzILmB4gJ5mZIsqxPgAQ=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=hhem9MKJMQqjwKMfhLMA:9
 a=l_HMvfEa3eZvGMTa:21 a=WBszXNDmikUSsiyi:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 8/9] sequencer: load commit related config
Date:   Fri, 10 Nov 2017 11:09:48 +0000
Message-Id: <20171110110949.328-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110110949.328-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJBImwRyS1Lw95pKX+Z8n3tnvdLK4R3eGB0Zxpouof1Sj9s5ReZkfan0fM1KJikBrw+d+8AwRDHLqdF0H25TbF07jH63wV8QIwQgpgD40bTjTTymbdLk
 imAGJiAPwykMa/fxqTtFo2JBHoyGU6Cnwxf3WzCcR0Irk0o5WdyN1KbnI6JitZHrGNPmtk05dzxTLJ39hV2EOwQY3DGPNoYYXYxk7lIHK6HEYopXF9+IdwnY
 9/tiONiMK14ztbQh0KETYqbddGkUum7pekN9cK5COWNUmiGzPTxeyKUMQnD6QhH8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Load default values for message cleanup and gpg signing of commits in
preparation for committing without forking 'git commit'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v1:
     - renamed git_revert_config() to common_config()
     - prefixed cleanup_mode constants to reflect the changes to patch 2
       in this series

 builtin/rebase--helper.c | 13 ++++++++++++-
 builtin/revert.c         | 15 +++++++++++++--
 sequencer.c              | 34 ++++++++++++++++++++++++++++++++++
 sequencer.h              |  1 +
 4 files changed, 60 insertions(+), 3 deletions(-)

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
index b9d927eb09c9ed87c84681df1396f4e6d9b13c97..1938825efa6ad20ede5aba57f097863aeb33d1d5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -31,6 +31,17 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
+static int common_config(const char *k, const char *v, void *cb)
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
+	git_config(common_config, NULL);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
@@ -221,7 +232,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	opts.action = REPLAY_PICK;
-	git_config(git_default_config, NULL);
+	git_config(common_config, NULL);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
diff --git a/sequencer.c b/sequencer.c
index 497764ea5db3a3ba2802387316c1d5024d47d7eb..0fd98391cb7dfcff6976271f44a56e897593e2c0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -688,6 +688,40 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	return run_command(&cmd);
 }
 
+static enum commit_msg_cleanup_mode default_msg_cleanup =
+						COMMIT_MSG_CLEANUP_NONE;
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
+			default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
+		else if (!strcmp(s, "whitespace"))
+			default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
+		else if (!strcmp(s, "strip"))
+			default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
+		else if (!strcmp(s, "scissors"))
+			default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
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
index e4040cac08cb69c9b91db3fe77ae392c8d6d0f50..27f34be4003589790be686c901a19059f4642c22 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -57,6 +57,7 @@ extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
+int git_sequencer_config(const char *k, const char *v, void *cb);
 
 enum commit_msg_cleanup_mode {
 	COMMIT_MSG_CLEANUP_SPACE,
-- 
2.15.0

