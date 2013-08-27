From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 23/23] initial pack index v3 support on the read side
Date: Tue, 27 Aug 2013 00:26:07 -0400
Message-ID: <1377577567-27655-24-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArq-0007MP-17
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab3H0E0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3H0E0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:35 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600F6D9O5GV90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 537172DA056B	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:30 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233055>

A bit crud but good enough for now.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 cache.h     |  1 +
 sha1_file.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index b6634c4..63066a1 100644
--- a/cache.h
+++ b/cache.h
@@ -1018,6 +1018,7 @@ extern struct packed_git {
 	off_t pack_size;
 	const void *index_data;
 	size_t index_size;
+	const unsigned char *sha1_table;
 	uint32_t num_objects;
 	uint32_t num_bad_objects;
 	unsigned char *bad_object_sha1;
diff --git a/sha1_file.c b/sha1_file.c
index c2020d0..e9c54f4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -504,7 +504,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	hdr = idx_map;
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2) {
+		if (version < 2 || version > 3) {
 			munmap(idx_map, idx_size);
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
@@ -539,12 +539,13 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 			munmap(idx_map, idx_size);
 			return error("wrong index v1 file size in %s", path);
 		}
-	} else if (version == 2) {
+	} else if (version == 2 || version == 3) {
+		unsigned long min_size, max_size;
 		/*
 		 * Minimum size:
 		 *  - 8 bytes of header
 		 *  - 256 index entries 4 bytes each
-		 *  - 20-byte sha1 entry * nr
+		 *  - 20-byte sha1 entry * nr (version 2 only)
 		 *  - 4-byte crc entry * nr
 		 *  - 4-byte offset entry * nr
 		 *  - 20-byte SHA1 of the packfile
@@ -553,8 +554,10 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
-		unsigned long max_size = min_size;
+		min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
+		if (version != 2)
+			min_size -= nr*20;
+		max_size = min_size;
 		if (nr)
 			max_size += (nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size) {
@@ -573,6 +576,36 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		}
 	}
 
+	if (version >= 3) {
+		/* the SHA1 table is located in the main pack file */
+		void *pack_map;
+		struct pack_header *pack_hdr;
+
+		fd = git_open_noatime(p->pack_name);
+		if (fd < 0) {
+			munmap(idx_map, idx_size);
+			return error("unable to open %s", p->pack_name);
+		}
+		if (fstat(fd, &st) != 0 || xsize_t(st.st_size) < 12 + nr*20) {
+			close(fd);
+			munmap(idx_map, idx_size);
+			return error("size of %s is wrong", p->pack_name);
+		}
+		pack_map = xmmap(NULL, 12 + nr*20, PROT_READ, MAP_PRIVATE, fd, 0);
+		close(fd);
+		pack_hdr = pack_map;
+		if (pack_hdr->hdr_signature != htonl(PACK_SIGNATURE) ||
+		    pack_hdr->hdr_version != htonl(4) ||
+		    pack_hdr->hdr_entries != htonl(nr)) {
+			munmap(idx_map, idx_size);
+			munmap(pack_map, 12 + nr*20);
+			return error("packfile for %s doesn't match expectations", path);
+		}
+		p->sha1_table = pack_map;
+		p->sha1_table += 12;
+	} else
+		p->sha1_table = NULL;
+
 	p->index_version = version;
 	p->index_data = idx_map;
 	p->index_size = idx_size;
@@ -697,6 +730,10 @@ void close_pack_index(struct packed_git *p)
 		munmap((void *)p->index_data, p->index_size);
 		p->index_data = NULL;
 	}
+	if (p->sha1_table) {
+		munmap((void *)(p->sha1_table - 12), 12 + p->num_objects * 20);
+		p->sha1_table = NULL;
+	}
 }
 
 /*
@@ -808,7 +845,7 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("file %s is far too short to be a packfile", p->pack_name);
 	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
 		return error("file %s is not a GIT packfile", p->pack_name);
-	if (!pack_version_ok(hdr.hdr_version))
+	if (!pack_version_ok(hdr.hdr_version) && hdr.hdr_version != htonl(4))
 		return error("packfile %s is version %"PRIu32" and not"
 			" supported (try upgrading GIT to a newer version)",
 			p->pack_name, ntohl(hdr.hdr_version));
@@ -2226,9 +2263,12 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		return index + 24 * n + 4;
-	} else {
+	} else if (p->index_version == 2) {
 		index += 8;
 		return index + 20 * n;
+	} else {
+		index = p->sha1_table;
+		return index + 20 * n;
 	}
 }
 
@@ -2241,6 +2281,8 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	} else {
 		uint32_t off;
 		index += 8 + p->num_objects * (20 + 4);
+		if (p->index_version != 2)
+			index -= p->num_objects * 20;
 		off = ntohl(*((uint32_t *)(index + 4 * n)));
 		if (!(off & 0x80000000))
 			return off;
@@ -2281,6 +2323,8 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		stride = 24;
 		index += 4;
 	}
+	if (p->index_version > 2)
+		index = p->sha1_table;
 
 	if (debug_lookup)
 		printf("%02x%02x%02x... lo %u hi %u nr %"PRIu32"\n",
-- 
1.8.4.22.g54757b7
