From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] Which merge_file() function do you mean?
Date: Wed, 26 Dec 2012 15:03:36 -0800
Message-ID: <1356563020-13919-2-git-send-email-gitster@pobox.com>
References: <1356563020-13919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 00:04:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To015-000797-5g
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 00:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab2LZXDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 18:03:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab2LZXDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 18:03:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D10A31E
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=y7FI
	RaiR5KOGQ5NZZrDHtLH7Kuc=; b=x1L/GSVS6dWxtn+loy1yO01aYb7d/ZVnxlzS
	mrS0fAlchFJK/nraqSdD5X5vLscpu/C6DfupXFL3l1It7S/90zLJHt5XSV07XijA
	ksBU2Gt/iVfUuQDp2Rdm9a5UlJ+aZumW6qv2JxnZSPNoDvz+IzWVCFld0vEtZH6P
	9ypKps0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UC8/fw
	dC2Ggqv1L+p7I8gh9forNHK6RjVzvJyIieh/LW0f+3KDcwuJhLkAb+IsCD0g3S68
	honm6YaG+YmOizeoUDtjF0qI6enKBVYGkwIQlYAZntoxVC+BSdailHIEyn/Aw/xa
	Q0Gr6wURin9X5CzPtX97CDNeg51h5Zl/PQ+Bk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DD40A31D
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A336A31C for
 <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc3.356.g686f81c
In-Reply-To: <1356563020-13919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7F38948E-4FB0-11E2-B9F0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212163>

There are two different static functions and one global function,
all of them called "merge_file()", with different signatures and
purposes.  Rename them all to reduce confusion in "git grep" output:

 * Rename the static one in merge-index to "merge_one_path(const char
   *path)" as that function is about asking an external command to
   resolve conflicts in one path.

 * Rename the global one in merge-file.c that is only used by
   merge-tree to "merge_blobs()", as the function takes three blobs and
   returns the merged result only in-core, without doing anything to
   the filesystem.

 * Rename the one in merge-recursive to "merge_one_file()", just to be
   fair.

Also rename merge-file.[ch] to merge-blobs.[ch].

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile              |   2 +-
 builtin/merge-index.c |   4 +-
 builtin/merge-tree.c  |   4 +-
 merge-blobs.c         | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 merge-blobs.h         |   8 ++++
 merge-file.c          | 124 --------------------------------------------------
 merge-file.h          |   7 ---
 merge-recursive.c     |   6 +--
 8 files changed, 140 insertions(+), 139 deletions(-)
 create mode 100644 merge-blobs.c
 create mode 100644 merge-blobs.h
 delete mode 100644 merge-file.c
 delete mode 100644 merge-file.h

diff --git a/Makefile b/Makefile
index 4ad6fbd..26ec519 100644
--- a/Makefile
+++ b/Makefile
@@ -765,7 +765,7 @@ LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge.o
-LIB_OBJS += merge-file.o
+LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += name-hash.o
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2338832..be5e514 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -42,7 +42,7 @@ static int merge_entry(int pos, const char *path)
 	return found;
 }
 
-static void merge_file(const char *path)
+static void merge_one_path(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
@@ -102,7 +102,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		merge_file(arg);
+		merge_one_path(arg);
 	}
 	if (err && !quiet)
 		die("merge program failed");
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 897a563..ebd0d25 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,7 +3,7 @@
 #include "xdiff-interface.h"
 #include "blob.h"
 #include "exec_cmd.h"
-#include "merge-file.h"
+#include "merge-blobs.h"
 
 static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
@@ -76,7 +76,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	their = NULL;
 	if (entry)
 		their = entry->blob;
-	return merge_file(path, base, our, their, size);
+	return merge_blobs(path, base, our, their, size);
 }
 
 static void *origin(struct merge_list *entry, unsigned long *size)
