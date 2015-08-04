From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Tue,  4 Aug 2015 18:31:14 +0530
Message-ID: <1438693282-15516-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:01:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbqR-0003Bv-4A
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933970AbbHDNBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:21 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35195 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933956AbbHDNBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:01:20 -0400
Received: by pasy3 with SMTP id y3so8183409pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=En8t3du9J8o2oHapCZSELZpxONf+79UF84WYGmQViio=;
        b=IOOWWpH4GvcJmhfuFhBZ60WaM4tyUMsx6+3DpZlWoW7w6+q41lln85zSOptodJNYu8
         025VXiOx2wu5Up9ADVTkbqdrC8qGEz6+zi9zYihe3Pqk6CBJ+vsv9xDJzL5znXFEAZGg
         AeX3qiPGdM7UmtTITLfS5f8fkkjUxNJeTMibhBpRccQ6KzqFVCdwMovyfSeaGFVKFAb3
         yUJ4lJLEYAkWvTczb+V2hxTgj9Fk/o8/4VZZwqIXO/X6W1DKilaG2Ra0lRXTQyr5phxA
         XCsH1xiwlTU+Ely89UhZYTCHt6Jkig1/hD3TMEZNFlohcGJVpI+9KY2KyHgG7dUT1EQk
         Y/ZQ==
X-Received: by 10.68.197.65 with SMTP id is1mr7514624pbc.109.1438693279741;
        Tue, 04 Aug 2015 06:01:19 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uy6sm1450657pbc.13.2015.08.04.06.01.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:01:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275265>

From: Karthik Nayak <karthik.188@gmail.com>

Add an option in 'filter_refs()' to use 'for_each_branch_ref()'
and filter refs. This type checking is done by adding a
'FILTER_REFS_BRANCHES' in 'ref-filter.h'.

Add an option in 'ref_filter_handler()' to filter different
types of branches by calling 'filter_branch_kind()' which
checks for the type of branch needed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 ref-filter.h | 10 ++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index de84dd4..c573109 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1044,6 +1044,46 @@ static const unsigned char *match_points_at(struct sha1_array *points_at,
 	return NULL;
 }
 
+/*
+ * Checks if a given refname is a branch and returns the kind of
+ * branch it is. If not a branch, 0 is returned.
+ */
+static int filter_branch_kind(struct ref_filter *filter, const char *refname)
+{
+	int kind, i;
+
+	static struct {
+		const char *prefix;
+		int kind;
+	} ref_kind[] = {
+		{ "refs/heads/" , REF_LOCAL_BRANCH },
+		{ "refs/remotes/" , REF_REMOTE_BRANCH },
+	};
+
+	/*  If no kind is specified, no need to filter */
+	if (!filter->branch_kind)
+		return REF_NO_BRANCH_FILTERING;
+
+	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
+		if (starts_with(refname, ref_kind[i].prefix)) {
+			kind = ref_kind[i].kind;
+			break;
+		}
+	}
+
+	if (ARRAY_SIZE(ref_kind) <= i) {
+		if (!strcmp(refname, "HEAD"))
+			kind = REF_DETACHED_HEAD;
+		else
+			return 0;
+	}
+
+	if ((filter->branch_kind & kind) == 0)
+		return 0;
+
+	return kind;
+}
+
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
@@ -1069,6 +1109,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
+	unsigned int kind;
 
 	if (flag & REF_BAD_NAME) {
 		warning("ignoring ref with broken name %s", refname);
@@ -1080,6 +1121,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	if (!(kind = filter_branch_kind(filter, refname)))
+		return 0;
+
 	if (!filter_pattern_match(filter, refname))
 		return 0;
 
@@ -1108,6 +1152,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 */
 	ref = new_ref_array_item(refname, oid->hash, flag);
 	ref->commit = commit;
+	ref->kind = kind;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
@@ -1198,6 +1243,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_TAGS)
 		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_BRANCHES)
+		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 5be3e35..b5a13e8 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,6 +16,12 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 #define FILTER_REFS_TAGS 0x4
+#define FILTER_REFS_BRANCHES 0x8
+
+#define REF_DETACHED_HEAD   0x01
+#define REF_LOCAL_BRANCH    0x02
+#define REF_REMOTE_BRANCH   0x04
+#define REF_NO_BRANCH_FILTERING 0x08
 
 #define ALIGN_LEFT 0x01
 #define ALIGN_RIGHT 0x02
@@ -50,7 +56,7 @@ struct ref_sorting {
 
 struct ref_array_item {
 	unsigned char objectname[20];
-	int flag;
+	int flag, kind;
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -76,7 +82,7 @@ struct ref_filter {
 
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1;
-	unsigned int lines;
+	unsigned int lines, branch_kind;
 };
 
 struct ref_filter_cbdata {
-- 
2.5.0
