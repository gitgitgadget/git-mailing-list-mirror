From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 07/10] index-pack: learn about pack index version 2
Date: Mon, 09 Apr 2007 01:06:34 -0400
Message-ID: <117609520190-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
 <11760951993409-git-send-email-nico@cam.org>
 <11760952002687-git-send-email-nico@cam.org>
 <11760952002410-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5w-00038I-Ao
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbXDIFG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXDIFG4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbXDIFGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:44 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:42 -0400 (EDT)
In-reply-to: <11760952002410-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44035>

Like previous patch but for index-pack.

[ There is quite some code duplication between pack-objects and index-pack
  for generating a pack index (and fast-import as well I suppose).  This
  should be reworked into a common function eventually. But not now. ]

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index d33f723..a833f64 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -686,9 +686,10 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct object_entry **sorted_by_sha, **list, **last;
-	unsigned int array[256];
+	uint32_t array[256];
 	int i, fd;
 	SHA_CTX ctx;
+	uint32_t index_version;
 
 	if (nr_objects) {
 		sorted_by_sha =
@@ -699,7 +700,6 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 			sorted_by_sha[i] = &objects[i];
 		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
 		      sha1_compare);
-
 	}
 	else
 		sorted_by_sha = list = last = NULL;
@@ -718,6 +718,17 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		die("unable to create %s: %s", index_name, strerror(errno));
 	f = sha1fd(fd, index_name);
 
+	/* if last object's offset is >= 2^31 we should use index V2 */
+	index_version = (objects[nr_objects-1].offset >> 31) ? 2 : 1;
+
+	/* index versions 2 and above need a header */
+	if (index_version >= 2) {
+		struct pack_idx_header hdr;
+		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
+		hdr.idx_version = htonl(index_version);
+		sha1write(f, &hdr, sizeof(hdr));
+	}
+
 	/*
 	 * Write the first-level table (the list is sorted,
 	 * but we use a 256-entry lookup to be able to avoid
@@ -734,24 +745,61 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		array[i] = htonl(next - sorted_by_sha);
 		list = next;
 	}
-	sha1write(f, array, 256 * sizeof(int));
+	sha1write(f, array, 256 * 4);
 
-	/* recompute the SHA1 hash of sorted object names.
-	 * currently pack-objects does not do this, but that
-	 * can be fixed.
-	 */
+	/* compute the SHA1 hash of sorted object names. */
 	SHA1_Init(&ctx);
+
 	/*
 	 * Write the actual SHA1 entries..
 	 */
 	list = sorted_by_sha;
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = *list++;
-		unsigned int offset = htonl(obj->offset);
-		sha1write(f, &offset, 4);
+		if (index_version < 2) {
+			uint32_t offset = htonl(obj->offset);
+			sha1write(f, &offset, 4);
+		}
 		sha1write(f, obj->sha1, 20);
 		SHA1_Update(&ctx, obj->sha1, 20);
 	}
+
+	if (index_version >= 2) {
+		unsigned int nr_large_offset = 0;
+
+		/* write the crc32 table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct object_entry *obj = *list++;
+			uint32_t crc32_val = htonl(obj->crc32);
+			sha1write(f, &crc32_val, 4);
+		}
+
+		/* write the 32-bit offset table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct object_entry *obj = *list++;
+			uint32_t offset = (obj->offset <= 0x7fffffff) ?
+				obj->offset : (0x80000000 | nr_large_offset++);
+			offset = htonl(offset);
+			sha1write(f, &offset, 4);
+		}
+
+		/* write the large offset table */
+		list = sorted_by_sha;
+		while (nr_large_offset) {
+			struct object_entry *obj = *list++;
+			uint64_t offset = obj->offset;
+			if (offset > 0x7fffffff) {
+				uint32_t split[2];
+				split[0]	= htonl(offset >> 32);
+				split[1] = htonl(offset & 0xffffffff);
+				sha1write(f, split, 8);
+				nr_large_offset--;
+			}
+		}
+	}
+
 	sha1write(f, sha1, 20);
 	sha1close(f, NULL, 1);
 	free(sorted_by_sha);
-- 
1.5.1.696.g6d352-dirty
