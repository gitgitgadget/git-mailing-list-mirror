From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 4/6] receive-pack: Refactor how capabilities are shown to the client
Date: Fri,  5 Feb 2010 12:57:40 -0800
Message-ID: <1265403462-20572-5-git-send-email-spearce@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:04:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVLN-0007MN-Uo
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab0BEVDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:03:53 -0500
Received: from george.spearce.org ([209.20.77.23]:41731 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0BEVDv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:03:51 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2010 16:03:51 EST
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F40DA38200
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 20:57:44 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
In-Reply-To: <1265403462-20572-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139086>

Moving capability advertisement into the packet_write call itself
makes it easier to add additional capabilities to the list, be
it optional by configuration, or always present in the protocol.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-receive-pack.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 78c0e69..325ec6e 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -31,7 +31,7 @@ static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static const char *head_name;
-static char *capabilities_to_send;
+static int sent_capabilities;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -105,19 +105,21 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	if (!capabilities_to_send)
+	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
-		packet_write(1, "%s %s%c%s\n",
-			     sha1_to_hex(sha1), path, 0, capabilities_to_send);
-	capabilities_to_send = NULL;
+		packet_write(1, "%s %s%c%s%s\n",
+			     sha1_to_hex(sha1), path, 0,
+			     " report-status delete-refs",
+			     prefer_ofs_delta ? " ofs-delta" : "");
+	sent_capabilities = 1;
 	return 0;
 }
 
 static void write_head_info(void)
 {
 	for_each_ref(show_ref, NULL);
-	if (capabilities_to_send)
+	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1, 0, NULL);
 
 }
@@ -670,10 +672,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
-	capabilities_to_send = (prefer_ofs_delta) ?
-		" report-status delete-refs ofs-delta " :
-		" report-status delete-refs ";
-
 	if (advertise_refs || !stateless_rpc) {
 		add_alternate_refs();
 		write_head_info();
-- 
1.7.0.rc1.199.g9253ab
