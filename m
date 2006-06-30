From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] merge-recursive: avoid the pipe to update-index
Date: Fri, 30 Jun 2006 16:44:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606301644210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 16:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKEn-0003e2-9Q
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 16:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWF3Oou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 10:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWF3Oou
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 10:44:50 -0400
Received: from mail.gmx.de ([213.165.64.21]:61109 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750975AbWF3Oot (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 10:44:49 -0400
Received: (qmail invoked by alias); 30 Jun 2006 14:44:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 30 Jun 2006 16:44:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <fork0@t-online.de>
In-Reply-To: <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22990>


Instead of a fork, we can use the plumbing ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 graph.c           |   26 -----
 merge-recursive.c |  270 +++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 191 insertions(+), 105 deletions(-)

diff --git a/graph.c b/graph.c
index fa2bfee..b784ea2 100644
--- a/graph.c
+++ b/graph.c
@@ -5,32 +5,6 @@ #include "cache.h"
 #include "commit.h"
 #include "graph.h"
 
-// does not belong here
-struct tree *git_write_tree()
-{
-#if 0
-	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
-		getenv("GIT_INDEX_FILE"));
-#endif
-	FILE *fp = popen("git-write-tree 2>/dev/null", "r");
-	char buf[41];
-	unsigned char sha1[20];
-	int ch;
-	unsigned i = 0;
-	while ( (ch = fgetc(fp)) != EOF )
-		if ( i < sizeof(buf)-1 && ch >= '0' && ch <= 'f' )
-			buf[i++] = ch;
-		else
-			break;
-	int rc = pclose(fp);
-	if ( rc == -1 || WEXITSTATUS(rc) )
-		return NULL;
-	buf[i] = '\0';
-	if ( get_sha1(buf, sha1) != 0 )
-		return NULL;
-	return lookup_tree(sha1);
-}
-
 const char *node_title(struct node *node, int *len)
 {
 	const char *s = "(null commit)";
diff --git a/merge-recursive.c b/merge-recursive.c
index 9bbb426..6d4e797 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -9,6 +9,7 @@ #include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include "cache.h"
+#include "cache-tree.h"
 #include "commit.h"
 #include "blob.h"
 #include "tree-walk.h"
@@ -19,6 +20,47 @@ #include "run-command.h"
 #include "graph.h"
 #include "path-list.h"
 
+#ifdef DEBUG
+#include "quote.h"
+static void show_ce_entry(const char *tag, struct cache_entry *ce)
+{
+	if (tag && *tag &&
+	    (ce->ce_flags & htons(CE_VALID))) {
+		static char alttag[4];
+		memcpy(alttag, tag, 3);
+		if (isalpha(tag[0]))
+			alttag[0] = tolower(tag[0]);
+		else if (tag[0] == '?')
+			alttag[0] = '!';
+		else {
+			alttag[0] = 'v';
+			alttag[1] = tag[0];
+			alttag[2] = ' ';
+			alttag[3] = 0;
+		}
+		tag = alttag;
+	}
+
+	fprintf(stderr,"%s%06o %s %d\t",
+			tag,
+			ntohl(ce->ce_mode),
+			sha1_to_hex(ce->sha1),
+			ce_stage(ce));
+	write_name_quoted("", 0, ce->name,
+			'\n', stderr);
+	fputc('\n', stderr);
+}
+
+static void ls_files() {
+	int i;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		show_ce_entry("", ce);
+	}
+	fprintf(stderr, "---\n");
+}
+#endif
+
 #define for_each_commit(p,list) for ( p = (list); p; p = p->next )
 
 struct merge_result
@@ -94,12 +136,68 @@ static void output(const char *fmt, ...)
 
 static const char *original_index_file;
 static const char *temporary_index_file;
+static int cache_dirty = 0;
+
+static int flush_cache()
+{
+	/* flush temporary index */
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	int fd = hold_lock_file_for_update(lock, getenv("GIT_INDEX_FILE"));
+	if (fd < 0)
+		die("could not lock %s", temporary_index_file);
+	if (write_cache(fd, active_cache, active_nr) ||
+			commit_lock_file(lock))
+		die ("unable to write %s", temporary_index_file);
+	discard_cache();
+	cache_dirty = 0;
+	return 0;
+}
 
 static void setup_index(int temp)
 {
 	const char *idx = temp ? temporary_index_file: original_index_file;
+	if (cache_dirty)
+		die("fatal: cache changed flush_cache();");
 	unlink(temporary_index_file);
 	setenv("GIT_INDEX_FILE", idx, 1);
+	discard_cache();
+}
+
+static struct cache_entry *make_cache_entry(unsigned int mode,
+		const unsigned char *sha1, const char *path, int stage, int refresh)
+{
+	int size, len;
+	struct cache_entry *ce;
+
+	if (!verify_path(path))
+		return NULL;
+
+	len = strlen(path);
+	size = cache_entry_size(len);
+	ce = xcalloc(1, size);
+
+	memcpy(ce->sha1, sha1, 20);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_mode = create_ce_mode(mode);
+
+	if (refresh)
+		return refresh_cache_entry(ce, 0);
+
+	return ce;
+}
+
+static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
+		const char *path, int stage, int refresh, int options)
+{
+	struct cache_entry *ce;
+	if (!cache_dirty)
+		read_cache_from(getenv("GIT_INDEX_FILE"));
+	cache_dirty++;
+	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh);
+	if (!ce)
+		return error("cache_addinfo failed: %s", strerror(cache_errno));
+	return add_cache_entry(ce, options);
 }
 
 // This is a global variable which is used in a number of places but
