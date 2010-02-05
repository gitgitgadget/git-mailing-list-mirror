From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] push: Use sideband channel for hook messages
Date: Thu, 4 Feb 2010 19:37:48 -0800
Message-ID: <20100205033748.GA19255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:04:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2Y-0003Bj-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934Ab0BEDhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 22:37:53 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:50576 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696Ab0BEDhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 22:37:52 -0500
Received: by iwn27 with SMTP id 27so513781iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 19:37:51 -0800 (PST)
Received: by 10.231.144.207 with SMTP id a15mr1296137ibv.94.1265341071248;
        Thu, 04 Feb 2010 19:37:51 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm635711iwn.11.2010.02.04.19.37.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 19:37:50 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139029>

Rather than sending hook messages over stderr, and losing them
entirely on git:// and smart HTTP transports, receive-pack now
puts them onto a multiplexed sideband channel if the send-pack
client asks for the side-band-64k capablity.  This ensures that
hooks from the server can report their detailed error messages,
if any, no matter what git-aware transport is being used.

When the side band channel is being used the push client will wind up
prefixing all server messages with "remote: ", just like fetch does.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 We should have done this back when we added smart HTTP, because
 otherwise the server can't send its hook messages back to the
 client.  I'd argue that is a bug, and so this should go in maint,
 but I can also see how some might consider this a new feature... so
 whatever.  :-)

 builtin-receive-pack.c  |  111 +++++++++++++++++++++++++++++++++++++----------
 builtin-send-pack.c     |   67 +++++++++++++++++++++-------
 run-command.c           |   24 ++++++++--
 run-command.h           |    1 +
 t/t5401-update-hooks.sh |   22 +++++-----
 5 files changed, 170 insertions(+), 55 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 78c0e69..e7bdd71 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -2,6 +2,7 @@
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "commit.h"
@@ -27,11 +28,12 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
+static int use_sideband;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static const char *head_name;
-static char *capabilities_to_send;
+static int send_capabilities = 1;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -105,19 +107,21 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	if (!capabilities_to_send)
+	if (!send_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
-		packet_write(1, "%s %s%c%s\n",
-			     sha1_to_hex(sha1), path, 0, capabilities_to_send);
-	capabilities_to_send = NULL;
+		packet_write(1, "%s %s%c%s%s\n",
+			     sha1_to_hex(sha1), path, 0,
+			     " report-status delete-refs side-band-64k",
+			     prefer_ofs_delta ? " ofs-delta" : "");
+	send_capabilities = 0;
 	return 0;
 }
 
 static void write_head_info(void)
 {
 	for_each_ref(show_ref, NULL);
-	if (capabilities_to_send)
+	if (send_capabilities)
 		show_ref("capabilities^{}", null_sha1, 0, NULL);
 
 }
@@ -135,11 +139,25 @@ static struct command *commands;
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
+static int copy_to_sideband(int in, void *arg)
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
+	struct async sideband_mux;
 	const char *argv[2];
 	int have_input = 0, code;
 
@@ -159,9 +177,23 @@ static int run_receive_hook(const char *hook_name)
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 
+	if (use_sideband) {
+		memset(&sideband_mux, 0, sizeof(sideband_mux));
+		sideband_mux.proc = copy_to_sideband;
+		sideband_mux.is_reader = 1;
+		code = start_async(&sideband_mux);
+		if (code)
+			return code;
+		proc.err = sideband_mux.out;
+	}
+
 	code = start_command(&proc);
-	if (code)
+	if (code) {
+		if (use_sideband)
+			finish_async(&sideband_mux);
 		return code;
+	}
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
@@ -173,6 +205,8 @@ static int run_receive_hook(const char *hook_name)
 		}
 	}
 	close(proc.in);
+	if (use_sideband)
+		finish_async(&sideband_mux);
 	return finish_command(&proc);
 }
 
@@ -180,6 +214,8 @@ static int run_update_hook(struct command *cmd)
 {
 	static const char update_hook[] = "hooks/update";
 	const char *argv[5];
+	struct child_process proc;
+	int code;
 
 	if (access(update_hook, X_OK) < 0)
 		return 0;
@@ -190,8 +226,18 @@ static int run_update_hook(struct command *cmd)
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
+		copy_to_sideband(proc.err, NULL);
+	return finish_command(&proc);
 }
 
 static int is_ref_checked_out(const char *ref)
