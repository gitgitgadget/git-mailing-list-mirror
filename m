From: Linus Torvalds <torvalds@osdl.org>
Subject: Libify the index refresh logic
Date: Fri, 19 May 2006 09:56:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605190942060.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 19 18:56:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh8HX-0002ej-Kp
	for gcvg-git@gmane.org; Fri, 19 May 2006 18:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWESQ4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWESQ4w
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 12:56:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751375AbWESQ4w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 12:56:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4JGuitH009062
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 May 2006 09:56:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4JGuZxf029121;
	Fri, 19 May 2006 09:56:39 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20349>


This cleans up and libifies the "git update-index --[really-]refresh" 
functionality. This will be eventually required for eventually doing the 
"commit" and "status" commands as built-ins.

It really just moves "refresh_index()" from update-index.c to 
read-cache.c, but it also has to change the calling convention so that the 
function uses a "unsigned int flags" argument instead of various static 
flags variables for passing down the information about whether to be quiet 
or not, and allow unmerged entries etc.

That actually cleans up update-index.c too, since it turns out that all 
those flags were really specific to that one function of the index update, 
so they shouldn't have had file-scope visibility even before. 

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

[ To keep the changes to the refresh_index() function itself minimal, it 
  currently just unpacks the passed-in "flags" argument into local 
  variables with the same names as the old static variables. That's 
  almost certainly worth cleaning up later, but for now it's that way
  just to show that no functionality or logic actually changed.

  Also, while I could have moved the IS_ERR/ERR_PTR/PTR_ERR macros to be 
  globally visible in a real header file, they were only used within the 
  moved function, so I just moved them to read-cache.c too with the only
  user. ]