@@ -119,6 +217,8 @@ #if 0
 		sha1_to_hex(tree->object.sha1));
 #endif
 	const char *argv[] = { "git-read-tree", NULL, NULL, };
+	if (cache_dirty)
+		die("read-tree with dirty cache");
 	argv[1] = sha1_to_hex(tree->object.sha1);
 	int rc = run_command_v(2, argv);
 	return rc < 0 ? -1: rc;
@@ -141,6 +241,8 @@ #endif
 		"git-read-tree", NULL, "-m", NULL, NULL, NULL,
 		NULL,
 	};
+	if (cache_dirty)
+		flush_cache();
 	argv[1] = update_arg;
 	argv[3] = sha1_to_hex(common->object.sha1);
 	argv[4] = sha1_to_hex(head->object.sha1);
@@ -149,6 +251,33 @@ #endif
 	return rc < 0 ? -1: rc;
 }
 
+struct tree *git_write_tree()
+{
+#if 0
+	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
+		getenv("GIT_INDEX_FILE"));
+#endif
+	if (cache_dirty)
+		flush_cache();
+	FILE *fp = popen("git-write-tree 2>/dev/null", "r");
+	char buf[41];
+	unsigned char sha1[20];
+	int ch;
+	unsigned i = 0;
+	while ( (ch = fgetc(fp)) != EOF )
+		if ( i < sizeof(buf)-1 && ch >= '0' && ch <= 'f' )
+			buf[i++] = ch;
+		else
+			break;
+	int rc = pclose(fp);
+	if ( rc == -1 || WEXITSTATUS(rc) )
+		return NULL;
+	buf[i] = '\0';
+	if ( get_sha1(buf, sha1) != 0 )
+		return NULL;
+	return lookup_tree(sha1);
+}
+
 struct merge_tree_result merge_trees(struct tree *head,
 				     struct tree *merge,
 				     struct tree *common,
@@ -640,36 +769,25 @@ struct rename_entry *getRenames(struct t
 	return renames;
 }
 
-static FILE *git_update_index_pipe()
-{
-	return popen("git-update-index -z --index-info", "w");
-}
-
-int setIndexStages(FILE *fp,
-		   const char *path,
+int setIndexStages(const char *path,
 		   unsigned char *osha, unsigned omode,
 		   unsigned char *asha, unsigned amode,
 		   unsigned char *bsha, unsigned bmode,
 		   int clear /* =True */)
 {
-	if ( !fp )
-		return -1;
-	if ( clear ) {
-		fprintf(fp, "0 %s\t%s", sha1_to_hex(null_sha1), path);
-		fputc('\0', fp);
-	}
-	if ( omode ) {
-		fprintf(fp, "0%o %s 1\t%s", omode, sha1_to_hex(osha), path);
-		fputc('\0', fp);
-	}
-	if ( amode ) {
-		fprintf(fp, "0%o %s 2\t%s", amode, sha1_to_hex(asha), path);
-		fputc('\0', fp);
-	}
-	if ( bmode ) {
-		fprintf(fp, "0%o %s 3\t%s", bmode, sha1_to_hex(bsha), path);
-		fputc('\0', fp);
-	}
+	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+	if ( clear ) 
+		if (add_cacheinfo(0, null_sha1, path, 0, 0, options))
+			return -1;
+	if ( omode )
+		if (add_cacheinfo(omode, osha, path, 1, 0, options))
+			return -1;
+	if ( amode )
+		if (add_cacheinfo(omode, osha, path, 2, 0, options))
+			return -1;
+	if ( bmode )
+		if (add_cacheinfo(omode, osha, path, 3, 0, options))
+			return -1;
 	return 0;
 }
 
@@ -695,17 +813,17 @@ static int remove_path(const char *name)
 	return ret;
 }
 
-int removeFile(FILE *fp, int clean, const char *path)
+int removeFile(int clean, const char *path)
 {
 	int updateCache = index_only || clean;
 	int updateWd = !index_only;
 
 	if ( updateCache ) {
-		if ( !fp )
+		if (!cache_dirty)
+			read_cache_from(getenv("GIT_INDEX_FILE"));
+		cache_dirty++;
+		if (remove_file_from_cache(path))
 			return -1;
-		fprintf(fp, "0 %s\t%s", sha1_to_hex(null_sha1), path);
-		fputc('\0', fp);
-		return 0;
 	}
 	if ( updateWd )
 	{
@@ -785,8 +903,7 @@ static void flush_buffer(int fd, const c
 	}
 }
 
-void updateFileExt(FILE *fp,
-		   const unsigned char *sha,
+void updateFileExt(const unsigned char *sha,
 		   unsigned mode,
 		   const char *path,
 		   int updateCache,
@@ -830,20 +947,15 @@ void updateFileExt(FILE *fp,
 			    mode, sha1_to_hex(sha), path);
 	}
 	if ( updateCache )
-	{
-		// XXX just always use "git update-index --index-info"?
-		fprintf(fp, "%06o %s\t%s", mode, sha1_to_hex(sha), path);
-		fputc('\0', fp);
-	}
+		add_cacheinfo(mode, sha, path, 0, updateWd, ADD_CACHE_OK_TO_ADD);
 }
 
-void updateFile(FILE *fp,
-		int clean,
+void updateFile(int clean,
 		const unsigned char *sha,
 		unsigned mode,
 		const char *path)
 {
-	updateFileExt(fp, sha, mode, path, index_only || clean, !index_only);
+	updateFileExt(sha, mode, path, index_only || clean, !index_only);
 }
 
 // Low level file merging, update and removal
@@ -1004,7 +1116,6 @@ int processRenames(struct rename_entry *
 	for (sre = renamesB; sre; sre = sre->next)
 		path_list_insert(sre->src, &srcNames);
 
-	FILE *fp = git_update_index_pipe();
 	for_each_path(src,&srcNames) {
 		struct rename_entry *renames1, *renames2, *ren1, *ren2;
 		const char *branchName1, *branchName2;
@@ -1050,26 +1161,26 @@ int processRenames(struct rename_entry *
 					dstName1 = uniquePath(ren1->dst, branchName1);
 					output("%s is a directory in %s adding as %s instead",
 					       ren1->dst, branchName2, dstName1);
-					removeFile(fp, 0, ren1->dst);
+					removeFile(0, ren1->dst);
 				}
 				if ( path_list_has_path(&currentDirectorySet, ren2->dst) ) {
 					dstName2 = uniquePath(ren2->dst, branchName2);
 					output("%s is a directory in %s adding as %s instead",
 					       ren2->dst, branchName1, dstName2);
-					removeFile(fp, 0, ren2->dst);
+					removeFile(0, ren2->dst);
 				}
-				setIndexStages(fp, dstName1,
+				setIndexStages(dstName1,
 					       NULL, 0,
 					       ren1->dst_sha, ren1->dst_mode,
 					       NULL, 0,
 					       1 /* clear */);
-				setIndexStages(fp, dstName2,
+				setIndexStages(dstName2,
 					       NULL, 0,
 					       NULL, 0,
 					       ren2->dst_sha, ren2->dst_mode,
 					       1 /* clear */);
 			} else {
-				removeFile(fp, 1, ren1->src);
+				removeFile(1, ren1->src);
 				struct merge_file_info mfi;
 				mfi = mergeFile(ren1->src, ren1->src_sha, ren1->src_mode,
 						ren1->dst, ren1->dst_sha, ren1->dst_mode,
@@ -1087,18 +1198,17 @@ int processRenames(struct rename_entry *
 					cleanMerge = 0;
 
 					if ( !index_only )
-						setIndexStages(fp,
-							       ren1->dst,
+						setIndexStages(ren1->dst,
 							       ren1->src_sha, ren1->src_mode,
 							       ren1->dst_sha, ren1->dst_mode,
 							       ren2->dst_sha, ren2->dst_mode,
 							       1 /* clear */);
 				}
-				updateFile(fp, mfi.clean, mfi.sha, mfi.mode, ren1->dst);
+				updateFile(mfi.clean, mfi.sha, mfi.mode, ren1->dst);
 			}
 		} else {
 			// Renamed in 1, maybe changed in 2
-			removeFile(fp, 1, ren1->src);
+			removeFile(1, ren1->src);
 
 			unsigned char srcShaOtherBranch[20], dstShaOtherBranch[20];
 			unsigned srcModeOtherBranch, dstModeOtherBranch;
@@ -1123,15 +1233,15 @@ int processRenames(struct rename_entry *
 				       ren1->dst, branchName2);
 				output("Renaming %s to %s instead", ren1->src, newPath);
 				cleanMerge = 0;
-				removeFile(fp, 0, ren1->dst);
-				updateFile(fp, 0, ren1->dst_sha, ren1->dst_mode, newPath);
+				removeFile(0, ren1->dst);
+				updateFile(0, ren1->dst_sha, ren1->dst_mode, newPath);
 			} else if ( memcmp(srcShaOtherBranch, null_sha1, 20) == 0 ) {
 				output("CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
 				       ren1->src, ren1->dst, branchName1,
 				       branchName2);
 				cleanMerge = 0;
-				updateFile(fp, 0, ren1->dst_sha, ren1->dst_mode, ren1->dst);
+				updateFile(0, ren1->dst_sha, ren1->dst_mode, ren1->dst);
 			} else if ( memcmp(dstShaOtherBranch, null_sha1, 20) != 0 ) {
 				newPath = uniquePath(ren1->dst, branchName2);
 				output("CONFLICT (rename/add): Rename %s->%s in %s. "
@@ -1139,7 +1249,7 @@ int processRenames(struct rename_entry *
 				       ren1->src, ren1->dst, branchName1,
 				       ren1->dst, branchName2);
 				output("Adding as %s instead", newPath);
-				updateFile(fp, 0, dstShaOtherBranch, dstModeOtherBranch, newPath);
+				updateFile(0, dstShaOtherBranch, dstModeOtherBranch, newPath);
 				cleanMerge = 0;
 				tryMerge = 1;
 			} else if ( (dst2 = find_rename_bydst(renames2, ren1->dst)) ) {
@@ -1151,9 +1261,9 @@ int processRenames(struct rename_entry *
 				       dst2->src, dst2->dst, branchName2);
 				output("Renaming %s to %s and %s to %s instead",
 				       ren1->src, newPath1, dst2->src, newPath2);
-				removeFile(fp, 0, ren1->dst);
-				updateFile(fp, 0, ren1->dst_sha, ren1->dst_mode, newPath1);
-				updateFile(fp, 0, dst2->dst_sha, dst2->dst_mode, newPath2);
+				removeFile(0, ren1->dst);
+				updateFile(0, ren1->dst_sha, ren1->dst_mode, newPath1);
+				updateFile(0, dst2->dst_sha, dst2->dst_mode, newPath2);
 				dst2->processed = 1;
 				cleanMerge = 0;
 			} else
@@ -1194,21 +1304,19 @@ int processRenames(struct rename_entry *
 					cleanMerge = 0;
 
 					if ( !index_only )
-						setIndexStages(fp,
-							       ren1->dst,
+						setIndexStages(ren1->dst,
 							       osha, omode,
 							       asha, amode,
 							       bsha, bmode,
 							       1 /* clear */);
 				}
-				updateFile(fp, mfi.clean, mfi.sha, mfi.mode, ren1->dst);
+				updateFile(mfi.clean, mfi.sha, mfi.mode, ren1->dst);
 			}
 		}
 	}
 	path_list_clear(&srcNames, 0);
-	if (pclose(fp)) {
-		die("git update-index --index-info failed");
-	}
+	if (cache_dirty)
+		flush_cache();
 	return cleanMerge;
 }
 
@@ -1241,7 +1349,6 @@ int processEntry(struct index_entry *ent
 	unsigned oMode = entry->stages[1].mode;
 	unsigned aMode = entry->stages[2].mode;
 	unsigned bMode = entry->stages[3].mode;
-	FILE *fp = git_update_index_pipe();
 
 	if ( oSha && (!aSha || !bSha) ) {
 		//
@@ -1253,7 +1360,7 @@ int processEntry(struct index_entry *ent
 			// Deleted in both or deleted in one and unchanged in the other
 			if ( aSha )
 				output("Removing %s", path);
-			removeFile(fp, 1, path);
+			removeFile(1, path);
 		} else {
 			// Deleted in one and changed in the other
 			cleanMerge = 0;
@@ -1262,13 +1369,13 @@ int processEntry(struct index_entry *ent
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, branch1Name,
 				       branch2Name, branch2Name, path);
-				updateFile(fp, 0, bSha, bMode, path);
+				updateFile(0, bSha, bMode, path);
 			} else {
 				output("CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, branch2Name,
 				       branch1Name, branch1Name, path);
-				updateFile(fp, 0, aSha, aMode, path);
+				updateFile(0, aSha, aMode, path);
 			}
 		}
 
@@ -1302,11 +1409,11 @@ int processEntry(struct index_entry *ent
 			output("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, otherBranch, path, newPath);
-			removeFile(fp, 0, path);
-			updateFile(fp, 0, sha, mode, newPath);
+			removeFile(0, path);
+			updateFile(0, sha, mode, newPath);
 		} else {
 			output("Adding %s", path);
-			updateFile(fp, 1, sha, mode, path);
+			updateFile(1, sha, mode, path);
 		}
 	} else if ( !oSha && aSha && bSha ) {
 		//
@@ -1319,7 +1426,7 @@ int processEntry(struct index_entry *ent
 				       "but permissions conflict %06o->%06o",
 				       path, aMode, bMode);
 				output("CONFLICT: adding with permission: %06o", aMode);
-				updateFile(fp, 0, aSha, aMode, path);
+				updateFile(0, aSha, aMode, path);
 			} else {
 				// This case is handled by git-read-tree
 				assert(0 && "This case must be handled by git-read-tree");
@@ -1331,9 +1438,9 @@ int processEntry(struct index_entry *ent
 			output("CONFLICT (add/add): File %s added non-identically "
 			       "in both branches. Adding as %s and %s instead.",
 			       path, newPath1, newPath2);
-			removeFile(fp, 0, path);
-			updateFile(fp, 0, aSha, aMode, newPath1);
-			updateFile(fp, 0, bSha, bMode, newPath2);
+			removeFile(0, path);
+			updateFile(0, aSha, aMode, newPath1);
+			updateFile(0, bSha, bMode, newPath2);
 		}
 
 	} else if ( oSha && aSha && bSha ) {
@@ -1348,22 +1455,23 @@ int processEntry(struct index_entry *ent
 				branch1Name, branch2Name);
 
 		if ( mfi.clean )
-			updateFile(fp, 1, mfi.sha, mfi.mode, path);
+			updateFile(1, mfi.sha, mfi.mode, path);
 		else {
 			cleanMerge = 0;
 			output("CONFLICT (content): Merge conflict in %s", path);
 
 			if ( index_only )
-				updateFile(fp, 0, mfi.sha, mfi.mode, path);
+				updateFile(0, mfi.sha, mfi.mode, path);
 			else
-				updateFileExt(fp, mfi.sha, mfi.mode, path,
+				updateFileExt(mfi.sha, mfi.mode, path,
 					      0 /* updateCache */, 1 /* updateWd */);
 		}
 	} else
 		die("Fatal merge failure, shouldn't happen.");
 
-	if (pclose(fp))
-		die("updating entry failed in git update-index");
+	if (cache_dirty)
+		flush_cache();
+
 	return cleanMerge;
 }
 
@@ -1570,6 +1678,10 @@ int main(int argc, char *argv[])
 		struct graph *graph = graph_build(commits);
 		result = merge(h1, h2, branch1, branch2, graph, 0, NULL);
 	}
+
+	if (cache_dirty)
+		flush_cache();
+
 	return result.clean ? 0: 1;
 }
 
-- 
1.4.1.rc1.gb2d14
