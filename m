From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] git-blame, take 2
Date: Thu, 2 Mar 2006 22:28:17 +0100
Message-ID: <20060302212816.GA11015@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Mar 02 22:28:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEvLk-0006qt-4V
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 22:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWCBV21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 16:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWCBV20
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 16:28:26 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:10726 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751638AbWCBV2Z
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 16:28:25 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A56284116; Thu,  2 Mar 2006 22:43:27 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FEvLN-0000yC-00; Thu, 02 Mar 2006 22:28:17 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17108>

Hi,

Here is an updated version of git-blame. The main changes compared to
the first version are:

* Use the new revision.h interface to do the revision walking
* Do the right thing in a lot of more cases than before. In particular
  parallel development tracks are hopefully handled sanely.
* Lots of clean-up

It still won't follow file renames though. The patch is against
current pu.

There are still some differences in the output between git-blame and
git-annotate. For example, in 'Makefile' git-blame assigns lines
354-358 to 455a7f3275d264f6e66045b92c83747ec461dda5 and git-annotate
assigns the same lines to 79a9d8ea0d88a3667ad19be8e705405ab5d896f1.

I think git-blame is correct in this case. This patterns occur in
several other places, git-annotate seems to sometimes assign lines to
merge commits when the lines actually changed in some other commit
which precedes the merge.

- Fredrik


Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 blame.c |  888 ++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 504 insertions(+), 384 deletions(-)

3a81d6759da19a4776102a405505f35811320d61
diff --git a/blame.c b/blame.c
index dbce7e2..0b5d6bd 100644
--- a/blame.c
+++ b/blame.c
@@ -1,4 +1,10 @@
+/*
+ * Copyright (C) 2006, Fredrik Kuivinen <freku045@student.liu.se>
+ */
+
 #include <assert.h>
+#include <time.h>
+#include <sys/time.h>
 
 #include "cache.h"
 #include "refs.h"
@@ -7,436 +13,550 @@
 #include "tree.h"
 #include "blob.h"
 #include "diff.h"
+#include "revision.h"
 
 #define DEBUG 0
 
-struct commit** blame_lines;
+struct commit **blame_lines;
 int num_blame_lines;
 
