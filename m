From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fetch/upload: Fix corner case with few revs
Date: Tue, 25 Oct 2005 17:34:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510251730200.12176@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1912382974-1130254447=:12176"
X-From: git-owner@vger.kernel.org Tue Oct 25 17:37:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUQoc-0001oH-N7
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 17:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVJYPeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 11:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJYPeK
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 11:34:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38582 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932185AbVJYPeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 11:34:09 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 15B5313F1A0; Tue, 25 Oct 2005 17:34:08 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E2127B0D42; Tue, 25 Oct 2005 17:34:07 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C317BB0CBF; Tue, 25 Oct 2005 17:34:07 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 980E213F1A0; Tue, 25 Oct 2005 17:34:07 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10592>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1912382974-1130254447=:12176
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

When git-fetch-pack did not have enough revs to send, it did not realize=20
that the server actually speaks multi_ack. The server would now continue=20
sending ack=B4s, but the client would try to unpack objects. Oops.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I have a sizable collection of brown paper bags by now.

 fetch-pack.c  |   13 +++++++++----
 upload-pack.c |   15 +++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

applies-to: f4786932e8753bdd07e44829a97a47749b329ee8
9a0ea94256236f1d038b16eb834fdfa5987f308c
diff --git a/fetch-pack.c b/fetch-pack.c
index 7015dc5..b02a24a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -224,12 +224,17 @@ done:
 	if (retval !=3D 0)
 		flushes++;
 	while (flushes) {
-		if (get_ack(fd[0], result_sha1)) {
+		int ack =3D get_ack(fd[0], result_sha1);
+		if (ack) {
 			if (verbose)
-				fprintf(stderr, "got ack %s\n",
+				fprintf(stderr, "got ack (%d) %s\n", ack,
 					sha1_to_hex(result_sha1));
-			if (!multi_ack)
-				return 0;
+			if (!multi_ack) {
+				if (ack =3D=3D 2)
+					multi_ack =3D 1;
+				else
+					return 0;
+			}
 			retval =3D 0;
 			continue;
 		}
diff --git a/upload-pack.c b/upload-pack.c
index 25a343e..1dbde5f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -116,7 +116,7 @@ static int get_common_commits(void)
 {
 	static char line[1000];
 	unsigned char sha1[20];
-	int len;
+	int len, last_sent_was_nak =3D 0;
=20
 	track_object_refs =3D 0;
 	save_commit_buffer =3D 0;
@@ -126,23 +126,30 @@ static int get_common_commits(void)
 		reset_timeout();
=20
 		if (!len) {
-			if (multi_ack || nr_has =3D=3D 0)
+			if (multi_ack || nr_has =3D=3D 0) {
 				packet_write(1, "NAK\n");
+				last_sent_was_nak =3D 1;
+			}
 			continue;
 		}
 		len =3D strip(line, len);
 		if (!strncmp(line, "have ", 5)) {
 			if (got_sha1(line+5, sha1) &&
-					(multi_ack || nr_has =3D=3D 1))
+					(multi_ack || nr_has =3D=3D 1)) {
 				packet_write(1, "ACK %s%s\n",
 					sha1_to_hex(sha1),
 					multi_ack && nr_has < MAX_HAS ?
 					" continue" : "");
+				last_sent_was_nak =3D 0;
+			}
 			continue;
 		}
 		if (!strcmp(line, "done")) {
-			if (nr_has > 0)
+			if (nr_has > 0) {
+				if (multi_ack && !last_sent_was_nak)
+					packet_write(1, "NAK\n");
 				return 0;
+			}
 			packet_write(1, "NAK\n");
 			return -1;
 		}
---
0.99.8.GIT
---1148973799-1912382974-1130254447=:12176--
