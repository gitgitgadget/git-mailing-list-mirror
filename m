From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/2] merge-recursive: move current_{file,directory}_set to struct merge_options
Date: Wed,  3 Sep 2008 19:34:37 +0200
Message-ID: <e3e7f1cbf3746e7d2ef2c77227c9367a361c10b9.1220463034.git.vmiklos@frugalware.org>
References: <cover.1220463034.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawHL-0004V7-C6
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYICRet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbYICRep
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:34:45 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:59504 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbYICRel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:34:41 -0400
Received: from vmobile.example.net (dsl5401C25C.pool.t-online.hu [84.1.194.92])
	by yugo.frugalware.org (Postfix) with ESMTP id 541261DDC5D;
	Wed,  3 Sep 2008 19:34:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9B35B84CB; Wed,  3 Sep 2008 19:34:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <cover.1220463034.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1220463034.git.vmiklos@frugalware.org>
References: <cover.1220463034.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94824>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 merge-recursive.c |   56 +++++++++++++++++++++++++++-------------------------
 merge-recursive.h |    4 +++
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d4f12d0..964b8f3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -77,9 +77,6 @@ struct stage_data
 	unsigned processed:1;
 };
 
-static struct string_list current_file_set = {NULL, 0, 0, 1};
-static struct string_list current_directory_set = {NULL, 0, 0, 1};
-
 static int show(struct merge_options *o, int v)
 {
 	return (!o->call_depth && o->verbosity >= v) || o->verbosity >= 5;
@@ -235,22 +232,23 @@ static int save_files_dirs(const unsigned char *sha1,
 	memcpy(newpath, base, baselen);
 	memcpy(newpath + baselen, path, len);
 	newpath[baselen + len] = '\0';
+	struct merge_options *o = context;
 
 	if (S_ISDIR(mode))
-		string_list_insert(newpath, &current_directory_set);
+		string_list_insert(newpath, &o->current_directory_set);
 	else
-		string_list_insert(newpath, &current_file_set);
+		string_list_insert(newpath, &o->current_file_set);
 	free(newpath);
 
 	return READ_TREE_RECURSIVE;
 }
 
-static int get_files_dirs(struct tree *tree)
+static int get_files_dirs(struct merge_options *o, struct tree *tree)
 {
 	int n;
-	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs, NULL))
+	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs, o))
 		return 0;
-	n = current_file_set.nr + current_directory_set.nr;
+	n = o->current_file_set.nr + o->current_directory_set.nr;
 	return n;
 }
 
@@ -434,7 +432,7 @@ static int remove_file(struct merge_options *o, int clean,
 	return 0;
 }
 
