From: Jeff King <peff@peff.net>
Subject: [PATCH v3 10/22] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 22 Feb 2016 17:44:32 -0500
Message-ID: <20160222224431.GJ10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:44:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzDd-0005B4-M7
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbcBVWog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:44:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:47085 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756085AbcBVWoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:44:34 -0500
Received: (qmail 21692 invoked by uid 102); 22 Feb 2016 22:44:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:34 -0500
Received: (qmail 23068 invoked by uid 107); 22 Feb 2016 22:44:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:32 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286981>

Using FLEX_ARRAY macros reduces the amount of manual
computation size we have to do. It also ensures we don't
overflow size_t, and it makes sure we write the same number
of bytes that we allocated.

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c               |  4 +---
 builtin/blame.c      |  4 +---
 builtin/help.c       |  9 +++------
 builtin/mktree.c     |  9 +++++----
 builtin/reflog.c     |  7 ++-----
 cache-tree.c         |  4 +---
 combine-diff.c       |  4 +---
 diff.c               |  7 ++-----
 dir.c                | 16 +++-------------
 hashmap.c            |  3 +--
 help.c               |  6 ++----
 log-tree.c           |  5 ++---
 name-hash.c          |  3 +--
 ref-filter.c         |  6 ++----
 refs.c               |  6 ++----
 refs/files-backend.c | 19 +++++--------------
 remote.c             |  5 +----
 17 files changed, 35 insertions(+), 82 deletions(-)

diff --git a/attr.c b/attr.c
index c83ec49..6537a43 100644
--- a/attr.c
+++ b/attr.c
@@ -93,9 +93,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 	if (invalid_attr_name(name, len))
 		return NULL;
 
-	a = xmalloc(sizeof(*a) + len + 1);
-	memcpy(a->name, name, len);
-	a->name[len] = 0;
+	FLEX_ALLOC_MEM(a, name, name, len);
 	a->h = hval;
 	a->next = git_attr_hash[pos];
 	a->attr_nr = attr_nr++;
