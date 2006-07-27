From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WIP] Status update on merge-recursive in C
Date: Thu, 27 Jul 2006 01:51:36 -0700
Message-ID: <7vu053o2g7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607081840280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<1152421230.2103.31.camel@dv>
	<Pine.LNX.4.63.0607091634010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 10:51:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G61ay-0003Jf-Vf
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 10:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWG0Ivj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 04:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWG0Ivj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 04:51:39 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7850 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750727AbWG0Ivi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 04:51:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060727085137.XPWX12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Jul 2006 04:51:37 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607091634010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 9 Jul 2006 16:41:28 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24269>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 9 Jul 2006, Pavel Roskin wrote:
>
>> - variable declarations in the middle of the code (allowed by c99 but
>> not by ANSI C) and incomplete function declarations (no "void").  It's
>> not C++, let's stick to the C standards.
>...
>> I'm attaching a patch that fixes everything except variable
>> declarations.
>
> May I ask you a favour? Can you redo the patch in, say, two weeks? Thank 
> you!

Now it's about two weeks so maybe we can apply this on top to
clean up and prod you to continue ;-)?

-- >8 --
[PATCH] merge-recursive in C: pedantic.

This just cleans up mixed declaration and code warnings and
incomplete function declarations, as Pavel earlier pointed out.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c |  147 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 83 insertions(+), 64 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8d30519..3735df1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -25,9 +25,9 @@ #include "path-list.h"
 /*#define DEBUG*/
 
 #ifdef DEBUG
-#define debug(args, ...) fprintf(stderr, args, ## __VA_ARGS__)
+#define debug(...) fprintf(stderr, __VA_ARGS__)
 #else
-#define debug(args, ...)
+#define debug(...) do { ; /* nothing */ } while (0)
 #endif
 
 #ifdef DEBUG
@@ -61,13 +61,14 @@ static void show_ce_entry(const char *ta
 	fputc('\n', stderr);
 }
 
-static void ls_files() {
+static void ls_files(void) {
 	int i;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		show_ce_entry("", ce);
 	}
 	fprintf(stderr, "---\n");
+	if (0) ls_files(); /* avoid "unused" warning */
 }
 #endif
 
