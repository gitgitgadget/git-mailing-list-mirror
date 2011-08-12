From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 24/56] merge-recursive: Fix code checking for D/F conflicts still being present
Date: Thu, 11 Aug 2011 23:19:57 -0600
Message-ID: <1313126429-17368-25-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDA-0005ix-0K
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab1HLFW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:59 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab1HLFVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:23 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=78v6QEw3hLU7oPJMaWXp4mNgryctI3gVh1bQumg3eBs=;
        b=tc8PMtt9Tz0906ueomWJTpUYofpePSfnGPPzTA0+ZVaGK9CGRAoWPu2cq5NdaCZEgq
         wnFAV4h70RwUQQh82SXmRJxTuYV/nZAXBYoj5dy04902JIBaxll2EsmYF2oQDcUbeiZh
         oGK7nQEoIN2zJE0YjY4Uw+NO3hmlzhWsEHPP0=
Received: by 10.231.6.40 with SMTP id 40mr1047421ibx.80.1313126482502;
        Thu, 11 Aug 2011 22:21:22 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.20
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179212>

Previously, we were using lstat() to determine if a directory was still
present after a merge (and thus in the way of adding a file).  We should
have been using lstat() only to determine if untracked directories were in
the way (and then only when necessary to check for untracked directories);
we should instead using the index to determine if there is a tracked
directory in the way.  Create a new function to do this and use it to
replace the existing checks for directories being in the way.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   49 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 76b895f..9aacf5e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -593,6 +593,30 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
 	}
 }
 
+static int dir_in_way(const char *path, int check_working_copy)
+{
+	int pos, pathlen = strlen(path);
+	char *dirpath = xmalloc(pathlen + 2);
+	struct stat st;
+
+	strcpy(dirpath, path);
+	dirpath[pathlen] = '/';
+	dirpath[pathlen+1] = '\0';
+
+	pos = cache_name_pos(dirpath, pathlen+1);
+
+	if (pos < 0)
+		pos = -1 - pos;
+	if (pos < active_nr &&
+	    !strncmp(dirpath, active_cache[pos]->name, pathlen+1)) {
+		free(dirpath);
+		return 1;
+	}
+
+	free(dirpath);
+	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode);
+}
+
 static int would_lose_untracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
@@ -882,7 +906,6 @@ static void conflict_rename_delete(struct merge_options *o,
 {
 	char *dest_name = pair->two->path;
 	int df_conflict = 0;
-	struct stat st;
 
 	output(o, 1, "CONFLICT (rename/delete): Rename %s->%s in %s "
 	       "and deleted in %s",
@@ -892,7 +915,7 @@ static void conflict_rename_delete(struct merge_options *o,
 		update_stages(dest_name, NULL,
 			      rename_branch == o->branch1 ? pair->two : NULL,
 			      rename_branch == o->branch1 ? NULL : pair->two);
-	if (lstat(dest_name, &st) == 0 && S_ISDIR(st.st_mode)) {
+	if (dir_in_way(dest_name, !o->call_depth)) {
 		dest_name = unique_path(o, dest_name, rename_branch);
 		df_conflict = 1;
 	}
@@ -914,13 +937,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	const char *ren2_dst = pair2->two->path;
 	const char *dst_name1 = ren1_dst;
 	const char *dst_name2 = ren2_dst;
-	struct stat st;
-	if (lstat(ren1_dst, &st) == 0 && S_ISDIR(st.st_mode)) {
+	if (dir_in_way(ren1_dst, !o->call_depth)) {
 		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
 	}
-	if (lstat(ren2_dst, &st) == 0 && S_ISDIR(st.st_mode)) {
+	if (dir_in_way(ren2_dst, !o->call_depth)) {
 		dst_name2 = del[delp++] = unique_path(o, ren2_dst, branch2);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
@@ -1080,7 +1102,7 @@ static int process_renames(struct merge_options *o,
 			try_merge = 0;
 
 			if (sha_eq(src_other.sha1, null_sha1)) {
-				if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
+				if (dir_in_way(ren1_dst, 0 /*check_wc*/)) {
 					ren1->dst_entry->processed = 0;
 					setup_rename_df_conflict_info(RENAME_DELETE,
 								      ren1->pair,
@@ -1159,7 +1181,7 @@ static int process_renames(struct merge_options *o,
 					a = &src_other;
 				}
 				update_stages_and_entry(ren1_dst, ren1->dst_entry, one, a, b, 1);
-				if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
+				if (dir_in_way(ren1_dst, 0 /*check_wc*/)) {
 					setup_rename_df_conflict_info(RENAME_NORMAL,
 								      ren1->pair,
 								      NULL,
@@ -1264,7 +1286,6 @@ static int merge_content(struct merge_options *o,
 	const char *reason = "content";
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
-	struct stat st;
 	unsigned df_conflict_remains = 0;
 
 	if (!o_sha) {
@@ -1281,7 +1302,7 @@ static int merge_content(struct merge_options *o,
 
 	mfi = merge_file(o, &one, &a, &b, o->branch1, o->branch2);
 	if (df_rename_conflict_branch &&
-	    lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+	    dir_in_way(path, !o->call_depth)) {
 		df_conflict_remains = 1;
 	}
 
@@ -1346,8 +1367,7 @@ static int process_entry(struct merge_options *o,
 				output(o, 2, "Removing %s", path);
 			/* do not touch working file if it did not exist */
 			remove_file(o, 1, path, !a_sha);
-		} else if (string_list_has_string(&o->current_directory_set,
-						  path)) {
+		} else if (dir_in_way(path, 0 /*check_wc*/)) {
 			entry->processed = 0;
 			return 1; /* Assume clean until processed */
 		} else {
@@ -1370,7 +1390,7 @@ static int process_entry(struct merge_options *o,
 			mode = b_mode;
 			sha = b_sha;
 		}
-		if (string_list_has_string(&o->current_directory_set, path)) {
+		if (dir_in_way(path, 0 /*check_wc*/)) {
 			/* Handle D->F conflicts after all subfiles */
 			entry->processed = 0;
 			return 1; /* Assume clean until processed */
@@ -1418,7 +1438,6 @@ static int process_df_entry(struct merge_options *o,
 	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
 	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
 	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
-	struct stat st;
 
 	entry->processed = 1;
 	if (entry->rename_df_conflict_info) {
@@ -1463,7 +1482,7 @@ static int process_df_entry(struct merge_options *o,
 	} else if (o_sha && (!a_sha || !b_sha)) {
 		/* Modify/delete; deleted side may have put a directory in the way */
 		char *renamed = NULL;
-		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+		if (dir_in_way(path, !o->call_depth)) {
 			renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 		}
 		clean_merge = 0;
@@ -1491,7 +1510,7 @@ static int process_df_entry(struct merge_options *o,
 			sha = b_sha;
 			conf = "directory/file";
 		}
-		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+		if (dir_in_way(path, !o->call_depth)) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
-- 
1.7.6.100.gac5c1
