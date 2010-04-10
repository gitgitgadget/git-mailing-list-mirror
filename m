From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 6/9] Add a mode parameter to the remove_path function
Date: Sat, 10 Apr 2010 19:23:47 +0100
Message-ID: <1270923830-11830-7-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMP-0007O3-3z
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0DJSYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:18 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37800 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab0DJSX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:58 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLV-0006qT-RP; Sat, 10 Apr 2010 19:23:54 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-00036N-Iw; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144564>

This patch adds a mode parameter to remove_path which determines
whether unlink or rmdir is used.  All calls to remove_path have
been modified to supply the mode parameter.

This patch also adds a test case for a bug fixed by the addition
of the mode parameter to remove_path.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 builtin/apply.c            |    2 +-
 builtin/rm.c               |    3 ++-
 dir.c                      |    4 ++--
 dir.h                      |    2 +-
 merge-recursive.c          |   27 ++++++++++++++++-----------
 t/t7405-submodule-merge.sh |   13 +++++++++++++
 6 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d56cabf..2f50a53 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3139,7 +3139,7 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 	}
 	if (!cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
-			remove_path(patch->old_name);
+			remove_path(patch->old_mode, patch->old_name);
 		}
 	}
 }
diff --git a/builtin/rm.c b/builtin/rm.c
index 61ec2cf..6ac5114 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -256,7 +256,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.name[i];
-			if (!remove_path(path)) {
+			unsigned int mode = list.mode[i];
+			if (!remove_path(mode, path)) {
 				removed = 1;
 				continue;
 			}
diff --git a/dir.c b/dir.c
index cb83332..2d9cd9a 100644
--- a/dir.c
+++ b/dir.c
@@ -1047,11 +1047,11 @@ void setup_standard_excludes(struct dir_struct *dir)
 		add_excludes_from_file(dir, excludes_file);
 }
 
