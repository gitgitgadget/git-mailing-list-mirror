From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/2] for-each-ref: re-structure code for moving to 'ref-filter'
Date: Mon, 25 May 2015 18:15:42 +0530
Message-ID: <1432557943-25337-1-git-send-email-karthik.188@gmail.com>
References: <556317F8.2070609@gmail.com>
Cc: christian.couder@gmail.com, matthieu.moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 14:46:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywrlv-0001kf-R2
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 14:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbbEYMqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 08:46:18 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33050 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbEYMqA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 08:46:00 -0400
Received: by pdbqa5 with SMTP id qa5so69457283pdb.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9cdULAW3kXHc+VrF21Gbm0P/+0JM1xavdK0XcsnxrE=;
        b=YjZfKMULnstpNG5gNPIy2tlqgQFYr2OQ+x0sCzK9EmdWRHVmiH41ibmztMjdg3T41m
         mQJ8/Ypmb3P8wwyelK5B/FnIdSQs9FmU732hV06t6PyZXYLZWvpSrhq2DBp5vozKXteF
         EBlKpWacuQO9emL3cYgP5jM71DArWCjSJASIoB/kJhv1H3GxMN5fVUV//0iqafEyngTq
         LXu3FUJY3cfV7TfqqFMsbYwYRRgNgpNQEs9WsAO6GQqkYhorh6a3uOaMG0+LknShpBhG
         qZht8fbPQYsAotvFDX1RTkEYvCupInCL/oXXVJzHtuW6zj+RKdFRPZLeYttjOxEPk+5Y
         zZuw==
X-Received: by 10.70.24.130 with SMTP id u2mr39709363pdf.147.1432557959894;
        Mon, 25 May 2015 05:45:59 -0700 (PDT)
Received: from ashley.localdomain ([103.227.99.94])
        by mx.google.com with ESMTPSA id ux6sm10073638pab.24.2015.05.25.05.45.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 May 2015 05:45:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <556317F8.2070609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269838>

Re-factoring and renaming of code to make meaningful, targeted
services available to other commands in efforts to change private
scope of the code to public API by moving it to 'ref-filter'.
Restructuring of code done to further modularize it to make API
provisions simple and effective.

Rename 'refinfo' to 'ref_filter_item' and intoduce 'ref_filter_data'
which will hold 'ref_filter' (Conditions to filter the refs on) and
'ref_list' (The list of ref_filter_items).

Modify the code to use 'ref_filter_data' and make some of the
functions publically available by removind the static file scope.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 212 ++++++++++++++++++++++++++++---------------------
 1 file changed, 121 insertions(+), 91 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..eb502a1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -31,12 +31,26 @@ struct ref_sort {
 	unsigned reverse : 1;
 };
 
