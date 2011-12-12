From: mhagger@alum.mit.edu
Subject: [PATCH v2 02/51] refs: rename "refname" variables
Date: Mon, 12 Dec 2011 06:38:09 +0100
Message-ID: <1323668338-1764-3-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycW-0000Sq-RW
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab1LLFjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:47 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34564 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1LLFjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:40 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aF015577;
	Mon, 12 Dec 2011 06:39:16 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186829>

From: Michael Haggerty <mhagger@alum.mit.edu>

Try to consistently use the variable name "refname" when referring to
a string that names a reference.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |    6 +-
 refs.c  |  306 ++++++++++++++++++++++++++++++++-------------------------------
 refs.h  |   26 +++---
 3 files changed, 175 insertions(+), 163 deletions(-)

diff --git a/cache.h b/cache.h
index 8c98d05..e1644b1 100644
--- a/cache.h
+++ b/cache.h
@@ -831,9 +831,9 @@ static inline int get_sha1_with_context(const char *str, unsigned char *sha1, st
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
-extern int read_ref_full(const char *filename, unsigned char *sha1,
+extern int read_ref_full(const char *refname, unsigned char *sha1,
 			 int reading, int *flags);
-extern int read_ref(const char *filename, unsigned char *sha1);
+extern int read_ref(const char *refname, unsigned char *sha1);
 
 /*
  * Resolve a reference, recursively following symbolic refererences.
@@ -865,7 +865,7 @@ extern int read_ref(const char *filename, unsigned char *sha1);
  *
  * errno is sometimes set on errors, but not always.
  */
-extern const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag);
+extern const char *resolve_ref(const char *refname, unsigned char *sha1, int reading, int *flag);
 
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
diff --git a/refs.c b/refs.c
index 669782f..8ddd874 100644
--- a/refs.c
+++ b/refs.c
@@ -48,7 +48,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
-static void add_ref(const char *name, const unsigned char *sha1,
+static void add_ref(const char *refname, const unsigned char *sha1,
 		    int flag, int check_name, struct ref_array *refs,
 		    struct ref_entry **new_entry)
 {
@@ -56,14 +56,14 @@ static void add_ref(const char *name, const unsigned char *sha1,
 	struct ref_entry *entry;
 
 	/* Allocate it and add it in.. */
-	len = strlen(name) + 1;
+	len = strlen(refname) + 1;
 	entry = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(entry->sha1, sha1);
 	hashclr(entry->peeled);
 	if (check_name &&
-	    check_refname_format(name, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", name);
-	memcpy(entry->name, name, len);
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+		die("Reference has invalid format: '%s'", refname);
+	memcpy(entry->name, refname, len);
 	entry->flag = flag;
 	if (new_entry)
 		*new_entry = entry;
@@ -106,20 +106,20 @@ static void sort_ref_array(struct ref_array *array)
 	array->nr = i + 1;
 }
 
-static struct ref_entry *search_ref_array(struct ref_array *array, const char *name)
+static struct ref_entry *search_ref_array(struct ref_array *array, const char *refname)
 {
 	struct ref_entry *e, **r;
 	int len;
 
-	if (name == NULL)
+	if (refname == NULL)
 		return NULL;
 
 	if (!array->nr)
 		return NULL;
 
-	len = strlen(name) + 1;
+	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
-	memcpy(e->name, name, len);
+	memcpy(e->name, refname, len);
 
 	r = bsearch(&e, array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
 
@@ -223,7 +223,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 	while (fgets(refline, sizeof(refline), f)) {
 		unsigned char sha1[20];
-		const char *name;
+		const char *refname;
 		static const char header[] = "# pack-refs with:";
 
 		if (!strncmp(refline, header, sizeof(header)-1)) {
@@ -234,9 +234,9 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 			continue;
 		}
 
-		name = parse_ref_line(refline, sha1);
-		if (name) {
-			add_ref(name, sha1, flag, 1, array, &last);
+		refname = parse_ref_line(refline, sha1);
+		if (refname) {
+			add_ref(refname, sha1, flag, 1, array, &last);
 			continue;
 		}
 		if (last &&
@@ -249,9 +249,9 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 	sort_ref_array(array);
 }
 
-void add_extra_ref(const char *name, const unsigned char *sha1, int flag)
+void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
-	add_ref(name, sha1, flag, 0, &extra_refs, NULL);
+	add_ref(refname, sha1, flag, 0, &extra_refs, NULL);
 }
 
 void clear_extra_refs(void)
@@ -298,11 +298,11 @@ static void get_ref_dir(const char *submodule, const char *base,
 	if (dir) {
 		struct dirent *de;
 		int baselen = strlen(base);
-		char *ref = xmalloc(baselen + 257);
+		char *refname = xmalloc(baselen + 257);
 
-		memcpy(ref, base, baselen);
+		memcpy(refname, base, baselen);
 		if (baselen && base[baselen-1] != '/')
-			ref[baselen++] = '/';
+			refname[baselen++] = '/';
 
 		while ((de = readdir(dir)) != NULL) {
 			unsigned char sha1[20];
@@ -318,30 +318,30 @@ static void get_ref_dir(const char *submodule, const char *base,
 				continue;
 			if (has_extension(de->d_name, ".lock"))
 				continue;
-			memcpy(ref + baselen, de->d_name, namelen+1);
+			memcpy(refname + baselen, de->d_name, namelen+1);
 			refdir = submodule
-				? git_path_submodule(submodule, "%s", ref)
-				: git_path("%s", ref);
+				? git_path_submodule(submodule, "%s", refname)
+				: git_path("%s", refname);
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(submodule, ref, array);
+				get_ref_dir(submodule, refname, array);
 				continue;
 			}
 			if (submodule) {
 				hashclr(sha1);
 				flag = 0;
-				if (resolve_gitlink_ref(submodule, ref, sha1) < 0) {
+				if (resolve_gitlink_ref(submodule, refname, sha1) < 0) {
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			} else if (read_ref_full(ref, sha1, 1, &flag)) {
+			} else if (read_ref_full(refname, sha1, 1, &flag)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_ref(ref, sha1, flag, 1, array, NULL);
+			add_ref(refname, sha1, flag, 1, array, NULL);
 		}
-		free(ref);
+		free(refname);
 		closedir(dir);
 	}
 }
@@ -401,7 +401,8 @@ static struct ref_array *get_loose_refs(const char *submodule)
  * from "name", which is "module/.git/<refname>". Find <refname> in
  * the packed-refs file for the submodule.
  */
-static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refname, unsigned char *result)
+static int resolve_gitlink_packed_ref(char *name, int pathlen,
+				      const char *refname, unsigned char *result)
 {
 	int retval = -1;
 	struct ref_entry *ref;
@@ -420,7 +421,9 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 	return retval;
 }
 
-static int resolve_gitlink_ref_recursive(char *name, int pathlen, const char *refname, unsigned char *result, int recursion)
+static int resolve_gitlink_ref_recursive(char *name, int pathlen,
+					 const char *refname, unsigned char *result,
+					 int recursion)
 {
 	int fd, len = strlen(refname);
 	char buffer[128], *p;
@@ -487,10 +490,10 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
  * Try to read ref from the packed references.  On success, set sha1
  * and return 0; otherwise, return -1.
  */
-static int get_packed_ref(const char *ref, unsigned char *sha1)
+static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
 	struct ref_array *packed = get_packed_refs(NULL);
-	struct ref_entry *entry = search_ref_array(packed, ref);
+	struct ref_entry *entry = search_ref_array(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->sha1);
 		return 0;
@@ -498,17 +501,17 @@ static int get_packed_ref(const char *ref, unsigned char *sha1)
 	return -1;
 }
 
-const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag)
+const char *resolve_ref(const char *refname, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
 	char buffer[256];
-	static char ref_buffer[256];
+	static char refname_buffer[256];
 
 	if (flag)
 		*flag = 0;
 
-	if (check_refname_format(ref, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		return NULL;
 
 	for (;;) {
@@ -520,7 +523,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		if (--depth < 0)
 			return NULL;
 
-		git_snpath(path, sizeof(path), "%s", ref);
+		git_snpath(path, sizeof(path), "%s", refname);
 
 		if (lstat(path, &st) < 0) {
 			if (errno != ENOENT)
@@ -529,17 +532,17 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			 * The loose reference file does not exist;
 			 * check for a packed reference.
 			 */
-			if (!get_packed_ref(ref, sha1)) {
+			if (!get_packed_ref(refname, sha1)) {
 				if (flag)
 					*flag |= REF_ISPACKED;
-				return ref;
+				return refname;
 			}
 			/* The reference is not a packed reference, either. */
 			if (reading) {
 				return NULL;
 			} else {
 				hashclr(sha1);
-				return ref;
+				return refname;
 			}
 		}
 
@@ -551,8 +554,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			buffer[len] = 0;
 			if (!prefixcmp(buffer, "refs/") &&
 					!check_refname_format(buffer, 0)) {
-				strcpy(ref_buffer, buffer);
-				ref = ref_buffer;
+				strcpy(refname_buffer, buffer);
+				refname = refname_buffer;
 				if (flag)
 					*flag |= REF_ISSYMREF;
 				continue;
@@ -595,7 +598,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 				*flag |= REF_ISBROKEN;
 			return NULL;
 		}
-		ref = strcpy(ref_buffer, buf);
+		refname = strcpy(refname_buffer, buf);
 	}
 	/* Please note that FETCH_HEAD has a second line containing other data. */
 	if (get_sha1_hex(buffer, sha1) || (buffer[40] != '\0' && !isspace(buffer[40]))) {
@@ -603,7 +606,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			*flag |= REF_ISBROKEN;
 		return NULL;
 	}
-	return ref;
+	return refname;
 }
 
 /* The argument to filter_refs */
@@ -613,16 +616,16 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *ref, unsigned char *sha1, int reading, int *flags)
+int read_ref_full(const char *refname, unsigned char *sha1, int reading, int *flags)
 {
-	if (resolve_ref(ref, sha1, reading, flags))
+	if (resolve_ref(refname, sha1, reading, flags))
 		return 0;
 	return -1;
 }
 
-int read_ref(const char *ref, unsigned char *sha1)
+int read_ref(const char *refname, unsigned char *sha1)
 {
-	return read_ref_full(ref, sha1, 1, NULL);
+	return read_ref_full(refname, sha1, 1, NULL);
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
@@ -644,23 +647,23 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
 }
 
-static int filter_refs(const char *ref, const unsigned char *sha, int flags,
-	void *data)
+static int filter_refs(const char *refname, const unsigned char *sha, int flags,
+		       void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
-	if (fnmatch(filter->pattern, ref, 0))
+	if (fnmatch(filter->pattern, refname, 0))
 		return 0;
-	return filter->fn(ref, sha, flags, filter->cb_data);
+	return filter->fn(refname, sha, flags, filter->cb_data);
 }
 
-int peel_ref(const char *ref, unsigned char *sha1)
+int peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
 	struct object *o;
 
-	if (current_ref && (current_ref->name == ref
-		|| !strcmp(current_ref->name, ref))) {
+	if (current_ref && (current_ref->name == refname
+		|| !strcmp(current_ref->name, refname))) {
 		if (current_ref->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, current_ref->peeled);
 			return 0;
@@ -669,12 +672,12 @@ int peel_ref(const char *ref, unsigned char *sha1)
 		goto fallback;
 	}
 
-	if (read_ref_full(ref, base, 1, &flag))
+	if (read_ref_full(refname, base, 1, &flag))
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
 		struct ref_array *array = get_packed_refs(NULL);
-		struct ref_entry *r = search_ref_array(array, ref);
+		struct ref_entry *r = search_ref_array(array, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->peeled);
@@ -685,7 +688,7 @@ int peel_ref(const char *ref, unsigned char *sha1)
 fallback:
 	o = parse_object(base);
 	if (o && o->type == OBJ_TAG) {
-		o = deref_tag(o, ref, 0);
+		o = deref_tag(o, refname, 0);
 		if (o) {
 			hashcpy(sha1, o->sha1);
 			return 0;
@@ -915,16 +918,16 @@ static inline int bad_ref_char(int ch)
 }
 
 /*
- * Try to read one refname component from the front of ref.  Return
+ * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
  * legal.
  */
-static int check_refname_component(const char *ref, int flags)
+static int check_refname_component(const char *refname, int flags)
 {
 	const char *cp;
 	char last = '\0';
 
-	for (cp = ref; ; cp++) {
+	for (cp = refname; ; cp++) {
 		char ch = *cp;
 		if (ch == '\0' || ch == '/')
 			break;
@@ -936,34 +939,34 @@ static int check_refname_component(const char *ref, int flags)
 			return -1; /* Refname contains "@{". */
 		last = ch;
 	}
-	if (cp == ref)
+	if (cp == refname)
 		return -1; /* Component has zero length. */
-	if (ref[0] == '.') {
+	if (refname[0] == '.') {
 		if (!(flags & REFNAME_DOT_COMPONENT))
 			return -1; /* Component starts with '.'. */
 		/*
 		 * Even if leading dots are allowed, don't allow "."
 		 * as a component (".." is prevented by a rule above).
 		 */
-		if (ref[1] == '\0')
+		if (refname[1] == '\0')
 			return -1; /* Component equals ".". */
 	}
-	if (cp - ref >= 5 && !memcmp(cp - 5, ".lock", 5))
+	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
 		return -1; /* Refname ends with ".lock". */
-	return cp - ref;
+	return cp - refname;
 }
 
-int check_refname_format(const char *ref, int flags)
+int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(ref, flags);
+		component_len = check_refname_component(refname, flags);
 		if (component_len < 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					ref[0] == '*' &&
-					(ref[1] == '\0' || ref[1] == '/')) {
+					refname[0] == '*' &&
+					(refname[1] == '\0' || refname[1] == '/')) {
 				/* Accept one wildcard as a full refname component. */
 				flags &= ~REFNAME_REFSPEC_PATTERN;
 				component_len = 1;
@@ -972,13 +975,13 @@ int check_refname_format(const char *ref, int flags)
 			}
 		}
 		component_count++;
-		if (ref[component_len] == '\0')
+		if (refname[component_len] == '\0')
 			break;
 		/* Skip to next component. */
-		ref += component_len + 1;
+		refname += component_len + 1;
 	}
 
-	if (ref[component_len - 1] == '.')
+	if (refname[component_len - 1] == '.')
 		return -1; /* Refname ends with '.'. */
 	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
 		return -1; /* Refname has only one component. */
@@ -1054,22 +1057,22 @@ static int remove_empty_directories(const char *file)
 	return result;
 }
 
-static int is_refname_available(const char *ref, const char *oldref,
+static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_array *array, int quiet)
 {
-	int i, namlen = strlen(ref); /* e.g. 'foo/bar' */
+	int i, namlen = strlen(refname); /* e.g. 'foo/bar' */
 	for (i = 0; i < array->nr; i++ ) {
 		struct ref_entry *entry = array->refs[i];
 		/* entry->name could be 'foo' or 'foo/bar/baz' */
-		if (!oldref || strcmp(oldref, entry->name)) {
+		if (!oldrefname || strcmp(oldrefname, entry->name)) {
 			int len = strlen(entry->name);
 			int cmplen = (namlen < len) ? namlen : len;
-			const char *lead = (namlen < len) ? entry->name : ref;
-			if (!strncmp(ref, entry->name, cmplen) &&
+			const char *lead = (namlen < len) ? entry->name : refname;
+			if (!strncmp(refname, entry->name, cmplen) &&
 			    lead[cmplen] == '/') {
 				if (!quiet)
 					error("'%s' exists; cannot create '%s'",
-					      entry->name, ref);
+					      entry->name, refname);
 				return 0;
 			}
 		}
@@ -1165,10 +1168,12 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1, int flags, int *type_p)
+static struct ref_lock *lock_ref_sha1_basic(const char *refname,
+					    const unsigned char *old_sha1,
+					    int flags, int *type_p)
 {
 	char *ref_file;
-	const char *orig_ref = ref;
+	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
 	int type, lflags;
@@ -1178,27 +1183,27 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	ref = resolve_ref(ref, lock->old_sha1, mustexist, &type);
-	if (!ref && errno == EISDIR) {
+	refname = resolve_ref(refname, lock->old_sha1, mustexist, &type);
+	if (!refname && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
 		 * it is normal for the empty directory 'foo'
 		 * to remain.
 		 */
-		ref_file = git_path("%s", orig_ref);
+		ref_file = git_path("%s", orig_refname);
 		if (remove_empty_directories(ref_file)) {
 			last_errno = errno;
-			error("there are still refs under '%s'", orig_ref);
+			error("there are still refs under '%s'", orig_refname);
 			goto error_return;
 		}
-		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, &type);
+		refname = resolve_ref(orig_refname, lock->old_sha1, mustexist, &type);
 	}
 	if (type_p)
 	    *type_p = type;
-	if (!ref) {
+	if (!refname) {
 		last_errno = errno;
 		error("unable to resolve reference %s: %s",
-			orig_ref, strerror(errno));
+			orig_refname, strerror(errno));
 		goto error_return;
 	}
 	missing = is_null_sha1(lock->old_sha1);
@@ -1208,7 +1213,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(ref, NULL, get_packed_refs(NULL), 0)) {
+	     !is_refname_available(refname, NULL, get_packed_refs(NULL), 0)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1217,12 +1222,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 
 	lflags = LOCK_DIE_ON_ERROR;
 	if (flags & REF_NODEREF) {
-		ref = orig_ref;
+		refname = orig_refname;
 		lflags |= LOCK_NODEREF;
 	}
-	lock->ref_name = xstrdup(ref);
-	lock->orig_ref_name = xstrdup(orig_ref);
-	ref_file = git_path("%s", ref);
+	lock->ref_name = xstrdup(refname);
+	lock->orig_ref_name = xstrdup(orig_refname);
+	ref_file = git_path("%s", refname);
 	if (missing)
 		lock->force_write = 1;
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
@@ -1243,20 +1248,21 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
+struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
-	if (check_refname_format(ref, 0))
+	if (check_refname_format(refname, 0))
 		return NULL;
-	strcpy(refpath, mkpath("refs/%s", ref));
+	strcpy(refpath, mkpath("refs/%s", refname));
 	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
+struct ref_lock *lock_any_ref_for_update(const char *refname,
+					 const unsigned char *old_sha1, int flags)
 {
-	if (check_refname_format(ref, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		return NULL;
-	return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, NULL);
 }
 
 static struct lock_file packlock;
@@ -1342,97 +1348,97 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
  */
 #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
 
-int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
+	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
 
 	if (log && S_ISLNK(loginfo.st_mode))
-		return error("reflog for %s is a symlink", oldref);
+		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref(oldref, orig_sha1, 1, &flag);
+	symref = resolve_ref(oldrefname, orig_sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
-			oldref);
+			oldrefname);
 	if (!symref)
-		return error("refname %s not found", oldref);
+		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newref, oldref, get_packed_refs(NULL), 0))
+	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL), 0))
 		return 1;
 
-	if (!is_refname_available(newref, oldref, get_loose_refs(NULL), 0))
+	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL), 0))
 		return 1;
 
-	if (log && rename(git_path("logs/%s", oldref), git_path(TMP_RENAMED_LOG)))
+	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
-			oldref, strerror(errno));
+			oldrefname, strerror(errno));
 
-	if (delete_ref(oldref, orig_sha1, REF_NODEREF)) {
-		error("unable to delete old %s", oldref);
+	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
+		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
 
-	if (!read_ref_full(newref, sha1, 1, &flag) &&
-	    delete_ref(newref, sha1, REF_NODEREF)) {
+	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
-			if (remove_empty_directories(git_path("%s", newref))) {
-				error("Directory not empty: %s", newref);
+			if (remove_empty_directories(git_path("%s", newrefname))) {
+				error("Directory not empty: %s", newrefname);
 				goto rollback;
 			}
 		} else {
-			error("unable to delete existing %s", newref);
+			error("unable to delete existing %s", newrefname);
 			goto rollback;
 		}
 	}
 
-	if (log && safe_create_leading_directories(git_path("logs/%s", newref))) {
-		error("unable to create directory for %s", newref);
+	if (log && safe_create_leading_directories(git_path("logs/%s", newrefname))) {
+		error("unable to create directory for %s", newrefname);
 		goto rollback;
 	}
 
  retry:
-	if (log && rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newref))) {
+	if (log && rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
 		if (errno==EISDIR || errno==ENOTDIR) {
 			/*
 			 * rename(a, b) when b is an existing
 			 * directory ought to result in ISDIR, but
 			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
 			 */
-			if (remove_empty_directories(git_path("logs/%s", newref))) {
-				error("Directory not empty: logs/%s", newref);
+			if (remove_empty_directories(git_path("logs/%s", newrefname))) {
+				error("Directory not empty: logs/%s", newrefname);
 				goto rollback;
 			}
 			goto retry;
 		} else {
 			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newref, strerror(errno));
+				newrefname, strerror(errno));
 			goto rollback;
 		}
 	}
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newref, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
 	if (!lock) {
-		error("unable to lock %s for update", newref);
+		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
 	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
 	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
-		error("unable to write current sha1 into %s", newref);
+		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
 	}
 
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldref, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
 	if (!lock) {
-		error("unable to lock %s for rollback", oldref);
+		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
 	}
 
@@ -1440,17 +1446,17 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_sha1(lock, orig_sha1, NULL))
-		error("unable to write current sha1 into %s", oldref);
+		error("unable to write current sha1 into %s", oldrefname);
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	if (logmoved && rename(git_path("logs/%s", newref), git_path("logs/%s", oldref)))
+	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
 		error("unable to restore logfile %s from %s: %s",
-			oldref, newref, strerror(errno));
+			oldrefname, newrefname, strerror(errno));
 	if (!logmoved && log &&
-	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldref)))
+	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
-			oldref, strerror(errno));
+			oldrefname, strerror(errno));
 
 	return 1;
 }