diff --git a/cache.h b/cache.h
index f9b7049..31755c8 100644
--- a/cache.h
+++ b/cache.h
@@ -160,6 +160,12 @@ extern int index_pipe(unsigned char *sha
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
+#define REFRESH_REALLY		0x0001	/* ignore_valid */
+#define REFRESH_UNMERGED	0x0002	/* allow unmerged */
+#define REFRESH_QUIET		0x0004	/* be quiet about it */
+#define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
+extern int refresh_cache(unsigned int flags);
+
 struct cache_file {
 	struct cache_file *next;
 	char lockfile[PATH_MAX];
diff --git a/read-cache.c b/read-cache.c
index 9a272f8..36bd4ea 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -577,6 +577,123 @@ int add_cache_entry(struct cache_entry *
 	return 0;
 }
 
+/* Three functions to allow overloaded pointer return; see linux/err.h */
+static inline void *ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
+static inline long PTR_ERR(const void *ptr)
+{
+	return (long) ptr;
+}
+
+static inline long IS_ERR(const void *ptr)
+{
+	return (unsigned long)ptr > (unsigned long)-1000L;
+}
+
+/*
+ * "refresh" does not calculate a new sha1 file or bring the
+ * cache up-to-date for mode/content changes. But what it
+ * _does_ do is to "re-match" the stat information of a file
+ * with the cache, so that you can refresh the cache for a
+ * file that hasn't been changed but where the stat entry is
+ * out of date.
+ *
+ * For example, you'd want to do this after doing a "git-read-tree",
+ * to link up the stat cache details with the proper files.
+ */
+static struct cache_entry *refresh_entry(struct cache_entry *ce, int really)
+{
+	struct stat st;
+	struct cache_entry *updated;
+	int changed, size;
+
+	if (lstat(ce->name, &st) < 0)
+		return ERR_PTR(-errno);
+
+	changed = ce_match_stat(ce, &st, really);
+	if (!changed) {
+		if (really && assume_unchanged &&
+		    !(ce->ce_flags & htons(CE_VALID)))
+			; /* mark this one VALID again */
+		else
+			return NULL;
+	}
+
+	if (ce_modified(ce, &st, really))
+		return ERR_PTR(-EINVAL);
+
+	size = ce_size(ce);
+	updated = xmalloc(size);
+	memcpy(updated, ce, size);
+	fill_stat_cache_info(updated, &st);
+
+	/* In this case, if really is not set, we should leave
+	 * CE_VALID bit alone.  Otherwise, paths marked with
+	 * --no-assume-unchanged (i.e. things to be edited) will
+	 * reacquire CE_VALID bit automatically, which is not
+	 * really what we want.
+	 */
+	if (!really && assume_unchanged && !(ce->ce_flags & htons(CE_VALID)))
+		updated->ce_flags &= ~htons(CE_VALID);
+
+	return updated;
+}
+
+int refresh_cache(unsigned int flags)
+{
+	int i;
+	int has_errors = 0;
+	int really = (flags & REFRESH_REALLY) != 0;
+	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
+	int quiet = (flags & REFRESH_QUIET) != 0;
+	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce, *new;
+		ce = active_cache[i];
+		if (ce_stage(ce)) {
+			while ((i < active_nr) &&
+			       ! strcmp(active_cache[i]->name, ce->name))
+				i++;
+			i--;
+			if (allow_unmerged)
+				continue;
+			printf("%s: needs merge\n", ce->name);
+			has_errors = 1;
+			continue;
+		}
+
+		new = refresh_entry(ce, really);
+		if (!new)
+			continue;
+		if (IS_ERR(new)) {
+			if (not_new && PTR_ERR(new) == -ENOENT)
+				continue;
+			if (really && PTR_ERR(new) == -EINVAL) {
+				/* If we are doing --really-refresh that
+				 * means the index is not valid anymore.
+				 */
+				ce->ce_flags &= ~htons(CE_VALID);
+				active_cache_changed = 1;
+			}
+			if (quiet)
+				continue;
+			printf("%s: needs update\n", ce->name);
+			has_errors = 1;
+			continue;
+		}
+		active_cache_changed = 1;
+		/* You can NOT just free active_cache[i] here, since it
+		 * might not be necessarily malloc()ed but can also come
+		 * from mmap(). */
+		active_cache[i] = new;
+	}
+	return has_errors;
+}
+
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
 	SHA_CTX c;
diff --git a/update-index.c b/update-index.c
index 21448cc..956b6b3 100644
--- a/update-index.c
+++ b/update-index.c
@@ -19,9 +19,6 @@ #include "tree-walk.h"
 static int allow_add;
 static int allow_remove;
 static int allow_replace;
-static int allow_unmerged; /* --refresh needing merge is not error */
-static int not_new; /* --refresh not having working tree files is not error */
-static int quiet; /* --refresh needing update is not error */
 static int info_only;
 static int force_remove;
 static int verbose;
@@ -29,23 +26,6 @@ static int mark_valid_only = 0;
 #define MARK_VALID 1
 #define UNMARK_VALID 2
 
-
-/* Three functions to allow overloaded pointer return; see linux/err.h */
-static inline void *ERR_PTR(long error)
-{
-	return (void *) error;
-}
-
-static inline long PTR_ERR(const void *ptr)
-{
-	return (long) ptr;
-}
-
-static inline long IS_ERR(const void *ptr)
-{
-	return (unsigned long)ptr > (unsigned long)-1000L;
-}
-
 static void report(const char *fmt, ...)
 {
 	va_list vp;
@@ -148,103 +128,6 @@ static int add_file_to_cache(const char 
 	return 0;
 }
 
-/*
- * "refresh" does not calculate a new sha1 file or bring the
- * cache up-to-date for mode/content changes. But what it
- * _does_ do is to "re-match" the stat information of a file
- * with the cache, so that you can refresh the cache for a
- * file that hasn't been changed but where the stat entry is
- * out of date.
- *
- * For example, you'd want to do this after doing a "git-read-tree",
- * to link up the stat cache details with the proper files.
- */
-static struct cache_entry *refresh_entry(struct cache_entry *ce, int really)
-{
-	struct stat st;
-	struct cache_entry *updated;
-	int changed, size;
-
-	if (lstat(ce->name, &st) < 0)
-		return ERR_PTR(-errno);
-
-	changed = ce_match_stat(ce, &st, really);
-	if (!changed) {
-		if (really && assume_unchanged &&
-		    !(ce->ce_flags & htons(CE_VALID)))
-			; /* mark this one VALID again */
-		else
-			return NULL;
-	}
-
-	if (ce_modified(ce, &st, really))
-		return ERR_PTR(-EINVAL);
-
-	size = ce_size(ce);
-	updated = xmalloc(size);
-	memcpy(updated, ce, size);
-	fill_stat_cache_info(updated, &st);
-
-	/* In this case, if really is not set, we should leave
-	 * CE_VALID bit alone.  Otherwise, paths marked with
-	 * --no-assume-unchanged (i.e. things to be edited) will
-	 * reacquire CE_VALID bit automatically, which is not
-	 * really what we want.
-	 */
-	if (!really && assume_unchanged && !(ce->ce_flags & htons(CE_VALID)))
-		updated->ce_flags &= ~htons(CE_VALID);
-
-	return updated;
-}
-
-static int refresh_cache(int really)
-{
-	int i;
-	int has_errors = 0;
-
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce, *new;
-		ce = active_cache[i];
-		if (ce_stage(ce)) {
-			while ((i < active_nr) &&
-			       ! strcmp(active_cache[i]->name, ce->name))
-				i++;
-			i--;
-			if (allow_unmerged)
-				continue;
-			printf("%s: needs merge\n", ce->name);
-			has_errors = 1;
-			continue;
-		}
-
-		new = refresh_entry(ce, really);
-		if (!new)
-			continue;
-		if (IS_ERR(new)) {
-			if (not_new && PTR_ERR(new) == -ENOENT)
-				continue;
-			if (really && PTR_ERR(new) == -EINVAL) {
-				/* If we are doing --really-refresh that
-				 * means the index is not valid anymore.
-				 */
-				ce->ce_flags &= ~htons(CE_VALID);
-				active_cache_changed = 1;
-			}
-			if (quiet)
-				continue;
-			printf("%s: needs update\n", ce->name);
-			has_errors = 1;
-			continue;
-		}
-		active_cache_changed = 1;
-		/* You can NOT just free active_cache[i] here, since it
-		 * might not be necessarily malloc()ed but can also come
-		 * from mmap(). */
-		active_cache[i] = new;
-	}
-	return has_errors;
-}
-
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 			 const char *path, int stage)
 {
@@ -602,6 +485,7 @@ int main(int argc, const char **argv)
 	const char *prefix = setup_git_directory();
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	char set_executable_bit = 0;
+	unsigned int refresh_flags = 0;
 
 	git_config(git_default_config);
 
@@ -622,7 +506,7 @@ int main(int argc, const char **argv)
 				continue;
 			}
 			if (!strcmp(path, "-q")) {
-				quiet = 1;
+				refresh_flags |= REFRESH_QUIET;
 				continue;
 			}
 			if (!strcmp(path, "--add")) {
@@ -638,15 +522,15 @@ int main(int argc, const char **argv)
 				continue;
 			}
 			if (!strcmp(path, "--unmerged")) {
-				allow_unmerged = 1;
+				refresh_flags |= REFRESH_UNMERGED;
 				continue;
 			}
 			if (!strcmp(path, "--refresh")) {
-				has_errors |= refresh_cache(0);
+				has_errors |= refresh_cache(refresh_flags);
 				continue;
 			}
 			if (!strcmp(path, "--really-refresh")) {
-				has_errors |= refresh_cache(1);
+				has_errors |= refresh_cache(REFRESH_REALLY | refresh_flags);
 				continue;
 			}
 			if (!strcmp(path, "--cacheinfo")) {
@@ -719,7 +603,7 @@ int main(int argc, const char **argv)
 				goto finish;
 			}
 			if (!strcmp(path, "--ignore-missing")) {
-				not_new = 1;
+				refresh_flags |= REFRESH_IGNORE_MISSING;
 				continue;
 			}
 			if (!strcmp(path, "--verbose")) {
