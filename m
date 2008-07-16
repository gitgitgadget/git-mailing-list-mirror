From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/5] sha1_file.c: learn about index version 2
Date: Wed, 16 Jul 2008 02:31:39 -0400
Message-ID: <1216189899-14279-6-git-send-email-nico@cam.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
 <1216189899-14279-2-git-send-email-nico@cam.org>
 <1216189899-14279-3-git-send-email-nico@cam.org>
 <1216189899-14279-4-git-send-email-nico@cam.org>
 <1216189899-14279-5-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ0ZY-0006cW-G8
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 08:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbYGPGbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 02:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYGPGbv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 02:31:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11931 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbYGPGbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 02:31:44 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K43006BG64RTN50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jul 2008 02:31:42 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.3.499.geae9
In-reply-to: <1216189899-14279-5-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88642>

This allows for pack index v2 to be used.  On 32-bit machines the
maximum pack size is 2GB.  To lift this limitation just use a newer
git version.

(based on commit 74e34e1fca2ed9998581cc94073bc2dd28bbb8f3)

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |  117 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 89 insertions(+), 28 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9c40e7e..927ac06 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -407,7 +407,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	void *idx_map;
 	struct pack_idx_header *hdr;
 	unsigned long idx_size;
-	unsigned int nr, i, *index;
+	unsigned int version, nr, i, *index;
 	int fd = open(path, O_RDONLY);
 	struct stat st;
 
@@ -423,21 +423,23 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	if (idx_map == MAP_FAILED)
 		return -1;
 
-	/* a future index format would start with this, as older git
-	 * binaries would fail the non-monotonic index check below.
-	 * give a nicer warning to the user if we can.
-	 */
 	hdr = idx_map;
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
-		munmap(idx_map, idx_size);
-		return error("index file %s is a newer version"
-			" and is not supported by this binary"
-			" (try upgrading GIT to a newer version)",
-			path);
-	}
+		version = ntohl(hdr->idx_version);
+		if (version < 2 || version > 2) {
+			munmap(idx_map, idx_size);
+			return error("index file %s is version %d"
+				     " and is not supported by this binary"
+				     " (try upgrading GIT to a newer version)",
+				     path, version);
+		}
+	} else
+		version = 1;
 
 	nr = 0;
 	index = idx_map;
+	if (version > 1)
+		index += 2;  /* skip index header */
 	for (i = 0; i < 256; i++) {
 		unsigned int n = ntohl(index[i]);
 		if (n < nr)
@@ -445,17 +447,47 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		nr = n;
 	}
 
-	/*
-	 * Total size:
-	 *  - 256 index entries 4 bytes each
-	 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
-	 *  - 20-byte SHA1 of the packfile
-	 *  - 20-byte SHA1 file checksum
-	 */
-	if (idx_size != 4*256 + nr * 24 + 20 + 20)
-		return error("wrong index file size");
+	if (version == 1) {
+		/*
+		 * Total size:
+		 *  - 256 index entries 4 bytes each
+		 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
+		 *  - 20-byte SHA1 of the packfile
+		 *  - 20-byte SHA1 file checksum
+		 */
+		if (idx_size != 4*256 + nr * 24 + 20 + 20) {
+			munmap(idx_map, idx_size);
+			return error("wrong index file size in %s", path);
+		}
+	} else if (version == 2) {
+		/*
+		 * Minimum size:
+		 *  - 8 bytes of header
+		 *  - 256 index entries 4 bytes each
+		 *  - 20-byte sha1 entry * nr
+		 *  - 4-byte crc entry * nr
+		 *  - 4-byte offset entry * nr
+		 *  - 20-byte SHA1 of the packfile
+		 *  - 20-byte SHA1 file checksum
+		 * And after the 4-byte offset table might be a
+		 * variable sized table containing 8-byte entries
+		 * for offsets larger than 2^31.
+		 */
+		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
+		if (idx_size < min_size || idx_size > min_size + (nr - 1)*8) {
+			munmap(idx_map, idx_size);
+			return error("wrong index file size in %s", path);
+		}
+		if (idx_size != min_size) {
+			/* make sure we can deal with large pack offsets */
+			if (sizeof(unsigned long) <= 4) {
+				munmap(idx_map, idx_size);
+				return error("pack %s too large -- please upgrade your git version", path);
+			}
+		}
+	}
 
-	p->index_version = 1;
+	p->index_version = version;
 	p->index_data = idx_map;
 	p->index_size = idx_size;
 	p->num_objects = nr;
@@ -1176,27 +1208,56 @@ const unsigned char *nth_packed_object_sha1(const struct packed_git *p,
 					    unsigned int n)
 {
 	const unsigned char *index = p->index_data;
-	index += 4 * 256;
 	if (n >= p->num_objects)
 		return NULL;
-	return index + 24 * n + 4;
+	index += 4 * 256;
+	if (p->index_version == 1) {
+		return index + 24 * n + 4;
+	} else {
+		index += 8;
+		return index + 20 * n;
+	}
+}
+
+static off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
+{
+	const unsigned char *index = p->index_data;
+	index += 4 * 256;
+	if (p->index_version == 1) {
+		return ntohl(*((uint32_t *)(index + 24 * n)));
+	} else {
+		uint32_t off;
+		index += 8 + p->num_objects * (20 + 4);
+		off = ntohl(*((uint32_t *)(index + 4 * n)));
+		if (!(off & 0x80000000))
+			return off;
+		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
+		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
+				   ntohl(*((uint32_t *)(index + 4)));
+	}
 }
 
 unsigned long find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
 	const unsigned int *level1_ofs = p->index_data;
-	int hi = ntohl(level1_ofs[*sha1]);
-	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
 	const unsigned char *index = p->index_data;
+	unsigned hi, lo;
 
+	if (p->index_version > 1) {
+		level1_ofs += 2;
+		index += 8;
+	}
 	index += 4 * 256;
+	hi = ntohl(level1_ofs[*sha1]);
+	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
 
 	do {
-		int mi = (lo + hi) / 2;
-		int cmp = hashcmp(index + 24 * mi + 4, sha1);
+		unsigned mi = (lo + hi) / 2;
+		unsigned x = (p->index_version > 1) ? (mi * 20) : (mi * 24 + 4);
+		int cmp = hashcmp(index + x, sha1);
 		if (!cmp)
-			return ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
+			return nth_packed_object_offset(p, mi);
 		if (cmp > 0)
 			hi = mi;
 		else
-- 
1.5.6.3.499.geae9
