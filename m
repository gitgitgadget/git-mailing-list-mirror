From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 07/14] ref-filter: add option to filter out tags, branches and remotes
Date: Thu, 10 Sep 2015 21:18:23 +0530
Message-ID: <1441900110-4015-8-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:49:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za45m-0005C6-8M
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 17:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbbIJPsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 11:48:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33345 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbbIJPsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 11:48:42 -0400
Received: by pacex6 with SMTP id ex6so46671554pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9BV+kJq2bR+n2YIHopeVbmXq+Xw9YI/tbm/S/gK7lOs=;
        b=MMBo9XZA8Fqd5duPI+21zfA4NDe1AkJgZXrXocinaasJEqFlcdpLzG9cEjiKrMveOz
         OIlR6zwxrSNT5PJ/x5Xi6GP4v/dkEFJsUQqvqYOjy1vYV4+aQ3zDux+ZQDSYCtrAHDA0
         VCq6rSdDDohpbu8N07d7oBfimdG3G73KMHSp21MpRIhuyGIZ3ftJe4UWAg7d6BSY0qa0
         E/zHFN5tgnKs/gmqXNhEwPxRiD3GYaDkxs8xa5LySatwTNKUkKmhgMelgTdLLXPbSdY4
         lEGjBJB6O+YPdJz///Gb1Ft6qUPCnDeV1eYzMM0tdbfFkVD71q0ofFho4j+4k5nXaFmW
         3mnA==
X-Received: by 10.66.102.40 with SMTP id fl8mr25260976pab.136.1441900121903;
        Thu, 10 Sep 2015 08:48:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ts1sm12738918pbc.74.2015.09.10.08.48.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Sep 2015 08:48:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277590>

From: Karthik Nayak <karthik.188@gmail.com>

Add a function called 'for_each_fullref_in()' to refs.{c,h} which
iterates through each ref for the given path without trimming the path
and also accounting for broken refs, if mentioned.

Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
handled and return the kind to 'ref_filter_handler()', where we
discard refs which we do not need and assign the kind to needed refs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 ref-filter.h | 13 ++++++++++--
 refs.c       |  9 +++++++++
 refs.h       |  1 +
 4 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index b8f719c..7d2732a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1189,6 +1189,34 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
+static int filter_ref_kind(struct ref_filter *filter, const char *refname)
+{
+	unsigned int i;
+
+	static struct {
+		const char *prefix;
+		unsigned int kind;
+	} ref_kind[] = {
+		{ "refs/heads/" , FILTER_REFS_BRANCHES },
+		{ "refs/remotes/" , FILTER_REFS_REMOTES },
+		{ "refs/tags/", FILTER_REFS_TAGS}
+	};
+
+	if (filter->kind == FILTER_REFS_BRANCHES ||
+	    filter->kind == FILTER_REFS_REMOTES ||
+	    filter->kind == FILTER_REFS_TAGS)
+		return filter->kind;
+	else if (!strcmp(refname, "HEAD"))
+		return FILTER_REFS_DETACHED_HEAD;
+
+	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
+		if (starts_with(refname, ref_kind[i].prefix))
+			return ref_kind[i].kind;
+	}
+
+	return FILTER_REFS_OTHERS;
+}
+
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
@@ -1199,6 +1227,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
+	unsigned int kind;
 
 	if (flag & REF_BAD_NAME) {
 		warning("ignoring ref with broken name %s", refname);
@@ -1210,6 +1239,11 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
+	kind = filter_ref_kind(filter, refname);
+	if (!(kind & filter->kind))
+		return 0;
+
 	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
@@ -1241,6 +1275,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
+	ref->kind = kind;
 	return 0;
 }
 
@@ -1317,17 +1352,37 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 {
 	struct ref_filter_cbdata ref_cbdata;
 	int ret = 0;
+	unsigned int broken = 0;
 
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
+	if (type & FILTER_REFS_INCLUDE_BROKEN)
+		broken = 1;
+	filter->kind = type & FILTER_REFS_KIND_MASK;
+
 	/*  Simple per-ref filtering */
-	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
-		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
-	else if (type & FILTER_REFS_ALL)
-		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
-	else if (type)
+	if (!filter->kind)
 		die("filter_refs: invalid type");
+	else {
+		/*
+		 * For common cases where we need only branches or remotes or tags,
+		 * we only iterate through those refs. If a mix of refs is needed,
+		 * we iterate over all refs and filter out required refs with the help
+		 * of filter_ref_kind().
+		 */
+		if (filter->kind == FILTER_REFS_BRANCHES)
+			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind == FILTER_REFS_REMOTES)
+			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind == FILTER_REFS_TAGS)
+			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind & FILTER_REFS_ALL)
+			ret = for_each_fullref_in("", ref_filter_handler, &ref_cbdata, broken);
+		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
+			head_ref(ref_filter_handler, &ref_cbdata);
+	}
+
 
 	/*  Filters that need revision walking */
 	if (filter->merge_commit)
diff --git a/ref-filter.h b/ref-filter.h
index 45026d0..0913ba9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -13,8 +13,15 @@
 #define QUOTE_PYTHON 4
 #define QUOTE_TCL 8
 
-#define FILTER_REFS_INCLUDE_BROKEN 0x1
-#define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_INCLUDE_BROKEN 0x0001
+#define FILTER_REFS_TAGS           0x0002
+#define FILTER_REFS_BRANCHES       0x0004
+#define FILTER_REFS_REMOTES        0x0008
+#define FILTER_REFS_OTHERS         0x0010
+#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
+				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
+#define FILTER_REFS_DETACHED_HEAD  0x0020
+#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
 
@@ -27,6 +34,7 @@ struct ref_sorting {
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
+	unsigned int kind;
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -51,6 +59,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int kind;
 };
 
 struct ref_filter_cbdata {
diff --git a/refs.c b/refs.c
index 4e15f60..a9469c2 100644
--- a/refs.c
+++ b/refs.c
@@ -2108,6 +2108,15 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
+}
+
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index e9a5f32..6d30c98 100644
--- a/refs.h
+++ b/refs.h
@@ -173,6 +173,7 @@ typedef int each_ref_fn(const char *refname,
 extern int head_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+extern int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken);
 extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-- 
2.5.1