@@ -380,8 +426,9 @@ static char update_post_hook[] = "hooks/post-update";
 static void run_update_post_hook(struct command *cmd)
 {
 	struct command *cmd_p;
-	int argc, status;
+	int argc;
 	const char **argv;
+	struct child_process proc;
 
 	for (argc = 0, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
 		if (cmd_p->error_string)
@@ -403,8 +450,18 @@ static void run_update_post_hook(struct command *cmd)
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
+			copy_to_sideband(proc.err, NULL);
+		finish_command(&proc);
+	}
 }
 
 static void execute_commands(const char *unpacker_error)
@@ -464,6 +521,8 @@ static void read_head_info(void)
 		if (reflen + 82 < len) {
 			if (strstr(refname + reflen + 1, "report-status"))
 				report_status = 1;
+			if (strstr(refname + reflen + 1, "side-band-64k"))
+				use_sideband = LARGE_PACKET_MAX;
 		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -563,17 +622,25 @@ static const char *unpack(void)
 static void report(const char *unpack_status)
 {
 	struct command *cmd;
-	packet_write(1, "unpack %s\n",
-		     unpack_status ? unpack_status : "ok");
+	struct strbuf buf = STRBUF_INIT;
+
+	packet_buf_write(&buf, "unpack %s\n",
+			 unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
-			packet_write(1, "ok %s\n",
-				     cmd->ref_name);
+			packet_buf_write(&buf, "ok %s\n",
+					 cmd->ref_name);
 		else
-			packet_write(1, "ng %s %s\n",
-				     cmd->ref_name, cmd->error_string);
+			packet_buf_write(&buf, "ng %s %s\n",
+					 cmd->ref_name, cmd->error_string);
 	}
-	packet_flush(1);
+	packet_buf_flush(&buf);
+
+	if (use_sideband)
+		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+	else
+		safe_write(1, buf.buf, buf.len);
+	strbuf_release(&buf);
 }
 
 static int delete_only(struct command *cmd)
@@ -670,10 +737,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
-	capabilities_to_send = (prefer_ofs_delta) ?
-		" report-status delete-refs ofs-delta " :
-		" report-status delete-refs ";
-
 	if (advertise_refs || !stateless_rpc) {
 		add_alternate_refs();
 		write_head_info();
@@ -707,5 +770,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		if (auto_update_server_info)
 			update_server_info(0);
 	}
+	if (use_sideband)
+		packet_flush(1);
 	return 0;
 }
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8fffdbf..4bbc39f 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -372,6 +372,15 @@ static void print_helper_status(struct ref *ref)
 	strbuf_release(&buf);
 }
 
