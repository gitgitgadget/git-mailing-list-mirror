From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [WIP PATCH 1/3] extend ref iteration for submodules
Date: Fri, 11 Jun 2010 14:23:31 +0200
Message-ID: <7990743852d1482e0f42daaa69a0a1a98a73402a.1276059473.git.hvoigt@hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 11 14:30:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON3NS-0005BH-6W
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 14:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760219Ab0FKMaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 08:30:20 -0400
Received: from darksea.de ([83.133.111.250]:56928 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760175Ab0FKMaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 08:30:17 -0400
Received: (qmail 1396 invoked from network); 11 Jun 2010 14:23:33 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Jun 2010 14:23:33 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1276059473.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1276059473.git.hvoigt@hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148941>

This is useful to interrogate a submodule from the main repository.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 cache.h |    3 ++
 path.c  |   21 +++++++++++++++
 refs.c  |   89 ++++++++++++++++++++++++++++++++++++++++++++------------------
 refs.h  |    2 +
 4 files changed, 89 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index c966023..daae839 100644
--- a/cache.h
+++ b/cache.h
@@ -621,6 +621,9 @@ extern char *git_pathdup(const char *fmt, ...)
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern char *git_path_submodule(const char *path, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
diff --git a/path.c b/path.c
index b4c8d91..47118bc 100644
--- a/path.c
+++ b/path.c
@@ -122,6 +122,27 @@ char *git_path(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
 
+char *git_path_submodule(const char *path, const char *fmt, ...)
+{
+	char *pathname = get_pathname();
+	va_list args;
+	unsigned len;
+
+	len = strlen(path);
+	if (len > PATH_MAX-100)
+		return bad_path;
+	memcpy(pathname, path, len);
+	if (len && path[len-1] != '/')
+		pathname[len++] = '/';
+	memcpy(pathname + len, ".git/", 5);
+	len += 5;
+	va_start(args, fmt);
+	len += vsnprintf(pathname + len, PATH_MAX - len, fmt, args);
+	va_end(args);
+	if (len >= PATH_MAX)
+		return bad_path;
+	return cleanup_path(pathname);
+}
 
 /* git_mkstemp() - create tmp file honoring TMPDIR variable */
 int git_mkstemp(char *path, size_t len, const char *template)
diff --git a/refs.c b/refs.c
index d3db15a..eed8a29 100644
--- a/refs.c
+++ b/refs.c
@@ -157,6 +157,7 @@ static struct cached_refs {
 	char did_packed;
 	struct ref_list *loose;
 	struct ref_list *packed;
+	const char *submodule;
 } cached_refs;
 static struct ref_list *current_ref;
 
@@ -229,10 +230,17 @@ void clear_extra_refs(void)
 	extra_refs = NULL;
 }
 
-static struct ref_list *get_packed_refs(void)
+static struct ref_list *get_packed_refs(const char *submodule)
 {
+	const char *packed_refs_file;
+
+	if (submodule)
+		packed_refs_file = git_path_submodule(submodule, "packed-refs");
+	else
+		packed_refs_file = git_path("packed-refs");
+
 	if (!cached_refs.did_packed) {
-		FILE *f = fopen(git_path("packed-refs"), "r");
+		FILE *f = fopen(packed_refs_file, "r");
 		cached_refs.packed = NULL;
 		if (f) {
 			read_packed_refs(f, &cached_refs);
@@ -243,9 +251,19 @@ static struct ref_list *get_packed_refs(void)
 	return cached_refs.packed;
 }
 
-static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
+static struct ref_list *get_ref_dir(const char *submodule, const char *base,
+				    struct ref_list *list)
 {
-	DIR *dir = opendir(git_path("%s", base));
+	DIR *dir;
+	const char *path;
+
+	if (submodule)
+		path = git_path_submodule(submodule, "%s", base);
+	else
+		path = git_path("%s", base);
+
+
+	dir = opendir(path);
 
 	if (dir) {
 		struct dirent *de;
@@ -261,6 +279,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 			struct stat st;
 			int flag;
 			int namelen;
+			const char *refdir;
 
 			if (de->d_name[0] == '.')
 				continue;
@@ -270,16 +289,27 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 			if (has_extension(de->d_name, ".lock"))
 				continue;
 			memcpy(ref + baselen, de->d_name, namelen+1);
-			if (stat(git_path("%s", ref), &st) < 0)
+			refdir = submodule
+				? git_path_submodule(submodule, "%s", ref)
+				: git_path("%s", ref);
+			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				list = get_ref_dir(ref, list);
+				list = get_ref_dir(submodule, ref, list);
 				continue;
 			}
-			if (!resolve_ref(ref, sha1, 1, &flag)) {
+			if (submodule) {
 				hashclr(sha1);
-				flag |= REF_BROKEN;
-			}
+				flag = 0;
+				if (!resolve_gitlink_ref(submodule, ref, sha1)) {
+				//	hashclr(sha1);
+					flag |= REF_BROKEN;
+				}
+			} else
+				if (!resolve_ref(ref, sha1, 1, &flag)) {
+					hashclr(sha1);
+					flag |= REF_BROKEN;
+				}
 			list = add_ref(ref, sha1, flag, list, NULL);
 		}
 		free(ref);
@@ -318,11 +348,12 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
-static struct ref_list *get_loose_refs(void)
+static struct ref_list *get_loose_refs(const char *submodule)
 {
-	if (!cached_refs.did_loose) {
-		cached_refs.loose = get_ref_dir("refs", NULL);
+	if (!cached_refs.did_loose || cached_refs.submodule != submodule) {
+		cached_refs.loose = get_ref_dir(submodule, "refs", NULL);
 		cached_refs.did_loose = 1;
+		cached_refs.submodule = submodule;
 	}
 	return cached_refs.loose;
 }
@@ -455,7 +486,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		git_snpath(path, sizeof(path), "%s", ref);
 		/* Special case: non-existing file. */
 		if (lstat(path, &st) < 0) {
-			struct ref_list *list = get_packed_refs();
+			struct ref_list *list = get_packed_refs(NULL);
 			while (list) {
 				if (!strcmp(ref, list->name)) {
 					hashcpy(sha1, list->sha1);
@@ -584,7 +615,7 @@ int peel_ref(const char *ref, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_list *list = get_packed_refs();
+		struct ref_list *list = get_packed_refs(NULL);
 
 		while (list) {
 			if (!strcmp(list->name, ref)) {
@@ -611,12 +642,12 @@ fallback:
 	return -1;
 }
 
-static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
-			   int flags, void *cb_data)
+static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
+			   int trim, int flags, void *cb_data)
 {
 	int retval = 0;
-	struct ref_list *packed = get_packed_refs();
-	struct ref_list *loose = get_loose_refs();
+	struct ref_list *packed = get_packed_refs(submodule);
+	struct ref_list *loose = get_loose_refs(submodule);
 
 	struct ref_list *extra;
 
@@ -665,12 +696,12 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0, 0, cb_data);
+	return do_for_each_ref(NULL, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
@@ -690,7 +721,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
 }
 
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
@@ -730,7 +761,13 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0,
+	return do_for_each_ref(NULL, "refs/", fn, 0,
+			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+}
+
+int for_each_rawref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(submodule, "refs/", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -954,7 +991,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(ref, NULL, get_packed_refs(), 0)) {
+	     !is_refname_available(ref, NULL, get_packed_refs(NULL), 0)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1017,7 +1054,7 @@ static int repack_without_ref(const char *refname)
 	int fd;
 	int found = 0;
 
-	packed_ref_list = get_packed_refs();
+	packed_ref_list = get_packed_refs(NULL);
 	for (list = packed_ref_list; list; list = list->next) {
 		if (!strcmp(refname, list->name)) {
 			found = 1;
@@ -1106,10 +1143,10 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	if (!symref)
 		return error("refname %s not found", oldref);
 
-	if (!is_refname_available(newref, oldref, get_packed_refs(), 0))
+	if (!is_refname_available(newref, oldref, get_packed_refs(NULL), 0))
 		return 1;
 
-	if (!is_refname_available(newref, oldref, get_loose_refs(), 0))
+	if (!is_refname_available(newref, oldref, get_loose_refs(NULL), 0))
 		return 1;
 
 	lock = lock_ref_sha1_basic(renamed_ref, NULL, 0, NULL);
diff --git a/refs.h b/refs.h
index 4a18b08..384e311 100644
--- a/refs.h
+++ b/refs.h
@@ -35,6 +35,8 @@ static inline const char *has_glob_specials(const char *pattern)
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
+extern int for_each_rawref_submodule(const char *path, each_ref_fn fn, void *cb_data);
+
 
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 
-- 
1.7.1
