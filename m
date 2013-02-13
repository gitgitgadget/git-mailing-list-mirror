From: Jeff King <peff@peff.net>
Subject: Re: inotify to minimize stat() calls
Date: Wed, 13 Feb 2013 14:47:41 -0500
Message-ID: <20130213194741.GA20712@sigill.intra.peff.net>
References: <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh>
 <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
 <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
 <511AAA92.4030508@gmail.com>
 <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com>
 <20130213181851.GA5603@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: blees@dcon.de, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:48:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5iJM-0000GL-8q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 20:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553Ab3BMTro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 14:47:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48230 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284Ab3BMTrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 14:47:43 -0500
Received: (qmail 14457 invoked by uid 107); 13 Feb 2013 19:49:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Feb 2013 14:49:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2013 14:47:41 -0500
Content-Disposition: inline
In-Reply-To: <20130213181851.GA5603@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216277>

On Wed, Feb 13, 2013 at 01:18:51PM -0500, Jeff King wrote:

> I think the best way forward is to actually create a separate hash table
> for the directory lookups. I note that we only care about these entries
> in directory_exists_in_index_icase, which is really about whether
> something is there, versus what exactly is there. So could we maybe get
> by with a separate hash table that stores a count of entries at each
> directory, and increment/decrement the count when we add/remove entries?
> 
> The biggest problem I see with that is that we do indeed care a little
> bit what is at the directory: we check the mode to see if it is a gitdir
> or not. But I think we can maybe sneak around that: gitdirs have actual
> entries in the index, whereas the directories do not. So we would find
> them via index_name_exists; anything that is not there, but _is_ in the
> special directory hash would therefore be a directory.
> 
> I realize it got pretty esoteric there in the middle. I'll see if I can
> work up a patch that expresses what I'm thinking.

So here's a patch. It's mostly meant to illustrate what I'm thinking,
and I have no clue if it introduces regressions. It does pass the test
suite, but we have virtually no ignorecase tests.  It seems to behave
sanely when I set core.ignorecase on my Linux box, but I have no idea
what it will do on a real case-insensitive system (nor even, to be
honest, what kinds of scenarios should be tested for the dir-hashing
stuff).

---
diff --git a/cache.h b/cache.h
index e493563..6630a35 100644
--- a/cache.h
+++ b/cache.h
@@ -131,7 +131,6 @@ struct cache_entry {
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
 	struct cache_entry *next;
-	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -267,26 +266,14 @@ extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
+	struct hash_table dir_hash;
 };
 
 extern struct index_state the_index;
 
 /* Name hashing */
 extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
