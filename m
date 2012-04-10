From: mhagger@alum.mit.edu
Subject: [PATCH 01/15] refs.c: reorder definitions more logically
Date: Tue, 10 Apr 2012 07:30:13 +0200
Message-ID: <1334035827-20331-2-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfc-0002Gn-4F
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab2DJFav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:30:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59185 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab2DJFas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:48 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXds000870;
	Tue, 10 Apr 2012 07:30:36 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195059>

From: Michael Haggerty <mhagger@alum.mit.edu>

Reorder definitions in file: first check_refname_format() and helper
functions, then the functions for managing the ref_entry and ref_array
data structures, then ref_cache, then the more "business-logicky"
stuff.  No code is changed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  509 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 256 insertions(+), 253 deletions(-)

diff --git a/refs.c b/refs.c
index c9f6835..0c9ca4c 100644
--- a/refs.c
+++ b/refs.c
@@ -4,16 +4,102 @@
 #include "tag.h"
 #include "dir.h"
 
-/* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
-#define REF_KNOWS_PEELED 0x10
+/*
+ * Make sure "ref" is something reasonable to have under ".git/refs/";
+ * We do not like it if:
+ *
+ * - any path component of it begins with ".", or
+ * - it has double dots "..", or
+ * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
+ * - it ends with a "/".
+ * - it ends with ".lock"
+ * - it contains a "\" (backslash)
+ */
 
