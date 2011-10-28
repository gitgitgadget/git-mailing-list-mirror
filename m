From: mhagger@alum.mit.edu
Subject: [PATCH 01/28] refs.c: reorder definitions more logically
Date: Fri, 28 Oct 2011 14:28:14 +0200
Message-ID: <1319804921-17545-2-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:29:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlYy-0003gi-5Q
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab1J1M3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:29:15 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55681 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-DU; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184378>

From: Michael Haggerty <mhagger@alum.mit.edu>

Reorder definitions in file: first check_refname_format() and helper
functions, then the functions for managing the ref_entry and ref_array
data structures, then ref_cache, then the more "business-logicky"
stuff.  No code is changed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  669 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 336 insertions(+), 333 deletions(-)

diff --git a/refs.c b/refs.c
index 96466f3..56868a5 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,108 @@
 #include "tag.h"
 #include "dir.h"
 
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
+
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
+
+struct ref_array {
+	int nr, alloc;
+	struct ref_entry **refs;
+};
+
 /* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
 #define REF_KNOWS_PEELED 0x10
 
@@ -15,47 +117,6 @@ struct ref_entry {
 	char name[FLEX_ARRAY];
 };
 
-struct ref_array {
-	int nr, alloc;
-	struct ref_entry **refs;
-};
-
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
-
-	if (check_refname_format(line, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
-
-	return line;
-}
-
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag)
 {
@@ -80,6 +141,16 @@ static void add_ref(struct ref_array *refs, struct ref_entry *ref)
 	refs->refs[refs->nr++] = ref;
 }
 
+static void clear_ref_array(struct ref_array *array)
+{
+	int i;
+	for (i = 0; i < array->nr; i++)
+		free(array->refs[i]);
+	free(array->refs);
+	array->nr = array->alloc = 0;
+	array->refs = NULL;
+}
+
 static int ref_entry_cmp(const void *a, const void *b)
 {
 	struct ref_entry *one = *(struct ref_entry **)a;
@@ -87,6 +158,31 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
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
+
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
@@ -130,29 +226,137 @@ static void sort_ref_array(struct ref_array *array)
 	array->nr = i + 1;
 }
 
-static struct ref_entry *search_ref_array(struct ref_array *array, const char *refname)
+#define DO_FOR_EACH_INCLUDE_BROKEN 01
+
+static struct ref_entry *current_ref;
+
+static int do_one_ref(const char *base, each_ref_fn fn, int trim,
+		      int flags, void *cb_data, struct ref_entry *entry)
 {
-	struct ref_entry *e, **r;
-	int len;
+	if (prefixcmp(entry->name, base))
+		return 0;
 
-	if (refname == NULL)
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
 
-	if (!array->nr)
-		return NULL;
+static int do_for_each_ref_in_array(struct ref_array *array, int offset,
+				    const char *base,
+				    each_ref_fn fn, int trim, int flags, void *cb_data)
+{
+	int i;
+	for (i = offset; i < array->nr; i++) {
+		int retval = do_one_ref(base, fn, trim, flags, cb_data, array->refs[i]);
+		if (retval)
+			return retval;
+	}
+	return 0;
+}
 
-	len = strlen(refname) + 1;
-	e = xmalloc(sizeof(struct ref_entry) + len);
-	memcpy(e->name, refname, len);
+static int do_for_each_ref_in_arrays(struct ref_array *array1,
+				     struct ref_array *array2,
+				     const char *base, each_ref_fn fn, int trim,
+				     int flags, void *cb_data)
+{
+	int retval;
+	int i1 = 0, i2 = 0;
 
-	r = bsearch(&e, array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+	while (1) {
+		struct ref_entry *e1, *e2;
+		int cmp;
+		if (i1 == array1->nr) {
+			return do_for_each_ref_in_array(array2, i2,
+							base, fn, trim, flags, cb_data);
+		}
+		if (i2 == array2->nr) {
+			return do_for_each_ref_in_array(array1, i1,
+							base, fn, trim, flags, cb_data);
+		}
+		e1 = array1->refs[i1];
+		e2 = array2->refs[i2];
+		cmp = strcmp(e1->name, e2->name);
+		if (cmp == 0) {
+			/* Two refs with the same name; ignore the one from array1. */
+			i1++;
+			continue;
+		}
+		if (cmp < 0) {
+			retval = do_one_ref(base, fn, trim, flags, cb_data, e1);
+			i1++;
+		} else {
+			retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
+			i2++;
+		}
+		if (retval)
+			return retval;
+	}
+}
 
