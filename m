From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/9] Use uint32_t for pack-objects counters.
Date: Tue, 6 Mar 2007 20:44:24 -0500
Message-ID: <20070307014424.GG26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlEF-00070d-44
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbXCGBoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbXCGBoe
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49218 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161176AbXCGBo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCQ-0003qH-V5; Tue, 06 Mar 2007 20:44:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 20D2220FBAE; Tue,  6 Mar 2007 20:44:24 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41641>

As we technically try to support up to a maximum of 2**32-1 objects
in a single packfile we should act like it and use unsigned 32 bit
integers for all of our object counts and progress output.

This change does not modify everything in pack-objects that probably
needs to change to fully support the maximum of 2**32-1 objects.
I'm intentionally breaking the improvements into slightly smaller
commits to make them easier to follow.

No logic change should be occuring here, with the exception that
some comparsions will now work properly when the number of objects
exceeds 2**31-1.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-pack-objects.c |   63 ++++++++++++++++++++++-------------------------
 1 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8cf24f4..8d5c3f1 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -68,7 +68,7 @@ static int allow_ofs_delta;
 
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects;
-static int nr_objects, nr_alloc, nr_result;
+static uint32_t nr_objects, nr_alloc, nr_result;
 static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
@@ -114,10 +114,8 @@ static int pack_revindex_hashsz;
 /*
  * stats
  */
