From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Sun, 20 May 2007 23:11:04 +0200
Message-ID: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 23:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsgK-0003Qu-FA
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbXETVLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756621AbXETVLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:11:09 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:48753 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbXETVLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:11:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id E48E17AF1C94;
	Sun, 20 May 2007 23:11:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWDe0DLS5s20; Sun, 20 May 2007 23:11:04 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 3ADD97AF1C88; Sun, 20 May 2007 23:11:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47920>

Creating deltas between big blobs is a CPU and memory intensive task.
In the writing phase, all (not reused) deltas are redone.

This patch adds support for caching deltas from the deltifing phase, so
that that the writing phase is faster.

The caching is limited to small deltas to avoid increasing memory usage very much.
The implemented limit is (memory needed to create the delta)/1024.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-pack-objects.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d165f10..13429d0 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -35,6 +35,7 @@ struct object_entry {
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
 					     */
+	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
@@ -380,17 +381,24 @@ static unsigned long write_object(struct sha1file *f,
 				 */
 
 	if (!to_reuse) {
-		buf = read_sha1_file(entry->sha1, &type, &size);
-		if (!buf)
-			die("unable to read %s", sha1_to_hex(entry->sha1));
-		if (size != entry->size)
-			die("object %s size inconsistency (%lu vs %lu)",
-			    sha1_to_hex(entry->sha1), size, entry->size);
-		if (entry->delta) {
-			buf = delta_against(buf, size, entry);
+		if (entry->delta_data) {
+			buf = entry->delta_data;
 			size = entry->delta_size;
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
-				OBJ_OFS_DELTA : OBJ_REF_DELTA;
+					OBJ_OFS_DELTA : OBJ_REF_DELTA;
+		} else {
+			buf = read_sha1_file(entry->sha1, &type, &size);
+			if (!buf)
+				die("unable to read %s", sha1_to_hex(entry->sha1));
+			if (size != entry->size)
+				die("object %s size inconsistency (%lu vs %lu)",
+				    sha1_to_hex(entry->sha1), size, entry->size);
+			if (entry->delta) {
+				buf = delta_against(buf, size, entry);
+				size = entry->delta_size;
+				obj_type = (allow_ofs_delta && entry->delta->offset) ?
+					OBJ_OFS_DELTA : OBJ_REF_DELTA;
+			}
 		}
 		/*
 		 * The object header is a byte of 'type' followed by zero or
@@ -1294,10 +1302,17 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (!delta_buf)
 		return 0;
 
+	if (trg_entry->delta_data)
+		free (trg_entry->delta_data);
+	trg_entry->delta_data = 0;
 	trg_entry->delta = src_entry;
 	trg_entry->delta_size = delta_size;
 	trg_entry->depth = src_entry->depth + 1;
-	free(delta_buf);
+	/* cache delta, if objects are large enough compared to delta size */
+	if ((src_size >> 20) + (trg_size >> 21) > (delta_size >> 10))
+		trg_entry->delta_data = delta_buf;
+	else
+		free(delta_buf);
 	return 1;
 }
 
-- 
1.5.2.rc3.802.g4b4b7
