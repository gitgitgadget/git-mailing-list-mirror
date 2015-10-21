From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4] name-hash: don't reuse cache_entry in dir_entry
Date: Wed, 21 Oct 2015 13:54:11 -0400
Message-ID: <1445450051-7430-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 19:54:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoxav-0007yS-EC
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 19:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbbJURyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 13:54:33 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34330 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbJURyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 13:54:32 -0400
Received: by qkfm62 with SMTP id m62so42460950qkf.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 10:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WazrSqBEtWo1PPM6CLrF1zrCA7+AwlaVUp+S9s6ZVG4=;
        b=J2dXl3FeaQDT4EykdA9YRDVV0l5VvWjKg7DumqqG6BC9vF0hlxmIvuMm+lHN5Dgv5T
         7f1OckI5IfHMv3Zf/beVY6E8Hk6LA5HPdIwwtlr5TkvzxvlOVWd2xHNE978bF0X+heOo
         HvTDBeGp+IbeQfrNbG8CjsBVUYyFC+scfTgXBVDLb6lp8u190cmRzLqBDq3bdjppiaSO
         8daBQ5UdWKEvgZSoVQfhfRClo4GEmFEeUAb+Zw7HL8hfauls5/azjKCG2qLMVT9Soz2A
         JYD53Qg0wjskuMkdgZ+MUwX6sMU4BT8z+gUJ0Ww+5+1wnv1G56t7lwFUWBtfRdRiMXPb
         qS7A==
X-Gm-Message-State: ALoCoQmpiIyds/2wOz8zcao2Qj3mLVOjotMxaM1aklUYf54DIwGHuKOy12qYR3vqwJLC/P5YRxkX
X-Received: by 10.55.217.20 with SMTP id u20mr12716363qki.98.1445450071208;
        Wed, 21 Oct 2015 10:54:31 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id v63sm3713350qkl.2.2015.10.21.10.54.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Oct 2015 10:54:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279995>

Stop reusing cache_entry in dir_entry; doing so causes a
use-after-free bug.

During merges, we free entries that we no longer need in the
destination index.  But those entries might have also been stored in
the dir_entry cache, and when a later call to add_to_index found them,
they would be used after being freed.

To prevent this, change dir_entry to store a copy of the name instead
of a pointer to a cache_entry.  This entails some refactoring of code
that expects the cache_entry.

Keith McGuigan <kmcguigan@twitter.com> diagnosed this bug and wrote
the initial patch, but this version does not use any of Keith's code.

Helped-by: Keith McGuigan <kmcguigan@twitter.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 cache.h      |  3 ++-
 dir.c        | 22 ++++------------------
 name-hash.c  | 54 ++++++++++++++++++++++++++++--------------------------
 read-cache.c | 16 +---------------
 4 files changed, 35 insertions(+), 60 deletions(-)

