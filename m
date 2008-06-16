From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] git-apply doesn't handle same name patches well [V3]
Date: Mon, 16 Jun 2008 16:04:46 -0400
Message-ID: <1213646686-31964-1-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 22:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8KxT-0001Iu-3g
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbYFPUEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYFPUEs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:04:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbYFPUEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:04:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5GK4lnC001555
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 16:04:47 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5GK4kR3007637;
	Mon, 16 Jun 2008 16:04:46 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5GK4ktq030295;
	Mon, 16 Jun 2008 16:04:46 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5GK4kMr031990;
	Mon, 16 Jun 2008 16:04:46 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5GK4kuX031989;
	Mon, 16 Jun 2008 16:04:46 -0400
X-Mailer: git-send-email 1.5.6.rc2.48.g13da
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85223>

When working with a lot of people who backport patches all day long, every
once in a while I get a patch that modifies the same file more than once
inside the same patch.  git-apply either fails if the second change relies
on the first change or silently drops the first change if the second change
is independent.

The silent part is the scary scenario for us.  Also this behaviour is
different from the patch-utils.

I have modified git-apply to cache the filenames of files it modifies such
that if a later patch chunk modifies a file in the cache it will buffer the
previously changed file instead of reading the original file from disk.

Logic has been put in to handle creations/deletions/renames/copies.  All the
relevant tests of git-apply succeed.

A new test has been added to cover the cases I addressed.  However,
currently adding changes to renamed file inside the same patch doesn't work
correctly (it fails to find new file).  I didn't know how to fix this
correctly, so I have the test fail expectedly.

The fix is relatively straight-forward.  But I'm not sure if this new
behaviour is something the git community wants.

Changes since v2
================
- the updated patch not a v1 copy (doh!)

Changes since v1
================
- converted to path-list structs
- added testcases for renaming a patch and apply a new patch on top inside
the same patch file

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 builtin-apply.c          |   52 +++++++++++++++++++++++++++++++++++-
 t/t4127-apply-same-fn.sh |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 1 deletions(-)
 create mode 100755 t/t4127-apply-same-fn.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index c497889..9f76ce4 100644
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
+struct path_list fn_cache = {NULL, 0, 0, 0};
+
 static uint32_t hash_line(const char *cp, size_t len)
 {
 	size_t i;
@@ -2176,6 +2184,38 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 	return 0;
 }
 
+struct patch *in_fn_cache(char *name)
+{
+	struct path_list_item *item;
+
+	item = path_list_lookup(name, &fn_cache);
+	if (item != NULL)
+		return (struct patch *)item->util;
+
+	return NULL;
+}
+
+void add_to_fn_cache(char *name, struct patch *patch)
+{
+	struct path_list_item *item;
+
+	/* Always add new_name unless patch is a deletion */
+	if (name != NULL) {
+		item = path_list_insert(name, &fn_cache);
+		item->util = patch;
+	}
+
+	/* skip normal diffs, creations and copies */
+	/*
+	 * store a failure on rename/deletion cases because
+	 * later chunks shouldn't patch old names
+	 */
+	if ((name == NULL) || (patch->is_rename)) {
+		item = path_list_insert(patch->old_name, &fn_cache);
+		item->util = (struct patch *) -1;
+	}
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf;
@@ -2188,7 +2228,16 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 		if (read_file_or_gitlink(ce, &buf))
 			return error("read of %s failed", patch->old_name);
 	} else if (patch->old_name) {
-		if (S_ISGITLINK(patch->old_mode)) {
+		struct patch *tpatch = in_fn_cache(patch->old_name);
+
+		if (tpatch != NULL) {
+			if (tpatch == (struct patch *) -1) {
+				return error("patch %s has been renamed/deleted",
+					patch->old_name);
+			}
+			/* We have a patched copy in memory use that */
+			strbuf_add(&buf, tpatch->result, tpatch->resultsize);
+		} else if (S_ISGITLINK(patch->old_mode)) {
 			if (ce) {
 				read_file_or_gitlink(ce, &buf);
 			} else {
@@ -2211,6 +2260,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 		return -1; /* note with --reject this succeeds. */
 	patch->result = image.buf;
 	patch->resultsize = image.len;
+	add_to_fn_cache(patch->new_name, patch);
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
new file mode 100755
index 0000000..47b59d5
--- /dev/null
+++ b/t/t4127-apply-same-fn.sh
@@ -0,0 +1,67 @@
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
+	git add same_fn &&
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
+test_expect_failure 'apply same new filename after rename' '
+	git reset --hard
+	git mv same_fn new_fn
+	sed -i -e "s/^d/z/" new_fn &&
+	git add new_fn &&
+	git diff -M --cached > patch1 &&
+	sed -i -e "s/^e/y/" new_fn &&
+	git diff >> patch1 &&
+	cp new_fn new_fn2 &&
+	git reset --hard &&
+	git apply patch1 &&
+	diff new_fn new_fn2
+'
+
+test_expect_success 'apply same old filename after rename' '
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
+test_done
-- 
1.5.6.rc2.48.g13da
