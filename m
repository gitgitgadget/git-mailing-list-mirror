From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 08/10] sha1_file.c: learn about index version 2
Date: Mon, 09 Apr 2007 01:06:35 -0400
Message-ID: <11760952023952-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
 <11760951993409-git-send-email-nico@cam.org>
 <11760952002687-git-send-email-nico@cam.org>
 <11760952002410-git-send-email-nico@cam.org>
 <117609520190-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5x-00038I-UL
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbXDIFHB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXDIFHA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:07:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbXDIFGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:45 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:42 -0400 (EDT)
In-reply-to: <117609520190-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44030>

With this patch, packs larger than 4GB are usable, even on a 32-bit machine
(at least on Linux).  If off_t is not large enough to deal with a large
pack then die() is called instead of attempting to use the pack and
producing garbage.

This was tested with a 8GB pack specially created for the occasion on
a 32-bit machine.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |  118 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 89 insertions(+), 29 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ebdd497..5f3a15d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -437,7 +437,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	void *idx_map;
 	struct pack_idx_header *hdr;
 	size_t idx_size;
-	uint32_t nr, i, *index;
+	uint32_t version, nr, i, *index;
 	int fd = open(path, O_RDONLY);
 	struct stat st;
 
@@ -455,21 +455,23 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
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
 		uint32_t n = ntohl(index[i]);
 		if (n < nr) {
@@ -479,19 +481,48 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		nr = n;
 	}
 
-	/*
-	 * Total size:
-	 *  - 256 index entries 4 bytes each
-	 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
-	 *  - 20-byte SHA1 of the packfile
-	 *  - 20-byte SHA1 file checksum
-	 */
-	if (idx_size != 4*256 + nr * 24 + 20 + 20) {
-		munmap(idx_map, idx_size);
-		return error("wrong index file size in %s", path);
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
+			off_t x = 0x7fffffffUL, y = 0xffffffffUL;
+			if (x > (x + 1) || y > (y + 1)) {
+				munmap(idx_map, idx_size);
+				return error("pack too large for current definition of off_t in %s", path);
+			}
+		}
 	}
 
-	p->index_version = 1;
+	p->index_version = version;
 	p->index_data = idx_map;
 	p->index_size = idx_size;
 	p->num_objects = nr;
@@ -1531,27 +1562,56 @@ const unsigned char *nth_packed_object_sha1(const struct packed_git *p,
 					    uint32_t n)
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
 
 off_t find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
 	const uint32_t *level1_ofs = p->index_data;
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
-			return ntohl(*((uint32_t *)((char *)index + (24 * mi))));
+			return nth_packed_object_offset(p, mi);
 		if (cmp > 0)
 			hi = mi;
 		else
-- 
1.5.1.696.g6d352-dirty
