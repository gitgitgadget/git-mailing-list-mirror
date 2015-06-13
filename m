From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 10/11] for-each-ref: introduce filter_refs()
Date: Sun, 14 Jun 2015 01:07:28 +0530
Message-ID: <1434224249-21476-10-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:38:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rGc-0002QK-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbbFMTix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:38:53 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35028 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbFMTiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:38:50 -0400
Received: by pacyx8 with SMTP id yx8so40814326pac.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFynqei08b0ESDHBaTd990jJDLbjpffBSu0Zw99TpQU=;
        b=qj3l3RUjwmZDfWYjUNCZdhqRr7y8pWqXnsllyVKG1HQGsNaDDzsgYYGS6vdv92kMni
         yy9txF+bhFB/SEHOdEkgLt7Xc3qA8BsQwTNiVRF670Jn6E+RPs0ZxnwCcR8h6QFcsAXc
         8kpiTadXJXhVol74jzuJyuFfsmrXxTmm0areJneLFf8XUGRScVgfoVqFIy4wpcaruz+i
         LgX9xNaSpTtx+O756/5WyBcN2raDRlvHmID1UVO6P9vreULQY1X83zKkQxH7lPMbIqSD
         BrlKAetV2fQPttSMe/XYj+j2v8Fx7ND8hyNVVJxC0dWZOsg2fzeSgp1Jpq7XYIm5XF8R
         74pQ==
X-Received: by 10.66.161.102 with SMTP id xr6mr34533773pab.8.1434224329646;
        Sat, 13 Jun 2015 12:38:49 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.38.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:38:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271573>

Introduce filter_refs() which will act as an API for filtering
a set of refs. Based on the type of refs the user has requested,
we iterate through those refs and apply filters as per the
given ref_filter structure and finally store the filtered refs
in the ref_array structure.

Currently this will wrap around ref_filter_handler(). Hence,
ref_filter_handler is made file scope static.

As users of this API will no longer send a ref_filter_cbdata
structure directly, we make the elements of ref_filter_cbdata
pointers. We can now use the information given by the users
to obtain our own ref_filter_cbdata structure. Changes are made to
support the change in ref_filter_cbdata structure.

Make 'for-each-ref' use this API.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 21 +++++++++++----------
 ref-filter.c           | 30 ++++++++++++++++++++++++++----
 ref-filter.h           | 16 ++++++++++++----
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 637fc4a..7919206 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -16,7 +16,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	int maxcount = 0, quote_style = 0;
-	struct ref_filter_cbdata ref_cbdata;
+	struct ref_array array;
+	struct ref_filter filter;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -54,16 +55,16 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
-	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
-	ref_cbdata.filter.name_patterns = argv;
-	for_each_rawref(ref_filter_handler, &ref_cbdata);
+	memset(&array, 0, sizeof(array));
+	memset(&filter, 0, sizeof(filter));
+	filter.name_patterns = argv;
+	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
+	ref_array_sort(sorting, &array);
 
-	ref_array_sort(sorting, &ref_cbdata.array);
-
-	if (!maxcount || ref_cbdata.array.nr < maxcount)
-		maxcount = ref_cbdata.array.nr;
+	if (!maxcount || array.nr < maxcount)
+		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(ref_cbdata.array.items[i], format, quote_style);
-	ref_array_clear(&ref_cbdata.array);
+		show_ref_array_item(array.items[i], format, quote_style);
+	ref_array_clear(&array);
 	return 0;
 }
diff --git a/ref-filter.c b/ref-filter.c
index f0dd0f2..a1151e0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -859,10 +859,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
-	struct ref_filter *filter = &ref_cbdata->filter;
+	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
@@ -880,8 +880,8 @@ int ref_filter_handler(const char *refname, const struct object_id *oid, int fla
 	 */
 	ref = new_ref_array_item(refname, oid->hash, flag);
 
-	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
-	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
+	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
+	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
 	return 0;
 }
 
@@ -905,6 +905,28 @@ void ref_array_clear(struct ref_array *array)
 	array->nr = array->alloc = 0;
 }
 
+/*
+ * API for filtering a set of refs. Based on the type of refs the user
+ * has requested, we iterate through those refs and apply filters
+ * as per the given ref_filter structure and finally store the
+ * filtered refs in the ref_array structure.
+ */
+int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
+{
+	struct ref_filter_cbdata ref_cbdata;
+
+	ref_cbdata.array = array;
+	ref_cbdata.filter = filter;
+
+	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
+		return for_each_rawref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_ALL)
+		return for_each_ref(ref_filter_handler, &ref_cbdata);
+	else
+		die("filter_refs: invalid type");
+	return 0;
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
diff --git a/ref-filter.h b/ref-filter.h
index 506ac8f..697b609 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -13,6 +13,9 @@
 #define QUOTE_PYTHON 4
 #define QUOTE_TCL 8
 
+#define FILTER_REFS_INCLUDE_BROKEN 0x1
+#define FILTER_REFS_ALL 0x2
+
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -42,12 +45,17 @@ struct ref_filter {
 };
 
 struct ref_filter_cbdata {
-	struct ref_array array;
-	struct ref_filter filter;
+	struct ref_array *array;
+	struct ref_filter *filter;
 };
 
-/*  Callback function for for_each_*ref(). This filters the refs based on the filters set */
-int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data);
+/*
+ * API for filtering a set of refs. Based on the type of refs the user
+ * has requested, we iterate through those refs and apply filters
+ * as per the given ref_filter structure and finally store the
+ * filtered refs in the ref_array structure.
+ */
+int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */
-- 
2.4.3.435.g2403634.dirty
