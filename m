From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Convert "struct cache_entry *" to "const ..." wherever possible
Date: Tue,  9 Jul 2013 22:29:00 +0700
Message-ID: <1373383740-24440-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 17:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwZqi-000551-1w
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 17:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab3GIP27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 11:28:59 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48889 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3GIP26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 11:28:58 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so5697794pac.15
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mPPAFHVsWLK4181kXvrNh7boF8APtunCuRsMXfsVJjg=;
        b=mT7UYdt+A447z6UEylA9Nq0ZUdiexRtXM6kmyo2O80EQYy9Nh2gPFjwRt8w/cbTsxy
         03w4xJp6rCp90lag4r5ZsBeBtUDWd1ji4yutLFYaNYBPixNdWVwsyT4vM/omuEt/8+nA
         vTLpGXJWqxIgUfU9/Xb1be+pXximGwWzLEs5eSZa7eXQ0hIWrOuPUj/TeExrO+3VbVjC
         4IX2766XAf5FWSCuNFBP03T7vBvMwLxTFTZpTmrW4v4bTexrXUMBW8hHWn430vXPjHlV
         Y9YjpqEx30JL/Abk7hHUyzl1x0w5ncHnS5qraivJXfOrYSdeP0zHCCx04q6Cn6ncw/r7
         LQ9g==
X-Received: by 10.68.164.225 with SMTP id yt1mr26491726pbb.195.1373383737772;
        Tue, 09 Jul 2013 08:28:57 -0700 (PDT)
Received: from lanh ([115.73.241.197])
        by mx.google.com with ESMTPSA id vi8sm20234832pbc.31.2013.07.09.08.28.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 08:28:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Jul 2013 22:29:02 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229960>

I attempted to make index_state->cache[] a "const struct cache_entry **=
"
to find out how existing entries in index are modified and where. The
question I have is what do we do if we really need to keep track of on-=
disk
changes in the index. The result is

 - diff-lib.c: setting CE_UPTODATE

 - name-hash.c: setting CE_HASHED

 - preload-index.c, read-cache.c, unpack-trees.c and
   builtin/update-index: obvious

 - entry.c: write_entry() may refresh the checked out entry via
   fill_stat_cache_info(). This causes "non-const struct cache_entry
   *" in builtin/apply.c, builtin/checkout-index.c and
   builtin/checkout.c

 - builtin/ls-files.c: --with-tree changes stagemask and may set
   CE_UPDATE

Of these, write_entry() and its call sites are probably most
interesting because it modifies on-disk info. But this is stat info
and can be retrieved via refresh, at least for porcelain
commands. Other just uses ce_flags for local purposes.

So, keeping track of "dirty" entries is just a matter of setting a
flag in index modification functions exposed by read-cache.c. Except
unpack-trees, the rest of the code base does not do anything funny
behind read-cache's back.

The actual patch is less valueable than the summary above. But if
anyone wants to re-identify the above sites. Applying this patch, then
this:

    diff --git a/cache.h b/cache.h
    index 430d021..1692891 100644
    --- a/cache.h
    +++ b/cache.h
    @@ -267,7 +267,7 @@ static inline unsigned int canon_mode(unsigned =
int mode)
     #define cache_entry_size(len) (offsetof(struct cache_entry,name) +=
 (len) + 1)
   =20
     struct index_state {
    -	struct cache_entry **cache;
    +	const struct cache_entry **cache;
     	unsigned int version;
     	unsigned int cache_nr, cache_alloc, cache_changed;
     	struct string_list *resolve_undo;

will help quickly identify them without bogus warnings.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c        | 13 +++++++------
 builtin/checkout.c     |  8 ++++----
 builtin/clean.c        |  2 +-
 builtin/commit.c       |  2 +-
 builtin/grep.c         |  2 +-
 builtin/ls-files.c     | 12 ++++++------
 builtin/merge-index.c  |  4 ++--
 builtin/merge.c        |  2 +-
 builtin/rm.c           |  6 +++---
 builtin/update-index.c | 14 +++++++-------
 cache-tree.c           | 19 ++++++++++---------
 cache-tree.h           |  2 +-
 cache.h                |  2 +-
 diff.c                 |  2 +-
 dir.c                  |  6 +++---
 entry.c                | 12 +++++++-----
 merge-recursive.c      |  7 ++++---
 pathspec.c             |  4 ++--
 read-cache.c           |  2 +-
 rerere.c               | 12 ++++++------
 resolve-undo.c         |  6 +++---
 revision.c             |  2 +-
 sequencer.c            |  7 ++++---
 sha1_name.c            |  4 ++--
 submodule.c            |  2 +-
 test-dump-cache-tree.c |  4 +++-
 tree.c                 |  2 +-
 unpack-trees.c         | 14 +++++++-------
 wt-status.c            |  4 ++--
 29 files changed, 93 insertions(+), 85 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0e9b631..023bb3a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2999,7 +2999,7 @@ static int read_blob_object(struct strbuf *buf, c=
onst unsigned char *sha1, unsig
 	return 0;
 }
=20
-static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf =
*buf)
+static int read_file_or_gitlink(const struct cache_entry *ce, struct s=
trbuf *buf)
 {
 	if (!ce)
 		return 0;
@@ -3117,7 +3117,7 @@ static struct patch *previous_patch(struct patch =
*patch, int *gone)
 	return previous;
 }
