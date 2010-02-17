From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 2/6] fast-import: use sha1write() for pack data
Date: Wed, 17 Feb 2010 14:05:52 -0500
Message-ID: <1266433556-1987-3-git-send-email-nico@fluxnic.net>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:06:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpEQ-0005G9-W8
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0BQTGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:06:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0BQTGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:06:05 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000GRF2DZ9K50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 14:06:01 -0500 (EST)
X-Mailer: git-send-email 1.7.0.23.gf5ef4
In-reply-to: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140252>

This is in preparation for using write_idx_file().  Also, by using
sha1write() we get some buffering to reduces the number of write
syscalls, and the written data is SHA1 summed which allows for the extra
data integrity validation check performed in fixup_pack_header_footer()
(details on this in commit abeb40e5aa).

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 fast-import.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c29737e..7d737ba 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -312,6 +312,7 @@ static struct atom_str **atom_table;
 
 /* The .pack file being generated */
 static unsigned int pack_id;
+static struct sha1file *pack_file;
 static struct packed_git *pack_data;
 static struct packed_git **all_packs;
 static unsigned long pack_size;
@@ -838,11 +839,12 @@ static void start_packfile(void)
 	p = xcalloc(1, sizeof(*p) + strlen(tmpfile) + 2);
 	strcpy(p->pack_name, tmpfile);
 	p->pack_fd = pack_fd;
+	pack_file = sha1fd(pack_fd, p->pack_name);
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(2);
 	hdr.hdr_entries = 0;
-	write_or_die(p->pack_fd, &hdr, sizeof(hdr));
+	sha1write(pack_file, &hdr, sizeof(hdr));
 
 	pack_data = p;
 	pack_size = sizeof(hdr);
@@ -956,15 +958,17 @@ static void end_packfile(void)
 
 	clear_delta_base_cache();
 	if (object_count) {
+		unsigned char cur_pack_sha1[20];
 		char *idx_name;
 		int i;
 		struct branch *b;
 		struct tag *t;
 
 		close_pack_windows(pack_data);
+		sha1close(pack_file, cur_pack_sha1, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
 				    pack_data->pack_name, object_count,
-				    NULL, 0);
+				    cur_pack_sha1, pack_size);
 		close(pack_data->pack_fd);
 		idx_name = keep_pack(create_index());
 
@@ -1138,22 +1142,22 @@ static int store_object(
 		e->depth = last->depth + 1;
 
 		hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
-		write_or_die(pack_data->pack_fd, hdr, hdrlen);
+		sha1write(pack_file, hdr, hdrlen);
 		pack_size += hdrlen;
 
 		hdr[pos] = ofs & 127;
 		while (ofs >>= 7)
 			hdr[--pos] = 128 | (--ofs & 127);
-		write_or_die(pack_data->pack_fd, hdr + pos, sizeof(hdr) - pos);
+		sha1write(pack_file, hdr + pos, sizeof(hdr) - pos);
 		pack_size += sizeof(hdr) - pos;
 	} else {
 		e->depth = 0;
 		hdrlen = encode_header(type, dat->len, hdr);
-		write_or_die(pack_data->pack_fd, hdr, hdrlen);
+		sha1write(pack_file, hdr, hdrlen);
 		pack_size += hdrlen;
 	}
 
-	write_or_die(pack_data->pack_fd, out, s.total_out);
+	sha1write(pack_file, out, s.total_out);
 	pack_size += s.total_out;
 
 	free(out);
@@ -1170,12 +1174,17 @@ static int store_object(
 	return 0;
 }
 
-static void truncate_pack(off_t to)
+static void truncate_pack(off_t to, git_SHA_CTX *ctx)
 {
 	if (ftruncate(pack_data->pack_fd, to)
 	 || lseek(pack_data->pack_fd, to, SEEK_SET) != to)
 		die_errno("cannot truncate pack to skip duplicate");
 	pack_size = to;
+
+	/* yes this is a layering violation */
+	pack_file->total = to;
+	pack_file->offset = 0;
+	pack_file->ctx = *ctx;
 }
 
 static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
@@ -1188,6 +1197,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	unsigned long hdrlen;
 	off_t offset;
 	git_SHA_CTX c;
+	git_SHA_CTX pack_file_ctx;
 	z_stream s;
 	int status = Z_OK;
 
@@ -1198,6 +1208,10 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 
 	offset = pack_size;
 
+	/* preserve the pack_file SHA1 ctx in case we have to truncate later */
+	sha1flush(pack_file);
+	pack_file_ctx = pack_file->ctx;
+
 	hdrlen = snprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
 	if (out_sz <= hdrlen)
 		die("impossibly large object header");
@@ -1232,7 +1246,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t n = s.next_out - out_buf;
-			write_or_die(pack_data->pack_fd, out_buf, n);
+			sha1write(pack_file, out_buf, n);
 			pack_size += n;
 			s.next_out = out_buf;
 			s.avail_out = out_sz;
@@ -1260,14 +1274,14 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 
 	if (e->idx.offset) {
 		duplicate_count_by_type[OBJ_BLOB]++;
-		truncate_pack(offset);
+		truncate_pack(offset, &pack_file_ctx);
 
 	} else if (find_sha1_pack(sha1, packed_git)) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
 		duplicate_count_by_type[OBJ_BLOB]++;
-		truncate_pack(offset);
+		truncate_pack(offset, &pack_file_ctx);
 
 	} else {
 		e->depth = 0;
@@ -1316,6 +1330,7 @@ static void *gfi_unpack_entry(
 		 * the newly written data.
 		 */
 		close_pack_windows(p);
+		sha1flush(pack_file);
 
 		/* We have to offer 20 bytes additional on the end of
 		 * the packfile as the core unpacker code assumes the
-- 
1.7.0.23.gf5ef4
