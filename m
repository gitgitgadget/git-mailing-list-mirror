From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 8/8] git-fetch-pack: Support multi_ack extension
Date: Fri, 28 Oct 2005 04:50:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280449240.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:51:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKKA-0001Ea-Py
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVJ1Cu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVJ1Cu2
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:50:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51919 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965070AbVJ1Cu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:50:28 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E8A5C13F2ED; Fri, 28 Oct 2005 04:50:26 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C5EAAB4EDA; Fri, 28 Oct 2005 04:50:26 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A0FBFB0D34; Fri, 28 Oct 2005 04:50:26 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 94FE813F2ED; Fri, 28 Oct 2005 04:50:26 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10749>


The client side support for multi_ack.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	So yes, I forgot to rewrite the "Subject: [PATCH]" of the first 
	patch of this series. Please be gentle, I am going to bed now.

 connect.c    |    5 ++++-
 fetch-pack.c |   58 ++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 17 deletions(-)

applies-to: e91233a8f0446016384e8f2c8faafc9c129b95d3
b851d9a0cad95cedc6082e6de00c25d9588519e7
diff --git a/connect.c b/connect.c
index 5cc49f9..b8aea35 100644
--- a/connect.c
+++ b/connect.c
@@ -73,8 +73,11 @@ int get_ack(int fd, unsigned char *resul
 	if (!strcmp(line, "NAK"))
 		return 0;
 	if (!strncmp(line, "ACK ", 3)) {
-		if (!get_sha1_hex(line+4, result_sha1))
+		if (!get_sha1_hex(line+4, result_sha1)) {
+			if (strstr(line+45, "continue"))
+				return 2;
 			return 1;
+		}
 	}
 	die("git-fetch_pack: expected ACK/NAK, got '%s'", line);
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index b584264..3df9911 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -19,7 +19,7 @@ static const char *exec = "git-upload-pa
 #define POPPED		(1U << 4)
 
 static struct commit_list *rev_list = NULL;
-static int non_common_revs = 0;
+static int non_common_revs = 0, multi_ack = 0;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -157,7 +157,8 @@ static int find_common(int fd[2], unsign
 			continue;
 		}
 
-		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+		packet_write(fd[1], "want %s%s\n", sha1_to_hex(remote),
+			multi_ack ? " multi_ack" : "");
 		fetching++;
 	}
 	packet_flush(fd[1]);
@@ -171,6 +172,8 @@ static int find_common(int fd[2], unsign
 		if (verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		if (!(31 & ++count)) {
+			int ack;
+
 			packet_flush(fd[1]);
 			flushes++;
 
@@ -180,29 +183,47 @@ static int find_common(int fd[2], unsign
 			 */
 			if (count == 32)
 				continue;
-			if (get_ack(fd[0], result_sha1)) {
-				flushes = 0;
-				retval = 0;
-				if (verbose)
-					fprintf(stderr, "got ack\n");
-				break;
-			}
+
+			do {
+				ack = get_ack(fd[0], result_sha1);
+				if (verbose && ack)
+					fprintf(stderr, "got ack %d %s\n", ack,
+							sha1_to_hex(result_sha1));
+				if (ack == 1) {
+					flushes = 0;
+					multi_ack = 0;
+					retval = 0;
+					goto done;
+				} else if (ack == 2) {
+					struct commit *commit =
+						lookup_commit(result_sha1);
+					mark_common(commit, 0, 1);
+					retval = 0;
+				}
+			} while (ack);
 			flushes--;
 		}
 	}
-
+done:
 	packet_write(fd[1], "done\n");
 	if (verbose)
 		fprintf(stderr, "done\n");
-	if (retval != 0)
+	if (retval != 0) {
+		multi_ack = 0;
 		flushes++;
-	while (flushes) {
-		flushes--;
-		if (get_ack(fd[0], result_sha1)) {
+	}
+	while (flushes || multi_ack) {
+		int ack = get_ack(fd[0], result_sha1);
+		if (ack) {
 			if (verbose)
-				fprintf(stderr, "got ack\n");
-			return 0;
+				fprintf(stderr, "got ack (%d) %s\n", ack,
+					sha1_to_hex(result_sha1));
+			if (ack == 1)
+				return 0;
+			multi_ack = 1;
+			continue;
 		}
+		flushes--;
 	}
 	return retval;
 }
@@ -344,6 +365,11 @@ static int fetch_pack(int fd[2], int nr_
 	pid_t pid;
 
 	get_remote_heads(fd[0], &ref, 0, NULL, 0);
+	if (server_supports("multi_ack")) {
+		if (verbose)
+			fprintf(stderr, "Server supports multi_ack\n");
+		multi_ack = 1;
+	}
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
---
0.99.8.GIT
