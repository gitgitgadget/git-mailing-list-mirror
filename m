From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 07/10] diff: convert struct combine_diff_path to object_id
Date: Sat,  7 Mar 2015 23:24:02 +0000
Message-ID: <1425770645-628957-8-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO5S-0001zh-KF
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbbCGXYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:33 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49840 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753160AbbCGXYS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:18 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 550E128097;
	Sat,  7 Mar 2015 23:24:17 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265019>

Also, convert a constant to GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 combine-diff.c | 56 ++++++++++++++++++++++++++++----------------------------
 diff-lib.c     | 10 +++++-----
 diff.h         |  5 +++--
 tree-diff.c    | 10 +++++-----
 4 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 91edce5..ec25202 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -44,9 +44,9 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			memset(p->parent, 0,
 			       sizeof(p->parent[0]) * num_parent);
 
-			hashcpy(p->sha1, q->queue[i]->two->sha1);
+			hashcpy(p->oid.sha1, q->queue[i]->two->sha1);
 			p->mode = q->queue[i]->two->mode;
-			hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
+			hashcpy(p->parent[n].oid.sha1, q->queue[i]->one->sha1);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
 			*tail = p;
@@ -77,7 +77,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			continue;
 		}
 
-		hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
+		hashcpy(p->parent[n].oid.sha1, q->queue[i]->one->sha1);
 		p->parent[n].mode = q->queue[i]->one->mode;
 		p->parent[n].status = q->queue[i]->status;
 
@@ -284,7 +284,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	return base;
 }
 
