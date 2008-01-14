From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 11:39:17 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801141132250.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
 <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org> <7vr6glnrvp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801140902140.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEVBK-0006dO-PI
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 20:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbYANTkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 14:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbYANTkp
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 14:40:45 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40884 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702AbYANTkn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2008 14:40:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0EJdIOw019329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2008 11:39:19 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0EJdHrK010788;
	Mon, 14 Jan 2008 11:39:17 -0800
In-Reply-To: <alpine.LFD.1.00.0801140902140.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-1.521 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_54,J_CHICKENPOX_64,J_CHICKENPOX_66,J_CHICKENPOX_71
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70470>



On Mon, 14 Jan 2008, Linus Torvalds wrote:
> 
> So I think this patch is good, but I think it would be even better if we 
> just bit the bullet and started looking at having a different in-memory 
> representation from the on-disk one.

Ok, so here's a possible patch.

It passes all the tests for me, and looks fairly ok, but it's also a bit 
big.

What makes it big is that I made the in-memory format be in host order, so 
that we can remove a *lot* of the "htonl/ntohl" switcheroo, and do it just 
on index file read/write.

The nice thing about this patch is that it would make it a lot easier to 
do any index handling changes,  because it makes a clear difference 
between the on-disk and the in-memory formats.

I realize that the patch looks big (195 lines inserted and 148 lines 
removed), but *most* of the lines are literally those ntohl() 
simplifications, ie stuff like

	-       if (S_ISGITLINK(ntohl(ce->ce_mode))) {
	+       if (S_ISGITLINK(ce->ce_mode)) {

so while it adds lines (for the "convert from disk" and "convert to disk" 
format conversions), in  many ways it really simplifies the source code 
too.

Comments?

This is on top of current master, so it's *before* junios thing that adds 
a CE_UPTODATE.

With this, the high 16 bits of "ce_flags" are in-memory only, so you could 
just make CE_UPTODATE be 0x10000, and it automatically ends up never being 
written to disk (and always "reads" as zero).

		Linus

---
 builtin-apply.c        |   10 ++--
 builtin-blame.c        |    2 +-
 builtin-fsck.c         |    2 +-
 builtin-grep.c         |    4 +-
 builtin-ls-files.c     |   10 ++--
 builtin-read-tree.c    |    2 +-
 builtin-rerere.c       |    4 +-
 builtin-update-index.c |   18 +++---
 cache-tree.c           |    2 +-
 cache.h                |   41 +++++++----
 diff-lib.c             |   31 ++++-----
 dir.c                  |    2 +-
 entry.c                |    6 +-
 merge-index.c          |    2 +-
 merge-recursive.c      |    2 +-
 reachable.c            |    2 +-
 read-cache.c           |  183 ++++++++++++++++++++++++++++-------------------
 sha1_name.c            |    2 +-
 tree.c                 |    4 +-
 unpack-trees.c         |   14 ++--
 20 files changed, 195 insertions(+), 148 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index d57bb6e..bd7cc37 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1946,7 +1946,7 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 	if (!ce)
 		return 0;
 
-	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
+	if (S_ISGITLINK(ce->ce_mode)) {
 		strbuf_grow(buf, 100);
 		strbuf_addf(buf, "Subproject commit %s\n", sha1_to_hex(ce->sha1));
 	} else {
@@ -2023,7 +2023,7 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 
 static int verify_index_match(struct cache_entry *ce, struct stat *st)
 {
-	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
+	if (S_ISGITLINK(ce->ce_mode)) {
 		if (!S_ISDIR(st->st_mode))
 			return -1;
 		return 0;
@@ -2082,12 +2082,12 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 				return error("%s: does not match index",
 					     old_name);
 			if (cached)
-				st_mode = ntohl(ce->ce_mode);
+				st_mode = ce->ce_mode;
 		} else if (stat_ret < 0)
 			return error("%s: %s", old_name, strerror(errno));
 
 		if (!cached)
-			st_mode = ntohl(ce_mode_from_stat(ce, st.st_mode));
+			st_mode = ce_mode_from_stat(ce, st.st_mode);
 
 		if (patch->is_new < 0)
 			patch->is_new = 0;
@@ -2388,7 +2388,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = htons(namelen);
+	ce->ce_flags = namelen;
 	if (S_ISGITLINK(mode)) {
 		const char *s = buf;
 
diff --git a/builtin-blame.c b/builtin-blame.c
index 9b4c02e..c7e6887 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2092,7 +2092,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	if (!mode) {
 		int pos = cache_name_pos(path, len);
 		if (0 <= pos)
-			mode = ntohl(active_cache[pos]->ce_mode);
+			mode = active_cache[pos]->ce_mode;
 		else
 			/* Let's not bother reading from HEAD tree */
 			mode = S_IFREG | 0644;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index e4874f6..8876d34 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -762,7 +762,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			struct blob *blob;
 			struct object *obj;
 
-			mode = ntohl(active_cache[i]->ce_mode);
+			mode = active_cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
 				continue;
 			blob = lookup_blob(active_cache[i]->sha1);
diff --git a/builtin-grep.c b/builtin-grep.c
index 0d6cc73..9180b39 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -331,7 +331,7 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 		struct cache_entry *ce = active_cache[i];
 		char *name;
 		int kept;
-		if (!S_ISREG(ntohl(ce->ce_mode)))
+		if (!S_ISREG(ce->ce_mode))
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
@@ -387,7 +387,7 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 
 	for (nr = 0; nr < active_nr; nr++) {
 		struct cache_entry *ce = active_cache[nr];
-		if (!S_ISREG(ntohl(ce->ce_mode)))
+		if (!S_ISREG(ce->ce_mode))
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 0f0ab2d..d56e33e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -189,7 +189,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		return;
 
 	if (tag && *tag && show_valid_bit &&
-	    (ce->ce_flags & htons(CE_VALID))) {
+	    (ce->ce_flags & CE_VALID)) {
 		static char alttag[4];
 		memcpy(alttag, tag, 3);
 		if (isalpha(tag[0]))
@@ -210,7 +210,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	} else {
 		printf("%s%06o %s %d\t",
 		       tag,
-		       ntohl(ce->ce_mode),
+		       ce->ce_mode,
 		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
 				: sha1_to_hex(ce->sha1),
 		       ce_stage(ce));
@@ -242,7 +242,7 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
-			if (ce->ce_flags & htons(CE_UPDATE))
+			if (ce->ce_flags & CE_UPDATE)
 				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
@@ -350,7 +350,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 		struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		ce->ce_flags |= htons(CE_STAGEMASK);
+		ce->ce_flags |= CE_STAGEMASK;
 	}
 
 	if (prefix) {
@@ -379,7 +379,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 			 */
 			if (last_stage0 &&
 			    !strcmp(last_stage0->name, ce->name))
-				ce->ce_flags |= htons(CE_UPDATE);
+				ce->ce_flags |= CE_UPDATE;
 		}
 	}
 }
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 43cd56a..eb879e1 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -46,7 +46,7 @@ static int read_cache_unmerged(void)
 			cache_tree_invalidate_path(active_cache_tree, ce->name);
 			last = ce;
 			ce->ce_mode = 0;
-			ce->ce_flags &= ~htons(CE_STAGEMASK);
+			ce->ce_flags &= ~CE_STAGEMASK;
 		}
 		*dst++ = ce;
 	}
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 37e6248..df1a55d 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -149,8 +149,8 @@ static int find_conflict(struct path_list *conflict)
 		if (ce_stage(e2) == 2 &&
 		    ce_stage(e3) == 3 &&
 		    ce_same_name(e2, e3) &&
-		    S_ISREG(ntohl(e2->ce_mode)) &&
-		    S_ISREG(ntohl(e3->ce_mode))) {
+		    S_ISREG(e2->ce_mode) &&
+		    S_ISREG(e3->ce_mode)) {
 			path_list_insert((const char *)e2->name, conflict);
 			i++; /* skip over both #2 and #3 */
 		}
diff --git a/builtin-update-index.c b/builtin-update-index.c
index e1a938d..b5a34ed 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -47,10 +47,10 @@ static int mark_valid(const char *path)
 	if (0 <= pos) {
 		switch (mark_valid_only) {
 		case MARK_VALID:
-			active_cache[pos]->ce_flags |= htons(CE_VALID);
+			active_cache[pos]->ce_flags |= CE_VALID;
 			break;
 		case UNMARK_VALID:
-			active_cache[pos]->ce_flags &= ~htons(CE_VALID);
+			active_cache[pos]->ce_flags &= ~CE_VALID;
 			break;
 		}
 		cache_tree_invalidate_path(active_cache_tree, path);
@@ -95,7 +95,7 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = htons(len);
+	ce->ce_flags = len;
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
@@ -139,7 +139,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
 		struct cache_entry *ce = active_cache[pos];
-		if (S_ISGITLINK(ntohl(ce->ce_mode))) {
+		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
 			if (resolve_gitlink_ref(path, "HEAD", sha1) < 0)
@@ -183,7 +183,7 @@ static int process_file(const char *path, int len, struct stat *st)
 	int pos = cache_name_pos(path, len);
 	struct cache_entry *ce = pos < 0 ? NULL : active_cache[pos];
 
-	if (ce && S_ISGITLINK(ntohl(ce->ce_mode)))
+	if (ce && S_ISGITLINK(ce->ce_mode))
 		return error("%s is already a gitlink, not replacing", path);
 
 	return add_one_path(ce, path, len, st);
@@ -226,7 +226,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	ce->ce_flags = create_ce_flags(len, stage);
 	ce->ce_mode = create_ce_mode(mode);
 	if (assume_unchanged)
-		ce->ce_flags |= htons(CE_VALID);
+		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
@@ -246,14 +246,14 @@ static void chmod_path(int flip, const char *path)
 	if (pos < 0)
 		goto fail;
 	ce = active_cache[pos];
-	mode = ntohl(ce->ce_mode);
+	mode = ce->ce_mode;
 	if (!S_ISREG(mode))
 		goto fail;
 	switch (flip) {
 	case '+':
-		ce->ce_mode |= htonl(0111); break;
+		ce->ce_mode |= 0111; break;
 	case '-':
-		ce->ce_mode &= htonl(~0111); break;
+		ce->ce_mode &= ~0111; break;
 	default:
 		goto fail;
 	}
diff --git a/cache-tree.c b/cache-tree.c
index 50b3526..3ef5f87 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -320,7 +320,7 @@ static int update_one(struct cache_tree *it,
 		}
 		else {
 			sha1 = ce->sha1;
-			mode = ntohl(ce->ce_mode);
+			mode = ce->ce_mode;
 			entlen = pathlen - baselen;
 		}
 		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
diff --git a/cache.h b/cache.h
index 39331c2..0aed11e 100644
--- a/cache.h
+++ b/cache.h
@@ -94,17 +94,31 @@ struct cache_time {
  * We save the fields in big-endian order to allow using the
  * index file over NFS transparently.
  */
+struct ondisk_cache_entry {
+	struct cache_time ctime;
+	struct cache_time mtime;
+	unsigned int dev;
+	unsigned int ino;
+	unsigned int mode;
+	unsigned int uid;
+	unsigned int gid;
+	unsigned int size;
+	unsigned char sha1[20];
+	unsigned short flags;
+	char name[FLEX_ARRAY]; /* more */
+};
+
 struct cache_entry {
-	struct cache_time ce_ctime;
-	struct cache_time ce_mtime;
+	unsigned int ce_ctime;
+	unsigned int ce_mtime;
 	unsigned int ce_dev;
 	unsigned int ce_ino;
 	unsigned int ce_mode;
 	unsigned int ce_uid;
 	unsigned int ce_gid;
 	unsigned int ce_size;
+	unsigned int ce_flags;
 	unsigned char sha1[20];
-	unsigned short ce_flags;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -114,28 +128,29 @@ struct cache_entry {
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
-#define create_ce_flags(len, stage) htons((len) | ((stage) << CE_STAGESHIFT))
-#define ce_namelen(ce) (CE_NAMEMASK & ntohs((ce)->ce_flags))
+#define create_ce_flags(len, stage) ((len) | ((stage) << CE_STAGESHIFT))
+#define ce_namelen(ce) (CE_NAMEMASK & (ce)->ce_flags)
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
-#define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
+#define ondisk_ce_size(ce) ondisk_cache_entry_size(ce_namelen(ce))
+#define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
 
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
 {
 	if (S_ISLNK(mode))
-		return htonl(S_IFLNK);
+		return S_IFLNK;
 	if (S_ISDIR(mode) || S_ISGITLINK(mode))
-		return htonl(S_IFGITLINK);
-	return htonl(S_IFREG | ce_permissions(mode));
+		return S_IFGITLINK;
+	return S_IFREG | ce_permissions(mode);
 }
 static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned int mode)
 {
 	extern int trust_executable_bit, has_symlinks;
 	if (!has_symlinks && S_ISREG(mode) &&
-	    ce && S_ISLNK(ntohl(ce->ce_mode)))
+	    ce && S_ISLNK(ce->ce_mode))
 		return ce->ce_mode;
 	if (!trust_executable_bit && S_ISREG(mode)) {
-		if (ce && S_ISREG(ntohl(ce->ce_mode)))
+		if (ce && S_ISREG(ce->ce_mode))
 			return ce->ce_mode;
 		return create_ce_mode(0666);
 	}
@@ -146,14 +161,14 @@ static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned in
 	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
+#define ondisk_cache_entry_size(len) ((offsetof(struct ondisk_cache_entry,name) + (len) + 8) & ~7)
 
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int cache_nr, cache_alloc, cache_changed;
 	struct cache_tree *cache_tree;
 	time_t timestamp;
-	void *mmap;
-	size_t mmap_size;
+	void *alloc;
 };
 
 extern struct index_state the_index;
diff --git a/diff-lib.c b/diff-lib.c
index d85d8f3..c20adaa 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -37,7 +37,7 @@ static int get_mode(const char *path, int *mode)
 	if (!path || !strcmp(path, "/dev/null"))
 		*mode = 0;
 	else if (!strcmp(path, "-"))
-		*mode = ntohl(create_ce_mode(0666));
+		*mode = create_ce_mode(0666);
 	else if (stat(path, &st))
 		return error("Could not access '%s'", path);
 	else
@@ -384,7 +384,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					continue;
 			}
 			else
-				dpath->mode = ntohl(ce_mode_from_stat(ce, st.st_mode));
+				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
 
 			while (i < entries) {
 				struct cache_entry *nce = active_cache[i];
@@ -398,10 +398,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				 */
 				stage = ce_stage(nce);
 				if (2 <= stage) {
-					int mode = ntohl(nce->ce_mode);
+					int mode = nce->ce_mode;
 					num_compare_stages++;
 					hashcpy(dpath->parent[stage-2].sha1, nce->sha1);
-					dpath->parent[stage-2].mode = ntohl(ce_mode_from_stat(nce, mode));
+					dpath->parent[stage-2].mode = ce_mode_from_stat(nce, mode);
 					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
 				}
@@ -442,15 +442,15 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			}
 			if (silent_on_removed)
 				continue;
-			diff_addremove(&revs->diffopt, '-', ntohl(ce->ce_mode),
+			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
 				       ce->sha1, ce->name, NULL);
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, ce_option);
 		if (!changed && !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 			continue;
-		oldmode = ntohl(ce->ce_mode);
-		newmode = ntohl(ce_mode_from_stat(ce, st.st_mode));
+		oldmode = ce->ce_mode;
+		newmode = ce_mode_from_stat(ce, st.st_mode);
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
 			    ce->name, NULL);
@@ -471,7 +471,7 @@ static void diff_index_show_file(struct rev_info *revs,
 				 struct cache_entry *ce,
 				 unsigned char *sha1, unsigned int mode)
 {
-	diff_addremove(&revs->diffopt, prefix[0], ntohl(mode),
+	diff_addremove(&revs->diffopt, prefix[0], mode,
 		       sha1, ce->name, NULL);
 }
 
@@ -550,14 +550,14 @@ static int show_modified(struct rev_info *revs,
 		p->len = pathlen;
 		memcpy(p->path, new->name, pathlen);
 		p->path[pathlen] = 0;
-		p->mode = ntohl(mode);
+		p->mode = mode;
 		hashclr(p->sha1);
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
-		p->parent[0].mode = ntohl(new->ce_mode);
+		p->parent[0].mode = new->ce_mode;
 		hashcpy(p->parent[0].sha1, new->sha1);
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
-		p->parent[1].mode = ntohl(old->ce_mode);
+		p->parent[1].mode = old->ce_mode;
 		hashcpy(p->parent[1].sha1, old->sha1);
 		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
 		free(p);
@@ -569,9 +569,6 @@ static int show_modified(struct rev_info *revs,
 	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 		return 0;
 
-	mode = ntohl(mode);
-	oldmode = ntohl(oldmode);
-
 	diff_change(&revs->diffopt, oldmode, mode,
 		    old->sha1, sha1, old->name, NULL);
 	return 0;
@@ -628,7 +625,7 @@ static int diff_cache(struct rev_info *revs,
 					   cached, match_missing))
 				break;
 			diff_unmerge(&revs->diffopt, ce->name,
-				     ntohl(ce->ce_mode), ce->sha1);
+				     ce->ce_mode, ce->sha1);
 			break;
 		case 3:
 			diff_unmerge(&revs->diffopt, ce->name,
@@ -664,7 +661,7 @@ static void mark_merge_entries(void)
 		struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		ce->ce_flags |= htons(CE_STAGEMASK);
+		ce->ce_flags |= CE_STAGEMASK;
 	}
 }
 
@@ -723,7 +720,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 						   ce->name);
 			last = ce;
 			ce->ce_mode = 0;
-			ce->ce_flags &= ~htons(CE_STAGEMASK);
+			ce->ce_flags &= ~CE_STAGEMASK;
 		}
 		*dst++ = ce;
 	}
diff --git a/dir.c b/dir.c
index 3e345c2..1b9cc7a 100644
--- a/dir.c
+++ b/dir.c
@@ -391,7 +391,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 			break;
 		if (endchar == '/')
 			return index_directory;
-		if (!endchar && S_ISGITLINK(ntohl(ce->ce_mode)))
+		if (!endchar && S_ISGITLINK(ce->ce_mode))
 			return index_gitdir;
 	}
 	return index_nonexistent;
