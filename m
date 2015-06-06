From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 04/11] for-each-ref: introduce new structures for better organisation
Date: Sat,  6 Jun 2015 19:18:09 +0530
Message-ID: <1433598496-31287-4-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
 <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 15:48:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ESt-0004oa-2I
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 15:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbbFFNsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 09:48:41 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:36647 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbbFFNsj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 09:48:39 -0400
Received: by pdev10 with SMTP id v10so6051188pde.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m1+kwN/FFGHAN9LmV3FJCVBNB+jS2h0gcYBUfadZoyI=;
        b=m0Ao3B4Fwy47b/v2fmt2EWtBhEKKl/jiJHwHbD/Xt7vEsq91swlJZvA+buNUKx+P+b
         ILR/M3IP9FUaG+mFircGfGYpI0MA6w7lgko6hVvMYg2JCIyU/Y2aOTGzldz1pb+oKeRZ
         Ew+3ukpnrsoAwp+PElCpUOdAB6WI5CuDWfCmC9YlqPTjJQ94cgCyaZ+MgXfib5vzKrqP
         d+Hr/TOHGi6UguqSJy3PVgnod+0S1ktByCZse5EOILHRQUC2Eo55n9kpNSRH9xqd2YvB
         LBkWCXpny0cPknSElqFpyu2j8Xeey7JbadmEVttbDfStzKEYaOmGnKil0dnIjOH0gFfE
         yErA==
X-Received: by 10.68.190.8 with SMTP id gm8mr14235560pbc.30.1433598518821;
        Sat, 06 Jun 2015 06:48:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.48.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:48:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270926>

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
index 763224c..42a89cd 100644
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
@@ -844,12 +858,6 @@ static void get_value(struct ref_array_item *ref, int atom, struct atom_value **
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
@@ -894,7 +902,8 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 static int grab_single_ref(const char *refname, const struct object_id *oid,
 			   int flag, void *cb_data)
 {
-	struct grab_ref_cbdata *cb = cb_data;
+	struct ref_filter_cbdata *ref_cbdata = cb_data;
+	struct ref_filter *filter = &ref_cbdata->filter;
 	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
@@ -902,7 +911,7 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 		  return 0;
 	}
 
-	if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
+	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
 	/*
@@ -912,8 +921,8 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 	 */
 	ref = new_ref_array_item(refname, oid->hash, flag);
 
-	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
-	cb->grab_array[cb->grab_cnt++] = ref;
+	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
+	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
 	return 0;
 }
 
@@ -956,10 +965,10 @@ static int compare_refs(const void *a_, const void *b_)
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
@@ -1095,12 +1104,11 @@ static char const * const for_each_ref_usage[] = {
 
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
@@ -1138,17 +1146,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
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
