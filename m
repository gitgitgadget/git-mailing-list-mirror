From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Optimize symlink/directory detection
Date: Fri, 9 May 2008 09:21:07 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805090911480.3142@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0805090856350.3142@woody.linux-foundation.org> <alpine.LFD.1.10.0805090904100.3142@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 09 18:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuVNW-0005KG-2V
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 18:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764998AbYEIQW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 12:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764977AbYEIQWZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 12:22:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47746 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764869AbYEIQWR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2008 12:22:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m49GL8N1024862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 May 2008 09:21:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m49GL7Xu014962;
	Fri, 9 May 2008 09:21:08 -0700
In-Reply-To: <alpine.LFD.1.10.0805090904100.3142@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81621>


This is the base for making symlink detection in the middle fo a pathname 
saner and (much) more efficient.

Under various loads, we want to verify that the full path leading up to a 
filename is a real directory tree, and that when we successfully do an 
'lstat()' on a filename, we don't get a false positive due to a symlink in 
the middle of the path that git should have seen as a symlink, not as a 
normal path component.

The 'has_symlink_leading_path()' function already did this, and cached 
a single level of symlink information, but didn't cache the _lack_ of a 
symlink, so the normal behaviour was actually the wrong way around, and we 
ended up doing an 'lstat()' on each path component to check that it was a 
real directory.

This caches the last detected full directory and symlink entries, and 
speeds up especially deep directory structures a lot by avoiding to 
lstat() all the directories leading up to each entry in the index.
    
[ This can - and should - probably be extended upon so that we eventually 
  never do a bare 'lstat()' on any path entries at *all* when checking the 
  index, but always check the full path carefully. Right now we do not 
  generally check the whole path for all our normal quick index 
  revalidation.

  We should also make sure that we're careful about all the invalidation, 
  ie when we remove a link and replace it by a directory we should 
  invalidate the symlink cache if it matches (and vice versa for the 
  directory cache).

  But regardless, the basic function needs to be sane to do that. The old
  'has_symlink_leading_path()' was not capable enough - or indeed the code
  readable enough - to really do that sanely. So I'm pushing this as not 
  just an optimization, but as a base for further work. ]

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

 builtin-apply.c |    2 +-
 cache.h         |    2 +-
 diff-lib.c      |   10 +++---
 symlinks.c      |   82 +++++++++++++++++++++++++++++++++----------------------
 unpack-trees.c  |   12 +++-----
 5 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index caa3f2a..1103625 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2247,7 +2247,7 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		 * In such a case, path "new_name" does not exist as
 		 * far as git is concerned.
 		 */
-		if (has_symlink_leading_path(new_name, NULL))
+		if (has_symlink_leading_path(strlen(new_name), new_name))
 			return 0;
 
 		return error("%s: already exists in working directory", new_name);
diff --git a/cache.h b/cache.h
index 4803b03..0d9d9e2 100644
--- a/cache.h
+++ b/cache.h
@@ -598,7 +598,7 @@ struct checkout {
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
-extern int has_symlink_leading_path(const char *name, char *last_symlink);
+extern int has_symlink_leading_path(int len, const char *name);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/diff-lib.c b/diff-lib.c
index 9139e45..9966d99 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -341,14 +341,14 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
  * See if work tree has an entity that can be staged.  Return 0 if so,
  * return 1 if not and return -1 if error.
  */
-static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st, char *symcache)
+static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st)
 {
 	if (lstat(ce->name, st) < 0) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			return -1;
 		return 1;
 	}
-	if (has_symlink_leading_path(ce->name, symcache))
+	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
@@ -402,7 +402,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
 
-			changed = check_work_tree_entity(ce, &st, symcache);
+			changed = check_work_tree_entity(ce, &st);
 			if (!changed)
 				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
@@ -466,7 +466,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (ce_uptodate(ce))
 			continue;
 
