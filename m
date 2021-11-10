Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3AC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 10:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CD361168
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 10:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhKJKie (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 05:38:34 -0500
Received: from host.78.145.23.62.rev.coltfrance.com ([62.23.145.78]:54708 "EHLO
        smtpservice.6wind.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231239AbhKJKid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 05:38:33 -0500
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
        by smtpservice.6wind.com (Postfix) with ESMTP id 918B66001B;
        Wed, 10 Nov 2021 11:35:44 +0100 (CET)
From:   Robin Jarry <robin.jarry@6wind.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jan Smets <jan.smets@nokia.com>,
        Stephen Morton <stephen.morton@nokia.com>,
        Jeff King <peff@peff.net>, Robin Jarry <robin.jarry@6wind.com>
Subject: [RFC PATCH] receive-pack: interrupt pre-receive when client disconnects
Date:   Wed, 10 Nov 2021 11:35:25 +0100
Message-Id: <20211110103525.171066-1-robin.jarry@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <xmqqzgqd11dp.fsf@gitster.g>
References: <xmqqzgqd11dp.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When hitting ctrl-c on the client while a remote pre-receive hook is
running, receive-pack is not killed by SIGPIPE because the signal is
ignored. This is a side effect of commit ec7dbd145bd8 ("receive-pack:
allow hooks to ignore its standard input stream").

The pre-receive hook itself is not interrupted and does not receive any
error since its stdout is a pipe which is read in an async thread and
output back to the client socket in a side band channel.

After the pre-receive has exited the SIGPIPE default handler is restored
and if the hook did not report any error, objects are migrated from
temporary to permanent storage.

This can be confusing for most people and may even be considered a bug.
When receive-pack cannot forward pre-receive output to the client, do
not ignore the error and kill the hook process so that the push does not
complete.

Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
---
Note that if pre-receive does not produce any output, any disconnection
of the client will not cause the hook to be killed. This is not ideal
but as far as I can see, there is no way to check if the client is alive
without writing in the side band channel. Maybe by sending keepalive
packets before cleaning up. I am not comfortable enough with git
internals to be sure.

 builtin/receive-pack.c | 55 ++++++++++++++++++++++++++++++++++++------
 sideband.c             | 31 +++++++++++++++++++++---
 sideband.h             |  4 +++
 3 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2f4a38adfe2c..5668b8273486 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -469,6 +469,7 @@ static int copy_to_sideband(int in, int out, void *arg)
 {
 	char data[128];
 	int keepalive_active = 0;
+	struct child_process *proc = arg;
 
 	if (keepalive_in_sec <= 0)
 		use_keepalive = KEEPALIVE_NEVER;
@@ -494,7 +495,11 @@ static int copy_to_sideband(int in, int out, void *arg)
 			} else if (ret == 0) {
 				/* no data; send a keepalive packet */
 				static const char buf[] = "0005\1";
-				write_or_die(1, buf, sizeof(buf) - 1);
+				if (proc && proc->pid > 0) {
+					if (write_in_full(1, buf, sizeof(buf) - 1) < 0)
+						goto error;
+				} else
+					write_or_die(1, buf, sizeof(buf) - 1);
 				continue;
 			} /* else there is actual data to read */
 		}
@@ -512,8 +517,21 @@ static int copy_to_sideband(int in, int out, void *arg)
 				 * with it.
 				 */
 				keepalive_active = 1;
-				send_sideband(1, 2, data, p - data, use_sideband);
-				send_sideband(1, 2, p + 1, sz - (p - data + 1), use_sideband);
+				if (proc && proc->pid > 0) {
+					if (send_sideband2(1, 2, data, p - data,
+							   use_sideband) < 0)
+						goto error;
+					if (send_sideband2(1, 2, p + 1,
+							   sz - (p - data + 1),
+							   use_sideband) < 0)
+						goto error;
+				} else {
+					send_sideband(1, 2, data, p - data,
+						      use_sideband);
+					send_sideband(1, 2, p + 1,
+						      sz - (p - data + 1),
+						      use_sideband);
+				}
 				continue;
 			}
 		}
@@ -522,10 +540,24 @@ static int copy_to_sideband(int in, int out, void *arg)
 		 * Either we're not looking for a NUL signal, or we didn't see
 		 * it yet; just pass along the data.
 		 */