-struct ref_entry {
-	unsigned char flag; /* ISSYMREF? ISPACKED? */
-	unsigned char sha1[20];
-	unsigned char peeled[20];
-	/* The full name of the reference (e.g., "refs/heads/master"): */
-	char name[FLEX_ARRAY];
-};
+/* Return true iff ch is not allowed in reference names. */
+static inline int bad_ref_char(int ch)
+{
+	if (((unsigned) ch) <= ' ' || ch == 0x7f ||
+	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
+		return 1;
+	/* 2.13 Pattern Matching Notation */
+	if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
+		return 1;
+	return 0;
+}
+
+/*
+ * Try to read one refname component from the front of refname.  Return
+ * the length of the component found, or -1 if the component is not
+ * legal.
+ */
+static int check_refname_component(const char *refname, int flags)
+{
+	const char *cp;
+	char last = '\0';
+
+	for (cp = refname; ; cp++) {
+		char ch = *cp;
+		if (ch == '\0' || ch == '/')
+			break;
+		if (bad_ref_char(ch))
+			return -1; /* Illegal character in refname. */
+		if (last == '.' && ch == '.')
+			return -1; /* Refname contains "..". */
+		if (last == '@' && ch == '{')
+			return -1; /* Refname contains "@{". */
+		last = ch;
+	}
+	if (cp == refname)
+		return -1; /* Component has zero length. */
+	if (refname[0] == '.') {
+		if (!(flags & REFNAME_DOT_COMPONENT))
+			return -1; /* Component starts with '.'. */
+		/*
+		 * Even if leading dots are allowed, don't allow "."
+		 * as a component (".." is prevented by a rule above).
+		 */
+		if (refname[1] == '\0')
+			return -1; /* Component equals ".". */
+	}
+	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+		return -1; /* Refname ends with ".lock". */
+	return cp - refname;
+}
+
+int check_refname_format(const char *refname, int flags)
+{
+	int component_len, component_count = 0;
+
+	while (1) {
+		/* We are at the start of a path component. */
+		component_len = check_refname_component(refname, flags);
+		if (component_len < 0) {
+			if ((flags & REFNAME_REFSPEC_PATTERN) &&
+					refname[0] == '*' &&
+					(refname[1] == '\0' || refname[1] == '/')) {
+				/* Accept one wildcard as a full refname component. */
+				flags &= ~REFNAME_REFSPEC_PATTERN;
+				component_len = 1;
+			} else {
+				return -1;
+			}
+		}
+		component_count++;
+		if (refname[component_len] == '\0')
+			break;
+		/* Skip to next component. */
+		refname += component_len + 1;
+	}
+
+	if (refname[component_len - 1] == '.')
+		return -1; /* Refname ends with '.'. */
+	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+		return -1; /* Refname has only one component. */
+	return 0;
+}
+
+struct ref_entry;
 
 struct ref_array {
 	int nr, alloc;
@@ -29,38 +115,16 @@ struct ref_array {
 	struct ref_entry **refs;
 };
 
-/*
- * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
- * Return a pointer to the refname within the line (null-terminated),
- * or NULL if there was a problem.
- */
-static const char *parse_ref_line(char *line, unsigned char *sha1)
-{
-	/*
-	 * 42: the answer to everything.
-	 *
-	 * In this case, it happens to be the answer to
-	 *  40 (length of sha1 hex representation)
-	 *  +1 (space in between hex and name)
-	 *  +1 (newline at the end of the line)
-	 */
-	int len = strlen(line) - 42;
-
-	if (len <= 0)
-		return NULL;
-	if (get_sha1_hex(line, sha1) < 0)
-		return NULL;
-	if (!isspace(line[40]))
-		return NULL;
-	line += 41;
-	if (isspace(*line))
-		return NULL;
-	if (line[len] != '\n')
-		return NULL;
-	line[len] = 0;
+/* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
+#define REF_KNOWS_PEELED 0x10
 
-	return line;
-}
+struct ref_entry {
+	unsigned char flag; /* ISSYMREF? ISPACKED? */
+	unsigned char sha1[20];
+	unsigned char peeled[20];
+	/* The full name of the reference (e.g., "refs/heads/master"): */
+	char name[FLEX_ARRAY];
+};
 
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
@@ -88,6 +152,16 @@ static void add_ref(struct ref_array *refs, struct ref_entry *ref)
 	refs->refs[refs->nr++] = ref;
 }
 
+static void clear_ref_array(struct ref_array *array)
+{
+	int i;
+	for (i = 0; i < array->nr; i++)
+		free(array->refs[i]);
+	free(array->refs);
+	array->sorted = array->nr = array->alloc = 0;
+	array->refs = NULL;
+}
+
 static int ref_entry_cmp(const void *a, const void *b)
 {
 	struct ref_entry *one = *(struct ref_entry **)a;
@@ -95,6 +169,33 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
+static void sort_ref_array(struct ref_array *array);
+
+static struct ref_entry *search_ref_array(struct ref_array *array, const char *refname)
+{
+	struct ref_entry *e, **r;
+	int len;
+
+	if (refname == NULL)
+		return NULL;
+
+	if (!array->nr)
+		return NULL;
+	sort_ref_array(array);
+	len = strlen(refname) + 1;
+	e = xmalloc(sizeof(struct ref_entry) + len);
+	memcpy(e->name, refname, len);
+
+	r = bsearch(&e, array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+
+	free(e);
+
+	if (r == NULL)
+		return NULL;
+
+	return *r;
+}
+
 /*
  * Emit a warning and return true iff ref1 and ref2 have the same name
  * and the same sha1.  Die if they have the same name but different
@@ -142,29 +243,55 @@ static void sort_ref_array(struct ref_array *array)
 	array->sorted = array->nr = i + 1;
 }
 
-static struct ref_entry *search_ref_array(struct ref_array *array, const char *refname)
-{
-	struct ref_entry *e, **r;
-	int len;
-
-	if (refname == NULL)
-		return NULL;
-
-	if (!array->nr)
-		return NULL;
-	sort_ref_array(array);
-	len = strlen(refname) + 1;
-	e = xmalloc(sizeof(struct ref_entry) + len);
-	memcpy(e->name, refname, len);
+#define DO_FOR_EACH_INCLUDE_BROKEN 01
 
-	r = bsearch(&e, array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+static struct ref_entry *current_ref;
 
-	free(e);
+static int do_one_ref(const char *base, each_ref_fn fn, int trim,
+		      int flags, void *cb_data, struct ref_entry *entry)
+{
+	if (prefixcmp(entry->name, base))
+		return 0;
 
-	if (r == NULL)
-		return NULL;
+	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
+		if (entry->flag & REF_ISBROKEN)
+			return 0; /* ignore broken refs e.g. dangling symref */
+		if (!has_sha1_file(entry->sha1)) {
+			error("%s does not point to a valid object!", entry->name);
+			return 0;
+		}
+	}
+	current_ref = entry;
+	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
+}
 
-	return *r;
+/*
+ * Return true iff a reference named refname could be created without
+ * conflicting with the name of an existing reference.  If oldrefname
+ * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
+ * because oldrefname is scheduled for deletion in the same
+ * operation).
+ */
+static int is_refname_available(const char *refname, const char *oldrefname,
+				struct ref_array *array)
+{
+	int i, namlen = strlen(refname); /* e.g. 'foo/bar' */
+	for (i = 0; i < array->nr; i++ ) {
+		struct ref_entry *entry = array->refs[i];
+		/* entry->name could be 'foo' or 'foo/bar/baz' */
+		if (!oldrefname || strcmp(oldrefname, entry->name)) {
+			int len = strlen(entry->name);
+			int cmplen = (namlen < len) ? namlen : len;
+			const char *lead = (namlen < len) ? entry->name : refname;
+			if (!strncmp(refname, entry->name, cmplen) &&
+			    lead[cmplen] == '/') {
+				error("'%s' exists; cannot create '%s'",
+				      entry->name, refname);
+				return 0;
+			}
+		}
+	}
+	return 1;
 }
 
 /*
@@ -181,18 +308,6 @@ static struct ref_cache {
 	char name[FLEX_ARRAY];
 } *ref_cache;
 
-static struct ref_entry *current_ref;
-
-static void clear_ref_array(struct ref_array *array)
-{
-	int i;
-	for (i = 0; i < array->nr; i++)
-		free(array->refs[i]);
-	free(array->refs);
-	array->sorted = array->nr = array->alloc = 0;
-	array->refs = NULL;
-}
-
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->did_packed)
@@ -249,6 +364,39 @@ void invalidate_ref_cache(const char *submodule)
 	clear_loose_ref_cache(refs);
 }
 
+/*
+ * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
+ * Return a pointer to the refname within the line (null-terminated),
+ * or NULL if there was a problem.
+ */
+static const char *parse_ref_line(char *line, unsigned char *sha1)
+{
+	/*
+	 * 42: the answer to everything.
+	 *
+	 * In this case, it happens to be the answer to
+	 *  40 (length of sha1 hex representation)
+	 *  +1 (space in between hex and name)
+	 *  +1 (newline at the end of the line)
+	 */
+	int len = strlen(line) - 42;
+
+	if (len <= 0)
+		return NULL;
+	if (get_sha1_hex(line, sha1) < 0)
+		return NULL;
+	if (!isspace(line[40]))
+		return NULL;
+	line += 41;
+	if (isspace(*line))
+		return NULL;
+	if (line[len] != '\n')
+		return NULL;
+	line[len] = 0;
+
+	return line;
+}
+
 static void read_packed_refs(FILE *f, struct ref_array *array)
 {
 	struct ref_entry *last = NULL;
@@ -320,7 +468,6 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 	else
 		path = git_path("%s", base);
 
-
 	dir = opendir(path);
 
 	if (dir) {
@@ -374,40 +521,6 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 	}
 }
 
-struct warn_if_dangling_data {
-	FILE *fp;
-	const char *refname;
-	const char *msg_fmt;
-};
-
-static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
-				   int flags, void *cb_data)
-{
-	struct warn_if_dangling_data *d = cb_data;
-	const char *resolves_to;
-	unsigned char junk[20];
-
-	if (!(flags & REF_ISSYMREF))
-		return 0;
-
-	resolves_to = resolve_ref_unsafe(refname, junk, 0, NULL);
-	if (!resolves_to || strcmp(resolves_to, d->refname))
-		return 0;
-
-	fprintf(d->fp, d->msg_fmt, refname);
-	return 0;
-}
-
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
-{
-	struct warn_if_dangling_data data;
-
-	data.fp = fp;
-	data.refname = refname;
-	data.msg_fmt = msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
-}
-
 static struct ref_array *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
