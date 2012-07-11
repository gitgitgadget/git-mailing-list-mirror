From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/3] Strip namelen out of ce_flags into a ce_namelen field
Date: Wed, 11 Jul 2012 11:22:37 +0200
Message-ID: <1341998558-8502-3-git-send-email-t.gummerer@gmail.com>
References: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
 <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 11:23:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sot8z-0001ya-Jb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 11:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab2GKJX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 05:23:27 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55856 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab2GKJXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 05:23:21 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so151965eek.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YVQMpJYZ3ps3prWR9cM+xZXrwQPROSNBm2uxNT2aUgM=;
        b=oNsiS9mx0SAC98PnC0xWSii+iI8hJzuF7Bvx0fWchh3SCHe3IM5VVRXVCwEkylMQko
         cbyd6V/TG81j8W//n72jk7W3B56dlQea3HhGgYtx7EfJJ64ynHb4qaQwxyUAe28UMooP
         D3/LJdjMp0LtJeItj1lXE+n9vIzbUHAxh9MAqI875N33zMG3nSxv8V4l5tNNOJX8TWXP
         vbHvR2vCnsc/YqH5wYofuOcyfzze3sqVcrKaNB7pP4+rtdvpCYpQftgNcDD7Oq3c8JFC
         Zl9AFZnDM8PjhlV5eIp2QF6sJtGT5C2zS8kqtY3D637+Z0IJJv9FO6qTCcKbCC+QrV4y
         VA/A==
Received: by 10.14.94.142 with SMTP id n14mr11768653eef.211.1341998600947;
        Wed, 11 Jul 2012 02:23:20 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id m46sm3828059eeh.9.2012.07.11.02.23.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 02:23:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201293>

Strip the name length from the ce_flags field and move it
into its own ce_namelen field in struct cache_entry. This
will both give us a tiny bit of a performance enhancement
when working with long pathnames and is a refactoring for
more readability of the code.

It enhances readability, by making it more clear what
is a flag, and where the length is stored and make it clear
which functions use stages in comparisions and which only
use the length.

It also makes CE_NAMEMASK private, so that users don't
mistakenly write the name length in the flags.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/apply.c        |    3 ++-
 builtin/blame.c        |    3 ++-
 builtin/checkout.c     |    3 ++-
 builtin/update-index.c |    9 ++++---
 cache.h                |   19 +++++---------
 read-cache.c           |   67 ++++++++++++++++++++++++++++--------------------
 tree.c                 |    7 ++---
 unpack-trees.c         |    3 ++-
 8 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dda9ea0..347633c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3502,7 +3502,8 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = namelen;
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = namelen;
 	if (S_ISGITLINK(mode)) {
 		const char *s = buf;
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 24d3dd5..a28004a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2153,7 +2153,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	ce = xcalloc(1, size);
 	hashcpy(ce->sha1, origin->blob_sha1);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(len, 0);
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3ddda34..2dfa45b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -73,7 +73,8 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len - baselen);
-	ce->ce_flags = create_ce_flags(len, 0) | CE_UPDATE;
+	ce->ce_flags = create_ce_flags(0) | CE_UPDATE;
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f038d6..e747def 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -95,7 +95,8 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = len;
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = len;
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
@@ -235,7 +236,8 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	if (assume_unchanged)
 		ce->ce_flags |= CE_VALID;
@@ -433,7 +435,8 @@ static struct cache_entry *read_one_ent(const char *which,
 
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, namelen);
-	ce->ce_flags = create_ce_flags(namelen, stage);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = namelen;
 	ce->ce_mode = create_ce_mode(mode);
 	return ce;
 }
