From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH 4/4] save another call to git-update-index
Date: Fri, 30 Jun 2006 02:27:56 +0200
Message-ID: <20060630002756.GD22618@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 30 02:28:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6rq-0002HI-P3
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWF3A2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWF3A2M
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:28:12 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:63394 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964816AbWF3A2L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 20:28:11 -0400
Received: from fwd28.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1Fw6re-0000Jb-00; Fri, 30 Jun 2006 02:28:06 +0200
Received: from tigra.home (XdjHZ4ZBYeXdXFbHJfsJ36KLkUQ+68OyMdIZ+-1XAiqjehCqquvN00@[84.160.88.232]) by fwd28.sul.t-online.de
	with esmtp id 1Fw6rU-1I0PEu0; Fri, 30 Jun 2006 02:27:56 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 46B4F277B5;
	Fri, 30 Jun 2006 02:27:56 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fw6rU-0007gk-8f; Fri, 30 Jun 2006 02:27:56 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-ID: XdjHZ4ZBYeXdXFbHJfsJ36KLkUQ+68OyMdIZ+-1XAiqjehCqquvN00
X-TOI-MSGID: e0dc215c-3217-40d6-ada8-8d9f63f5f206
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22934>

and a small cleanup
---
 merge-recursive.c |   41 ++++++++++++++++++-----------------------
 1 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9a18e06..f3f8e7d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -21,7 +21,7 @@ #include "graph.h"
 #include "path-list.h"
 
 #define HAVE_ALLOCA
-#define DEBUG
+/*#define DEBUG*/
 
 #ifdef DEBUG
 #define debug(args, ...) fprintf(stderr, args, ## __VA_ARGS__)
@@ -629,8 +629,10 @@ static struct rename_entry *get_renames(
 					struct tree *bTree,
 					struct index_entry **entries)
 {
+#ifdef DEBUG
 	time_t t = time(0);
 	debug("getRenames ...\n");
+#endif
 	struct rename_entry *renames = NULL;
 	struct rename_entry **rptr = &renames;
 	struct diff_options opts;
@@ -691,22 +693,16 @@ static int update_stages(FILE *up_index,
 {
 	if ( !up_index )
 		return -1;
-	if ( clear ) {
+	if ( clear )
 		fprintf(up_index, "0 %s\t%s", sha1_to_hex(null_sha1), path);
-		fputc('\0', up_index);
-	}
-	if ( omode ) {
+	if ( omode )
 		fprintf(up_index, "0%o %s 1\t%s", omode, sha1_to_hex(osha), path);
-		fputc('\0', up_index);
-	}
-	if ( amode ) {
+	if ( amode )
 		fprintf(up_index, "0%o %s 2\t%s", amode, sha1_to_hex(asha), path);
-		fputc('\0', up_index);
-	}
-	if ( bmode ) {
+	if ( bmode )
 		fprintf(up_index, "0%o %s 3\t%s", bmode, sha1_to_hex(bsha), path);
+	if ( clear || omode || amode || bmode )
 		fputc('\0', up_index);
-	}
 	return 0;
 }
 
@@ -1080,7 +1076,8 @@ static void conflict_rename_rename_2(FIL
 	free(newPath1);
 }
 
-static int process_renames(struct rename_entry *renamesA,
+static int process_renames(FILE* fp,
+			   struct rename_entry *renamesA,
 			   struct rename_entry *renamesB,
 			   const char *branchNameA,
 			   const char *branchNameB)
@@ -1097,7 +1094,6 @@ static int process_renames(struct rename
 	for (sre = renamesB; sre; sre = sre->next)
 		path_list_insert(sre->pair->one->path, &srcNames);
 
-	FILE *fp = git_update_index_pipe();
 	for_each_path(src,&srcNames) {
 		struct rename_entry *renames1, *renames2, *ren1, *ren2;
 		const char *branchName1, *branchName2;
@@ -1282,9 +1278,6 @@ static int process_renames(struct rename
 		}
 	}
 	path_list_clear(&srcNames, 0);
-	if (pclose(fp)) {
-		die("git update-index --index-info failed");
-	}
 	debug("  processRenames done\n");
 	return cleanMerge;
 }
@@ -1467,24 +1460,26 @@ static struct merge_tree_result merge_tr
 		struct rename_entry *re_head, *re_merge;
 		re_head  = get_renames(head, common, head, merge, &entries);
 		re_merge = get_renames(merge, common, head, merge, &entries);
-		result.clean = process_renames(re_head, re_merge,
+		FILE *up_index = git_update_index_pipe();
+		result.clean = process_renames(up_index,
+					       re_head, re_merge,
 					       branch1Name, branch2Name);
 		debug("\tprocessing entries...\n");
-		FILE *fp = git_update_index_pipe();
 		struct index_entry *e;
 		for (e = entries; e; e = e->next) {
 			if (e->processed)
 				continue;
-			if (!process_entry(fp, e, branch1Name, branch2Name))
+			if (!process_entry(up_index, e,
+					   branch1Name, branch2Name))
 				result.clean = 0;
 		}
+		if (pclose(up_index))
+			die("updating entry failed in git update-index");
+
 		free_rename_entries(&re_merge);
 		free_rename_entries(&re_head);
 		free_index_entries(&entries);
 
-		if (pclose(fp))
-			die("updating entry failed in git update-index");
-
 		if (result.clean || index_only)
 			result.tree = git_write_tree();
 		else
-- 
1.4.1.rc1.g17dc