diff --git a/builtin/blame.c b/builtin/blame.c
index b4ed462..e982fb8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -466,13 +466,11 @@ static void queue_blames(struct scoreboard *sb, struct origin *porigin,
 static struct origin *make_origin(struct commit *commit, const char *path)
 {
 	struct origin *o;
-	size_t pathlen = strlen(path) + 1;
-	o = xcalloc(1, sizeof(*o) + pathlen);
+	FLEX_ALLOC_STR(o, path, path);
 	o->commit = commit;
 	o->refcnt = 1;
 	o->next = commit->util;
 	commit->util = o;
-	memcpy(o->path, path, pathlen); /* includes NUL */
 	return o;
 }
 
diff --git a/builtin/help.c b/builtin/help.c
index 1cd0c1e..3c55ce4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -171,12 +171,10 @@ static void exec_man_cmd(const char *cmd, const char *page)
 static void add_man_viewer(const char *name)
 {
 	struct man_viewer_list **p = &man_viewer_list;
-	size_t len = strlen(name);
 
 	while (*p)
 		p = &((*p)->next);
-	*p = xcalloc(1, (sizeof(**p) + len + 1));
-	memcpy((*p)->name, name, len); /* NUL-terminated by xcalloc */
+	FLEX_ALLOC_STR(*p, name, name);
 }
 
 static int supported_man_viewer(const char *name, size_t len)
@@ -190,9 +188,8 @@ static void do_add_man_viewer_info(const char *name,
 				   size_t len,
 				   const char *value)
 {
-	struct man_viewer_info_list *new = xcalloc(1, sizeof(*new) + len + 1);
-
-	memcpy(new->name, name, len); /* NUL-terminated by xcalloc */
+	struct man_viewer_info_list *new;
+	FLEX_ALLOC_MEM(new, name, name, len);
 	new->info = xstrdup(value);
 	new->next = man_viewer_info_list;
 	man_viewer_info_list = new;
diff --git a/builtin/mktree.c b/builtin/mktree.c
index a237caa..4282b62 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -19,16 +19,17 @@ static int alloc, used;
 static void append_to_tree(unsigned mode, unsigned char *sha1, char *path)
 {
 	struct treeent *ent;
-	int len = strlen(path);
+	size_t len = strlen(path);
 	if (strchr(path, '/'))
 		die("path %s contains slash", path);
 
-	ALLOC_GROW(entries, used + 1, alloc);
-	ent = entries[used++] = xmalloc(sizeof(**entries) + len + 1);
+	FLEX_ALLOC_MEM(ent, name, path, len);
 	ent->mode = mode;
 	ent->len = len;
 	hashcpy(ent->sha1, sha1);
-	memcpy(ent->name, path, len+1);
+
+	ALLOC_GROW(entries, used + 1, alloc);
+	entries[used++] = ent;
 }
 
 static int ent_compare(const void *a_, const void *b_)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9980731..2d46b64 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -382,11 +382,9 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 {
 	struct collected_reflog *e;
 	struct collect_reflog_cb *cb = cb_data;
-	size_t namelen = strlen(ref);
 
-	e = xmalloc(sizeof(*e) + namelen + 1);
+	FLEX_ALLOC_STR(e, reflog, ref);
 	hashcpy(e->sha1, oid->hash);
-	memcpy(e->reflog, ref, namelen + 1);
 	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
 	cb->e[cb->nr++] = e;
 	return 0;
@@ -411,8 +409,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 		    ent->pattern[len] == '\0')
 			return ent;
 
-	ent = xcalloc(1, sizeof(*ent) + len + 1);
-	memcpy(ent->pattern, pattern, len);
+	FLEX_ALLOC_MEM(ent, pattern, pattern, len);
 	*reflog_expire_cfg_tail = ent;
 	reflog_expire_cfg_tail = &(ent->next);
 	return ent;
diff --git a/cache-tree.c b/cache-tree.c
index 20ee7b5..3ebf9c3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -79,11 +79,9 @@ static struct cache_tree_sub *find_subtree(struct cache_tree *it,
 	ALLOC_GROW(it->down, it->subtree_nr + 1, it->subtree_alloc);
 	it->subtree_nr++;
 
-	down = xmalloc(sizeof(*down) + pathlen + 1);
+	FLEX_ALLOC_MEM(down, name, path, pathlen);
 	down->cache_tree = NULL;
 	down->namelen = pathlen;
-	memcpy(down->name, path, pathlen);
-	down->name[pathlen] = 0;
 
 	if (pos < it->subtree_nr)
 		memmove(it->down + pos + 1,
diff --git a/combine-diff.c b/combine-diff.c
index 890c415..be09a2b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -319,7 +319,7 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 	if (line[len-1] == '\n')
 		len--;
 
-	lline = xmalloc(sizeof(*lline) + len + 1);
+	FLEX_ALLOC_MEM(lline, line, line, len);
 	lline->len = len;
 	lline->next = NULL;
 	lline->prev = sline->plost.lost_tail;
@@ -330,8 +330,6 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 	sline->plost.lost_tail = lline;
 	sline->plost.len++;
 	lline->parent_map = this_mask;
-	memcpy(lline->line, line, len);
-	lline->line[len] = 0;
 }
 
 struct combine_diff_state {
diff --git a/diff.c b/diff.c
index 2136b69..27d14a7 100644
--- a/diff.c
+++ b/diff.c
@@ -2607,12 +2607,9 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 
 struct diff_filespec *alloc_filespec(const char *path)
 {
-	int namelen = strlen(path);
-	struct diff_filespec *spec = xmalloc(sizeof(*spec) + namelen + 1);
+	struct diff_filespec *spec;
 
-	memset(spec, 0, sizeof(*spec));
-	spec->path = (char *)(spec + 1);
-	memcpy(spec->path, path, namelen+1);
+	FLEXPTR_ALLOC_STR(spec, path, path);
 	spec->count = 1;
 	spec->is_binary = -1;
 	return spec;
diff --git a/dir.c b/dir.c
index 6c627d5..f06ebb7 100644
--- a/dir.c
+++ b/dir.c
@@ -503,12 +503,7 @@ void add_exclude(const char *string, const char *base,
 
 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
 	if (flags & EXC_FLAG_MUSTBEDIR) {
-		char *s;
-		x = xmalloc(sizeof(*x) + patternlen + 1);
-		s = (char *)(x+1);
-		memcpy(s, string, patternlen);
-		s[patternlen] = '\0';
-		x->pattern = s;
+		FLEXPTR_ALLOC_MEM(x, pattern, string, patternlen);
 	} else {
 		x = xmalloc(sizeof(*x));
 		x->pattern = string;
@@ -625,10 +620,7 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 	}
 
 	uc->dir_created++;
-	d = xmalloc(sizeof(*d) + len + 1);
-	memset(d, 0, sizeof(*d));
-	memcpy(d->name, name, len);
-	d->name[len] = '\0';
+	FLEX_ALLOC_MEM(d, name, name, len);
 
 	ALLOC_GROW(dir->dirs, dir->dirs_nr + 1, dir->dirs_alloc);
 	memmove(dir->dirs + first + 1, dir->dirs + first,
@@ -1167,10 +1159,8 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 {
 	struct dir_entry *ent;
 
-	ent = xmalloc(sizeof(*ent) + len + 1);
+	FLEX_ALLOC_MEM(ent, name, pathname, len);
 	ent->len = len;
-	memcpy(ent->name, pathname, len);
-	ent->name[len] = 0;
 	return ent;
 }
 
diff --git a/hashmap.c b/hashmap.c
index f693839..b10b642 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -256,10 +256,9 @@ const void *memintern(const void *data, size_t len)
 	e = hashmap_get(&map, &key, data);
 	if (!e) {
 		/* not found: create it */
-		e = xmallocz(sizeof(struct pool_entry) + len);
+		FLEX_ALLOC_MEM(e, data, data, len);
 		hashmap_entry_init(e, key.ent.hash);
 		e->len = len;
-		memcpy(e->data, data, len);
 		hashmap_add(&map, e);
 	}
 	return e->data;
diff --git a/help.c b/help.c
index d996b34..19328ea 100644
--- a/help.c
+++ b/help.c
@@ -11,11 +11,9 @@
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
-	struct cmdname *ent = xmalloc(sizeof(*ent) + len + 1);
-
+	struct cmdname *ent;
+	FLEX_ALLOC_MEM(ent, name, name, len);
 	ent->len = len;
-	memcpy(ent->name, name, len);
-	ent->name[len] = 0;
 
 	ALLOC_GROW(cmds->names, cmds->cnt + 1, cmds->alloc);
 	cmds->names[cmds->cnt++] = ent;
diff --git a/log-tree.c b/log-tree.c
index f70a30e..60f9839 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -77,9 +77,8 @@ int parse_decorate_color_config(const char *var, const char *slot_name, const ch
 
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
 {
-	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(*res) + nlen + 1);
-	memcpy(res->name, name, nlen + 1);
+	struct name_decoration *res;
+	FLEX_ALLOC_STR(res, name, name);
 	res->type = type;
 	res->next = add_decoration(&name_decoration, obj, res);
 }
diff --git a/name-hash.c b/name-hash.c
index 332ba95..6d9f23e 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -55,10 +55,9 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	dir = find_dir_entry(istate, ce->name, namelen);
 	if (!dir) {
 		/* not found, create it and add to hash table */
-		dir = xcalloc(1, sizeof(struct dir_entry) + namelen + 1);
+		FLEX_ALLOC_MEM(dir, name, ce->name, namelen);
 		hashmap_entry_init(dir, memihash(ce->name, namelen));
 		dir->namelen = namelen;
-		strncpy(dir->name, ce->name, namelen);
 		hashmap_add(&istate->dir_hash, dir);
 
 		/* recursively add missing parent directories */
diff --git a/ref-filter.c b/ref-filter.c
index f097176..9ccfc51 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1255,10 +1255,8 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
 						 int flag)
 {
-	size_t len = strlen(refname);
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
-	memcpy(ref->refname, refname, len);
-	ref->refname[len] = '\0';
+	struct ref_array_item *ref;
+	FLEX_ALLOC_STR(ref, refname, refname);
 	hashcpy(ref->objectname, objectname);
 	ref->flag = flag;
 
diff --git a/refs.c b/refs.c
index 1d9e2a7..2d86445 100644
--- a/refs.c
+++ b/refs.c
@@ -761,10 +761,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
 {
-	size_t len = strlen(refname) + 1;
-	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
-
-	memcpy((char *)update->refname, refname, len); /* includes NUL */
+	struct ref_update *update;
+	FLEX_ALLOC_STR(update, refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b569762..81f68f8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -199,17 +199,14 @@ static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
 					  int check_name)
 {
-	int len;
 	struct ref_entry *ref;
 
 	if (check_name &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
-	len = strlen(refname) + 1;
-	ref = xmalloc(sizeof(struct ref_entry) + len);
+	FLEX_ALLOC_STR(ref, name, refname);
 	hashcpy(ref->u.value.oid.hash, sha1);
 	oidclr(&ref->u.value.peeled);
-	memcpy(ref->name, refname, len);
 	ref->flag = flag;
 	return ref;
 }
@@ -268,9 +265,7 @@ static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
 					  int incomplete)
 {
 	struct ref_entry *direntry;
-	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
-	memcpy(direntry->name, dirname, len);
-	direntry->name[len] = '\0';
+	FLEX_ALLOC_MEM(direntry, name, dirname, len);
 	direntry->u.subdir.ref_cache = ref_cache;
 	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
 	return direntry;
@@ -939,13 +934,10 @@ static void clear_loose_ref_cache(struct ref_cache *refs)
  */
 static struct ref_cache *create_ref_cache(const char *submodule)
 {
-	int len;
 	struct ref_cache *refs;
 	if (!submodule)
 		submodule = "";
-	len = strlen(submodule) + 1;
-	refs = xcalloc(1, sizeof(struct ref_cache) + len);
-	memcpy(refs->name, submodule, len);
+	FLEX_ALLOC_STR(refs, name, submodule);
 	refs->next = submodule_ref_caches;
 	submodule_ref_caches = refs;
 	return refs;
@@ -2197,10 +2189,9 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 	/* Schedule the loose reference for pruning if requested. */
 	if ((cb->flags & PACK_REFS_PRUNE)) {
-		int namelen = strlen(entry->name) + 1;
-		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
+		struct ref_to_prune *n;
+		FLEX_ALLOC_STR(n, name, entry->name);
 		hashcpy(n->sha1, entry->u.value.oid.hash);
-		memcpy(n->name, entry->name, namelen); /* includes NUL */
 		n->next = cb->ref_to_prune;
 		cb->ref_to_prune = n;
 	}
diff --git a/remote.c b/remote.c
index 02e698a..25a960f 100644
--- a/remote.c
+++ b/remote.c
@@ -2136,16 +2136,13 @@ static int one_local_ref(const char *refname, const struct object_id *oid,
 {
 	struct ref ***local_tail = cb_data;
 	struct ref *ref;
-	int len;
 
 	/* we already know it starts with refs/ to get here */
 	if (check_refname_format(refname + 5, 0))
 		return 0;
 
-	len = strlen(refname) + 1;
-	ref = xcalloc(1, sizeof(*ref) + len);
+	ref = alloc_ref(refname);
 	oidcpy(&ref->new_oid, oid);
-	memcpy(ref->name, refname, len);
 	**local_tail = ref;
 	*local_tail = &ref->next;
 	return 0;
-- 
2.7.2.645.g4e1306c
