From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/5] git push: verify refs early
Date: Mon, 13 Feb 2012 21:17:13 +0100
Message-ID: <1329164235-29955-4-git-send-email-drizzd@aon.at>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2TC-0002HE-Cu
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038Ab2BMUZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:25:49 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:36777 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757967Ab2BMUZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:25:47 -0500
Received: from localhost (p5B22E0DA.dip.t-dialin.net [91.34.224.218])
	by bsmtp.bon.at (Postfix) with ESMTP id 8A31213004B;
	Mon, 13 Feb 2012 21:25:43 +0100 (CET)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329164235-29955-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190658>

Receive-pack waits for the transfer of all new object data to complete
before taking a closer look at the received refs. It may then decide to
refuse updates of refs without even looking at the data.

Instead, do as much ref validation as possible before new object data is
available, in order to avoid a potentially expensive transfer.
Receive-pack will then respond with "verify-refs ok" if at least one ref
update is valid. Otherwise, it will respond with "verify-refs no valid
refs".

On the client side, send-pack will wait for "verify-refs ok" or skip the
object transfer entirely if it reads a packet line that starts with
"verify-refs " but does not match "verify-refs ok". Any other response
is considered an error.

Early ref validation is disabled for the smart HTTP protocol, since it
tries to fit the entire push (ref info and object data) into a single
POST request.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I suppose with some effort, this could be done for smart HTTP as well.
But I am not sure if we actually want the overhead of the additional
ping-pong for HTTP.

 builtin/receive-pack.c |   83 ++++++++++++++++++++++++++++++++++++++----------
 builtin/send-pack.c    |   43 +++++++++++++++++--------
 send-pack.h            |    3 +-
 3 files changed, 97 insertions(+), 32 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..0129d9c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -34,6 +34,8 @@ static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
 static int quiet;
+static int verify_refs;
+static int stateless_rpc;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
@@ -123,7 +125,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	else
 		packet_write(1, "%s %s%c%s%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k quiet",
+			     " report-status delete-refs side-band-64k quiet verify-refs",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
 }
@@ -410,14 +412,13 @@ static void refuse_unconfigured_deny_delete_current(void)
 		rp_error("%s", refuse_unconfigured_deny_delete_current_msg[i]);
 }
 
-static const char *update(struct command *cmd)
+static const char *verify_ref(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -444,12 +445,6 @@ static const char *update(struct command *cmd)
 		}
 	}
 
-	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
-		error("unpack should have generated %s, "
-		      "but I can't find it!", sha1_to_hex(new_sha1));
-		return "bad pack";
-	}
-
 	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
 		if (deny_deletes && !prefixcmp(name, "refs/heads/")) {
 			rp_error("denying ref deletion for %s", name);
@@ -473,6 +468,27 @@ static const char *update(struct command *cmd)
 		}
 	}
 
+	return NULL;
+}
+
+static const char *update(struct command *cmd)
+{
+	const char *name = cmd->ref_name;
+	struct strbuf namespaced_name_buf = STRBUF_INIT;
+	const char *namespaced_name;
+	unsigned char *old_sha1 = cmd->old_sha1;
+	unsigned char *new_sha1 = cmd->new_sha1;
+	struct ref_lock *lock;
+
+	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
+	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
+
+	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
+		error("unpack should have generated %s, "
+		      "but I can't find it!", sha1_to_hex(new_sha1));
+		return "bad pack";
+	}
+
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
 	    !prefixcmp(name, "refs/heads/")) {
@@ -692,10 +708,41 @@ static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
 	return -1; /* end of list */
 }
 
