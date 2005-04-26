From: Christopher Li <git@chrisli.org>
Subject: Re: [PATCH] introduce xmalloc and xrealloc
Date: Tue, 26 Apr 2005 11:42:12 -0400
Message-ID: <20050426154212.GC5344@64m.dyndns.org>
References: <20050426151217.GA5344@64m.dyndns.org> <Pine.LNX.4.58.0504261125220.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:40:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUyI-0002aO-Nz
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVDZSo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDZSo4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:44:56 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:26571 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261667AbVDZSnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 14:43:01 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc13) with ESMTP
          id <20050426184300016002k5u5e>; Tue, 26 Apr 2005 18:43:00 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id CF1AF3F1AC; Tue, 26 Apr 2005 11:42:12 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504261125220.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2005 at 11:25:58AM -0700, Linus Torvalds wrote:
> 
> I'd prefer xmalloc()/xrealloc() instead, and just do it in one place.

Done.

Chris

Introduce xmalloc and xrealloc
 
Signed-off-by: Christopher Li<chrislgit@chrisli.org>
Index: git-hack/blob.c
===================================================================
--- git-hack.orig/blob.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/blob.c	2005-04-26 11:38:26.000000000 -0400
@@ -8,7 +8,7 @@
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct blob *ret = malloc(sizeof(struct blob));
+		struct blob *ret = xmalloc(sizeof(struct blob));
 		memset(ret, 0, sizeof(struct blob));
 		created_object(sha1, &ret->object);
 		ret->object.type = blob_type;