@@ -645,23 +758,10 @@ int read_ref(const char *refname, unsigned char *sha1)
 	return read_ref_full(refname, sha1, 1, NULL);
 }
 
-#define DO_FOR_EACH_INCLUDE_BROKEN 01
-static int do_one_ref(const char *base, each_ref_fn fn, int trim,
-		      int flags, void *cb_data, struct ref_entry *entry)
+int ref_exists(const char *refname)
 {
-	if (prefixcmp(entry->name, base))
-		return 0;
-
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
-		if (entry->flag & REF_ISBROKEN)
-			return 0; /* ignore broken refs e.g. dangling symref */
-		if (!has_sha1_file(entry->sha1)) {
-			error("%s does not point to a valid object!", entry->name);
-			return 0;
-		}
-	}
-	current_ref = entry;
-	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
+	unsigned char sha1[20];
+	return !!resolve_ref_unsafe(refname, sha1, 1, NULL);
 }
 
 static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
@@ -714,6 +814,40 @@ fallback:
 	return -1;
 }
 
+struct warn_if_dangling_data {
+	FILE *fp;
+	const char *refname;
+	const char *msg_fmt;
+};
+
+static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
+				   int flags, void *cb_data)
+{
+	struct warn_if_dangling_data *d = cb_data;
+	const char *resolves_to;
+	unsigned char junk[20];
+
+	if (!(flags & REF_ISSYMREF))
+		return 0;
+
+	resolves_to = resolve_ref_unsafe(refname, junk, 0, NULL);
+	if (!resolves_to || strcmp(resolves_to, d->refname))
+		return 0;
+
+	fprintf(d->fp, d->msg_fmt, refname);
+	return 0;
+}
+
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = refname;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
+
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
@@ -757,7 +891,6 @@ end_each:
 	return retval;
 }
 
