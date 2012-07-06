From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 1/2] Strip namelen out of ce_flags into a ce_namelen field
Date: Fri,  6 Jul 2012 18:07:29 +0200
Message-ID: <1341590850-15653-2-git-send-email-t.gummerer@gmail.com>
References: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
 <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 18:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnB57-0000fP-HT
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 18:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab2GFQI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 12:08:28 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40304 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab2GFQIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 12:08:25 -0400
Received: by eeit10 with SMTP id t10so3704193eei.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=D0Vr2z/PeQN7KBCN2BU2us1vAxT0PTwinapHF/qou/U=;
        b=j/edWdCqgdl1E8/kMntorXFnVlGJRQX0gQxHQv43JeO6OECxcRDoS787kxL9AiqYv9
         CmxCFXHQWVg+ZraDwUnp9GXIqIAc0V4prRpi4zaAC0DndS3fv8avOG1ohnf2MJjKgfFc
         LzirhBYtdhgZBhyjK+Nv5/kQpnfpgXg85RtjpysTPWocSaj/+COigbV3WQUFkVv6nOsB
         BYvtAByWW17IpyFkQZTs7NNvxQZc8vSwH0rNmt3CfuFVTj/J3jUnTHYGe8f4tDS3KYlZ
         a4xvZoRfWNIWDffpO0z5qAmYu19J3lNvA1yEkVPJBzidMK/YQo6dA9cVBTeBhOqv691u
         Crpg==
Received: by 10.14.45.68 with SMTP id o44mr7594775eeb.66.1341590904389;
        Fri, 06 Jul 2012 09:08:24 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id a4sm65428552een.14.2012.07.06.09.08.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 09:08:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201120>

Strip the name length from the ce_flags field and move it
into its own ce_namelen field in struct cache_entry. This
will both give us a tiny bit of a performance enhancement
when working with long pathnames and is part of the
refactoring for the index-v5 file format.

Index-v5 won't store the name length in the on disk index
file, so storing it in the flags wouldn't make sense for
index-v5.

It also enhances readability, by making it more clear what
is a flag, and where the length is stored and make it clear
which functions use stages in comparisions and which only
use the length.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/apply.c        |    3 ++-
 builtin/blame.c        |    3 ++-
 builtin/checkout.c     |    3 ++-
 builtin/update-index.c |    9 +++++---
 cache.h                |   18 ++++++----------
 read-cache.c           |   54 +++++++++++++++++++++++++++++-------------------
 tree.c                 |    7 ++++---
 unpack-trees.c         |    3 ++-
 8 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dda9ea0..10f83fc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3502,7 +3502,8 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = namelen;
