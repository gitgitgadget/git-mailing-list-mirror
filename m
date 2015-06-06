From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 03/10] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Sat,  6 Jun 2015 12:39:34 +0530
Message-ID: <1433574581-23980-3-git-send-email-karthik.188@gmail.com>
References: <55729B78.1070207@gmail.com>
 <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 09:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18FB-0002oC-M3
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbbFFHKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:10:04 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35570 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbFFHJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:09:59 -0400
Received: by pacyx8 with SMTP id yx8so25916508pac.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5f/qPGE2xj6vktWwYECTk53GBsStm5B+SDc0zvaZbgs=;
        b=SFOcNQpVt737YE9QFjEIw6gFnTPN1No/Gmpx0nI4ZnLm9WNo6jHbE8Cgd84iy/2jqm
         K4Uuxoz2RZZ3cnykWdK1OaYQq5AYA/GhS/8V39FpiEM2NCH5141NSxeK7dQ9t/4Cxu2Y
         Z+ykG/4+FvIM/ZTAAOPj7WvHGYozJCl7qsYkASoxjRj2JQqDFw2e7Ne1J3iIemNlfASW
         x5/aDFflhPHaejUkcC+vht5owHKgtMMGvTx5Y/1En7k64PUYevqhuiFFJFTQw7ZdVWgu
         A3DVSVDwc2AQ1pIjOTZMcvYphFIdmdnZOjAYQkqv5NcXwKvlObWGP90rAUeNkYDyEINP
         LuXg==
X-Received: by 10.68.69.48 with SMTP id b16mr7673014pbu.144.1433574599069;
        Sat, 06 Jun 2015 00:09:59 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ve1sm8572230pbc.52.2015.06.06.00.09.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 00:09:58 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270904>

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
index 0ca9836..b8d17b6 100644
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
@@ -85,7 +85,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  refinfo
+ * of properties that we need to extract out of objects.  ref_array_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -622,7 +622,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -821,7 +821,7 @@ static void populate_value(struct refinfo *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+static void get_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -831,7 +831,7 @@ static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
 }
 
 struct grab_ref_cbdata {
-	struct refinfo **grab_array;
+	struct ref_array_item **grab_array;
 	const char **grab_pattern;
 	int grab_cnt;
 };
@@ -860,12 +860,12 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -880,7 +880,7 @@ static struct refinfo *new_refinfo(const char *refname,
 static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct grab_ref_cbdata *cb = cb_data;
-	struct refinfo *ref;
+	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -895,14 +895,14 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_refinfo(refname, sha1, flag);
+	ref = new_ref_array_item(refname, sha1, flag);
 
 	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
 	cb->grab_array[cb->grab_cnt++] = ref;
 	return 0;
 }
 
-static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -929,8 +929,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b
 static struct ref_sort *ref_sort;
 static int compare_refs(const void *a_, const void *b_)
 {
-	struct refinfo *a = *((struct refinfo **)a_);
-	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_array_item *a = *((struct ref_array_item **)a_);
+	struct ref_array_item *b = *((struct ref_array_item **)b_);
 	struct ref_sort *s;
 
 	for (s = ref_sort; s; s = s->next) {
@@ -941,10 +941,10 @@ static int compare_refs(const void *a_, const void *b_)
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
@@ -1011,7 +1011,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct refinfo *info, const char *format, int quote_style)
+static void show_ref(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1084,7 +1084,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct refinfo **refs;
+	struct ref_array_item **refs;
 	struct grab_ref_cbdata cbdata;
 
 	struct option opts[] = {
-- 
2.4.2
