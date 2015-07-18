From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 6/9] tag.c: use 'ref-filter' data structures
Date: Sun, 19 Jul 2015 00:42:26 +0530
Message-ID: <1437246749-14423-7-git-send-email-Karthik.188@gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 21:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGXXi-0001LD-FW
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 21:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbbGRTM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 15:12:58 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35322 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbbGRTM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 15:12:56 -0400
Received: by pdrg1 with SMTP id g1so79351366pdr.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cB7RM2BtKJWJxtcIVupGXvTmxRg3AoRGEtJvBCZYKLw=;
        b=k+NRNeguLyeouzD8+HUWpnhYxHPKQ+bgo2elJd43GaCEk2ZBMoKa3DvnJ9pSwRLBO6
         1EvDp0xqdgaTI8O7uXk7msbc/3QTP8l+2VIx1szG9IBn3W/lFRXCaI2GzdkKGK6WndaV
         DW3AgyvZY4CF5shsjzzKPJo5pP0NQQP4+BJtvVOSv+g6Fy/+u4+5M+u1k/MsWAXY3XzY
         ajE4+FSAfU301jgOhRtyOIkNrNLa/YKoW42+hnjClNrW/RxppS2D1XXATcIHhiuvJlPx
         cjzWnsyJSRvdICdWDSG+K+un3buP5+qNnxqcGzbZITvoT2qfR3q35WOjtFoLD0l08RfR
         BRQw==
X-Received: by 10.67.7.199 with SMTP id de7mr41267135pad.107.1437246775719;
        Sat, 18 Jul 2015 12:12:55 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ra10sm15104498pab.19.2015.07.18.12.12.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jul 2015 12:12:55 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274174>

From: Karthik Nayak <karthik.188@gmail.com>

Make 'tag.c' use 'ref-filter' data structures and make changes to
support the new data structures. This is a part of the process
of porting 'tag.c' to use 'ref-filter' APIs.

This is a temporary step before porting 'tag.c' to use 'ref-filter'
completely. As this is a temporary step, most of the code
introduced here will be removed when 'tag.c' is ported over to use
'ref-filter' APIs

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c | 106 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 10b11ce..dadc686 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -17,6 +17,7 @@
 #include "gpg-interface.h"
 #include "sha1-array.h"
 #include "column.h"
+#include "ref-filter.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
@@ -34,15 +35,6 @@ static const char * const git_tag_usage[] = {
 
 static int tag_sort;
 
-struct tag_filter {
-	const char **patterns;
-	int lines;
-	int sort;
-	struct string_list tags;
-	struct commit_list *with_commit;
-};
-
-static struct sha1_array points_at;
 static unsigned int colopts;
 
 static int match_pattern(const char **patterns, const char *ref)
@@ -61,19 +53,20 @@ static int match_pattern(const char **patterns, const char *ref)
  * removed as we port tag.c to use the ref-filter APIs.
  */
 static const unsigned char *match_points_at(const char *refname,
-					    const unsigned char *sha1)
+					    const unsigned char *sha1,
+					    struct sha1_array *points_at)
 {
 	const unsigned char *tagged_sha1 = NULL;
 	struct object *obj;
 
-	if (sha1_array_lookup(&points_at, sha1) >= 0)
+	if (sha1_array_lookup(points_at, sha1) >= 0)
 		return sha1;
 	obj = parse_object(sha1);
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
 		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
-	if (tagged_sha1 && sha1_array_lookup(&points_at, tagged_sha1) >= 0)
+	if (tagged_sha1 && sha1_array_lookup(points_at, tagged_sha1) >= 0)
 		return tagged_sha1;
 	return NULL;
 }
@@ -228,12 +221,24 @@ free_return:
 	free(buf);
 }
 
+static void ref_array_append(struct ref_array *array, const char *refname)
+{
+	size_t len = strlen(refname);
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
+	memcpy(ref->refname, refname, len);
+	ref->refname[len] = '\0';
+	REALLOC_ARRAY(array->items, array->nr + 1);
+	array->items[array->nr++] = ref;
+}
+
 static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
-	struct tag_filter *filter = cb_data;
+	struct ref_filter_cbdata *data = cb_data;
+	struct ref_array *array = data->array;
+	struct ref_filter *filter = data->filter;
 