-int remove_path(const char *name)
+int remove_path(unsigned int mode, const char *name)
 {
 	char *slash;
 
-	if (unlink(name) && errno != ENOENT)
+	if ((S_ISGITLINK(mode) ? rmdir(name) : unlink(name)) && errno != ENOENT)
 		return -1;
 
 	slash = strrchr(name, '/');
diff --git a/dir.h b/dir.h
index 3bead5f..0e48d2a 100644
--- a/dir.h
+++ b/dir.h
@@ -98,6 +98,6 @@ extern void setup_standard_excludes(struct dir_struct *dir);
 extern int remove_dir_recursively(struct strbuf *path, int flag);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
-extern int remove_path(const char *path);
+extern int remove_path(unsigned int mode, const char *path);
 
 #endif
diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..f4ac8c9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -399,7 +399,7 @@ static int update_stages(const char *path, struct diff_filespec *o,
 }
 
 static int remove_file(struct merge_options *o, int clean,
-		       const char *path, int no_wd)
+		       unsigned int mode, const char *path, int no_wd)
 {
 	int update_cache = o->call_depth || clean;
 	int update_working_directory = !o->call_depth && !no_wd;
@@ -409,7 +409,7 @@ static int remove_file(struct merge_options *o, int clean,
 			return -1;
 	}
 	if (update_working_directory) {
-		if (remove_path(path))
+		if (remove_path(mode, path))
 			return -1;
 	}
 	return 0;
@@ -739,6 +739,8 @@ static void conflict_rename_rename(struct merge_options *o,
 {
 	char *del[2];
 	int delp = 0;
+	unsigned int ren1_mode = ren1->pair->two->mode;
+	unsigned int ren2_mode = ren2->pair->two->mode;
 	const char *ren1_dst = ren1->pair->two->path;
 	const char *ren2_dst = ren2->pair->two->path;
 	const char *dst_name1 = ren1_dst;
@@ -747,13 +749,13 @@ static void conflict_rename_rename(struct merge_options *o,
 		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
-		remove_file(o, 0, ren1_dst, 0);
+		remove_file(o, 0, ren1_mode, ren1_dst, 0);
 	}
 	if (string_list_has_string(&o->current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(o, ren2_dst, branch2);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
-		remove_file(o, 0, ren2_dst, 0);
+		remove_file(o, 0, ren2_mode, ren2_dst, 0);
 	}
 	if (o->call_depth) {
 		remove_file_from_cache(dst_name1);
@@ -778,7 +780,7 @@ static void conflict_rename_dir(struct merge_options *o,
 {
 	char *new_path = unique_path(o, ren1->pair->two->path, branch1);
 	output(o, 1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
-	remove_file(o, 0, ren1->pair->two->path, 0);
+	remove_file(o, 0, ren1->pair->two->mode, ren1->pair->two->path, 0);
 	update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
 	free(new_path);
 }
@@ -794,7 +796,7 @@ static void conflict_rename_rename_2(struct merge_options *o,
 	output(o, 1, "Renaming %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
-	remove_file(o, 0, ren1->pair->two->path, 0);
+	remove_file(o, 0, ren1->pair->two->mode, ren1->pair->two->path, 0);
 	update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path1);
 	update_file(o, 0, ren2->pair->two->sha1, ren2->pair->two->mode, new_path2);
 	free(new_path2);
@@ -826,6 +828,7 @@ static int process_renames(struct merge_options *o,
 		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branch1, *branch2;
 		const char *ren1_src, *ren1_dst;
+		unsigned int ren1_srcmode;
 
 		if (i >= a_renames->nr) {
 			ren2 = b_renames->items[j++].util;
@@ -868,6 +871,8 @@ static int process_renames(struct merge_options *o,
 		ren1_src = ren1->pair->one->path;
 		ren1_dst = ren1->pair->two->path;
 
+		ren1_srcmode = ren1->pair->one->mode;
+
 		if (ren2) {
 			const char *ren2_src = ren2->pair->one->path;
 			const char *ren2_dst = ren2->pair->two->path;
@@ -892,7 +897,7 @@ static int process_renames(struct merge_options *o,
 				conflict_rename_rename(o, ren1, branch1, ren2, branch2);
 			} else {
 				struct merge_file_info mfi;
-				remove_file(o, 1, ren1_src, 1);
+				remove_file(o, 1, ren1_srcmode, ren1_src, 1);
 				mfi = merge_file(o,
 						 ren1->pair->one,
 						 ren1->pair->two,
@@ -926,7 +931,7 @@ static int process_renames(struct merge_options *o,
 			struct diff_filespec src_other, dst_other;
 			int try_merge, stage = a_renames == renames1 ? 3: 2;
 
-			remove_file(o, 1, ren1_src, o->call_depth || stage == 3);
+			remove_file(o, 1, ren1_srcmode, ren1_src, o->call_depth || stage == 3);
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[stage].sha);
 			src_other.mode = ren1->src_entry->stages[stage].mode;
@@ -1082,7 +1087,7 @@ static int process_entry(struct merge_options *o,
 			if (a_sha)
 				output(o, 2, "Removing %s", path);
 			/* do not touch working file if it did not exist */
-			remove_file(o, 1, path, !a_sha);
+			remove_file(o, 1, a_mode, path, !a_sha);
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
@@ -1129,7 +1134,7 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
-			remove_file(o, 0, path, 0);
+			remove_file(o, 0, mode, path, 0);
 			update_file(o, 0, sha, mode, new_path);
 		} else {
 			output(o, 2, "Adding %s", path);
@@ -1171,7 +1176,7 @@ static int process_entry(struct merge_options *o,
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
 		 */
-		remove_file(o, 1, path, !a_mode);
+		remove_file(o, 1, a_mode, path, !a_mode);
 	} else
 		die("Fatal merge failure, shouldn't happen.");
 
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 9a21f78..d87ed9e 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -71,4 +71,17 @@ test_expect_success 'merging with a modify/modify conflict between merge bases'
 
 '
 
+test_expect_success 'merging a submodule deletion' '
+
+	git reset --hard HEAD &&
+	git checkout -b test3 a &&
+	rm -rf sub &&
+	git update-index --remove sub &&
+	git commit -m empty &&
+	git checkout -b test4 c &&
+	test -d sub &&
+	git merge test3 &&
+	test \! -d sub
+'
+
 test_done
-- 
1.6.5
