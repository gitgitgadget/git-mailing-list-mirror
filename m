From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 5/6] receive-pack: Wrap status reports inside side-band-64k
Date: Fri,  5 Feb 2010 12:57:41 -0800
Message-ID: <1265403462-20572-6-git-send-email-spearce@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:09:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVQQ-0002t7-6d
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933801Ab0BEVIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:08:52 -0500
Received: from george.spearce.org ([209.20.77.23]:35086 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511Ab0BEVIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:08:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 42A613821F
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 20:57:45 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
In-Reply-To: <1265403462-20572-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139094>

If the client requests the side-band-64k protocol capability we
now wrap the status report data inside of packets sent to band #1.
This permits us to later send additional progress or informational
messages down band #2.

If side-band-64k was enabled, we always send a final flush packet
to let the client know we are done transmitting.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-receive-pack.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 325ec6e..ff3f117 100644
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
@@ -27,6 +28,7 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
+static int use_sideband;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
@@ -110,7 +112,7 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	else
 		packet_write(1, "%s %s%c%s%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs",
+			     " report-status delete-refs side-band-64k",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
 	return 0;
@@ -466,6 +468,8 @@ static void read_head_info(void)
 		if (reflen + 82 < len) {
 			if (strstr(refname + reflen + 1, "report-status"))
 				report_status = 1;
+			if (strstr(refname + reflen + 1, "side-band-64k"))
+				use_sideband = LARGE_PACKET_MAX;
 		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -565,17 +569,25 @@ static const char *unpack(void)
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
@@ -705,5 +717,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		if (auto_update_server_info)
 			update_server_info(0);
 	}
+	if (use_sideband)
+		packet_flush(1);
 	return 0;
 }
-- 
1.7.0.rc1.199.g9253ab
