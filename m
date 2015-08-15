From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 06/13] ref-filter: add option to filter out tags, branches and remotes
Date: Sat, 15 Aug 2015 23:30:36 +0530
Message-ID: <1439661643-16094-7-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflU-0001Wc-U5
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbbHOSA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:00:59 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35489 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbbHOSAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:54 -0400
Received: by pacgr6 with SMTP id gr6so79476155pac.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NiZwGZVHah4g4m0K91XyCdlXjQan9UcD3Qhh4ypgI+0=;
        b=sSkVo9PuU6ZTRwtnp5GcP5pBLCWym+az/FXwGeS1ECytg77HTn6aFFBVvH7NDbQND5
         QuacIy4I0p+ZrlPPg+C38RgVz38kJXjxddpX6a6RuNVlWdCSAUiAJKi68rcqlVyB2+nu
         62dO5YETjnwU0jnCPDINEuZzwdif6e8yrvu6FKrpIiiRc6HgYelWnV3ne8euhltSw/rx
         PlxX/W6rfimyI2kxZHpLDsAlOSyCyeEcgXBwfUXiPWXxgWXpwpHxlvbhQnRx3tl61iPq
         119twqtEe0Z1WicO6hvDxj1/wxwtxBdUT5o0+DFXnErXEJ7ir0krpkzPgvRw7MZjiGEX
         D5JA==
X-Received: by 10.68.241.166 with SMTP id wj6mr100348479pbc.114.1439661653589;
        Sat, 15 Aug 2015 11:00:53 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:53 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275999>

From: Karthik Nayak <karthik.188@gmail.com>

Add a function called 'for_each_reftype_fullpath()' to refs.{c,h}
which iterates through each ref for the given path without trimming
the path and also accounting for broken refs, if mentioned.

Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
handled and return the kind to 'ref_filter_handler()', where we
discard refs which we do not need and assign the kind to needed refs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 ref-filter.h | 12 ++++++++++--
 refs.c       |  7 +++++++
 refs.h       |  1 +
 4 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index eac99d0..abcd235 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1098,6 +1098,36 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
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
+	if (filter->kind == FILTER_REFS_BRANCHES)
+		return FILTER_REFS_BRANCHES;
+	else if (filter->kind == FILTER_REFS_REMOTES)
+		return FILTER_REFS_REMOTES;
+	else if (filter->kind == FILTER_REFS_TAGS)
+		return FILTER_REFS_TAGS;
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
@@ -1108,6 +1138,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
+	unsigned int kind;
 
 	if (flag & REF_BAD_NAME) {
 		warning("ignoring ref with broken name %s", refname);
@@ -1119,6 +1150,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	kind = filter_ref_kind(filter, refname);
+	if (!(kind & filter->kind))
+		return 0;
+
 	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
@@ -1150,6 +1185,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
+	ref->kind = kind;
 	return 0;
 }
 
@@ -1226,16 +1262,29 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 {
 	struct ref_filter_cbdata ref_cbdata;
 	int ret = 0;
+	unsigned int broken = 0;
 
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
 	/*  Simple per-ref filtering */
-	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
-		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
-	else if (type & FILTER_REFS_ALL)
-		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
-	else if (type)
+	if (type & FILTER_REFS_INCLUDE_BROKEN) {
+		type -= FILTER_REFS_INCLUDE_BROKEN;
+		broken = 1;
+	}
+
+	filter->kind = type;
+	if (type == FILTER_REFS_BRANCHES)
+		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
+	else if (type == FILTER_REFS_REMOTES)
+		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
+	else if (type == FILTER_REFS_TAGS)
+		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
+	else if (type & FILTER_REFS_ALL) {
+		ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
+		if (type & FILTER_REFS_DETACHED_HEAD)
+			head_ref(ref_filter_handler, &ref_cbdata);
+	} else
 		die("filter_refs: invalid type");
 
 	/*  Filters that need revision walking */
diff --git a/ref-filter.h b/ref-filter.h
index 144a633..64fedd3 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -14,8 +14,14 @@
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
 
 struct atom_value;
 
@@ -28,6 +34,7 @@ struct ref_sorting {
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
+	unsigned int kind;
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -52,6 +59,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int kind;
 };
 
 struct ref_filter_cbdata {
diff --git a/refs.c b/refs.c
index 2db2975..0f18c34 100644
--- a/refs.c
+++ b/refs.c
@@ -2145,6 +2145,13 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
+int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
+{
+	if (broken)
+		broken = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(&ref_cache, type, fn, 0, broken, cb_data);
+}
+
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index 6a3fa6d..7f91a72 100644
--- a/refs.h
+++ b/refs.h
@@ -179,6 +179,7 @@ extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
+extern int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-- 
2.5.0
