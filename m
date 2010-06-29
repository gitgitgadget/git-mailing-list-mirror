From: newren@gmail.com
Subject: [PATCH 3/5] merge-recursive: Fix D/F conflicts
Date: Mon, 28 Jun 2010 19:12:14 -0600
Message-ID: <1277773936-12412-4-git-send-email-newren@gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, vmiklos@frugalware.org,
	gitster@pobox.com, spearce@spearce.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:11:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPM5-0006ry-PR
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab0F2BLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:11:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48961 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab0F2BK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:10:58 -0400
Received: by pvg2 with SMTP id 2so2210263pvg.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jQX9aVneGVGgM9Sh5j7UTOdJF/UGrZu80tRu24S3abg=;
        b=WY5X3DNv18AoGWmXdNH3NpOggoZq+fqqx3II610Qa6UB3LGx3PxrMItnRMcC/zan/C
         A1Uwav9bRnmCyebF4H5uISuHzEVemHUzUnNrYcJWirp8aRUnDeS7I0WrbQJ5xXwhgr01
         EEvxzv6e70iDrYNBFQ7I35p/LKO+KEvFu0PWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C9hQg+pNibUHQgHQpe0j7jbYoDc0j2Q/nDjbC+uARssJX8TAam/G+B1q0mxCmwOjFT
         FFfHCCTYwhMwMB2xMoYTS2WPHZIplWeWTgcsKxZaz96RnF2sbj0a6dQEab0k5V7WIGoo
         6amwqbk2EKdDuDJ0LLVvuWbxfInzcIbA+3/HU=
Received: by 10.142.152.29 with SMTP id z29mr6854039wfd.30.1277773855014;
        Mon, 28 Jun 2010 18:10:55 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id x34sm8105171wfi.4.2010.06.28.18.10.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:10:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
In-Reply-To: <1277773936-12412-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149876>

From: Elijah Newren <newren@gmail.com>