@@ -1507,16 +1513,16 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-int log_ref_setup(const char *ref_name, char *logfile, int bufsize)
+int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 
-	git_snpath(logfile, bufsize, "logs/%s", ref_name);
+	git_snpath(logfile, bufsize, "logs/%s", refname);
 	if (log_all_ref_updates &&
-	    (!prefixcmp(ref_name, "refs/heads/") ||
-	     !prefixcmp(ref_name, "refs/remotes/") ||
-	     !prefixcmp(ref_name, "refs/notes/") ||
-	     !strcmp(ref_name, "HEAD"))) {
+	    (!prefixcmp(refname, "refs/heads/") ||
+	     !prefixcmp(refname, "refs/remotes/") ||
+	     !prefixcmp(refname, "refs/notes/") ||
+	     !strcmp(refname, "HEAD"))) {
 		if (safe_create_leading_directories(logfile) < 0)
 			return error("unable to create directory for %s",
 				     logfile);
@@ -1546,7 +1552,7 @@ int log_ref_setup(const char *ref_name, char *logfile, int bufsize)
 	return 0;
 }
 
-static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
+static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
 	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
@@ -1559,7 +1565,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(ref_name, log_file, sizeof(log_file));
+	result = log_ref_setup(refname, log_file, sizeof(log_file));
 	if (result)
 		return result;
 