diff --git a/merge-blobs.c b/merge-blobs.c
new file mode 100644
index 0000000..57211bc
--- /dev/null
+++ b/merge-blobs.c
@@ -0,0 +1,124 @@
+#include "cache.h"
+#include "run-command.h"
+#include "xdiff-interface.h"
+#include "ll-merge.h"
+#include "blob.h"
+#include "merge-blobs.h"
+
+static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
+{
+	void *buf;
+	unsigned long size;
+	enum object_type type;
+
+	buf = read_sha1_file(obj->object.sha1, &type, &size);
+	if (!buf)
+		return -1;
+	if (type != OBJ_BLOB)
+		return -1;
+	f->ptr = buf;
+	f->size = size;
+	return 0;
+}
+
+static void free_mmfile(mmfile_t *f)
+{
+	free(f->ptr);
+}
+
+static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
+{
+	int merge_status;
+	mmbuffer_t res;
+
+	/*
+	 * This function is only used by cmd_merge_tree, which
+	 * does not respect the merge.conflictstyle option.
+	 * There is no need to worry about a label for the
+	 * common ancestor.
+	 */
+	merge_status = ll_merge(&res, path, base, NULL,
+				our, ".our", their, ".their", NULL);
+	if (merge_status < 0)
+		return NULL;
+
+	*size = res.size;
+	return res.ptr;
+}
+
+static int common_outf(void *priv_, mmbuffer_t *mb, int nbuf)
+{
+	int i;
+	mmfile_t *dst = priv_;
+
+	for (i = 0; i < nbuf; i++) {
+		memcpy(dst->ptr + dst->size, mb[i].ptr, mb[i].size);
+		dst->size += mb[i].size;
+	}
+	return 0;
+}
+
+static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
+{
+	unsigned long size = f1->size < f2->size ? f1->size : f2->size;
+	void *ptr = xmalloc(size);
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags = 0;
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = 3;
+	xecfg.flags = XDL_EMIT_COMMON;
+	ecb.outf = common_outf;
+
+	res->ptr = ptr;
+	res->size = 0;
+
+	ecb.priv = res;
+	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
+}
+
+void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+{
+	void *res = NULL;
+	mmfile_t f1, f2, common;
+
+	/*
+	 * Removed in either branch?
+	 *
+	 * NOTE! This depends on the caller having done the
+	 * proper warning about removing a file that got
+	 * modified in the other branch!
+	 */
+	if (!our || !their) {
+		enum object_type type;
+		if (base)
+			return NULL;
+		if (!our)
+			our = their;
+		return read_sha1_file(our->object.sha1, &type, size);
+	}
+
+	if (fill_mmfile_blob(&f1, our) < 0)
+		goto out_no_mmfile;
+	if (fill_mmfile_blob(&f2, their) < 0)
+		goto out_free_f1;
+
+	if (base) {
+		if (fill_mmfile_blob(&common, base) < 0)
+			goto out_free_f2_f1;
+	} else {
+		if (generate_common_file(&common, &f1, &f2) < 0)
+			goto out_free_f2_f1;
+	}
+	res = three_way_filemerge(path, &common, &f1, &f2, size);
+	free_mmfile(&common);
+out_free_f2_f1:
+	free_mmfile(&f2);
+out_free_f1:
+	free_mmfile(&f1);
+out_no_mmfile:
+	return res;
+}
diff --git a/merge-blobs.h b/merge-blobs.h
new file mode 100644
index 0000000..62b569e
--- /dev/null
+++ b/merge-blobs.h
@@ -0,0 +1,8 @@
+#ifndef MERGE_BLOBS_H
+#define MERGE_BLOBS_H
+
+#include "blob.h"
+
+extern void *merge_blobs(const char *, struct blob *, struct blob *, struct blob *, unsigned long *);
+
+#endif /* MERGE_BLOBS_H */
diff --git a/merge-file.c b/merge-file.c
deleted file mode 100644
index 7845528..0000000
--- a/merge-file.c
+++ /dev/null
@@ -1,124 +0,0 @@
-#include "cache.h"
-#include "run-command.h"
-#include "xdiff-interface.h"
-#include "ll-merge.h"
-#include "blob.h"
-#include "merge-file.h"
-
-static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
-{
-	void *buf;
-	unsigned long size;
-	enum object_type type;
-
-	buf = read_sha1_file(obj->object.sha1, &type, &size);
-	if (!buf)
-		return -1;
-	if (type != OBJ_BLOB)
-		return -1;
-	f->ptr = buf;
-	f->size = size;
-	return 0;
-}
-
-static void free_mmfile(mmfile_t *f)
-{
-	free(f->ptr);
-}
-
-static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
-{
-	int merge_status;
-	mmbuffer_t res;
-
-	/*
-	 * This function is only used by cmd_merge_tree, which
-	 * does not respect the merge.conflictstyle option.
-	 * There is no need to worry about a label for the
-	 * common ancestor.
-	 */
-	merge_status = ll_merge(&res, path, base, NULL,
-				our, ".our", their, ".their", NULL);
-	if (merge_status < 0)
-		return NULL;
-
-	*size = res.size;
-	return res.ptr;
-}
-
-static int common_outf(void *priv_, mmbuffer_t *mb, int nbuf)
-{
-	int i;
-	mmfile_t *dst = priv_;
-
-	for (i = 0; i < nbuf; i++) {
-		memcpy(dst->ptr + dst->size, mb[i].ptr, mb[i].size);
-		dst->size += mb[i].size;
-	}
-	return 0;
-}
-
-static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
-{
-	unsigned long size = f1->size < f2->size ? f1->size : f2->size;
-	void *ptr = xmalloc(size);
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
-
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = 0;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 3;
-	xecfg.flags = XDL_EMIT_COMMON;
-	ecb.outf = common_outf;
-
-	res->ptr = ptr;
-	res->size = 0;
-
-	ecb.priv = res;
-	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
-}
-
-void *merge_file(const char *path, struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
-{
-	void *res = NULL;
-	mmfile_t f1, f2, common;
-
-	/*
-	 * Removed in either branch?
-	 *
-	 * NOTE! This depends on the caller having done the
-	 * proper warning about removing a file that got
-	 * modified in the other branch!
-	 */
-	if (!our || !their) {
-		enum object_type type;
-		if (base)
-			return NULL;
-		if (!our)
-			our = their;
-		return read_sha1_file(our->object.sha1, &type, size);
-	}
-
-	if (fill_mmfile_blob(&f1, our) < 0)
-		goto out_no_mmfile;
-	if (fill_mmfile_blob(&f2, their) < 0)
-		goto out_free_f1;
-
-	if (base) {
-		if (fill_mmfile_blob(&common, base) < 0)
-			goto out_free_f2_f1;
-	} else {
-		if (generate_common_file(&common, &f1, &f2) < 0)
-			goto out_free_f2_f1;
-	}
-	res = three_way_filemerge(path, &common, &f1, &f2, size);
-	free_mmfile(&common);
-out_free_f2_f1:
-	free_mmfile(&f2);
-out_free_f1:
-	free_mmfile(&f1);
-out_no_mmfile:
-	return res;
-}
diff --git a/merge-file.h b/merge-file.h
deleted file mode 100644
index 9b3b83a..0000000
--- a/merge-file.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef MERGE_FILE_H
-#define MERGE_FILE_H
-
-extern void *merge_file(const char *path, struct blob *base, struct blob *our,
-			struct blob *their, unsigned long *size);
-
-#endif
diff --git a/merge-recursive.c b/merge-recursive.c
index d882060..33ba5dc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -976,7 +976,7 @@ merge_file_special_markers(struct merge_options *o,
 	return mfi;
 }
 
-static struct merge_file_info merge_file(struct merge_options *o,
+static struct merge_file_info merge_file_one(struct merge_options *o,
 					 const char *path,
 					 const unsigned char *o_sha, int o_mode,
 					 const unsigned char *a_sha, int a_mode,
@@ -1166,7 +1166,7 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		struct merge_file_info mfi;
 		struct diff_filespec other;
 		struct diff_filespec *add;
-		mfi = merge_file(o, one->path,
+		mfi = merge_file_one(o, one->path,
 				 one->sha1, one->mode,
 				 a->sha1, a->mode,
 				 b->sha1, b->mode,
@@ -1450,7 +1450,7 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					mfi = merge_file(o, ren1_dst, null_sha1, 0,
+					mfi = merge_file_one(o, ren1_dst, null_sha1, 0,
 							 ren1->pair->two->sha1, ren1->pair->two->mode,
 							 dst_other.sha1, dst_other.mode,
 							 branch1, branch2);
-- 
1.8.1.rc3.356.g686f81c
