From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 3/6] send-pack: demultiplex a sideband stream with status data
Date: Fri,  5 Feb 2010 12:57:39 -0800
Message-ID: <1265403462-20572-4-git-send-email-spearce@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:08:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVQA-0002it-QY
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933842Ab0BEVIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:08:53 -0500
Received: from george.spearce.org ([209.20.77.23]:35087 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521Ab0BEVIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:08:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B276A381FF
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 20:57:44 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
In-Reply-To: <1265403462-20572-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139092>

If the server advertises side-band-64k capability, we request
it and pull the status report data out of side band #1, and let
side band #2 go to our stderr.  The latter channel be used by the
remote side to send our user messages.  This basically mirrors the
side-band-64k capability in upload-pack.

Servers may choose to use side band #2 to send error messages from
hook scripts that are meant for the push end user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-send-pack.c |   66 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8fffdbf..2478e18 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -372,6 +372,14 @@ static void print_helper_status(struct ref *ref)
 	strbuf_release(&buf);
 }
 
+static int sideband_demux(int in, int out, void *data)
+{
+	int *fd = data;
+	int ret = recv_sideband("send-pack", fd[0], out);
+	close(out);
+	return ret;
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -382,18 +390,22 @@ int send_pack(struct send_pack_args *args,
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
+	struct async demux;
 
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
@@ -456,28 +468,30 @@ int send_pack(struct send_pack_args *args,
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
@@ -487,23 +501,43 @@ int send_pack(struct send_pack_args *args,
 	}
 	strbuf_release(&req_buf);
 
-	if (new_refs && !args->dry_run) {
+	if (use_sideband && cmds_sent) {
+		memset(&demux, 0, sizeof(demux));
+		demux.proc = sideband_demux;
+		demux.data = fd;
+		demux.out = -1;
+		if (start_async(&demux))
+			die("receive-pack: unable to fork off sideband demultiplexer");
+		in = demux.out;
+	}
+
+	if (new_refs && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
 				ref->status = REF_STATUS_NONE;
+			if (use_sideband)
+				finish_async(&demux);
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
+		if (finish_async(&demux)) {
+			error("error in sideband demultiplexer");
+			ret = -1;
+		}
+		close(demux.out);
+	}
+
 	if (ret < 0)
 		return ret;
 	for (ref = remote_refs; ref; ref = ref->next) {
-- 
1.7.0.rc1.199.g9253ab