@@ -1730,7 +1736,9 @@ static char *ref_msg(const char *line, const char *endp)
 	return xmemdupz(line, ep - line);
 }
 
-int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
+int read_ref_at(const char *refname, unsigned long at_time, int cnt,
+		unsigned char *sha1, char **msg,
+		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
 	char *tz_c;
@@ -1741,7 +1749,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	void *log_mapped;
 	size_t mapsz;
 
-	logfile = git_path("logs/%s", ref);
+	logfile = git_path("logs/%s", refname);
 	logfd = open(logfile, O_RDONLY, 0);
 	if (logfd < 0)
 		die_errno("Unable to read log '%s'", logfile);
@@ -1834,14 +1842,14 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	return 1;
 }
 
-int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long ofs, void *cb_data)
+int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long ofs, void *cb_data)
 {
 	const char *logfile;
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
-	logfile = git_path("logs/%s", ref);
+	logfile = git_path("logs/%s", refname);
 	logfp = fopen(logfile, "r");
 	if (!logfp)
 		return -1;
@@ -1892,9 +1900,9 @@ int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long ofs,
 	return ret;
 }
 
-int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
+int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
 {
-	return for_each_recent_reflog_ent(ref, fn, 0, cb_data);
+	return for_each_recent_reflog_ent(refname, fn, 0, cb_data);
 }
 
 static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