=20
-static int verify_index_match(struct cache_entry *ce, struct stat *st)
+static int verify_index_match(const struct cache_entry *ce, struct sta=
t *st)
 {
 	if (S_ISGITLINK(ce->ce_mode)) {
 		if (!S_ISDIR(st->st_mode))
@@ -3130,7 +3130,7 @@ static int verify_index_match(struct cache_entry =
*ce, struct stat *st)
 #define SUBMODULE_PATCH_WITHOUT_INDEX 1
=20
 static int load_patch_target(struct strbuf *buf,
-			     struct cache_entry *ce,
+			     const struct cache_entry *ce,
 			     struct stat *st,
 			     const char *name,
 			     unsigned expected_mode)
@@ -3160,7 +3160,8 @@ static int load_patch_target(struct strbuf *buf,
  * we read from the result of a previous diff.
  */
 static int load_preimage(struct image *image,
-			 struct patch *patch, struct stat *st, struct cache_entry *ce)
+			 struct patch *patch, struct stat *st,
+			 const struct cache_entry *ce)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	size_t len;
@@ -3273,7 +3274,7 @@ static int load_current(struct image *image, stru=
ct patch *patch)
 }
=20
 static int try_threeway(struct image *image, struct patch *patch,
-			struct stat *st, struct cache_entry *ce)
+			struct stat *st, const struct cache_entry *ce)
 {
 	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
 	struct strbuf buf =3D STRBUF_INIT;
@@ -3343,7 +3344,7 @@ static int try_threeway(struct image *image, stru=
ct patch *patch,
 	return 0;
 }
=20
-static int apply_data(struct patch *patch, struct stat *st, struct cac=
he_entry *ce)
+static int apply_data(struct patch *patch, struct stat *st, const stru=
ct cache_entry *ce)
 {
 	struct image image;
=20
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3be0018..69f9efa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -97,7 +97,7 @@ static int read_tree_some(struct tree *tree, const ch=
ar **pathspec)
 	return 0;
 }
=20
-static int skip_same_name(struct cache_entry *ce, int pos)
+static int skip_same_name(const struct cache_entry *ce, int pos)
 {
 	while (++pos < active_nr &&
 	       !strcmp(active_cache[pos]->name, ce->name))
@@ -105,7 +105,7 @@ static int skip_same_name(struct cache_entry *ce, i=
nt pos)
 	return pos;
 }
=20
-static int check_stage(int stage, struct cache_entry *ce, int pos)
+static int check_stage(int stage, const struct cache_entry *ce, int po=
s)
 {
 	while (pos < active_nr &&
 	       !strcmp(active_cache[pos]->name, ce->name)) {
@@ -119,7 +119,7 @@ static int check_stage(int stage, struct cache_entr=
y *ce, int pos)
 		return error(_("path '%s' does not have their version"), ce->name);
 }
=20
-static int check_stages(unsigned stages, struct cache_entry *ce, int p=
os)
+static int check_stages(unsigned stages, const struct cache_entry *ce,=
 int pos)
 {
 	unsigned seen =3D 0;
 	const char *name =3D ce->name;
@@ -321,7 +321,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
=20
 	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
-		struct cache_entry *ce =3D active_cache[pos];
+		const struct cache_entry *ce =3D active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
diff --git a/builtin/clean.c b/builtin/clean.c
index 04e396b..e344137 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -221,7 +221,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		struct dir_entry *ent =3D dir.entries[i];
 		int len, pos;
 		int matches =3D 0;
-		struct cache_entry *ce;
+		const struct cache_entry *ce;
 		struct stat st;
=20
 		/*
diff --git a/builtin/commit.c b/builtin/commit.c
index 6b693c1..c9cbb81 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -205,7 +205,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
 	}
=20
 	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		struct string_list_item *item;
=20
 		if (ce->ce_flags & CE_UPDATE)
diff --git a/builtin/grep.c b/builtin/grep.c
index 159e65d..0223d70 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -376,7 +376,7 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
 	read_cache();
=20
 	for (nr =3D 0; nr < active_nr; nr++) {
-		struct cache_entry *ce =3D active_cache[nr];
+		const struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
 		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NUL=
L))
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3a410c3..80fff23 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -127,7 +127,7 @@ static void show_killed_files(struct dir_struct *di=
r)
 	}
 }
=20
-static void show_ce_entry(const char *tag, struct cache_entry *ce)
+static void show_ce_entry(const char *tag, const struct cache_entry *c=
e)
 {
 	int len =3D max_prefix_len;
=20
@@ -165,7 +165,7 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 	}
 	write_name(ce->name, ce_namelen(ce));
 	if (debug_mode) {
-		struct stat_data *sd =3D &ce->ce_stat_data;
+		const struct stat_data *sd =3D &ce->ce_stat_data;
=20
 		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
 		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
@@ -203,7 +203,7 @@ static void show_ru_info(void)
 	}
 }
=20
-static int ce_excluded(struct dir_struct *dir, struct cache_entry *ce)
+static int ce_excluded(struct dir_struct *dir, const struct cache_entr=
y *ce)
 {
 	int dtype =3D ce_to_dtype(ce);
 	return is_excluded(dir, ce->name, &dtype);
@@ -223,7 +223,7 @@ static void show_files(struct dir_struct *dir)
 	}
 	if (show_cached || show_stage) {
 		for (i =3D 0; i < active_nr; i++) {
-			struct cache_entry *ce =3D active_cache[i];
+			const struct cache_entry *ce =3D active_cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
 			    !ce_excluded(dir, ce))
 				continue;
@@ -237,7 +237,7 @@ static void show_files(struct dir_struct *dir)
 	}
 	if (show_deleted || show_modified) {
 		for (i =3D 0; i < active_nr; i++) {
-			struct cache_entry *ce =3D active_cache[i];
+			const struct cache_entry *ce =3D active_cache[i];
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
@@ -273,7 +273,7 @@ static void prune_cache(const char *prefix)
 	last =3D active_nr;
 	while (last > first) {
 		int next =3D (last + first) >> 1;
-		struct cache_entry *ce =3D active_cache[next];
+		const struct cache_entry *ce =3D active_cache[next];
 		if (!strncmp(ce->name, prefix, max_prefix_len)) {
 			first =3D next+1;
 			continue;
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index be5e514..b416d92 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -16,7 +16,7 @@ static int merge_entry(int pos, const char *path)
 		die("git merge-index: %s not in the cache", path);
 	found =3D 0;
 	do {
-		struct cache_entry *ce =3D active_cache[pos];
+		const struct cache_entry *ce =3D active_cache[pos];
 		int stage =3D ce_stage(ce);
=20
 		if (strcmp(ce->name, path))
@@ -58,7 +58,7 @@ static void merge_all(void)
 {
 	int i;
 	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
 		i +=3D merge_entry(i, ce->name)-1;
diff --git a/builtin/merge.c b/builtin/merge.c
index 2ebe732..74c0746 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -889,7 +889,7 @@ static int suggest_conflicts(int renormalizing)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	fprintf(fp, "\nConflicts:\n");
 	for (pos =3D 0; pos < active_nr; pos++) {
-		struct cache_entry *ce =3D active_cache[pos];
+		const struct cache_entry *ce =3D active_cache[pos];
=20
 		if (ce_stage(ce)) {
 			fprintf(fp, "\t%s\n", ce->name);
diff --git a/builtin/rm.c b/builtin/rm.c
index 06025a2..18916e0 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -67,7 +67,7 @@ static int check_submodules_use_gitfiles(void)
 	for (i =3D 0; i < list.nr; i++) {
 		const char *name =3D list.entry[i].name;
 		int pos;
-		struct cache_entry *ce;
+		const struct cache_entry *ce;
 		struct stat st;
=20
 		pos =3D cache_name_pos(name, strlen(name));
@@ -120,7 +120,7 @@ static int check_local_mod(unsigned char *head, int=
 index_only)
 	for (i =3D 0; i < list.nr; i++) {
 		struct stat st;
 		int pos;
-		struct cache_entry *ce;
+		const struct cache_entry *ce;
 		const char *name =3D list.entry[i].name;
 		unsigned char sha1[20];
 		unsigned mode;
@@ -321,7 +321,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	seen =3D xcalloc(i, 1);
=20
 	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5c7762e..c317981 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -83,7 +83,7 @@ static int process_lstat_error(const char *path, int =
err)
 	return error("lstat(\"%s\"): %s", path, strerror(errno));
 }
=20
-static int add_one_path(struct cache_entry *old, const char *path, int=
 len, struct stat *st)
+static int add_one_path(const struct cache_entry *old, const char *pat=
h, int len, struct stat *st)
 {
 	int option, size;
 	struct cache_entry *ce;
@@ -142,7 +142,7 @@ static int process_directory(const char *path, int =
len, struct stat *st)
=20
 	/* Exact match: file or existing gitlink */
 	if (pos >=3D 0) {
-		struct cache_entry *ce =3D active_cache[pos];
+		const struct cache_entry *ce =3D active_cache[pos];
 		if (S_ISGITLINK(ce->ce_mode)) {
=20
 			/* Do nothing to the index if there is no HEAD! */
@@ -158,7 +158,7 @@ static int process_directory(const char *path, int =
len, struct stat *st)
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos =3D -pos-1;
 	while (pos < active_nr) {
-		struct cache_entry *ce =3D active_cache[pos++];
+		const struct cache_entry *ce =3D active_cache[pos++];
=20
 		if (strncmp(ce->name, path, len))
 			break;
@@ -183,7 +183,7 @@ static int process_path(const char *path)
 {
 	int pos, len;
 	struct stat st;
-	struct cache_entry *ce;
+	const struct cache_entry *ce;
=20
 	len =3D strlen(path);
 	if (has_symlink_leading_path(path, len))
@@ -448,7 +448,7 @@ static int unresolve_one(const char *path)
 		/* already merged */
 		pos =3D unmerge_cache_entry_at(pos);
 		if (pos < active_nr) {
-			struct cache_entry *ce =3D active_cache[pos];
+			const struct cache_entry *ce =3D active_cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) =3D=3D namelen &&
 			    !memcmp(ce->name, path, namelen))
@@ -462,7 +462,7 @@ static int unresolve_one(const char *path)
 		 */
 		pos =3D -pos-1;
 		if (pos < active_nr) {
-			struct cache_entry *ce =3D active_cache[pos];
+			const struct cache_entry *ce =3D active_cache[pos];
 			if (ce_namelen(ce) =3D=3D namelen &&
 			    !memcmp(ce->name, path, namelen)) {
 				fprintf(stderr,
@@ -558,7 +558,7 @@ static int do_reupdate(int ac, const char **av,
 		has_head =3D 0;
  redo:
 	for (pos =3D 0; pos < active_nr; pos++) {
-		struct cache_entry *ce =3D active_cache[pos];
+		const struct cache_entry *ce =3D active_cache[pos];
 		struct cache_entry *old =3D NULL;
 		int save_nr;
=20
diff --git a/cache-tree.c b/cache-tree.c
index 37e4d00..0bbec43 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -149,7 +149,7 @@ void cache_tree_invalidate_path(struct cache_tree *=
it, const char *path)
 		cache_tree_invalidate_path(down->cache_tree, slash + 1);
 }
=20
-static int verify_cache(struct cache_entry **cache,
+static int verify_cache(const struct cache_entry * const *cache,
 			int entries, int flags)
 {
 	int i, funny;
@@ -158,7 +158,7 @@ static int verify_cache(struct cache_entry **cache,
 	/* Verify that the tree is merged */
 	funny =3D 0;
 	for (i =3D 0; i < entries; i++) {
-		struct cache_entry *ce =3D cache[i];
+		const struct cache_entry *ce =3D cache[i];
 		if (ce_stage(ce)) {
 			if (silent)
 				return -1;
@@ -234,7 +234,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 }
=20
 static int update_one(struct cache_tree *it,
-		      struct cache_entry **cache,
+		      const struct cache_entry * const *cache,
 		      int entries,
 		      const char *base,
 		      int baselen,
@@ -265,7 +265,7 @@ static int update_one(struct cache_tree *it,
 	 */
 	i =3D 0;
 	while (i < entries) {
-		struct cache_entry *ce =3D cache[i];
+		const struct cache_entry *ce =3D cache[i];
 		struct cache_tree_sub *sub;
 		const char *path, *slash;
 		int pathlen, sublen, subcnt, subskip;
@@ -312,7 +312,7 @@ static int update_one(struct cache_tree *it,
=20
 	i =3D 0;
 	while (i < entries) {
-		struct cache_entry *ce =3D cache[i];
+		const struct cache_entry *ce =3D cache[i];
 		struct cache_tree_sub *sub;
 		const char *path, *slash;
 		int pathlen, entlen;
@@ -397,7 +397,7 @@ static int update_one(struct cache_tree *it,
 }
=20
 int cache_tree_update(struct cache_tree *it,
-		      struct cache_entry **cache,
+		      const struct cache_entry * const *cache,
 		      int entries,
 		      int flags)
 {
@@ -599,8 +599,8 @@ int write_cache_as_tree(unsigned char *sha1, int fl=
ags, const char *prefix)
 	was_valid =3D cache_tree_fully_valid(active_cache_tree);
 	if (!was_valid) {
 		if (cache_tree_update(active_cache_tree,
-				      active_cache, active_nr,
-				      flags) < 0)
+				      (const struct cache_entry * const *)active_cache,
+				      active_nr, flags) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <=3D newfd) {
 			if (!write_cache(newfd, active_cache, active_nr) &&
@@ -701,5 +701,6 @@ int update_main_cache_tree(int flags)
 	if (!the_index.cache_tree)
 		the_index.cache_tree =3D cache_tree();
 	return cache_tree_update(the_index.cache_tree,
-				 the_index.cache, the_index.cache_nr, flags);
+				 (const struct cache_entry * const *)the_index.cache,
+				 the_index.cache_nr, flags);
 }
diff --git a/cache-tree.h b/cache-tree.h
index 55d0f59..f1923ad 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -30,7 +30,7 @@ void cache_tree_write(struct strbuf *, struct cache_t=
ree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long s=
ize);
=20
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct cache_tree *, struct cache_entry **, int,=
 int);
+int cache_tree_update(struct cache_tree *, const struct cache_entry * =
const *, int, int);
=20
 int update_main_cache_tree(int);
=20
diff --git a/cache.h b/cache.h
index dd0fb33..430d021 100644
--- a/cache.h
+++ b/cache.h
@@ -476,7 +476,7 @@ extern int remove_file_from_index(struct index_stat=
e *, const char *path);
 extern int add_to_index(struct index_state *, const char *path, struct=
 stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, i=
nt flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const u=
nsigned char *sha1, const char *path, int stage, int refresh);
-extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
+extern int ce_same_name(const struct cache_entry *a, const struct cach=
e_entry *b);
 extern int index_name_is_other(const struct index_state *, const char =
*, int);
 extern void *read_blob_data_from_index(struct index_state *, const cha=
r *, unsigned long *);
=20
diff --git a/diff.c b/diff.c
index 208094f..126abbf 100644
--- a/diff.c
+++ b/diff.c
@@ -2586,7 +2586,7 @@ void fill_filespec(struct diff_filespec *spec, co=
nst unsigned char *sha1,
  */
 static int reuse_worktree_file(const char *name, const unsigned char *=
sha1, int want_file)
 {
-	struct cache_entry *ce;
+	const struct cache_entry *ce;
 	struct stat st;
 	int pos, len;
=20
diff --git a/dir.c b/dir.c
index 897c874..bb1f4e4 100644
--- a/dir.c
+++ b/dir.c
@@ -933,7 +933,7 @@ enum exist_status {
  */
 static enum exist_status directory_exists_in_index_icase(const char *d=
irname, int len)
 {
-	struct cache_entry *ce =3D index_name_exists(&the_index, dirname, len=
 + 1, ignore_case);
+	const struct cache_entry *ce =3D index_name_exists(&the_index, dirnam=
e, len + 1, ignore_case);
 	unsigned char endchar;
=20
 	if (!ce)
@@ -977,7 +977,7 @@ static enum exist_status directory_exists_in_index(=
const char *dirname, int len)
 	if (pos < 0)
 		pos =3D -pos-1;
 	while (pos < active_nr) {
-		struct cache_entry *ce =3D active_cache[pos++];
+		const struct cache_entry *ce =3D active_cache[pos++];
 		unsigned char endchar;
=20
 		if (strncmp(ce->name, dirname, len))
@@ -1115,7 +1115,7 @@ static int exclude_matches_pathspec(const char *p=
ath, int len,
 static int get_index_dtype(const char *path, int len)
 {
 	int pos;
-	struct cache_entry *ce;
+	const struct cache_entry *ce;
=20
 	ce =3D cache_name_exists(path, len, 0);
 	if (ce) {
diff --git a/entry.c b/entry.c
index d7c131d..c6f7fd7 100644
--- a/entry.c
+++ b/entry.c
@@ -79,7 +79,7 @@ static int create_file(const char *path, unsigned int=
 mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
=20
-static void *read_blob_entry(struct cache_entry *ce, unsigned long *si=
ze)
+static void *read_blob_entry(const struct cache_entry *ce, unsigned lo=
ng *size)
 {
 	enum object_type type;
 	void *new =3D read_sha1_file(ce->sha1, &type, size);
@@ -92,7 +92,7 @@ static void *read_blob_entry(struct cache_entry *ce, =
unsigned long *size)
 	return NULL;
 }
=20
-static int open_output_fd(char *path, struct cache_entry *ce, int to_t=
empfile)
+static int open_output_fd(char *path, const struct cache_entry *ce, in=
t to_tempfile)
 {
 	int symlink =3D (ce->ce_mode & S_IFMT) !=3D S_IFREG;
 	if (to_tempfile) {
@@ -115,7 +115,7 @@ static int fstat_output(int fd, const struct checko=
ut *state, struct stat *st)
 	return 0;
 }
=20
-static int streaming_write_entry(struct cache_entry *ce, char *path,
+static int streaming_write_entry(const struct cache_entry *ce, char *p=
ath,
 				 struct stream_filter *filter,
 				 const struct checkout *state, int to_tempfile,
 				 int *fstat_done, struct stat *statbuf)
@@ -136,7 +136,8 @@ static int streaming_write_entry(struct cache_entry=
 *ce, char *path,
 	return result;
 }
=20
-static int write_entry(struct cache_entry *ce, char *path, const struc=
t checkout *state, int to_tempfile)
+static int write_entry(struct cache_entry *ce,
+		       char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt =3D ce->ce_mode & S_IFMT;
 	int fd, ret, fstat_done =3D 0;
@@ -233,7 +234,8 @@ static int check_path(const char *path, int len, st=
ruct stat *st, int skiplen)
 	return lstat(path, st);
 }
=20
-int checkout_entry(struct cache_entry *ce, const struct checkout *stat=
e, char *topath)
+int checkout_entry(struct cache_entry *ce,
+		   const struct checkout *state, char *topath)
 {
 	static char path[PATH_MAX + 1];
 	struct stat st;
diff --git a/merge-recursive.c b/merge-recursive.c
index ea9dbd3..f95933b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -251,7 +251,7 @@ struct tree *write_tree_from_memory(struct merge_op=
tions *o)
 		int i;
 		fprintf(stderr, "BUG: There are unmerged index entries:\n");
 		for (i =3D 0; i < active_nr; i++) {
-			struct cache_entry *ce =3D active_cache[i];
+			const struct cache_entry *ce =3D active_cache[i];
 			if (ce_stage(ce))
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
@@ -264,7 +264,8 @@ struct tree *write_tree_from_memory(struct merge_op=
tions *o)
=20
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0) < 0)
+			      (const struct cache_entry * const *)active_cache,
+			      active_nr, 0) < 0)
 		die(_("error building trees"));
=20
 	result =3D lookup_tree(active_cache_tree->sha1);
@@ -339,7 +340,7 @@ static struct string_list *get_unmerged(void)
 	for (i =3D 0; i < active_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
=20
diff --git a/pathspec.c b/pathspec.c
index 284f397..6ea0867 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -32,7 +32,7 @@ void add_pathspec_matches_against_index(const char **=
pathspec,
 	if (!num_unmatched)
 		return;
 	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
 	}
 }
@@ -67,7 +67,7 @@ const char *check_path_for_gitlink(const char *path)
 {
 	int i, path_len =3D strlen(path);
 	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		if (S_ISGITLINK(ce->ce_mode)) {
 			int ce_len =3D ce_namelen(ce);
 			if (path_len <=3D ce_len || path[ce_len] !=3D '/' ||
diff --git a/read-cache.c b/read-cache.c
index d5201f9..d4474ea 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -722,7 +722,7 @@ struct cache_entry *make_cache_entry(unsigned int m=
ode,
 	return ce;
 }
=20
-int ce_same_name(struct cache_entry *a, struct cache_entry *b)
+int ce_same_name(const struct cache_entry *a, const struct cache_entry=
 *b)
 {
 	int len =3D ce_namelen(a);
 	return ce_namelen(b) =3D=3D len && !memcmp(a->name, b->name, len);
diff --git a/rerere.c b/rerere.c
index 98e3e29..6fde8f9 100644
--- a/rerere.c
+++ b/rerere.c
@@ -299,7 +299,7 @@ static int handle_cache(const char *path, unsigned =
char *sha1, const char *outpu
 {
 	mmfile_t mmfile[3] =3D {{NULL}};
 	mmbuffer_t result =3D {NULL, 0};
-	struct cache_entry *ce;
+	const struct cache_entry *ce;
 	int pos, len, i, hunk_no;
 	struct rerere_io_mem io;
 	int marker_size =3D ll_merge_marker_size(path);
@@ -359,7 +359,7 @@ static int handle_cache(const char *path, unsigned =
char *sha1, const char *outpu
=20
 static int check_one_conflict(int i, int *type)
 {
-	struct cache_entry *e =3D active_cache[i];
+	const struct cache_entry *e =3D active_cache[i];
=20
 	if (!ce_stage(e)) {
 		*type =3D RESOLVED;
@@ -374,8 +374,8 @@ static int check_one_conflict(int i, int *type)
=20
 	/* Only handle regular files with both stages #2 and #3 */
 	if (i + 1 < active_nr) {
-		struct cache_entry *e2 =3D active_cache[i];
-		struct cache_entry *e3 =3D active_cache[i + 1];
+		const struct cache_entry *e2 =3D active_cache[i];
+		const struct cache_entry *e3 =3D active_cache[i + 1];
 		if (ce_stage(e2) =3D=3D 2 &&
 		    ce_stage(e3) =3D=3D 3 &&
 		    ce_same_name(e, e3) &&
@@ -398,7 +398,7 @@ static int find_conflict(struct string_list *confli=
ct)
=20
 	for (i =3D 0; i < active_nr;) {
 		int conflict_type;
-		struct cache_entry *e =3D active_cache[i];
+		const struct cache_entry *e =3D active_cache[i];
 		i =3D check_one_conflict(i, &conflict_type);
 		if (conflict_type =3D=3D THREE_STAGED)
 			string_list_insert(conflict, (const char *)e->name);
@@ -414,7 +414,7 @@ int rerere_remaining(struct string_list *merge_rr)
=20
 	for (i =3D 0; i < active_nr;) {
 		int conflict_type;
-		struct cache_entry *e =3D active_cache[i];
+		const struct cache_entry *e =3D active_cache[i];
 		i =3D check_one_conflict(i, &conflict_type);
 		if (conflict_type =3D=3D PUNTED)
 			string_list_insert(merge_rr, (const char *)e->name);
diff --git a/resolve-undo.c b/resolve-undo.c
index 639eb9c..77101f5 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -115,7 +115,7 @@ void resolve_undo_clear_index(struct index_state *i=
state)
=20
 int unmerge_index_entry_at(struct index_state *istate, int pos)
 {
-	struct cache_entry *ce;
+	const struct cache_entry *ce;
 	struct string_list_item *item;
 	struct resolve_undo_info *ru;
 	int i, err =3D 0, matched;
@@ -167,7 +167,7 @@ void unmerge_marked_index(struct index_state *istat=
e)
 		return;
=20
 	for (i =3D 0; i < istate->cache_nr; i++) {
-		struct cache_entry *ce =3D istate->cache[i];
+		const struct cache_entry *ce =3D istate->cache[i];
 		if (ce->ce_flags & CE_MATCHED)
 			i =3D unmerge_index_entry_at(istate, i);
 	}
@@ -181,7 +181,7 @@ void unmerge_index(struct index_state *istate, cons=
t char **pathspec)
 		return;
=20
 	for (i =3D 0; i < istate->cache_nr; i++) {
-		struct cache_entry *ce =3D istate->cache[i];
+		const struct cache_entry *ce =3D istate->cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL))
 			continue;
 		i =3D unmerge_index_entry_at(istate, i);
diff --git a/revision.c b/revision.c
index 2f0142f..84ccc05 100644
--- a/revision.c
+++ b/revision.c
@@ -1358,7 +1358,7 @@ static void prepare_show_merge(struct rev_info *r=
evs)
 	if (!active_nr)
 		read_cache();
 	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
 		if (ce_path_match(ce, &revs->prune_data)) {
diff --git a/sequencer.c b/sequencer.c
index 425207a..351548f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -331,7 +331,7 @@ static int do_recursive_merge(struct commit *base, =
struct commit *next,
 		int i;
 		strbuf_addstr(msgbuf, "\nConflicts:\n");
 		for (i =3D 0; i < active_nr;) {
-			struct cache_entry *ce =3D active_cache[i++];
+			const struct cache_entry *ce =3D active_cache[i++];
 			if (ce_stage(ce)) {
 				strbuf_addch(msgbuf, '\t');
 				strbuf_addstr(msgbuf, ce->name);
@@ -371,8 +371,9 @@ static int is_index_unchanged(void)
 		active_cache_tree =3D cache_tree();
=20
 	if (!cache_tree_fully_valid(active_cache_tree))
-		if (cache_tree_update(active_cache_tree, active_cache,
-				  active_nr, 0))
+		if (cache_tree_update(active_cache_tree,
+				      (const struct cache_entry * const *)active_cache,
+				      active_nr, 0))
 			return error(_("Unable to update cache tree\n"));
=20
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sh=
a1);
diff --git a/sha1_name.c b/sha1_name.c
index 90419ef..86e8a5c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1234,7 +1234,7 @@ static void diagnose_invalid_index_path(int stage=
,
 					const char *filename)
 {
 	struct stat st;
-	struct cache_entry *ce;
+	const struct cache_entry *ce;
 	int pos;
 	unsigned namelen =3D strlen(filename);
 	unsigned fullnamelen;
@@ -1328,7 +1328,7 @@ static int get_sha1_with_context_1(const char *na=
me,
 	 */
 	if (name[0] =3D=3D ':') {
 		int stage =3D 0;
-		struct cache_entry *ce;
+		const struct cache_entry *ce;
 		char *new_path =3D NULL;
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] =3D=3D '/') {
diff --git a/submodule.c b/submodule.c
index 8685424..4045d53 100644
--- a/submodule.c
+++ b/submodule.c
@@ -623,7 +623,7 @@ int fetch_populated_submodules(const struct argv_ar=
ray *options,
 		struct strbuf submodule_path =3D STRBUF_INIT;
 		struct strbuf submodule_git_dir =3D STRBUF_INIT;
 		struct strbuf submodule_prefix =3D STRBUF_INIT;
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		const char *git_dir, *name, *default_argv;
=20
 		if (!S_ISGITLINK(ce->ce_mode))
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index a6ffdf3..47eab97 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -59,6 +59,8 @@ int main(int ac, char **av)
 	struct cache_tree *another =3D cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_update(another, active_cache, active_nr, WRITE_TREE_DRY_RU=
N);
+	cache_tree_update(another,
+			  (const struct cache_entry * const *)active_cache,
+			  active_nr, WRITE_TREE_DRY_RUN);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
diff --git a/tree.c b/tree.c
index 62fed63..c0e568c 100644
--- a/tree.c
+++ b/tree.c
@@ -159,7 +159,7 @@ int read_tree(struct tree *tree, int stage, struct =
pathspec *match)
 	 * sort at the end.
 	 */
 	for (i =3D 0; !fn && i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
 		if (ce_stage(ce) =3D=3D stage)
 			fn =3D read_one_entry;
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
index b27f2a6..bf01717 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -179,7 +179,7 @@ static void display_error_msgs(struct unpack_trees_=
options *o)
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
-static void unlink_entry(struct cache_entry *ce)
+static void unlink_entry(const struct cache_entry *ce)
 {
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
@@ -199,7 +199,7 @@ static int check_updates(struct unpack_trees_option=
s *o)
=20
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
-			struct cache_entry *ce =3D index->cache[cnt];
+			const struct cache_entry *ce =3D index->cache[cnt];
 			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
 				total++;
 		}
@@ -212,7 +212,7 @@ static int check_updates(struct unpack_trees_option=
s *o)
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
 	for (i =3D 0; i < index->cache_nr; i++) {
-		struct cache_entry *ce =3D index->cache[i];
+		const struct cache_entry *ce =3D index->cache[i];
=20
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
@@ -376,7 +376,7 @@ static struct cache_entry *next_cache_entry(struct =
unpack_trees_options *o)
 	return NULL;
 }
=20
-static void add_same_unmerged(struct cache_entry *ce,
+static void add_same_unmerged(const struct cache_entry *ce,
 			      struct unpack_trees_options *o)
 {
 	struct index_state *index =3D o->src_index;
@@ -650,7 +650,7 @@ static int find_cache_pos(struct traverse_info *inf=
o,
 	int p_len =3D tree_entry_len(p);
=20
 	for (pos =3D o->cache_bottom; pos < index->cache_nr; pos++) {
-		struct cache_entry *ce =3D index->cache[pos];
+		const struct cache_entry *ce =3D index->cache[pos];
 		const char *ce_name, *ce_slash;
 		int cmp, ce_len;
=20
@@ -1353,7 +1353,7 @@ static int verify_clean_subdirectory(const struct=
 cache_entry *ce,
  */
 static int icase_exists(struct unpack_trees_options *o, const char *na=
me, int len, struct stat *st)
 {
-	struct cache_entry *src;
+	const struct cache_entry *src;
=20
 	src =3D index_name_exists(o->src_index, name, len, 1);
 	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_V=
ALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
@@ -1364,7 +1364,7 @@ static int check_ok_to_remove(const char *name, i=
nt len, int dtype,
 			      enum unpack_trees_error_types error_type,
 			      struct unpack_trees_options *o)
 {
-	struct cache_entry *result;
+	const struct cache_entry *result;
=20
 	/*
 	 * It may be that the 'lstat()' succeeded even though
diff --git a/wt-status.c b/wt-status.c
index b191c65..08aba7c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -371,7 +371,7 @@ static void wt_status_collect_changed_cb(struct dif=
f_queue_struct *q,
 static int unmerged_mask(const char *path)
 {
 	int pos, mask;
-	struct cache_entry *ce;
+	const struct cache_entry *ce;
=20
 	pos =3D cache_name_pos(path, strlen(path));
 	if (0 <=3D pos)
@@ -475,7 +475,7 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
 	for (i =3D 0; i < active_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
-		struct cache_entry *ce =3D active_cache[i];
+		const struct cache_entry *ce =3D active_cache[i];
=20
 		if (!ce_path_match(ce, &pathspec))
 			continue;
--=20
1.8.2.83.gc99314b
