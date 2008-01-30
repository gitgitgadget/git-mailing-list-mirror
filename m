From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/7] Redirect receive-pack hook output into sideband channel
Date: Wed, 30 Jan 2008 01:22:18 -0500
Message-ID: <20080130062218.GG15838@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:23:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6Lx-0001Yk-8m
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbYA3GW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYA3GW2
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:22:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58719 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbYA3GWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2008 01:22:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK6Ky-0000Be-9M; Wed, 30 Jan 2008 01:22:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 07B4D20FBAE; Wed, 30 Jan 2008 01:22:19 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72036>

If both send-pack and receive-pack have selected to enable the
side-band-64k protocol extension we can redirect the stdout and
stderr from any hooks we execute into the multiplexed band #2
channel.  This allows recv_sideband running as an async "thread"
in send-pack to automatically unpack the additional messages and
display them on send-pack's stderr.

There are two different styles of hooks in use within receive-pack,
so our solution for perform this redirection varies a little.

In the update and post-update hooks there is no stdin provided to
the hook so we can perform a naive loop around the stderr pipe,
copying any received messages into band #2.  The stderr pipe is
also dup'd over to stdout by start_command, so we get both sets of
messages over this single fd.

In the pre-receive and post-receive hooks we need to supply the set
of commands on stdin to the hook.  To avoid a deadlock with the
hook we implement a poll loop within receive-pack, watching for
when we can feed additional data into the hook and also for when
we need to copy messages off the stderr pipe to band #2.  By doing
this here in receive-pack we allow the hook author to not need to
perform the same sort of complex poll based IO for its stdin and
stdout/stderr handling.

Test vectors in t5401 needed to be modified slightly as any messages
received through sideband #2 are prefixed on the send-pack side with
"remote: ", indicating their origin.  As the test suite is always
run with the same version of send-pack/receive-pack code we know
they will agree to enable the side-band-64k extension.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c          |   91 +++++++++++++++++++++++++++++++++++++++-------
 t/t5401-update-hooks.sh |   22 ++++++------
 2 files changed, 88 insertions(+), 25 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index 8962c4c..f9f080b 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -56,7 +56,14 @@ static void write_head_info(void)
 	for_each_ref(show_ref, NULL);
 	if (!capabilities_sent)
 		show_ref("capabilities^{}", null_sha1, 0, NULL);
+}
 
+static void show_hook_output(char *msgs, ssize_t n)
+{
+	if (use_sideband)
+		send_sideband(1, 2, msgs, n, use_sideband);
+	else
+		write_in_full(2, msgs, n);
 }
 
 struct command {
@@ -100,10 +107,13 @@ static int hook_status(int code, const char *hook_name)
 static int run_hook(const char *hook_name)
 {
 	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
+	static char msgs[128];
 	struct command *cmd;
 	struct child_process proc;
 	const char *argv[2];
 	int have_input = 0, code;
+	size_t buf_len, buf_off;
+	struct pollfd pfd[2];
 
 	for (cmd = commands; !have_input && cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
@@ -119,28 +129,87 @@ static int run_hook(const char *hook_name)
 	memset(&proc, 0, sizeof(proc));
 	proc.argv = argv;
 	proc.in = -1;
+	proc.err = -1;
 	proc.stdout_to_stderr = 1;
 
 	code = start_command(&proc);
 	if (code)
 		return hook_status(code, hook_name);
+
+	pfd[0].fd = proc.in;
+	pfd[0].events = POLLOUT;
+	pfd[1].fd = proc.err;
+	pfd[1].events = POLLIN;
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string) {
-			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
+		if (cmd->error_string)
+			continue;
+		buf_off = 0;
+		buf_len = snprintf(buf, sizeof(buf), "%s %s %s\n",
 				sha1_to_hex(cmd->old_sha1),
 				sha1_to_hex(cmd->new_sha1),
 				cmd->ref_name);
-			if (write_in_full(proc.in, buf, n) != n)
-				break;
-		}
+		do {
+			if (poll(pfd, 2, -1) < 0) {
+				if (errno == EINTR)
+					continue;
+				goto finish;
+			}
+			if (pfd[0].revents & POLLOUT) {
+				ssize_t r = xwrite(proc.in, buf + buf_off, buf_len);
+				if (r <= 0)
+					goto finish;
+				buf_len -= r;
+				buf_off += r;
+			}
+			if (pfd[1].revents & POLLIN) {
+				ssize_t r = xread(proc.err, msgs, sizeof(msgs));
+				if (r <= 0)
+					goto finish;
+				show_hook_output(msgs, r);
+			}
+		} while (buf_len > 0);
+	}
+
+finish:
+	close(proc.in);
+	proc.close_in = 0;
+	for (;;) {
+		ssize_t r = xread(proc.err, msgs, sizeof(msgs));
+		if (r <= 0)
+			break;
+		show_hook_output(msgs, r);
 	}
 	return hook_status(finish_command(&proc), hook_name);
 }
 
+static int run_noinput_hook(const char **argv)
+{
+	static char msgs[128];
+	struct child_process proc;
+	int code;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.no_stdin = 1;
+	proc.stdout_to_stderr = 1;
+	proc.err = -1;
+
+	code = start_command(&proc);
+	if (code)
+		return code;
+	for (;;) {
+		ssize_t sz = xread(proc.err, msgs, sizeof(msgs));
+		if (sz <= 0)
+			break;
+		show_hook_output(msgs, sz);
+	}
+	return finish_command(&proc);
+}
+
 static int run_update_hook(struct command *cmd)
 {
 	static const char update_hook[] = "hooks/update";
-	struct child_process proc;
 	const char *argv[5];
 
 	if (access(update_hook, X_OK) < 0)
@@ -152,12 +221,7 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
-	proc.argv = argv;
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-
-	return hook_status(run_command(&proc), update_hook);
+	return hook_status(run_noinput_hook(argv), update_hook);
 }
 
 static const char *update(struct command *cmd)
@@ -264,8 +328,7 @@ static void run_update_post_hook(struct command *cmd)
 		argc++;
 	}
 	argv[argc] = NULL;
-	run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
-		| RUN_COMMAND_STDOUT_TO_STDERR);
+	run_noinput_hook(argv);
 }
 
 static void execute_commands(const char *unpacker_error)
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 9734fc5..6aae4f3 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -117,19 +117,19 @@ test_expect_failure 'send-pack produced no output' '
 '
 
 cat <<EOF >expect
-STDOUT pre-receive
-STDERR pre-receive
-STDOUT update refs/heads/master
-STDERR update refs/heads/master
-STDOUT update refs/heads/tofail
-STDERR update refs/heads/tofail
-STDOUT post-receive
-STDERR post-receive
-STDOUT post-update
-STDERR post-update
+remote: STDOUT pre-receive[K
+remote: STDERR pre-receive[K
+remote: STDOUT update refs/heads/master[K
+remote: STDERR update refs/heads/master[K
+remote: STDOUT update refs/heads/tofail[K
+remote: STDERR update refs/heads/tofail[K
+remote: STDOUT post-receive[K
+remote: STDERR post-receive[K
+remote: STDOUT post-update[K
+remote: STDERR post-update[K
 EOF
 test_expect_success 'send-pack stderr contains hook messages' '
-	grep ^STD send.err >actual &&
+	grep ^remote: send.err >actual &&
 	git diff - actual <expect
 '
 
-- 
1.5.4.rc5.1126.g6ba14
