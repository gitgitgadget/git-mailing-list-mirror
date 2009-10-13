From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 11/16] Add one shot RPC options to upload-pack, receive-pack
Date: Mon, 12 Oct 2009 19:25:10 -0700
Message-ID: <1255400715-10508-12-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDC-0004cs-R9
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758855AbZJMC0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbZJMC0m
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:42 -0400
Received: from george.spearce.org ([209.20.77.23]:56215 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758832AbZJMC0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:36 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 141EA38239; Tue, 13 Oct 2009 02:25:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C05D238265
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 02:25:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130114>

When --one-shot-rpc is passed as a command line parameter to
upload-pack or receive-pack the programs now assume they may
perform only a single read-write cycle with stdin and stdout.
This fits with the HTTP POST request processing model where a
program may read the request, write a response, and must exit.

When --advertise-refs is passed as a command line parameter only
the initial ref advertisement is output, and the program exits
immediately.  This fits with the HTTP GET request model, where
no request content is received but a response must be produced.

HTTP headers and/or environment are not processed here, but
instead are assumed to be handled by the program invoking
either service backend.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-receive-pack.c |   26 ++++++++++++++++++++------
 upload-pack.c          |   40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b771fe9..9e8f36f 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -615,6 +615,8 @@ static void add_alternate_refs(void)
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
+	int advertise_refs = 0;
+	int one_shot_rpc = 0;
 	int i;
 	char *dir = NULL;
 
@@ -623,7 +625,15 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *arg = *argv++;
 
 		if (*arg == '-') {
-			/* Do flag handling here */
+			if (!strcmp(arg, "--advertise-refs")) {
+				advertise_refs = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--one-shot-rpc")) {
+				one_shot_rpc = 1;
+				continue;
+			}
+
 			usage(receive_pack_usage);
 		}
 		if (dir)
@@ -652,12 +662,16 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		" report-status delete-refs ofs-delta " :
 		" report-status delete-refs ";
 
-	add_alternate_refs();
-	write_head_info();
-	clear_extra_refs();
+	if (advertise_refs || !one_shot_rpc) {
+		add_alternate_refs();
+		write_head_info();
+		clear_extra_refs();
 
-	/* EOF */
-	packet_flush(1);
+		/* EOF */
+		packet_flush(1);
+	}
+	if (advertise_refs)
+		return 0;
 
 	read_head_info();
 	if (commands) {
diff --git a/upload-pack.c b/upload-pack.c
index 5024b59..71318d7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -39,6 +39,8 @@ static unsigned int timeout;
  */
 static int use_sideband;
 static int debug_fd;
+static int advertise_refs;
+static int one_shot_rpc;
 
 static void reset_timeout(void)
 {
@@ -509,6 +511,8 @@ static int get_common_commits(void)
 		if (!len) {
 			if (have_obj.nr == 0 || multi_ack)
 				packet_write(1, "NAK\n");
+			if (one_shot_rpc)
+				exit(0);
 			continue;
 		}
 		strip(line, len);
@@ -710,12 +714,32 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
+static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct object *o = parse_object(sha1);
+	if (!o)
+		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
+	if (!(o->flags & OUR_REF)) {
+		o->flags |= OUR_REF;
+		nr_our_refs++;
+	}
+	return 0;
+}
+
 static void upload_pack(void)
 {
-	reset_timeout();
-	head_ref(send_ref, NULL);
-	for_each_ref(send_ref, NULL);
-	packet_flush(1);
+	if (advertise_refs || !one_shot_rpc) {
+		reset_timeout();
+		head_ref(send_ref, NULL);
+		for_each_ref(send_ref, NULL);
+		packet_flush(1);
+	} else {
+		head_ref(mark_our_ref, NULL);
+		for_each_ref(mark_our_ref, NULL);
+	}
+	if (advertise_refs)
+		return;
+
 	receive_needs();
 	if (want_obj.nr) {
 		get_common_commits();
@@ -737,6 +761,14 @@ int main(int argc, char **argv)
 
 		if (arg[0] != '-')
 			break;
+		if (!strcmp(arg, "--advertise-refs")) {
+			advertise_refs = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--one-shot-rpc")) {
+			one_shot_rpc = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--strict")) {
 			strict = 1;
 			continue;
-- 
1.6.5.52.g0ff2e
