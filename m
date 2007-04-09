From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 06/10] pack-objects: learn about pack index version 2
Date: Mon, 09 Apr 2007 01:06:33 -0400
Message-ID: <11760952002410-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
 <11760951993409-git-send-email-nico@cam.org>
 <11760952002687-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5w-00038I-Rd
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbXDIFG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXDIFG6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbXDIFGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:43 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:41 -0400 (EDT)
In-reply-to: <11760952002687-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44032>

Pack index version 2 goes as follows:

 - 8 bytes of header with signature and version.

 - 256 entries of 4-byte first-level fan-out table.

 - Table of sorted 20-byte SHA1 records for each object in pack.

 - Table of 4-byte CRC32 entries for raw pack object data.

 - Table of 4-byte offset entries for objects in the pack if offset is
   representable with 31 bits or less, otherwise it is an index in the next
   table with top bit set.

 - Table of 8-byte offset entries indexed from previous table for offsets
   which are 32 bits or more (optional).

 - 20-byte SHA1 checksum of sorted object names.

 - 20-byte SHA1 checksum of the above.

The object SHA1 table is all contiguous so future pack format that would
contain this table directly won't require big changes to the code. It is
also tighter for slightly better cache locality when looking up entries.

Support for large packs exceeding 31 bits in size won't impose an index
size bloat for packs within that range that don't need a 64-bit offset.
And because newer objects which are likely to be the most frequently used
are located at the beginning of the pack, they won't pay the 64-bit offset
lookup at run time either even if the pack is large.

Right now an index version 2 is created only when the biggest offset in a
pack reaches 31 bits.  It might be a good idea to always use index version
2 eventually to benefit from the CRC32 it contains when reusing pack data
while repacking.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   85 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 03e36f0..c7e0a42 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -169,13 +169,33 @@ static void prepare_pack_revindex(struct pack_revindex *rix)
 	int i;
 	const char *index = p->index_data;
 
-	index += 4 * 256;
 	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
-	for (i = 0; i < num_ent; i++) {
-		uint32_t hl = *((uint32_t *)(index + 24 * i));
-		rix->revindex[i].offset = ntohl(hl);
-		rix->revindex[i].nr = i;
+	index += 4 * 256;
+
+	if (p->index_version > 1) {
+		const uint32_t *off_32 =
+			(uint32_t *)(index + 8 + p->num_objects * (20 + 4));
+		const uint32_t *off_64 = off_32 + p->num_objects;
+		for (i = 0; i < num_ent; i++) {
+			uint32_t off = ntohl(*off_32++);
+			if (!(off & 0x80000000)) {
+				rix->revindex[i].offset = off;
+			} else {
+				rix->revindex[i].offset =
+					((uint64_t)ntohl(*off_64++)) << 32;
+				rix->revindex[i].offset |=
+					ntohl(*off_64++);
+			}
+			rix->revindex[i].nr = i;
+		}
+	} else {
+		for (i = 0; i < num_ent; i++) {
+			uint32_t hl = *((uint32_t *)(index + 24 * i));
+			rix->revindex[i].offset = ntohl(hl);
+			rix->revindex[i].nr = i;
+		}
 	}
+
 	/* This knows the pack format -- the 20-byte trailer
 	 * follows immediately after the last object data.
 	 */
@@ -582,6 +602,18 @@ static void write_index_file(void)
 	struct object_entry **list = sorted_by_sha;
 	struct object_entry **last = list + nr_result;
 	uint32_t array[256];
+	uint32_t index_version;
+
+	/* if last object's offset is >= 2^31 we should use index V2 */
+	index_version = (objects[nr_result-1].offset >> 31) ? 2 : 1;
+
+	/* index versions 2 and above need a header */
+	if (index_version >= 2) {
+		struct pack_idx_header hdr;
+		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
+		hdr.idx_version = htonl(index_version);
+		sha1write(f, &hdr, sizeof(hdr));
+	}
 
 	/*
 	 * Write the first-level table (the list is sorted,
@@ -607,10 +639,49 @@ static void write_index_file(void)
 	list = sorted_by_sha;
 	for (i = 0; i < nr_result; i++) {
 		struct object_entry *entry = *list++;
-		uint32_t offset = htonl(entry->offset);
-		sha1write(f, &offset, 4);
+		if (index_version < 2) {
+			uint32_t offset = htonl(entry->offset);
+			sha1write(f, &offset, 4);
+		}
 		sha1write(f, entry->sha1, 20);
 	}
+
+	if (index_version >= 2) {
+		unsigned int nr_large_offset = 0;
+
+		/* write the crc32 table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct object_entry *entry = *list++;
+			uint32_t crc32_val = htonl(entry->crc32);
+			sha1write(f, &crc32_val, 4);
+		}
+
+		/* write the 32-bit offset table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct object_entry *entry = *list++;
+			uint32_t offset = (entry->offset <= 0x7fffffff) ?
+				entry->offset : (0x80000000 | nr_large_offset++);
+			offset = htonl(offset);
+			sha1write(f, &offset, 4);
+		}
+
+		/* write the large offset table */
+		list = sorted_by_sha;
+		while (nr_large_offset) {
+			struct object_entry *entry = *list++;
+			uint64_t offset = entry->offset;
+			if (offset > 0x7fffffff) {
+				uint32_t split[2];
+				split[0]        = htonl(offset >> 32);
+				split[1] = htonl(offset & 0xffffffff);
+				sha1write(f, split, 8);
+				nr_large_offset--;
+			}
+		}
+	}
+
 	sha1write(f, pack_file_sha1, 20);
 	sha1close(f, NULL, 1);
 }
-- 
1.5.1.696.g6d352-dirty