-struct refinfo {
-	char *refname;
-	unsigned char objectname[20];
-	int flag;
+struct ref_filter_item {
+	unsigned char sha1[20];
+	int flags;
 	const char *symref;
 	struct atom_value *value;
+	char *name;
+};
+
+struct ref_list {
+	int nr, alloc;
+	struct ref_filter_item **items;
+};
+
+struct ref_filter {
+	const char **name_patterns;
+};
+
+struct ref_filter_data {
+	struct ref_list list;
+	struct ref_filter filter;
 };
 
 static struct {
@@ -85,7 +99,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  refinfo
+ * of properties that we need to extract out of objects. ref_filter_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -98,7 +112,7 @@ static int need_color_reset_at_eol;
 /*
  * Used to parse format string and sort specifiers
  */
-static int parse_atom(const char *atom, const char *ep)
+int parse_atom(const char *atom, const char *ep)
 {
 	const char *sp;
 	int i, at;
@@ -175,7 +189,7 @@ static const char *find_next(const char *cp)
  * Make sure the format string is well formed, and parse out
  * the used atoms.
  */
-static int verify_format(const char *format)
+int verify_format(const char *format)
 {
 	const char *cp, *sp;
 
@@ -622,7 +636,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct ref_filter_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -632,9 +646,9 @@ static void populate_value(struct refinfo *ref)
 
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
-	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
+	if (need_symref && (ref->flags & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
-		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
+		ref->symref = resolve_refdup(ref->name, RESOLVE_REF_READING,
 					     unused1, NULL);
 		if (!ref->symref)
 			ref->symref = "";
@@ -655,14 +669,14 @@ static void populate_value(struct refinfo *ref)
 		}
 
 		if (starts_with(name, "refname"))
-			refname = ref->refname;
+			refname = ref->name;
 		else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (starts_with(name, "upstream")) {
 			/* only local branches may have an upstream */
-			if (!starts_with(ref->refname, "refs/heads/"))
+			if (!starts_with(ref->name, "refs/heads/"))
 				continue;
-			branch = branch_get(ref->refname + 11);
+			branch = branch_get(ref->name + 11);
 
 			if (!branch || !branch->merge || !branch->merge[0] ||
 			    !branch->merge[0]->dst)
@@ -677,9 +691,9 @@ static void populate_value(struct refinfo *ref)
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
-			if (ref->flag & REF_ISSYMREF)
+			if (ref->flags & REF_ISSYMREF)
 				cp = copy_advance(cp, ",symref");
-			if (ref->flag & REF_ISPACKED)
+			if (ref->flags & REF_ISPACKED)
 				cp = copy_advance(cp, ",packed");
 			if (cp == buf)
 				v->s = "";
@@ -688,7 +702,7 @@ static void populate_value(struct refinfo *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
+		} else if (!deref && grab_objectname(name, ref->sha1, v)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
@@ -696,7 +710,7 @@ static void populate_value(struct refinfo *ref)
 
 			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 						  sha1, NULL);
-			if (!strcmp(ref->refname, head))
+			if (!strcmp(ref->name, head))
 				v->s = "*";
 			else
 				v->s = " ";
@@ -774,13 +788,13 @@ static void populate_value(struct refinfo *ref)
 	return;
 
  need_obj:
-	buf = get_obj(ref->objectname, &obj, &size, &eaten);
+	buf = get_obj(ref->sha1, &obj, &size, &eaten);
 	if (!buf)
 		die("missing object %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
+		    sha1_to_hex(ref->sha1), ref->name);
 	if (!obj)
 		die("parse_object_buffer failed on %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
+		    sha1_to_hex(ref->sha1), ref->name);
 
 	grab_values(ref->value, 0, obj, buf, size);
 	if (!eaten)
@@ -808,10 +822,10 @@ static void populate_value(struct refinfo *ref)
 	buf = get_obj(tagged, &obj, &size, &eaten);
 	if (!buf)
 		die("missing object %s for %s",
-		    sha1_to_hex(tagged), ref->refname);
+		    sha1_to_hex(tagged), ref->name);
 	if (!obj)
 		die("parse_object_buffer failed on %s for %s",
-		    sha1_to_hex(tagged), ref->refname);
+		    sha1_to_hex(tagged), ref->name);
 	grab_values(ref->value, 1, obj, buf, size);
 	if (!eaten)
 		free(buf);
@@ -821,7 +835,7 @@ static void populate_value(struct refinfo *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+static void get_value(struct ref_filter_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -830,65 +844,81 @@ static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
 	*v = &ref->value[atom];
 }
 
-struct grab_ref_cbdata {
-	struct refinfo **grab_array;
-	const char **grab_pattern;
-	int grab_cnt;
-};
+/*
+ * Given a refname, return 1 if the refname matches with one of the patterns
+ * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
+ * and so on, else return 0. Supports use of wild characters.
+ */
+static int match_name_as_path(const char **pattern, const char *refname)
+{
+	int namelen = strlen(refname);
+	for (; *pattern; pattern++) {
+		const char *p = *pattern;
+		int plen = strlen(p);
+
+		if ((plen <= namelen) &&
+		    !strncmp(refname, p, plen) &&
+		    (refname[plen] == '\0' ||
+		     refname[plen] == '/' ||
+		     p[plen-1] == '/'))
+			return 1;
+		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
+			return 1;
+	}
+	return 0;
+}
+
+/* Allocate space for a new ref_filter_item and copy the sha1 and flags to it */
+static struct ref_filter_item *new_ref_filter_item(const char *refname,
+						   const unsigned char *sha1,
+						   int flag)
+{
+	struct ref_filter_item *ref = xcalloc(1, sizeof(struct ref_filter_item));
+	ref->name = xstrdup(refname);
+	hashcpy(ref->sha1, sha1);
+	ref->flags = flag;
+
+	return ref;
+}
 
 /*
- * A call-back given to for_each_ref().  Filter refs and keep them for
- * later object processing.
+ * A call-back given to for_each_ref(). Process the refs and store only required refs
+ * into the ref_filter_data structure.
  */
-static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *data)
 {
-	struct grab_ref_cbdata *cb = cb_data;
-	struct refinfo *ref;
-	int cnt;
+	struct ref_filter_data *ref_data = data;
+	struct ref_filter_item *ref;
 
 	if (flag & REF_BAD_NAME) {
-		  warning("ignoring ref with broken name %s", refname);
-		  return 0;
+		warning("ignoring ref with broken name %s", refname);
+		return 0;
 	}
 
-	if (*cb->grab_pattern) {
-		const char **pattern;
-		int namelen = strlen(refname);
-		for (pattern = cb->grab_pattern; *pattern; pattern++) {
-			const char *p = *pattern;
-			int plen = strlen(p);
-
-			if ((plen <= namelen) &&
-			    !strncmp(refname, p, plen) &&
-			    (refname[plen] == '\0' ||
-			     refname[plen] == '/' ||
-			     p[plen-1] == '/'))
-				break;
-			if (!wildmatch(p, refname, WM_PATHNAME, NULL))
-				break;
-		}
-		if (!*pattern)
-			return 0;
-	}
+	if (*ref_data->filter.name_patterns && !match_name_as_path(ref_data->filter.name_patterns, refname))
+		return 0;
+
+	ref = new_ref_filter_item(refname, sha1, flag);
+
+	REALLOC_ARRAY(ref_data->list.items, ref_data->list.nr + 1);
+	ref_data->list.items[ref_data->list.nr++] = ref;
 
-	/*
-	 * We do not open the object yet; sort may only need refname
-	 * to do its job and the resulting list may yet to be pruned
-	 * by maxcount logic.
-	 */
-	ref = xcalloc(1, sizeof(*ref));
-	ref->refname = xstrdup(refname);
-	hashcpy(ref->objectname, sha1);
-	ref->flag = flag;
-
-	cnt = cb->grab_cnt;
-	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-	cb->grab_array[cnt++] = ref;
-	cb->grab_cnt = cnt;
 	return 0;
 }
 
-static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+/* Free all memory allocated for ref_filter_data */
+void ref_filter_clear(struct ref_filter_data *ref_data)
+{
+	int i;
+
+	for (i = 0; i < ref_data->list.nr; i++)
+		free(ref_data->list.items[i]);
+	free(ref_data->list.items);
+	ref_data->list.items = NULL;
+	ref_data->list.nr = ref_data->list.alloc = 0;
+}
+
+static int cmp_ref_sort(struct ref_sort *s, struct ref_filter_item *a, struct ref_filter_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -915,8 +945,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b
 static struct ref_sort *ref_sort;
 static int compare_refs(const void *a_, const void *b_)
 {
-	struct refinfo *a = *((struct refinfo **)a_);
-	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_filter_item *a = *((struct ref_filter_item **)a_);
+	struct ref_filter_item *b = *((struct ref_filter_item **)b_);
 	struct ref_sort *s;
 
 	for (s = ref_sort; s; s = s->next) {
@@ -927,10 +957,11 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs)
+void sort_refs(struct ref_sort *sort, struct ref_filter_data *ref_data)
 {
 	ref_sort = sort;
-	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
+	qsort(ref_data->list.items, ref_data->list.nr,
+	      sizeof(struct ref_filter_item *), compare_refs);
 }
 
 static void print_value(struct atom_value *v, int quote_style)
@@ -997,7 +1028,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct refinfo *info, const char *format, int quote_style)
+void show_ref(struct ref_filter_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1026,7 +1057,8 @@ static void show_ref(struct refinfo *info, const char *format, int quote_style)
 	putchar('\n');
 }
 
-static struct ref_sort *default_sort(void)
+/*  If no sorting option is given, use refname to sort as default */
+struct ref_sort *ref_default_sort(void)
 {
 	static const char cstr_name[] = "refname";
 
@@ -1037,7 +1069,7 @@ static struct ref_sort *default_sort(void)
 	return sort;
 }
 
-static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
+int ref_opt_parse_sort(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_sort **sort_tail = opt->value;
 	struct ref_sort *s;
@@ -1066,12 +1098,12 @@ static char const * const for_each_ref_usage[] = {
 
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i, num_refs;
+	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct refinfo **refs;
-	struct grab_ref_cbdata cbdata;
+	struct ref_filter_data ref_data;
+	memset(&ref_data, 0, sizeof(ref_data));
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1087,7 +1119,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
-			    N_("field name to sort on"), &opt_parse_sort),
+			    N_("field name to sort on"), &ref_opt_parse_sort),
 		OPT_END(),
 	};
 
@@ -1104,22 +1136,20 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		usage_with_options(for_each_ref_usage, opts);
 
 	if (!sort)
-		sort = default_sort();
+		sort = ref_default_sort();
 
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.grab_pattern = argv;
-	for_each_rawref(grab_single_ref, &cbdata);
-	refs = cbdata.grab_array;
-	num_refs = cbdata.grab_cnt;
+	ref_data.filter.name_patterns = argv;
+	for_each_rawref(ref_filter_handler, &ref_data);
 
-	sort_refs(sort, refs, num_refs);
+	sort_refs(sort, &ref_data);
 
-	if (!maxcount || num_refs < maxcount)
-		maxcount = num_refs;
+	if (!maxcount || ref_data.list.nr < maxcount)
+		maxcount = ref_data.list.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref(refs[i], format, quote_style);
+		show_ref(ref_data.list.items[i], format, quote_style);
+	ref_filter_clear(&ref_data);
 	return 0;
 }
-- 
2.4.1
