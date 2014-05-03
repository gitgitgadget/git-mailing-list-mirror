From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 9/9] diff: convert struct combine_diff_path to object_id
Date: Sat,  3 May 2014 20:12:22 +0000
Message-ID: <1399147942-165308-10-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIg-0004K5-KX
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbaECUMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:34 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47535 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752193AbaECUMd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:33 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EE91B28088
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:31 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248052>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 combine-diff.c | 54 +++++++++++++++++++++++++++---------------------------
 diff-lib.c     | 10 +++++-----
 diff.h         |  5 +++--
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 24ca7e2..f97eb3a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -34,9 +34,9 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			memset(p->parent, 0,
 			       sizeof(p->parent[0]) * num_parent);
 
-			hashcpy(p->sha1, q->queue[i]->two->sha1);
+			hashcpy(p->sha1.oid, q->queue[i]->two->sha1);
 			p->mode = q->queue[i]->two->mode;
-			hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
+			hashcpy(p->parent[n].sha1.oid, q->queue[i]->one->sha1);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
 			*tail = p;
@@ -67,7 +67,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			continue;
 		}
 
-		hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
+		hashcpy(p->parent[n].sha1.oid, q->queue[i]->one->sha1);
 		p->parent[n].mode = q->queue[i]->one->mode;
 		p->parent[n].status = q->queue[i]->status;
 
@@ -274,7 +274,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	return base;
 }
 
