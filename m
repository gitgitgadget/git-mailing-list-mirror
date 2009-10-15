From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v3 12/17] Add stateless RPC options to upload-pack, receive-pack
Date: Wed, 14 Oct 2009 20:36:49 -0700
Message-ID: <1255577814-14745-13-git-send-email-spearce@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:43:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHFP-0007IV-A1
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762451AbZJODiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762448AbZJODiR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:38:17 -0400
Received: from george.spearce.org ([209.20.77.23]:33056 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762442AbZJODiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:38:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0D33738262; Thu, 15 Oct 2009 03:37:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5D61B38200
	for <git@vger.kernel.org>; Thu, 15 Oct 2009 03:36:58 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130364>

When --stateless-rpc is passed as a command line parameter to
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
index b771fe9..70ff8c5 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -615,6 +615,8 @@ static void add_alternate_refs(void)
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
+	int advertise_refs = 0;
+	int stateless_rpc = 0;
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
+			if (!strcmp(arg, "--stateless-rpc")) {
+				stateless_rpc = 1;
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
+	if (advertise_refs || !stateless_rpc) {
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
index f1dc3a3..70badcf 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -39,6 +39,8 @@ static unsigned int timeout;
  */
 static int use_sideband;
 static int debug_fd;
+static int advertise_refs;
+static int stateless_rpc;
 
 static void reset_timeout(void)
 {
@@ -509,6 +511,8 @@ static int get_common_commits(void)
 		if (!len) {
 			if (have_obj.nr == 0 || multi_ack)
 				packet_write(1, "NAK\n");
+			if (stateless_rpc)
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
+	if (advertise_refs || !stateless_rpc) {
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
+		if (!strcmp(arg, "--stateless-rpc")) {
+			stateless_rpc = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--strict")) {
 			strict = 1;
 			continue;
-- 
1.6.5.52.g0ff2e