-	if (match_pattern(filter->patterns, refname)) {
+	if (match_pattern(filter->name_patterns, refname)) {
 		if (filter->with_commit) {
 			struct commit *commit;
 
@@ -244,12 +249,12 @@ static int show_reference(const char *refname, const struct object_id *oid,
 				return 0;
 		}
 
-		if (points_at.nr && !match_points_at(refname, oid->hash))
+		if (filter->points_at.nr && !match_points_at(refname, oid->hash, &filter->points_at))
 			return 0;
 
 		if (!filter->lines) {
-			if (filter->sort)
-				string_list_append(&filter->tags, refname);
+			if (tag_sort)
+				ref_array_append(array, refname);
 			else
 				printf("%s\n", refname);
 			return 0;
@@ -264,36 +269,36 @@ static int show_reference(const char *refname, const struct object_id *oid,
 
 static int sort_by_version(const void *a_, const void *b_)
 {
-	const struct string_list_item *a = a_;
-	const struct string_list_item *b = b_;
-	return versioncmp(a->string, b->string);
+	const struct ref_array_item *a = *((struct ref_array_item **)a_);
+	const struct ref_array_item *b = *((struct ref_array_item **)b_);
+	return versioncmp(a->refname, b->refname);
 }
 
-static int list_tags(const char **patterns, int lines,
-		     struct commit_list *with_commit, int sort)
+static int list_tags(struct ref_filter *filter, int sort)
 {
-	struct tag_filter filter;
+	struct ref_array array;
+	struct ref_filter_cbdata data;
+
+	memset(&array, 0, sizeof(array));
+	data.array = &array;
+	data.filter = filter;
 
-	filter.patterns = patterns;
-	filter.lines = lines;
-	filter.sort = sort;
-	filter.with_commit = with_commit;
-	memset(&filter.tags, 0, sizeof(filter.tags));
-	filter.tags.strdup_strings = 1;
+	if (filter->lines == -1)
+		filter->lines = 0;
 
-	for_each_tag_ref(show_reference, (void *)&filter);
+	for_each_tag_ref(show_reference, &data);
 	if (sort) {
 		int i;
 		if ((sort & SORT_MASK) == VERCMP_SORT)
-			qsort(filter.tags.items, filter.tags.nr,
-			      sizeof(struct string_list_item), sort_by_version);
+			qsort(array.items, array.nr,
+			      sizeof(struct ref_array_item *), sort_by_version);
 		if (sort & REVERSE_SORT)
-			for (i = filter.tags.nr - 1; i >= 0; i--)
-				printf("%s\n", filter.tags.items[i].string);
+			for (i = array.nr - 1; i >= 0; i--)
+				printf("%s\n", array.items[i]->refname);
 		else
-			for (i = 0; i < filter.tags.nr; i++)
-				printf("%s\n", filter.tags.items[i].string);
-		string_list_clear(&filter.tags, 0);
+			for (i = 0; i < array.nr; i++)
+				printf("%s\n", array.items[i]->refname);
+		ref_array_clear(&array);
 	}
 	return 0;
 }
@@ -574,16 +579,16 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *object_ref, *tag;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
-	int annotate = 0, force = 0, lines = -1;
+	int annotate = 0, force = 0;
 	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
-	struct commit_list *with_commit = NULL;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	struct ref_filter filter;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
-		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
+		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
 				N_("print <n> lines of each tag message"),
 				PARSE_OPT_OPTARG, NULL, 1 },
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete tags"), 'd'),
@@ -604,14 +609,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
-		OPT_CONTAINS(&with_commit, N_("print only tags that contain the commit")),
-		OPT_WITH(&with_commit, N_("print only tags that contain the commit")),
+		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
 		{
 			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
 			PARSE_OPT_NONEG, parse_opt_sort
 		},
 		{
-			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
+			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
 		OPT_END()
@@ -620,6 +625,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_tag_config, NULL);
 
 	memset(&opt, 0, sizeof(opt));
+	memset(&filter, 0, sizeof(filter));
+	filter.lines = -1;
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
@@ -636,7 +643,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
-	if (cmdmode == 'l' && lines != -1) {
+	if (cmdmode == 'l' && filter.lines != -1) {
 		if (explicitly_enable_column(colopts))
 			die(_("--column and -n are incompatible"));
 		colopts = 0;
@@ -649,18 +656,19 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
-		if (lines != -1 && tag_sort)
+		if (filter.lines != -1 && tag_sort)
 			die(_("--sort and -n are incompatible"));
-		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, tag_sort);
+		filter.name_patterns = argv;
+		ret = list_tags(&filter, tag_sort);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
 	}
-	if (lines != -1)
+	if (filter.lines != -1)
 		die(_("-n option is only allowed with -l."));
-	if (with_commit)
+	if (filter.with_commit)
 		die(_("--contains option is only allowed with -l."));
-	if (points_at.nr)
+	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed with -l."));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag);
-- 
2.4.6
