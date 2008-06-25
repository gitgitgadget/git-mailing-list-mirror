From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/4] verify-pack: check packed object CRC when using index
 version 2
Date: Tue, 24 Jun 2008 23:19:02 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806242318210.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:20:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLYC-00023A-VA
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYFYDTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbYFYDTF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:19:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20737 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbYFYDTD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:19:03 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3000HJT17QG5A0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 23:19:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86203>


To do so, check_pack_crc() moved from builtin-pack-objects.c to
pack-check.c where it is more logical to share.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   22 ----------------------
 pack-check.c           |   39 +++++++++++++++++++++++++++++++++++++--
 pack.h                 |    2 +-
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 827673c..28207d9 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -209,28 +209,6 @@ static int check_pack_inflate(struct packed_git *p,
 		stream.total_in == len) ? 0 : -1;
 }
 
-static int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
-			  off_t offset, off_t len, unsigned int nr)
-{
-	const uint32_t *index_crc;
-	uint32_t data_crc = crc32(0, Z_NULL, 0);
-
-	do {
-		unsigned int avail;
-		void *data = use_pack(p, w_curs, offset, &avail);
-		if (avail > len)
-			avail = len;
-		data_crc = crc32(data_crc, data, avail);
-		offset += avail;
-		len -= avail;
-	} while (len);
-
-	index_crc = p->index_data;
-	index_crc += 2 + 256 + p->num_objects * (20/4) + nr;
-
-	return data_crc != ntohl(*index_crc);
-}
-
 static void copy_pack_data(struct sha1file *f,
 		struct packed_git *p,
 		struct pack_window **w_curs,
diff --git a/pack-check.c b/pack-check.c
index 5f02a65..f596bf2 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -4,8 +4,9 @@
 
 struct idx_entry
 {
-	const unsigned char *sha1;
 	off_t                offset;
+	const unsigned char *sha1;
+	unsigned int nr;
 };
 
 static int compare_entries(const void *e1, const void *e2)
@@ -19,6 +20,28 @@ static int compare_entries(const void *e1, const void *e2)
 	return 0;
 }
 
+int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
+		   off_t offset, off_t len, unsigned int nr)
+{
+	const uint32_t *index_crc;
+	uint32_t data_crc = crc32(0, Z_NULL, 0);
+
+	do {
+		unsigned int avail;
+		void *data = use_pack(p, w_curs, offset, &avail);
+		if (avail > len)
+			avail = len;
+		data_crc = crc32(data_crc, data, avail);
+		offset += avail;
+		len -= avail;
+	} while (len);
+
+	index_crc = p->index_data;
+	index_crc += 2 + 256 + p->num_objects * (20/4) + nr;
+
+	return data_crc != ntohl(*index_crc);
+}
+
 static int verify_packfile(struct packed_git *p,
 		struct pack_window **w_curs)
 {
@@ -61,13 +84,15 @@ static int verify_packfile(struct packed_git *p,
 	 * we do not do scan-streaming check on the pack file.
 	 */
 	nr_objects = p->num_objects;
-	entries = xmalloc(nr_objects * sizeof(*entries));
+	entries = xmalloc((nr_objects + 1) * sizeof(*entries));
+	entries[nr_objects].offset = pack_sig_ofs;
 	/* first sort entries by pack offset, since unpacking them is more efficient that way */
 	for (i = 0; i < nr_objects; i++) {
 		entries[i].sha1 = nth_packed_object_sha1(p, i);
 		if (!entries[i].sha1)
 			die("internal error pack-check nth-packed-object");
 		entries[i].offset = nth_packed_object_offset(p, i);
+		entries[i].nr = i;
 	}
 	qsort(entries, nr_objects, sizeof(*entries), compare_entries);
 
@@ -76,6 +101,16 @@ static int verify_packfile(struct packed_git *p,
 		enum object_type type;
 		unsigned long size;
 
+		if (p->index_version > 1) {
+			off_t offset = entries[i].offset;
+			off_t len = entries[i+1].offset - offset;
+			unsigned int nr = entries[i].nr;
+			if (check_pack_crc(p, w_curs, offset, len, nr))
+				err = error("index CRC mismatch for object %s "
+					    "from %s at offset %"PRIuMAX"",
+					    sha1_to_hex(entries[i].sha1),
+					    p->pack_name, (uintmax_t)offset);
+		}
 		data = unpack_entry(p, entries[i].offset, &type, &size);
 		if (!data) {
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
diff --git a/pack.h b/pack.h
index 465071c..76e6aa2 100644
--- a/pack.h
+++ b/pack.h
@@ -56,7 +56,7 @@ struct pack_idx_entry {
 };
 
 extern char *write_idx_file(char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
-
+extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack(struct packed_git *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t);
 extern char *index_pack_lockfile(int fd);
-- 
1.5.6.56.g29b0d