+static int sideband_decoder_callback(int out, void *data)
+{
+	int *fd = data;
+	int in = fd[0];
+	int ret = recv_sideband("send-pack", in, out);
+	close(out);
+	return ret;
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -382,18 +391,22 @@ int send_pack(struct send_pack_args *args,
 	struct strbuf req_buf = STRBUF_INIT;
 	struct ref *ref;
 	int new_refs;
-	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
-	int expect_status_report = 0;
+	int status_report = 0;
+	int use_sideband = 0;
+	unsigned cmds_sent = 0;
 	int ret;
+	struct async sideband_decoder;
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
-		ask_for_status_report = 1;
+		status_report = 1;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
 	if (server_supports("ofs-delta"))
 		args->use_ofs_delta = 1;
+	if (server_supports("side-band-64k"))
+		use_sideband = 1;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -456,28 +469,30 @@ int send_pack(struct send_pack_args *args,
 		if (!ref->deletion)
 			new_refs++;
 
-		if (!args->dry_run) {
+		if (args->dry_run) {
+			ref->status = REF_STATUS_OK;
+		} else {
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
-			if (ask_for_status_report) {
-				packet_buf_write(&req_buf, "%s %s %s%c%s",
+			if (!cmds_sent && (status_report || use_sideband)) {
+				packet_buf_write(&req_buf, "%s %s %s%c%s%s",
 					old_hex, new_hex, ref->name, 0,
-					"report-status");
-				ask_for_status_report = 0;
-				expect_status_report = 1;
+					status_report ? " report-status" : "",
+					use_sideband ? " side-band-64k" : "");
 			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
 					old_hex, new_hex, ref->name);
+			ref->status = status_report ?
+				REF_STATUS_EXPECTING_REPORT :
+				REF_STATUS_OK;
+			cmds_sent++;
 		}
-		ref->status = expect_status_report ?
-			REF_STATUS_EXPECTING_REPORT :
-			REF_STATUS_OK;
 	}
 
 	if (args->stateless_rpc) {
-		if (!args->dry_run) {
+		if (!args->dry_run && cmds_sent) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
@@ -487,23 +502,43 @@ int send_pack(struct send_pack_args *args,
 	}
 	strbuf_release(&req_buf);
 
-	if (new_refs && !args->dry_run) {
+	if (use_sideband && cmds_sent) {
+		memset(&sideband_decoder, 0, sizeof(sideband_decoder));
+		sideband_decoder.proc = sideband_decoder_callback;
+		sideband_decoder.data = fd;
+		if (start_async(&sideband_decoder))
+			die("cannot start sideband decoder");
+		in = sideband_decoder.out;
+	}
+
+	if (new_refs && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
 				ref->status = REF_STATUS_NONE;
+			if (use_sideband)
+				finish_async(&sideband_decoder);
 			return -1;
 		}
 	}
-	if (args->stateless_rpc && !args->dry_run)
+	if (args->stateless_rpc && cmds_sent)
 		packet_flush(out);
 
-	if (expect_status_report)
+	if (status_report && cmds_sent)
 		ret = receive_status(in, remote_refs);
 	else
 		ret = 0;
 	if (args->stateless_rpc)
 		packet_flush(out);
 
+	if (use_sideband && cmds_sent) {
+		int err = finish_async(&sideband_decoder);
+		if (err) {
+			error("sideband decoder failed %d", err);
+			ret = -1;
+		}
+		close(sideband_decoder.out);
+	}
+
 	if (ret < 0)
 		return ret;
 	for (ref = remote_refs; ref; ref = ref->next) {
diff --git a/run-command.c b/run-command.c
index cf2d8f7..7d1fd88 100644
--- a/run-command.c
+++ b/run-command.c
@@ -94,6 +94,9 @@ fail_pipe:
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
+		} else if (cmd->err > 1) {
+			dup2(cmd->err, 2);
+			close(cmd->err);
 		}
 
 		if (cmd->no_stdout)
@@ -228,6 +231,8 @@ fail_pipe:
 
 	if (need_err)
 		close(fderr[1]);
+	else if (cmd->err)
+		close(cmd->err);
 
 	return 0;
 }
@@ -326,10 +331,19 @@ static unsigned __stdcall run_thread(void *data)
 int start_async(struct async *async)
 {
 	int pipe_out[2];
+	int proc_fd, call_fd;
 
 	if (pipe(pipe_out) < 0)
 		return error("cannot create pipe: %s", strerror(errno));
-	async->out = pipe_out[0];
+
+	if (async->is_reader) {
+		proc_fd = pipe_out[0];
+		call_fd = pipe_out[1];
+	} else {
+		call_fd = pipe_out[0];
+		proc_fd = pipe_out[1];
+	}
+	async->out = call_fd;
 
 #ifndef WIN32
 	/* Flush stdio before fork() to avoid cloning buffers */
@@ -342,12 +356,12 @@ int start_async(struct async *async)
 		return -1;
 	}
 	if (!async->pid) {
-		close(pipe_out[0]);
-		exit(!!async->proc(pipe_out[1], async->data));
+		close(call_fd);
+		exit(!!async->proc(proc_fd, async->data));
 	}
-	close(pipe_out[1]);
+	close(proc_fd);
 #else
-	async->fd_for_proc = pipe_out[1];
+	async->fd_for_proc = proc_fd;
 	async->tid = (HANDLE) _beginthreadex(NULL, 0, run_thread, async, 0, NULL);
 	if (!async->tid) {
 		error("cannot create thread: %s", strerror(errno));
diff --git a/run-command.h b/run-command.h
index fb34209..8aed83f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -70,6 +70,7 @@ struct async {
 	int (*proc)(int fd, void *data);
 	void *data;
 	int out;	/* caller reads from here and closes it */
+	unsigned is_reader:1;
 #ifndef WIN32
 	pid_t pid;
 #else
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

-- 
Shawn.
