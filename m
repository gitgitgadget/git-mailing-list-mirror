From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] git-apply doesn't handle same name patches well [V4]
Date: Fri, 27 Jun 2008 14:39:12 -0400
Message-ID: <1214591952-3763-1-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 20:40:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIrt-0005zS-0N
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbYF0SjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755567AbYF0SjS
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:39:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59894 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392AbYF0SjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:39:16 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5RIdFP7026256
	for <git@vger.kernel.org>; Fri, 27 Jun 2008 14:39:15 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5RIdC6s018560;
	Fri, 27 Jun 2008 14:39:14 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5RIdCEh031971;
	Fri, 27 Jun 2008 14:39:12 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5RIdChv003795;
	Fri, 27 Jun 2008 14:39:12 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5RIdCrQ003794;
	Fri, 27 Jun 2008 14:39:12 -0400
X-Mailer: git-send-email 1.5.6.rc2.48.g13da
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86621>

When working with a lot of people who backport patches all day long, every
once in a while I get a patch that modifies the same file more than once
inside the same patch.  git-apply either fails if the second change relies
on the first change or silently drops the first change if the second change
is independent.

The silent part is the scary scenario for us.  Also this behaviour is
different from the patch-utils.

I have modified git-apply to create a table of the filenames of files it
modifies such that if a later patch chunk modifies a file in the table it
will buffer the previously changed file instead of reading the original file
from disk.

Logic has been put in to handle creations/deletions/renames/copies.  All the
relevant tests of git-apply succeed.

A new test has been added to cover the cases I addressed.

The fix is relatively straight-forward.

Signed-off-by: Don Zickus <dzickus@redhat.com>

---

Changes since v3
================
various improvements based on suggestions from Junio
*NOTE* I'm not entirely sure I got the mode bits right and the cache/index
stuff correct.  It seems to work correctly but I didn't test every
permutation.
- simplified check_patch() using new mechanisms
- re-used mode bits if lookup succeeds in check_preimage
- add test to verify A->B, C->A, A->A works
- cheap memset hack to deal with pointers to free'd memory
- rename fn_cache to fn_table
- hours lost chasing down weird behaviour from test results :)

Changes since v2
================
- the updated patch not a v1 copy (doh!)

Changes since v1
================
- converted to path-list structs
- added testcases for renaming a patch and apply a new patch on top inside
the same patch file
---
 builtin-apply.c          |   82 +++++++++++++++++++++++++++++++++++++++-----
 t/t4127-apply-same-fn.sh |   85 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 10 deletions(-)
 create mode 100755 t/t4127-apply-same-fn.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index c497889..34ab637 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -12,6 +12,7 @@
 #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
+#include "path-list.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -185,6 +186,13 @@ struct image {
 	struct line *line;
 };
 
+/*
+ * Caches patch filenames to handle the case where a
+ * patch chunk reuses a filename
+ */
+
+static struct path_list fn_table;
+
 static uint32_t hash_line(const char *cp, size_t len)
 {
 	size_t i;
@@ -2176,15 +2184,62 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 	return 0;
 }
 
