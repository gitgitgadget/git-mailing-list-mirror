From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 2/4] teach ref iteration module about submodules
Date: Tue,  6 Jul 2010 21:34:32 +0200
Message-ID: <17527e05975d1a23b09059a9cb2ae2180d296165.1278444110.git.hvoigt@hvoigt.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 06 21:35:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDv8-0003yP-SJ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab0GFTek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 15:34:40 -0400
Received: from darksea.de ([83.133.111.250]:56022 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754492Ab0GFTeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 15:34:37 -0400
Received: (qmail 13687 invoked from network); 6 Jul 2010 21:34:35 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Jul 2010 21:34:35 +0200
X-Mailer: git-send-email 1.7.2.rc1.217.g7dc0db.dirty
In-Reply-To: <cover.1278444110.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1278444110.git.hvoigt@hvoigt.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150402>

We will use this in a later patch to extend setup_revisions() to
load revisions directly from a submodule.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 cache.h |    3 ++
 path.c  |   38 ++++++++++++++++++++
 refs.c  |  118 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 127 insertions(+), 32 deletions(-)

diff --git a/cache.h b/cache.h
index c9fa3df..32932e8 100644
--- a/cache.h
+++ b/cache.h
@@ -641,6 +641,9 @@ extern char *git_pathdup(const char *fmt, ...)
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
index b4c8d91..e32c61c 100644
--- a/path.c
+++ b/path.c
@@ -122,6 +122,44 @@ char *git_path(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
 
+char *git_path_submodule(const char *path, const char *fmt, ...)
+{
+	char *pathname = get_pathname();
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir;
+	va_list args;
+	unsigned len;
+
+	len = strlen(path);
+	if (len > PATH_MAX-100)
+		return bad_path;
+
+	strbuf_addstr(&buf, path);
+	if (len && path[len-1] != '/')
+		strbuf_addch(&buf, '/');
+	strbuf_addstr(&buf, ".git");
+
+	git_dir = read_gitfile_gently(buf.buf);
+	if (git_dir) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, git_dir);
+	}
+	strbuf_addch(&buf, '/');
+
+	if (buf.len >= PATH_MAX)
+		return bad_path;
+	memcpy(pathname, buf.buf, buf.len + 1);
+
+	strbuf_release(&buf);
+	len = strlen(pathname);
+
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
index 6f486ae..c8649b1 100644
--- a/refs.c
+++ b/refs.c
@@ -157,7 +157,7 @@ static struct cached_refs {
 	char did_packed;
 	struct ref_list *loose;
 	struct ref_list *packed;
-} cached_refs;
+} cached_refs, submodule_refs;
 static struct ref_list *current_ref;
 
 static struct ref_list *extra_refs;
@@ -229,23 +229,45 @@ void clear_extra_refs(void)
 	extra_refs = NULL;
 }
 
-static struct ref_list *get_packed_refs(void)
+static struct ref_list *get_packed_refs(const char *submodule)
 {
-	if (!cached_refs.did_packed) {
-		FILE *f = fopen(git_path("packed-refs"), "r");
-		cached_refs.packed = NULL;
+	const char *packed_refs_file;
+	struct cached_refs *refs;
+
+	if (submodule) {
+		packed_refs_file = git_path_submodule(submodule, "packed-refs");
+		refs = &submodule_refs;
+		free_ref_list(refs->packed);
+	} else {
+		packed_refs_file = git_path("packed-refs");
+		refs = &cached_refs;
+	}
+
+	if (!refs->did_packed || submodule) {
+		FILE *f = fopen(packed_refs_file, "r");
+		refs->packed = NULL;
 		if (f) {
-			read_packed_refs(f, &cached_refs);
+			read_packed_refs(f, refs);
 			fclose(f);
 		}
-		cached_refs.did_packed = 1;
+		refs->did_packed = 1;
 	}
-	return cached_refs.packed;
+	return refs->packed;
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
@@ -261,6 +283,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 			struct stat st;
 			int flag;
 			int namelen;
+			const char *refdir;
 
 			if (de->d_name[0] == '.')
 				continue;
@@ -270,16 +293,27 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
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
+				if (resolve_gitlink_ref(submodule, ref, sha1) < 0) {
+					hashclr(sha1);
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
@@ -322,10 +356,16 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
-static struct ref_list *get_loose_refs(void)
+static struct ref_list *get_loose_refs(const char *submodule)
 {
+	if (submodule) {
+		free_ref_list(submodule_refs.loose);
+		submodule_refs.loose = get_ref_dir(submodule, "refs", NULL);
+		return submodule_refs.loose;
+	}
+
 	if (!cached_refs.did_loose) {
-		cached_refs.loose = get_ref_dir("refs", NULL);
+		cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
 		cached_refs.did_loose = 1;
 	}
 	return cached_refs.loose;
@@ -459,7 +499,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		git_snpath(path, sizeof(path), "%s", ref);
 		/* Special case: non-existing file. */
 		if (lstat(path, &st) < 0) {
-			struct ref_list *list = get_packed_refs();
+			struct ref_list *list = get_packed_refs(NULL);
 			while (list) {
 				if (!strcmp(ref, list->name)) {
 					hashcpy(sha1, list->sha1);
@@ -588,7 +628,7 @@ int peel_ref(const char *ref, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_list *list = get_packed_refs();
+		struct ref_list *list = get_packed_refs(NULL);
 
 		while (list) {
 			if (!strcmp(list->name, ref)) {
@@ -615,12 +655,12 @@ fallback:
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
 
@@ -657,24 +697,38 @@ end_each:
 	return retval;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+
+static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];
 	int flag;
 
+	if (submodule) {
+		if (resolve_gitlink_ref(submodule, "HEAD", sha1) == 0)
+			return fn("HEAD", sha1, 0, cb_data);
+
+		return 0;
+	}
+
 	if (resolve_ref("HEAD", sha1, 1, &flag))
 		return fn("HEAD", sha1, flag, cb_data);
+
 	return 0;
 }
 
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_head_ref(NULL, fn, cb_data);
+}
+
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
@@ -694,7 +748,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
 }
 
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
@@ -734,7 +788,7 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0,
+	return do_for_each_ref(NULL, "refs/", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -958,7 +1012,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(ref, NULL, get_packed_refs(), 0)) {
+	     !is_refname_available(ref, NULL, get_packed_refs(NULL), 0)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1021,7 +1075,7 @@ static int repack_without_ref(const char *refname)
 	int fd;
 	int found = 0;
 
-	packed_ref_list = get_packed_refs();
+	packed_ref_list = get_packed_refs(NULL);
 	for (list = packed_ref_list; list; list = list->next) {
 		if (!strcmp(refname, list->name)) {
 			found = 1;
@@ -1110,10 +1164,10 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	if (!symref)
 		return error("refname %s not found", oldref);
 
-	if (!is_refname_available(newref, oldref, get_packed_refs(), 0))
+	if (!is_refname_available(newref, oldref, get_packed_refs(NULL), 0))
 		return 1;
 
-	if (!is_refname_available(newref, oldref, get_loose_refs(), 0))
+	if (!is_refname_available(newref, oldref, get_loose_refs(NULL), 0))
 		return 1;
 
 	lock = lock_ref_sha1_basic(renamed_ref, NULL, 0, NULL);
-- 
1.7.2.rc1.217.g7dc0db.dirty
