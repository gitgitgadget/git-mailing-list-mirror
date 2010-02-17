From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 3/6] fast-import: use write_idx_file() instead of custom code
Date: Wed, 17 Feb 2010 14:05:53 -0500
Message-ID: <1266433556-1987-4-git-send-email-nico@fluxnic.net>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpEO-0005G9-RP
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0BQTGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:06:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab0BQTGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:06:06 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000GRF2DZ9K50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 14:06:02 -0500 (EST)
X-Mailer: git-send-email 1.7.0.23.gf5ef4
In-reply-to: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140248>

This allows for the creation of pack index version 2 with its object
CRC and the possibility for a pack to be larger than 4 GB.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 fast-import.c |   63 +++++++++++++++-----------------------------------------
 1 files changed, 17 insertions(+), 46 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7d737ba..9d7ab09 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -854,67 +854,30 @@ static void start_packfile(void)
 	all_packs[pack_id] = p;
 }
 
-static int oecmp (const void *a_, const void *b_)
+static const char *create_index(void)
 {
-	struct object_entry *a = *((struct object_entry**)a_);
-	struct object_entry *b = *((struct object_entry**)b_);
-	return hashcmp(a->idx.sha1, b->idx.sha1);
-}
-
-static char *create_index(void)
-{
-	static char tmpfile[PATH_MAX];
-	git_SHA_CTX ctx;
-	struct sha1file *f;
-	struct object_entry **idx, **c, **last, *e;
+	const char *tmpfile;
+	struct pack_idx_entry **idx, **c, **last;
+	struct object_entry *e;
 	struct object_entry_pool *o;
-	uint32_t array[256];
-	int i, idx_fd;
 
-	/* Build the sorted table of object IDs. */
-	idx = xmalloc(object_count * sizeof(struct object_entry*));
+	/* Build the table of object IDs. */
+	idx = xmalloc(object_count * sizeof(*idx));
 	c = idx;
 	for (o = blocks; o; o = o->next_pool)
 		for (e = o->next_free; e-- != o->entries;)
 			if (pack_id == e->pack_id)
-				*c++ = e;
+				*c++ = &e->idx;
 	last = idx + object_count;
 	if (c != last)
 		die("internal consistency error creating the index");
-	qsort(idx, object_count, sizeof(struct object_entry*), oecmp);
 
-	/* Generate the fan-out array. */
-	c = idx;
-	for (i = 0; i < 256; i++) {
-		struct object_entry **next = c;
-		while (next < last) {
-			if ((*next)->idx.sha1[0] != i)
-				break;
-			next++;
-		}
-		array[i] = htonl(next - idx);
-		c = next;
-	}
-
-	idx_fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
-			     "pack/tmp_idx_XXXXXX");
-	f = sha1fd(idx_fd, tmpfile);
-	sha1write(f, array, 256 * sizeof(int));
-	git_SHA1_Init(&ctx);
-	for (c = idx; c != last; c++) {
-		uint32_t offset = htonl((*c)->idx.offset);
-		sha1write(f, &offset, 4);
-		sha1write(f, (*c)->idx.sha1, sizeof((*c)->idx.sha1));
-		git_SHA1_Update(&ctx, (*c)->idx.sha1, 20);
-	}
-	sha1write(f, pack_data->sha1, sizeof(pack_data->sha1));
-	sha1close(f, NULL, CSUM_FSYNC);
+	tmpfile = write_idx_file(NULL, idx, object_count, pack_data->sha1);
 	free(idx);
-	git_SHA1_Final(pack_data->sha1, &ctx);
 	return tmpfile;
 }
 
-static char *keep_pack(char *curr_index_name)
+static char *keep_pack(const char *curr_index_name)
 {
 	static char name[PATH_MAX];
 	static const char *keep_msg = "fast-import";
@@ -936,6 +899,7 @@ static char *keep_pack(char *curr_index_name)
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
 	if (move_temp_to_file(curr_index_name, name))
 		die("cannot store index file");
+	free((void *)curr_index_name);
 	return name;
 }
 
@@ -1134,6 +1098,8 @@ static int store_object(
 	object_count++;
 	object_count_by_type[type]++;
 
+	crc32_begin(pack_file);
+
 	if (delta) {
 		unsigned long ofs = e->idx.offset - last->offset;
 		unsigned pos = sizeof(hdr) - 1;
@@ -1160,6 +1126,8 @@ static int store_object(
 	sha1write(pack_file, out, s.total_out);
 	pack_size += s.total_out;
 
+	e->idx.crc32 = crc32_end(pack_file);
+
 	free(out);
 	free(delta);
 	if (last) {
@@ -1219,6 +1187,8 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, out_buf, hdrlen);
 
+	crc32_begin(pack_file);
+
 	memset(&s, 0, sizeof(s));
 	deflateInit(&s, pack_compression_level);
 
@@ -1288,6 +1258,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		e->type = OBJ_BLOB;
 		e->pack_id = pack_id;
 		e->idx.offset = offset;
+		e->idx.crc32 = crc32_end(pack_file);
 		object_count++;
 		object_count_by_type[OBJ_BLOB]++;
 	}
-- 
1.7.0.23.gf5ef4
