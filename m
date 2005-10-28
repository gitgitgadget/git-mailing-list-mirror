From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 7/8] git-upload-pack: Support the multi_ack protocol
Date: Fri, 28 Oct 2005 04:49:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280448560.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:49:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKIy-0000yz-Lq
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVJ1CtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVJ1CtS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:49:18 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47311 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965069AbVJ1CtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:49:17 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A38F713EFF3; Fri, 28 Oct 2005 04:49:16 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7E0759EFCF; Fri, 28 Oct 2005 04:49:16 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4CA1E9EFC3; Fri, 28 Oct 2005 04:49:16 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 441AE13EFF3; Fri, 28 Oct 2005 04:49:16 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10746>


This implements three things (trying very hard to be backwards
compatible):

It sends the "multi_ack" capability via the mechanism proposed by
Sergey Vlasov.

When the client sends "multi_ack" with at least one "want", multi_ack
is enabled.

When multi_ack is enabled, "continue" is appended to each "ACK" until
either the server can not store more refs, or "done" is received.

In contrast to the original protocol, as long as "continue" is sent,
flushes are answered by a "NAK" (not just until an "ACK" was sent),
and if "continue" was sent at least once, the last message is an
"ACK" without "continue".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 upload-pack.c |   47 ++++++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 23 deletions(-)

applies-to: 4a808fae0b12e633b13bc0e76ec31ee19eecb21b
42affc8d8fa1ed7e7d95fd7385d118cc57a0c420
diff --git a/upload-pack.c b/upload-pack.c
index 660d7c4..686445e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -12,7 +12,7 @@ static const char upload_pack_usage[] = 
 #define WANTED (1U << 2)
 #define MAX_HAS 256
 #define MAX_NEEDS 256
-static int nr_has = 0, nr_needs = 0, nr_our_refs = 0;
+static int nr_has = 0, nr_needs = 0, multi_ack = 0, nr_our_refs = 0;
 static unsigned char has_sha1[MAX_HAS][20];
 static unsigned char needs_sha1[MAX_NEEDS][20];
 static unsigned int timeout = 0;
@@ -119,7 +119,7 @@ static int got_sha1(char *hex, unsigned 
 static int get_common_commits(void)
 {
 	static char line[1000];
-	unsigned char sha1[20];
+	unsigned char sha1[20], last_sha1[20];
 	int len;
 
 	track_object_refs = 0;
@@ -130,39 +130,36 @@ static int get_common_commits(void)
 		reset_timeout();
 
 		if (!len) {
-			packet_write(1, "NAK\n");
+			if (nr_has == 0 || multi_ack)
+				packet_write(1, "NAK\n");
 			continue;
 		}
 		len = strip(line, len);
 		if (!strncmp(line, "have ", 5)) {
-			if (got_sha1(line+5, sha1)) {
-				packet_write(1, "ACK %s\n", sha1_to_hex(sha1));
-				break;
+			if (got_sha1(line+5, sha1) &&
+					(multi_ack || nr_has == 1)) {
+				if (nr_has >= MAX_HAS)
+					multi_ack = 0;
+				packet_write(1, "ACK %s%s\n",
+					sha1_to_hex(sha1),
+					multi_ack ?  " continue" : "");
+				if (multi_ack)
+					memcpy(last_sha1, sha1, 20);
 			}
 			continue;
 		}
 		if (!strcmp(line, "done")) {
+			if (nr_has > 0) {
+				if (multi_ack)
+					packet_write(1, "ACK %s\n",
+							sha1_to_hex(last_sha1));
+				return 0;
+			}
 			packet_write(1, "NAK\n");
 			return -1;
 		}
 		die("git-upload-pack: expected SHA1 list, got '%s'", line);
 	}
-
-	for (;;) {
-		len = packet_read_line(0, line, sizeof(line));
-		reset_timeout();
-		if (!len)
-			continue;
-		len = strip(line, len);
-		if (!strncmp(line, "have ", 5)) {
-			got_sha1(line+5, sha1);
-			continue;
-		}
-		if (!strcmp(line, "done"))
-			break;
-		die("git-upload-pack: expected SHA1 list, got '%s'", line);
-	}
-	return 0;
 }
 
 static int receive_needs(void)
@@ -192,6 +189,8 @@ static int receive_needs(void)
 		if (strncmp("want ", line, 5) || get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
+		if (strstr(line+45, "multi_ack"))
+			multi_ack = 1;
 
 		/* We have sent all our refs already, and the other end
 		 * should have chosen out of them; otherwise they are
@@ -213,9 +212,11 @@ static int receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
+	static char *capabilities = "\0multi_ack";
 	struct object *o = parse_object(sha1);
 
-	packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
+	packet_write(1, "%s %s%s\n", sha1_to_hex(sha1), refname, capabilities);
+	capabilities = "";
 	if (!(o->flags & OUR_REF)) {
 		o->flags |= OUR_REF;
 		nr_our_refs++;
---
0.99.8.GIT