+	ce->ce_flags = 0;
+	ce->ce_namelen = namelen;
 	if (S_ISGITLINK(mode)) {
 		const char *s = buf;
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 24d3dd5..e181368 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2153,7 +2153,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	ce = xcalloc(1, size);
 	hashcpy(ce->sha1, origin->blob_sha1);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(len, 0);
+	ce->ce_flags = 0;
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3ddda34..5c06444 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -73,7 +73,8 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len - baselen);
-	ce->ce_flags = create_ce_flags(len, 0) | CE_UPDATE;
+	ce->ce_flags = CE_UPDATE;
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f038d6..911090f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -95,7 +95,8 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = len;
+	ce->ce_flags = 0;
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
index cc5048c..14160b7 100644
--- a/cache.h
+++ b/cache.h
@@ -128,6 +128,7 @@ struct cache_entry {
 	unsigned int ce_gid;
 	unsigned int ce_size;
 	unsigned int ce_flags;
+	unsigned int ce_namelen;
 	unsigned char sha1[20];
 	struct cache_entry *next;
 	struct cache_entry *dir_next;
@@ -198,21 +199,12 @@ static inline void copy_cache_entry(struct cache_entry *dst, struct cache_entry
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
@@ -448,6 +440,7 @@ extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+extern int index_name_stage_pos(const struct index_state *, const char *name, int stage, int namelen);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
@@ -857,6 +850,7 @@ extern int validate_headref(const char *ref);
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
+extern int cache_name_stage_compare(const char *name1, int stage1, int len1, const char *name2, int stage2, int len2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
 					const char *required_type,
diff --git a/read-cache.c b/read-cache.c
index ef355cc..ea75c89 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -54,8 +54,8 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 
 	new = xmalloc(cache_entry_size(namelen));
 	copy_cache_entry(new, old);
-	new->ce_flags &= ~(CE_STATE_MASK | CE_NAMEMASK);
-	new->ce_flags |= (namelen >= CE_NAMEMASK ? CE_NAMEMASK : namelen);
+	new->ce_flags &= ~CE_STATE_MASK;
+	new->ce_namelen = namelen;
 	memcpy(new->name, new_name, namelen + 1);
 
 	cache_tree_invalidate_path(istate->cache_tree, old->name);
@@ -395,10 +395,8 @@ int df_name_compare(const char *name1, int len1, int mode1,
 	return c1 - c2;
 }
 
-int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
+int cache_name_stage_compare(const char *name1, int stage1, int len1, const char *name2, int stage2, int len2)
 {
-	int len1 = flags1 & CE_NAMEMASK;
-	int len2 = flags2 & CE_NAMEMASK;
 	int len = len1 < len2 ? len1 : len2;
 	int cmp;
 
@@ -410,18 +408,19 @@ int cache_name_compare(const char *name1, int flags1, const char *name2, int fla
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
+	return cache_name_stage_compare(name1, 0, len1, name2, 0, len2);
+}
+
+int index_name_stage_pos(const struct index_state *istate, const char *name, int stage, int namelen)
 {
 	int first, last;
 
@@ -430,7 +429,7 @@ int index_name_pos(const struct index_state *istate, const char *name, int namel
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = istate->cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ce->ce_flags);
+		int cmp = cache_name_stage_compare(name, stage, namelen, ce->name, ce_stage(ce), ce->ce_namelen);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -442,6 +441,11 @@ int index_name_pos(const struct index_state *istate, const char *name, int namel
 	return -first-1;
 }
 
+int index_name_pos(const struct index_state *istate, const char *name, int namelen)
+{
+	return index_name_stage_pos(istate, name, 0, namelen);
+}
+
 /* Remove entry, return true if there are more entries to go.. */
 int remove_index_entry_at(struct index_state *istate, int pos)
 {
@@ -581,7 +585,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
-	ce->ce_flags = namelen;
+	ce->ce_namelen = namelen;
 	if (!intent_only)
 		fill_stat_cache_info(ce, st);
 	else
@@ -683,7 +687,8 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
 	if (refresh)
@@ -820,7 +825,7 @@ static int has_dir_name(struct index_state *istate,
 		}
 		len = slash - name;
 
-		pos = index_name_pos(istate, name, create_ce_flags(len, stage));
+		pos = index_name_stage_pos(istate, name, stage, len);
 		if (pos >= 0) {
 			/*
 			 * Found one, but not so fast.  This could
@@ -910,7 +915,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
 	cache_tree_invalidate_path(istate->cache_tree, ce->name);
-	pos = index_name_pos(istate, ce->name, ce->ce_flags);
+	pos = index_name_stage_pos(istate, ce->name, ce_stage(ce), ce->ce_namelen);
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
@@ -942,7 +947,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		if (!ok_to_replace)
 			return error("'%s' appears as both a file and as a directory",
 				     ce->name);
-		pos = index_name_pos(istate, ce->name, ce->ce_flags);
+		pos = index_name_stage_pos(istate, ce->name, ce_stage(ce), ce->ce_namelen);
 		pos = -pos-1;
 	}
 	return pos + 1;
@@ -1319,7 +1324,8 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	ce->ce_uid   = ntoh_l(ondisk->uid);
 	ce->ce_gid   = ntoh_l(ondisk->gid);
 	ce->ce_size  = ntoh_l(ondisk->size);
-	ce->ce_flags = flags;
+	ce->ce_flags = flags & ~CE_NAMEMASK;
+	ce->ce_namelen = len;
 	hashcpy(ce->sha1, ondisk->sha1);
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
@@ -1743,7 +1749,7 @@ int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended, hdr_version;
+	int i, err, removed, extended, hdr_version, len;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
@@ -1759,6 +1765,11 @@ int write_index(struct index_state *istate, int newfd)
 			extended++;
 			cache[i]->ce_flags |= CE_EXTENDED;
 		}
+		if (cache[i]->ce_namelen >= CE_NAMEMASK)
+			len = CE_NAMEMASK;
+		else
+			len = cache[i]->ce_namelen;
+		cache[i]->ce_flags |= len;
 	}
 
 	if (!istate->version)
@@ -1845,7 +1856,8 @@ int read_index_unmerged(struct index_state *istate)
 		size = cache_entry_size(len);
 		new_ce = xcalloc(1, size);
 		memcpy(new_ce->name, ce->name, len);
-		new_ce->ce_flags = create_ce_flags(len, 0) | CE_CONFLICTED;
+		new_ce->ce_flags = CE_CONFLICTED;
+		new_ce->ce_namelen = len;
 		new_ce->ce_mode = ce->ce_mode;
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
diff --git a/tree.c b/tree.c
index 676e9f7..7ab02d8 100644
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
+	return cache_name_stage_compare(ce1->name, ce_stage(ce1), ce1->ce_namelen,
+				  ce2->name, ce_stage(ce2), ce2->ce_namelen);
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
