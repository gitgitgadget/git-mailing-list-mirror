From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/3] improve reliability of fixup_pack_header_footer()
Date: Thu, 28 Aug 2008 22:07:02 -0400
Message-ID: <1219975624-7653-1-git-send-email-nico@cam.org>
References: <alpine.LFD.1.10.0808282142490.1624@xanadu.home>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 04:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYtPW-0004BH-7b
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 04:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbYH2CHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 22:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbYH2CHM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 22:07:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57167 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbYH2CHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 22:07:11 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6C005YHB6YVB40@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Aug 2008 22:06:35 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.174.g97d7e.dirty
In-reply-to: <alpine.LFD.1.10.0808282142490.1624@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94243>

Currently, this function has the potential to read corrupted pack data
from disk and give it a valid SHA1 checksum.  Let's add the ability to
validate SHA1 checksum of existing data along the way, including before
and after any arbitrary point in the pack.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    3 +-
 fast-import.c          |    3 +-
 index-pack.c           |    3 +-
 pack-write.c           |   78 ++++++++++++++++++++++++++++++++++++++++-------
 pack.h                 |    2 +-
 5 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ef3befe..ec80f14 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -498,7 +498,8 @@ static void write_pack_file(void)
 			sha1close(f, sha1, CSUM_FSYNC);
 		} else {
 			int fd = sha1close(f, NULL, 0);
-			fixup_pack_header_footer(fd, sha1, pack_tmp_name, nr_written);
+			fixup_pack_header_footer(fd, sha1, pack_tmp_name,
+						 nr_written, NULL, 0);
 			close(fd);
 		}
 
diff --git a/fast-import.c b/fast-import.c
index 7089e6f..d85b3a5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -951,7 +951,8 @@ static void end_packfile(void)
 
 		close_pack_windows(pack_data);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
-				    pack_data->pack_name, object_count);
+				    pack_data->pack_name, object_count,
+				    NULL, 0);
 		close(pack_data->pack_fd);
 		idx_name = keep_pack(create_index());
 
diff --git a/index-pack.c b/index-pack.c
index 728af7d..411b80d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -982,7 +982,8 @@ int main(int argc, char **argv)
 				nr_objects - nr_objects_initial);
 			stop_progress_msg(&progress, msg);
 			fixup_pack_header_footer(output_fd, sha1,
-						 curr_pack, nr_objects);
+						 curr_pack, nr_objects,
+						 NULL, 0);
 		}
 		if (nr_deltas != nr_resolved_deltas)
 			die("pack has %d unresolved deltas",
diff --git a/pack-write.c b/pack-write.c
index ddcfd37..0c0abce 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -144,41 +144,95 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 	return index_name;
 }
 
+/*
+ * Update pack header with object_count and compute new SHA1 for pack data
+ * associated to pack_fd, and write that SHA1 at the end.  That new SHA1
+ * is also returned in new_pack_sha1.
+ *
+ * If partial_pack_sha1 is non null, then the SHA1 of the existing pack
+ * (without the header update) is computed and validated against the one
+ * provided in partial_pack_sha1.  The validation is performed at
+ * partial_pack_offset bytes in the pack file, or at the end of the pack
+ * file if partial_pack_offset is zero.  Also, when partial_pack_offset is
+ * non zero, the SHA1 of the remaining data (i.e. from partial_pack_offset
+ * to the end) is returned in partial_pack_sha1.
+ *
+ * Note that new_pack_sha1 is updated last, so both new_pack_sha1 and
+ * partial_pack_sha1 can refer to the same buffer if the caller is not
+ * interested in the resulting SHA1 of pack data above partial_pack_offset.
+ */
 void fixup_pack_header_footer(int pack_fd,
-			 unsigned char *pack_file_sha1,
+			 unsigned char *new_pack_sha1,
 			 const char *pack_name,
-			 uint32_t object_count)
+			 uint32_t object_count,
+			 unsigned char *partial_pack_sha1,
+			 off_t partial_pack_offset)
 {
 	static const int buf_sz = 128 * 1024;
-	SHA_CTX c;
+	SHA_CTX old_sha1_ctx, new_sha1_ctx;
 	struct pack_header hdr;
 	char *buf;
 
+	SHA1_Init(&old_sha1_ctx);
+	SHA1_Init(&new_sha1_ctx);
+
+	if (partial_pack_sha1 && !partial_pack_offset) {
+		partial_pack_offset = lseek(pack_fd, 0, SEEK_CUR);
+		if (partial_pack_offset == (off_t)-1)
+			die("Can't get size of %s: %s", pack_name, strerror(errno));
+	}
+
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
-		die("Failed seeking to start: %s", strerror(errno));
+		die("Failed seeking to start of %s: %s", pack_name, strerror(errno));
 	if (read_in_full(pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
 		die("Unable to reread header of %s: %s", pack_name, strerror(errno));
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
-		die("Failed seeking to start: %s", strerror(errno));
+		die("Failed seeking to start of %s: %s", pack_name, strerror(errno));
+	SHA1_Update(&old_sha1_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
+	SHA1_Update(&new_sha1_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
-
-	SHA1_Init(&c);
-	SHA1_Update(&c, &hdr, sizeof(hdr));
+	partial_pack_offset -= sizeof(hdr);
 
 	buf = xmalloc(buf_sz);
 	for (;;) {
-		ssize_t n = xread(pack_fd, buf, buf_sz);
+		ssize_t m, n;
+		m = (partial_pack_sha1 && partial_pack_offset < buf_sz) ?
+			partial_pack_offset : buf_sz;
+		n = xread(pack_fd, buf, m);
 		if (!n)
 			break;
 		if (n < 0)
 			die("Failed to checksum %s: %s", pack_name, strerror(errno));
-		SHA1_Update(&c, buf, n);
+		SHA1_Update(&new_sha1_ctx, buf, n);
+
+		if (!partial_pack_sha1)
+			continue;
+
+		SHA1_Update(&old_sha1_ctx, buf, n);
+		partial_pack_offset -= n;
+		if (partial_pack_offset == 0) {
+			unsigned char sha1[20];
+			SHA1_Final(sha1, &old_sha1_ctx);
+			if (hashcmp(sha1, partial_pack_sha1) != 0)
+				die("Unexpected checksum for %s "
+				    "(disk corruption?)", pack_name);
+			/*
+			 * Now let's compute the SHA1 of the remainder of the
+			 * pack, which also means making partial_pack_offset
+			 * big enough not to matter anymore.
+			 */
+			SHA1_Init(&old_sha1_ctx);
+			partial_pack_offset = ~partial_pack_offset;
+			partial_pack_offset -= MSB(partial_pack_offset, 1);
+		}
 	}
 	free(buf);
 
-	SHA1_Final(pack_file_sha1, &c);
-	write_or_die(pack_fd, pack_file_sha1, 20);
+	if (partial_pack_sha1)
+		SHA1_Final(partial_pack_sha1, &old_sha1_ctx);
+	SHA1_Final(new_pack_sha1, &new_sha1_ctx);
+	write_or_die(pack_fd, new_pack_sha1, 20);
 	fsync_or_die(pack_fd, pack_name);
 }
 
diff --git a/pack.h b/pack.h
index 76e6aa2..a883334 100644
--- a/pack.h
+++ b/pack.h
@@ -58,7 +58,7 @@ struct pack_idx_entry {
 extern char *write_idx_file(char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack(struct packed_git *);
-extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t);
+extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 
 #define PH_ERROR_EOF		(-1)
-- 
1.6.0.1.174.g97d7e.dirty
