From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 05/12] ref-filter: add option to filter out tags, branches and remotes
Date: Sat, 22 Aug 2015 09:09:41 +0530
Message-ID: <1440214788-1309-6-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzf5-0002IM-Pc
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbbHVDj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:39:59 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36009 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbbHVDj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:39:58 -0400
Received: by pdbmi9 with SMTP id mi9so32829431pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdxyLMdzGM+r3+ovFh3zpfV2/u84l05vMR+YWzYebpY=;
        b=R08bo26BMHKKODHdlbtV3u5tipKnMKSNAU6faNnh2A4Uc0kYckrGSc1W1UI7V/jNV2
         HmhT7aJqGdo9k+GXj3dBdx6F/dHmJSgbG95ac/yG+xTWKoqCkaEw1iH6Mb7SUeraNsvT
         z59EZAWsVYVKNLl5R64Xy9pKVgWLmY5ibuIBGrKSWVZyjhWzT5b0K5VSPLlc6C6BAaze
         U/IyoUxIf+ruj7mSKatTkrcoqzUdNHWqbkucPTmcO5Jx6WG7hWOUjwFok6Mm90XoGNat
         k69/byIlLfOTqhMUe4HSEGYAsR5xk3UHmyM2f0S0fGDlM9hVI0+C45BVzV/LNH0kcHxc
         kdoQ==
X-Received: by 10.70.34.228 with SMTP id c4mr23787826pdj.114.1440214798100;
        Fri, 21 Aug 2015 20:39:58 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.39.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:39:57 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276367>

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
 refs.c       |  9 +++++++++
 refs.h       |  1 +
 4 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ffec10a..d5fae1a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1123,6 +1123,36 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
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
@@ -1133,6 +1163,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
+	unsigned int kind;
 
 	if (flag & REF_BAD_NAME) {
 		warning("ignoring ref with broken name %s", refname);
@@ -1144,6 +1175,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	kind = filter_ref_kind(filter, refname);
+	if (!(kind & filter->kind))
+		return 0;
+
 	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
@@ -1175,6 +1210,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
+	ref->kind = kind;
 	return 0;
 }
 
@@ -1251,16 +1287,29 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
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
+		type &= ~FILTER_REFS_INCLUDE_BROKEN;
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
index 45026d0..99f081b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -13,8 +13,14 @@
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
 
@@ -27,6 +33,7 @@ struct ref_sorting {
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
+	unsigned int kind;
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -51,6 +58,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int kind;
 };
 
 struct ref_filter_cbdata {
diff --git a/refs.c b/refs.c
index 4e15f60..3266617 100644
--- a/refs.c
+++ b/refs.c
@@ -2150,6 +2150,15 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
+int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
+}
+
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index e9a5f32..6e913ee 100644
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
