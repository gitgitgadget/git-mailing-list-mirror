From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat() functions
Date: Wed, 10 Jul 2013 21:23:11 +0100
Message-ID: <51DDC2AF.9010504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	mlevedahl@gmail.com, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 10 22:25:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ux0xH-0002T5-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 22:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab3GJUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 16:25:33 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:46544 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754342Ab3GJUZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 16:25:31 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 984E618C87D;
	Wed, 10 Jul 2013 21:25:30 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 9D30618C831;
	Wed, 10 Jul 2013 21:25:27 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Wed, 10 Jul 2013 21:25:25 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230071>


Commit adbc0b6b ("cygwin: Use native Win32 API for stat", 30-09-2008)
added a Win32 specific implementation of the stat functions. In order
to handle absolute paths, cygwin mount points and symbolic links, this
implementation may fall back on the standard cygwin l/stat() functions.
Also, the choice of cygwin or Win32 functions is made lazily (by the
first call(s) to l/stat) based on the state of some config variables.

Unfortunately, this "schizophrenic stat" implementation has been the
source of many problems ever since. For example, see commits 7faee6b8,
79748439, 452993c2, 085479e7, b8a97333, 924aaf3e, 05bab3ea and 0117c2f0.

In order to limit the adverse effects caused by this implementation,
we provide a new "fast stat" interface, which allows us to use this
only for interactions with the index (i.e. the cached stat data).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/apply.c        |  8 ++++----
 builtin/commit.c       |  2 +-
 builtin/ls-files.c     |  2 +-
 builtin/rm.c           |  2 +-
 builtin/update-index.c |  2 +-
 check-racy.c           |  2 +-
 compat/cygwin.c        | 48 ++++++++++--------------------------------------
 compat/cygwin.h        | 17 +++++++++--------
 diff-lib.c             |  2 +-
 diff.c                 |  2 +-
 entry.c                |  6 +++---
 git-compat-util.h      | 27 +++++++++++++++++++++++++--
 help.c                 |  5 +----
 path.c                 |  9 +--------
 preload-index.c        |  2 +-
 read-cache.c           |  6 +++---
 unpack-trees.c         |  8 ++++----
 17 files changed, 68 insertions(+), 82 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0e9b631..f5046a6 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3091,7 +3091,7 @@ static int checkout_target(struct cache_entry *ce, struct stat *st)
 	memset(&costate, 0, sizeof(costate));
 	costate.base_dir = "";
 	costate.refresh_cache = 1;
-	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
+	if (checkout_entry(ce, &costate, NULL) || fast_lstat(ce->name, st))
 		return error(_("cannot checkout %s"), ce->name);
 	return 0;
 }
@@ -3253,7 +3253,7 @@ static int load_current(struct image *image, struct patch *patch)
 	if (pos < 0)
 		return error(_("%s: does not exist in index"), name);
 	ce = active_cache[pos];
