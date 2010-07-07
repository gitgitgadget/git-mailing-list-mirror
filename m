From: newren@gmail.com
Subject: [PATCHv3 3/6] merge-recursive: Fix D/F conflicts
Date: Tue,  6 Jul 2010 23:20:31 -0600
Message-ID: <1278480034-22939-4-git-send-email-newren@gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 07:13:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMwd-0002Ar-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab0GGFNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:13:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47654 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0GGFNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:13:06 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so3440291gxk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SPhwRObgEVORhVyJoTOgwTN42iw7VW1dvInfbN91mfM=;
        b=LLtapU+vtJLQZt9Ij21LIC2EzXKYvtNpVUvnj7wH+QprBoA9BpbYqNlOFxPmfD0+9J
         eSzXtL/XJXyf3nqT8Hw/1hi0L6IA8LVsZSTszd9sZzlZueYQxxpIF/iIOJY8jREl6ytt
         OtF1vgIRdfStX8vkryzYa5JPYmSMKqtGthPkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZAhR0AUiEM5QYMdUoezS0AtEpK5D8PlEWd789pfHuBdEqNFi/jCqo8N+gt8Psw2jje
         OOjRrVBRhFEE+84GKXlV1v+ibSlwiwoT3bMyA/DaMjeKBIe5bfkMMc6OK9mb364N4URT
         B3FPfovzMNbWEvb2C7LYzDrqCBZlWqEokeYxw=
Received: by 10.101.145.40 with SMTP id x40mr1446665ann.261.1278479586151;
        Tue, 06 Jul 2010 22:13:06 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id h5sm60464675anb.28.2010.07.06.22.13.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:13:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.10.g6dbc5
In-Reply-To: <1278480034-22939-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150441>

From: Elijah Newren <newren@gmail.com>

The D/F conflicts that can be automatically resolved (file or directory
unmodified on one side of history), have the nice property that
process_entry() can correctly handle all subpaths of the D/F conflict.  In
the case of D->F conversions, it will correctly delete all non-conflicting
files below the relevant directory and the directory itself (note that both
untracked and conflicting files below the directory will prevent its
removal).  So if we handle D/F conflicts after all other conflicts, they
become fairly simple to handle -- we just need to check for whether or not
a path (file/directory) is in the way of creating the new content.  We do
this by having process_entry() defer handling such entries to a subsequent
process_df_entry() step.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c               |   93 ++++++++++++++++++++++++++++++++-------
 t/t6035-merge-dir-to-symlink.sh |    8 ++--
 2 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..865729a 100644
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
index 3c176d7..384547d 100755
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
1.7.1.1.10.g2e807
