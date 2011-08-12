From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 25/56] merge-recursive: Save D/F conflict filenames instead of unlinking them
Date: Thu, 11 Aug 2011 23:19:58 -0600
Message-ID: <1313126429-17368-26-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBn-00051N-Qm
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab1HLFV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:28 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1HLFVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:24 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mKUMQZfkBY7xG4WtbOcnHo8J45B6AUSeQ5jZlwnft6Y=;
        b=xS4caTyDTtKhHALhxbpjrGA9XCUHFmC6CIl10XemRYbTtU3UHvw8gjKTEhzl/0oqWb
         ECwB3JenFyyJBxVxA84bRvUxkKZWArKKC6+efNwFpd8swhxgzXoO8eIPeaRgqLWM1YC2
         szHr8Ac/VA7UCqK56F3EALfIo9+cLb9SWk98k=
Received: by 10.42.140.200 with SMTP id l8mr512800icu.371.1313126484364;
        Thu, 11 Aug 2011 22:21:24 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.22
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179183>

Rename make_room_for_directories_of_df_conflicts() to
record_df_conflict_files() to reflect the change in functionality.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   40 ++++++++++++++++++++++++----------------
 merge-recursive.h |    1 +
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9aacf5e..e1723d4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -362,20 +362,24 @@ static int string_list_df_name_compare(const void *a, const void *b)
 	return onelen - twolen;
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
@@ -392,6 +396,7 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	qsort(entries->items, entries->nr, sizeof(*entries->items),
 	      string_list_df_name_compare);
 
+	string_list_clear(&o->df_conflict_file_set, 1);
 	for (i = 0; i < entries->nr; i++) {
 		const char *path = entries->items[i].string;
 		int len = strlen(path);
@@ -400,14 +405,15 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
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
@@ -1571,7 +1577,7 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		make_room_for_directories_of_df_conflicts(o, entries);
+		record_df_conflict_files(o, entries);
 		re_head  = get_renames(o, head, common, head, merge, entries);
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
@@ -1797,6 +1803,8 @@ void init_merge_options(struct merge_options *o)
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
1.7.6.100.gac5c1
