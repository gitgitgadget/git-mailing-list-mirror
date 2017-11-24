Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F44E20954
	for <e@80x24.org>; Fri, 24 Nov 2017 11:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbdKXLIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 06:08:36 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:7464 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbdKXLIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 06:08:17 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id IBq0eNps6Ap17IBqBeb1C9; Fri, 24 Nov 2017 11:08:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511521696;
        bh=zuWGeGNcHDQdIl29/85yZhU2Ku+NyfvECW3g0EDvFDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=FHT2w5+KVFRuCS4wSvtq1AUrTCfj+Y53CPHLQU01/RGpwdkIdjmFPRHwekOVqFK+g
         M2MiJqeH+H2/aNu4B+0yfWAsp6gu0xLCN2osU4hRnroHSOzj7bktIiSbPHn8L+M2N8
         1zC4XqSNiBFKSPwRo1n+Zv/0iUthhg8/1yPUZd0A=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=hhem9MKJMQqjwKMfhLMA:9
 a=VLKk6m_03y0HNLDs:21 a=LeVQdgHSo8ulomSK:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 7/9] sequencer: load commit related config
Date:   Fri, 24 Nov 2017 11:07:56 +0000
Message-Id: <20171124110758.9406-8-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171124110758.9406-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJau08Ypu40/7YlkbKTIGYZyQ9qPjsOB+OMAkJTeDHyWh3/2dxEFyyT9CNdG2uiZOvf8zXuwvNIrq6AYIj1guJTZEsyFOX4bAqiCs4fAcMj0aF+bJJni
 RcpLwTrQ8IsgorrZbEQMlCTzHtaQqq7r1k8IJPitYj3MSYbGk6VpaTgAwU7omAQgQK1CCQAlIEXZXU/hFC8H522GgoX7E7+lqCIXvhrSo4pQ08+HJieKP5O+
 s07aBUNzTvjScX+enO9MDZvtwl+rtDWlqv7XRIA3vFYnj0NWbQjXow+algSxiv6+A8RlxzIxZuSa3jWpJK+gF/2K26vMtQlWKCslbPPPbQWxmzBeyN5PowFZ
 ZrtweimdhdDLQZW60w1XkpR9bsWLxf22LhPepLFoIcOWTMxcpmA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Load default values for message cleanup and gpg signing of commits in
preparation for committing without forking 'git commit'. Note that we
interpret commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE to
be consistent with 'git commit'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v3:
     - interpret commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE
       to match 'git commit'
    
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
index 7400df5522037583108534755af6f542117667c2..40461a41e3798e267813656de6b669c297b521c6 100644
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
+			default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
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
index 4f616c61a3f3869daf9f427b978c308d6094a978..77cb174b2aaf3972ebb9e6ec379252be96dedd3d 100644
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

