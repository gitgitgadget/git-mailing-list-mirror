From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 01:24:19 -0400
Message-ID: <20070526052419.GA11957@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dana How <danahow@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 07:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrolW-0000gb-5Z
	for gcvg-git@gmane.org; Sat, 26 May 2007 07:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbXEZFY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 01:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbXEZFY1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 01:24:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40400 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbXEZFY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 01:24:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HrolJ-0005zT-7x; Sat, 26 May 2007 01:24:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EBC8920FBAE; Sat, 26 May 2007 01:24:19 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48449>

In some repository configurations the user may have many packfiles,
but all of the recent commits/trees/tags/blobs are likely to
be in the most recent packfile (the one with the newest mtime).
It is therefore common to be able to complete an entire operation
by accessing only one packfile, even if there are 25 packfiles
available to the repository.

Rather than opening and mmaping the corresponding .idx file for
every pack found, we now only open and map the .idx when we suspect
there might be an object of interest in there.

Of course we cannot known in advance which packfile contains an
object, so we still need to scan the entire packed_git list to
locate anything.  But odds are users want to access objects in the
most recently created packfiles first, and that may be all they
ever need for the current operation.

Junio observed in b867092f that placing recent packfiles before
older ones can slightly improve access times for recent objects,
without degrading it for historical object access.

This change improves upon Junio's observations by trying even harder
to avoid the .idx files that we won't need.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This conflicts (in a subtle way) with Dana How's
 "sha1_file.c:rearrange_packed_git() should consider packs' object
 sizes" patch as we now have num_objects = 0 for any indexes we
 have not opened.  In the case of Dana's patch this would cause
 those packfiles to have very high ranks, possibly sorting much
 later than they should have.

 builtin-count-objects.c |    2 ++
 cache.h                 |    3 ++-
 pack-check.c            |    9 +++++++--
 pack-redundant.c        |    3 +++
 sha1_file.c             |   38 +++++++++++++++++++++++++++++++++++---
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index ff90ebd..ac65e03 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -111,6 +111,8 @@ int cmd_count_objects(int ac, const char **av, const char *prefix)
 		for (p = packed_git; p; p = p->next) {
 			if (!p->pack_local)
 				continue;
+			if (!p->index_data && open_pack_index(p))
+				continue;
 			packed += p->num_objects;
 			num_pack++;
 		}
diff --git a/cache.h b/cache.h
index cd875bc..0f4a05b 100644
--- a/cache.h
+++ b/cache.h
@@ -485,10 +485,11 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
 extern void pack_report(void);
+extern int open_pack_index(struct packed_git *);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *, int, int);
-extern const unsigned char *nth_packed_object_sha1(const struct packed_git *, uint32_t);
+extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/pack-check.c b/pack-check.c
index d04536b..7475348 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -129,12 +129,17 @@ static void show_pack_info(struct packed_git *p)
 
 int verify_pack(struct packed_git *p, int verbose)
 {
-	off_t index_size = p->index_size;
-	const unsigned char *index_base = p->index_data;
+	off_t index_size;
+	const unsigned char *index_base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	int ret;
 
+	if (open_pack_index(p))
+		return error("packfile %s index not opened", p->pack_name);
+	index_size = p->index_size;
+	index_base = p->index_data;
+
 	ret = 0;
 	/* Verify SHA1 sum of the index file */
 	SHA1_Init(&ctx);
diff --git a/pack-redundant.c b/pack-redundant.c
index 87077e1..0617320 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -550,6 +550,9 @@ static struct pack_list * add_pack(struct packed_git *p)
 	l.pack = p;
 	llist_init(&l.all_objects);
 
+	if (!p->index_data && open_pack_index(p))
+		return NULL;
+
 	base = p->index_data;
 	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
 	step = (p->index_version < 2) ? 24 : 20;
diff --git a/sha1_file.c b/sha1_file.c
index 12d2ef2..6a5ba63 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -530,6 +530,21 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	return 0;
 }
 
+int open_pack_index (struct packed_git *p)
+{
+	char *idx_name;
+	int ret;
+
+	if (p->index_data)
+		return 0;
+
+	idx_name = xstrdup(p->pack_name);
+	strcpy(idx_name + strlen(idx_name) - strlen(".pack"), ".idx");
+	ret = check_packed_git_idx(idx_name, p);
+	free(idx_name);
+	return ret;
+}
+
 static void scan_windows(struct packed_git *p,
 	struct packed_git **lru_p,
 	struct pack_window **lru_w,
@@ -605,6 +620,9 @@ static int open_packed_git_1(struct packed_git *p)
 	unsigned char *idx_sha1;
 	long fd_flag;
 
+	if (!p->index_data && open_pack_index(p))
+		return error("packfile %s index unavailable", p->pack_name);
+
 	p->pack_fd = open(p->pack_name, O_RDONLY);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
@@ -757,8 +775,7 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 		return NULL;
 	memcpy(p->pack_name, path, path_len);
 	strcpy(p->pack_name + path_len, ".pack");
-	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode) ||
-	    check_packed_git_idx(path, p)) {
+	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
 		return NULL;
 	}
@@ -766,6 +783,10 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	/* ok, it looks sane as far as we can check without
 	 * actually mapping the pack file.
 	 */
+	p->index_version = 0;
+	p->index_data = NULL;
+	p->index_size = 0;
+	p->num_objects = 0;
 	p->pack_size = st.st_size;
 	p->next = NULL;
 	p->windows = NULL;
@@ -1572,10 +1593,15 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	return data;
 }
 
-const unsigned char *nth_packed_object_sha1(const struct packed_git *p,
+const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 					    uint32_t n)
 {
 	const unsigned char *index = p->index_data;
+	if (!index) {
+		if (open_pack_index(p))
+			return NULL;
+		index = p->index_data;
+	}
 	if (n >= p->num_objects)
 		return NULL;
 	index += 4 * 256;
@@ -1612,6 +1638,12 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	const unsigned char *index = p->index_data;
 	unsigned hi, lo;
 
+	if (!index) {
+		if (open_pack_index(p))
+			return 0;
+		level1_ofs = p->index_data;
+		index = p->index_data;
+	}
 	if (p->index_version > 1) {
 		level1_ofs += 2;
 		index += 8;
-- 
1.5.2.789.g8ee1