diff --git a/cache.h b/cache.h
index cc5048c..22d9484 100644
--- a/cache.h
+++ b/cache.h
@@ -128,13 +128,13 @@ struct cache_entry {
 	unsigned int ce_gid;
 	unsigned int ce_size;
 	unsigned int ce_flags;
+	unsigned int ce_namelen;
 	unsigned char sha1[20];
 	struct cache_entry *next;
 	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
-#define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_EXTENDED  (0x4000)
 #define CE_VALID     (0x8000)
@@ -198,21 +198,12 @@ static inline void copy_cache_entry(struct cache_entry *dst, struct cache_entry
 	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
 }
 
-static inline unsigned create_ce_flags(size_t len, unsigned stage)
+static inline unsigned create_ce_flags(unsigned stage)
 {
-	if (len >= CE_NAMEMASK)
-		len = CE_NAMEMASK;
-	return (len | (stage << CE_STAGESHIFT));
-}
-
-static inline size_t ce_namelen(const struct cache_entry *ce)
-{
-	size_t len = ce->ce_flags & CE_NAMEMASK;
-	if (len < CE_NAMEMASK)
-		return len;
-	return strlen(ce->name + CE_NAMEMASK) + CE_NAMEMASK;
+	return (stage << CE_STAGESHIFT);
 }
 
+#define ce_namelen(ce) ((ce)->ce_namelen)
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
@@ -448,6 +439,7 @@ extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+extern int index_name_stage_pos(const struct index_state *, const char *name, int namelen, int stage);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
@@ -857,6 +849,7 @@ extern int validate_headref(const char *ref);
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
+extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
 					const char *required_type,
diff --git a/read-cache.c b/read-cache.c
index 4c6bf5f..ac13bca 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -17,6 +17,10 @@
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 
+/* Mask for the name length in ce_flags in the on-disk index */
+
+#define CE_NAMEMASK  (0x0fff)
+
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
@@ -54,8 +58,8 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 
 	new = xmalloc(cache_entry_size(namelen));
 	copy_cache_entry(new, old);
-	new->ce_flags &= ~(CE_STATE_MASK | CE_NAMEMASK);
-	new->ce_flags |= (namelen >= CE_NAMEMASK ? CE_NAMEMASK : namelen);
+	new->ce_flags &= ~CE_STATE_MASK;
+	new->ce_namelen = namelen;
 	memcpy(new->name, new_name, namelen + 1);
 
 	cache_tree_invalidate_path(istate->cache_tree, old->name);
@@ -395,17 +399,10 @@ int df_name_compare(const char *name1, int len1, int mode1,
 	return c1 - c2;
 }
 
-int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
+int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
 {
-	int len1 = flags1 & CE_NAMEMASK;
-	int len2 = flags2 & CE_NAMEMASK;
-	int len, cmp;
-
-	if (len1 >= CE_NAMEMASK)
-		len1 = strlen(name1 + CE_NAMEMASK) + CE_NAMEMASK;
-	if (len2 >= CE_NAMEMASK)
-		len2 = strlen(name2 + CE_NAMEMASK) + CE_NAMEMASK;
-	len = len1 < len2 ? len1 : len2;
+	int len = len1 < len2 ? len1 : len2;
+	int cmp;
 
 	cmp = memcmp(name1, name2, len);
 	if (cmp)
@@ -415,18 +412,19 @@ int cache_name_compare(const char *name1, int flags1, const char *name2, int fla
 	if (len1 > len2)
 		return 1;
 
-	/* Compare stages  */
-	flags1 &= CE_STAGEMASK;
-	flags2 &= CE_STAGEMASK;
-
-	if (flags1 < flags2)
+	if (stage1 < stage2)
 		return -1;
-	if (flags1 > flags2)
+	if (stage1 > stage2)
 		return 1;
 	return 0;
 }
 
-int index_name_pos(const struct index_state *istate, const char *name, int namelen)
+int cache_name_compare(const char *name1, int len1, const char *name2, int len2)
+{
+	return cache_name_stage_compare(name1, len1, 0, name2, len2, 0);
+}
+
+int index_name_stage_pos(const struct index_state *istate, const char *name, int namelen, int stage)
 {
 	int first, last;
 
@@ -435,7 +433,7 @@ int index_name_pos(const struct index_state *istate, const char *name, int namel
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = istate->cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ce->ce_flags);
+		int cmp = cache_name_stage_compare(name, namelen, stage, ce->name, ce_namelen(ce), ce_stage(ce));
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -447,6 +445,11 @@ int index_name_pos(const struct index_state *istate, const char *name, int namel
 	return -first-1;
 }
 
+int index_name_pos(const struct index_state *istate, const char *name, int namelen)
+{
+	return index_name_stage_pos(istate, name, namelen, 0);
+}
+
 /* Remove entry, return true if there are more entries to go.. */
 int remove_index_entry_at(struct index_state *istate, int pos)
 {
@@ -586,7 +589,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
-	ce->ce_flags = namelen;
+	ce->ce_namelen = namelen;
 	if (!intent_only)
 		fill_stat_cache_info(ce, st);
 	else
@@ -688,7 +691,8 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
 	if (refresh)
@@ -825,7 +829,7 @@ static int has_dir_name(struct index_state *istate,
 		}
 		len = slash - name;
 
-		pos = index_name_pos(istate, name, create_ce_flags(len, stage));
+		pos = index_name_stage_pos(istate, name, len, stage);
 		if (pos >= 0) {
 			/*
 			 * Found one, but not so fast.  This could
@@ -915,7 +919,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
 	cache_tree_invalidate_path(istate->cache_tree, ce->name);
-	pos = index_name_pos(istate, ce->name, ce->ce_flags);
+	pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
@@ -947,7 +951,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		if (!ok_to_replace)
 			return error("'%s' appears as both a file and as a directory",
 				     ce->name);
-		pos = index_name_pos(istate, ce->name, ce->ce_flags);
+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 		pos = -pos-1;
 	}
 	return pos + 1;
@@ -1324,7 +1328,8 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	ce->ce_uid   = ntoh_l(ondisk->uid);
 	ce->ce_gid   = ntoh_l(ondisk->gid);
 	ce->ce_size  = ntoh_l(ondisk->size);
-	ce->ce_flags = flags;
+	ce->ce_flags = flags & ~CE_NAMEMASK;
+	ce->ce_namelen = len;
 	hashcpy(ce->sha1, ondisk->sha1);
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
@@ -1651,6 +1656,8 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 				       struct cache_entry *ce)
 {
+	short flags;
+
 	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
 	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
 	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
@@ -1662,7 +1669,10 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	ondisk->gid  = htonl(ce->ce_gid);
 	ondisk->size = htonl(ce->ce_size);
 	hashcpy(ondisk->sha1, ce->sha1);
-	ondisk->flags = htons(ce->ce_flags);
+
+	flags = ce->ce_flags;
+	flags |= (ce_namelen(ce) >= CE_NAMEMASK ? CE_NAMEMASK : ce_namelen(ce));
+	ondisk->flags = htons(flags);
 	if (ce->ce_flags & CE_EXTENDED) {
 		struct ondisk_cache_entry_extended *ondisk2;
 		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
@@ -1850,7 +1860,8 @@ int read_index_unmerged(struct index_state *istate)
 		size = cache_entry_size(len);
 		new_ce = xcalloc(1, size);
 		memcpy(new_ce->name, ce->name, len);
-		new_ce->ce_flags = create_ce_flags(len, 0) | CE_CONFLICTED;
+		new_ce->ce_flags = create_ce_flags(0) | CE_CONFLICTED;
+		new_ce->ce_namelen = len;
 		new_ce->ce_mode = ce->ce_mode;
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
diff --git a/tree.c b/tree.c
index 676e9f7..62fed63 100644
--- a/tree.c
+++ b/tree.c
@@ -22,7 +22,8 @@ static int read_one_entry_opt(const unsigned char *sha1, const char *base, int b
 	ce = xcalloc(1, size);
 
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = create_ce_flags(baselen + len, stage);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = baselen + len;
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	hashcpy(ce->sha1, sha1);
@@ -133,8 +134,8 @@ static int cmp_cache_name_compare(const void *a_, const void *b_)
 
 	ce1 = *((const struct cache_entry **)a_);
 	ce2 = *((const struct cache_entry **)b_);
-	return cache_name_compare(ce1->name, ce1->ce_flags,
-				  ce2->name, ce2->ce_flags);
+	return cache_name_stage_compare(ce1->name, ce1->ce_namelen, ce_stage(ce1),
+				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
 }
 
 int read_tree(struct tree *tree, int stage, struct pathspec *match)
diff --git a/unpack-trees.c b/unpack-trees.c
index ad40109..9981dd3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -539,7 +539,8 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 	struct cache_entry *ce = xcalloc(1, cache_entry_size(len));
 
 	ce->ce_mode = create_ce_mode(n->mode);
-	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = len;
 	hashcpy(ce->sha1, n->sha1);
 	make_traverse_path(ce->name, info, n);
 
-- 
1.7.10.GIT
