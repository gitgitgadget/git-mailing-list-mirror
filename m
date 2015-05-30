From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v4 4/8] for-each-ref: introduce new structures for better organisation
Date: Sat, 30 May 2015 23:23:27 +0530
Message-ID: <1433008411-8550-4-git-send-email-karthik.188@gmail.com>
References: <5569EF77.4010300@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 19:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yykxb-0005yM-4T
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754AbbE3RyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:54:10 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33750 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757736AbbE3RyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:54:08 -0400
Received: by pdbqa5 with SMTP id qa5so76328867pdb.0
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8QxKF9iPsDf6mfseOSIpdTitYZp9LP0eNJGFkR/jDj8=;
        b=FrrBEaPeDpyzex50xxXJvjZS3JNaalSiJZNjJpnC358rcuIDJsAnC7M4VxG3MVFvAd
         Nw7Qwfpgipe81DkGHAponE2gv0uKBy39Ko9i+DqLGnadS+FIa6JAzudyjyYRswjOXmIz
         AXGdbSvwk3trl5Xu/uy1d7TWW3t35+KDiq5W4hpoiyu8rkZIzBDNJTu5LYtce2P/nf3X
         WFHcX66BLAV0qRSpk1aHyz0Zf3ur796z839VXVJ80gTMnW/ZqkgoW5oFrW6NigFXdZwW
         0zfmqUF4oh6g5LjIdnERzGoPCAQRv0l4eVj8EHv6UuFQH37q1LvRr1Pq6RK43ST6p7An
         ZKwA==
X-Received: by 10.70.87.231 with SMTP id bb7mr25532198pdb.70.1433008447679;
        Sat, 30 May 2015 10:54:07 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ob15sm9317839pdb.40.2015.05.30.10.54.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 May 2015 10:54:07 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5569EF77.4010300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270298>

Intoduce 'ref_filter_cbdata' which will hold 'ref_filter'
(Conditions to filter the refs on) and 'ref_array' (The array
of ref_array_items). Modify the code to use these new structures.

This is a preparatory patch to eventually move code from 'for-each-ref'
to 'ref-filter' and making it publically available.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e634fd2..ef54c90 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -39,6 +39,20 @@ struct ref_array_item {
 	char *refname;
 };
 
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
+};
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -85,7 +99,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  ref_array_item
+ * of properties that we need to extract out of objects. ref_array_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -830,12 +844,6 @@ static void get_value(struct ref_array_item *ref, int atom, struct atom_value **
 	*v = &ref->value[atom];
 }
 
-struct grab_ref_cbdata {
-	struct ref_array_item **grab_array;
-	const char **grab_pattern;
-	int grab_cnt;
-};
-
 /*
  * Given a refname, return 1 if the refname matches with one of the patterns
  * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
@@ -879,7 +887,8 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
  */
 static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct grab_ref_cbdata *cb = cb_data;
+	struct ref_filter_cbdata *ref_cbdata = cb_data;
+	struct ref_filter *filter = &ref_cbdata->filter;
 	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
@@ -887,13 +896,13 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 		  return 0;
 	}
 
-	if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
+	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
 	ref = new_ref_array_item(refname, sha1, flag);
 
-	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
-	cb->grab_array[cb->grab_cnt++] = ref;
+	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
+	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
 
 	return 0;
 }
@@ -937,10 +946,10 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct ref_array_item **refs, int num_refs)
+static void sort_refs(struct ref_sort *sort, struct ref_array *array)
 {
 	ref_sort = sort;
-	qsort(refs, num_refs, sizeof(struct ref_array_item *), compare_refs);
+	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
 static void print_value(struct atom_value *v, int quote_style)
@@ -1076,12 +1085,12 @@ static char const * const for_each_ref_usage[] = {
 
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i, num_refs;
+	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct ref_array_item **refs;
-	struct grab_ref_cbdata cbdata;
+	struct ref_filter_cbdata ref_cbdata;
+	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1119,17 +1128,14 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
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
 	return 0;
 }
-- 
2.4.2
