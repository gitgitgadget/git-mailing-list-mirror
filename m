From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/9] Use off_t in pack-objects/fast-import when we mean an offset
Date: Tue, 6 Mar 2007 20:44:34 -0500
Message-ID: <20070307014434.GI26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlEG-00070d-5o
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbXCGBop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbXCGBop
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49225 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161176AbXCGBoi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCb-0003r6-CJ; Tue, 06 Mar 2007 20:44:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A391420FBAE; Tue,  6 Mar 2007 20:44:34 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41639>

Always use an off_t value in pack-objects anytime we are dealing
with an offset to some data within a packfile.

Also fixed a minor uintmax_t that was incorrectly defined before.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-pack-objects.c |   52 ++++++++++++++++++++++++------------------------
 fast-import.c          |    4 +-
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8d5c3f1..f8ebad0 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -23,7 +23,7 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 struct object_entry {
 	unsigned char sha1[20];
 	unsigned long size;	/* uncompressed size */
-	unsigned long offset;	/* offset into the final pack file;
+	off_t offset;	/* offset into the final pack file;
 				 * nonzero if already written.
 				 */
 	unsigned int depth;	/* delta depth */
@@ -35,7 +35,7 @@ struct object_entry {
 #define in_pack_header_size delta_size	/* only when reusing pack data */
 	struct object_entry *delta;	/* delta base object */
 	struct packed_git *in_pack; 	/* already in pack */
-	unsigned int in_pack_offset;
+	off_t in_pack_offset;
 	struct object_entry *delta_child; /* deltified objects who bases me */
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
@@ -101,7 +101,7 @@ static int object_ix_hashsz;
  * get the object sha1 from the main index.
  */
 struct revindex_entry {
-	unsigned int offset;
+	off_t offset;
 	unsigned int nr;
 };
 struct pack_revindex {
@@ -183,7 +183,7 @@ static void prepare_pack_revindex(struct pack_revindex *rix)
 }
 
 static struct revindex_entry * find_packed_object(struct packed_git *p,
-						  unsigned int ofs)
+						  off_t ofs)
 {
 	int num;
 	int lo, hi;
@@ -211,15 +211,14 @@ static struct revindex_entry * find_packed_object(struct packed_git *p,
 	die("internal error: pack revindex corrupt");
 }
 
-static unsigned long find_packed_object_size(struct packed_git *p,
-					     unsigned long ofs)
+static off_t find_packed_object_size(struct packed_git *p, off_t ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
 	return entry[1].offset - ofs;
 }
 
 static unsigned char *find_packed_object_name(struct packed_git *p,
-					      unsigned long ofs)
+					      off_t ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
 	return (unsigned char *)(p->index_base + 256) + 24 * entry->nr + 4;
@@ -276,8 +275,8 @@ static int encode_header(enum object_type type, unsigned long size, unsigned cha
  */
 static int check_pack_inflate(struct packed_git *p,
 		struct pack_window **w_curs,
-		unsigned long offset,
-		unsigned long len,
+		off_t offset,
+		off_t len,
 		unsigned long expect)
 {
 	z_stream stream;
@@ -303,8 +302,8 @@ static int check_pack_inflate(struct packed_git *p,
 static void copy_pack_data(struct sha1file *f,
 		struct packed_git *p,
 		struct pack_window **w_curs,
-		unsigned long offset,
-		unsigned long len)
+		off_t offset,
+		off_t len)
 {
 	unsigned char *in;
 	unsigned int avail;
@@ -312,7 +311,7 @@ static void copy_pack_data(struct sha1file *f,
 	while (len) {
 		in = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
-			avail = len;
+			avail = (unsigned int)len;
 		sha1write(f, in, avail);
 		offset += avail;
 		len -= avail;
@@ -369,14 +368,15 @@ static int revalidate_loose_object(struct object_entry *entry,
 	return check_loose_inflate(map, mapsize, size);
 }
 
-static unsigned long write_object(struct sha1file *f,
+static off_t write_object(struct sha1file *f,
 				  struct object_entry *entry)
 {
 	unsigned long size;
 	enum object_type type;
 	void *buf;
 	unsigned char header[10];
-	unsigned hdrlen, datalen;
+	unsigned hdrlen;
+	off_t datalen;
 	enum object_type obj_type;
 	int to_reuse = 0;
 
@@ -439,7 +439,7 @@ static unsigned long write_object(struct sha1file *f,
 			 * encoding of the relative offset for the delta
 			 * base from this object's position in the pack.
 			 */
-			unsigned long ofs = entry->offset - entry->delta->offset;
+			off_t ofs = entry->offset - entry->delta->offset;
 			unsigned pos = sizeof(header) - 1;
 			header[pos] = ofs & 127;
 			while (ofs >>= 7)
@@ -460,7 +460,7 @@ static unsigned long write_object(struct sha1file *f,
 	else {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
-		unsigned long offset;
+		off_t offset;
 
 		if (entry->delta) {
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
@@ -470,7 +470,7 @@ static unsigned long write_object(struct sha1file *f,
 		hdrlen = encode_header(obj_type, entry->size, header);
 		sha1write(f, header, hdrlen);
 		if (obj_type == OBJ_OFS_DELTA) {
-			unsigned long ofs = entry->offset - entry->delta->offset;
+			off_t ofs = entry->offset - entry->delta->offset;
 			unsigned pos = sizeof(header) - 1;
 			header[pos] = ofs & 127;
 			while (ofs >>= 7)
@@ -498,9 +498,9 @@ static unsigned long write_object(struct sha1file *f,
 	return hdrlen + datalen;
 }
 
-static unsigned long write_one(struct sha1file *f,
+static off_t write_one(struct sha1file *f,
 			       struct object_entry *e,
-			       unsigned long offset)
+			       off_t offset)
 {
 	if (e->offset || e->preferred_base)
 		/* offset starts from header size and cannot be zero
@@ -518,7 +518,7 @@ static void write_pack_file(void)
 {
 	uint32_t i;
 	struct sha1file *f;
-	unsigned long offset;
+	off_t offset;
 	struct pack_header hdr;
 	unsigned last_percent = 999;
 	int do_progress = progress;
@@ -671,13 +671,13 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 	uint32_t idx = nr_objects;
 	struct object_entry *entry;
 	struct packed_git *p;
-	unsigned int found_offset = 0;
+	off_t found_offset = 0;
 	struct packed_git *found_pack = NULL;
 	int ix, status = 0;
 
 	if (!exclude) {
 		for (p = packed_git; p; p = p->next) {
-			unsigned long offset = find_pack_entry_one(sha1, p);
+			off_t offset = find_pack_entry_one(sha1, p);
 			if (offset) {
 				if (incremental)
 					return 0;
@@ -978,17 +978,17 @@ static void check_object(struct object_entry *entry)
 	if (entry->in_pack && !entry->preferred_base) {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
-		unsigned long left = p->pack_size - entry->in_pack_offset;
 		unsigned long size, used;
+		unsigned int avail;
 		unsigned char *buf;
 		struct object_entry *base_entry = NULL;
 
-		buf = use_pack(p, &w_curs, entry->in_pack_offset, NULL);
+		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
 		/* We want in_pack_type even if we do not reuse delta.
 		 * There is no point not reusing non-delta representations.
 		 */
-		used = unpack_object_header_gently(buf, left,
+		used = unpack_object_header_gently(buf, avail,
 						   &entry->in_pack_type, &size);
 
 		/* Check if it is delta, and the base is also an object
@@ -997,7 +997,7 @@ static void check_object(struct object_entry *entry)
 		 */
 		if (!no_reuse_delta) {
 			unsigned char c, *base_name;
-			unsigned long ofs;
+			off_t ofs;
 			unsigned long used_0;
 			/* there is at least 20 bytes left in the pack */
 			switch (entry->in_pack_type) {
diff --git a/fast-import.c b/fast-import.c
index a418a17..fda5018 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -249,7 +249,7 @@ typedef enum {
 
 /* Configured limits on output */
 static unsigned long max_depth = 10;
-static unsigned long max_packsize = (1LL << 32) - 1;
+static off_t max_packsize = (1LL << 32) - 1;
 static int force_update;
 
 /* Stats and misc. counters */
@@ -1527,7 +1527,7 @@ static void unload_one_branch(void)
 {
 	while (cur_active_branches
 		&& cur_active_branches >= max_active_branches) {
-		unsigned long min_commit = ULONG_MAX;
+		uintmax_t min_commit = ULONG_MAX;
 		struct branch *e, *l = NULL, *p = NULL;
 
 		for (e = active_branches; e; e = e->active_next_branch) {
-- 
1.5.0.3.863.gf0989
