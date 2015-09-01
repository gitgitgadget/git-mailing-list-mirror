From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v15 10/13] tag.c: use 'ref-filter' data structures
Date: Tue,  1 Sep 2015 23:56:31 +0530
Message-ID: <1441131994-13508-11-git-send-email-Karthik.188@gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 20:27:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqGq-0007I8-TI
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbbIAS06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:26:58 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33577 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbbIAS04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:26:56 -0400
Received: by padan5 with SMTP id an5so3837335pad.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/G5daHHseZPb5Amsl2o1JA+tH3EU3cSRkZfaBp5zPX8=;
        b=u8gg43ZUJULfmUen+Npot6tQ7WBe2+QgqKaEgjpBZsn+Tb5W+XDFgWhkotcotfS1oY
         YpMqEtLkApeTuGdvspmHMkQxMxP2Qlsdt8OGUPm8plqTP2KEOiUzn9mx2YuqL+JlD7yT
         RRoX1qWdm9fZqFQP4y5zy+Dxy5bw1ORyA76MeONQUdYSU3H3eusUXUmYgRc5/ayk7GCt
         zMvAn61J5tVqMsfieAJ5kFKbkPQrUWmUpRREGjmCdX72MBFVb3KmLFCKqc5BP0pDh9iG
         fH5Fz6tTTC56tNgr81274UHV9b8n9NGs4c3bAAm5G379oeBi7X/UXh7uFyPvHZJmR/f3
         EwxQ==
X-Received: by 10.66.141.141 with SMTP id ro13mr50030375pab.68.1441132016111;
        Tue, 01 Sep 2015 11:26:56 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uk6sm19091682pac.27.2015.09.01.11.26.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2015 11:26:55 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277021>

From: Karthik Nayak <karthik.188@gmail.com>

Make 'tag.c' use 'ref-filter' data structures and make changes to
support the new data structures. This is a part of the process
of porting 'tag.c' to use 'ref-filter' APIs.

This is a temporary step before porting 'tag.c' to use 'ref-filter'
completely. As this is a temporary step, most of the code
introduced here will be removed when 'tag.c' is ported over to use
'ref-filter' APIs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c | 106 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index b0bc1c5..fe66f7b 100644
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
@@ -574,17 +579,17 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *object_ref, *tag;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
-	int annotate = 0, force = 0, lines = -1;
 	int create_reflog = 0;
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
@@ -606,14 +611,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
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
@@ -622,6 +627,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_tag_config, NULL);
 
 	memset(&opt, 0, sizeof(opt));
+	memset(&filter, 0, sizeof(filter));
+	filter.lines = -1;
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
@@ -638,7 +645,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
-	if (cmdmode == 'l' && lines != -1) {
+	if (cmdmode == 'l' && filter.lines != -1) {
 		if (explicitly_enable_column(colopts))
 			die(_("--column and -n are incompatible"));
 		colopts = 0;
@@ -651,18 +658,19 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
2.5.0