-/*
- * We don't actually *remove* it, we can just mark it invalid so that
- * we won't find it in lookups.
- *
- * Not only would we have to search the lists (simple enough), but
- * we'd also have to rehash other hash buckets in case this makes the
- * hash bucket empty (common). So it's much better to just mark
- * it.
- */
-static inline void remove_name_hash(struct cache_entry *ce)
-{
-	ce->ce_flags |= CE_UNHASHED;
-}
-
+extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define active_cache (the_index.cache)
@@ -443,6 +430,7 @@ extern struct cache_entry *index_name_exists(struct index_state *istate, const c
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+extern int index_icase_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/dir.c b/dir.c
index 57394e4..f73ac34 100644
--- a/dir.c
+++ b/dir.c
@@ -927,29 +927,27 @@ static enum exist_status directory_exists_in_index_icase(const char *dirname, in
  */
 static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
 {
-	struct cache_entry *ce = index_name_exists(&the_index, dirname, len + 1, ignore_case);
-	unsigned char endchar;
-
-	if (!ce)
-		return index_nonexistent;
-	endchar = ce->name[len];
+	struct cache_entry *ce = index_name_exists(&the_index, dirname, len, ignore_case);
 
 	/*
-	 * The cache_entry structure returned will contain this dirname
-	 * and possibly additional path components.
+	 * We found something in the index, which means it is either an actual
+	 * file, or a gitdir.
 	 */
-	if (endchar == '/')
-		return index_directory;
+	if (ce) {
+	    if (S_ISGITLINK(ce->ce_mode))
+		    return index_gitdir;
+	    /* We call a file "index_nonexistent" here, because the caller is
+	     * asking about a directory.  */
+	    return index_nonexistent;
+	}
 
 	/*
-	 * If there are no additional path components, then this cache_entry
-	 * represents a submodule.  Submodules, despite being directories,
-	 * are stored in the cache without a closing slash.
+	 * Otherwise, it might be a leading path of something that is in the
+	 * index. We can look it up in the special dir hash.
 	 */
-	if (!endchar && S_ISGITLINK(ce->ce_mode))
-		return index_gitdir;
+	if (index_icase_dir_exists(&the_index, dirname, len))
+		return index_directory;
 
-	/* This should never be hit, but it exists just in case. */
 	return index_nonexistent;
 }
 
diff --git a/name-hash.c b/name-hash.c
index d8d25c2..de8239f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -32,37 +32,88 @@ static void hash_index_entry_directories(struct index_state *istate, struct cach
 	return hash;
 }
 
-static void hash_index_entry_directories(struct index_state *istate, struct cache_entry *ce)
+struct dir_hash_entry {
+	struct dir_hash_entry *next;
+	int nr;
+	unsigned int namelen;
+	char name[FLEX_ARRAY];
+};
+
+static struct dir_hash_entry *find_dir_hash(struct hash_table *t,
+					    const char *name,
+					    unsigned int namelen)
+{
+	unsigned int hash = hash_name(name, namelen);
+	struct dir_hash_entry *ent;
+
+	for (ent = lookup_hash(hash, t); ent; ent = ent->next) {
+		if (ent->namelen == namelen &&
+		    !strncasecmp(ent->name, name, namelen))
+			return ent;
+	}
+	return NULL;
+}
+
+static struct dir_hash_entry *find_or_create_dir_hash(struct hash_table *t,
+						      const char *name,
+						      unsigned int namelen)
+{
+	struct dir_hash_entry *ent;
+
+	ent = find_dir_hash(t, name, namelen);
+	if (!ent) {
+		void **pos;
+
+		ent = xcalloc(sizeof(*ent) + namelen + 1, 1);
+		memcpy(ent->name, name, namelen);
+		ent->namelen = namelen;
+
+		pos = insert_hash(hash_name(name, namelen), ent, t);
+		if (pos) {
+			ent->next = *pos;
+			*pos = ent;
+		}
+	}
+
+	return ent;
+}
+
+static void hash_index_entry_directories(struct index_state *istate,
+					 struct cache_entry *ce,
+					 int add)
 {
 	/*
-	 * Throw each directory component in the hash for quick lookup
+	 * Throw each directory component into a hash for quick lookup
 	 * during a git status. Directory components are stored with their
 	 * closing slash.  Despite submodules being a directory, they never
 	 * reach this point, because they are stored without a closing slash
-	 * in the cache.
-	 *
-	 * Note that the cache_entry stored with the directory does not
-	 * represent the directory itself.  It is a pointer to an existing
-	 * filename, and its only purpose is to represent existence of the
-	 * directory in the cache.  It is very possible multiple directory
-	 * hash entries may point to the same cache_entry.
+	 * in the cache. This means we don't need to know anything about
+	 * what is stored at a particular directory, just that it is a leading
+	 * directory component of something else. Which means we can get away
+	 * with storing a count instead of a complete
 	 */
-	unsigned int hash;
-	void **pos;
-
 	const char *ptr = ce->name;
 	while (*ptr) {
 		while (*ptr && *ptr != '/')
 			++ptr;
 		if (*ptr == '/') {
-			++ptr;
-			hash = hash_name(ce->name, ptr - ce->name);
-			pos = insert_hash(hash, ce, &istate->name_hash);
-			if (pos) {
-				ce->dir_next = *pos;
-				*pos = ce;
+			struct dir_hash_entry *ent;
+
+			if (add) {
+				ent = find_or_create_dir_hash(&istate->dir_hash,
+							      ce->name,
+							      ptr - ce->name);
+				ent->nr++;
+			}
+			else {
+				ent = find_dir_hash(&istate->dir_hash,
+						    ce->name,
+						    ptr - ce->name);
+				if (ent)
+					ent->nr--;
 			}
 		}
+		ptr++;
 	}
 }
 
@@ -74,7 +125,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	ce->next = ce->dir_next = NULL;
+	ce->next = NULL;
 	hash = hash_name(ce->name, ce_namelen(ce));
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
@@ -83,7 +134,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	}
 
 	if (ignore_case)
-		hash_index_entry_directories(istate, ce);
+		hash_index_entry_directories(istate, ce, 1);
 }
 
 static void lazy_init_name_hash(struct index_state *istate)
@@ -104,6 +155,22 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 		hash_index_entry(istate, ce);
 }
 
+/*
+ * We don't actually *remove* it, we can just mark it invalid so that
+ * we won't find it in lookups.
+ *
+ * Not only would we have to search the lists (simple enough), but
+ * we'd also have to rehash other hash buckets in case this makes the
+ * hash bucket empty (common). So it's much better to just mark
+ * it.
+ */
+void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
+{
+	ce->ce_flags |= CE_UNHASHED;
+	if (istate->dir_hash.nr)
+		hash_index_entry_directories(istate, ce, 0);
+}
+
 static int slow_same_name(const char *name1, int len1, const char *name2, int len2)
 {
 	if (len1 != len2)
@@ -137,18 +204,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	if (!icase)
 		return 0;
 
-	/*
-	 * If the entry we're comparing is a filename (no trailing slash), then compare
-	 * the lengths exactly.
-	 */
-	if (name[namelen - 1] != '/')
-		return slow_same_name(name, namelen, ce->name, len);
-
-	/*
-	 * For a directory, we point to an arbitrary cache_entry filename.  Just
-	 * make sure the directory portion matches.
-	 */
-	return slow_same_name(name, namelen, ce->name, namelen < len ? namelen : len);
+	return slow_same_name(name, namelen, ce->name, len);
 }
 
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
@@ -164,10 +220,7 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
-		if (icase && name[namelen - 1] == '/')
-			ce = ce->dir_next;
-		else
-			ce = ce->next;
+		ce = ce->next;
 	}
 
 	/*
@@ -188,3 +241,11 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 	}
 	return NULL;
 }
+
+int index_icase_dir_exists(struct index_state *istate, const char *name, int namelen)
+{
+	struct dir_hash_entry *ent;
+
+	ent = find_dir_hash(&istate->dir_hash, name, namelen);
+	return ent && ent->nr;
+}
diff --git a/read-cache.c b/read-cache.c
index 827ae55..116c25c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -46,7 +46,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 {
 	struct cache_entry *old = istate->cache[nr];
 
-	remove_name_hash(old);
+	remove_name_hash(istate, old);
 	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
 }
@@ -460,7 +460,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	struct cache_entry *ce = istate->cache[pos];
 
 	record_resolve_undo(istate, ce);
-	remove_name_hash(ce);
+	remove_name_hash(istate, ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
@@ -483,7 +483,7 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE)
-			remove_name_hash(ce_array[i]);
+			remove_name_hash(istate, ce_array[i]);
 		else
 			ce_array[j++] = ce_array[i];
 	}