+static int verify_ref_commands(struct command *commands)
+{
+	unsigned char sha1[20];
+	int commands_ok;
+	struct command *cmd;
+
+	free(head_name_to_free);
+	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
+
+	commands_ok = 0;
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		cmd->error_string = verify_ref(cmd);
+		if (!cmd->error_string)
+			commands_ok++;
+	}
+
+	if (verify_refs && !stateless_rpc) {
+		struct strbuf buf = STRBUF_INIT;
+
+		packet_buf_write(&buf, "verify-refs %s\n",
+			 commands_ok > 0 ? "ok" : "no valid refs");
+
+		if (use_sideband)
+			send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+		else
+			safe_write(1, buf.buf, buf.len);
+		strbuf_release(&buf);
+	}
+
+	return commands_ok;
+}
+
 static void execute_commands(struct command *commands, const char *unpacker_error)
 {
 	struct command *cmd;
-	unsigned char sha1[20];
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -718,9 +765,6 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 
 	check_aliased_updates(commands);
 
-	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
-
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -766,6 +810,8 @@ static struct command *read_head_info(void)
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
+			if (parse_feature_request(feature_list, "verify-refs"))
+				verify_refs = 1;
 		}
 		cmd = xcalloc(1, sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -905,7 +951,6 @@ static int delete_only(struct command *commands)
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
-	int stateless_rpc = 0;
 	int i;
 	char *dir = NULL;
 	struct command *commands;
@@ -962,11 +1007,15 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		return 0;
 
 	if ((commands = read_head_info()) != NULL) {
+		int commands_ok;
 		const char *unpack_status = NULL;
 
-		if (!delete_only(commands))
-			unpack_status = unpack();
-		execute_commands(commands, unpack_status);
+		commands_ok = verify_ref_commands(commands);
+		if (!verify_refs || commands_ok > 0) {
+			if (!delete_only(commands))
+				unpack_status = unpack();
+			execute_commands(commands, unpack_status);
+		}
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		if (report_status)
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 71f258e..7d514ca 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -265,6 +265,8 @@ int send_pack(struct send_pack_args *args,
 		use_sideband = 1;
 	if (!server_supports("quiet"))
 		args->quiet = 0;
+	if (server_supports("verify-refs"))
+		args->verify_refs = 1;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -303,12 +305,13 @@ int send_pack(struct send_pack_args *args,
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
-			if (!cmds_sent && (status_report || use_sideband || args->quiet)) {
-				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s",
+			if (!cmds_sent && (status_report || use_sideband || args->quiet || args->verify_refs)) {
+				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s%s",
 					old_hex, new_hex, ref->name, 0,
 					status_report ? " report-status" : "",
 					use_sideband ? " side-band-64k" : "",
-					args->quiet ? " quiet" : "");
+					args->quiet ? " quiet" : "",
+					args->verify_refs ? " verify-refs" : "");
 			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
@@ -341,17 +344,29 @@ int send_pack(struct send_pack_args *args,
 		in = demux.out;
 	}
 
-	if (new_refs && cmds_sent) {
-		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
-			for (ref = remote_refs; ref; ref = ref->next)
-				ref->status = REF_STATUS_NONE;
-			if (args->stateless_rpc)
-				close(out);
-			if (git_connection_is_socket(conn))
-				shutdown(fd[0], SHUT_WR);
-			if (use_sideband)
-				finish_async(&demux);
-			return -1;
+	if (cmds_sent) {
+		int verify_refs_status = 0;
+
+		if (args->verify_refs && !args->stateless_rpc) {
+			char line[1000];
+			int len = packet_read_line(in, line, sizeof(line));
+			if (len < 15 || memcmp(line, "verify-refs ", 12))
+				return error("did not receive remote status");
+			verify_refs_status = memcmp(line, "verify-refs ok\n", 15);
+		}
+
+		if (!verify_refs_status && new_refs) {
+			if (pack_objects(out, remote_refs, extra_have, args) < 0) {
+				for (ref = remote_refs; ref; ref = ref->next)
+					ref->status = REF_STATUS_NONE;
+				if (args->stateless_rpc)
+					close(out);
+				if (git_connection_is_socket(conn))
+					shutdown(fd[0], SHUT_WR);
+				if (use_sideband)
+					finish_async(&demux);
+				return -1;
+			}
 		}
 	}
 	if (args->stateless_rpc && cmds_sent)
diff --git a/send-pack.h b/send-pack.h
index 05d7ab1..87edaa5 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -11,7 +11,8 @@ struct send_pack_args {
 		use_thin_pack:1,
 		use_ofs_delta:1,
 		dry_run:1,
-		stateless_rpc:1;
+		stateless_rpc:1,
+		verify_refs:1;
 };
 
 int send_pack(struct send_pack_args *args,
-- 
1.7.9
