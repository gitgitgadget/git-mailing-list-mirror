From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 34/48] merge-recursive: Consolidate process_entry() and process_df_entry()
Date: Wed,  8 Jun 2011 01:31:04 -0600
Message-ID: <1307518278-23814-35-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEh-0006q0-AU
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab1FHHaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:08 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHHaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:04 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xeEQFmNzxm00FOL5MXR3TizWKCSbm6qPdk3WJ673daE=;
        b=uFha2H0IBrq9K1koUOazkR2GOlWCuNYY/ooNUMJNBpVuTnARenrYnqGjs5/lMRa7g3
         CHi7WvHc8/s1OIaCfWhuJf5OhD9GnIKIVajrsWhakLPqKUz2iEx3KUNqw3BQPCpyqVVK
         ZIR1KdMxnR7mwKzjtpU/9XqAC7+fwqJlsoSlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z6xaD3wbEEK+7Gf5NHoy44G3vAcbNLTb2QXD35b6OHKHZ2mzE+fKJnXIQu4p4jWryM
         l6cBMuiJh25PYP+zZJsGZBW+FeoAOr6wEgZE1XkXKVXZJU2oaeVHauTa+5uU+E50h6Ep
         ql6rbDMq13CwUE8bqnHgz9I/EMzhj0MuPwS7I=
Received: by 10.68.6.5 with SMTP id w5mr688477pbw.15.1307518204717;
        Wed, 08 Jun 2011 00:30:04 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.02
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175317>

The whole point of adding process_df_entry() was to ensure that files of
D/F conflicts were processed after paths under the corresponding
directory.  However, given that the entries are in sorted order, all we
need to do is iterate through them in reverse order to achieve the same
effect.  That lets us remove some duplicated code, and lets us keep
track of one less thing as we read the code ("do we need to make sure
this is processed before process_df_entry() or do we need to defer it
until then?").

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |  194 ++++++++++++++++------------------------------------
 1 files changed, 60 insertions(+), 134 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e6a97b2..5673ccb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -116,7 +116,6 @@ static inline void setup_rename_df_conflict_info(enum rename_type rename_type,
 		ci->dst_entry2 = dst_entry2;
 		ci->pair2 = pair2;
 		dst_entry2->rename_df_conflict_info = ci;
-		dst_entry2->processed = 0;
 	}
 }
 
@@ -358,20 +357,17 @@ static void record_df_conflict_files(struct merge_options *o,
 				     struct string_list *entries)
 {
 	/* If there is a D/F conflict and the file for such a conflict
-	 * currently exist in the working copy, we want to allow it to
-	 * be removed to make room for the corresponding directory if
-	 * needed.  The files underneath the directories of such D/F
-	 * conflicts will be handled in process_entry(), while the
-	 * files of such D/F conflicts will be processed later in
-	 * process_df_entry().  If the corresponding directory ends up
-	 * being removed by the merge, then no additional work needs
-	 * to be done by process_df_entry() for the conflicting file.
-	 * If the directory needs to be written to the working copy,
-	 * then the conflicting file will simply be removed (e.g. in
-	 * make_room_for_path).  If the directory is written to the
-	 * working copy but the file also has a conflict that needs to
-	 * be resolved, then process_df_entry() will reinstate the
-	 * file with a new unique name.
+	 * currently exist in the working copy, we want to allow it to be
+	 * removed to make room for the corresponding directory if needed.
+	 * The files underneath the directories of such D/F conflicts will
+	 * be processed before the corresponding file involved in the D/F
+	 * conflict.  If the D/F directory ends up being removed by the
+	 * merge, then we won't have to touch the D/F file.  If the D/F
+	 * directory needs to be written to the working copy, then the D/F
+	 * file will simply be removed (in make_room_for_path()) to make
+	 * room for the necessary paths.  Note that if both the directory
+	 * and the file need to be present, then the D/F file will be
+	 * reinstated with a new unique name at the time it is processed.
 	 */
 	const char *last_file = NULL;
 	int last_len = 0;
@@ -1310,17 +1306,17 @@ static void handle_delete_modify(struct merge_options *o,
 		       "and modified in %s. Version %s of %s left in tree%s%s.",
 		       path, o->branch1,
 		       o->branch2, o->branch2, path,
-		       path == new_path ? "" : " at ",
-		       path == new_path ? "" : new_path);
-		update_file(o, 0, b_sha, b_mode, new_path);
+		       NULL == new_path ? "" : " at ",
+		       NULL == new_path ? "" : new_path);
+		update_file(o, 0, b_sha, b_mode, new_path ? new_path : path);
 	} else {
 		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
 		       "and modified in %s. Version %s of %s left in tree%s%s.",
 		       path, o->branch2,
 		       o->branch1, o->branch1, path,
-		       path == new_path ? "" : " at ",
-		       path == new_path ? "" : new_path);
-		update_file(o, 0, a_sha, a_mode, new_path);
+		       NULL == new_path ? "" : " at ",
+		       NULL == new_path ? "" : new_path);
+		update_file(o, 0, a_sha, a_mode, new_path ? new_path : path);
 	}
 }
 