diff --git a/cache.h b/cache.h
index 752031e..ccc329a 100644
--- a/cache.h
+++ b/cache.h
@@ -520,7 +520,8 @@ extern int write_locked_index(struct index_state *, struct lock_file *lock, unsi
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
-extern struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen);
+extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
+extern void adjust_dirname_case(struct index_state *istate, char *name);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
diff --git a/dir.c b/dir.c
index b90484a..c982aac 100644
--- a/dir.c
+++ b/dir.c
@@ -1279,29 +1279,15 @@ enum exist_status {
  */
 static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
 {
-	const struct cache_entry *ce = cache_dir_exists(dirname, len);
-	unsigned char endchar;
+	struct cache_entry *ce;
 
-	if (!ce)
-		return index_nonexistent;
-	endchar = ce->name[len];
-
-	/*
-	 * The cache_entry structure returned will contain this dirname
-	 * and possibly additional path components.
-	 */
-	if (endchar == '/')
+	if (cache_dir_exists(dirname, len))
 		return index_directory;
 
-	/*
-	 * If there are no additional path components, then this cache_entry
-	 * represents a submodule.  Submodules, despite being directories,
-	 * are stored in the cache without a closing slash.
-	 */
-	if (!endchar && S_ISGITLINK(ce->ce_mode))
+	ce = cache_file_exists(dirname, len, ignore_case);
+	if (ce && S_ISGITLINK(ce->ce_mode))
 		return index_gitdir;
 
-	/* This should never be hit, but it exists just in case. */
 	return index_nonexistent;
 }
 
diff --git a/name-hash.c b/name-hash.c
index 702cd05..332ba95 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -11,16 +11,16 @@
 struct dir_entry {
 	struct hashmap_entry ent;
 	struct dir_entry *parent;
-	struct cache_entry *ce;
 	int nr;
 	unsigned int namelen;
+	char name[FLEX_ARRAY];
 };
 
 static int dir_entry_cmp(const struct dir_entry *e1,
 		const struct dir_entry *e2, const char *name)
 {
-	return e1->namelen != e2->namelen || strncasecmp(e1->ce->name,
-			name ? name : e2->ce->name, e1->namelen);
+	return e1->namelen != e2->namelen || strncasecmp(e1->name,
+			name ? name : e2->name, e1->namelen);
 }
 
 static struct dir_entry *find_dir_entry(struct index_state *istate,
@@ -41,14 +41,6 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	 * closing slash.  Despite submodules being a directory, they never
 	 * reach this point, because they are stored
 	 * in index_state.name_hash (as ordinary cache_entries).
-	 *
-	 * Note that the cache_entry stored with the dir_entry merely
-	 * supplies the name of the directory (up to dir_entry.namelen). We
-	 * track the number of 'active' files in a directory in dir_entry.nr,
-	 * so we can tell if the directory is still relevant, e.g. for git
-	 * status. However, if cache_entries are removed, we cannot pinpoint
-	 * an exact cache_entry that's still active. It is very possible that
-	 * multiple dir_entries point to the same cache_entry.
 	 */
 	struct dir_entry *dir;
 
@@ -63,10 +55,10 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	dir = find_dir_entry(istate, ce->name, namelen);
 	if (!dir) {
 		/* not found, create it and add to hash table */
-		dir = xcalloc(1, sizeof(struct dir_entry));
+		dir = xcalloc(1, sizeof(struct dir_entry) + namelen + 1);
 		hashmap_entry_init(dir, memihash(ce->name, namelen));
 		dir->namelen = namelen;
-		dir->ce = ce;
+		strncpy(dir->name, ce->name, namelen);
 		hashmap_add(&istate->dir_hash, dir);
 
 		/* recursively add missing parent directories */
@@ -188,26 +180,36 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	return slow_same_name(name, namelen, ce->name, len);
 }
 
-struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen)
+int index_dir_exists(struct index_state *istate, const char *name, int namelen)
 {
-	struct cache_entry *ce;
 	struct dir_entry *dir;
 
 	lazy_init_name_hash(istate);
 	dir = find_dir_entry(istate, name, namelen);
-	if (dir && dir->nr)
-		return dir->ce;
+	return dir && dir->nr;
+}
 
-	/*
-	 * It might be a submodule. Unlike plain directories, which are stored
-	 * in the dir-hash, submodules are stored in the name-hash, so check
-	 * there, as well.
-	 */
-	ce = index_file_exists(istate, name, namelen, 1);
-	if (ce && S_ISGITLINK(ce->ce_mode))
-		return ce;
+void adjust_dirname_case(struct index_state *istate, char *name)
+{
+	const char *startPtr = name;
+	const char *ptr = startPtr;
 
-	return NULL;
+	lazy_init_name_hash(istate);
+	while (*ptr) {
+		while (*ptr && *ptr != '/')
+			ptr++;
+
+		if (*ptr == '/') {
+			struct dir_entry *dir;
+
+			ptr++;
+			dir = find_dir_entry(istate, name, ptr - name + 1);
+			if (dir) {
+				memcpy((void *)startPtr, dir->name + (startPtr - name), ptr - startPtr);
+				startPtr = ptr;
+			}
+		}
+	}
 }
 
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
diff --git a/read-cache.c b/read-cache.c
index 87204a5..de22df2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -679,21 +679,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	 * entry's directory case.
 	 */
 	if (ignore_case) {
-		const char *startPtr = ce->name;
-		const char *ptr = startPtr;
-		while (*ptr) {
-			while (*ptr && *ptr != '/')
-				++ptr;
-			if (*ptr == '/') {
-				struct cache_entry *foundce;
-				++ptr;
-				foundce = index_dir_exists(istate, ce->name, ptr - ce->name - 1);
-				if (foundce) {
-					memcpy((void *)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
-					startPtr = ptr;
-				}
-			}
-		}
+		adjust_dirname_case(istate, ce->name);
 	}
 
 	alias = index_file_exists(istate, ce->name, ce_namelen(ce), ignore_case);
-- 
2.4.2.644.g97b850b-twtrsrc
