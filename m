From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] rename gitlink to dirlink.
Date: Tue, 22 May 2007 13:39:20 +0200
Message-ID: <20070522113920.GI5412@admingilde.org>
References: <20070521200828.GC5412@admingilde.org> <e7bda7770705211612w3ce1b7dew8d48f1ddeb7d100e@mail.gmail.com> <7vodkdbvmk.fsf@assigned-by-dhcp.cox.net> <20070522055939.GG5412@admingilde.org> <7vd50t9y92.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torgil Svensson <torgil.svensson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 13:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqSiC-0002hH-CT
	for gcvg-git@gmane.org; Tue, 22 May 2007 13:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810AbXEVLjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 07:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759230AbXEVLjX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 07:39:23 -0400
Received: from mail.admingilde.org ([213.95.32.147]:50624 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810AbXEVLjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 07:39:22 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HqSi0-0003h4-OH; Tue, 22 May 2007 13:39:20 +0200
Content-Disposition: inline
In-Reply-To: <7vd50t9y92.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48094>

Unify naming of plumbing dirlink/gitlink concept:

perl -pi -e 's/gitlink/dirlink/g'

Signed-off-by: Martin Waitz <tali@admingilde.org>
---

On Mon, May 21, 2007 at 11:19:05PM -0700, Junio C Hamano wrote:
> > But then we also should be consequent and rename the entire
> > low-level plumbing to dirlink.  I don't see a reason to keep
> > both.
> 
> Ok.  Let's do that then before it is too late.

now you can choose which one you want to apply...

 builtin-ls-files.c     |    2 +-
 builtin-update-index.c |   14 +++++++-------
 diff.c                 |    4 ++--
 dir.c                  |   10 +++++-----
 entry.c                |    2 +-
 list-objects.c         |   10 +++++-----
 read-cache.c           |    6 +++---
 refs.c                 |   12 ++++++------
 refs.h                 |    4 ++--
 sha1_file.c            |    2 +-
 tree.c                 |    2 +-
 11 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f7c066b..ad0267b 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -97,7 +97,7 @@ static void show_other_files(struct dir_struct *dir)
 	 *
 	 * (Matching entries are normally pruned during
 	 * the directory tree walk, but will show up for
-	 * gitlinks because we don't necessarily have
+	 * dirlinks because we don't necessarily have
 	 * dir->show_other_directories set to suppress
 	 * them).
 	 */
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 8f98991..7fe2466 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -106,7 +106,7 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 /*
  * Handle a path that was a directory. Four cases:
  *
- *  - it's already a gitlink in the index, and we keep it that
+ *  - it's already a dirlink in the index, and we keep it that
  *    way, and update it if we can (if we cannot find the HEAD,
  *    we're going to keep it unchanged in the index!)
  *
@@ -124,20 +124,20 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
  *    to try to update it as a directory.
  *
  *  - it doesn't exist at all in the index, but it is a valid
- *    git directory, and it should be *added* as a gitlink.
+ *    git directory, and it should be *added* as a dirlink.
  */
 static int process_directory(const char *path, int len, struct stat *st)
 {
 	unsigned char sha1[20];
 	int pos = cache_name_pos(path, len);
 
-	/* Exact match: file or existing gitlink */
+	/* Exact match: file or existing dirlink */
 	if (pos >= 0) {
 		struct cache_entry *ce = active_cache[pos];
 		if (S_ISDIRLNK(ntohl(ce->ce_mode))) {
 
 			/* Do nothing to the index if there is no HEAD! */
-			if (resolve_gitlink_ref(path, "HEAD", sha1) < 0)
+			if (resolve_dirlink_ref(path, "HEAD", sha1) < 0)
 				return 0;
 
 			return add_one_path(ce, path, len, st);
@@ -162,8 +162,8 @@ static int process_directory(const char *path, int len, struct stat *st)
 		return error("%s: is a directory - add individual files instead", path);
 	}
 
-	/* No match - should we add it as a gitlink? */
-	if (!resolve_gitlink_ref(path, "HEAD", sha1))
+	/* No match - should we add it as a dirlink? */
+	if (!resolve_dirlink_ref(path, "HEAD", sha1))
 		return add_one_path(NULL, path, len, st);
 
 	/* Error out. */
@@ -179,7 +179,7 @@ static int process_file(const char *path, int len, struct stat *st)
 	struct cache_entry *ce = pos < 0 ? NULL : active_cache[pos];
 
 	if (ce && S_ISDIRLNK(ntohl(ce->ce_mode)))
-		return error("%s is already a gitlink, not replacing", path);
+		return error("%s is already a dirlink, not replacing", path);
 
 	return add_one_path(ce, path, len, st);
 }
diff --git a/diff.c b/diff.c
index 33297aa..434947e 100644
--- a/diff.c
+++ b/diff.c
@@ -1432,7 +1432,7 @@ static int populate_from_stdin(struct diff_filespec *s)
 	return 0;
 }
 
-static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
+static int diff_populate_dirlink(struct diff_filespec *s, int size_only)
 {
 	int len;
 	char *data = xmalloc(100);
@@ -1468,7 +1468,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		return 0;
 
 	if (S_ISDIRLNK(s->mode))
-		return diff_populate_gitlink(s, size_only);
+		return diff_populate_dirlink(s, size_only);
 
 	if (!s->sha1_valid ||
 	    reuse_worktree_file(s->path, s->sha1, 0)) {
diff --git a/dir.c b/dir.c
index 11fab7f..1f17fc7 100644
--- a/dir.c
+++ b/dir.c
@@ -300,7 +300,7 @@ enum exist_status {
 
 /*
  * The index sorts alphabetically by entry name, which
- * means that a gitlink sorts as '\0' at the end, while
+ * means that a dirlink sorts as '\0' at the end, while
  * a directory (which is defined not as an entry, but as
  * the files it contains) will sort with the '/' at the
  * end.
@@ -343,8 +343,8 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  * directory name, we always recurse into the directory to see
  * all the files.
  *
- * Case 2: If we *already* have that directory name as a gitlink,
- * we always continue to see it as a gitlink, regardless of whether
+ * Case 2: If we *already* have that directory name as a dirlink,
+ * we always continue to see it as a dirlink, regardless of whether
  * there is an actual git directory there or not (it might not
  * be checked out as a subproject!)
  *
@@ -356,7 +356,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  *      also true and the directory is empty, in which case
  *      we just ignore it entirely.
  *  (b) if it looks like a git directory, and we don't have
- *      'no_dirlinks' set we treat it as a gitlink, and show it
+ *      'no_dirlinks' set we treat it as a dirlink, and show it
  *      as a directory.
  *  (c) otherwise, we recurse into it.
  */
@@ -385,7 +385,7 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 			break;
 		if (!dir->no_dirlinks) {
 			unsigned char sha1[20];
-			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
+			if (resolve_dirlink_ref(dirname, "HEAD", sha1) == 0)
 				return show_directory;
 		}
 		return recurse_into_directory;
diff --git a/entry.c b/entry.c
index 82bf725..db66663 100644
--- a/entry.c
+++ b/entry.c
@@ -193,7 +193,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 */
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
+			/* If it is a dirlink, leave it alone! */
 			if (S_ISDIRLNK(ntohl(ce->ce_mode)))
 				return 0;
 			if (!state->force)
diff --git a/list-objects.c b/list-objects.c
index 310f8d3..8027e02 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -26,7 +26,7 @@ static void process_blob(struct rev_info *revs,
 }
 
 /*
- * Processing a gitlink entry currently does nothing, since
+ * Processing a dirlink entry currently does nothing, since
  * we do not recurse into the subproject.
  *
  * We *could* eventually add a flag that actually does that,
@@ -34,20 +34,20 @@ static void process_blob(struct rev_info *revs,
  *  - is the subproject actually checked out?
  *  - if so, see if the subproject has already been added
  *    to the alternates list, and add it if not.
- *  - process the commit (or tag) the gitlink points to
+ *  - process the commit (or tag) the dirlink points to
  *    recursively.
  *
  * However, it's unclear whether there is really ever any
  * reason to see superprojects and subprojects as such a
  * "unified" object pool (potentially resulting in a totally
  * humongous pack - avoiding which was the whole point of
- * having gitlinks in the first place!).
+ * having dirlinks in the first place!).
  *
  * So for now, there is just a note that we *could* follow
  * the link, and how to do it. Whether it necessarily makes
  * any sense what-so-ever to ever do that is another issue.
  */
-static void process_gitlink(struct rev_info *revs,
+static void process_dirlink(struct rev_info *revs,
 			    const unsigned char *sha1,
 			    struct object_array *p,
 			    struct name_path *path,
@@ -88,7 +88,7 @@ static void process_tree(struct rev_info *revs,
 				     lookup_tree(entry.sha1),
 				     p, &me, entry.path);
 		else if (S_ISDIRLNK(entry.mode))
-			process_gitlink(revs, entry.sha1,
+			process_dirlink(revs, entry.sha1,
 					p, &me, entry.path);
 		else
 			process_blob(revs,
diff --git a/read-cache.c b/read-cache.c
index d9f46da..3aa92a4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -86,7 +86,7 @@ static int ce_compare_link(struct cache_entry *ce, size_t expected_size)
 	return match;
 }
 
-static int ce_compare_gitlink(struct cache_entry *ce)
+static int ce_compare_dirlink(struct cache_entry *ce)
 {
 	unsigned char sha1[20];
 
@@ -98,7 +98,7 @@ static int ce_compare_gitlink(struct cache_entry *ce)
 	 *
 	 * If so, we consider it always to match.
 	 */
-	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
+	if (resolve_dirlink_ref(ce->name, "HEAD", sha1) < 0)
 		return 0;
 	return hashcmp(sha1, ce->sha1);
 }
@@ -145,7 +145,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	case S_IFDIRLNK:
 		if (!S_ISDIR(st->st_mode))
 			changed |= TYPE_CHANGED;
-		else if (ce_compare_gitlink(ce))
+		else if (ce_compare_dirlink(ce))
 			changed |= DATA_CHANGED;
 		return changed;
 	default:
diff --git a/refs.c b/refs.c
index 89876bf..ee79329 100644
--- a/refs.c
+++ b/refs.c
@@ -285,7 +285,7 @@ static struct ref_list *get_loose_refs(void)
 #define MAXDEPTH 5
 #define MAXREFLEN (1024)
 
-static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refname, unsigned char *result)
+static int resolve_dirlink_packed_ref(char *name, int pathlen, const char *refname, unsigned char *result)
 {
 	FILE *f;
 	struct cached_refs refs;
@@ -312,7 +312,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 	return retval;
 }
 
-static int resolve_gitlink_ref_recursive(char *name, int pathlen, const char *refname, unsigned char *result, int recursion)
+static int resolve_dirlink_ref_recursive(char *name, int pathlen, const char *refname, unsigned char *result, int recursion)
 {
 	int fd, len = strlen(refname);
 	char buffer[128], *p;
@@ -322,7 +322,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen, const char *re
 	memcpy(name + pathlen, refname, len+1);
 	fd = open(name, O_RDONLY);
 	if (fd < 0)
-		return resolve_gitlink_packed_ref(name, pathlen, refname, result);
+		return resolve_dirlink_packed_ref(name, pathlen, refname, result);
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
@@ -343,10 +343,10 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen, const char *re
 	while (isspace(*p))
 		p++;
 
-	return resolve_gitlink_ref_recursive(name, pathlen, p, result, recursion+1);
+	return resolve_dirlink_ref_recursive(name, pathlen, p, result, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *result)
+int resolve_dirlink_ref(const char *path, const char *refname, unsigned char *result)
 {
 	int len = strlen(path), retval;
 	char *gitdir;
@@ -359,7 +359,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 	memcpy(gitdir, path, len);
 	memcpy(gitdir + len, "/.git/", 7);
 
-	retval = resolve_gitlink_ref_recursive(gitdir, len+6, refname, result, 0);
+	retval = resolve_dirlink_ref_recursive(gitdir, len+6, refname, result, 0);
 	free(gitdir);
 	return retval;
 }
diff --git a/refs.h b/refs.h
index f61f6d9..5cbb711 100644
--- a/refs.h
+++ b/refs.h
@@ -60,7 +60,7 @@ extern int check_ref_format(const char *target);
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-/** resolve ref in nested "gitlink" repository */
-extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);
+/** resolve ref in nested "dirlink" repository */
+extern int resolve_dirlink_ref(const char *name, const char *refname, unsigned char *result);
 
 #endif /* REFS_H */
diff --git a/sha1_file.c b/sha1_file.c
index be991ed..c37fbed 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2393,7 +2393,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 		free(target);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", sha1);
+		return resolve_dirlink_ref(path, "HEAD", sha1);
 	default:
 		return error("%s: unsupported file type", path);
 	}
diff --git a/tree.c b/tree.c
index e4a39aa..d8014eb 100644
--- a/tree.c
+++ b/tree.c
@@ -141,7 +141,7 @@ struct tree *lookup_tree(const unsigned char *sha1)
 
 /*
  * NOTE! Tree refs to external git repositories
- * (ie gitlinks) do not count as real references.
+ * (ie dirlinks) do not count as real references.
  *
  * You don't have to have those repositories
  * available at all, much less have the objects
-- 
1.5.0.3


-- 
Martin Waitz