@@ -1422,93 +1418,6 @@ static int process_entry(struct merge_options *o,
 	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
 	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
 
-	if (entry->rename_df_conflict_info)
-		return 1; /* Such cases are handled elsewhere. */
-
-	entry->processed = 1;
-	if (o_sha && (!a_sha || !b_sha)) {
-		/* Case A: Deleted in one */
-		if ((!a_sha && !b_sha) ||
-		    (!b_sha && blob_unchanged(o_sha, a_sha, normalize, path)) ||
-		    (!a_sha && blob_unchanged(o_sha, b_sha, normalize, path))) {
-			/* Deleted in both or deleted in one and
-			 * unchanged in the other */
-			if (a_sha)
-				output(o, 2, "Removing %s", path);
-			/* do not touch working file if it did not exist */
-			remove_file(o, 1, path, !a_sha);
-		} else if (dir_in_way(path, 0 /*check_wc*/)) {
-			entry->processed = 0;
-			return 1; /* Assume clean until processed */
-		} else {
-			/* Deleted in one and changed in the other */
-			clean_merge = 0;
-			handle_delete_modify(o, path, path,
-					     a_sha, a_mode, b_sha, b_mode);
-		}
-
-	} else if ((!o_sha && a_sha && !b_sha) ||
-		   (!o_sha && !a_sha && b_sha)) {
-		/* Case B: Added in one. */
-		unsigned mode;
-		const unsigned char *sha;
-
-		if (a_sha) {
-			mode = a_mode;
-			sha = a_sha;
-		} else {
-			mode = b_mode;
-			sha = b_sha;
-		}
-		if (dir_in_way(path, 0 /*check_wc*/)) {
-			/* Handle D->F conflicts after all subfiles */
-			entry->processed = 0;
-			return 1; /* Assume clean until processed */
-		} else {
-			output(o, 2, "Adding %s", path);
-			update_file(o, 1, sha, mode, path);
-		}
-	} else if (a_sha && b_sha) {
-		/* Case C: Added in both (check for same permissions) and */
-		/* case D: Modified in both, but differently. */
-		clean_merge = merge_content(o, entry->involved_in_rename, path,
-					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
-					    NULL);
-	} else if (!o_sha && !a_sha && !b_sha) {
-		/*
-		 * this entry was deleted altogether. a_mode == 0 means
-		 * we had that path and want to actively remove it.
-		 */
-		remove_file(o, 1, path, !a_mode);
-	} else
-		die("Fatal merge failure, shouldn't happen.");
-
-	return clean_merge;
-}
-
-/*
- * Per entry merge function for D/F (and/or rename) conflicts.  In the
- * cases we can cleanly resolve D/F conflicts, process_entry() can
- * clean out all the files below the directory for us.  All D/F
- * conflict cases must be handled here at the end to make sure any
- * directories that can be cleaned out, are.
- *
- * Some rename conflicts may also be handled here that don't necessarily
- * involve D/F conflicts, since the code to handle them is generic enough
- * to handle those rename conflicts with or without D/F conflicts also
- * being involved.
- */
-static int process_df_entry(struct merge_options *o,
-			    const char *path, struct stage_data *entry)
-{
-	int clean_merge = 1;
-	unsigned o_mode = entry->stages[1].mode;
-	unsigned a_mode = entry->stages[2].mode;
-	unsigned b_mode = entry->stages[3].mode;
-	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
-	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
-	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
-
 	entry->processed = 1;
 	if (entry->rename_df_conflict_info) {
 		struct rename_df_conflict_info *conflict_info = entry->rename_df_conflict_info;
@@ -1543,27 +1452,41 @@ static int process_df_entry(struct merge_options *o,
 						    conflict_info->branch1,
 						    conflict_info->pair2,
 						    conflict_info->branch2);
-			conflict_info->dst_entry2->processed = 1;
 			break;
 		default:
 			entry->processed = 0;
 			break;
 		}
 	} else if (o_sha && (!a_sha || !b_sha)) {
-		/* Modify/delete; deleted side may have put a directory in the way */
-		char *new_path;
-		int free_me = 0;
-		if (dir_in_way(path, !o->call_depth)) {
-			new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
-			free_me = 1;
+		/* Case A: Deleted in one */
+		if ((!a_sha && !b_sha) ||
+		    (!b_sha && blob_unchanged(o_sha, a_sha, normalize, path)) ||
+		    (!a_sha && blob_unchanged(o_sha, b_sha, normalize, path))) {
+			/* Deleted in both or deleted in one and
+			 * unchanged in the other */
+			if (a_sha)
+				output(o, 2, "Removing %s", path);
+			/* do not touch working file if it did not exist */
+			remove_file(o, 1, path, !a_sha);
+		} else {
+			/* Modify/delete; deleted side may have put a directory in the way */
+			char *new_path = NULL;
+			int free_me = 0;
+			clean_merge = 0;
+			if (dir_in_way(path, !o->call_depth)) {
+				new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+				free_me = 1;
+			}
+			handle_delete_modify(o, path, new_path,
+					     a_sha, a_mode, b_sha, b_mode);
+			if (free_me)
+				free(new_path);
 		}
-		clean_merge = 0;
-		handle_delete_modify(o, path, free_me ? new_path : path,
-				     a_sha, a_mode, b_sha, b_mode);
-		if (free_me)
-			free(new_path);
-	} else if (!o_sha && !!a_sha != !!b_sha) {
-		/* directory -> (directory, file) or <nothing> -> (directory, file) */
+	} else if ((!o_sha && a_sha && !b_sha) ||
+		   (!o_sha && !a_sha && b_sha)) {
+		/* Case B: Added in one. */
+		/* [nothing|directory] -> ([nothing|directory], file) */
+
 		const char *add_branch;
 		const char *other_branch;
 		unsigned mode;
@@ -1599,10 +1522,20 @@ static int process_df_entry(struct merge_options *o,
 			output(o, 2, "Adding %s", path);
 			update_file(o, 1, sha, mode, path);
 		}
-	} else {
-		entry->processed = 0;
-		return 1; /* not handled; assume clean until processed */
-	}
+	} else if (a_sha && b_sha) {
+		/* Case C: Added in both (check for same permissions) and */
+		/* case D: Modified in both, but differently. */
+		clean_merge = merge_content(o, entry->involved_in_rename, path,
+					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
+					    NULL);
+	} else if (!o_sha && !a_sha && !b_sha) {
+		/*
+		 * this entry was deleted altogether. a_mode == 0 means
+		 * we had that path and want to actively remove it.
+		 */
+		remove_file(o, 1, path, !a_mode);
+	} else
+		die("Fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
@@ -1650,7 +1583,7 @@ int merge_trees(struct merge_options *o,
 		re_head  = get_renames(o, head, common, head, merge, entries);
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
-		for (i = 0; i < entries->nr; i++) {
+		for (i = entries->nr-1; i >=0; i--) {
 			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed
@@ -1658,13 +1591,6 @@ int merge_trees(struct merge_options *o,
 				clean = 0;
 		}
 		for (i = 0; i < entries->nr; i++) {
-			const char *path = entries->items[i].string;
-			struct stage_data *e = entries->items[i].util;
-			if (!e->processed
-				&& !process_df_entry(o, path, e))
-				clean = 0;
-		}
-		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
 				die("Unprocessed path??? %s",
-- 
1.7.6.rc0.62.g2d69f