diff --git a/entry.c b/entry.c
index 257ab46..44f4b89 100644
--- a/entry.c
+++ b/entry.c
@@ -103,7 +103,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	int fd;
 	long wrote;
 
-	switch (ntohl(ce->ce_mode) & S_IFMT) {
+	switch (ce->ce_mode & S_IFMT) {
 		char *new;
 		struct strbuf buf;
 		unsigned long size;
@@ -129,7 +129,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 			strcpy(path, ".merge_file_XXXXXX");
 			fd = mkstemp(path);
 		} else
-			fd = create_file(path, ntohl(ce->ce_mode));
+			fd = create_file(path, ce->ce_mode);
 		if (fd < 0) {
 			free(new);
 			return error("git-checkout-index: unable to create file %s (%s)",
@@ -221,7 +221,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
 			/* If it is a gitlink, leave it alone! */
-			if (S_ISGITLINK(ntohl(ce->ce_mode)))
+			if (S_ISGITLINK(ce->ce_mode))
 				return 0;
 			if (!state->force)
 				return error("%s is a directory", path);
diff --git a/merge-index.c b/merge-index.c
index fa719cb..bbb700b 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -48,7 +48,7 @@ static int merge_entry(int pos, const char *path)
 			break;
 		found++;
 		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
-		sprintf(ownbuf[stage], "%o", ntohl(ce->ce_mode));
+		sprintf(ownbuf[stage], "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
diff --git a/merge-recursive.c b/merge-recursive.c
index b34177d..0db0b3a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -333,7 +333,7 @@ static struct path_list *get_unmerged(void)
 			item->util = xcalloc(1, sizeof(struct stage_data));
 		}
 		e = item->util;
-		e->stages[ce_stage(ce)].mode = ntohl(ce->ce_mode);
+		e->stages[ce_stage(ce)].mode = ce->ce_mode;
 		hashcpy(e->stages[ce_stage(ce)].sha, ce->sha1);
 	}
 
diff --git a/reachable.c b/reachable.c
index 6383401..00f289f 100644
--- a/reachable.c
+++ b/reachable.c
@@ -176,7 +176,7 @@ static void add_cache_refs(struct rev_info *revs)
 		 * lookup_blob() on them, to avoid populating the hash table
 		 * with invalid information
 		 */
-		if (S_ISGITLINK(ntohl(active_cache[i]->ce_mode)))
+		if (S_ISGITLINK(active_cache[i]->ce_mode))
 			continue;
 
 		lookup_blob(active_cache[i]->sha1);
diff --git a/read-cache.c b/read-cache.c
index 7db5588..4414a40 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -30,20 +30,16 @@ struct index_state the_index;
  */
 void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
-	ce->ce_ctime.sec = htonl(st->st_ctime);
-	ce->ce_mtime.sec = htonl(st->st_mtime);
-#ifdef USE_NSEC
-	ce->ce_ctime.nsec = htonl(st->st_ctim.tv_nsec);
-	ce->ce_mtime.nsec = htonl(st->st_mtim.tv_nsec);
-#endif
-	ce->ce_dev = htonl(st->st_dev);
-	ce->ce_ino = htonl(st->st_ino);
-	ce->ce_uid = htonl(st->st_uid);
-	ce->ce_gid = htonl(st->st_gid);
-	ce->ce_size = htonl(st->st_size);
+	ce->ce_ctime = st->st_ctime;
+	ce->ce_mtime = st->st_mtime;
+	ce->ce_dev = st->st_dev;
+	ce->ce_ino = st->st_ino;
+	ce->ce_uid = st->st_uid;
+	ce->ce_gid = st->st_gid;
+	ce->ce_size = st->st_size;
 
 	if (assume_unchanged)
-		ce->ce_flags |= htons(CE_VALID);
+		ce->ce_flags |= CE_VALID;
 }
 
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
@@ -116,7 +112,7 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 			return DATA_CHANGED;
 		break;
 	case S_IFDIR:
-		if (S_ISGITLINK(ntohl(ce->ce_mode)))
+		if (S_ISGITLINK(ce->ce_mode))
 			return 0;
 	default:
 		return TYPE_CHANGED;
@@ -128,14 +124,14 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
 
-	switch (ntohl(ce->ce_mode) & S_IFMT) {
+	switch (ce->ce_mode & S_IFMT) {
 	case S_IFREG:
 		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
 		/* We consider only the owner x bit to be relevant for
 		 * "mode changes"
 		 */
 		if (trust_executable_bit &&
-		    (0100 & (ntohl(ce->ce_mode) ^ st->st_mode)))
+		    (0100 & (ce->ce_mode ^ st->st_mode)))
 			changed |= MODE_CHANGED;
 		break;
 	case S_IFLNK:
@@ -152,29 +148,17 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	case 0: /* Special case: unmerged file in index */
 		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
 	default:
-		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
+		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
-	if (ce->ce_mtime.sec != htonl(st->st_mtime))
+	if (ce->ce_mtime != (unsigned int) st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (ce->ce_ctime.sec != htonl(st->st_ctime))
+	if (ce->ce_ctime != (unsigned int) st->st_ctime)
 		changed |= CTIME_CHANGED;
 
-#ifdef USE_NSEC
-	/*
-	 * nsec seems unreliable - not all filesystems support it, so
-	 * as long as it is in the inode cache you get right nsec
-	 * but after it gets flushed, you get zero nsec.
-	 */
-	if (ce->ce_mtime.nsec != htonl(st->st_mtim.tv_nsec))
-		changed |= MTIME_CHANGED;
-	if (ce->ce_ctime.nsec != htonl(st->st_ctim.tv_nsec))
-		changed |= CTIME_CHANGED;
-#endif
-
-	if (ce->ce_uid != htonl(st->st_uid) ||
-	    ce->ce_gid != htonl(st->st_gid))
+	if (ce->ce_uid != (unsigned int) st->st_uid ||
+	    ce->ce_gid != (unsigned int) st->st_gid)
 		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != htonl(st->st_ino))
+	if (ce->ce_ino != (unsigned int) st->st_ino)
 		changed |= INODE_CHANGED;
 
 #ifdef USE_STDEV
@@ -183,11 +167,11 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (ce->ce_dev != htonl(st->st_dev))
+	if (ce->ce_dev != (unsigned int) st->st_dev)
 		changed |= INODE_CHANGED;
 #endif
 
-	if (ce->ce_size != htonl(st->st_size))
+	if (ce->ce_size != (unsigned int) st->st_size)
 		changed |= DATA_CHANGED;
 
 	return changed;
@@ -205,7 +189,7 @@ int ie_match_stat(struct index_state *istate,
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
 	 */
-	if (!ignore_valid && (ce->ce_flags & htons(CE_VALID)))
+	if (!ignore_valid && (ce->ce_flags & CE_VALID))
 		return 0;
 
 	changed = ce_match_stat_basic(ce, st);
@@ -228,7 +212,7 @@ int ie_match_stat(struct index_state *istate,
 	 */
 	if (!changed &&
 	    istate->timestamp &&
-	    istate->timestamp <= ntohl(ce->ce_mtime.sec)) {
+	    istate->timestamp <= ce->ce_mtime) {
 		if (assume_racy_is_modified)
 			changed |= DATA_CHANGED;
 		else
@@ -320,7 +304,7 @@ int index_name_pos(struct index_state *istate, const char *name, int namelen)
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = istate->cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ntohs(ce->ce_flags));
+		int cmp = cache_name_compare(name, namelen, ce->name, ce->ce_flags);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -405,7 +389,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
-	ce->ce_flags = htons(namelen);
+	ce->ce_flags = namelen;
 	fill_stat_cache_info(ce, &st);
 
 	if (trust_executable_bit && has_symlinks)
@@ -616,7 +600,7 @@ static int has_dir_name(struct index_state *istate,
 		}
 		len = slash - name;
 
-		pos = index_name_pos(istate, name, ntohs(create_ce_flags(len, stage)));
+		pos = index_name_pos(istate, name, create_ce_flags(len, stage));
 		if (pos >= 0) {
 			/*
 			 * Found one, but not so fast.  This could
@@ -704,7 +688,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 
 	cache_tree_invalidate_path(istate->cache_tree, ce->name);
-	pos = index_name_pos(istate, ce->name, ntohs(ce->ce_flags));
+	pos = index_name_pos(istate, ce->name, ce->ce_flags);
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
@@ -736,7 +720,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		if (!ok_to_replace)
 			return error("'%s' appears as both a file and as a directory",
 				     ce->name);
-		pos = index_name_pos(istate, ce->name, ntohs(ce->ce_flags));
+		pos = index_name_pos(istate, ce->name, ce->ce_flags);
 		pos = -pos-1;
 	}
 	return pos + 1;
@@ -810,7 +794,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		 * valid again, under "assume unchanged" mode.
 		 */
 		if (ignore_valid && assume_unchanged &&
-		    !(ce->ce_flags & htons(CE_VALID)))
+		    !(ce->ce_flags & CE_VALID))
 			; /* mark this one VALID again */
 		else
 			return ce;
@@ -826,7 +810,6 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	updated = xmalloc(size);
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
-
 	/*
 	 * If ignore_valid is not set, we should leave CE_VALID bit
 	 * alone.  Otherwise, paths marked with --no-assume-unchanged
@@ -834,8 +817,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	 * automatically, which is not really what we want.
 	 */
 	if (!ignore_valid && assume_unchanged &&
-	    !(ce->ce_flags & htons(CE_VALID)))
-		updated->ce_flags &= ~htons(CE_VALID);
+	    !(ce->ce_flags & CE_VALID))
+		updated->ce_flags &= ~CE_VALID;
 
 	return updated;
 }
@@ -880,7 +863,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
-				ce->ce_flags &= ~htons(CE_VALID);
+				ce->ce_flags &= ~CE_VALID;
 				istate->cache_changed = 1;
 			}
 			if (quiet)
@@ -942,16 +925,34 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
+static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_entry *ce)
+{
+	ce->ce_ctime = ntohl(ondisk->ctime.sec);
+	ce->ce_mtime = ntohl(ondisk->mtime.sec);
+	ce->ce_dev   = ntohl(ondisk->dev);
+	ce->ce_ino   = ntohl(ondisk->ino);
+	ce->ce_mode  = ntohl(ondisk->mode);
+	ce->ce_uid   = ntohl(ondisk->uid);
+	ce->ce_gid   = ntohl(ondisk->gid);
+	ce->ce_size  = ntohl(ondisk->size);
+	/* On-disk flags are just 16 bits */
+	ce->ce_flags = ntohs(ondisk->flags);
+	hashcpy(ce->sha1, ondisk->sha1);
+	memcpy(ce->name, ondisk->name, ce_namelen(ce)+1);
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
 	int fd, i;
 	struct stat st;
-	unsigned long offset;
+	unsigned long src_offset, dst_offset;
 	struct cache_header *hdr;
+	void *mmap;
+	size_t mmap_size;
 
 	errno = EBUSY;
-	if (istate->mmap)
+	if (istate->alloc)
 		return istate->cache_nr;
 
 	errno = ENOENT;
@@ -967,31 +968,47 @@ int read_index_from(struct index_state *istate, const char *path)
 		die("cannot stat the open index (%s)", strerror(errno));
 
 	errno = EINVAL;
-	istate->mmap_size = xsize_t(st.st_size);
-	if (istate->mmap_size < sizeof(struct cache_header) + 20)
+	mmap_size = xsize_t(st.st_size);
+	if (mmap_size < sizeof(struct cache_header) + 20)
 		die("index file smaller than expected");
 
-	istate->mmap = xmmap(NULL, istate->mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	close(fd);
+	if (mmap == MAP_FAILED)
+		die("unable to map index file");
 
-	hdr = istate->mmap;
-	if (verify_hdr(hdr, istate->mmap_size) < 0)
+	hdr = mmap;
+	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
 
-	offset = sizeof(*hdr);
+	/*
+	 * The disk format is actually larger than the in-memory format,
+	 * due to space for nsec etc, so even though the in-memory one
+	 * has room for a few  more flags, we can allocate using the same
+	 * index size
+	 */
+	istate->alloc = xmalloc(mmap_size);
+
+	src_offset = sizeof(*hdr);
+	dst_offset = 0;
 	for (i = 0; i < istate->cache_nr; i++) {
+		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
 
-		ce = (struct cache_entry *)((char *)(istate->mmap) + offset);
-		offset = offset + ce_size(ce);
+		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		ce = (struct cache_entry *)((char *)istate->alloc + dst_offset);
+		convert_from_disk(disk_ce, ce);
 		istate->cache[i] = ce;
+
+		src_offset += ondisk_ce_size(ce);
+		dst_offset += ce_size(ce);
 	}
 	istate->timestamp = st.st_mtime;
-	while (offset <= istate->mmap_size - 20 - 8) {
+	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
 		 * sections, each of which is prefixed with
@@ -999,40 +1016,36 @@ int read_index_from(struct index_state *istate, const char *path)
 		 * in 4-byte network byte order.
 		 */
 		unsigned long extsize;
-		memcpy(&extsize, (char *)(istate->mmap) + offset + 4, 4);
+		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
 		extsize = ntohl(extsize);
 		if (read_index_extension(istate,
-					 ((const char *) (istate->mmap)) + offset,
-					 (char *) (istate->mmap) + offset + 8,
+					 (const char *) mmap + src_offset,
+					 (char *) mmap + src_offset + 8,
 					 extsize) < 0)
 			goto unmap;
-		offset += 8;
-		offset += extsize;
+		src_offset += 8;
+		src_offset += extsize;
 	}
+	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
 unmap:
-	munmap(istate->mmap, istate->mmap_size);
+	munmap(mmap, mmap_size);
 	errno = EINVAL;
 	die("index file corrupt");
 }
 
 int discard_index(struct index_state *istate)
 {
-	int ret;
-
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
 	istate->timestamp = 0;
 	cache_tree_free(&(istate->cache_tree));
-	if (istate->mmap == NULL)
-		return 0;
-	ret = munmap(istate->mmap, istate->mmap_size);
-	istate->mmap = NULL;
-	istate->mmap_size = 0;
+	free(istate->alloc);
+	istate->alloc = NULL;
 
 	/* no need to throw away allocated active_cache */
-	return ret;
+	return 0;
 }
 
 #define WRITE_BUFFER_SIZE 8192
@@ -1148,6 +1161,28 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	}
 }
 