-	free(e);
+/*
+ * Return true iff refname1 and refname2 conflict with each other.
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ */
+static int names_conflict(const char *refname1, const char *refname2)
+{
+	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
+		;
+	return (*refname1 == '\0' && *refname2 == '/')
+		|| (*refname1 == '/' && *refname2 == '\0');
+}
 
-	if (r == NULL)
-		return NULL;
+struct name_conflict_cb {
+	const char *refname;
+	const char *oldrefname;
+	const char *conflicting_refname;
+};
 
-	return *r;
+static int name_conflict_fn(const char *existingrefname, const unsigned char *sha1,
+			    int flags, void *cb_data)
+{
+	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
+	if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
+		return 0;
+	if (names_conflict(data->refname, existingrefname)) {
+		data->conflicting_refname = existingrefname;
+		return 1;
+	}
+	return 0;
+}
+
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
+	struct name_conflict_cb data;
+	data.refname = refname;
+	data.oldrefname = oldrefname;
+	data.conflicting_refname = NULL;
+
+	if (do_for_each_ref_in_array(array, 0, "", name_conflict_fn,
+				     0, DO_FOR_EACH_INCLUDE_BROKEN,
+				     &data)) {
+		error("'%s' exists; cannot create '%s'",
+		      data.conflicting_refname, refname);
+		return 0;
+	}
+	return 1;
 }
 
 /*
@@ -169,20 +373,8 @@ static struct ref_cache {
 	char name[FLEX_ARRAY];
 } *ref_cache;
 
-static struct ref_entry *current_ref;
-
 static struct ref_array extra_refs;
 
-static void clear_ref_array(struct ref_array *array)
-{
-	int i;
-	for (i = 0; i < array->nr; i++)
-		free(array->refs[i]);
-	free(array->refs);
-	array->nr = array->alloc = 0;
-	array->refs = NULL;
-}
-
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->did_packed)
@@ -239,6 +431,42 @@ void invalidate_ref_cache(const char *submodule)
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
+	if (check_refname_format(line, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
+	return line;
+}
+
 static void read_packed_refs(FILE *f, struct ref_array *array)
 {
 	struct ref_entry *last = NULL;
@@ -355,53 +583,19 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 				hashclr(sha1);
 				flag = 0;
 				if (resolve_gitlink_ref(refs->name, refname, sha1) < 0) {
-					hashclr(sha1);
-					flag |= REF_ISBROKEN;
-				}
-			} else
-				if (!resolve_ref(refname, sha1, 1, &flag)) {
-					hashclr(sha1);
-					flag |= REF_ISBROKEN;
-				}
-			add_ref(array, create_ref_entry(refname, sha1, flag));
-		}
-		free(refname);
-		closedir(dir);
-	}
-}
-
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
-	resolves_to = resolve_ref(refname, junk, 0, NULL);
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
+					hashclr(sha1);
+					flag |= REF_ISBROKEN;
+				}
+			} else
+				if (!resolve_ref(refname, sha1, 1, &flag)) {
+					hashclr(sha1);
+					flag |= REF_ISBROKEN;
+				}
+			add_ref(array, create_ref_entry(refname, sha1, flag));
+		}
+		free(refname);
+		closedir(dir);
+	}
 }
 
 static struct ref_array *get_loose_refs(struct ref_cache *refs)
@@ -631,27 +825,8 @@ int read_ref(const char *refname, unsigned char *sha1)
 	return -1;
 }
 
-#define DO_FOR_EACH_INCLUDE_BROKEN 01
-static int do_one_ref(const char *base, each_ref_fn fn, int trim,
-		      int flags, void *cb_data, struct ref_entry *entry)
-{
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
-}
-
 static int filter_refs(const char *refname, const unsigned char *sha, int flags,
-	void *data)
+		       void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 	if (fnmatch(filter->pattern, refname, 0))
@@ -700,56 +875,38 @@ fallback:
 	return -1;
 }
 
-static int do_for_each_ref_in_array(struct ref_array *array, int offset,
-				    const char *base,
-				    each_ref_fn fn, int trim, int flags, void *cb_data)
+struct warn_if_dangling_data {
+	FILE *fp;
+	const char *refname;
+	const char *msg_fmt;
+};
+
+static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
+				   int flags, void *cb_data)
 {
-	int i;
-	for (i = offset; i < array->nr; i++) {
-		int retval = do_one_ref(base, fn, trim, flags, cb_data, array->refs[i]);
-		if (retval)
-			return retval;
-	}
+	struct warn_if_dangling_data *d = cb_data;
+	const char *resolves_to;
+	unsigned char junk[20];
+
+	if (!(flags & REF_ISSYMREF))
+		return 0;
+
+	resolves_to = resolve_ref(refname, junk, 0, NULL);
+	if (!resolves_to || strcmp(resolves_to, d->refname))
+		return 0;
+
+	fprintf(d->fp, d->msg_fmt, refname);
 	return 0;
 }
 
-static int do_for_each_ref_in_arrays(struct ref_array *array1,
-				     struct ref_array *array2,
-				     const char *base, each_ref_fn fn, int trim,
-				     int flags, void *cb_data)
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 {
-	int retval;
-	int i1 = 0, i2 = 0;
+	struct warn_if_dangling_data data;
 
-	while (1) {
-		struct ref_entry *e1, *e2;
-		int cmp;
-		if (i1 == array1->nr) {
-			return do_for_each_ref_in_array(array2, i2,
-							base, fn, trim, flags, cb_data);
-		}
-		if (i2 == array2->nr) {
-			return do_for_each_ref_in_array(array1, i1,
-							base, fn, trim, flags, cb_data);
-		}
-		e1 = array1->refs[i1];
-		e2 = array2->refs[i2];
-		cmp = strcmp(e1->name, e2->name);
-		if (cmp == 0) {
-			/* Two refs with the same name; ignore the one from array1. */
-			i1++;
-			continue;
-		}
-		if (cmp < 0) {
-			retval = do_one_ref(base, fn, trim, flags, cb_data, e1);
-			i1++;
-		} else {
-			retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
-			i2++;
-		}
-		if (retval)
-			return retval;
-	}
+	data.fp = fp;
+	data.refname = refname;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
@@ -920,101 +1077,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
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
@@ -1092,65 +1154,6 @@ static int remove_empty_directories(const char *file)
 }
 
 /*
- * Return true iff refname1 and refname2 conflict with each other.
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
- */
-static int names_conflict(const char *refname1, const char *refname2)
-{
-	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
-		;
-	return (*refname1 == '\0' && *refname2 == '/')
-		|| (*refname1 == '/' && *refname2 == '\0');
-}
-
-struct name_conflict_cb {
-	const char *refname;
-	const char *oldrefname;
-	const char *conflicting_refname;
-};
-
-static int name_conflict_fn(const char *existingrefname, const unsigned char *sha1,
-			    int flags, void *cb_data)
-{
-	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
-		return 0;
-	if (names_conflict(data->refname, existingrefname)) {
-		data->conflicting_refname = existingrefname;
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference.  If oldrefname
- * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
- * because oldrefname is scheduled for deletion in the same
- * operation).
- */
-static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_array *array)
-{
-	struct name_conflict_cb data;
-	data.refname = refname;
-	data.oldrefname = oldrefname;
-	data.conflicting_refname = NULL;
-
-	if (do_for_each_ref_in_array(array, 0, "", name_conflict_fn,
-				     0, DO_FOR_EACH_INCLUDE_BROKEN,
-				     &data)) {
-		error("'%s' exists; cannot create '%s'",
-		      data.conflicting_refname, refname);
-		return 0;
-	}
-	return 1;
-}
-
-/*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
  * to name a branch.
-- 
1.7.7