-		send_sideband(1, 2, data, sz, use_sideband);
+		if (proc && proc->pid > 0) {
+			if (send_sideband2(1, 2, data, sz, use_sideband) < 0)
+				goto error;
+		} else
+			send_sideband(1, 2, data, sz, use_sideband);
 	}
 	close(in);
 	return 0;
+error:
+	close(in);
+	if (proc && proc->pid > 0) {
+		/*
+		 * SIGPIPE would be more relevant but we want to make sure that
+		 * the hook does not ignore the signal.
+		 */
+		kill(proc->pid, SIGKILL);
+	}
+	return -1;
 }
 
 static void hmac_hash(unsigned char *out,
@@ -807,7 +839,8 @@ struct receive_hook_feed_state {
 };
 
 typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed,
+static int run_and_feed_hook(const char *hook_name,
+			     int isolate_sigpipe, feed_fn feed,
 			     struct receive_hook_feed_state *feed_state)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
@@ -843,6 +876,10 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
 		muxer.proc = copy_to_sideband;
+		if (isolate_sigpipe)
+			muxer.data = NULL;
+		else
+			muxer.data = &proc;
 		muxer.in = -1;
 		code = start_async(&muxer);
 		if (code)
@@ -923,6 +960,7 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 static int run_receive_hook(struct command *commands,
 			    const char *hook_name,
 			    int skip_broken,
+			    int isolate_sigpipe,
 			    const struct string_list *push_options)
 {
 	struct receive_hook_feed_state state;
@@ -936,7 +974,8 @@ static int run_receive_hook(struct command *commands,
 		return 0;
 	state.cmd = commands;
 	state.push_options = push_options;
-	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
+	status = run_and_feed_hook(hook_name, isolate_sigpipe,
+				   feed_receive_hook, &state);
 	strbuf_release(&state.buf);
 	return status;
 }
@@ -1970,7 +2009,7 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
-	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
+	if (run_receive_hook(commands, "pre-receive", 0, 0, push_options)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string = "pre-receive hook declined";
@@ -2572,7 +2611,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		else if (report_status)
 			report(commands, unpack_status);
 		sigchain_pop(SIGPIPE);
-		run_receive_hook(commands, "post-receive", 1,
+		run_receive_hook(commands, "post-receive", 1, 1,
 				 &push_options);
 		run_update_post_hook(commands);
 		string_list_clear(&push_options, 0);
diff --git a/sideband.c b/sideband.c
index 85bddfdcd4f5..27f8d653eb24 100644
--- a/sideband.c
+++ b/sideband.c
@@ -247,11 +247,25 @@ int demultiplex_sideband(const char *me, int status,
 	return 1;
 }
 
+static int send_sideband_priv(int fd, int band, const char *data, ssize_t sz,
+			      int packet_max, int ignore_errors);
+
 /*
  * fd is connected to the remote side; send the sideband data
  * over multiplexed packet stream.
  */
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max)
+{
+	(void)send_sideband_priv(fd, band, data, sz, packet_max, 1);
+}
+
+int send_sideband2(int fd, int band, const char *data, ssize_t sz, int packet_max)
+{
+	return send_sideband_priv(fd, band, data, sz, packet_max, 0);
+}
+
+static int send_sideband_priv(int fd, int band, const char *data, ssize_t sz,
+			      int packet_max, int ignore_errors)
 {
 	const char *p = data;
 
@@ -265,13 +279,24 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			write_or_die(fd, hdr, 5);
+			if (ignore_errors)
+				write_or_die(fd, hdr, 5);
+			else if (write_in_full(fd, hdr, 5) < 0)
+				return -1;
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			write_or_die(fd, hdr, 4);
+			if (ignore_errors)
+				write_or_die(fd, hdr, 4);
+			else if (write_in_full(fd, hdr, 4) < 0)
+				return -1;
 		}
-		write_or_die(fd, p, n);
+		if (ignore_errors)
+			write_or_die(fd, p, n);
+		else if (write_in_full(fd, p, n) < 0)
+			return -1;
 		p += n;
 		sz -= n;
 	}
+
+	return 0;
 }
diff --git a/sideband.h b/sideband.h
index 5a25331be55d..cb92777418e1 100644
--- a/sideband.h
+++ b/sideband.h
@@ -29,5 +29,9 @@ int demultiplex_sideband(const char *me, int status,
 			 enum sideband_type *sideband_type);
 
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
+/*
+ * Do not die on write errors, return -1 instead.
+ */
+int send_sideband2(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
-- 
2.30.2

