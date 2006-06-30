From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH 3/4] use detachable filepairs and an attempt to cleanup
Date: Fri, 30 Jun 2006 02:27:50 +0200
Message-ID: <20060630002750.GC22618@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 30 02:28:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6rk-0002GV-UE
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWF3A2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWF3A2I
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:28:08 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:46994 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964811AbWF3A2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 20:28:06 -0400
Received: from fwd34.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1Fw6rY-0001d5-00; Fri, 30 Jun 2006 02:28:00 +0200
Received: from tigra.home (Z6ouJkZA8e4Nw3k1JKmv+ny+L9Lk32QY-SiGe2ntw5nnnP85gxSdQx@[84.160.88.232]) by fwd34.sul.t-online.de
	with esmtp id 1Fw6rO-1rmxpA0; Fri, 30 Jun 2006 02:27:50 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 56681277B5;
	Fri, 30 Jun 2006 02:27:50 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fw6rO-0007gd-AJ; Fri, 30 Jun 2006 02:27:50 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-ID: Z6ouJkZA8e4Nw3k1JKmv+ny+L9Lk32QY-SiGe2ntw5nnnP85gxSdQx
X-TOI-MSGID: 59d16e57-f72c-42b7-862f-dd2d8de3ca3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22933>

---
 merge-recursive.c |  295 +++++++++++++++++++++++++++++------------------------
 1 files changed, 162 insertions(+), 133 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index abceb30..9a18e06 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -579,26 +579,17 @@ struct rename_entry
 {
 	struct rename_entry *next;
 
-	unsigned char src_sha[20];
-	unsigned src_mode;
+	struct diff_filepair *pair;
 	struct index_entry *src_entry;
-
-	unsigned char dst_sha[20];
-	unsigned dst_mode;
 	struct index_entry *dst_entry;
-
-	unsigned score:16,
-		 processed:1;
-
-	char *src; /* dst + strlen(dst) + 1 */
-	char dst[1];
+	unsigned processed:1;
 };
 
 static struct rename_entry *find_rename_bysrc(struct rename_entry *e,
 					      const char *name)
 {
 	while ( e ) {
-		if ( strcmp(e->src, name) == 0 )
+		if ( strcmp(e->pair->one->path, name) == 0 )
 			break;
 		e = e->next;
 	}
@@ -609,7 +600,7 @@ static struct rename_entry *find_rename_
 					      const char *name)
 {
 	while ( e ) {
-		if ( strcmp(e->dst, name) == 0 )
+		if ( strcmp(e->pair->two->path, name) == 0 )
 			break;
 		e = e->next;
 	}
@@ -620,6 +611,7 @@ static void free_rename_entries(struct r
 {
 	while (*list) {
 		struct rename_entry *next = (*list)->next;
+		diff_free_filepair((*list)->pair);
 		free(*list);
 		*list = next;
 	}
@@ -656,29 +648,23 @@ static struct rename_entry *get_renames(
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
 		if (pair->status != 'R')
 			continue;
-		size_t l1 = strlen(pair->one->path);
-		size_t l2 = strlen(pair->two->path);
-		re = xmalloc(sizeof(*re) + l1 + l2 + 2);
-		re->src = re->dst + l2;
+		diff_queued_diff.queue[i] = NULL;
+		re = xmalloc(sizeof(*re));
 		re->next = NULL;
 		re->processed = 0;
-		re->score = pair->score;
-		memcpy(re->src_sha, pair->one->sha1, 20);
-		memcpy(re->src, pair->one->path, ++l1);
-		re->src_mode = pair->one->mode;
-		memcpy(re->dst_sha, pair->two->sha1, 20);
-		memcpy(re->dst, pair->two->path, ++l2);
-		re->dst_mode = pair->two->mode;
+		re->pair = pair;
 		// TODO: optimize index_entry_find
-		re->src_entry = index_entry_find(*entries, re->src);
+		re->src_entry = index_entry_find(*entries, re->pair->one->path);
 		if ( !re->src_entry ) {
-			re->src_entry = index_entry_from_db(re->src, oTree, aTree, bTree);
+			re->src_entry = index_entry_from_db(re->pair->one->path,
+							    oTree, aTree, bTree);
 			re->src_entry->next = *entries;
 			*entries = re->src_entry;
 		}
-		re->dst_entry = index_entry_find(*entries, re->dst);
+		re->dst_entry = index_entry_find(*entries, re->pair->two->path);
 		if ( !re->dst_entry ) {
-			re->dst_entry = index_entry_from_db(re->dst, oTree, aTree, bTree);
+			re->dst_entry = index_entry_from_db(re->pair->two->path,
+							    oTree, aTree, bTree);
 			re->dst_entry->next = *entries;
 			*entries = re->dst_entry;
 		}
@@ -688,7 +674,6 @@ static struct rename_entry *get_renames(
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_flush(&opts);
 	debug("  getRenames done in %ld\n", time(0)-t);
-	die("PROFILING");
 	return renames;
 }
 
@@ -979,12 +964,9 @@ static struct merge_file_info merge_file
 				NULL
 			};
 			char *la, *lb, *lo;
-			argv[2] = la = malloc(strlen(branch1Name) + 2 + strlen(aPath));
-			strcat(strcat(strcpy(la, branch1Name), "/"), aPath);
-			argv[6] = lb = malloc(strlen(branch2Name) + 2 + strlen(bPath));
-			strcat(strcat(strcpy(lb, branch2Name), "/"), bPath);
-			argv[4] = lo = malloc(7 + strlen(oPath));
-			strcat(strcpy(lo, "orig/"), oPath);
+			argv[2] = la = strdup(mkpath("%s/%s", branch1Name, aPath));
+			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, bPath));
+			argv[4] = lo = strdup(mkpath("orig/%s", oPath));
 
 #if 0
 			printf("%s %s %s %s %s %s %s %s %s %s\n",
@@ -1029,6 +1011,75 @@ #endif
 	return result;
 }
 
+static void conflict_rename_rename(FILE *up_index,
+				   struct rename_entry *ren1,
+				   const char *branch1,
+				   struct rename_entry *ren2,
+				   const char *branch2)
+{
+	char *del[2];
+	int delp = 0;
+	const char *ren1_dst = ren1->pair->two->path;
+	const char *ren2_dst = ren2->pair->two->path;
+	const char *dstName1 = ren1_dst;
+	const char *dstName2 = ren2_dst;
+	if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
+		dstName1 = del[delp++] = unique_path(ren1_dst, branch1);
+		output("%s is a directory in %s adding as %s instead",
+		       ren1_dst, branch2, dstName1);
+		remove_file(up_index, 0, ren1_dst);
+	}
+	if (path_list_has_path(&currentDirectorySet, ren2_dst)) {
+		dstName2 = del[delp++] = unique_path(ren2_dst, branch2);
+		output("%s is a directory in %s adding as %s instead",
+		       ren2_dst, branch1, dstName2);
+		remove_file(up_index, 0, ren2_dst);
+	}
+	update_stages(up_index, dstName1,
+		      NULL, 0,
+		      ren1->pair->two->sha1, ren1->pair->two->mode,
+		      NULL, 0,
+		      1 /* clear */);
+	update_stages(up_index, dstName2,
+		      NULL, 0,
+		      NULL, 0,
+		      ren2->pair->two->sha1, ren2->pair->two->mode,
+		      1 /* clear */);
+	while ( delp-- )
+		free(del[delp]);
+}
+
+static void conflict_rename_dir(FILE *up_index,
+				struct rename_entry *ren1,
+				const char *branch1)
+{
+	char *newPath = unique_path(ren1->pair->two->path, branch1);
+	output("Renaming %s to %s instead", ren1->pair->one->path, newPath);
+	remove_file(up_index, 0, ren1->pair->two->path);
+	update_file(up_index, 0, ren1->pair->two->sha1, ren1->pair->two->mode, newPath);
+	free(newPath);
+}
+
+static void conflict_rename_rename_2(FILE *up_index,
+				     struct rename_entry *ren1,
+				     const char *branch1,
+				     struct rename_entry *ren2,
+				     const char *branch2)
+{
+	char *newPath1 = unique_path(ren1->pair->two->path, branch1);
+	char *newPath2 = unique_path(ren2->pair->two->path, branch2);
+	output("Renaming %s to %s and %s to %s instead",
+	       ren1->pair->one->path, newPath1,
+	       ren2->pair->one->path, newPath2);
+	remove_file(up_index, 0, ren1->pair->two->path);
+	update_file(up_index, 0,
+		    ren1->pair->two->sha1, ren1->pair->two->mode, newPath1);
+	update_file(up_index, 0,
+		    ren2->pair->two->sha1, ren2->pair->two->mode, newPath2);
+	free(newPath2);
+	free(newPath1);
+}
+
 static int process_renames(struct rename_entry *renamesA,
 			   struct rename_entry *renamesB,
 			   const char *branchNameA,
@@ -1042,9 +1093,9 @@ static int process_renames(struct rename
 	char **src;
 
 	for (sre = renamesA; sre; sre = sre->next)
-		path_list_insert(sre->src, &srcNames);
+		path_list_insert(sre->pair->one->path, &srcNames);
 	for (sre = renamesB; sre; sre = sre->next)
-		path_list_insert(sre->src, &srcNames);
+		path_list_insert(sre->pair->one->path, &srcNames);
 
 	FILE *fp = git_update_index_pipe();
 	for_each_path(src,&srcNames) {
@@ -1074,80 +1125,66 @@ static int process_renames(struct rename
 			continue;
 		ren1->processed = 1;
 
+		const char *ren1_src = ren1->pair->one->path;
+		const char *ren1_dst = ren1->pair->two->path;
+
 		if ( ren2 ) {
+			const char *ren2_src = ren2->pair->one->path;
+			const char *ren2_dst = ren2->pair->two->path;
 			/* Renamed in 1 and renamed in 2 */
-			if ( strcmp(ren1->src, ren2->src) != 0 )
-				die("ren1.srcName != ren2.srcName");
+			if (strcmp(ren1_src, ren2_src) != 0)
+				die("ren1.src != ren2.src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
-			if ( strcmp(ren1->dst, ren2->dst) != 0 ) {
+			if (strcmp(ren1_dst, ren2_dst) != 0) {
+				cleanMerge = 0;
 				output("CONFLICT (rename/rename): "
 				       "Rename %s->%s in branch %s "
 				       "rename %s->%s in %s",
-				       *src, ren1->dst, branchName1,
-				       *src, ren2->dst, branchName2);
-				cleanMerge = 0;
-				char *dstName1 = ren1->dst, *dstName2 = ren2->dst;
-				if ( path_list_has_path(&currentDirectorySet, ren1->dst) ) {
-					dstName1 = unique_path(ren1->dst, branchName1);
-					output("%s is a directory in %s adding as %s instead",
-					       ren1->dst, branchName2, dstName1);
-					remove_file(fp, 0, ren1->dst);
-				}
-				if ( path_list_has_path(&currentDirectorySet, ren2->dst) ) {
-					dstName2 = unique_path(ren2->dst, branchName2);
-					output("%s is a directory in %s adding as %s instead",
-					       ren2->dst, branchName1, dstName2);
-					remove_file(fp, 0, ren2->dst);
-				}
-				update_stages(fp, dstName1,
-					       NULL, 0,
-					       ren1->dst_sha, ren1->dst_mode,
-					       NULL, 0,
-					       1 /* clear */);
-				update_stages(fp, dstName2,
-					       NULL, 0,
-					       NULL, 0,
-					       ren2->dst_sha, ren2->dst_mode,
-					       1 /* clear */);
+				       *src, ren1_dst, branchName1,
+				       *src, ren2_dst, branchName2);
+				conflict_rename_rename(fp, ren1, branchName1, ren2, branchName2);
 			} else {
-				remove_file(fp, 1, ren1->src);
+				remove_file(fp, 1, ren1_src);
 				struct merge_file_info mfi;
-				mfi = merge_file(ren1->src,
-						 ren1->src_sha,
-						 ren1->src_mode,
-						 ren1->dst,
-						 ren1->dst_sha,
-						 ren1->dst_mode,
-						 ren2->dst,
-						 ren2->dst_sha,
-						 ren2->dst_mode,
+				mfi = merge_file(ren1_src,
+						 ren1->pair->one->sha1,
+						 ren1->pair->one->mode,
+						 ren1_dst,
+						 ren1->pair->two->sha1,
+						 ren1->pair->two->mode,
+						 ren2_dst,
+						 ren2->pair->two->sha1,
+						 ren2->pair->two->mode,
 						 branchName1,
 						 branchName2);
 				if ( mfi.merge || !mfi.clean )
-					output("Renaming %s->%s", *src, ren1->dst);
+					output("Renaming %s->%s", *src, ren1_dst);
 
 				if ( mfi.merge )
-					output("Auto-merging %s", ren1->dst);
+					output("Auto-merging %s", ren1_dst);
 
 				if ( !mfi.clean ) {
 					output("CONFLICT (content): merge conflict in %s",
-					       ren1->dst);
+					       ren1_dst);
 					cleanMerge = 0;
 
 					if ( !index_only )
 						update_stages(fp,
-							       ren1->dst,
-							       ren1->src_sha, ren1->src_mode,
-							       ren1->dst_sha, ren1->dst_mode,
-							       ren2->dst_sha, ren2->dst_mode,
-							       1 /* clear */);
+							      ren1_dst,
+							      ren1->pair->one->sha1,
+							      ren1->pair->one->mode,
+							      ren1->pair->two->sha1,
+							      ren1->pair->two->mode,
+							      ren2->pair->two->sha1,
+							      ren2->pair->two->mode,
+							      1 /* clear */);
 				}
-				update_file(fp, mfi.clean, mfi.sha, mfi.mode, ren1->dst);
+				update_file(fp, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
-			remove_file(fp, 1, ren1->src);
+			remove_file(fp, 1, ren1_src);
 
 			unsigned char srcShaOtherBranch[20], dstShaOtherBranch[20];
 			unsigned srcModeOtherBranch, dstModeOtherBranch;
@@ -1162,62 +1199,52 @@ static int process_renames(struct rename
 
 			int tryMerge = 0;
 			char *newPath;
-			struct rename_entry *dst2;
 
-			if ( path_list_has_path(&currentDirectorySet, ren1->dst) ) {
-				newPath = unique_path(ren1->dst, branchName1);
+			if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
+				cleanMerge = 0;
 				output("CONFLICT (rename/directory): Rename %s->%s in %s "
 				       " directory %s added in %s",
-				       ren1->src, ren1->dst, branchName1,
-				       ren1->dst, branchName2);
-				output("Renaming %s to %s instead", ren1->src, newPath);
-				cleanMerge = 0;
-				remove_file(fp, 0, ren1->dst);
-				update_file(fp, 0, ren1->dst_sha, ren1->dst_mode, newPath);
+				       ren1_src, ren1_dst, branchName1,
+				       ren1_dst, branchName2);
+				conflict_rename_dir(fp, ren1, branchName1);
 			} else if ( memcmp(srcShaOtherBranch, null_sha1, 20) == 0 ) {
+				cleanMerge = 0;
 				output("CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
-				       ren1->src, ren1->dst, branchName1,
+				       ren1_src, ren1_dst, branchName1,
 				       branchName2);
-				cleanMerge = 0;
-				update_file(fp, 0, ren1->dst_sha, ren1->dst_mode, ren1->dst);
+				update_file(fp, 0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
 			} else if ( memcmp(dstShaOtherBranch, null_sha1, 20) != 0 ) {
-				newPath = unique_path(ren1->dst, branchName2);
+				cleanMerge = 0;
+				tryMerge = 1;
 				output("CONFLICT (rename/add): Rename %s->%s in %s. "
 				       "%s added in %s",
-				       ren1->src, ren1->dst, branchName1,
-				       ren1->dst, branchName2);
+				       ren1_src, ren1_dst, branchName1,
+				       ren1_dst, branchName2);
+				newPath = unique_path(ren1_dst, branchName2);
 				output("Adding as %s instead", newPath);
 				update_file(fp, 0, dstShaOtherBranch, dstModeOtherBranch, newPath);
+			} else if ( (ren2 = find_rename_bydst(renames2, ren1_dst)) ) {
 				cleanMerge = 0;
-				tryMerge = 1;
-			} else if ( (dst2 = find_rename_bydst(renames2, ren1->dst)) ) {
-				char *newPath1 = unique_path(ren1->dst, branchName1);
-				char *newPath2 = unique_path(dst2->dst, branchName2);
+				ren2->processed = 1;
 				output("CONFLICT (rename/rename): Rename %s->%s in %s. "
 				       "Rename %s->%s in %s",
-				       ren1->src, ren1->dst, branchName1,
-				       dst2->src, dst2->dst, branchName2);
-				output("Renaming %s to %s and %s to %s instead",
-				       ren1->src, newPath1, dst2->src, newPath2);
-				remove_file(fp, 0, ren1->dst);
-				update_file(fp, 0, ren1->dst_sha, ren1->dst_mode, newPath1);
-				update_file(fp, 0, dst2->dst_sha, dst2->dst_mode, newPath2);
-				dst2->processed = 1;
-				cleanMerge = 0;
+				       ren1_src, ren1_dst, branchName1,
+				       ren2->pair->one->path, ren2->pair->two->path, branchName2);
+				conflict_rename_rename_2(fp, ren1, branchName1, ren2, branchName2);
 			} else
 				tryMerge = 1;
 
 			if ( tryMerge ) {
-				char *oname = ren1->src;
-				char *aname = ren1->dst;
-				char *bname = ren1->src;
+				const char *oname = ren1_src;
+				const char *aname = ren1_dst;
+				const char *bname = ren1_src;
 				unsigned char osha[20], asha[20], bsha[20];
-				unsigned omode = ren1->src_mode;
-				unsigned amode = ren1->dst_mode;
+				unsigned omode = ren1->pair->one->mode;
+				unsigned amode = ren1->pair->two->mode;
 				unsigned bmode = srcModeOtherBranch;
-				memcpy(osha, ren1->src_sha, 20);
-				memcpy(asha, ren1->dst_sha, 20);
+				memcpy(osha, ren1->pair->one->sha1, 20);
+				memcpy(asha, ren1->pair->two->sha1, 20);
 				memcpy(bsha, srcShaOtherBranch, 20);
 				const char *aBranch = branchName1;
 				const char *bBranch = branchName2;
@@ -1234,23 +1261,23 @@ static int process_renames(struct rename
 						 aBranch, bBranch);
 
 				if ( mfi.merge || !mfi.clean )
-					output("Renaming %s => %s", ren1->src, ren1->dst);
+					output("Renaming %s => %s", ren1_src, ren1_dst);
 				if ( mfi.merge )
-					output("Auto-merging %s", ren1->dst);
+					output("Auto-merging %s", ren1_dst);
 				if ( !mfi.clean ) {
 					output("CONFLICT (rename/modify): Merge conflict in %s",
-					       ren1->dst);
+					       ren1_dst);
 					cleanMerge = 0;
 
 					if ( !index_only )
 						update_stages(fp,
-							       ren1->dst,
-							       osha, omode,
-							       asha, amode,
-							       bsha, bmode,
-							       1 /* clear */);
+							      ren1_dst,
+							      osha, omode,
+							      asha, amode,
+							      bsha, bmode,
+							      1 /* clear */);
 				}
-				update_file(fp, mfi.clean, mfi.sha, mfi.mode, ren1->dst);
+				update_file(fp, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		}
 	}
@@ -1451,16 +1478,18 @@ static struct merge_tree_result merge_tr
 			if (!process_entry(fp, e, branch1Name, branch2Name))
 				result.clean = 0;
 		}
+		free_rename_entries(&re_merge);
+		free_rename_entries(&re_head);
+		free_index_entries(&entries);
+
 		if (pclose(fp))
 			die("updating entry failed in git update-index");
+
 		if (result.clean || index_only)
 			result.tree = git_write_tree();
 		else
 			result.tree = NULL;
 		debug("\t  processing entries done\n");
-		free_rename_entries(&re_merge);
-		free_rename_entries(&re_head);
-		free_index_entries(&entries);
 	} else {
 		result.clean = 1;
 		printf("merging of trees %s and %s resulted in %s\n",
-- 
1.4.1.rc1.g17dc
