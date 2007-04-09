From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 09/10] show-index.c: learn about index v2
Date: Mon, 09 Apr 2007 01:06:36 -0400
Message-ID: <11760952021074-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
 <11760951993409-git-send-email-nico@cam.org>
 <11760952002687-git-send-email-nico@cam.org>
 <11760952002410-git-send-email-nico@cam.org>
 <117609520190-git-send-email-nico@cam.org>
 <11760952023952-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5x-00038I-DW
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbXDIFHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXDIFG7
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbXDIFGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:45 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:43 -0400 (EDT)
In-reply-to: <11760952023952-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44031>

When index v2 is encountered, the CRC32 of each object is also displayed
in parenthesis at the end of the line.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 show-index.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/show-index.c b/show-index.c
index a30a2de..cae1f7d 100644
--- a/show-index.c
+++ b/show-index.c
@@ -1,14 +1,26 @@
 #include "cache.h"
+#include "pack.h"
 
 int main(int argc, char **argv)
 {
 	int i;
 	unsigned nr;
-	unsigned int entry[6];
+	unsigned int version;
 	static unsigned int top_index[256];
 
-	if (fread(top_index, sizeof(top_index), 1, stdin) != 1)
-		die("unable to read index");
+	if (fread(top_index, 2 * 4, 1, stdin) != 1)
+		die("unable to read header");
+	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
+		version = ntohl(top_index[1]);
+		if (version < 2 || version > 2)
+			die("unknown index version");
+		if (fread(top_index, 256 * 4, 1, stdin) != 1)
+			die("unable to read index");
+	} else {
+		version = 1;
+		if (fread(&top_index[2], 254 * 4, 1, stdin) != 1)
+			die("unable to read index");
+	}
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned n = ntohl(top_index[i]);
@@ -16,13 +28,50 @@ int main(int argc, char **argv)
 			die("corrupt index file");
 		nr = n;
 	}
-	for (i = 0; i < nr; i++) {
-		unsigned offset;
+	if (version == 1) {
+		for (i = 0; i < nr; i++) {
+			unsigned int offset, entry[6];
 
-		if (fread(entry, 24, 1, stdin) != 1)
-			die("unable to read entry %u/%u", i, nr);
-		offset = ntohl(entry[0]);
-		printf("%u %s\n", offset, sha1_to_hex((void *)(entry+1)));
+			if (fread(entry, 4 + 20, 1, stdin) != 1)
+				die("unable to read entry %u/%u", i, nr);
+			offset = ntohl(entry[0]);
+			printf("%u %s\n", offset, sha1_to_hex((void *)(entry+1)));
+		}
+	} else {
+		unsigned off64_nr = 0;
+		struct {
+			unsigned char sha1[20];
+			uint32_t crc;
+			uint32_t off;
+		} *entries = xmalloc(nr * sizeof(entries[0]));
+		for (i = 0; i < nr; i++)
+			if (fread(entries[i].sha1, 20, 1, stdin) != 1)
+				die("unable to read sha1 %u/%u", i, nr);
+		for (i = 0; i < nr; i++)
+			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
+				die("unable to read crc %u/%u", i, nr);
+		for (i = 0; i < nr; i++)
+			if (fread(&entries[i].off, 4, 1, stdin) != 1)
+				die("unable to read 32b offset %u/%u", i, nr);
+		for (i = 0; i < nr; i++) {
+			uint64_t offset;
+			uint32_t off = ntohl(entries[i].off);
+			if (!(off & 0x80000000)) {
+				offset = off;
+			} else {
+				uint32_t off64[2];
+				if ((off & 0x7fffffff) != off64_nr)
+					die("inconsistent 64b offset index");
+				if (fread(off64, 8, 1, stdin) != 1)
+					die("unable to read 64b offset %u", off64_nr);
+				offset = (((uint64_t)ntohl(off64[0])) << 32) |
+						     ntohl(off64[1]);
+				off64_nr++;
+			}
+			printf("%llu %s (%08x)\n", offset,
+			       sha1_to_hex(entries[i].sha1), ntohl(entries[i].crc));
+		}
+		free(entries);
 	}
 	return 0;
 }
-- 
1.5.1.696.g6d352-dirty