-struct util_info
-{
-    int* line_map;
-    int num_lines;
-    unsigned char sha1[20]; /* blob sha, not commit! */
-    char* buf;
-    unsigned long size;
+struct util_info {
+	int *line_map;
+	unsigned char sha1[20];	/* blob sha, not commit! */
+	char *buf;
+	unsigned long size;
+	int num_lines;
 //    const char* path;
 };
 
-struct chunk
-{
-    int off1, len1; // ---
-    int off2, len2; // +++
+struct chunk {
+	int off1, len1;	// ---
+	int off2, len2;	// +++
 };
 
-struct patch
-{
-    struct chunk* chunks;
-    int num;
+struct patch {
+	struct chunk *chunks;
+	int num;
 };
 
-static void get_blob(struct commit* commit);
-
-int num_get_patch = 0;
-int num_commits = 0;
-
-struct patch* get_patch(struct commit* commit, struct commit* other)
-{
-    struct patch* ret = xmalloc(sizeof(struct patch));
-    ret->chunks = NULL;
-    ret->num = 0;
-
-    struct util_info* info_c = (struct util_info*) commit->object.util;
-    struct util_info* info_o = (struct util_info*) other->object.util;
-
-    if(!memcmp(info_c->sha1, info_o->sha1, 20))
-        return ret;
-
-    get_blob(commit);
-    get_blob(other);
-
-    FILE* fout = fopen("/tmp/git-blame-tmp1", "w");
-    if(!fout)
-        die("fopen tmp1 failed: %s", strerror(errno));
-
-    if(fwrite(info_c->buf, info_c->size, 1, fout) != 1)
-        die("fwrite 1 failed: %s", strerror(errno));
-    fclose(fout);
-
-    fout = fopen("/tmp/git-blame-tmp2", "w");
-    if(!fout)
-        die("fopen tmp2 failed: %s", strerror(errno));
-
-    if(fwrite(info_o->buf, info_o->size, 1, fout) != 1)
-        die("fwrite 2 failed: %s", strerror(errno));
-    fclose(fout);
-
-    FILE* fin = popen("diff -u0 /tmp/git-blame-tmp1 /tmp/git-blame-tmp2", "r");
-    if(!fin)
-        die("popen failed: %s", strerror(errno));
-
-    char buf[1024];
-    while(fgets(buf, sizeof(buf), fin)) {
-        if(buf[0] != '@' || buf[1] != '@')
-            continue;
-
-        if(DEBUG)
-            printf("chunk line: %s", buf);
-        ret->num++;
-        ret->chunks = xrealloc(ret->chunks, sizeof(struct chunk)*ret->num);
-        struct chunk* chunk = &ret->chunks[ret->num-1];
-
-        assert(!strncmp(buf, "@@ -", 4));
-
-        char* start = buf+4;
-        char* sp = index(start, ' ');
-        *sp = '\0';
-        if(index(start, ',')) {
-            int ret = sscanf(start, "%d,%d", &chunk->off1, &chunk->len1);
-            assert(ret == 2);
-        } else {
-            int ret = sscanf(start, "%d", &chunk->off1);
-            assert(ret == 1);
-            chunk->len1 = 1;
-        }
-        *sp = ' ';
-
-        start = sp+1;
-        sp = index(start, ' ');
-        *sp = '\0';
-        if(index(start, ',')) {
-            int ret = sscanf(start, "%d,%d", &chunk->off2, &chunk->len2);
-            assert(ret == 2);
-        } else {
-            int ret = sscanf(start, "%d", &chunk->off2);
-            assert(ret == 1);
-            chunk->len2 = 1;
-        }
-        *sp = ' ';
-
-        if(chunk->off1 > 0)
-            chunk->off1 -= 1;
-        if(chunk->off2 > 0)
-            chunk->off2 -= 1;
-
-        assert(chunk->off1 >= 0);
-        assert(chunk->off2 >= 0);
-    }
-    fclose(fin);
-
-    num_get_patch++;
-    return ret;
-}
-
-void free_patch(struct patch* p)
-{
-    free(p->chunks);
-    free(p);
-}
-
-static int get_blob_sha1_internal(unsigned char *sha1, const char *base, int baselen,
-                                  const char *pathname, unsigned mode, int stage);
+static void get_blob(struct commit *commit);
 
+/* Only used for statistics */
+static int num_get_patch = 0;
+static int num_commits = 0;
+static int patch_time = 0;
+
+#define TEMPFILE_PATH_LEN 60
+static struct patch *get_patch(struct commit *commit, struct commit *other)
+{
+	struct patch *ret;
+	struct util_info *info_c = (struct util_info *)commit->object.util;
+	struct util_info *info_o = (struct util_info *)other->object.util;
+	char tmp_path1[TEMPFILE_PATH_LEN], tmp_path2[TEMPFILE_PATH_LEN];
+	char diff_cmd[TEMPFILE_PATH_LEN*2 + 20];
+	struct timeval tv_start, tv_end;
+	int fd;
+	FILE *fin;
+	char buf[1024];
+	
+	ret = xmalloc(sizeof(struct patch));
+	ret->chunks = NULL;
+	ret->num = 0;
+
+	get_blob(commit);
+	get_blob(other);
+
+	gettimeofday(&tv_start, NULL);
+
+	fd = git_mkstemp(tmp_path1, TEMPFILE_PATH_LEN, "git-blame-XXXXXX");
+	if (fd < 0)
+		die("unable to create temp-file: %s", strerror(errno));
+
+	if (xwrite(fd, info_c->buf, info_c->size) != info_c->size)
+		die("write failed: %s", strerror(errno));
+	close(fd);
+
+	fd = git_mkstemp(tmp_path2, TEMPFILE_PATH_LEN, "git-blame-XXXXXX");
+	if (fd < 0)
+		die("unable to create temp-file: %s", strerror(errno));
+
+	if (xwrite(fd, info_o->buf, info_o->size) != info_o->size)
+		die("write failed: %s", strerror(errno));
+	close(fd);
+
+	sprintf(diff_cmd, "diff -u0 %s %s", tmp_path1, tmp_path2);
+	fin = popen(diff_cmd, "r");
+	if (!fin)
+		die("popen failed: %s", strerror(errno));
+
+	while (fgets(buf, sizeof(buf), fin)) {
+		struct chunk *chunk;
+		char *start, *sp;
+		
+		if (buf[0] != '@' || buf[1] != '@')
+			continue;
+
+		if (DEBUG)
+			printf("chunk line: %s", buf);
+		ret->num++;
+		ret->chunks = xrealloc(ret->chunks,
+				       sizeof(struct chunk) * ret->num);
+		chunk = &ret->chunks[ret->num - 1];
+
+		assert(!strncmp(buf, "@@ -", 4));
+
+		start = buf + 4;
+		sp = index(start, ' ');
+		*sp = '\0';
+		if (index(start, ',')) {
+			int ret =
+			    sscanf(start, "%d,%d", &chunk->off1, &chunk->len1);
+			assert(ret == 2);
+		} else {
+			int ret = sscanf(start, "%d", &chunk->off1);
+			assert(ret == 1);
+			chunk->len1 = 1;
+		}
+		*sp = ' ';
+
+		start = sp + 1;
+		sp = index(start, ' ');
+		*sp = '\0';
+		if (index(start, ',')) {
+			int ret =
+			    sscanf(start, "%d,%d", &chunk->off2, &chunk->len2);
+			assert(ret == 2);
+		} else {
+			int ret = sscanf(start, "%d", &chunk->off2);
+			assert(ret == 1);
+			chunk->len2 = 1;
+		}
+		*sp = ' ';
+
+		if (chunk->len1 == 0)
+			chunk->off1++;
+		if (chunk->len2 == 0)
+			chunk->off2++;
+
+		if (chunk->off1 > 0)
+			chunk->off1--;
+		if (chunk->off2 > 0)
+			chunk->off2--;
+
+		assert(chunk->off1 >= 0);
+		assert(chunk->off2 >= 0);
+	}
+	pclose(fin);
+	unlink(tmp_path1);
+	unlink(tmp_path2);
+	
+	gettimeofday(&tv_end, NULL);
+	patch_time += 1000000 * (tv_end.tv_sec - tv_start.tv_sec) +
+		tv_end.tv_usec - tv_start.tv_usec;
+
+	num_get_patch++;
+	return ret;
+}
+
+static void free_patch(struct patch *p)
+{
+	free(p->chunks);
+	free(p);
+}
+
+static int get_blob_sha1_internal(unsigned char *sha1, const char *base,
+				  int baselen, const char *pathname,
+				  unsigned mode, int stage);
 
 static unsigned char blob_sha1[20];
-static int get_blob_sha1(struct tree* t, const char* pathname, unsigned char* sha1)
+static int get_blob_sha1(struct tree *t, const char *pathname,
+			 unsigned char *sha1)
 {
-    const char *pathspec[2];
-    pathspec[0] = pathname;
-    pathspec[1] = NULL;
-    memset(blob_sha1, 0, sizeof(blob_sha1));
-    read_tree_recursive(t, "", 0, 0, pathspec, get_blob_sha1_internal);
+	int i;
+	const char *pathspec[2];
+	pathspec[0] = pathname;
+	pathspec[1] = NULL;
+	memset(blob_sha1, 0, sizeof(blob_sha1));
+	read_tree_recursive(t, "", 0, 0, pathspec, get_blob_sha1_internal);
 
-    int i;
-    for(i = 0; i < 20; i++) {
-        if(blob_sha1[i] != 0)
-            break;
-    }
+	for (i = 0; i < 20; i++) {
+		if (blob_sha1[i] != 0)
+			break;
+	}
 
-    if(i == 20)
-        return -1;
+	if (i == 20)
+		return -1;
 
-    memcpy(sha1, blob_sha1, 20);
-    return 0;
+	memcpy(sha1, blob_sha1, 20);
+	return 0;
 }
 
-static int get_blob_sha1_internal(unsigned char *sha1, const char *base, int baselen,
-                                  const char *pathname, unsigned mode, int stage)
+static int get_blob_sha1_internal(unsigned char *sha1, const char *base,
+				  int baselen, const char *pathname,
+				  unsigned mode, int stage)
 {
-//    printf("Got blob: %s base: '%s' baselen: %d pathname: '%s' mode: %o stage: %d\n",
-//           sha1_to_hex(sha1), base, baselen, pathname, mode, stage);
-
-    if(S_ISDIR(mode))
-        return READ_TREE_RECURSIVE;
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
 
-    memcpy(blob_sha1, sha1, 20);
-    return -1;
+	memcpy(blob_sha1, sha1, 20);
+	return -1;
 }
 
-static void get_blob(struct commit* commit)
+static void get_blob(struct commit *commit)
 {
-    struct util_info* info = commit->object.util;
-    char type[20];
+	struct util_info *info = commit->object.util;
+	char type[20];
 
-    if(info->buf)
-        return;
+	if (info->buf)
+		return;
 
-    info->buf = read_sha1_file(info->sha1, type, &info->size);
-    assert(!strcmp(type, "blob"));
-}
+	info->buf = read_sha1_file(info->sha1, type, &info->size);
 
-void print_patch(struct patch* p)
-{
-    printf("Num chunks: %d\n", p->num);
-    int i;
-    for(i = 0; i < p->num; i++) {
-        printf("%d,%d %d,%d\n", p->chunks[i].off1, p->chunks[i].len1, p->chunks[i].off2, p->chunks[i].len2);
-    }
+	assert(!strcmp(type, "blob"));
 }
 
-
-// p is a patch from commit to other.
-void fill_line_map(struct commit* commit, struct commit* other, struct patch* p)
+/* For debugging only */
+static void print_patch(struct patch *p)
 {
-    int num_lines = ((struct util_info*) commit->object.util)->num_lines;
-    int* line_map = ((struct util_info*) commit->object.util)->line_map;
-    int num_lines2 = ((struct util_info*) other->object.util)->num_lines;
-    int* line_map2 = ((struct util_info*) other->object.util)->line_map;
-    int cur_chunk = 0;
-    int i1, i2;
-
-    if(p->num && DEBUG)
-        print_patch(p);
-
-    for(i1 = 0; i1 < num_lines; i1++)
-        line_map[i1] = -1;
-
-    if(DEBUG)
-        printf("num lines 1: %d num lines 2: %d\n", num_lines, num_lines2);
-
-    for(i1 = 0, i2 = 0; i1 < num_lines; i1++, i2++) {
-        if(DEBUG > 1)
-            printf("%d %d\n", i1, i2);
-
-        if(i2 >= num_lines2)
-            break;
-
-        line_map[i1] = line_map2[i2];
-
-        struct chunk* chunk = NULL;
-        if(cur_chunk < p->num)
-            chunk = &p->chunks[cur_chunk];
-
-        if(chunk && chunk->off1 == i1) {
-            i2 = chunk->off2;
-
-            if(chunk->len1 > 0)
-                i1 += chunk->len1-1;
-            if(chunk->len2 > 0)
-                i2 += chunk->len2-1;
-            cur_chunk++;
-        }
-    }
-}
-
-int map_line(struct commit* commit, int line)
-{
-    struct util_info* info = commit->object.util;
-    assert(line >= 0 && line < info->num_lines);
-    return info->line_map[line];
+	int i;
+	printf("Num chunks: %d\n", p->num);
+	for (i = 0; i < p->num; i++) {
+		printf("%d,%d %d,%d\n", p->chunks[i].off1, p->chunks[i].len1,
+		       p->chunks[i].off2, p->chunks[i].len2);
+	}
 }
 
-int fill_util_info(struct commit* commit, const char* path)
+/* For debugging only */
+static void print_map(struct commit *cmit, struct commit *other)
 {
-    if(commit->object.util)
-        return 0;
-
-    struct util_info* util = xmalloc(sizeof(struct util_info));
-    util->buf = NULL;
-    util->size = 0;
-    util->num_lines = -1;
-    util->line_map = NULL;
+	struct util_info *util = cmit->object.util;
+	struct util_info *util2 = other->object.util;
 
-    commit->object.util = util;
+	int i;
+	int max =
+	    util->num_lines >
+	    util2->num_lines ? util->num_lines : util2->num_lines;
+	int num;
 
-    if(get_blob_sha1(commit->tree, path, util->sha1))
-        return -1;
+	for (i = 0; i < max; i++) {
+		printf("i: %d ", i);
+		num = -1;
 
-    return 0;
-}
-
-void alloc_line_map(struct commit* commit)
-{
-    struct util_info* util = commit->object.util;
+		if (i < util->num_lines) {
+			num = util->line_map[i];
+			printf("%d\t", num);
+		} else
+			printf("\t");
 
-    if(util->line_map)
-        return;
+		if (i < util2->num_lines) {
+			int num2 = util2->line_map[i];
+			printf("%d\t", num2);
+			if (num != -1 && num2 != num)
+				printf("---");
+		} else
+			printf("\t");
 
-    get_blob(commit);
-
-    int i;
-    util->num_lines = 0;
-    for(i = 0; i < util->size; i++) {
-        if(util->buf[i] == '\n')
-            util->num_lines++;
-    }
-    util->line_map = xmalloc(sizeof(int)*util->num_lines);
+		printf("\n");
+	}
 }
 
-void copy_line_map(struct commit* dst, struct commit* src)
-{
-    struct util_info* u_dst = dst->object.util;
-    struct util_info* u_src = src->object.util;
-
-    u_dst->line_map = u_src->line_map;
-    u_dst->num_lines = u_src->num_lines;
-    u_dst->buf = u_src->buf;
-    u_dst->size = u_src->size;
-}
-
-void process_commits(struct commit_list* list, const char* path)
-{
-    int i;
-
-    while(list) {
-        struct commit* commit = pop_commit(&list);
-        struct commit_list* parents;
-        struct util_info* info;
-
-        info = commit->object.util;
-        num_commits++;
-        if(DEBUG)
-            printf("\nProcessing commit: %d %s\n", num_commits, sha1_to_hex(commit->object.sha1));
-        for(parents = commit->parents;
-            parents != NULL; parents = parents->next) {
-            struct commit* parent = parents->item;
-
-            if(parse_commit(parent) < 0)
-                die("parse_commit error");
-
-            if(DEBUG)
-                printf("parent: %s\n", sha1_to_hex(parent->object.sha1));
-
-            if(fill_util_info(parent, path))
-                continue;
-
-            // Temporarily assign everything to the parent.
-            int num_blame = 0;
-            for(i = 0; i < num_blame_lines; i++) {
-                if(blame_lines[i] == commit) {
-                    num_blame++;
-                    blame_lines[i] = parent;
-                }
-            }
-
-            if(num_blame == 0)
-                continue;
-
-            struct patch* patch = get_patch(parent, commit);
-            if(patch->num == 0) {
-                copy_line_map(parent, commit);
-            } else {
-                alloc_line_map(parent);
-                fill_line_map(parent, commit, patch);
-            }
-
-            for(i = 0; i < patch->num; i++) {
-                int l;
-                for(l = 0; l < patch->chunks[i].len2; l++) {
-                    int mapped_line = map_line(commit, patch->chunks[i].off2 + l);
-                    if(mapped_line != -1 && blame_lines[mapped_line] == parent)
-                        blame_lines[mapped_line] = commit;
-                }
-            }
-            free_patch(patch);
-        }
-    }
-}
-
-#define SEEN 1
-struct commit_list* get_commit_list(struct commit* commit, const char* pathname)
+// p is a patch from commit to other.
+static void fill_line_map(struct commit *commit, struct commit *other,
+			  struct patch *p)
 {
-    struct commit_list* ret = NULL;
-    struct commit_list* process = NULL;
-    unsigned char sha1[20];
-
-    commit_list_insert(commit, &process);
-
-    while(process) {
-        struct commit* com = pop_commit(&process);
-        if(com->object.flags & SEEN)
-            continue;
-
-        com->object.flags |= SEEN;
-        commit_list_insert(com, &ret);
-        struct commit_list* parents;
-
-        parse_commit(com);
-
-        for(parents = com->parents;
-            parents != NULL; parents = parents->next) {
-            struct commit* parent = parents->item;
-
-            parse_commit(parent);
-
-            if(!get_blob_sha1(parent->tree, pathname, sha1))
-                commit_list_insert(parent, &process);
-        }
-    }
-
-    return ret;
+	struct util_info *util = commit->object.util;
+	struct util_info *util2 = other->object.util;
+	int *map = util->line_map;
+	int *map2 = util2->line_map;
+	int cur_chunk = 0;
+	int i1, i2;
+
+	if (p->num && DEBUG)
+		print_patch(p);
+
+	if (DEBUG)
+		printf("num lines 1: %d num lines 2: %d\n", util->num_lines,
+		       util2->num_lines);
+
+	for (i1 = 0, i2 = 0; i1 < util->num_lines; i1++, i2++) {
+		struct chunk *chunk = NULL;
+		if (cur_chunk < p->num)
+			chunk = &p->chunks[cur_chunk];
+
+		if (chunk && chunk->off1 == i1) {
+			if (DEBUG && i2 != chunk->off2)
+				printf("i2: %d off2: %d\n", i2, chunk->off2);
+
+			assert(i2 == chunk->off2);
+
+			i1--;
+			i2--;
+			if (chunk->len1 > 0)
+				i1 += chunk->len1;
+			
+			if (chunk->len2 > 0)
+				i2 += chunk->len2;
+
+			cur_chunk++;
+		} else {
+			if (i2 >= util2->num_lines)
+				break;
+
+			if (map[i1] != map2[i2] && map[i1] != -1) {
+				if (DEBUG)
+					printf("map: i1: %d %d %p i2: %d %d %p\n",
+					       i1, map[i1],
+					       i1 != -1 ? blame_lines[map[i1]] : NULL,
+					       i2, map2[i2],
+					       i2 != -1 ? blame_lines[map2[i2]] : NULL);
+				if (map2[i2] != -1 &&
+				    blame_lines[map[i1]] &&
+				    !blame_lines[map2[i2]])
+					map[i1] = map2[i2];
+			}
+
+			if (map[i1] == -1 && map2[i2] != -1)
+				map[i1] = map2[i2];
+		}
+
+		if (DEBUG > 1)
+			printf("l1: %d l2: %d i1: %d i2: %d\n",
+			       map[i1], map2[i2], i1, i2);
+	}
+}
+
+static int map_line(struct commit *commit, int line)
+{
+	struct util_info *info = commit->object.util;
+	assert(line >= 0 && line < info->num_lines);
+	return info->line_map[line];
+}
+
+static int fill_util_info(struct commit *commit, const char *path)
+{
+	struct util_info *util;
+	if (commit->object.util)
+		return 0;
+
+	util = xmalloc(sizeof(struct util_info));
+
+	if (get_blob_sha1(commit->tree, path, util->sha1)) {
+		free(util);
+		return 1;
+	} else {
+		util->buf = NULL;
+		util->size = 0;
+		util->line_map = NULL;
+		util->num_lines = -1;
+		commit->object.util = util;
+		return 0;
+	}
+}
+
+static void alloc_line_map(struct commit *commit)
+{
+	struct util_info *util = commit->object.util;
+	int i;
+
+	if (util->line_map)
+		return;
+
+	get_blob(commit);
+
+	util->num_lines = 0;
+	for (i = 0; i < util->size; i++) {
+		if (util->buf[i] == '\n')
+			util->num_lines++;
+	}
+	if(util->buf[util->size - 1] != '\n')
+		util->num_lines++;
+	
+	util->line_map = xmalloc(sizeof(int) * util->num_lines);
+
+	for (i = 0; i < util->num_lines; i++)
+		util->line_map[i] = -1;
+}
+
+static void init_first_commit(struct commit* commit, const char* filename)
+{
+	struct util_info* util;
+	int i;
+	
+	if (fill_util_info(commit, filename))
+		die("fill_util_info failed");
+
+	alloc_line_map(commit);
+
+	util = commit->object.util;
+	num_blame_lines = util->num_lines;
+
+	for (i = 0; i < num_blame_lines; i++)
+		util->line_map[i] = i;
+}
+
+
+static void process_commits(struct rev_info *rev, const char *path,
+			    struct commit** initial)
+{
+	int i;
+	struct util_info* util;
+	int lines_left;
+	int *blame_p;
+	int *new_lines;
+	int new_lines_len;
+
+	struct commit* commit = get_revision(rev);
+	assert(commit);
+	init_first_commit(commit, path);
+
+	util = commit->object.util;
+	num_blame_lines = util->num_lines;
+	blame_lines = xmalloc(sizeof(struct commit *) * num_blame_lines);
+	for (i = 0; i < num_blame_lines; i++)
+		blame_lines[i] = NULL;
+
+	lines_left = num_blame_lines;
+	blame_p = xmalloc(sizeof(int) * num_blame_lines);
+	new_lines = xmalloc(sizeof(int) * num_blame_lines);
+	do {
+		struct commit_list *parents;
+		int num_parents;
+		struct util_info *util;
+
+		if (DEBUG)
+			printf("\nProcessing commit: %d %s\n", num_commits,
+			       sha1_to_hex(commit->object.sha1));
+
+		if (lines_left == 0)
+			return;
+
+		num_commits++;
+		memset(blame_p, 0, sizeof(int) * num_blame_lines);
+		new_lines_len = 0;
+		num_parents = 0;
+		for (parents = commit->parents;
+		     parents != NULL; parents = parents->next)
+			num_parents++;
+
+		if(num_parents == 0)
+			*initial = commit;
+
+		if(fill_util_info(commit, path))
+			continue;
+
+		alloc_line_map(commit);
+		util = commit->object.util;
+
+		for (parents = commit->parents;
+		     parents != NULL; parents = parents->next) {
+			struct commit *parent = parents->item;
+			struct patch *patch;
+			
+			if (parse_commit(parent) < 0)
+				die("parse_commit error");
+
+			if (DEBUG)
+				printf("parent: %s\n",
+				       sha1_to_hex(parent->object.sha1));
+
+			if(fill_util_info(parent, path)) {
+				num_parents--;
+				continue;
+			}
+			
+			patch = get_patch(parent, commit);
+                        alloc_line_map(parent);
+                        fill_line_map(parent, commit, patch);
+                        
+                        for (i = 0; i < patch->num; i++) {
+                            int l;
+                            for (l = 0; l < patch->chunks[i].len2; l++) {
+                                int mapped_line =
+                                    map_line(commit, patch->chunks[i].off2 + l);
+                                if (mapped_line != -1) {
+                                    blame_p[mapped_line]++;
+                                    if (blame_p[mapped_line] == num_parents)
+                                        new_lines[new_lines_len++] = mapped_line;
+                                }
+                            }
+			}
+                        free_patch(patch);
+		}
+
+		if (DEBUG)
+			printf("parents: %d\n", num_parents);
+
+		for (i = 0; i < new_lines_len; i++) {
+			int mapped_line = new_lines[i];
+			if (blame_lines[mapped_line] == NULL) {
+				blame_lines[mapped_line] = commit;
+				lines_left--;
+				if (DEBUG)
+					printf("blame: mapped: %d i: %d\n",
+					       mapped_line, i);
+			}
+		}
+	} while ((commit = get_revision(rev)) != NULL);
 }
 
 int main(int argc, const char **argv)
 {
-    unsigned char sha1[20];
-    struct commit *commit;
-    const char* filename;
-    int i;
-
-    setup_git_directory();
-
-    if (argc != 3)
-        die("Usage: blame commit-ish file");
-
-    if (get_sha1(argv[1], sha1))
-        die("get_sha1 failed");
-
-    commit = lookup_commit_reference(sha1);
-
-    filename = argv[2];
-
-    struct commit_list* list = get_commit_list(commit, filename);
-    sort_in_topological_order(&list, 1);
-
-    if(fill_util_info(commit, filename)) {
-        printf("%s not found in %s\n", filename, argv[1]);
-        return 0;
-    }
-    alloc_line_map(commit);
-
-    struct util_info* util = commit->object.util;
-    num_blame_lines = util->num_lines;
-    blame_lines = xmalloc(sizeof(struct commit*)*num_blame_lines);
-
-
-    for(i = 0; i < num_blame_lines; i++) {
-        blame_lines[i] = commit;
-
-        ((struct util_info*) commit->object.util)->line_map[i] = i;
-    }
-
-    process_commits(list, filename);
-
-    for(i = 0; i < num_blame_lines; i++) {
-        printf("%d %s\n", i+1-1, sha1_to_hex(blame_lines[i]->object.sha1));
-//        printf("%d %s\n", i+1-1, find_unique_abbrev(blame_lines[i]->object.sha1, 6));
-    }
-
-    if(DEBUG) {
-        printf("num get patch: %d\n", num_get_patch);
-        printf("num commits: %d\n", num_commits);
-    }
+	int i;
+	struct commit *initial = NULL;
+	unsigned char sha1[20];
+	const char* filename;
+	int num_args;
+	const char* args[10];
+	struct rev_info rev;
+	
+	setup_git_directory();
+
+	if (argc != 3)
+		die("Usage: blame commit-ish file");
+
+
+	filename = argv[2];	
+	
+	{
+		struct commit* commit;
+		if (get_sha1(argv[1], sha1))
+			die("get_sha1 failed");	
+		commit = lookup_commit_reference(sha1);
+
+		if (fill_util_info(commit, filename)) {
+			printf("%s not found in %s\n", filename, argv[1]);
+			return 1;
+		}
+	}
+
+	num_args = 0;
+	args[num_args++] = NULL;
+	args[num_args++] = "--topo-order";
+	args[num_args++] = "--remove-empty";
+	args[num_args++] = argv[1];
+	args[num_args++] = "--";
+	args[num_args++] = filename;
+	args[num_args] = NULL;
+	
+	setup_revisions(num_args, args, &rev, "HEAD");
+	prepare_revision_walk(&rev);
+	process_commits(&rev, filename, &initial);
+
+	for (i = 0; i < num_blame_lines; i++) {
+		struct commit *c = blame_lines[i];
+		if (!c)
+			c = initial;
+
+		printf("%d %.8s\n", i, sha1_to_hex(c->object.sha1));
+// printf("%d %s\n", i, find_unique_abbrev(blame_lines[i]->object.sha1, 6));
+	}
+
+	if (DEBUG) {
+		printf("num get patch: %d\n", num_get_patch);
+		printf("num commits: %d\n", num_commits);
+		printf("patch time: %f\n", patch_time / 1000000.0);
+		printf("initial: %s\n", sha1_to_hex(initial->object.sha1));
+	}
 
-    return 0;
+	return 0;
 }
-- 
1.2.4.g90ab-dirty