-static char *unique_path(const char *path, const char *branch)
+static char *unique_path(struct merge_options *o, const char *path, const char *branch)
 {
 	char *newpath = xmalloc(strlen(path) + 1 + strlen(branch) + 8 + 1);
 	int suffix = 0;
@@ -446,12 +444,12 @@ static char *unique_path(const char *path, const char *branch)
 	for (; *p; ++p)
 		if ('/' == *p)
 			*p = '_';
-	while (string_list_has_string(&current_file_set, newpath) ||
-	       string_list_has_string(&current_directory_set, newpath) ||
+	while (string_list_has_string(&o->current_file_set, newpath) ||
+	       string_list_has_string(&o->current_directory_set, newpath) ||
 	       lstat(newpath, &st) == 0)
 		sprintf(p, "_%d", suffix++);
 
-	string_list_insert(newpath, &current_file_set);
+	string_list_insert(newpath, &o->current_file_set);
 	return newpath;
 }
 
@@ -716,14 +714,14 @@ static void conflict_rename_rename(struct merge_options *o,
 	const char *ren2_dst = ren2->pair->two->path;
 	const char *dst_name1 = ren1_dst;
 	const char *dst_name2 = ren2_dst;
-	if (string_list_has_string(&current_directory_set, ren1_dst)) {
-		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
+	if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
+		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
 		remove_file(o, 0, ren1_dst, 0);
 	}
-	if (string_list_has_string(&current_directory_set, ren2_dst)) {
-		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
+	if (string_list_has_string(&o->current_directory_set, ren2_dst)) {
+		dst_name2 = del[delp++] = unique_path(o, ren2_dst, branch2);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
 		remove_file(o, 0, ren2_dst, 0);
@@ -749,7 +747,7 @@ static void conflict_rename_dir(struct merge_options *o,
 				struct rename *ren1,
 				const char *branch1)
 {
-	char *new_path = unique_path(ren1->pair->two->path, branch1);
+	char *new_path = unique_path(o, ren1->pair->two->path, branch1);
 	output(o, 1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
 	remove_file(o, 0, ren1->pair->two->path, 0);
 	update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
@@ -762,8 +760,8 @@ static void conflict_rename_rename_2(struct merge_options *o,
 				     struct rename *ren2,
 				     const char *branch2)
 {
-	char *new_path1 = unique_path(ren1->pair->two->path, branch1);
-	char *new_path2 = unique_path(ren2->pair->two->path, branch2);
+	char *new_path1 = unique_path(o, ren1->pair->two->path, branch1);
+	char *new_path2 = unique_path(o, ren2->pair->two->path, branch2);
 	output(o, 1, "Renaming %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
@@ -913,7 +911,7 @@ static int process_renames(struct merge_options *o,
 
 			try_merge = 0;
 
-			if (string_list_has_string(&current_directory_set, ren1_dst)) {
+			if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
 				clean_merge = 0;
 				output(o, 1, "CONFLICT (rename/directory): Rename %s->%s in %s "
 				       " directory %s added in %s",
@@ -935,7 +933,7 @@ static int process_renames(struct merge_options *o,
 				       "%s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
-				new_path = unique_path(ren1_dst, branch2);
+				new_path = unique_path(o, ren1_dst, branch2);
 				output(o, 1, "Adding as %s instead", new_path);
 				update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
@@ -1073,8 +1071,8 @@ static int process_entry(struct merge_options *o,
 			sha = b_sha;
 			conf = "directory/file";
 		}
-		if (string_list_has_string(&current_directory_set, path)) {
-			const char *new_path = unique_path(path, add_branch);
+		if (string_list_has_string(&o->current_directory_set, path)) {
+			const char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
@@ -1165,10 +1163,10 @@ int merge_trees(struct merge_options *o,
 	if (unmerged_cache()) {
 		struct string_list *entries, *re_head, *re_merge;
 		int i;
-		string_list_clear(&current_file_set, 1);
-		string_list_clear(&current_directory_set, 1);
-		get_files_dirs(head);
-		get_files_dirs(merge);
+		string_list_clear(&o->current_file_set, 1);
+		string_list_clear(&o->current_directory_set, 1);
+		get_files_dirs(o, head);
+		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
 		re_head  = get_renames(o, head, common, head, merge, entries);
@@ -1374,4 +1372,8 @@ void init_merge_options(struct merge_options *o)
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
 	strbuf_init(&o->obuf, 0);
+	memset(&o->current_file_set, 0, sizeof(struct string_list));
+	o->current_file_set.strdup_strings = 1;
+	memset(&o->current_directory_set, 0, sizeof(struct string_list));
+	o->current_directory_set.strdup_strings = 1;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index be84d9b..fd138ca 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,6 +1,8 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
+#include "string-list.h"
+
 struct merge_options {
 	const char *branch1;
 	const char *branch2;
@@ -11,6 +13,8 @@ struct merge_options {
 	int merge_rename_limit;
 	int call_depth;
 	struct strbuf obuf;
+	struct string_list current_file_set;
+	struct string_list current_directory_set;
 };
 
 /* merge_trees() but with recursive ancestor consolidation */
-- 
1.6.0.1