-
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];
@@ -908,101 +1041,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-/*
- * Make sure "ref" is something reasonable to have under ".git/refs/";
- * We do not like it if:
- *
- * - any path component of it begins with ".", or
- * - it has double dots "..", or
- * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
- * - it ends with a "/".
- * - it ends with ".lock"
- * - it contains a "\" (backslash)
- */
-
-/* Return true iff ch is not allowed in reference names. */
-static inline int bad_ref_char(int ch)
-{
-	if (((unsigned) ch) <= ' ' || ch == 0x7f ||
-	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
-		return 1;
-	/* 2.13 Pattern Matching Notation */
-	if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
-		return 1;
-	return 0;
-}
-
-/*
- * Try to read one refname component from the front of refname.  Return
- * the length of the component found, or -1 if the component is not
- * legal.
- */
-static int check_refname_component(const char *refname, int flags)
-{
-	const char *cp;
-	char last = '\0';
-
-	for (cp = refname; ; cp++) {
-		char ch = *cp;
-		if (ch == '\0' || ch == '/')
-			break;
-		if (bad_ref_char(ch))
-			return -1; /* Illegal character in refname. */
-		if (last == '.' && ch == '.')
-			return -1; /* Refname contains "..". */
-		if (last == '@' && ch == '{')
-			return -1; /* Refname contains "@{". */
-		last = ch;
-	}
-	if (cp == refname)
-		return -1; /* Component has zero length. */
-	if (refname[0] == '.') {
-		if (!(flags & REFNAME_DOT_COMPONENT))
-			return -1; /* Component starts with '.'. */
-		/*
-		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is prevented by a rule above).
-		 */
-		if (refname[1] == '\0')
-			return -1; /* Component equals ".". */
-	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
-		return -1; /* Refname ends with ".lock". */
-	return cp - refname;
-}
-
-int check_refname_format(const char *refname, int flags)
-{
-	int component_len, component_count = 0;
-
-	while (1) {
-		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, flags);
-		if (component_len < 0) {
-			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					refname[0] == '*' &&
-					(refname[1] == '\0' || refname[1] == '/')) {
-				/* Accept one wildcard as a full refname component. */
-				flags &= ~REFNAME_REFSPEC_PATTERN;
-				component_len = 1;
-			} else {
-				return -1;
-			}
-		}
-		component_count++;
-		if (refname[component_len] == '\0')
-			break;
-		/* Skip to next component. */
-		refname += component_len + 1;
-	}
-
-	if (refname[component_len - 1] == '.')
-		return -1; /* Refname ends with '.'. */
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
-		return -1; /* Refname has only one component. */
-	return 0;
-}
-
 const char *prettify_refname(const char *name)
 {
 	return name + (
@@ -1073,35 +1111,6 @@ static int remove_empty_directories(const char *file)
 }
 
 /*
- * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference.  If oldrefname
- * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
- * because oldrefname is scheduled for deletion in the same
- * operation).
- */
-static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_array *array)
-{
-	int i, namlen = strlen(refname); /* e.g. 'foo/bar' */
-	for (i = 0; i < array->nr; i++ ) {
-		struct ref_entry *entry = array->refs[i];
-		/* entry->name could be 'foo' or 'foo/bar/baz' */
-		if (!oldrefname || strcmp(oldrefname, entry->name)) {
-			int len = strlen(entry->name);
-			int cmplen = (namlen < len) ? namlen : len;
-			const char *lead = (namlen < len) ? entry->name : refname;
-			if (!strncmp(refname, entry->name, cmplen) &&
-			    lead[cmplen] == '/') {
-				error("'%s' exists; cannot create '%s'",
-				      entry->name, refname);
-				return 0;
-			}
-		}
-	}
-	return 1;
-}
-
-/*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
  * to name a branch.
@@ -2004,12 +2013,6 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
-int ref_exists(const char *refname)
-{
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, sha1, 1, NULL);
-}
-
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list = list->next)
-- 
1.7.10
