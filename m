From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 03/11] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Sat,  6 Jun 2015 19:18:08 +0530
Message-ID: <1433598496-31287-3-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
 <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 15:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ESo-0004lC-RH
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 15:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbbFFNsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 09:48:39 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36163 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbbFFNsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 09:48:37 -0400
Received: by pablj1 with SMTP id lj1so11573833pab.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0peVD6s3ujtoqLTrViMYSIUT7HY5MSf2GkD5DTN1FUs=;
        b=zMCO3P2+tGN08Q5RiUNbPYlhbQUAqE2D87Jp0ZKgG+mRwzYDGZVUMBJ1hkUPDoBtNm
         yr1npJwE/VjLHWER7E3RtGA0fZ6X7s4ixXZJCKO2O0fedOeAhG4bZPzJBLHZuzzBFWJn
         2b6a8kNIVfBJ9G4lqdkxMvPYCfMgJcuUoI7L2u0m2UH57rHlFbaW+XAdkJhTojixEmA7
         hoAYzwpFklCO+zE7W8jscj3uyOJpJQn3tN65cmf3Uw4dnpkSq2+oZXhTqs+FHVwZ8I2H
         xICaqSc1TfmJRju/yQNz7sscGT+uW3vMz/b6JLWNX5mDasVWeoNVt5JtbYK+6YOY2u2R
         uFUg==
X-Received: by 10.66.193.164 with SMTP id hp4mr14169329pac.23.1433598515894;
        Sat, 06 Jun 2015 06:48:35 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.48.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:48:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270925>

Rename 'refinfo' to 'ref_array_item' as a preparatory step for
introduction of new structures in the forthcoming patch.

Re-order the fields in 'ref_array_item' so that refname can be
eventually converted to a FLEX_ARRAY.

Make 'symref' a non const char pointer, so that the compiler doesn't
throw an error when we try to free the memory allocated to it.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 406de88..763224c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -31,12 +31,12 @@ struct ref_sort {
 	unsigned reverse : 1;
 };
 
-struct refinfo {
-	char *refname;
+struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
-	const char *symref;
+	char *symref;
 	struct atom_value *value;
+	char *refname;
 };
 
 static struct {
@@ -86,7 +86,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  refinfo
+ * of properties that we need to extract out of objects.  ref_array_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -623,7 +623,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -835,7 +835,7 @@ static void populate_value(struct refinfo *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+static void get_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -845,7 +845,7 @@ static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
 }
 
 struct grab_ref_cbdata {
-	struct refinfo **grab_array;
+	struct ref_array_item **grab_array;
 	const char **grab_pattern;
 	int grab_cnt;
 };
@@ -874,12 +874,12 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -895,7 +895,7 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 			   int flag, void *cb_data)
 {
 	struct grab_ref_cbdata *cb = cb_data;
-	struct refinfo *ref;
+	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -910,14 +910,14 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_refinfo(refname, oid->hash, flag);
+	ref = new_ref_array_item(refname, oid->hash, flag);
 
 	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
 	cb->grab_array[cb->grab_cnt++] = ref;
 	return 0;
 }
 
-static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -944,8 +944,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b
 static struct ref_sort *ref_sort;
 static int compare_refs(const void *a_, const void *b_)
 {
-	struct refinfo *a = *((struct refinfo **)a_);
-	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_array_item *a = *((struct ref_array_item **)a_);
+	struct ref_array_item *b = *((struct ref_array_item **)b_);
 	struct ref_sort *s;
 
 	for (s = ref_sort; s; s = s->next) {
@@ -956,10 +956,10 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs)
+static void sort_refs(struct ref_sort *sort, struct ref_array_item **refs, int num_refs)
 {
 	ref_sort = sort;
-	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
+	qsort(refs, num_refs, sizeof(struct ref_array_item *), compare_refs);
 }
 
 static void print_value(struct atom_value *v, int quote_style)
@@ -1026,7 +1026,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct refinfo *info, const char *format, int quote_style)
+static void show_ref(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1099,7 +1099,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct refinfo **refs;
+	struct ref_array_item **refs;
 	struct grab_ref_cbdata cbdata;
 
 	struct option opts[] = {
-- 
2.4.2