-		changed = check_work_tree_entity(ce, &st, symcache);
+		changed = check_work_tree_entity(ce, &st);
 		if (changed) {
 			if (changed < 0) {
 				perror(ce->name);
@@ -527,7 +527,7 @@ static int get_stat_data(struct cache_entry *ce,
 	if (!cached) {
 		int changed;
 		struct stat st;
-		changed = check_work_tree_entity(ce, &st, cbdata->symcache);
+		changed = check_work_tree_entity(ce, &st);
 		if (changed < 0)
 			return -1;
 		else if (changed) {
diff --git a/symlinks.c b/symlinks.c
index be9ace6..5a5e781 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,48 +1,64 @@
 #include "cache.h"
 
-int has_symlink_leading_path(const char *name, char *last_symlink)
-{
+struct pathname {
+	int len;
 	char path[PATH_MAX];
-	const char *sp, *ep;
-	char *dp;
-
-	sp = name;
-	dp = path;
-
-	if (last_symlink && *last_symlink) {
-		size_t last_len = strlen(last_symlink);
-		size_t len = strlen(name);
-		if (last_len < len &&
-		    !strncmp(name, last_symlink, last_len) &&
-		    name[last_len] == '/')
-			return 1;
-		*last_symlink = '\0';
+};
+
+/* Return matching pathname prefix length, or zero if not matching */
+static inline int match_pathname(int len, const char *name, struct pathname *match)
+{
+	int match_len = match->len;
+	return (len > match_len &&
+		name[match_len] == '/' &&
+		!memcmp(name, match->path, match_len)) ? match_len : 0;
+}
+
+static inline void set_pathname(int len, const char *name, struct pathname *match)
+{
+	if (len < PATH_MAX) {
+		match->len = len;
+		memcpy(match->path, name, len);
+		match->path[len] = 0;
 	}
+}
+
+int has_symlink_leading_path(int len, const char *name)
+{
+	static struct pathname link, nonlink;
+	char path[PATH_MAX];
+	struct stat st;
+	char *sp;
+	int known_dir;
 
-	while (1) {
-		size_t len;
-		struct stat st;
+	/*
+	 * See if the last known symlink cache matches.
+	 */
+	if (match_pathname(len, name, &link))
+		return 1;
 
-		ep = strchr(sp, '/');
-		if (!ep)
-			break;
-		len = ep - sp;
-		if (PATH_MAX <= dp + len - path + 2)
-			return 0; /* new name is longer than that??? */
-		memcpy(dp, sp, len);
-		dp[len] = 0;
+	/*
+	 * Get rid of the last known directory part
+	 */
+	known_dir = match_pathname(len, name, &nonlink);
+
+	while ((sp = strchr(name + known_dir + 1, '/')) != NULL) {
+		int thislen = sp - name ;
+		memcpy(path, name, thislen);
+		path[thislen] = 0;
 
 		if (lstat(path, &st))
 			return 0;
+		if (S_ISDIR(st.st_mode)) {
+			set_pathname(thislen, path, &nonlink);
+			known_dir = thislen;
+			continue;
+		}
 		if (S_ISLNK(st.st_mode)) {
-			if (last_symlink)
-				strcpy(last_symlink, path);
+			set_pathname(thislen, path, &link);
 			return 1;
 		}
-
-		dp[len++] = '/';
-		dp = dp + len;
-		sp = ep + 1;
+		break;
 	}
 	return 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index feae846..1ab28fd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -26,11 +26,12 @@ static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
  * directories, in case this unlink is the removal of the
  * last entry in the directory -- empty directories are removed.
  */
-static void unlink_entry(char *name, char *last_symlink)
+static void unlink_entry(struct cache_entry *ce)
 {
 	char *cp, *prev;
+	char *name = ce->name;
 
-	if (has_symlink_leading_path(name, last_symlink))
+	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
 		return;
 	if (unlink(name))
 		return;
@@ -58,7 +59,6 @@ static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
-	char last_symlink[PATH_MAX];
 	struct index_state *index = &o->result;
 	int i;
 	int errs = 0;
@@ -75,14 +75,13 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
-	*last_symlink = '\0';
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
-				unlink_entry(ce->name, last_symlink);
+				unlink_entry(ce);
 			remove_index_entry_at(&o->result, i);
 			i--;
 			continue;
@@ -97,7 +96,6 @@ static int check_updates(struct unpack_trees_options *o)
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update) {
 				errs |= checkout_entry(ce, &state, NULL);
-				*last_symlink = '\0';
 			}
 		}
 	}
@@ -553,7 +551,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_leading_path(ce->name, NULL))
+	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