-static int written;
-static int written_delta;
-static int reused;
-static int reused_delta;
+static uint32_t written, written_delta;
+static uint32_t reused, reused_delta;
 
 static int pack_revindex_ix(struct packed_git *p)
 {
@@ -518,7 +516,7 @@ static unsigned long write_one(struct sha1file *f,
 
 static void write_pack_file(void)
 {
-	int i;
+	uint32_t i;
 	struct sha1file *f;
 	unsigned long offset;
 	struct pack_header hdr;
@@ -533,7 +531,7 @@ static void write_pack_file(void)
 		f = sha1create("%s-%s.%s", base_name,
 			       sha1_to_hex(object_list_sha1), "pack");
 	if (do_progress)
-		fprintf(stderr, "Writing %d objects.\n", nr_result);
+		fprintf(stderr, "Writing %u objects.\n", nr_result);
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(PACK_VERSION);
@@ -558,13 +556,13 @@ static void write_pack_file(void)
 		fputc('\n', stderr);
  done:
 	if (written != nr_result)
-		die("wrote %d objects while expecting %d", written, nr_result);
+		die("wrote %u objects while expecting %u", written, nr_result);
 	sha1close(f, pack_file_sha1, 1);
 }
 
 static void write_index_file(void)
 {
-	int i;
+	uint32_t i;
 	struct sha1file *f = sha1create("%s-%s.%s", base_name,
 					sha1_to_hex(object_list_sha1), "idx");
 	struct object_entry **list = sorted_by_sha;
@@ -633,7 +631,7 @@ static struct object_entry *locate_object_entry(const unsigned char *sha1)
 
 static void rehash_objects(void)
 {
-	int i;
+	uint32_t i;
 	struct object_entry *oe;
 
 	object_ix_hashsz = nr_objects * 3;
@@ -670,7 +668,7 @@ static unsigned name_hash(const char *name)
 
 static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclude)
 {
-	unsigned int idx = nr_objects;
+	uint32_t idx = nr_objects;
 	struct object_entry *entry;
 	struct packed_git *p;
 	unsigned int found_offset = 0;
@@ -696,9 +694,8 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 		goto already_added;
 
 	if (idx >= nr_alloc) {
-		unsigned int needed = (idx + 1024) * 3 / 2;
-		objects = xrealloc(objects, needed * sizeof(*entry));
-		nr_alloc = needed;
+		nr_alloc = (idx + 1024) * 3 / 2;
+		objects = xrealloc(objects, nr_alloc * sizeof(*entry));
 	}
 	entry = objects + idx;
 	nr_objects = idx + 1;
@@ -718,7 +715,7 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 
  already_added:
 	if (progress_update) {
-		fprintf(stderr, "Counting objects...%d\r", nr_objects);
+		fprintf(stderr, "Counting objects...%u\r", nr_objects);
 		progress_update = 0;
 	}
 	if (exclude)
@@ -1081,7 +1078,7 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 
 static void get_object_details(void)
 {
-	int i;
+	uint32_t i;
 	struct object_entry *entry;
 
 	prepare_pack_ix();
@@ -1120,7 +1117,7 @@ static int sort_comparator(const void *_a, const void *_b)
 static struct object_entry **create_sorted_list(entry_sort_t sort)
 {
 	struct object_entry **list = xmalloc(nr_objects * sizeof(struct object_entry *));
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < nr_objects; i++)
 		list[i] = objects + i;
@@ -1137,7 +1134,7 @@ static int sha1_sort(const struct object_entry *a, const struct object_entry *b)
 static struct object_entry **create_final_object_list(void)
 {
 	struct object_entry **list;
-	int i, j;
+	uint32_t i, j;
 
 	for (i = nr_result = 0; i < nr_objects; i++)
 		if (!objects[i].preferred_base)
@@ -1279,20 +1276,20 @@ static void progress_interval(int signum)
 
 static void find_deltas(struct object_entry **list, int window, int depth)
 {
-	int i, idx;
+	uint32_t i = nr_objects, idx = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
-	struct unpacked *array = xmalloc(array_size);
-	unsigned processed = 0;
+	struct unpacked *array;
 	unsigned last_percent = 999;
 
+	if (!nr_objects)
+		return;
+	array = xmalloc(array_size);
 	memset(array, 0, array_size);
-	i = nr_objects;
-	idx = 0;
 	if (progress)
-		fprintf(stderr, "Deltifying %d objects.\n", nr_result);
+		fprintf(stderr, "Deltifying %u objects.\n", nr_result);
 
-	while (--i >= 0) {
-		struct object_entry *entry = list[i];
+	do {
+		struct object_entry *entry = list[--i];
 		struct unpacked *n = array + idx;
 		int j;
 
@@ -1325,7 +1322,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 
 		j = window;
 		while (--j > 0) {
-			unsigned int other_idx = idx + j;
+			uint32_t other_idx = idx + j;
 			struct unpacked *m;
 			if (other_idx >= window)
 				other_idx -= window;
@@ -1345,7 +1342,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		idx++;
 		if (idx >= window)
 			idx = 0;
-	}
+	} while (i > 0);
 
 	if (progress)
 		fputc('\n', stderr);
@@ -1386,7 +1383,7 @@ static int reuse_cached_pack(unsigned char *sha1)
 	}
 
 	if (progress)
-		fprintf(stderr, "Reusing %d objects pack %s\n", nr_objects,
+		fprintf(stderr, "Reusing %u objects pack %s\n", nr_objects,
 			sha1_to_hex(sha1));
 
 	if (pack_to_stdout) {
@@ -1537,7 +1534,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct object_entry **list;
 	int use_internal_rev_list = 0;
 	int thin = 0;
-	int i;
+	uint32_t i;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
 	int rp_ac;
@@ -1670,7 +1667,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress)
-		fprintf(stderr, "Done counting %d objects.\n", nr_objects);
+		fprintf(stderr, "Done counting %u objects.\n", nr_objects);
 	sorted_by_sha = create_final_object_list();
 	if (non_empty && !nr_result)
 		return 0;
@@ -1683,7 +1680,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 	SHA1_Final(object_list_sha1, &ctx);
 	if (progress && (nr_objects != nr_result))
-		fprintf(stderr, "Result has %d objects.\n", nr_result);
+		fprintf(stderr, "Result has %u objects.\n", nr_result);
 
 	if (reuse_cached_pack(object_list_sha1))
 		;
@@ -1704,7 +1701,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 	if (progress)
-		fprintf(stderr, "Total %d (delta %d), reused %d (delta %d)\n",
+		fprintf(stderr, "Total %u (delta %u), reused %u (delta %u)\n",
 			written, written_delta, reused, reused_delta);
 	return 0;
 }
-- 
1.5.0.3.863.gf0989
