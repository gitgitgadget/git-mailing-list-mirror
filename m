From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/9] pack-objects: get rid of create_final_object_list()
Date: Mon, 16 Apr 2007 12:31:05 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704161230190.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdU6l-0000vZ-Kh
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030865AbXDPQbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030866AbXDPQbK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:31:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63164 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030865AbXDPQbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:31:09 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00MTTN7TRA90@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:31:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44671>

Because we don't have to know the SHA1 h(hence the name) of the pack
up front anymore, let's get rid of yet another global sorted object list
and sort them only in write_index_file(), then compute the object list
SHA1 on the fly.

This has the advantage of saving another chunk of memory, and the sorted
list SHA1 won't be computed needlessly on servers during a fetch.

Of course the cunning plan is also to make write_index_file() much like
the function with the same name in index-pack.c for an eventual easy
sharing.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |  127 +++++++++++++++++++++++++++---------------------
 1 files changed, 72 insertions(+), 55 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c2f7c30..7af1776 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -59,17 +59,16 @@ struct object_entry {
  * heuristics.
  */
 
-static unsigned char object_list_sha1[20];
 static int non_empty;
 static int no_reuse_delta;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
 
-static struct object_entry **sorted_by_sha;
 static struct object_entry *objects;
 static uint32_t nr_objects, nr_alloc, nr_result;
-static const char *base_name;
+static const char *pack_tmp_name, *idx_tmp_name;
+static char tmpname[PATH_MAX];
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static volatile sig_atomic_t progress_update;
@@ -578,13 +577,19 @@ static off_t write_pack_file(void)
 	unsigned last_percent = 999;
 	int do_progress = progress;
 
-	if (!base_name) {
+	if (pack_to_stdout) {
 		f = sha1fd(1, "<stdout>");
 		do_progress >>= 1;
+	} else {
+		int fd;
+		snprintf(tmpname, sizeof(tmpname), "tmp_pack_XXXXXX");
+		fd = mkstemp(tmpname);
+		if (fd < 0)
+			die("unable to create %s: %s\n", tmpname, strerror(errno));
+		pack_tmp_name = xstrdup(tmpname);
+		f = sha1fd(fd, pack_tmp_name);
 	}
-	else
-		f = sha1create("%s-%s.%s", base_name,
-			       sha1_to_hex(object_list_sha1), "pack");
+
 	if (do_progress)
 		fprintf(stderr, "Writing %u objects.\n", nr_result);
 
@@ -618,18 +623,46 @@ static off_t write_pack_file(void)
 	return last_obj_offset;
 }
 
+static int sha1_sort(const void *_a, const void *_b)
+{
+	const struct object_entry *a = *(struct object_entry **)_a;
+	const struct object_entry *b = *(struct object_entry **)_b;
+	return hashcmp(a->sha1, b->sha1);
+}
+
 static uint32_t index_default_version = 1;
 static uint32_t index_off32_limit = 0x7fffffff;
 
-static void write_index_file(off_t last_obj_offset)
+static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 {
-	uint32_t i;
-	struct sha1file *f = sha1create("%s-%s.%s", base_name,
-					sha1_to_hex(object_list_sha1), "idx");
-	struct object_entry **list = sorted_by_sha;
-	struct object_entry **last = list + nr_result;
+	struct sha1file *f;
+	struct object_entry **sorted_by_sha, **list, **last;
 	uint32_t array[256];
-	uint32_t index_version;
+	uint32_t i, index_version;
+	SHA_CTX ctx;
+	int fd;
+
+	snprintf(tmpname, sizeof(tmpname), "tmp_idx_XXXXXX");
+	fd = mkstemp(tmpname);
+	if (fd < 0)
+		die("unable to create %s: %s\n", tmpname, strerror(errno));
+	idx_tmp_name = xstrdup(tmpname);
+	f = sha1fd(fd, idx_tmp_name);
+
+	if (nr_result) {
+		uint32_t j = 0;
+		sorted_by_sha =
+			xcalloc(nr_result, sizeof(struct object_entry *));
+		for (i = 0; i < nr_objects; i++)
+			if (!objects[i].preferred_base)
+				sorted_by_sha[j++] = objects + i;
+		if (j != nr_result)
+			die("listed %u objects while expecting %u", j, nr_result);
+		qsort(sorted_by_sha, nr_result, sizeof(*sorted_by_sha), sha1_sort);
+		list = sorted_by_sha;
+		last = sorted_by_sha + nr_result;
+	} else
+		sorted_by_sha = list = last = NULL;
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
 	index_version = (last_obj_offset >> 31) ? 2 : index_default_version;
@@ -660,9 +693,10 @@ static void write_index_file(off_t last_obj_offset)
 	}
 	sha1write(f, array, 256 * 4);
 
-	/*
-	 * Write the actual SHA1 entries..
-	 */
+	/* Compute the SHA1 hash of sorted object names. */
+	SHA1_Init(&ctx);
+
+	/* Write the actual SHA1 entries. */
 	list = sorted_by_sha;
 	for (i = 0; i < nr_result; i++) {
 		struct object_entry *entry = *list++;
@@ -671,6 +705,7 @@ static void write_index_file(off_t last_obj_offset)
 			sha1write(f, &offset, 4);
 		}
 		sha1write(f, entry->sha1, 20);
+		SHA1_Update(&ctx, entry->sha1, 20);
 	}
 
 	if (index_version >= 2) {
@@ -711,6 +746,8 @@ static void write_index_file(off_t last_obj_offset)
 
 	sha1write(f, pack_file_sha1, 20);
 	sha1close(f, NULL, 1);
+	free(sorted_by_sha);
+	SHA1_Final(sha1, &ctx);
 }
 
 static int locate_object_entry_hash(const unsigned char *sha1)