+static int ce_write_entry(SHA_CTX *c, int fd, struct cache_entry *ce)
+{
+	int size = ondisk_ce_size(ce);
+	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
+
+	ondisk->ctime.sec = htonl(ce->ce_ctime);
+	ondisk->ctime.nsec = 0;
+	ondisk->mtime.sec = htonl(ce->ce_mtime);
+	ondisk->mtime.nsec = 0;
+	ondisk->dev  = htonl(ce->ce_dev);
+	ondisk->ino  = htonl(ce->ce_ino);
+	ondisk->mode = htonl(ce->ce_mode);
+	ondisk->uid  = htonl(ce->ce_uid);
+	ondisk->gid  = htonl(ce->ce_gid);
+	ondisk->size = htonl(ce->ce_size);
+	hashcpy(ondisk->sha1, ce->sha1);
+	ondisk->flags = htons(ce->ce_flags);
+	memcpy(ondisk->name, ce->name, ce_namelen(ce));
+
+	return ce_write(c, fd, ondisk, size);
+}
+
 int write_index(struct index_state *istate, int newfd)
 {
 	SHA_CTX c;
@@ -1173,9 +1208,9 @@ int write_index(struct index_state *istate, int newfd)
 		if (!ce->ce_mode)
 			continue;
 		if (istate->timestamp &&
-		    istate->timestamp <= ntohl(ce->ce_mtime.sec))
+		    istate->timestamp <= ce->ce_mtime)
 			ce_smudge_racily_clean_entry(ce);