Index: git-hack/checkout-cache.c
===================================================================
--- git-hack.orig/checkout-cache.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/checkout-cache.c	2005-04-26 11:38:26.000000000 -0400
@@ -39,7 +39,7 @@
 static void create_directories(const char *path)
 {
 	int len = strlen(path);
-	char *buf = malloc(len + 1);
+	char *buf = xmalloc(len + 1);
 	const char *slash = path;
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
Index: git-hack/commit-tree.c
===================================================================
--- git-hack.orig/commit-tree.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/commit-tree.c	2005-04-26 11:38:26.000000000 -0400
@@ -18,7 +18,7 @@
  */
 static void init_buffer(char **bufp, unsigned int *sizep)
 {
-	char *buf = malloc(BLOCKING);
+	char *buf = xmalloc(BLOCKING);
 	*sizep = 0;
 	*bufp = buf;
 }
@@ -40,7 +40,7 @@
 	buf = *bufp;
 	if (newsize > alloc) {
 		alloc = (newsize + 32767) & ~32767;
-		buf = realloc(buf, alloc);
+		buf = xrealloc(buf, alloc);
 		*bufp = buf;
 	}
 	*sizep = newsize;
Index: git-hack/commit.c
===================================================================
--- git-hack.orig/commit.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/commit.c	2005-04-26 11:38:26.000000000 -0400
@@ -9,7 +9,7 @@
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct commit *ret = malloc(sizeof(struct commit));
+		struct commit *ret = xmalloc(sizeof(struct commit));
 		memset(ret, 0, sizeof(struct commit));
 		created_object(sha1, &ret->object);
 		ret->object.type = commit_type;
@@ -78,7 +78,7 @@
 
 void commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
-	struct commit_list *new_list = malloc(sizeof(struct commit_list));
+	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
 	new_list->item = item;
 	new_list->next = *list_p;
 	*list_p = new_list;
Index: git-hack/convert-cache.c
===================================================================
--- git-hack.orig/convert-cache.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/convert-cache.c	2005-04-26 11:38:26.000000000 -0400
@@ -18,8 +18,7 @@
 
 static struct entry *insert_new(unsigned char *sha1, int pos)
 {
-	struct entry *new = malloc(sizeof(struct entry));
-
+	struct entry *new = xmalloc(sizeof(struct entry));
 	memset(new, 0, sizeof(*new));
 	memcpy(new->old_sha1, sha1, 20);
 	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
@@ -68,7 +67,7 @@
 
 static int write_subdirectory(void *buffer, unsigned long size, const char *base, int baselen, unsigned char *result_sha1)
 {
-	char *new = malloc(size);
+	char *new = xmalloc(size);
 	unsigned long newlen = 0;
 	unsigned long used;
 
@@ -226,9 +225,9 @@
 
 static void convert_date(void *buffer, unsigned long size, unsigned char *result_sha1)
 {
-	char *new = malloc(size + 100);
+	char *new = xmalloc(size + 100);
 	unsigned long newlen = 0;
-
+	
 	// "tree <sha1>\n"
 	memcpy(new + newlen, buffer, 46);
 	newlen += 46;
@@ -283,7 +282,7 @@
 	if (!data)
 		die("unable to read object %s", sha1_to_hex(sha1));
 
-	buffer = malloc(size);
+	buffer = xmalloc(size);
 	memcpy(buffer, data, size);
 	
 	if (!strcmp(type, "blob")) {
Index: git-hack/diff-tree.c
===================================================================
--- git-hack.orig/diff-tree.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/diff-tree.c	2005-04-26 11:38:26.000000000 -0400
@@ -37,7 +37,7 @@
 static char *malloc_base(const char *base, const char *path, int pathlen)
 {
 	int baselen = strlen(base);
-	char *newbase = malloc(baselen + pathlen + 2);
+	char *newbase = xmalloc(baselen + pathlen + 2);
 	memcpy(newbase, base, baselen);
 	memcpy(newbase + baselen, path, pathlen);
 	memcpy(newbase + baselen + pathlen, "/", 2);
@@ -270,7 +270,7 @@
 
 		paths = &argv[3];
 		nr_paths = argc - 3;
-		pathlens = malloc(nr_paths * sizeof(int));
+		pathlens = xmalloc(nr_paths * sizeof(int));
 		for (i=0; i<nr_paths; i++)
 			pathlens[i] = strlen(paths[i]);
 	}
Index: git-hack/http-pull.c
===================================================================
--- git-hack.orig/http-pull.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/http-pull.c	2005-04-26 11:38:26.000000000 -0400
@@ -73,7 +73,7 @@
 	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 
-	url = malloc(strlen(base) + 50);
+	url = xmalloc(strlen(base) + 50);
 	strcpy(url, base);
 	posn = url + strlen(base);
 	strcpy(posn, "objects/");
Index: git-hack/init-db.c
===================================================================
--- git-hack.orig/init-db.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/init-db.c	2005-04-26 11:38:26.000000000 -0400
@@ -34,7 +34,7 @@
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
 	len = strlen(sha1_dir);
-	path = malloc(len + 40);
+	path = xmalloc(len + 40);
 	memcpy(path, sha1_dir, len);
 
 	safe_create_dir(sha1_dir);
Index: git-hack/object.c
===================================================================
--- git-hack.orig/object.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/object.c	2005-04-26 11:38:26.000000000 -0400
@@ -52,7 +52,7 @@
 
 	if (obj_allocs == nr_objs) {
 		obj_allocs = alloc_nr(obj_allocs);
-		objs = realloc(objs, obj_allocs * sizeof(struct object *));
+		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
 	}
 
 	/* Insert it into the right place */
@@ -75,7 +75,7 @@
 	}
 
 	target->used = 1;
-	p = malloc(sizeof(*p));
+	p = xmalloc(sizeof(*p));
 	p->item = target;
 	p->next = NULL;
 	*pp = p;
Index: git-hack/read-cache.c
===================================================================
--- git-hack.orig/read-cache.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/read-cache.c	2005-04-26 11:38:26.000000000 -0400
@@ -143,7 +143,7 @@
 	/* Make sure the array is big enough .. */
 	if (active_nr == active_alloc) {
 		active_alloc = alloc_nr(active_alloc);
-		active_cache = realloc(active_cache, active_alloc * sizeof(struct cache_entry *));
+		active_cache = xrealloc(active_cache, active_alloc * sizeof(struct cache_entry *));
 	}
 
 	/* Add it in.. */
Index: git-hack/sha1_file.c
===================================================================
--- git-hack.orig/sha1_file.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/sha1_file.c	2005-04-26 11:38:26.000000000 -0400
@@ -73,7 +73,7 @@
 	if (!base) {
 		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
 		int len = strlen(sha1_file_directory);
-		base = malloc(len + 60);
+		base = xmalloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
 		memset(base+len, 0, 60);
 		base[len] = '/';
@@ -161,9 +161,7 @@
 		return NULL;
 
 	bytes = strlen(buffer) + 1;
-	buf = malloc(*size);
-	if (!buf)
-		return NULL;
+	buf = xmalloc(*size);
 
 	memcpy(buf, buffer + bytes, stream.total_out - bytes);
 	bytes = stream.total_out - bytes;
@@ -271,7 +269,7 @@
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_BEST_COMPRESSION);
 	size = deflateBound(&stream, len+hdrlen);
-	compressed = malloc(size);
+	compressed = xmalloc(size);
 
 	/* Compress it */
 	stream.next_out = compressed;
Index: git-hack/show-files.c
===================================================================
--- git-hack.orig/show-files.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/show-files.c	2005-04-26 11:38:26.000000000 -0400
@@ -30,9 +30,9 @@
 
 	if (nr_dir == dir_alloc) {
 		dir_alloc = alloc_nr(dir_alloc);
-		dir = realloc(dir, dir_alloc*sizeof(char *));
+		dir = xrealloc(dir, dir_alloc*sizeof(char *));
 	}
-	name = malloc(len + 1);
+	name = xmalloc(len + 1);
 	memcpy(name, pathname, len + 1);
 	dir[nr_dir++] = name;
 }
Index: git-hack/tree.c
===================================================================
--- git-hack.orig/tree.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/tree.c	2005-04-26 11:38:26.000000000 -0400
@@ -9,7 +9,7 @@
 {
 	int len = strlen(pathname);
 	unsigned int size = cache_entry_size(baselen + len);
-	struct cache_entry *ce = malloc(size);
+	struct cache_entry *ce = xmalloc(size);
 
 	memset(ce, 0, size);
 
@@ -39,7 +39,7 @@
 		if (S_ISDIR(mode)) {
 			int retval;
 			int pathlen = strlen(path);
-			char *newbase = malloc(baselen + 1 + pathlen);
+			char *newbase = xmalloc(baselen + 1 + pathlen);
 			void *eltbuf;
 			char elttype[20];
 			unsigned long eltsize;
@@ -74,7 +74,7 @@
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct tree *ret = malloc(sizeof(struct tree));
+		struct tree *ret = xmalloc(sizeof(struct tree));
 		memset(ret, 0, sizeof(struct tree));
 		created_object(sha1, &ret->object);
 		ret->object.type = tree_type;
@@ -116,7 +116,7 @@
 		    sscanf(bufptr, "%o", &mode) != 1)
 			return -1;
 
-		entry = malloc(sizeof(struct tree_entry_list));
+		entry = xmalloc(sizeof(struct tree_entry_list));
 		entry->name = strdup(path + 1);
 		entry->directory = S_ISDIR(mode);
 		entry->executable = mode & S_IXUSR;
Index: git-hack/update-cache.c
===================================================================
--- git-hack.orig/update-cache.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/update-cache.c	2005-04-26 11:38:26.000000000 -0400
@@ -35,8 +35,8 @@
 	z_stream stream;
 	unsigned long size = st->st_size;
 	int max_out_bytes = size + 200;
-	void *out = malloc(max_out_bytes);
-	void *metadata = malloc(200);
+	void *out = xmalloc(max_out_bytes);
+	void *metadata = xmalloc(200);
 	int metadata_size;
 	void *in;
 	SHA_CTX c;
@@ -122,7 +122,7 @@
 	}
 	namelen = strlen(path);
 	size = cache_entry_size(namelen);
-	ce = malloc(size);
+	ce = xmalloc(size);
 	memset(ce, 0, size);
 	memcpy(ce->name, path, namelen);
 	fill_stat_cache_info(ce, &st);
@@ -205,7 +205,7 @@
 		return ERR_PTR(-EINVAL);
 
 	size = ce_size(ce);
-	updated = malloc(size);
+	updated = xmalloc(size);
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
 	return updated;
@@ -281,7 +281,7 @@
 
 	len = strlen(arg3);
 	size = cache_entry_size(len);
-	ce = malloc(size);
+	ce = xmalloc(size);
 	memset(ce, 0, size);
 
 	memcpy(ce->sha1, sha1, 20);
Index: git-hack/write-tree.c
===================================================================
--- git-hack.orig/write-tree.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/write-tree.c	2005-04-26 11:38:26.000000000 -0400
@@ -26,7 +26,7 @@
 
 	/* Guess at some random initial size */
 	size = 8192;
-	buffer = malloc(size);
+	buffer = xmalloc(size);
 	offset = 0;
 
 	nr = 0;
@@ -68,7 +68,7 @@
 		entrylen = pathlen - baselen;
 		if (offset + entrylen + 100 > size) {
 			size = alloc_nr(offset + entrylen + 100);
-			buffer = realloc(buffer, size);
+			buffer = xrealloc(buffer, size);
 		}
 		offset += sprintf(buffer + offset, "%o %.*s", mode, entrylen, filename);
 		buffer[offset++] = 0;
Index: git-hack/revision.h
===================================================================
--- git-hack.orig/revision.h	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/revision.h	2005-04-26 11:38:26.000000000 -0400
@@ -68,10 +68,9 @@
 
 	if (rev_allocs == nr_revs) {
 		rev_allocs = alloc_nr(rev_allocs);
-		revs = realloc(revs, rev_allocs * sizeof(struct revision *));
+		revs = xrealloc(revs, rev_allocs * sizeof(struct revision *));
 	}
-	n = malloc(sizeof(struct revision) + strlen(tag));
-
+	n = xmalloc(sizeof(struct revision) + strlen(tag));
 	n->flags = 0;
 	memcpy(n->sha1, sha1, 20);
 	n->parent = NULL;
@@ -96,7 +95,7 @@
 		pp = &p->next;
 	}
 
-	p = malloc(sizeof(*p));
+	p = xmalloc(sizeof(*p));
 	p->parent = parent_rev;
 	p->next = NULL;
 	*pp = p;
Index: git-hack/diff.c
===================================================================
--- git-hack.orig/diff.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/diff.c	2005-04-26 11:38:26.000000000 -0400
@@ -59,8 +59,7 @@
 		if (*cp == '\'')
 			cnt += 3;
 
-	if (! (buf = malloc(cnt)))
-	    return buf;
+	buf = xmalloc(cnt);
 	bp = buf;
 	while ((c = *src++)) {
 		if (c != '\'')
@@ -100,7 +99,7 @@
 			strlen(diff_arg) +
 			strlen(name_1_sq) + strlen(name_2_sq)
 			- 5);
-	char *cmd = malloc(cmd_size);
+	char *cmd = xmalloc(cmd_size);
 	int next_at = 0;
 
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
Index: git-hack/strbuf.c
===================================================================
--- git-hack.orig/strbuf.c	2005-04-26 11:38:21.000000000 -0400
+++ git-hack/strbuf.c	2005-04-26 11:38:26.000000000 -0400
@@ -1,6 +1,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include "strbuf.h"
+#include "cache.h"
 
 void strbuf_init(struct strbuf *sb) {
 	sb->buf = 0;
@@ -15,7 +16,7 @@
 static void inline strbuf_add(struct strbuf *sb, int ch) {
 	if (sb->alloc <= sb->len) {
 		sb->alloc = sb->alloc * 3 / 2 + 16;
-		sb->buf = realloc(sb->buf, sb->alloc);
+		sb->buf = xrealloc(sb->buf, sb->alloc);
 	}
 	sb->buf[sb->len++] = ch;
 }
Index: git-hack/cache.h
===================================================================
--- git-hack.orig/cache.h	2005-04-26 11:40:43.000000000 -0400
+++ git-hack/cache.h	2005-04-26 11:40:59.000000000 -0400
@@ -147,4 +147,20 @@
 						unsigned long *size,
 						unsigned char *tree_sha1_ret);
 
+static inline void *xmalloc(int size)
+{
+	void *ret = malloc(size);
+	if (!ret)
+		die("Out of memory, malloc failed");
+	return ret;
+}
+
+static inline void *xrealloc(void *ptr, int size)
+{
+	void *ret = realloc(ptr, size);
+	if (!ret)
+		die("Out of memory, realloc failed");
+	return ret;
+}
+
 #endif /* CACHE_H */