@@ -89,8 +90,8 @@ static const char *commit_title(struct c
 			s = "(bad commit)";
 			*len = strlen(s);
 		} else {
-			s = commit->buffer;
 			char prev = '\0';
+			s = commit->buffer;
 			while ( *s ) {
 				if ( '\n' == prev && '\n' == *s ) {
 					++s;
@@ -207,7 +208,7 @@ static const char *original_index_file;
 static const char *temporary_index_file;
 static int cache_dirty = 0;
 
-static int flush_cache()
+static int flush_cache(void)
 {
 	/* flush temporary index */
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
@@ -290,11 +291,12 @@ #if 0
 		getenv("GIT_INDEX_FILE"),
 		sha1_to_hex(tree->object.sha1));
 #endif
+	int rc;
 	const char *argv[] = { "git-read-tree", NULL, NULL, };
 	if (cache_dirty)
 		die("read-tree with dirty cache");
 	argv[1] = sha1_to_hex(tree->object.sha1);
-	int rc = run_command_v(2, argv);
+	rc = run_command_v(2, argv);
 	return rc < 0 ? -1: rc;
 }
 
@@ -314,6 +316,7 @@ #if 0
 		sha1_to_hex(head->object.sha1),
 		sha1_to_hex(merge->object.sha1));
 #endif
+	int rc;
 	const char *argv[] = {
 		"git-read-tree", NULL, "-m", NULL, NULL, NULL,
 		NULL,
@@ -324,32 +327,34 @@ #endif
 	argv[3] = sha1_to_hex(common->object.sha1);
 	argv[4] = sha1_to_hex(head->object.sha1);
 	argv[5] = sha1_to_hex(merge->object.sha1);
-	int rc = run_command_v(6, argv);
+	rc = run_command_v(6, argv);
 	return rc < 0 ? -1: rc;
 }
 
 /*
  * TODO: this can be streamlined by refactoring builtin-write-tree.c
  */
-static struct tree *git_write_tree()
+static struct tree *git_write_tree(void)
 {
 #if 0
 	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
 		getenv("GIT_INDEX_FILE"));
 #endif
-	if (cache_dirty)
-		flush_cache();
-	FILE *fp = popen("git-write-tree 2>/dev/null", "r");
+	FILE *fp;
+	int rc;
 	char buf[41];
 	unsigned char sha1[20];
 	int ch;
 	unsigned i = 0;
+	if (cache_dirty)
+		flush_cache();
+	fp = popen("git-write-tree 2>/dev/null", "r");
 	while ( (ch = fgetc(fp)) != EOF )
 		if ( i < sizeof(buf)-1 && ch >= '0' && ch <= 'f' )
 			buf[i++] = ch;
 		else
 			break;
-	int rc = pclose(fp);
+	rc = pclose(fp);
 	if ( rc == -1 || WEXITSTATUS(rc) )
 		return NULL;
 	buf[i] = '\0';
@@ -467,7 +472,7 @@ static void free_index_entries(struct pa
  * Create a dictionary mapping file names to CacheEntry objects. The
  * dictionary contains one entry for every path with a non-zero stage entry.
  */
-static struct path_list *get_unmerged()
+static struct path_list *get_unmerged(void)
 {
 	struct path_list *unmerged = xcalloc(1, sizeof(struct path_list));
 	int i;
@@ -479,10 +484,10 @@ static struct path_list *get_unmerged()
 	}
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
+		struct stage_data *e;
 		if (!ce_stage(ce))
 			continue;
-
-		struct stage_data *e = index_entry_get(unmerged, ce->name);
+		e = index_entry_get(unmerged, ce->name);
 		e->stages[ce_stage(ce)].mode = ntohl(ce->ce_mode);
 		memcpy(e->stages[ce_stage(ce)].sha, ce->sha1, 20);
 	}
@@ -530,13 +535,16 @@ static struct path_list *get_renames(str
 					struct tree *bTree,
 					struct path_list *entries)
 {
+	int i;
+	struct path_list *renames;
+	struct diff_options opts;
 #ifdef DEBUG
 	time_t t = time(0);
+
 	debug("getRenames ...\n");
 #endif
-	int i;
-	struct path_list *renames = xcalloc(1, sizeof(struct path_list));
-	struct diff_options opts;
+
+	renames = xcalloc(1, sizeof(struct path_list));
 	diff_setup(&opts);
 	opts.recursive = 1;
 	opts.detect_rename = DIFF_DETECT_RENAME;
@@ -547,6 +555,7 @@ #endif
 	diffcore_std(&opts);
 	for (i = 0; i < diff_queued_diff.nr; ++i) {
 		struct rename *re;
+		struct path_list_item *item;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
 		if (pair->status != 'R') {
 			diff_free_filepair(pair);
@@ -560,19 +569,17 @@ #endif
 		if ( !re->src_entry ) {
 			re->src_entry = index_entry_from_db(re->pair->one->path,
 					oTree, aTree, bTree);
-			struct path_list_item *item =
-				path_list_insert(re->pair->one->path, entries);
+			item = path_list_insert(re->pair->one->path, entries);
 			item->util = re->src_entry;
 		}
 		re->dst_entry = index_entry_find(entries, re->pair->two->path);
 		if ( !re->dst_entry ) {
 			re->dst_entry = index_entry_from_db(re->pair->two->path,
 					oTree, aTree, bTree);
-			struct path_list_item *item =
-				path_list_insert(re->pair->two->path, entries);
+			item = path_list_insert(re->pair->two->path, entries);
 			item->util = re->dst_entry;
 		}
-		struct path_list_item *item = path_list_insert(pair->one->path, renames);
+		item = path_list_insert(pair->one->path, renames);
 		item->util = re;
 	}
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -613,14 +620,14 @@ int update_stages(const char *path,
  */
 static int remove_path(const char *name)
 {
-	int ret;
-	char *slash;
+	int ret, len;
+	char *slash, *dirs;
 
 	ret = unlink(name);
 	if ( ret )
 		return ret;
-	int len = strlen(name);
-	char *dirs = malloc(len+1);
+	len = strlen(name);
+	dirs = malloc(len+1);
 	memcpy(dirs, name, len);
 	dirs[len] = '\0';
 	while ( (slash = strrchr(name, '/')) ) {
@@ -664,15 +671,17 @@ int remove_file(int clean, const char *p
 static char *unique_path(const char *path, const char *branch)
 {
 	char *newpath = xmalloc(strlen(path) + 1 + strlen(branch) + 8 + 1);
+	char *p;
+	int suffix;
+	struct stat st;
 	strcpy(newpath, path);
 	strcat(newpath, "~");
-	char *p = newpath + strlen(newpath);
+	p = newpath + strlen(newpath);
 	strcpy(p, branch);
 	for ( ; *p; ++p )
 		if ( '/' == *p )
 			*p = '_';
-	int suffix = 0;
-	struct stat st;
+	suffix = 0;
 	while ( path_list_has_path(&currentFileSet, newpath) ||
 		path_list_has_path(&currentDirectorySet, newpath) ||
 		lstat(newpath, &st) == 0 ) {
@@ -754,6 +763,7 @@ void update_file_flags(const unsigned ch
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
 
 		if ( S_ISREG(mode) ) {
+			int fd;
 			if ( mkdir_p(path, 0777, 0 /* don't create last element */) )
 				die("failed to create path %s: %s", path, strerror(errno));
 			unlink(path);
@@ -761,7 +771,7 @@ void update_file_flags(const unsigned ch
 				mode = 0777;
 			else
 				mode = 0666;
-			int fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if ( fd < 0 )
 				die("failed to open %s: %s", path, strerror(errno));
 			flush_buffer(fd, buf, size);
@@ -863,17 +873,19 @@ static struct merge_file_info merge_file
 			char orig[PATH_MAX];
 			char src1[PATH_MAX];
 			char src2[PATH_MAX];
-
-			git_unpack_file(oSha, orig);
-			git_unpack_file(aSha, src1);
-			git_unpack_file(bSha, src2);
-
 			const char *argv[] = {
 				"merge", "-L", NULL, "-L", NULL, "-L", NULL,
 				src1, orig, src2,
 				NULL
 			};
 			char *la, *lb, *lo;
+			struct stat st;
+			int fd;
+
+			git_unpack_file(oSha, orig);
+			git_unpack_file(aSha, src1);
+			git_unpack_file(bSha, src2);
+
 			argv[2] = la = strdup(mkpath("%s/%s", branch1Name, aPath));
 			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, bPath));
 			argv[4] = lo = strdup(mkpath("orig/%s", oPath));
@@ -892,8 +904,7 @@ #endif
 				die("Failed to execute 'merge'. merge(1) is used as the "
 				    "file-level merge tool. Is 'merge' in your path?");
 			}
-			struct stat st;
-			int fd = open(src1, O_RDONLY);
+			fd = open(src1, O_RDONLY);
 			if (fd < 0 || fstat(fd, &st) < 0 ||
 					index_fd(result.sha, fd, &st, 1,
 						"blob"))
@@ -1018,6 +1029,7 @@ static int process_renames(struct path_l
 		struct path_list *renames1, *renames2, *renames2Dst;
 		struct rename *ren1, *ren2;
 		const char *branchName1, *branchName2;
+		const char *ren1_src, *ren1_dst;
 		ren1 = find_rename_bysrc(renamesA, src);
 		ren2 = find_rename_bysrc(renamesB, src);
 		/* TODO: refactor, so that 1/2 are not needed */
@@ -1028,12 +1040,13 @@ static int process_renames(struct path_l
 			branchName1 = branchNameA;
 			branchName2 = branchNameB;
 		} else {
+			struct rename *tmp;
 			renames1 = renamesB;
 			renames2 = renamesA;
 			renames2Dst = &byDstA;
 			branchName1 = branchNameB;
 			branchName2 = branchNameA;
-			struct rename *tmp = ren2;
+			tmp = ren2;
 			ren2 = ren1;
 			ren1 = tmp;
 		}
@@ -1045,8 +1058,8 @@ static int process_renames(struct path_l
 			continue;
 		ren1->processed = 1;
 
-		const char *ren1_src = ren1->pair->one->path;
-		const char *ren1_dst = ren1->pair->two->path;
+		ren1_src = ren1->pair->one->path;
+		ren1_dst = ren1->pair->two->path;
 
 		if ( ren2 ) {
 			const char *ren2_src = ren2->pair->one->path;
@@ -1065,8 +1078,8 @@ static int process_renames(struct path_l
 				       src, ren2_dst, branchName2);
 				conflict_rename_rename(ren1, branchName1, ren2, branchName2);
 			} else {
-				remove_file(1, ren1_src);
 				struct merge_file_info mfi;
+				remove_file(1, ren1_src);
 				mfi = merge_file(ren1_src,
 						 ren1->pair->one->sha1,
 						 ren1->pair->one->mode,
@@ -1102,13 +1115,17 @@ static int process_renames(struct path_l
 				update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		} else {
-			/* Renamed in 1, maybe changed in 2 */
-			remove_file(1, ren1_src);
-
 			unsigned char srcShaOtherBranch[20], dstShaOtherBranch[20];
 			unsigned srcModeOtherBranch, dstModeOtherBranch;
 
-			int stage = renamesA == renames1 ? 3: 2;
+			int stage;
+			int tryMerge = 0;
+			char *newPath;
+
+			/* Renamed in 1, maybe changed in 2 */
+			remove_file(1, ren1_src);
+
+			stage = renamesA == renames1 ? 3: 2;
 
 			memcpy(srcShaOtherBranch, ren1->src_entry->stages[stage].sha, 20);
 			srcModeOtherBranch = ren1->src_entry->stages[stage].mode;
@@ -1116,8 +1133,7 @@ static int process_renames(struct path_l
 			memcpy(dstShaOtherBranch, ren1->dst_entry->stages[stage].sha, 20);
 			dstModeOtherBranch = ren1->dst_entry->stages[stage].mode;
 
-			int tryMerge = 0;
-			char *newPath;
+			tryMerge = 0;
 
 			if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
 				cleanMerge = 0;
@@ -1162,18 +1178,19 @@ static int process_renames(struct path_l
 				unsigned omode = ren1->pair->one->mode;
 				unsigned amode = ren1->pair->two->mode;
 				unsigned bmode = srcModeOtherBranch;
+				const char *aBranch = branchName1;
+				const char *bBranch = branchName2;
+				struct merge_file_info mfi;
+
 				memcpy(osha, ren1->pair->one->sha1, 20);
 				memcpy(asha, ren1->pair->two->sha1, 20);
 				memcpy(bsha, srcShaOtherBranch, 20);
-				const char *aBranch = branchName1;
-				const char *bBranch = branchName2;
 
 				if ( renamesA != renames1 ) {
 					memswp(&aname, &bname, sizeof(aname));
 					memswp(asha, bsha, 20);
 					memswp(&aBranch, &bBranch, sizeof(aBranch));
 				}
-				struct merge_file_info mfi;
 				mfi = merge_file(oname, osha, omode,
 						 aname, asha, amode,
 						 bname, bsha, bmode,
@@ -1280,8 +1297,9 @@ static int process_entry(const char *pat
 			conf = "directory/file";
 		}
 		if ( path_list_has_path(&currentDirectorySet, path) ) {
+			const char *newPath;
 			cleanMerge = 0;
-			const char *newPath = unique_path(path, addBranch);
+			newPath = unique_path(path, addBranch);
 			output("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, otherBranch, path, newPath);
@@ -1306,9 +1324,10 @@ static int process_entry(const char *pat
 				assert(0 && "This case must be handled by git-read-tree");
 			}
 		} else {
+			const char *newPath1, *newPath2;
 			cleanMerge = 0;
-			const char *newPath1 = unique_path(path, branch1Name);
-			const char *newPath2 = unique_path(path, branch2Name);
+			newPath1 = unique_path(path, branch1Name);
+			newPath2 = unique_path(path, branch2Name);
 			output("CONFLICT (add/add): File %s added non-identically "
 			       "in both branches. Adding as %s and %s instead.",
 			       path, newPath1, newPath2);
@@ -1319,8 +1338,8 @@ static int process_entry(const char *pat
 
 	} else if ( oSha && aSha && bSha ) {
 		/* case D: Modified in both, but differently. */
-		output("Auto-merging %s", path);
 		struct merge_file_info mfi;
+		output("Auto-merging %s", path);
 		mfi = merge_file(path, oSha, oMode,
 				 path, aSha, aMode,
 				 path, bSha, bMode,
@@ -1373,19 +1392,19 @@ static struct merge_tree_result merge_tr
 	result.tree = git_write_tree();
 
 	if ( !result.tree ) {
+		struct path_list *entries, *re_head, *re_merge;
+		int i;
 		path_list_clear(&currentFileSet, 1);
 		path_list_clear(&currentDirectorySet, 1);
 		get_files_dirs(head, &currentFileSet, &currentDirectorySet);
 		get_files_dirs(merge, &currentFileSet, &currentDirectorySet);
 
-		struct path_list *entries = get_unmerged();
-		struct path_list *re_head, *re_merge;
+		entries = get_unmerged();
 		re_head  = get_renames(head, common, head, merge, entries);
 		re_merge = get_renames(merge, common, head, merge, entries);
 		result.clean = process_renames(re_head, re_merge,
 					       branch1Name, branch2Name);
 		debug("\tprocessing entries...\n");
-		int i;
 		for (i = 0; i < entries->nr; i++) {
 			const char *path = entries->items[i].path;
 			struct stage_data *e = entries->items[i].util;
@@ -1512,6 +1531,10 @@ int main(int argc, char *argv[])
 {
 	static const char *bases[2];
 	static unsigned bases_count = 0;
+	int i;
+	const char *branch1, *branch2;
+	struct merge_result result;
+	struct commit *h1, *h2;
 
 	original_index_file = getenv("GIT_INDEX_FILE");
 
@@ -1523,7 +1546,6 @@ int main(int argc, char *argv[])
 	if (argc < 4)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
 
-	int i;
 	for (i = 1; i < argc; ++i) {
 		if (!strcmp(argv[i], "--"))
 			break;
@@ -1533,15 +1555,12 @@ int main(int argc, char *argv[])
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
 
-	const char *branch1, *branch2;
-
 	branch1 = argv[++i];
 	branch2 = argv[++i];
 	printf("Merging %s with %s\n", branch1, branch2);
 
-	struct merge_result result;
-	struct commit *h1 = get_ref(branch1);
-	struct commit *h2 = get_ref(branch2);
+	h1 = get_ref(branch1);
+	h2 = get_ref(branch2);
 
 	if (bases_count == 1) {
 		struct commit *ancestor = get_ref(bases[0]);
-- 
1.4.2.rc2.g544b