-static char *grab_blob(const unsigned char *sha1, unsigned int mode,
+static char *grab_blob(const struct object_id *oid, unsigned int mode,
 		       unsigned long *size, struct userdiff_driver *textconv,
 		       const char *path)
 {
@@ -294,20 +294,20 @@ static char *grab_blob(const unsigned char *sha1, unsigned int mode,
 	if (S_ISGITLINK(mode)) {
 		blob = xmalloc(100);
 		*size = snprintf(blob, 100,
-				 "Subproject commit %s\n", sha1_to_hex(sha1));
-	} else if (is_null_sha1(sha1)) {
+				 "Subproject commit %s\n", oid_to_hex(oid));
+	} else if (is_null_oid(oid)) {
 		/* deleted blob */
 		*size = 0;
 		return xcalloc(1, 1);
 	} else if (textconv) {
 		struct diff_filespec *df = alloc_filespec(path);
-		fill_filespec(df, sha1, 1, mode);
+		fill_filespec(df, oid->sha1, 1, mode);
 		*size = fill_textconv(textconv, df, &blob);
 		free_filespec(df);
 	} else {
-		blob = read_sha1_file(sha1, &type, size);
+		blob = read_sha1_file(oid->sha1, &type, size);
 		if (type != OBJ_BLOB)
-			die("object '%s' is not a blob!", sha1_to_hex(sha1));
+			die("object '%s' is not a blob!", oid_to_hex(oid));
 	}
 	return blob;
 }
@@ -389,7 +389,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const unsigned char *parent, unsigned int mode,
+static void combine_diff(const struct object_id *parent, unsigned int mode,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted,
@@ -897,7 +897,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 int show_file_header)
 {
 	struct diff_options *opt = &rev->diffopt;
-	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
+	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? GIT_SHA1_HEXSZ : DEFAULT_ABBREV;
 	const char *a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
 	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
 	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
@@ -914,11 +914,11 @@ static void show_combined_header(struct combine_diff_path *elem,
 			 "", elem->path, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
-		abb = find_unique_abbrev(elem->parent[i].sha1,
+		abb = find_unique_abbrev(elem->parent[i].oid.sha1,
 					 abbrev);
 		printf("%s%s", i ? "," : "", abb);
 	}
-	abb = find_unique_abbrev(elem->sha1, abbrev);
+	abb = find_unique_abbrev(elem->oid.sha1, abbrev);
 	printf("..%s%s\n", abb, c_reset);
 
 	if (mode_differs) {
@@ -991,7 +991,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
-		result = grab_blob(elem->sha1, elem->mode, &result_size,
+		result = grab_blob(&elem->oid, elem->mode, &result_size,
 				   textconv, elem->path);
 	else {
 		/* Used by diff-tree to read from the working tree */
@@ -1013,12 +1013,12 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result = strbuf_detach(&buf, NULL);
 			elem->mode = canon_mode(st.st_mode);
 		} else if (S_ISDIR(st.st_mode)) {
-			unsigned char sha1[20];
-			if (resolve_gitlink_ref(elem->path, "HEAD", sha1) < 0)
-				result = grab_blob(elem->sha1, elem->mode,
+			struct object_id oid;
+			if (resolve_gitlink_ref(elem->path, "HEAD", oid.sha1) < 0)
+				result = grab_blob(&elem->oid, elem->mode,
 						   &result_size, NULL, NULL);
 			else
-				result = grab_blob(sha1, elem->mode,
+				result = grab_blob(&oid, elem->mode,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
@@ -1090,7 +1090,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		for (i = 0; !is_binary && i < num_parent; i++) {
 			char *buf;
 			unsigned long size;
-			buf = grab_blob(elem->parent[i].sha1,
+			buf = grab_blob(&elem->parent[i].oid,
 					elem->parent[i].mode,
 					&size, NULL, NULL);
 			if (buffer_is_binary(buf, size))
@@ -1139,14 +1139,14 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	for (i = 0; i < num_parent; i++) {
 		int j;
 		for (j = 0; j < i; j++) {
-			if (!hashcmp(elem->parent[i].sha1,
-				     elem->parent[j].sha1)) {
+			if (!hashcmp(elem->parent[i].oid.sha1,
+				     elem->parent[j].oid.sha1)) {
 				reuse_combine_diff(sline, cnt, i, j);
 				break;
 			}
 		}
 		if (i <= j)
-			combine_diff(elem->parent[i].sha1,
+			combine_diff(&elem->parent[i].oid,
 				     elem->parent[i].mode,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted,
@@ -1206,9 +1206,9 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 
 		/* Show sha1's */
 		for (i = 0; i < num_parent; i++)
-			printf(" %s", diff_unique_abbrev(p->parent[i].sha1,
+			printf(" %s", diff_unique_abbrev(p->parent[i].oid.sha1,
 							 opt->abbrev));
-		printf(" %s ", diff_unique_abbrev(p->sha1, opt->abbrev));
+		printf(" %s ", diff_unique_abbrev(p->oid.sha1, opt->abbrev));
 	}
 
 	if (opt->output_format & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS)) {
@@ -1271,16 +1271,16 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	for (i = 0; i < num_parent; i++) {
 		pair->one[i].path = p->path;
 		pair->one[i].mode = p->parent[i].mode;
-		hashcpy(pair->one[i].sha1, p->parent[i].sha1);
-		pair->one[i].sha1_valid = !is_null_sha1(p->parent[i].sha1);
+		hashcpy(pair->one[i].sha1, p->parent[i].oid.sha1);
+		pair->one[i].sha1_valid = !is_null_oid(&p->parent[i].oid);
 		pair->one[i].has_more_entries = 1;
 	}
 	pair->one[num_parent - 1].has_more_entries = 0;
 
 	pair->two->path = p->path;
 	pair->two->mode = p->mode;
-	hashcpy(pair->two->sha1, p->sha1);
-	pair->two->sha1_valid = !is_null_sha1(p->sha1);
+	hashcpy(pair->two->sha1, p->oid.sha1);
+	pair->two->sha1_valid = !is_null_oid(&p->oid);
 	return pair;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index a85c497..60a7d6f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -125,7 +125,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			dpath->next = NULL;
 			memcpy(dpath->path, ce->name, path_len);
 			dpath->path[path_len] = '\0';
-			hashclr(dpath->sha1);
+			oidclr(&dpath->oid);
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
 
@@ -155,7 +155,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				if (2 <= stage) {
 					int mode = nce->ce_mode;
 					num_compare_stages++;
-					hashcpy(dpath->parent[stage-2].sha1, nce->sha1);
+					hashcpy(dpath->parent[stage-2].oid.sha1, nce->sha1);
 					dpath->parent[stage-2].mode = ce_mode_from_stat(nce, mode);
 					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
@@ -339,14 +339,14 @@ static int show_modified(struct rev_info *revs,
 		memcpy(p->path, new->name, pathlen);
 		p->path[pathlen] = 0;
 		p->mode = mode;
-		hashclr(p->sha1);
+		oidclr(&p->oid);
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
 		p->parent[0].mode = new->ce_mode;
-		hashcpy(p->parent[0].sha1, new->sha1);
+		hashcpy(p->parent[0].oid.sha1, new->sha1);
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old->ce_mode;
-		hashcpy(p->parent[1].sha1, old->sha1);
+		hashcpy(p->parent[1].oid.sha1, old->sha1);
 		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
 		free(p);
 		return 0;
diff --git a/diff.h b/diff.h
index b4a624d..f6fdf49 100644
--- a/diff.h
+++ b/diff.h
@@ -6,6 +6,7 @@
 
 #include "tree-walk.h"
 #include "pathspec.h"
+#include "object.h"
 
 struct rev_info;
 struct diff_options;
@@ -207,11 +208,11 @@ struct combine_diff_path {
 	struct combine_diff_path *next;
 	char *path;
 	unsigned int mode;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct combine_diff_parent {
 		char status;
 		unsigned int mode;
-		unsigned char sha1[20];
+		struct object_id oid;
 	} parent[FLEX_ARRAY];
 };
 #define combine_diff_path_size(n, l) \
diff --git a/tree-diff.c b/tree-diff.c
index e7b378c..8631c28 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -64,7 +64,7 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
 {
 	struct combine_diff_parent *p0 = &p->parent[0];
 	if (p->mode && p0->mode) {
-		opt->change(opt, p0->mode, p->mode, p0->sha1, p->sha1,
+		opt->change(opt, p0->mode, p->mode, p0->oid.sha1, p->oid.sha1,
 			1, 1, p->path, 0, 0);
 	}
 	else {
@@ -74,11 +74,11 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
 
 		if (p->mode) {
 			addremove = '+';
-			sha1 = p->sha1;
+			sha1 = p->oid.sha1;
 			mode = p->mode;
 		} else {
 			addremove = '-';
-			sha1 = p0->sha1;
+			sha1 = p0->oid.sha1;
 			mode = p0->mode;
 		}
 
@@ -151,7 +151,7 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	memcpy(p->path + base->len, path, pathlen);
 	p->path[len] = 0;
 	p->mode = mode;
-	hashcpy(p->sha1, sha1 ? sha1 : null_sha1);
+	hashcpy(p->oid.sha1, sha1 ? sha1 : null_sha1);
 
 	return p;
 }
@@ -238,7 +238,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 			}
 
 			p->parent[i].mode = mode_i;
-			hashcpy(p->parent[i].sha1, sha1_i ? sha1_i : null_sha1);
+			hashcpy(p->parent[i].oid.sha1, sha1_i ? sha1_i : null_sha1);
 		}
 
 		keep = 1;
-- 
2.2.1.209.g41e5f3a
