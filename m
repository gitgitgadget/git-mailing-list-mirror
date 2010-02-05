From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 6/6] receive-pack: Send hook output over side band #2
Date: Fri,  5 Feb 2010 12:57:42 -0800
Message-ID: <1265403462-20572-7-git-send-email-spearce@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:08:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVQB-0002it-Cy
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834Ab0BEVIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:08:53 -0500
Received: from george.spearce.org ([209.20.77.23]:35085 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518Ab0BEVIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:08:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 83E8138221
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 20:57:45 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
In-Reply-To: <1265403462-20572-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139093>

If the client requests to enable side-band-64k capability we can
safely send any hook stdout or stderr data down side band #2,
so the client can present it to the user.

If side-band-64k isn't enabled, hooks continue to inherit stderr
from the parent receive-pack process.

When the side band channel is being used the push client will wind up
prefixing all server messages with "remote: ", just like fetch does,
so our test vector has to be updated with the new expected output.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-receive-pack.c  |   65 ++++++++++++++++++++++++++++++++++++++++++----
 t/t5401-update-hooks.sh |   22 ++++++++--------
 2 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index ff3f117..da1c26b 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -139,11 +139,25 @@ static struct command *commands;
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
+static int copy_to_sideband(int in, int out, void *arg)
+{
+	char data[128];
+	while (1) {
+		ssize_t sz = xread(in, data, sizeof(data));
+		if (sz <= 0)
+			break;
+		send_sideband(1, 2, data, sz, use_sideband);
+	}
+	close(in);
+	return 0;
+}
+
 static int run_receive_hook(const char *hook_name)
 {
 	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
 	struct command *cmd;
 	struct child_process proc;
+	struct async muxer;
 	const char *argv[2];
 	int have_input = 0, code;
 
@@ -163,9 +177,23 @@ static int run_receive_hook(const char *hook_name)
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 
+	if (use_sideband) {
+		memset(&muxer, 0, sizeof(muxer));
+		muxer.proc = copy_to_sideband;
+		muxer.in = -1;
+		code = start_async(&muxer);
+		if (code)
+			return code;
+		proc.err = muxer.in;
+	}
+
 	code = start_command(&proc);
-	if (code)
+	if (code) {
+		if (use_sideband)
+			finish_async(&muxer);
 		return code;
+	}
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
@@ -177,6 +205,8 @@ static int run_receive_hook(const char *hook_name)
 		}
 	}
 	close(proc.in);
+	if (use_sideband)
+		finish_async(&muxer);
 	return finish_command(&proc);
 }
 
@@ -184,6 +214,8 @@ static int run_update_hook(struct command *cmd)
 {
 	static const char update_hook[] = "hooks/update";
 	const char *argv[5];
+	struct child_process proc;
+	int code;
 
 	if (access(update_hook, X_OK) < 0)
 		return 0;
@@ -194,8 +226,18 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
-	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN |
-					RUN_COMMAND_STDOUT_TO_STDERR);
+	memset(&proc, 0, sizeof(proc));
+	proc.no_stdin = 1;
+	proc.stdout_to_stderr = 1;
+	proc.err = use_sideband ? -1 : 0;
+	proc.argv = argv;
+
+	code = start_command(&proc);
+	if (code)
+		return code;
+	if (use_sideband)
+		copy_to_sideband(proc.err, -1, NULL);
+	return finish_command(&proc);
 }
 
 static int is_ref_checked_out(const char *ref)
@@ -384,8 +426,9 @@ static char update_post_hook[] = "hooks/post-update";
 static void run_update_post_hook(struct command *cmd)
 {
 	struct command *cmd_p;
-	int argc, status;
+	int argc;
 	const char **argv;
+	struct child_process proc;
 
 	for (argc = 0, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
 		if (cmd_p->error_string)
@@ -407,8 +450,18 @@ static void run_update_post_hook(struct command *cmd)
 		argc++;
 	}
 	argv[argc] = NULL;
-	status = run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
-			| RUN_COMMAND_STDOUT_TO_STDERR);
+
+	memset(&proc, 0, sizeof(proc));
+	proc.no_stdin = 1;
+	proc.stdout_to_stderr = 1;
+	proc.err = use_sideband ? -1 : 0;
+	proc.argv = argv;
+
+	if (!start_command(&proc)) {
+		if (use_sideband)
+			copy_to_sideband(proc.err, -1, NULL);
+		finish_command(&proc);
+	}
 }
 
 static void execute_commands(const char *unpacker_error)
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 64f66c9..c3cf397 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -118,19 +118,19 @@ test_expect_success 'send-pack produced no output' '
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
+remote: STDOUT pre-receive
+remote: STDERR pre-receive
+remote: STDOUT update refs/heads/master
+remote: STDERR update refs/heads/master
+remote: STDOUT update refs/heads/tofail
+remote: STDERR update refs/heads/tofail
+remote: STDOUT post-receive
+remote: STDERR post-receive
+remote: STDOUT post-update
+remote: STDERR post-update
 EOF
 test_expect_success 'send-pack stderr contains hook messages' '
-	grep ^STD send.err >actual &&
+	grep ^remote: send.err | sed "s/ *\$//" >actual &&
 	test_cmp - actual <expect
 '
 
-- 
1.7.0.rc1.199.g9253ab
