From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] git-tar-tree: Simplify write_trailer()
Date: Sun, 18 Jun 2006 12:57:56 +0200
Message-ID: <1150628276770-git-send-email-rene.scharfe@lsrfire.ath.cx>
Reply-To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 18 12:58:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fruz6-0007M4-Jt
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 12:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWFRK56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 06:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWFRK56
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 06:57:58 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:39598
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751133AbWFRK55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 06:57:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by neapel230.server4you.de (Postfix) with ESMTP id 058472701F;
	Sun, 18 Jun 2006 12:57:57 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22071>

We can write the trailer in one or at most two steps; it will always
fit within two blocks.  With the last caller of get_record() gone we
can get rid of it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-tar-tree.c |   40 +++++++++++++++-------------------------
 1 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f6310b9..f646c5b 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -47,31 +47,6 @@ static void write_if_needed(void)
 	}
 }
 
-/* acquire the next record from the buffer; user must call write_if_needed() */
-static char *get_record(void)
-{
-	char *p = block + offset;
-	memset(p, 0, RECORDSIZE);
-	offset += RECORDSIZE;
-	return p;
-}
-
-/*
- * The end of tar archives is marked by 1024 nul bytes and after that
- * follows the rest of the block (if any).
- */
-static void write_trailer(void)
-{
-	get_record();
-	write_if_needed();
-	get_record();
-	write_if_needed();
-	while (offset) {
-		get_record();
-		write_if_needed();
-	}
-}
-
 /*
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
@@ -107,6 +82,21 @@ static void write_blocked(void *buf, uns
 	write_if_needed();
 }
 
+/*
+ * The end of tar archives is marked by 2*512 nul bytes and after that
+ * follows the rest of the block (if any).
+ */
+static void write_trailer(void)
+{
+	int tail = BLOCKSIZE - offset;
+	memset(block + offset, 0, tail);
+	reliable_write(block, BLOCKSIZE);
+	if (tail < 2 * RECORDSIZE) {
+		memset(block, 0, offset);
+		reliable_write(block, BLOCKSIZE);
+	}
+}
+
 static void strbuf_append_string(struct strbuf *sb, const char *s)
 {
 	int slen = strlen(s);
-- 
1.4.0
