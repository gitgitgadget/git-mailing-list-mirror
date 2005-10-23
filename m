From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack
 extension
Date: Sun, 23 Oct 2005 03:40:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Oct 23 03:40:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETUqR-00081f-R3
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 03:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVJWBkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 21:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVJWBkQ
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 21:40:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5011 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751378AbVJWBkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 21:40:15 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D259B13F0B6; Sun, 23 Oct 2005 03:40:13 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B98B99EF7D; Sun, 23 Oct 2005 03:40:13 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9D2FC90236; Sun, 23 Oct 2005 03:40:13 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8988213F0B6; Sun, 23 Oct 2005 03:40:13 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10485>

This patch concludes the series, which makes 
git-fetch-pack/git-upload-pack negotiate a potentially better set of 
common revs. It should make a difference when fetching from a repository 
with a few branches.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 connect.c    |    5 ++++-
 fetch-pack.c |   50 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 14 deletions(-)

applies-to: 6b4b7d9acf60aa99d961b599f37d0c824be79e27
9adb6b3971e7daa79221d7dbe05b66327b266b86
diff --git a/connect.c b/connect.c
index b171c5d..57e25a3 100644
--- a/connect.c
+++ b/connect.c
@@ -59,8 +59,11 @@ int get_ack(int fd, unsigned char *resul
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
index 3a903c4..57602b9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -125,7 +125,7 @@ static int find_common(int fd[2], unsign
 		       struct ref *refs)
 {
 	int fetching;
-	int count = 0, flushes = 0, retval;
+	int count = 0, flushes = 0, multi_ack = 0, retval;
 	const unsigned char *sha1;
 
 	for_each_ref(rev_list_append_sha1);
@@ -156,20 +156,22 @@ static int find_common(int fd[2], unsign
 			continue;
 		}
 
-		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+		packet_write(fd[1], "want %s multi_ack\n", sha1_to_hex(remote));
 		fetching++;
 	}
 	packet_flush(fd[1]);
 	if (!fetching)
 		return 1;
 
-	flushes = 1;
+	flushes = 0;
 	retval = -1;
 	while ((sha1 = get_rev())) {
 		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
 		if (verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		if (!(31 & ++count)) {
+			int ack;
+
 			packet_flush(fd[1]);
 			flushes++;
 
@@ -179,26 +181,48 @@ static int find_common(int fd[2], unsign
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
+					if (!multi_ack)
+						flushes = 0;
+					retval = 0;
+					goto done;
+				} else if (ack == 2) {
+					multi_ack = 1;
+					mark_common((struct commit *)
+							lookup_object(result_sha1));
+					retval = 0;
+				}
+			} while(ack);
 			flushes--;
 		}
 	}
+done:
+	if (multi_ack) {
+		packet_flush(fd[1]);
+		flushes++;
+	}
 	packet_write(fd[1], "done\n");
 	if (verbose)
 		fprintf(stderr, "done\n");
+	if (retval != 0)
+		flushes++;
 	while (flushes) {
-		flushes--;
 		if (get_ack(fd[0], result_sha1)) {
 			if (verbose)
-				fprintf(stderr, "got ack\n");
-			return 0;
+				fprintf(stderr, "got ack %s\n",
+					sha1_to_hex(result_sha1));
+			if (!multi_ack)
+				return 0;
+			retval = 0;
+			continue;
 		}
+		flushes--;
 	}
 	return retval;
 }
---
0.99.8.GIT