-static char *grab_blob(const unsigned char *sha1, unsigned int mode,
+static char *grab_blob(const struct object_id *sha1, unsigned int mode,
 		       unsigned long *size, struct userdiff_driver *textconv,
 		       const char *path)
 {
@@ -284,20 +284,20 @@ static char *grab_blob(const unsigned char *sha1, unsigned int mode,
 	if (S_ISGITLINK(mode)) {
 		blob = xmalloc(100);
 		*size = snprintf(blob, 100,
-				 "Subproject commit %s\n", sha1_to_hex(sha1));
-	} else if (is_null_sha1(sha1)) {
+				 "Subproject commit %s\n", sha1_to_hex(sha1->oid));
+	} else if (is_null_sha1(sha1->oid)) {
 		/* deleted blob */
 		*size = 0;
 		return xcalloc(1, 1);
 	} else if (textconv) {
 		struct diff_filespec *df = alloc_filespec(path);
-		fill_filespec(df, sha1, 1, mode);
+		fill_filespec(df, sha1->oid, 1, mode);
 		*size = fill_textconv(textconv, df, &blob);
 		free_filespec(df);
 	} else {
-		blob = read_sha1_file(sha1, &type, size);
+		blob = read_sha1_file(sha1->oid, &type, size);
 		if (type != OBJ_BLOB)
-			die("object '%s' is not a blob!", sha1_to_hex(sha1));
+			die("object '%s' is not a blob!", sha1_to_hex(sha1->oid));
 	}
 	return blob;
 }
@@ -379,7 +379,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const unsigned char *parent, unsigned int mode,
+static void combine_diff(const struct object_id *parent, unsigned int mode,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted,
@@ -904,11 +904,11 @@ static void show_combined_header(struct combine_diff_path *elem,
 			 "", elem->path, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
-		abb = find_unique_abbrev(elem->parent[i].sha1,
+		abb = find_unique_abbrev(elem->parent[i].sha1.oid,
 					 abbrev);
 		printf("%s%s", i ? "," : "", abb);
 	}
-	abb = find_unique_abbrev(elem->sha1, abbrev);
+	abb = find_unique_abbrev(elem->sha1.oid, abbrev);
 	printf("..%s%s\n", abb, c_reset);
 
 	if (mode_differs) {
@@ -981,7 +981,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
-		result = grab_blob(elem->sha1, elem->mode, &result_size,
+		result = grab_blob(&elem->sha1, elem->mode, &result_size,
 				   textconv, elem->path);
 	else {
 		/* Used by diff-tree to read from the working tree */
@@ -1003,12 +1003,12 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result = strbuf_detach(&buf, NULL);
 			elem->mode = canon_mode(st.st_mode);
 		} else if (S_ISDIR(st.st_mode)) {
-			unsigned char sha1[20];
-			if (resolve_gitlink_ref(elem->path, "HEAD", sha1) < 0)
-				result = grab_blob(elem->sha1, elem->mode,
+			struct object_id sha1;
+			if (resolve_gitlink_ref(elem->path, "HEAD", sha1.oid) < 0)
+				result = grab_blob(&elem->sha1, elem->mode,
 						   &result_size, NULL, NULL);
 			else
-				result = grab_blob(sha1, elem->mode,
+				result = grab_blob(&sha1, elem->mode,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
@@ -1080,7 +1080,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		for (i = 0; !is_binary && i < num_parent; i++) {
 			char *buf;
 			unsigned long size;
-			buf = grab_blob(elem->parent[i].sha1,
+			buf = grab_blob(&elem->parent[i].sha1,
 					elem->parent[i].mode,
 					&size, NULL, NULL);
 			if (buffer_is_binary(buf, size))
@@ -1129,14 +1129,14 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	for (i = 0; i < num_parent; i++) {
 		int j;
 		for (j = 0; j < i; j++) {
-			if (!hashcmp(elem->parent[i].sha1,
-				     elem->parent[j].sha1)) {
+			if (!hashcmp(elem->parent[i].sha1.oid,
+				     elem->parent[j].sha1.oid)) {
 				reuse_combine_diff(sline, cnt, i, j);
 				break;
 			}
 		}
 		if (i <= j)
-			combine_diff(elem->parent[i].sha1,
+			combine_diff(&elem->parent[i].sha1,
 				     elem->parent[i].mode,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted,
@@ -1196,9 +1196,9 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 
 		/* Show sha1's */
 		for (i = 0; i < num_parent; i++)
-			printf(" %s", diff_unique_abbrev(p->parent[i].sha1,
+			printf(" %s", diff_unique_abbrev(p->parent[i].sha1.oid,
 							 opt->abbrev));
-		printf(" %s ", diff_unique_abbrev(p->sha1, opt->abbrev));
+		printf(" %s ", diff_unique_abbrev(p->sha1.oid, opt->abbrev));
 	}
 
 	if (opt->output_format & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS)) {
@@ -1261,16 +1261,16 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	for (i = 0; i < num_parent; i++) {
 		pair->one[i].path = p->path;
 		pair->one[i].mode = p->parent[i].mode;
-		hashcpy(pair->one[i].sha1, p->parent[i].sha1);
-		pair->one[i].sha1_valid = !is_null_sha1(p->parent[i].sha1);
+		hashcpy(pair->one[i].sha1, p->parent[i].sha1.oid);
+		pair->one[i].sha1_valid = !is_null_sha1(p->parent[i].sha1.oid);
 		pair->one[i].has_more_entries = 1;
 	}
 	pair->one[num_parent - 1].has_more_entries = 0;
 
 	pair->two->path = p->path;
 	pair->two->mode = p->mode;
-	hashcpy(pair->two->sha1, p->sha1);
-	pair->two->sha1_valid = !is_null_sha1(p->sha1);
+	hashcpy(pair->two->sha1, p->sha1.oid);
+	pair->two->sha1_valid = !is_null_sha1(p->sha1.oid);
 	return pair;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index 0448729..4b74a02 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -124,7 +124,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			dpath->next = NULL;
 			memcpy(dpath->path, ce->name, path_len);
 			dpath->path[path_len] = '\0';
-			hashclr(dpath->sha1);
+			hashclr(dpath->sha1.oid);
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
 
@@ -154,7 +154,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				if (2 <= stage) {
 					int mode = nce->ce_mode;
 					num_compare_stages++;
-					hashcpy(dpath->parent[stage-2].sha1, nce->sha1);
+					hashcpy(dpath->parent[stage-2].sha1.oid, nce->sha1);
 					dpath->parent[stage-2].mode = ce_mode_from_stat(nce, mode);
 					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
@@ -326,14 +326,14 @@ static int show_modified(struct rev_info *revs,
 		memcpy(p->path, new->name, pathlen);
 		p->path[pathlen] = 0;
 		p->mode = mode;
-		hashclr(p->sha1);
+		hashclr(p->sha1.oid);
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
 		p->parent[0].mode = new->ce_mode;
-		hashcpy(p->parent[0].sha1, new->sha1);
+		hashcpy(p->parent[0].sha1.oid, new->sha1);
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old->ce_mode;
-		hashcpy(p->parent[1].sha1, old->sha1);
+		hashcpy(p->parent[1].sha1.oid, old->sha1);
 		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
 		free(p);
 		return 0;
diff --git a/diff.h b/diff.h
index a24a767..38bb1ed 100644
--- a/diff.h
+++ b/diff.h
@@ -6,6 +6,7 @@
 
 #include "tree-walk.h"
 #include "pathspec.h"
+#include "object.h"
 
 struct rev_info;
 struct diff_options;
@@ -200,11 +201,11 @@ struct combine_diff_path {
 	struct combine_diff_path *next;
 	char *path;
 	unsigned int mode;
-	unsigned char sha1[20];
+	struct object_id sha1;
 	struct combine_diff_parent {
 		char status;
 		unsigned int mode;
-		unsigned char sha1[20];
+		struct object_id sha1;
 	} parent[FLEX_ARRAY];
 };
 #define combine_diff_path_size(n, l) \
-- 
2.0.0.rc0