The D/F conflicts we know how to resolve (file or directory unmodified on
one side of history), have the nice property that process_entry() can
correctly handle all subpaths of the D/F conflict, and will in fact delete
all non-conflicting files below the relevant directory and the directory
itself in such cases.  So if we handle D/F conflicts after all other
conflicts, they become fairly simple to handle.  We do this by adding an
extra process_df_entry() step after process_renames() and process_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c               |   93 ++++++++++++++++++++++++++++++++-------
 t/t6035-merge-dir-to-symlink.sh |    8 ++--
 2 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..8d70fc0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1072,6 +1072,7 @@ static int process_entry(struct merge_options *o,
 	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
 	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
 
+	entry->processed = 1;
 	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
@@ -1104,33 +1105,28 @@ static int process_entry(struct merge_options *o,
 	} else if ((!o_sha && a_sha && !b_sha) ||
 		   (!o_sha && !a_sha && b_sha)) {
 		/* Case B: Added in one. */
-		const char *add_branch;
-		const char *other_branch;
 		unsigned mode;
 		const unsigned char *sha;
-		const char *conf;
 
 		if (a_sha) {
-			add_branch = o->branch1;
-			other_branch = o->branch2;
 			mode = a_mode;
 			sha = a_sha;
-			conf = "file/directory";
 		} else {
-			add_branch = o->branch2;
-			other_branch = o->branch1;
 			mode = b_mode;
 			sha = b_sha;
-			conf = "directory/file";
 		}
 		if (string_list_has_string(&o->current_directory_set, path)) {
-			const char *new_path = unique_path(o, path, add_branch);
-			clean_merge = 0;
-			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
-			       "Adding %s as %s",
-			       conf, path, other_branch, path, new_path);
-			remove_file(o, 0, path, 0);
-			update_file(o, 0, sha, mode, new_path);
+			/* Handle D->F conflicts after all subfiles */
+			entry->processed = 0;
+			/* But get any file out of the way now, so conflicted
+			 * entries below the directory of the same name can
+			 * be put in the working directory.
+			 */
+			if (a_sha)
+				output(o, 2, "Removing %s", path);
+			/* do not touch working file if it did not exist */
+			remove_file(o, 0, path, !a_sha);
+			return 1; /* Assume clean till processed */
 		} else {
 			output(o, 2, "Adding %s", path);
 			update_file(o, 1, sha, mode, path);
@@ -1178,6 +1174,64 @@ static int process_entry(struct merge_options *o,
 	return clean_merge;
 }
 
+/* Per entry merge function for D/F conflicts, to be called only after
+ * all files below dir have been processed.  We do this because in the
+ * cases we can cleanly resolve D/F conflicts, process_entry() can clean
+ * out all the files below the directory for us.
+ */
+static int process_df_entry(struct merge_options *o,
+			 const char *path, struct stage_data *entry)
+{
+	int clean_merge = 1;
+	unsigned o_mode = entry->stages[1].mode;
+	unsigned a_mode = entry->stages[2].mode;
+	unsigned b_mode = entry->stages[3].mode;
+	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
+	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
+	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
+
+	/* We currently only handle D->F cases */
+	assert((!o_sha && a_sha && !b_sha) ||
+	       (!o_sha && !a_sha && b_sha));
+
+	const char *add_branch;
+	const char *other_branch;
+	unsigned mode;
+	const unsigned char *sha;
+	const char *conf;
+
+	entry->processed = 1;
+
+	if (a_sha) {
+		add_branch = o->branch1;
+		other_branch = o->branch2;
+		mode = a_mode;
+		sha = a_sha;
+		conf = "file/directory";
+	} else {
+		add_branch = o->branch2;
+		other_branch = o->branch1;
+		mode = b_mode;
+		sha = b_sha;
+		conf = "directory/file";
+	}
+	struct stat st;
+	if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+		const char *new_path = unique_path(o, path, add_branch);
+		clean_merge = 0;
+		output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
+		       "Adding %s as %s",
+		       conf, path, other_branch, path, new_path);
+		remove_file(o, 0, path, 0);
+		update_file(o, 0, sha, mode, new_path);
+	} else {
+		output(o, 2, "Adding %s", path);
+		update_file(o, 1, sha, mode, path);
+	}
+
+	return clean_merge;
+}
+
 struct unpack_trees_error_msgs get_porcelain_error_msgs(void)
 {
 	struct unpack_trees_error_msgs msgs = {
@@ -1249,6 +1303,13 @@ int merge_trees(struct merge_options *o,
 				&& !process_entry(o, path, e))
 				clean = 0;
 		}
+		for (i = 0; i < entries->nr; i++) {
+			const char *path = entries->items[i].string;
+			struct stage_data *e = entries->items[i].util;
+			if (!e->processed
+				&& !process_df_entry(o, path, e))
+				clean = 0;
+		}
 
 		string_list_clear(re_merge, 0);
 		string_list_clear(re_head, 0);
diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 4f04f41..64387a0 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -56,7 +56,7 @@ test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
 	test -f a/b-2/c/d
 '
 
-test_expect_failure 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive master &&
@@ -64,7 +64,7 @@ test_expect_failure 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recurs
 	test -f a/b-2/c/d
 '
 
-test_expect_failure 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout master &&
 	git merge -s recursive baseline^0 &&
@@ -107,7 +107,7 @@ test_expect_success 'merge should not have conflicts (resolve)' '
 	test -f a/b/c/d
 '
 
-test_expect_failure 'merge should not have D/F conflicts (recursive)' '
+test_expect_success 'merge should not have D/F conflicts (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive test2 &&
@@ -115,7 +115,7 @@ test_expect_failure 'merge should not have D/F conflicts (recursive)' '
 	test -f a/b/c/d
 '
 
-test_expect_failure 'merge should not have F/D conflicts (recursive)' '
+test_expect_success 'merge should not have F/D conflicts (recursive)' '
 	git reset --hard &&
 	git checkout -b foo test2 &&
 	git merge -s recursive baseline^0 &&
-- 
1.7.2.rc0.212.g0c601
