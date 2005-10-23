From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] git-upload-pack: Support sending multiple ACK messages
Date: Sun, 23 Oct 2005 03:37:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510230336300.21239@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Oct 23 03:38:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETUo2-0007Xm-84
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 03:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVJWBhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 21:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVJWBhr
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 21:37:47 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1171 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751345AbVJWBhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 21:37:46 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7F16513F0B6; Sun, 23 Oct 2005 03:37:45 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6505B9EF7D; Sun, 23 Oct 2005 03:37:45 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 13E6C90236; Sun, 23 Oct 2005 03:37:45 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 00BA713F0B6; Sun, 23 Oct 2005 03:37:45 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10483>

The current fetch/upload protocol works like this:

- client sends revs it wants to have via "want" messages
- client sends a flush message (message with len 0)
- client sends revs it has via "have" messages
- after one window (32 revs), a flush is sent
- after each subsequent window, a flush is sent, and an ACK/NAK is received.
        (NAK means that server does not have any of the transmitted revs;
         ACK sends also the sha1 of the rev server has)
 - when the first ACK is received, client sends "done", and does not expect
        any further messages

One special case, though:

- if no ACK is received (only NAK's), and client runs out of revs to send,
        "done" is sent, and server sends just one more "NAK"

A smarter scheme, which actually has a chance to detect more than one 
common rev, would be to send more than just one ACK. This patch implements 
the server side of the following extension to the protocol:

- client sends at least one "want" message with "multi_ack" appended, like

        "want 1234567890123456789012345678901234567890 multi_ack"

- if the server understands that extension, it will send ACK messages for all
        revs it has, not just the first one

- server appends "continue" to the ACK messages like

        "ACK 1234567890123456789012345678901234567890 continue"

        until it has MAX_HAS-1 revs. In this manner, client knows when to
        stop sending revs by checking for the substring "continue" (and
        further knows that server understands multi_ack)

In this manner, the protocol stays backwards compatible, since both client 
must send "want ... multi_ack" and server must answer with "ACK ... 
continue" to enable the extension.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 upload-pack.c |   37 +++++++++++++++----------------------
 1 files changed, 15 insertions(+), 22 deletions(-)

applies-to: 95634a3973bbc1eb8cc626fd6fd67bb773caf7ab
89df3fb3bb65e37c33b478b66c76adc46cf22cd7
diff --git a/upload-pack.c b/upload-pack.c
index ab1981c..c3abf7b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,7 +10,7 @@ static const char upload_pack_usage[] = 
 #define THEY_HAVE (1U << 0)
 #define MAX_HAS 256
 #define MAX_NEEDS 256
-static int nr_has = 0, nr_needs = 0;
+static int nr_has = 0, nr_needs = 0, multi_ack = 0;
 static unsigned char has_sha1[MAX_HAS][20];
 static unsigned char needs_sha1[MAX_NEEDS][20];
 static unsigned int timeout = 0;
@@ -124,39 +124,28 @@ static int get_common_commits(void)
 		reset_timeout();
 
 		if (!len) {
-			packet_write(1, "NAK\n");
+			if (multi_ack || nr_has == 0)
+				packet_write(1, "NAK\n");
 			continue;
 		}
 		len = strip(line, len);
 		if (!strncmp(line, "have ", 5)) {
-			if (got_sha1(line+5, sha1)) {
-				packet_write(1, "ACK %s\n", sha1_to_hex(sha1));
-				break;
-			}
+			if (got_sha1(line+5, sha1) &&
+					(multi_ack || nr_has == 1))
+				packet_write(1, "ACK %s%s\n",
+					sha1_to_hex(sha1),
+					multi_ack && nr_has < MAX_HAS ?
+					" continue" : "");
 			continue;
 		}
 		if (!strcmp(line, "done")) {
+			if (nr_has > 0)
+				return 0;
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
@@ -185,6 +174,10 @@ static int receive_needs(void)
 		if (strncmp("want ", line, 5) || get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
+
+		if (strstr(line+45, "multi_ack"))
+			multi_ack = 1;
+
 		needs++;
 	}
 }
---
0.99.8.GIT
