From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 04/10] for-each-ref: introduce new structures for better organisation
Date: Sat,  6 Jun 2015 12:39:35 +0530
Message-ID: <1433574581-23980-4-git-send-email-karthik.188@gmail.com>
References: <55729B78.1070207@gmail.com>
 <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 09:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18FC-0002oC-AU
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbbFFHKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:10:07 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33583 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbFFHKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:10:03 -0400
Received: by pdjn11 with SMTP id n11so29269325pdj.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3jXbfS1izkwox4eQQHae5AfDB3eX2iEvlHQnIlQwWAQ=;
        b=er4/vE5boYfqkgRBFqyTsuQa0N536VjL4oDrjHWo9HD3GKIPxt4gTpEU2rRyRi4dxl
         EvPX1Af4qFqFykWxFIWssImV/lqA8BrFun8NttQB2kXOGRGbnu9uw2Omj4wzOAKpHZag
         jFt57FhE51LHwO45OYQlYGeE5UxmvpGboEq/fhX6Y5kqQrgm4hWPpxU8eQ0bb/qKMVGx
         XuUjCe6QOdD6rPeJlJq3enFrcY5AE132KlZQTjtbOLwPYugmm1j/XwfHKzN2fKyj1ccT
         M21fb3xQUe3fEruVe711P757Ce6Bek1t1LR/+41ntZfli7efhdHorDRvFAJAYJ7zAduY
         49fw==
X-Received: by 10.70.96.35 with SMTP id dp3mr12169545pdb.44.1433574601975;
        Sat, 06 Jun 2015 00:10:01 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ve1sm8572230pbc.52.2015.06.06.00.09.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 00:10:01 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270902>

Introduce 'ref_filter_cbdata' which will hold 'ref_filter'
(conditions to filter the refs on) and 'ref_array' (the array
of ref_array_items). Modify the code to use these new structures.

This is a preparatory patch to eventually move code from 'for-each-ref'
to 'ref-filter' and make it publicly available.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 54 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b8d17b6..169ccc8 100644
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
@@ -887,7 +896,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 		  return 0;
 	}
 
-	if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
+	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
 	/*
@@ -897,8 +906,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	ref = new_ref_array_item(refname, sha1, flag);
 
-	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
-	cb->grab_array[cb->grab_cnt++] = ref;
+	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
+	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
 	return 0;
 }
 
@@ -941,10 +950,10 @@ static int compare_refs(const void *a_, const void *b_)
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
@@ -1080,12 +1089,11 @@ static char const * const for_each_ref_usage[] = {
 
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
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1123,17 +1131,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.grab_pattern = argv;
-	for_each_rawref(grab_single_ref, &cbdata);
-	refs = cbdata.grab_array;
-	num_refs = cbdata.grab_cnt;
+	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
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
