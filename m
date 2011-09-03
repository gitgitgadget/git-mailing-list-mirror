From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Sat,  3 Sep 2011 18:34:16 +0200
Message-ID: <1315067656-2846-4-git-send-email-drizzd@aon.at>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, tobiasu@tmux.org,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 18:37:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QztDo-0007Px-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 18:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab1ICQh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 12:37:27 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:55411 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753077Ab1ICQh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 12:37:26 -0400
Received: from localhost (p5B22F905.dip.t-dialin.net [91.34.249.5])
	by bsmtp.bon.at (Postfix) with ESMTP id 4AE10130049;
	Sat,  3 Sep 2011 18:37:18 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1315067656-2846-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180661>

Commit 90a6c7d4 (propagate --quiet to send-pack/receive-pack)
introduced the --quiet option to receive-pack and made send-pack
pass that option. Older versions of receive-pack do not recognize
the option, however, and terminate immediately.

This change restores backwards compatibility by adding a 'quiet'
capability to receive-pack.

Reported-by: Tobias Ulmer <tobiasu@tmux.org>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/receive-pack.c |   10 ++++++----
 builtin/send-pack.c    |   16 +++++++---------
 transport.c            |   10 +++-------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 60260d0..06c481a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -31,6 +31,7 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
+static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
@@ -114,7 +115,7 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	else
 		packet_write(1, "%s %s%c%s%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k",
+			     " report-status delete-refs side-band-64k quiet",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
 	return 0;
@@ -636,6 +637,8 @@ static struct command *read_head_info(void)
 				report_status = 1;
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
+			if (strstr(refname + reflen + 1, "quiet"))
+				quiet = 1;
 		}
 		cmd = xcalloc(1, sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -669,7 +672,7 @@ static const char *parse_pack_header(struct pack_header *hdr)
 
 static const char *pack_lockfile;
 
-static const char *unpack(int quiet)
+static const char *unpack()
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -788,7 +791,6 @@ static void add_alternate_refs(void)
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
-	int quiet = 0;
 	int advertise_refs = 0;
 	int stateless_rpc = 0;
 	int i;
@@ -855,7 +857,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 
 		if (!delete_only(commands))
-			unpack_status = unpack(quiet);
+			unpack_status = unpack();
 		execute_commands(commands, unpack_status);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 40a1675..a8d6b4c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -263,6 +263,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
+	if (!server_supports("quiet"))
+		args->quiet = 0;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -301,11 +303,12 @@ int send_pack(struct send_pack_args *args,
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
-			if (!cmds_sent && (status_report || use_sideband)) {
-				packet_buf_write(&req_buf, "%s %s %s%c%s%s",
+			if (!cmds_sent && (status_report || use_sideband || args->quiet)) {
+				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s",
 					old_hex, new_hex, ref->name, 0,
 					status_report ? " report-status" : "",
-					use_sideband ? " side-band-64k" : "");
+					use_sideband ? " side-band-64k" : "",
+					args->quiet ? " quiet" : "");
 			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
@@ -492,13 +495,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addstr(&sb, receivepack);
-		if (args.quiet)
-			strbuf_addstr(&sb, " --quiet");
-		conn = git_connect(fd, dest, sb.buf,
+		conn = git_connect(fd, dest, receivepack,
 			args.verbose ? CONNECT_VERBOSE : 0);
-		strbuf_release(&sb);
 	}
 
 	memset(&extra_have, 0, sizeof(extra_have));
diff --git a/transport.c b/transport.c
index 98c5778..c9c8056 100644
--- a/transport.c
+++ b/transport.c
@@ -482,18 +482,14 @@ static int set_git_option(struct git_transport_options *opts,
 static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
-	struct strbuf sb = STRBUF_INIT;
 
 	if (data->conn)
 		return 0;
 
-	strbuf_addstr(&sb, for_push ? data->options.receivepack :
-				 data->options.uploadpack);
-	if (for_push && transport->verbose < 0)
-		strbuf_addstr(&sb, " --quiet");
-	data->conn = git_connect(data->fd, transport->url, sb.buf,
+	data->conn = git_connect(data->fd, transport->url,
+				 for_push ? data->options.receivepack :
+				 data->options.uploadpack,
 				 verbose ? CONNECT_VERBOSE : 0);
-	strbuf_release(&sb);
 
 	return 0;
 }
-- 
1.7.6.1