+static struct patch *in_fn_table(const char *name)
+{
+	struct path_list_item *item;
+
+	if (name == NULL)
+		return NULL;
+
+	item = path_list_lookup(name, &fn_table);
+	if (item != NULL)
+		return (struct patch *)item->util;
+
+	return NULL;
+}
+
+static void add_to_fn_table(struct patch *patch)
+{
+	struct path_list_item *item;
+
+	/*
+	 * Always add new_name unless patch is a deletion
+	 * This should cover the cases for normal diffs,
+	 * file creations and copies
+	 */
+	if (patch->new_name != NULL) {
+		item = path_list_insert(patch->new_name, &fn_table);
+		item->util = patch;
+	}
+
+	/*
+	 * store a failure on rename/deletion cases because
+	 * later chunks shouldn't patch old names
+	 */
+	if ((patch->new_name == NULL) || (patch->is_rename)) {
+		item = path_list_insert(patch->old_name, &fn_table);
+		item->util = (struct patch *) -1;
+	}
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf;
 	struct image image;
 	size_t len;
 	char *img;
+	struct patch *tpatch;
 
 	strbuf_init(&buf, 0);
-	if (cached) {
+
+	if ((tpatch = in_fn_table(patch->old_name)) != NULL) {
+		if (tpatch == (struct patch *) -1) {
+			return error("patch %s has been renamed/deleted",
+				patch->old_name);
+		}
+		/* We have a patched copy in memory use that */
+		strbuf_add(&buf, tpatch->result, tpatch->resultsize);
+	} else if (cached) {
 		if (read_file_or_gitlink(ce, &buf))
 			return error("read of %s failed", patch->old_name);
 	} else if (patch->old_name) {
@@ -2211,6 +2266,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 		return -1; /* note with --reject this succeeds. */
 	patch->result = image.buf;
 	patch->resultsize = image.len;
+	add_to_fn_table(patch);
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
@@ -2255,6 +2311,7 @@ static int verify_index_match(struct cache_entry *ce, struct stat *st)
 static int check_preimage(struct patch *patch, struct cache_entry **ce, struct stat *st)
 {
 	const char *old_name = patch->old_name;
+	struct patch *tpatch;
 	int stat_ret = 0;
 	unsigned st_mode = 0;
 
@@ -2268,12 +2325,17 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		return 0;
 
 	assert(patch->is_new <= 0);
-	if (!cached) {
+	if ((tpatch = in_fn_table(old_name)) != NULL) {
+		if (tpatch == (struct patch *) -1) {
+			return error("%s: has been deleted/renamed", old_name);
+		}
+		st_mode = tpatch->new_mode;
+	} else if (!cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
 			return error("%s: %s", old_name, strerror(errno));
 	}
-	if (check_index) {
+	if (check_index && !tpatch) {
 		int pos = cache_name_pos(old_name, strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
@@ -2325,7 +2387,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	return 0;
 }
 
-static int check_patch(struct patch *patch, struct patch *prev_patch)
+static int check_patch(struct patch *patch)
 {
 	struct stat st;
 	const char *old_name = patch->old_name;
@@ -2342,8 +2404,7 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 		return status;
 	old_name = patch->old_name;
 
-	if (new_name && prev_patch && 0 < prev_patch->is_delete &&
-	    !strcmp(prev_patch->old_name, new_name))
+	if (in_fn_table(new_name) == (struct patch *) -1)
 		/*
 		 * A type-change diff is always split into a patch to
 		 * delete old, immediately followed by a patch to
@@ -2393,15 +2454,14 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 
 static int check_patch_list(struct patch *patch)
 {
-	struct patch *prev_patch = NULL;
 	int err = 0;
 
-	for (prev_patch = NULL; patch ; patch = patch->next) {
+	while (patch) {
 		if (apply_verbosely)
 			say_patch_name(stderr,
 				       "Checking patch ", patch, "...\n");
-		err |= check_patch(patch, prev_patch);
-		prev_patch = patch;
+		err |= check_patch(patch);
+		patch = patch->next;
 	}
 	return err;
 }
@@ -2919,6 +2979,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
+	/* FIXME - memory leak when using multiple patch files as inputs */
+	memset(&fn_table, 0, sizeof(struct path_list));
 	strbuf_init(&buf, 0);
 	patch_input_file = filename;
 	read_patch_file(&buf, fd);
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
new file mode 100755
index 0000000..2a6ed77
--- /dev/null
+++ b/t/t4127-apply-same-fn.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='apply same filename'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	for i in a b c d e f g h i j k l m
+	do
+		echo $i
+	done >same_fn &&
+	cp same_fn other_fn &&
+	git add same_fn other_fn &&
+	git commit -m initial
+'
+test_expect_success 'apply same filename with independent changes' '
+	sed -i -e "s/^d/z/" same_fn &&
+	git diff > patch0 &&
+	git add same_fn &&
+	sed -i -e "s/^i/y/" same_fn &&
+	git diff >> patch0 &&
+	cp same_fn same_fn2 &&
+	git reset --hard &&
+	git-apply patch0 &&
+	diff same_fn same_fn2
+'
+
+test_expect_success 'apply same filename with overlapping changes' '
+	git reset --hard
+	sed -i -e "s/^d/z/" same_fn &&
+	git diff > patch0 &&
+	git add same_fn &&
+	sed -i -e "s/^e/y/" same_fn &&
+	git diff >> patch0 &&
+	cp same_fn same_fn2 &&
+	git reset --hard &&
+	git-apply patch0 &&
+	diff same_fn same_fn2
+'
+
+test_expect_success 'apply same new filename after rename' '
+	git reset --hard
+	git mv same_fn new_fn
+	sed -i -e "s/^d/z/" new_fn &&
+	git add new_fn &&
+	git diff -M --cached > patch1 &&
+	sed -i -e "s/^e/y/" new_fn &&
+	git diff >> patch1 &&
+	cp new_fn new_fn2 &&
+	git reset --hard &&
+	git apply --index patch1 &&
+	diff new_fn new_fn2
+'
+
+test_expect_success 'apply same old filename after rename -- should fail.' '
+	git reset --hard
+	git mv same_fn new_fn
+	sed -i -e "s/^d/z/" new_fn &&
+	git add new_fn &&
+	git diff -M --cached > patch1 &&
+	git mv new_fn same_fn
+	sed -i -e "s/^e/y/" same_fn &&
+	git diff >> patch1 &&
+	git reset --hard &&
+	test_must_fail git apply patch1
+'
+
+test_expect_success 'apply A->B (rename), C->A (rename), A->A -- should pass.' '
+	git reset --hard
+	git mv same_fn new_fn
+	sed -i -e "s/^d/z/" new_fn &&
+	git add new_fn &&
+	git diff -M --cached > patch1 &&
+	git commit -m "a rename" &&
+	git mv other_fn same_fn
+	sed -i -e "s/^e/y/" same_fn &&
+	git add same_fn &&
+	git diff -M --cached >> patch1 &&
+	sed -i -e "s/^g/x/" same_fn &&
+	git diff >> patch1 &&
+	git reset --hard HEAD^ &&
+	git apply patch1
+'
+
+test_done
-- 
1.5.6.rc2.48.g13da