-		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
+		if (ce_write_entry(&c, newfd, ce) < 0)
 			return -1;
 	}
 
diff --git a/sha1_name.c b/sha1_name.c
index 13e1164..be8489e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -695,7 +695,7 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 				break;
 			if (ce_stage(ce) == stage) {
 				hashcpy(sha1, ce->sha1);
-				*mode = ntohl(ce->ce_mode);
+				*mode = ce->ce_mode;
 				return 0;
 			}
 			pos++;
diff --git a/tree.c b/tree.c
index 8c0819f..87708ef 100644
--- a/tree.c
+++ b/tree.c
@@ -142,8 +142,8 @@ static int cmp_cache_name_compare(const void *a_, const void *b_)
 
 	ce1 = *((const struct cache_entry **)a_);
 	ce2 = *((const struct cache_entry **)b_);
-	return cache_name_compare(ce1->name, ntohs(ce1->ce_flags),
-				  ce2->name, ntohs(ce2->ce_flags));
+	return cache_name_compare(ce1->name, ce1->ce_flags,
+				  ce2->name, ce2->ce_flags);
 }
 
 int read_tree(struct tree *tree, int stage, const char **match)
diff --git a/unpack-trees.c b/unpack-trees.c
index aa2513e..9205320 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -289,7 +289,7 @@ static struct checkout state;
 static void check_updates(struct cache_entry **src, int nr,
 			struct unpack_trees_options *o)
 {
-	unsigned short mask = htons(CE_UPDATE);
+	unsigned short mask = CE_UPDATE;
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
 	char last_symlink[PATH_MAX];
@@ -408,7 +408,7 @@ static void verify_uptodate(struct cache_entry *ce,
 		 * submodules that are marked to be automatically
 		 * checked out.
 		 */
-		if (S_ISGITLINK(ntohl(ce->ce_mode)))
+		if (S_ISGITLINK(ce->ce_mode))
 			return;
 		errno = 0;
 	}
@@ -450,7 +450,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	int cnt = 0;
 	unsigned char sha1[20];
 
-	if (S_ISGITLINK(ntohl(ce->ce_mode)) &&
+	if (S_ISGITLINK(ce->ce_mode) &&
 	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
 		/* If we are not going to update the submodule, then
 		 * we don't care.
@@ -580,7 +580,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		struct unpack_trees_options *o)
 {
-	merge->ce_flags |= htons(CE_UPDATE);
+	merge->ce_flags |= CE_UPDATE;
 	if (old) {
 		/*
 		 * See if we can re-use the old CE directly?
@@ -601,7 +601,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		invalidate_ce_path(merge);
 	}
 
-	merge->ce_flags &= ~htons(CE_STAGEMASK);
+	merge->ce_flags &= ~CE_STAGEMASK;
 	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	return 1;
 }
@@ -634,7 +634,7 @@ static void show_stage_entry(FILE *o,
 	else
 		fprintf(o, "%s%06o %s %d\t%s\n",
 			label,
-			ntohl(ce->ce_mode),
+			ce->ce_mode,
 			sha1_to_hex(ce->sha1),
 			ce_stage(ce),
 			ce->name);
@@ -920,7 +920,7 @@ int oneway_merge(struct cache_entry **src,
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ce_match_stat(old, &st, CE_MATCH_IGNORE_VALID))
-				old->ce_flags |= htons(CE_UPDATE);
+				old->ce_flags |= CE_UPDATE;
 		}
 		return keep_entry(old, o);
 	}