@@ -789,6 +826,8 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 	if (ix >= 0) {
 		if (exclude) {
 			entry = objects + object_ix[ix] - 1;
+			if (!entry->preferred_base)
+				nr_result--;
 			entry->preferred_base = 1;
 		}
 		return 0;
@@ -821,6 +860,8 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 	entry->hash = hash;
 	if (exclude)
 		entry->preferred_base = 1;
+	else
+		nr_result++;
 	if (found_pack) {
 		entry->in_pack = found_pack;
 		entry->in_pack_offset = found_offset;
@@ -1181,30 +1222,6 @@ static void get_object_details(void)
 		check_object(entry);
 }
 
-static int sha1_sort(const void *_a, const void *_b)
-{
-	const struct object_entry *a = *(struct object_entry **)_a;
-	const struct object_entry *b = *(struct object_entry **)_b;
-	return hashcmp(a->sha1, b->sha1);
-}
-
-static struct object_entry **create_final_object_list(void)
-{
-	struct object_entry **list;
-	uint32_t i, j;
-
-	for (i = nr_result = 0; i < nr_objects; i++)
-		if (!objects[i].preferred_base)
-			nr_result++;
-	list = xmalloc(nr_result * sizeof(struct object_entry *));
-	for (i = j = 0; i < nr_objects; i++) {
-		if (!objects[i].preferred_base)
-			list[j++] = objects + i;
-	}
-	qsort(list, nr_result, sizeof(struct object_entry *), sha1_sort);
-	return list;
-}
-
 static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
@@ -1561,13 +1578,12 @@ static void get_object_list(int ac, const char **av)
 
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
-	SHA_CTX ctx;
 	int depth = 10;
-	struct object_entry **list;
-	off_t last_obj_offset;
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	uint32_t i;
+	off_t last_obj_offset;
+	const char *base_name = NULL;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
 	int rp_ac;
@@ -1712,20 +1728,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (progress)
 		fprintf(stderr, "Done counting %u objects.\n", nr_objects);
-	sorted_by_sha = create_final_object_list();
 	if (non_empty && !nr_result)
 		return 0;
-
-	SHA1_Init(&ctx);
-	list = sorted_by_sha;
-	for (i = 0; i < nr_result; i++) {
-		struct object_entry *entry = *list++;
-		SHA1_Update(&ctx, entry->sha1, 20);
-	}
-	SHA1_Final(object_list_sha1, &ctx);
 	if (progress && (nr_objects != nr_result))
 		fprintf(stderr, "Result has %u objects.\n", nr_result);
-
 	if (nr_result)
 		prepare_pack(window, depth);
 	if (progress == 1 && pack_to_stdout) {
@@ -1737,7 +1743,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 	last_obj_offset = write_pack_file();
 	if (!pack_to_stdout) {
-		write_index_file(last_obj_offset);
+		unsigned char object_list_sha1[20];
+		write_index_file(last_obj_offset, object_list_sha1);
+		snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
+			 base_name, sha1_to_hex(object_list_sha1));
+		if (rename(pack_tmp_name, tmpname))
+			die("unable to rename temporary pack file: %s",
+			    strerror(errno));
+		snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
+			 base_name, sha1_to_hex(object_list_sha1));
+		if (rename(idx_tmp_name, tmpname))
+			die("unable to rename temporary index file: %s",
+			    strerror(errno));
 		puts(sha1_to_hex(object_list_sha1));
 	}
 	if (progress)
-- 
1.5.1.1.781.g65e8
