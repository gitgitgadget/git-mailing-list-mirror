From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Tue, 27 Jun 2006 18:42:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 27 18:44:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvGfI-0001e5-QI
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 18:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWF0QnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 12:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWF0QnH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 12:43:07 -0400
Received: from mail.gmx.net ([213.165.64.21]:25786 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161181AbWF0Qmx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 12:42:53 -0400
Received: (qmail invoked by alias); 27 Jun 2006 16:42:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 27 Jun 2006 18:42:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22742>

Hi,

On Tue, 27 Jun 2006, Alex Riesen wrote:

> - use a pipe to "git-update-index --index-info" instead of using command 
> line

It might be an even better idea to call the cache functions directly. But 
in that case, you definitely want a function set_index_file() in 
environment.c, as well as a way to invalidate the active cache. Something 
like

	if (active_cache) {
		free(active_cache);
		active_cache = NULL;
		active_nr = active_alloc = 0;
		free(active_cache_tree);
		active_cache_tree = NULL;
		read_cache();
	}

> Good news is that it is faster: 6min vs 10min. Bad news is that it is 
> still not enough for me and it is only on Linux (Windows will be slower, 
> still testing), uses an awful lot of memory and CPU.

No fear. I am sure we'll get there.

> Path list optimization should be next (and I'll be glad if someone does 
> this before me).

See below.

> Also graph algos have a greate optimization potential (intersection, all 
> parents of a node, node_by_sha).

The longer I look at it, the more I am convinced that this graph thing is 
not necessary. I was hesitant at first that addCommonRoot() would not be 
possible, but nobody says we cannot override commit->parents.

I have some commits in a private branch to split out get_merge_bases() 
from merge-base.c, so I'll try that next.

BTW, before actually finishing this, we might want to do away with 
capitalizedFunctionNames and 4-space indent.

And here comes my patch (on top of what you sent) to avoid linked lists:

 merge-recursive.c |   61 ++++++++++++-------------
 path-list.c       |  128 +++++++++++++++++++++++++++++++++++------------------
 path-list.h       |   31 +++++++------
 3 files changed, 129 insertions(+), 91 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 547150e..b608a49 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -75,8 +75,8 @@ void print_index_entry(const char *text,
 }
 #endif
 
-static struct path_list *currentFileSet;
-static struct path_list *currentDirectorySet;
+static struct path_list currentFileSet = {NULL, 0, 0};
+static struct path_list currentDirectorySet = {NULL, 0, 0};
 
 static int output_indent = 0;
 
@@ -297,8 +297,8 @@ static int read_tree_rt(struct tree *tre
 
 struct files_and_dirs
 {
-	struct path_list **files;
-	struct path_list **dirs;
+	struct path_list *files;
+	struct path_list *dirs;
 };
 
 static int save_files_dirs(const char *sha1,
@@ -309,19 +309,16 @@ static int save_files_dirs(const char *s
 	struct files_and_dirs *data = data_;
 	char *path = strdup(path_);
 
-	if (S_ISDIR(mode)) {
+	if (S_ISDIR(mode))
 		path_list_insert(path, data->dirs);
-		data->dirs = &(*data->dirs)->next;
-	} else {
+	else
 		path_list_insert(path, data->files);
-		data->files = &(*data->files)->next;
-	}
 	return READ_TREE_RECURSIVE;
 }
 
 int getFilesAndDirs(struct tree *tree,
-		    struct path_list **files,
-		    struct path_list **dirs)
+		    struct path_list *files,
+		    struct path_list *dirs)
 {
 	struct files_and_dirs data;
 	path_list_clear(files, 1);
@@ -330,7 +327,7 @@ int getFilesAndDirs(struct tree *tree,
 	data.dirs = dirs;
 	if ( read_tree_rt(tree, "", 0, save_files_dirs, &data) != 0 )
 		return 0;
-	return path_list_count(*files) + path_list_count(*dirs);
+	return path_list_count(files) + path_list_count(dirs);
 }
 
 struct index_entry *index_entry_find(struct index_entry *ents, const char *path)
@@ -714,8 +711,8 @@ char *uniquePath(const char *path, const
 			*p = '_';
 	int suffix = 0;
 	struct stat st;
-	while ( path_list_has_path(currentFileSet, newpath) ||
-		path_list_has_path(currentDirectorySet, newpath) ||
+	while ( path_list_has_path(&currentFileSet, newpath) ||
+		path_list_has_path(&currentDirectorySet, newpath) ||
 		lstat(newpath, &st) == 0 ) {
 		sprintf(p, "_%d", suffix++);
 	}
@@ -980,23 +977,21 @@ int processRenames(struct rename_entry *
 	//	   branchNameA, renamesA ? renamesA->src: "(none)",
 	//	   branchNameB, renamesB ? renamesB->dst: "(none)");
 
-	struct path_list *srcNames = NULL;
+	struct path_list srcNames = {NULL, 0, 0};
 	const struct rename_entry *sre;
+	char **src;
 
 	for (sre = renamesA; sre; sre = sre->next)
-		if (!path_list_has_path(srcNames, sre->src))
-			path_list_insert(sre->src, &srcNames);
+		path_list_insert(sre->src, &srcNames);
 	for (sre = renamesB; sre; sre = sre->next)
-		if (!path_list_has_path(srcNames, sre->src))
-			path_list_insert(sre->src, &srcNames);
+		path_list_insert(sre->src, &srcNames);
 
 	FILE *fp = git_update_index_pipe();
-	struct path_list *src;
-	for_each_path(src,srcNames) {
+	for_each_path(src,&srcNames) {
 		struct rename_entry *renames1, *renames2, *ren1, *ren2;
 		const char *branchName1, *branchName2;
-		ren1 = find_rename_bysrc(renamesA, src->path);
-		ren2 = find_rename_bysrc(renamesB, src->path);
+		ren1 = find_rename_bysrc(renamesA, *src);
+		ren2 = find_rename_bysrc(renamesB, *src);
 		if ( ren1 ) {
 			renames1 = renamesA;
 			renames2 = renamesB;
@@ -1029,17 +1024,17 @@ int processRenames(struct rename_entry *
 				output("CONFLICT (rename/rename): "
 				       "Rename %s->%s in branch %s "
 				       "rename %s->%s in %s",
-				       src->path, ren1->dst, branchName1,
-				       src->path, ren2->dst, branchName2);
+				       *src, ren1->dst, branchName1,
+				       *src, ren2->dst, branchName2);
 				cleanMerge = 0;
 				char *dstName1 = ren1->dst, *dstName2 = ren2->dst;
-				if ( path_list_has_path(currentDirectorySet, ren1->dst) ) {
+				if ( path_list_has_path(&currentDirectorySet, ren1->dst) ) {
 					dstName1 = uniquePath(ren1->dst, branchName1);
 					output("%s is a directory in %s adding as %s instead",
 					       ren1->dst, branchName2, dstName1);
 					removeFile(fp, 0, ren1->dst);
 				}
-				if ( path_list_has_path(currentDirectorySet, ren2->dst) ) {
+				if ( path_list_has_path(&currentDirectorySet, ren2->dst) ) {
 					dstName2 = uniquePath(ren2->dst, branchName2);
 					output("%s is a directory in %s adding as %s instead",
 					       ren2->dst, branchName1, dstName2);
@@ -1063,7 +1058,7 @@ int processRenames(struct rename_entry *
 						ren2->dst, ren2->dst_sha, ren2->dst_mode,
 						branchName1, branchName2);
 				if ( mfi.merge || !mfi.clean )
-					output("Renaming %s->%s", src->path, ren1->dst);
+					output("Renaming %s->%s", *src, ren1->dst);
 
 				if ( mfi.merge )
 					output("Auto-merging %s", ren1->dst);
@@ -1102,7 +1097,7 @@ int processRenames(struct rename_entry *
 			char *newPath;
 			struct rename_entry *dst2;
 
-			if ( path_list_has_path(currentDirectorySet, ren1->dst) ) {
+			if ( path_list_has_path(&currentDirectorySet, ren1->dst) ) {
 				newPath = uniquePath(ren1->dst, branchName1);
 				output("CONFLICT (rename/directory): Rename %s->%s in %s "
 				       " directory %s added in %s",
@@ -1283,7 +1278,7 @@ int processEntry(struct index_entry *ent
 			sha = bSha;
 			conf = "directory/file";
 		}
-		if ( path_list_has_path(currentDirectorySet, path) ) {
+		if ( path_list_has_path(&currentDirectorySet, path) ) {
 			cleanMerge = 0;
 			const char *newPath = uniquePath(path, addBranch);
 			output("CONFLICT (%s): There is a directory with name %s in %s. "
@@ -1379,13 +1374,13 @@ struct merge_tree_result merge_trees(str
 	result.tree = git_write_tree();
 
 	if ( !result.tree ) {
-		struct path_list *filesM = NULL, *dirsM = NULL;
+		struct path_list filesM = {NULL, 0, 0}, dirsM = {NULL, 0, 0};
 
 		getFilesAndDirs(head, &currentFileSet, &currentDirectorySet);
 		getFilesAndDirs(merge, &filesM, &dirsM);
 
-		path_list_union_update(&currentFileSet, filesM);
-		path_list_union_update(&currentDirectorySet, dirsM);
+		path_list_union_update(&currentFileSet, &filesM);
+		path_list_union_update(&currentDirectorySet, &dirsM);
 
 		struct index_entry *entries = unmergedCacheEntries();
 		struct rename_entry *renamesHead, *renamesMerge;
diff --git a/path-list.c b/path-list.c
index f969116..fbfc103 100644
--- a/path-list.c
+++ b/path-list.c
@@ -2,67 +2,109 @@ #include <stdio.h>
 #include "cache.h"
 #include "path-list.h"
 
-static struct path_list *path_list_pool = NULL;
-
-struct path_list *path_list_insert(char *path, struct path_list **list)
+/* if there is no exact match, point to the index where the entry could be
+ * inserted */
+static int get_entry_index(const struct path_list *container, const char *path,
+		int *exact_match)
 {
-    struct path_list *e;
-    if ( path_list_pool ) {
-        e = path_list_pool;
-        path_list_pool = path_list_pool->next;
-    } else
-        e = xmalloc(sizeof(struct path_list));
-    e->next = *list;
-    e->path = path;
-    *list = e;
-    return e;
+	int left = -1, right = container->nr;
+
+	while (left + 1 < right) {
+		int middle = (left + right) / 2;
+		int compare = strcmp(path, container->paths[middle]);
+		if (compare < 0)
+			right = middle;
+		else if (compare > 0)
+			left = middle;
+		else {
+			*exact_match = 1;
+			return middle;
+		}
+	}
+
+	*exact_match = 0;
+	return right;
 }
 
-void path_list_clear(struct path_list **list, int free_path)
+/* returns -1-index if already exists */
+static int add_entry(struct path_list *container, const char *path)
 {
-    while ( *list ) {
-        struct path_list *next = (*list)->next;
-	if (free_path)
-	    free((*list)->path);
-        (*list)->path = NULL;
-        (*list)->next = path_list_pool;
-        path_list_pool = *list;
-        *list = next;
-    }
+	int exact_match;
+	int index = get_entry_index(container, path, &exact_match);
+
+	if (exact_match)
+		return -1 - index;
+
+	if (container->nr + 1 >= container->alloc) {
+		container->alloc += 32;
+		container->paths = realloc(container->paths,
+				container->alloc * sizeof(char *));
+	}
+	if (index < container->nr)
+		memmove(container->paths + index + 1,
+				container->paths + index,
+				(container->nr - index) * sizeof(char *));
+	container->paths[index] = strdup(path);
+	container->nr++;
+
+	return index;
 }
 
-int path_list_count(const struct path_list *list)
+char *path_list_insert(char *path, struct path_list *list)
 {
-    int n = 0;
-    for ( ; list; list = list->next )
-        ++n;
-    return n;
+	int index = add_entry(list, path);
+
+	if (index < 0)
+		index = 1 - index;
+
+	return list->paths[index];
 }
 
 int path_list_has_path(const struct path_list *list, const char *path)
 {
-    for ( ; list; list = list->next )
-        if ( strcmp(path, list->path) == 0 )
-            return 1;
-    return 0;
+	int exact_match;
+	get_entry_index(list, path, &exact_match);
+	return exact_match;
 }
 
 // in place
-void path_list_union_update(struct path_list **dst, const struct path_list *src)
+void path_list_union_update(struct path_list *dst, const struct path_list *src)
 {
-    const struct path_list *i = src;
-    while ( i ) {
-        if ( !path_list_has_path(*dst, i->path) )
-	    path_list_insert(i->path, dst);
-	i = i->next;
-    }
+	char **new_paths;
+	int i = 0, j = 0, nr = 0, alloc = dst->nr + dst->nr;
+
+	new_paths = xcalloc(sizeof(char *), alloc);
+
+	while (i < dst->nr || j < src->nr) {
+		char **entry = new_paths + nr++;
+		if (i == dst->nr)
+			*entry = src->paths[j++];
+		else if (j == src->nr)
+			*entry = dst->paths[i++];
+		else {
+			int compare = strcmp(dst->paths[i], src->paths[j]);
+			if (compare > 0)
+				*entry = src->paths[j++];
+			else {
+				*entry = dst->paths[i++];
+				if (!compare)
+					free(src->paths[j++]);
+			}
+		}
+	}
+
+	free(dst->paths);
+	dst->paths = new_paths;
+	dst->nr = nr;
+	dst->alloc = alloc;
 }
 
 void print_path_list(const char *text, const struct path_list *p)
 {
-    if ( text )
-        printf("%s\n", text);
-    for ( ; p; p = p->next )
-        printf("%s\n", p->path);
+	int i;
+	if ( text )
+		printf("%s\n", text);
+	for (i = 0; i < p->nr; i++)
+		printf("%s\n", p->paths[i]);
 }
 
diff --git a/path-list.h b/path-list.h
index 7e79f17..a12c7a4 100644
--- a/path-list.h
+++ b/path-list.h
@@ -3,29 +3,30 @@ #define _PATH_LIST_H_
 
 struct path_list
 {
-    struct path_list *next;
-    char *path;
+    char **paths;
+    unsigned int nr, alloc;
 };
 
-#define for_each_path(p,list) for ( p = (list); p; p = p->next )
+#define for_each_path(p,list) for ( p = (list)->paths; p != (list)->paths + (list)->nr; p++ )
 
 void print_path_list(const char *text, const struct path_list *p);
 
-static inline struct path_list *path_list_shift(struct path_list **list)
-{
-    struct path_list *cur = *list;
-    *list = cur->next;
-    return cur;
-}
+#define path_list_count(list) (list)->nr
 
-int path_list_count(const struct path_list *list);
 int path_list_has_path(const struct path_list *list, const char *path);
-void path_list_union_update(struct path_list **dst, const struct path_list *src);
-void path_list_clear(struct path_list **list, int free_path);
-static inline void path_list_free(struct path_list *list)
+void path_list_union_update(struct path_list *dst, const struct path_list *src);
+static inline void path_list_clear(struct path_list *list, int free_paths)
 {
-    path_list_clear(&list, 1);
+	if (list->paths) {
+		int i;
+		if (free_paths)
+			for (i = 0; i < list->nr; i++)
+				free(list->paths[i]);
+		free(list->paths);
+	}
+	list->paths = NULL;
+	list->nr = list->alloc = 0;
 }
-struct path_list *path_list_insert(char *path, struct path_list **list);
+char *path_list_insert(char *path, struct path_list *list);
 
 #endif /* _PATH_LIST_H_ */
-- 
1.4.1.rc1.g3583-dirty