@@ -2014,7 +2022,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
 	return;
 }
 
-char *shorten_unambiguous_ref(const char *ref, int strict)
+char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
 	static char **scanf_fmts;
@@ -2043,10 +2051,10 @@ char *shorten_unambiguous_ref(const char *ref, int strict)
 
 	/* bail out if there are no rules */
 	if (!nr_rules)
-		return xstrdup(ref);
+		return xstrdup(refname);
 
-	/* buffer for scanf result, at most ref must fit */
-	short_name = xstrdup(ref);
+	/* buffer for scanf result, at most refname must fit */
+	short_name = xstrdup(refname);
 
 	/* skip first rule, it will always match */
 	for (i = nr_rules - 1; i > 0 ; --i) {
@@ -2054,7 +2062,7 @@ char *shorten_unambiguous_ref(const char *ref, int strict)
 		int rules_to_fail = i;
 		int short_name_len;
 
-		if (1 != sscanf(ref, scanf_fmts[i], short_name))
+		if (1 != sscanf(refname, scanf_fmts[i], short_name))
 			continue;
 
 		short_name_len = strlen(short_name);
@@ -2098,5 +2106,5 @@ char *shorten_unambiguous_ref(const char *ref, int strict)
 	}
 
 	free(short_name);
-	return xstrdup(ref);
+	return xstrdup(refname);
 }
