From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 24/48] merge-recursive: Save D/F conflict filenames instead of unlinking them
Date: Wed,  8 Jun 2011 01:30:54 -0600
Message-ID: <1307518278-23814-25-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDN-0005pC-3j
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab1FHH3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab1FHH3o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:44 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ojgb6jdopCfWIQxscwbLJnCfk5PXAD/9oO1Hj/MeoeE=;
        b=gbDleGmhZq1QpP8TPHn/hAdJu2LqeO2YGOUuipyqQNoeiG8cTxz/i81Y5mwwWszTBc
         rpbxD3O9T2KGHpSSl/X2JK79dnThIp+ZUdDs863KWje4AYvadddgfaC0F7mEuKhtLCTh
         fREucaPOrpvz2LOZnaylX8HGiPgQapN7ACbFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gKdQ86NLsTOBj0hmpPc3v1KUSZkQjL3OEMCrHHfRCrgHtBTiv+jLY5THd84kZqD5bW
         Skd0AVRShVKME/6RKcDs6PX+fAD52xS9o3R04UV0UvKaJ8tMT/O6WzPyE2vR4tfM8SnT
         G9VlsRKqGP2PCiUsionZKdKThHUhd6D6QsKBQ=
Received: by 10.68.12.73 with SMTP id w9mr592963pbb.318.1307518184044;
        Wed, 08 Jun 2011 00:29:44 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.42
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175303>

Rename make_room_for_directories_of_df_conflicts() to
record_df_conflict_files() to reflect the change in functionality.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   40 ++++++++++++++++++++++++----------------
 merge-recursive.h |    1 +
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3a8e64e..e59eec0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -353,20 +353,24 @@ static int string_list_df_name_compare(const void *a, const void *b)
 			       two->string, strlen(two->string), S_IFDIR);
 }
 
-
-
-static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
-						      struct string_list *entries)
+static void record_df_conflict_files(struct merge_options *o,
+				     struct string_list *entries)
 {
-	/* If there are D/F conflicts, and the paths currently exist
-	 * in the working copy as a file, we want to remove them to
-	 * make room for the corresponding directory.  Such paths will
-	 * later be processed in process_df_entry() at the end.  If
-	 * the corresponding directory ends up being removed by the
-	 * merge, then the file will be reinstated at that time;
-	 * otherwise, if the file is not supposed to be removed by the
-	 * merge, the contents of the file will be placed in another
-	 * unique filename.
+	/* If there is a D/F conflict and the file for such a conflict
+	 * currently exist in the working copy, we want to allow it to
+	 * be removed to make room for the corresponding directory if
+	 * needed.  The files underneath the directories of such D/F
+	 * conflicts will be handled in process_entry(), while the
+	 * files of such D/F conflicts will be processed later in
+	 * process_df_entry().  If the corresponding directory ends up
+	 * being removed by the merge, then no additional work needs
+	 * to be done by process_df_entry() for the conflicting file.
+	 * If the directory needs to be written to the working copy,
+	 * then the conflicting file will simply be removed (e.g. in
+	 * make_room_for_path).  If the directory is written to the
+	 * working copy but the file also has a conflict that needs to
+	 * be resolved, then process_df_entry() will reinstate the
+	 * file with a new unique name.
 	 */
 	const char *last_file = NULL;
 	int last_len = 0;
@@ -383,6 +387,7 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	qsort(entries->items, entries->nr, sizeof(*entries->items),
 	      string_list_df_name_compare);
 
+	string_list_clear(&o->df_conflict_file_set, 1);
 	for (i = 0; i < entries->nr; i++) {
 		const char *path = entries->items[i].string;
 		int len = strlen(path);
@@ -391,14 +396,15 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 		/*
 		 * Check if last_file & path correspond to a D/F conflict;
 		 * i.e. whether path is last_file+'/'+<something>.
-		 * If so, remove last_file to make room for path and friends.
+		 * If so, record that it's okay to remove last_file to make
+		 * room for path and friends if needed.
 		 */
 		if (last_file &&
 		    len > last_len &&
 		    memcmp(path, last_file, last_len) == 0 &&
 		    path[last_len] == '/') {
 			output(o, 3, "Removing %s to make room for subdirectory; may re-add later.", last_file);
-			unlink(last_file);
+			string_list_insert(&o->df_conflict_file_set, last_file);
 		}
 
 		/*
@@ -1574,7 +1580,7 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		make_room_for_directories_of_df_conflicts(o, entries);
+		record_df_conflict_files(o, entries);
 		re_head  = get_renames(o, head, common, head, merge, entries);
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
@@ -1800,6 +1806,8 @@ void init_merge_options(struct merge_options *o)
 	o->current_file_set.strdup_strings = 1;
 	memset(&o->current_directory_set, 0, sizeof(struct string_list));
 	o->current_directory_set.strdup_strings = 1;
+	memset(&o->df_conflict_file_set, 0, sizeof(struct string_list));
+	o->df_conflict_file_set.strdup_strings = 1;
 }
 
 int parse_merge_opt(struct merge_options *o, const char *s)
diff --git a/merge-recursive.h b/merge-recursive.h
index 7e1e972..58f3435 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -26,6 +26,7 @@ struct merge_options {
 	struct strbuf obuf;
 	struct string_list current_file_set;
 	struct string_list current_directory_set;
+	struct string_list df_conflict_file_set;
 };
 
 /* merge_trees() but with recursive ancestor consolidation */
-- 
1.7.6.rc0.62.g2d69f
