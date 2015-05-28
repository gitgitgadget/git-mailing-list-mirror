From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/WIP v3 2/4] for-each-ref: introduce new structures for better organisation
Date: Thu, 28 May 2015 23:13:43 +0530
Message-ID: <1432835025-13291-2-git-send-email-karthik.188@gmail.com>
References: <5567527A.6090607@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 19:44:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1ql-0005MF-1m
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbbE1RoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:44:07 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34624 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbbE1RoD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:44:03 -0400
Received: by pabru16 with SMTP id ru16so28578744pab.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQNIzJReN3GPZLx44dAtroH1LpNu1uV816Py2VMrOsM=;
        b=D/SYA2vYFovY/EbIaKtQaZr7JrVFtLPsJB6QSsaervsBXEk0cAYlPpgBphI7RfEPI8
         o5TSOTS3+PBk8NZbjw5MvOYQzIiUdxJJsmKhmLJwihcIBhg2LDgwUjcPsC8jrkWS21rC
         dBqIr+SKQwiaaUzAbSBZSikA5smH7O4JX6rfzGbtoHI/r6gh/Sa5Tf11G97lKQooUndd
         hD/5uNFMg3rKV2tEbyrAgYSeLkz3pnL2CRT2nXdfBluK+Ocwtc7IphQ87/BMfJlt9IRH
         2OfqQIPbZEefcjJjVhJHVQIvr7vUohUtH99oddTRD5NG5hCA5Yb0v9WUmBqXpGZLayAQ
         OYdQ==
X-Received: by 10.66.194.201 with SMTP id hy9mr7772444pac.140.1432835042790;
        Thu, 28 May 2015 10:44:02 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id k13sm3003649pbq.79.2015.05.28.10.44.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 May 2015 10:44:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <5567527A.6090607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270166>

Rename 'refinfo' to 'ref_array_item' and intoduce 'ref_filter_cbdata'
which will hold 'ref_filter' (Conditions to filter the refs on) and
'ref_array' (The array of ref_array_items). Modify the code to use
these new structures.

Re-order the fields in 'ref_array_item' so that refname can be
eventually converted to a FLEX_ARRAY.

Introduce 'ref_filter_clear_data' to clear all allocated memory.

This is a preparatory patch to eventually move code from 'for-each-ref'
to 'ref-filter' and making it publically available.

Mentored-by: Christian Couder <christian.couder@gmail.com>   Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 103 +++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 42 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 919d45e..d9fd512 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -31,12 +31,26 @@ struct ref_sort {
 	unsigned reverse : 1;
 };
 
-struct refinfo {
-	char *refname;
+struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
 	const char *symref;
 	struct atom_value *value;
+	char *refname;
+};
+
+struct ref_array {
+	int nr, alloc;
+	struct ref_array_item **items;
+};
+
+struct ref_filter {
+	const char **name_patterns;
+};
+
+struct ref_filter_cbdata {
+	struct ref_array array;
+	struct ref_filter filter;
 };
 
 static struct {
@@ -85,7 +99,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  refinfo
+ * of properties that we need to extract out of objects. ref_array_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -622,7 +636,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -821,7 +835,7 @@ static void populate_value(struct refinfo *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+static void get_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -830,12 +844,6 @@ static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
 	*v = &ref->value[atom];
 }
 
-struct grab_ref_cbdata {
-	struct refinfo **grab_array;
-	const char **grab_pattern;
-	int grab_cnt;
-};
-
 /*
  * Given a refname, return 1 if the refname matches with one of the patterns
  * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
@@ -860,12 +868,12 @@ static int match_name_as_path(const char **pattern, const char *refname)
 	return 0;
 }
 
-/* Allocate space for a new refinfo and copy the objectname and flag to it */
-static struct refinfo *new_refinfo(const char *refname,
-				   const unsigned char *objectname,
-				   int flag)
+/* Allocate space for a new ref_array_item and copy the objectname and flag to it */
+static struct ref_array_item *new_ref_array_item(const char *refname,
+						 const unsigned char *objectname,
+						 int flag)
 {
-	struct refinfo *ref = xcalloc(1, sizeof(struct refinfo));
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
 	ref->refname = xstrdup(refname);
 	hashcpy(ref->objectname, objectname);
 	ref->flag = flag;
@@ -879,26 +887,39 @@ static struct refinfo *new_refinfo(const char *refname,
  */
 static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct grab_ref_cbdata *cb = cb_data;
-	struct refinfo *ref;
+	struct ref_filter_cbdata *ref_cbdata = cb_data;
+	struct ref_filter *filter = &ref_cbdata->filter;
+	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
-		  warning("ignoring ref with broken name %s", refname);
-		  return 0;
+		warning("ignoring ref with broken name %s", refname);
+		return 0;
 	}
 
-	if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
+	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
-	ref = new_refinfo(refname, sha1, flag);
+	ref = new_ref_array_item(refname, sha1, flag);
 
-	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
-	cb->grab_array[cb->grab_cnt++] = ref;
+	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
+	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
 
 	return 0;
 }
 
-static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+/* Free all memory allocated for ref_filter_cbdata */
+void ref_filter_clear_data(struct ref_filter_cbdata *ref_cbdata)
+{
+	int i;
+
+	for (i = 0; i < ref_cbdata->array.nr; i++)
+		free(ref_cbdata->array.items[i]);
+	free(ref_cbdata->array.items);
+	ref_cbdata->array.items = NULL;
+	ref_cbdata->array.nr = ref_cbdata->array.alloc = 0;
+}
+
+static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -925,8 +946,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b
 static struct ref_sort *ref_sort;
 static int compare_refs(const void *a_, const void *b_)
 {
-	struct refinfo *a = *((struct refinfo **)a_);
-	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_array_item *a = *((struct ref_array_item **)a_);
+	struct ref_array_item *b = *((struct ref_array_item **)b_);
 	struct ref_sort *s;
 
 	for (s = ref_sort; s; s = s->next) {
@@ -937,10 +958,10 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs)
+static void sort_refs(struct ref_sort *sort, struct ref_array *array)
 {
 	ref_sort = sort;
-	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
+	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
 static void print_value(struct atom_value *v, int quote_style)
@@ -1007,7 +1028,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct refinfo *info, const char *format, int quote_style)
+static void show_ref(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1076,12 +1097,12 @@ static char const * const for_each_ref_usage[] = {
 
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i, num_refs;
+	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct refinfo **refs;
-	struct grab_ref_cbdata cbdata;
+	struct ref_filter_cbdata ref_cbdata;
+	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1119,17 +1140,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.grab_pattern = argv;
-	for_each_rawref(grab_single_ref, &cbdata);
-	refs = cbdata.grab_array;
-	num_refs = cbdata.grab_cnt;
+	ref_cbdata.filter.name_patterns = argv;
+	for_each_rawref(grab_single_ref, &ref_cbdata);
 
-	sort_refs(sort, refs, num_refs);
+	sort_refs(sort, &ref_cbdata.array);
 
-	if (!maxcount || num_refs < maxcount)
-		maxcount = num_refs;
+	if (!maxcount || ref_cbdata.array.nr < maxcount)
+		maxcount = ref_cbdata.array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref(refs[i], format, quote_style);
+		show_ref(ref_cbdata.array.items[i], format, quote_style);
+	ref_filter_clear_data(&ref_cbdata);
 	return 0;
 }
-- 
2.4.1