diff --git a/refs.h b/refs.h
index 3fd5536..e36bd03 100644
--- a/refs.h
+++ b/refs.h
@@ -60,14 +60,16 @@ extern void add_extra_ref(const char *refname, const unsigned char *sha1, int fl
 extern void clear_extra_refs(void);
 extern int ref_exists(const char *);
 
-extern int peel_ref(const char *, unsigned char *);
+extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
-extern struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1);
+extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
-extern struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags);
+extern struct ref_lock *lock_any_ref_for_update(const char *refname,
+						const unsigned char *old_sha1,
+						int flags);
 
 /** Close the file descriptor owned by a lock and return the status */
 extern int close_ref(struct ref_lock *lock);
@@ -93,12 +95,14 @@ extern void invalidate_ref_cache(const char *submodule);
 int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
+		       unsigned char *sha1, char **msg,
+		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
-int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
-int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long, void *cb_data);
+int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
+int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long, void *cb_data);
 
 /*
  * Calls the specified function for each reflog file until it returns nonzero,
@@ -111,9 +115,9 @@ extern int for_each_reflog(each_ref_fn, void *);
 #define REFNAME_DOT_COMPONENT 4
 
 /*
- * Return 0 iff ref has the correct format for a refname according to
- * the rules described in Documentation/git-check-ref-format.txt.  If
- * REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
+ * Return 0 iff refname has the correct format for a refname according
+ * to the rules described in Documentation/git-check-ref-format.txt.
+ * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
  * allow a "*" wildcard character in place of one of the name
  * components.  No leading or repeated slashes are accepted.  If
@@ -121,10 +125,10 @@ extern int for_each_reflog(each_ref_fn, void *);
  * components to start with "." (but not a whole component equal to
  * "." or "..").
  */
-extern int check_refname_format(const char *ref, int flags);
+extern int check_refname_format(const char *refname, int flags);
 
 extern const char *prettify_refname(const char *refname);
-extern char *shorten_unambiguous_ref(const char *ref, int strict);
+extern char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
-- 
1.7.8
