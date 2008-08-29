From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/5] index-pack: use fixup_pack_header_footer()'s validation
 mode
Date: Fri, 29 Aug 2008 16:08:01 -0400
Message-ID: <1220040482-10108-5-git-send-email-nico@cam.org>
References: <20080829143023.GA7403@spearce.org>
 <1220040482-10108-1-git-send-email-nico@cam.org>
 <1220040482-10108-2-git-send-email-nico@cam.org>
 <1220040482-10108-3-git-send-email-nico@cam.org>
 <1220040482-10108-4-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZAHy-0006Wv-HA
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 22:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbYH2UIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYH2UIb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 16:08:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15047 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbYH2UI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 16:08:29 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D007OOP8J18A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 16:07:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.212.g35f9f
In-reply-to: <1220040482-10108-4-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94325>

When completing a thin pack, a new header has to be written to
the pack and a new SHA1 computed.  Make sure that the SHA1 of what
is being read back matches the SHA1 of what was written for both:
the original pack and the appended objects.

To do so, a couple write_or_die() calls were converted to sha1write()
which has the advantage of doing some buffering as well as handling
SHA1 and CRC32 checksum already.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |   43 +++++++++++++++++++++++++------------------
 1 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 411b80d..a6e91fe 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -654,7 +654,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	}
 }
 
-static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_crc)
+static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 {
 	z_stream stream;
 	unsigned long maxsize;
@@ -674,13 +674,12 @@ static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_c
 	deflateEnd(&stream);
 
 	size = stream.total_out;
-	write_or_die(fd, out, size);
-	*obj_crc = crc32(*obj_crc, out, size);
+	sha1write(f, out, size);
 	free(out);
 	return size;
 }
 
-static struct object_entry *append_obj_to_pack(
+static struct object_entry *append_obj_to_pack(struct sha1file *f,
 			       const unsigned char *sha1, void *buf,
 			       unsigned long size, enum object_type type)
 {
@@ -696,15 +695,15 @@ static struct object_entry *append_obj_to_pack(
 		s >>= 7;
 	}
 	header[n++] = c;
-	write_or_die(output_fd, header, n);
-	obj[0].idx.crc32 = crc32(0, Z_NULL, 0);
-	obj[0].idx.crc32 = crc32(obj[0].idx.crc32, header, n);
+	crc32_begin(f);
+	sha1write(f, header, n);
 	obj[0].size = size;
 	obj[0].hdr_size = n;
 	obj[0].type = type;
 	obj[0].real_type = type;
 	obj[1].idx.offset = obj[0].idx.offset + n;
-	obj[1].idx.offset += write_compressed(output_fd, buf, size, &obj[0].idx.crc32);
+	obj[1].idx.offset += write_compressed(f, buf, size);
+	obj[0].idx.crc32 = crc32_end(f);
 	hashcpy(obj->idx.sha1, sha1);
 	return obj;
 }
@@ -716,7 +715,7 @@ static int delta_pos_compare(const void *_a, const void *_b)
 	return a->obj_no - b->obj_no;
 }
 
-static void fix_unresolved_deltas(int nr_unresolved)
+static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolved)
 {
 	struct delta_entry **sorted_by_pos;
 	int i, n = 0;
@@ -754,8 +753,8 @@ static void fix_unresolved_deltas(int nr_unresolved)
 		if (check_sha1_signature(d->base.sha1, base_obj.data,
 				base_obj.size, typename(type)))
 			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
-		base_obj.obj = append_obj_to_pack(d->base.sha1, base_obj.data,
-			base_obj.size, type);
+		base_obj.obj = append_obj_to_pack(f, d->base.sha1,
+					base_obj.data, base_obj.size, type);
 		link_base_data(NULL, &base_obj);
 
 		find_delta_children(&d->base, &first, &last);
@@ -875,7 +874,7 @@ int main(int argc, char **argv)
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
 	struct pack_idx_entry **idx_objects;
-	unsigned char sha1[20];
+	unsigned char pack_sha1[20];
 	int nongit = 0;
 
 	setup_git_directory_gently(&nongit);
@@ -962,13 +961,15 @@ int main(int argc, char **argv)
 	parse_pack_header();
 	objects = xmalloc((nr_objects + 1) * sizeof(struct object_entry));
 	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
-	parse_pack_objects(sha1);
+	parse_pack_objects(pack_sha1);
 	if (nr_deltas == nr_resolved_deltas) {
 		stop_progress(&progress);
 		/* Flush remaining pack final 20-byte SHA1. */
 		flush();
 	} else {
 		if (fix_thin_pack) {
+			struct sha1file *f;
+			unsigned char read_sha1[20], tail_sha1[20];
 			char msg[48];
 			int nr_unresolved = nr_deltas - nr_resolved_deltas;
 			int nr_objects_initial = nr_objects;
@@ -977,13 +978,19 @@ int main(int argc, char **argv)
 			objects = xrealloc(objects,
 					   (nr_objects + nr_unresolved + 1)
 					   * sizeof(*objects));
-			fix_unresolved_deltas(nr_unresolved);
+			f = sha1fd(output_fd, curr_pack);
+			fix_unresolved_deltas(f, nr_unresolved);
 			sprintf(msg, "completed with %d local objects",
 				nr_objects - nr_objects_initial);
 			stop_progress_msg(&progress, msg);
-			fixup_pack_header_footer(output_fd, sha1,
+			sha1close(f, tail_sha1, 0);
+			hashcpy(read_sha1, pack_sha1);
+			fixup_pack_header_footer(output_fd, pack_sha1,
 						 curr_pack, nr_objects,
-						 NULL, 0);
+						 read_sha1, consumed_bytes-20);
+			if (hashcmp(read_sha1, tail_sha1) != 0)
+				die("Unexpected tail checksum for %s "
+				    "(disk corruption?)", curr_pack);
 		}
 		if (nr_deltas != nr_resolved_deltas)
 			die("pack has %d unresolved deltas",
@@ -996,13 +1003,13 @@ int main(int argc, char **argv)
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(index_name, idx_objects, nr_objects, sha1);
+	curr_index = write_idx_file(index_name, idx_objects, nr_objects, pack_sha1);
 	free(idx_objects);
 
 	final(pack_name, curr_pack,
 		index_name, curr_index,
 		keep_name, keep_msg,
-		sha1);
+		pack_sha1);
 	free(objects);
 	free(index_name_buf);
 	free(keep_name_buf);
-- 
1.6.0.1.212.g35f9f
