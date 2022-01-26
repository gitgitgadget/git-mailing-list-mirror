Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFBC433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiAZVo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:44:56 -0500
Received: from [185.13.181.2] ([185.13.181.2]:59336 "EHLO
        smtpservice.6wind.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S232437AbiAZVoz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jan 2022 16:44:55 -0500
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
        by smtpservice.6wind.com (Postfix) with ESMTP id 777026011B;
        Wed, 26 Jan 2022 22:44:53 +0100 (CET)
From:   Robin Jarry <robin.jarry@6wind.com>
To:     git@vger.kernel.org
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2] receive-pack: add option to interrupt pre-receive when client exits
Date:   Wed, 26 Jan 2022 22:44:37 +0100
Message-Id: <20220126214438.3066132-1-robin.jarry@6wind.com>
X-Mailer: git-send-email 2.35.0.1.g8273a50afc47
In-Reply-To: <20220125095445.1796938-1-robin.jarry@6wind.com>
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When hitting ctrl-c on the client while a remote pre-receive hook is
running, receive-pack is not killed by SIGPIPE because the signal is
ignored. This is a side effect of commit ec7dbd145bd8 (receive-pack:
allow hooks to ignore its standard input stream).

The pre-receive hook itself is not interrupted and does not receive any
error since its stdout is a pipe which is read in an async thread and
output back to the client socket in a side band channel.

After the pre-receive has exited the SIGPIPE default handler is restored
and if the hook did not report any error, objects are migrated from
temporary to permanent storage.

This can be confusing for most people and may even be considered a bug.

Add a new receive.strictPreReceiveImpl config option to *not* ignore
SIGPIPE when running pre-receive. If set to true, and the hook output
cannot be forwarded to the client, receive-pack will be killed via
SIGPIPE and the push will be aborted. Add a signal handler to kill and
reap the hook process before exiting. This option only affects
pre-receive.

This does not guarantee that all client disconnections will abort
a push. If there is no pre-receive hook or if it does not produce any
output, receive-pack will not be killed via SIGPIPE and the push will
complete.

Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
---
v1 -> v2:
  Changed approach following Jiang Xin advice. Adding an option makes
  more sense and also makes a much simpler patch.

 Documentation/config/receive.txt | 13 +++++++++++++
 builtin/receive-pack.c           | 26 +++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 85d5b5a3d2d8..7174168541dc 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -143,3 +143,16 @@ receive.updateServerInfo::
 receive.shallowUpdate::
 	If set to true, .git/shallow can be updated when new refs
 	require new shallow roots. Otherwise those refs are rejected.
+
+receive.strictPreReceiveImpl::
+	If a pre-receive hook does not consume its standard input fully, it may
+	kill receive-pack via SIGPIPE. This can lead to obscure push failures.
+	To avoid potential death-by-SIGPIPE due to poorly written hooks,
+	receive-pack ignores SIGPIPE while running the pre-receive hook.
++
+If this option is set to true, SIGPIPE will `not` be ignored by receive-pack
+while running the "pre-receive" hook. This has a side-effect: If the hook
+outputs something and the client has disconnected, receive-pack will be killed
+and the push will be aborted.
++
+SIGPIPE is always ignored while running "post-receive".
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf9..8718a6dd91b4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -74,6 +74,7 @@ static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
+static int strict_pre_receive_impl;
 static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static struct object_id push_cert_oid;
@@ -219,6 +220,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.strictprereceiveimpl") == 0) {
+		strict_pre_receive_impl = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.certnonceseed") == 0)
 		return git_config_string(&cert_nonce_seed, var, value);
 
@@ -800,6 +806,19 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 	}
 }
 
+static volatile pid_t hook_pid;
+
+static void kill_hook(int signum)
+{
+	if (hook_pid != 0) {
+		kill(hook_pid, signum);
+		waitpid(hook_pid, NULL, 0);
+		hook_pid = 0;
+	}
+	sigchain_pop(signum);
+	raise(signum);
+}
+
 struct receive_hook_feed_state {
 	struct command *cmd;
 	struct ref_push_report *report;
@@ -858,7 +877,11 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 		return code;
 	}
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+	hook_pid = proc.pid;
+	if (strict_pre_receive_impl && strcmp(hook_name, "pre-receive") == 0)
+		sigchain_push(SIGPIPE, kill_hook);
+	else
+		sigchain_push(SIGPIPE, SIG_IGN);
 
 	while (1) {
 		const char *buf;
@@ -872,6 +895,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	if (use_sideband)
 		finish_async(&muxer);
 
+	hook_pid = 0;
 	sigchain_pop(SIGPIPE);
 
 	return finish_command(&proc);
-- 
2.35.0.1.g8273a50afc47