-	if (lstat(name, &st)) {
+	if (fast_lstat(name, &st)) {
 		if (errno != ENOENT)
 			return error(_("%s: %s"), name, strerror(errno));
 		if (checkout_target(ce, &st))
@@ -3396,7 +3396,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (previous) {
 		st_mode = previous->new_mode;
 	} else if (!cached) {
-		stat_ret = lstat(old_name, st);
+		stat_ret = fast_lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
 			return error(_("%s: %s"), old_name, strerror(errno));
 	}
@@ -3850,7 +3850,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 			die(_("corrupt patch for subproject %s"), path);
 	} else {
 		if (!cached) {
-			if (lstat(path, &st) < 0)
+			if (fast_lstat(path, &st) < 0)
 				die_errno(_("unable to stat newly created file '%s'"),
 					  path);
 			fill_stat_cache_info(ce, &st);
diff --git a/builtin/commit.c b/builtin/commit.c
index 6b693c1..1d208c6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -231,7 +231,7 @@ static void add_remove_files(struct string_list *list)
 		if (p->util)
 			continue;
 
-		if (!lstat(p->string, &st)) {
+		if (!fast_lstat(p->string, &st)) {
 			if (add_to_cache(p->string, &st, 0))
 				die(_("updating files failed"));
 		} else
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3a410c3..a066719 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -247,7 +247,7 @@ static void show_files(struct dir_struct *dir)
 				continue;
 			if (ce_skip_worktree(ce))
 				continue;
-			err = lstat(ce->name, &st);
+			err = fast_lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
 			if (show_modified && ce_modified(ce, &st, 0))
diff --git a/builtin/rm.c b/builtin/rm.c
index 06025a2..4b783e7 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -143,7 +143,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		}
 		ce = active_cache[pos];
 
-		if (lstat(ce->name, &st) < 0) {
+		if (fast_lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT && errno != ENOTDIR)
 				warning("'%s': %s", ce->name, strerror(errno));
 			/* It already vanished from the working tree */
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5c7762e..4790e4c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -206,7 +206,7 @@ static int process_path(const char *path)
 	 * First things first: get the stat information, to decide
 	 * what to do about the pathname!
 	 */
-	if (lstat(path, &st) < 0)
+	if (fast_lstat(path, &st) < 0)
 		return process_lstat_error(path, errno);
 
 	if (S_ISDIR(st.st_mode))
diff --git a/check-racy.c b/check-racy.c
index 00d92a1..6124355 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -11,7 +11,7 @@ int main(int ac, char **av)
 		struct cache_entry *ce = active_cache[i];
 		struct stat st;
 
-		if (lstat(ce->name, &st)) {
+		if (fast_lstat(ce->name, &st)) {
 			error("lstat(%s): %s", ce->name, strerror(errno));
 			continue;
 		}
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 91ce5d4..661d8f7 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,4 +1,3 @@
-#define CYGWIN_C
 #define WIN32_LEAN_AND_MEAN
 #include <sys/stat.h>
 #include <sys/errno.h>
@@ -6,18 +5,6 @@
 #include "../git-compat-util.h"
 #include "../cache.h" /* to read configuration */
 
-/*
- * Return POSIX permission bits, regardless of core.ignorecygwinfstricks
- */
-int cygwin_get_st_mode_bits(const char *path, int *mode)
-{
-	struct stat st;
-	if (lstat(path, &st) < 0)
-		return -1;
-	*mode = st.st_mode;
-	return 0;
-}
-
 static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
 {
 	long long winTime = ((long long)ft->dwHighDateTime << 32) +
@@ -85,29 +72,23 @@ static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
 	return -1;
 }
 
-/* We provide our own lstat/stat functions, since the provided Cygwin versions
- * of these functions are too slow. These stat functions are tailored for Git's
- * usage, and therefore they are not meant to be complete and correct emulation
- * of lstat/stat functionality.
+/* We provide our own lstat function, since the provided Cygwin versions of
+ * the stat functions are too slow. This lstat function is tailored for Git's
+ * usage, and therefore it is not meant to be complete and correct emulation
+ * of lstat functionality.
  */
 static int cygwin_lstat(const char *path, struct stat *buf)
 {
 	return do_stat(path, buf, lstat);
 }
 
-static int cygwin_stat(const char *path, struct stat *buf)
-{
-	return do_stat(path, buf, stat);
-}
-
-
 /*
- * At start up, we are trying to determine whether Win32 API or cygwin stat
- * functions should be used. The choice is determined by core.ignorecygwinfstricks.
+ * At start up, we are trying to determine whether Win32 API or cygwin lstat
+ * function should be used. The choice is determined by core.ignorecygwinfstricks.
  * Reading this option is not always possible immediately as git_dir may
- * not be set yet. So until it is set, use cygwin lstat/stat functions.
+ * not be set yet. So until it is set, use the cygwin lstat function.
  * However, if core.filemode is set, we must use the Cygwin posix
- * stat/lstat as the Windows stat functions do not determine posix filemode.
+ * lstat as the Windows lstat function does not determine posix filemode.
  *
  * Note that git_cygwin_config() does NOT call git_default_config() and this
  * is deliberate.  Many commands read from config to establish initial
@@ -130,28 +111,19 @@ static int git_cygwin_config(const char *var, const char *value, void *cb)
 static int init_stat(void)
 {
 	if (have_git_dir() && git_config(git_cygwin_config,NULL)) {
-		if (!core_filemode && native_stat) {
-			cygwin_stat_fn = cygwin_stat;
+		if (!core_filemode && native_stat)
 			cygwin_lstat_fn = cygwin_lstat;
-		} else {
-			cygwin_stat_fn = stat;
+		else
 			cygwin_lstat_fn = lstat;
-		}
 		return 0;
 	}
 	return 1;
 }
 
-static int cygwin_stat_stub(const char *file_name, struct stat *buf)
-{
-	return (init_stat() ? stat : *cygwin_stat_fn)(file_name, buf);
-}
-
 static int cygwin_lstat_stub(const char *file_name, struct stat *buf)
 {
 	return (init_stat() ? lstat : *cygwin_lstat_fn)(file_name, buf);
 }
 
-stat_fn_t cygwin_stat_fn = cygwin_stat_stub;
 stat_fn_t cygwin_lstat_fn = cygwin_lstat_stub;
 
diff --git a/compat/cygwin.h b/compat/cygwin.h
index c04965a..c5955cc 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -2,13 +2,14 @@
 #include <sys/stat.h>
 
 typedef int (*stat_fn_t)(const char*, struct stat*);
-extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
-int cygwin_get_st_mode_bits(const char *path, int *mode);
 
-#define get_st_mode_bits(p,m) cygwin_get_st_mode_bits((p),(m))
-#ifndef CYGWIN_C
-/* cygwin.c needs the original lstat() */
-#define stat(path, buf) (*cygwin_stat_fn)(path, buf)
-#define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
-#endif
+/*
+ * Note that the fast_fstat function should never actually
+ * be called, since cygwin has the UNRELIABLE_FSTAT build
+ * variable set. Currently, all calls to fast_fstat are
+ * protected by 'fstat_is_reliable()'.
+ */
+#define fast_lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+#define fast_fstat(fd, buf) fstat(fd, buf)
+#define GIT_FAST_STAT
diff --git a/diff-lib.c b/diff-lib.c
index b6f4b21..401dab6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -27,7 +27,7 @@
  */
 static int check_removed(const struct cache_entry *ce, struct stat *st)
 {
-	if (lstat(ce->name, st) < 0) {
+	if (fast_lstat(ce->name, st) < 0) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			return -1;
 		return 1;
diff --git a/diff.c b/diff.c
index 208094f..212d3ff 100644
--- a/diff.c
+++ b/diff.c
@@ -2642,7 +2642,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * If ce matches the file in the work tree, we can reuse it.
 	 */
 	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+	    (!fast_lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
 
 	return 0;
diff --git a/entry.c b/entry.c
index d7c131d..f746d2a 100644
--- a/entry.c
+++ b/entry.c
@@ -109,7 +109,7 @@ static int fstat_output(int fd, const struct checkout *state, struct stat *st)
 	/* use fstat() only when path == ce->name */
 	if (fstat_is_reliable() &&
 	    state->refresh_cache && !state->base_dir_len) {
-		fstat(fd, st);
+		fast_fstat(fd, st);
 		return 1;
 	}
 	return 0;
@@ -210,7 +210,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 finish:
 	if (state->refresh_cache) {
 		if (!fstat_done)
-			lstat(ce->name, &st);
+			fast_lstat(ce->name, &st);
 		fill_stat_cache_info(ce, &st);
 	}
 	return 0;
@@ -230,7 +230,7 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 		errno = ENOENT;
 		return -1;
 	}
-	return lstat(path, st);
+	return fast_lstat(path, st);
 }
 
 int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath)
diff --git a/git-compat-util.h b/git-compat-util.h
index ff193f4..092a571 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -129,8 +129,6 @@
 #include <poll.h>
 #endif
 
-extern int get_st_mode_bits(const char *path, int *mode);
-
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
@@ -179,6 +177,31 @@ typedef unsigned long uintptr_t;
 #endif
 #endif
 
+#ifndef GIT_FAST_STAT
+/*
+ * The "fast" stat() variants are used to read the stat data from the
+ * filesystem that is stored into the index and/or that is compared
+ * with the cached stat data. In order to provide a fast implementation,
+ * these functions may not provide meaningful data in all fields of the
+ * stat structure and should not, therefore, be used for any other purpose.
+ *
+ * Platforms which have slow stat functions, which can also provide
+ * such fast variants (e.g. cygwin), should include the external
+ * declarations above and define the GIT_FAST_STAT macro.
+ *
+ * The static inline definitions below are for platforms which have
+ * no need of such fast variants.
+ */
+static inline int fast_lstat(const char *path, struct stat *st)
+{
+	return lstat(path, st);
+}
+static inline int fast_fstat(int fd, struct stat *st)
+{
+	return fstat(fd, st);
+}
+#endif
+
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
diff --git a/help.c b/help.c
index 08c54ef..f068925 100644
--- a/help.c
+++ b/help.c
@@ -107,10 +107,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
-#if defined(__CYGWIN__)
-if ((st.st_mode & S_IXUSR) == 0)
-#endif
+#if defined(GIT_WINDOWS_NATIVE)
 {	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
diff --git a/path.c b/path.c
index 04ff148..4e7fae4 100644
--- a/path.c
+++ b/path.c
@@ -5,13 +5,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-#ifndef get_st_mode_bits
-/*
- * The replacement lstat(2) we use on Cygwin is incomplete and
- * may return wrong permission bits. Most of the time we do not care,
- * but the callsites of this wrapper do care.
- */
-int get_st_mode_bits(const char *path, int *mode)
+static int get_st_mode_bits(const char *path, int *mode)
 {
 	struct stat st;
 	if (lstat(path, &st) < 0)
@@ -19,7 +13,6 @@ int get_st_mode_bits(const char *path, int *mode)
 	*mode = st.st_mode;
 	return 0;
 }
-#endif
 
 static char bad_path[] = "/bad-path/";
 
diff --git a/preload-index.c b/preload-index.c
index 49cb08d..1bece91 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -57,7 +57,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
 			continue;
-		if (lstat(ce->name, &st))
+		if (fast_lstat(ce->name, &st))
 			continue;
 		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
 			continue;
diff --git a/read-cache.c b/read-cache.c
index d5201f9..ed33d9e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -689,7 +689,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
-	if (lstat(path, &st))
+	if (fast_lstat(path, &st))
 		die_errno("unable to stat '%s'", path);
 	return add_to_index(istate, path, &st, flags);
 }
@@ -1049,7 +1049,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		return ce;
 	}
 
-	if (lstat(ce->name, &st) < 0) {
+	if (fast_lstat(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
 		return NULL;
@@ -1635,7 +1635,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	 */
 	struct stat st;
 
-	if (lstat(ce->name, &st) < 0)
+	if (fast_lstat(ce->name, &st) < 0)
 		return;
 	if (ce_match_stat_basic(ce, &st))
 		return;
diff --git a/unpack-trees.c b/unpack-trees.c
index b27f2a6..1fe9b63 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1215,7 +1215,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	else if (o->reset || ce_uptodate(ce))
 		return 0;
 
-	if (!lstat(ce->name, &st)) {
+	if (!fast_lstat(ce->name, &st)) {
 		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
 		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
 		if (!changed)
@@ -1432,13 +1432,13 @@ static int verify_absent_1(const struct cache_entry *ce,
 		char path[PATH_MAX + 1];
 		memcpy(path, ce->name, len);
 		path[len] = 0;
-		if (lstat(path, &st))
+		if (fast_lstat(path, &st))
 			return error("cannot stat '%s': %s", path,
 					strerror(errno));
 
 		return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
 				error_type, o);
-	} else if (lstat(ce->name, &st)) {
+	} else if (fast_lstat(ce->name, &st)) {
 		if (errno != ENOENT)
 			return error("cannot stat '%s': %s", ce->name,
 				     strerror(errno));
@@ -1852,7 +1852,7 @@ int oneway_merge(const struct cache_entry * const *src,
 		int update = 0;
 		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
 			struct stat st;
-			if (lstat(old->name, &st) ||
+			if (fast_lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
 				update |= CE_UPDATE;
 		}
-- 
1.8.3
