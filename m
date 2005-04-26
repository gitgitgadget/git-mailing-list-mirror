From: Christopher Li <chrislgit@chrisli.org>
Subject: [PATCH] check for malloc
Date: Tue, 26 Apr 2005 11:12:17 -0400
Message-ID: <20050426151217.GA5344@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUUJ-0005qp-6I
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDZSN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDZSN6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:13:58 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:43952 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261417AbVDZSNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 14:13:06 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005042618130401200dcnfde>; Tue, 26 Apr 2005 18:13:04 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 1E2833F1AC; Tue, 26 Apr 2005 11:12:18 -0400 (EDT)
To: git mailing list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add check for NULL return from malloc and realloc

Signed-off-by: Christopher Li <chrislgit@chrisli.org>

Index: git-hack/blob.c
===================================================================
--- git-hack.orig/blob.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/blob.c	2005-04-26 10:55:56.000000000 -0400
@@ -9,6 +9,8 @@
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
 		struct blob *ret = malloc(sizeof(struct blob));
+		if (!ret)
+			die("Out of memory, malloc failed");
 		memset(ret, 0, sizeof(struct blob));
 		created_object(sha1, &ret->object);
 		ret->object.type = blob_type;
Index: git-hack/checkout-cache.c
===================================================================
--- git-hack.orig/checkout-cache.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/checkout-cache.c	2005-04-26 10:56:32.000000000 -0400
@@ -42,6 +42,8 @@
 	char *buf = malloc(len + 1);
 	const char *slash = path;
 
+	if (!buf)
+		die ("Out of memory, malloc failed");
 	while ((slash = strchr(slash+1, '/')) != NULL) {
 		len = slash - path;
 		memcpy(buf, path, len);
Index: git-hack/commit-tree.c
===================================================================
--- git-hack.orig/commit-tree.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/commit-tree.c	2005-04-26 10:54:18.000000000 -0400
@@ -19,6 +19,8 @@
 static void init_buffer(char **bufp, unsigned int *sizep)
 {
 	char *buf = malloc(BLOCKING);
+	if (!buf)
+		die("Out of memory, malloc failed");
 	*sizep = 0;
 	*bufp = buf;
 }
@@ -41,6 +43,8 @@
 	if (newsize > alloc) {
 		alloc = (newsize + 32767) & ~32767;
 		buf = realloc(buf, alloc);
+		if (!buf)
+			die("Out of memory, realloc failed");
 		*bufp = buf;
 	}
 	*sizep = newsize;
Index: git-hack/commit.c
===================================================================
--- git-hack.orig/commit.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/commit.c	2005-04-26 10:57:21.000000000 -0400
@@ -10,6 +10,8 @@
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
 		struct commit *ret = malloc(sizeof(struct commit));
+		if (!ret)
+			die("Out of memory, malloc failed");
 		memset(ret, 0, sizeof(struct commit));
 		created_object(sha1, &ret->object);
 		ret->object.type = commit_type;
@@ -79,6 +81,8 @@
 void commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = malloc(sizeof(struct commit_list));
+	if (new_list)
+		die("Out of memory, malloc failed");
 	new_list->item = item;
 	new_list->next = *list_p;
 	*list_p = new_list;
Index: git-hack/convert-cache.c
===================================================================
--- git-hack.orig/convert-cache.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/convert-cache.c	2005-04-26 10:58:51.000000000 -0400
@@ -20,6 +20,8 @@
 {
 	struct entry *new = malloc(sizeof(struct entry));
 
+	if (!new)
+		die("Out of memory, malloc failed");
 	memset(new, 0, sizeof(*new));
 	memcpy(new->old_sha1, sha1, 20);
 	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
@@ -72,6 +74,8 @@
 	unsigned long newlen = 0;
 	unsigned long used;
 
+	if (!new)
+		die("Out of memory, malloc failed");
 	used = 0;
 	while (size) {
 		int len = 21 + strlen(buffer);
@@ -229,6 +233,8 @@
 	char *new = malloc(size + 100);
 	unsigned long newlen = 0;
 
+	if (!new)
+		die("Out of memory, malloc failed");
 	// "tree <sha1>\n"
 	memcpy(new + newlen, buffer, 46);
 	newlen += 46;
@@ -284,6 +290,8 @@
 		die("unable to read object %s", sha1_to_hex(sha1));
 
 	buffer = malloc(size);
+	if (!buffer)
+		die("Out of memory, malloc failed");
 	memcpy(buffer, data, size);
 	
 	if (!strcmp(type, "blob")) {
Index: git-hack/diff-tree.c
===================================================================
--- git-hack.orig/diff-tree.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/diff-tree.c	2005-04-26 10:59:51.000000000 -0400
@@ -38,6 +38,8 @@
 {
 	int baselen = strlen(base);
 	char *newbase = malloc(baselen + pathlen + 2);
+	if (!newbase)
+		die("Out of memory, malloc failed");
 	memcpy(newbase, base, baselen);
 	memcpy(newbase + baselen, path, pathlen);
 	memcpy(newbase + baselen + pathlen, "/", 2);
@@ -271,6 +273,8 @@
 		paths = &argv[3];
 		nr_paths = argc - 3;
 		pathlens = malloc(nr_paths * sizeof(int));
+		if (!pathlens)
+			die("Out of memory, malloc failed");
 		for (i=0; i<nr_paths; i++)
 			pathlens[i] = strlen(paths[i]);
 	}
Index: git-hack/http-pull.c
===================================================================
--- git-hack.orig/http-pull.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/http-pull.c	2005-04-26 11:00:26.000000000 -0400
@@ -74,6 +74,8 @@
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 
 	url = malloc(strlen(base) + 50);
+	if (!url)
+		die("Out of memory, malloc failed");
 	strcpy(url, base);
 	posn = url + strlen(base);
 	strcpy(posn, "objects/");
Index: git-hack/init-db.c
===================================================================
--- git-hack.orig/init-db.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/init-db.c	2005-04-26 11:00:43.000000000 -0400
@@ -35,6 +35,8 @@
 	}
 	len = strlen(sha1_dir);
 	path = malloc(len + 40);
+	if (!path)
+		die("Out of memory, malloc failed");
 	memcpy(path, sha1_dir, len);
 
 	safe_create_dir(sha1_dir);
Index: git-hack/object.c
===================================================================
--- git-hack.orig/object.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/object.c	2005-04-26 11:01:14.000000000 -0400
@@ -53,6 +53,8 @@
 	if (obj_allocs == nr_objs) {
 		obj_allocs = alloc_nr(obj_allocs);
 		objs = realloc(objs, obj_allocs * sizeof(struct object *));
+		if (!objs)
+			die("Out of memory, realloc failed");
 	}
 
 	/* Insert it into the right place */
@@ -76,6 +78,8 @@
 
 	target->used = 1;
 	p = malloc(sizeof(*p));
+	if (!p)
+		die("Out of memory, malloc failed");
 	p->item = target;
 	p->next = NULL;
 	*pp = p;
Index: git-hack/read-cache.c
===================================================================
--- git-hack.orig/read-cache.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/read-cache.c	2005-04-26 10:54:23.000000000 -0400
@@ -144,6 +144,8 @@
 	if (active_nr == active_alloc) {
 		active_alloc = alloc_nr(active_alloc);
 		active_cache = realloc(active_cache, active_alloc * sizeof(struct cache_entry *));
+		if (active_cache)
+			die("Out of memory, realloc failed");
 	}
 
 	/* Add it in.. */
Index: git-hack/sha1_file.c
===================================================================
--- git-hack.orig/sha1_file.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/sha1_file.c	2005-04-26 11:01:40.000000000 -0400
@@ -74,6 +74,8 @@
 		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
 		int len = strlen(sha1_file_directory);
 		base = malloc(len + 60);
+		if (!base)
+			die("Out of memory, malloc failed");
 		memcpy(base, sha1_file_directory, len);
 		memset(base+len, 0, 60);
 		base[len] = '/';
@@ -272,6 +274,8 @@
 	deflateInit(&stream, Z_BEST_COMPRESSION);
 	size = deflateBound(&stream, len+hdrlen);
 	compressed = malloc(size);
+	if (!compressed)
+		die("Out of memory, malloc failed");
 
 	/* Compress it */
 	stream.next_out = compressed;
Index: git-hack/show-files.c
===================================================================
--- git-hack.orig/show-files.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/show-files.c	2005-04-26 10:54:23.000000000 -0400
@@ -31,8 +31,12 @@
 	if (nr_dir == dir_alloc) {
 		dir_alloc = alloc_nr(dir_alloc);
 		dir = realloc(dir, dir_alloc*sizeof(char *));
+		if (!dir)
+			die("Out of memory, realloc failed");
 	}
 	name = malloc(len + 1);
+	if (!name)
+		die("Out of memory, malloc failed");
 	memcpy(name, pathname, len + 1);
 	dir[nr_dir++] = name;
 }
Index: git-hack/tree.c
===================================================================
--- git-hack.orig/tree.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/tree.c	2005-04-26 10:54:23.000000000 -0400
@@ -11,6 +11,8 @@
 	unsigned int size = cache_entry_size(baselen + len);
 	struct cache_entry *ce = malloc(size);
 
+	if (!ce)
+		die("Out of memory, malloc failed");
 	memset(ce, 0, size);
 
 	ce->ce_mode = create_ce_mode(mode);
@@ -44,6 +46,8 @@
 			char elttype[20];
 			unsigned long eltsize;
 
+			if (!newbase)
+				die("Out of memory, malloc failed");
 			eltbuf = read_sha1_file(sha1, elttype, &eltsize);
 			if (!eltbuf || strcmp(elttype, "tree"))
 				return -1;
@@ -75,6 +79,8 @@
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
 		struct tree *ret = malloc(sizeof(struct tree));
+		if (!ret)
+			die("Out of memory, malloc failed");
 		memset(ret, 0, sizeof(struct tree));
 		created_object(sha1, &ret->object);
 		ret->object.type = tree_type;
@@ -117,6 +123,8 @@
 			return -1;
 
 		entry = malloc(sizeof(struct tree_entry_list));
+		if (!entry)
+			die("Out of memory, malloc failed");
 		entry->name = strdup(path + 1);
 		entry->directory = S_ISDIR(mode);
 		entry->executable = mode & S_IXUSR;
Index: git-hack/update-cache.c
===================================================================
--- git-hack.orig/update-cache.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/update-cache.c	2005-04-26 11:02:27.000000000 -0400
@@ -41,6 +41,8 @@
 	void *in;
 	SHA_CTX c;
 
+	if (!metadata || !out)
+		die("Out of memory, malloc failed");
 	in = "";
 	if (size)
 		in = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -123,6 +125,8 @@
 	namelen = strlen(path);
 	size = cache_entry_size(namelen);
 	ce = malloc(size);
+	if (!ce)
+		die("Out of memory, malloc failed");
 	memset(ce, 0, size);
 	memcpy(ce->name, path, namelen);
 	fill_stat_cache_info(ce, &st);
@@ -206,6 +210,8 @@
 
 	size = ce_size(ce);
 	updated = malloc(size);
+	if (!updated)
+		die("Out of memory, malloc failed");
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
 	return updated;
@@ -282,6 +288,8 @@
 	len = strlen(arg3);
 	size = cache_entry_size(len);
 	ce = malloc(size);
+	if (!ce)
+		die("Out of memory, malloc failed");
 	memset(ce, 0, size);
 
 	memcpy(ce->sha1, sha1, 20);
Index: git-hack/write-tree.c
===================================================================
--- git-hack.orig/write-tree.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/write-tree.c	2005-04-26 10:54:23.000000000 -0400
@@ -27,6 +27,8 @@
 	/* Guess at some random initial size */
 	size = 8192;
 	buffer = malloc(size);
+	if (!buffer)
+		die("Out of memory, malloc failed");
 	offset = 0;
 
 	nr = 0;
@@ -69,6 +71,8 @@
 		if (offset + entrylen + 100 > size) {
 			size = alloc_nr(offset + entrylen + 100);
 			buffer = realloc(buffer, size);
+			if (!buffer)
+				die("Out of memory, realloc failed");
 		}
 		offset += sprintf(buffer + offset, "%o %.*s", mode, entrylen, filename);
 		buffer[offset++] = 0;
Index: git-hack/revision.h
===================================================================
--- git-hack.orig/revision.h	2005-04-26 10:52:38.000000000 -0400
+++ git-hack/revision.h	2005-04-26 11:05:24.000000000 -0400
@@ -69,9 +69,12 @@
 	if (rev_allocs == nr_revs) {
 		rev_allocs = alloc_nr(rev_allocs);
 		revs = realloc(revs, rev_allocs * sizeof(struct revision *));
+		if (!revs)
+			die("Out of memory, realloc failed")
 	}
 	n = malloc(sizeof(struct revision) + strlen(tag));
-
+	if (!n)
+		die("Out of memory, malloc failed");
 	n->flags = 0;
 	memcpy(n->sha1, sha1, 20);
 	n->parent = NULL;
@@ -97,6 +100,8 @@
 	}
 
 	p = malloc(sizeof(*p));
+	if (!p)
+		die("Out of memory, malloc failed");
 	p->parent = parent_rev;
 	p->next = NULL;
 	*pp = p;
Index: git-hack/diff.c
===================================================================
--- git-hack.orig/diff.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/diff.c	2005-04-26 11:00:06.000000000 -0400
@@ -103,6 +103,8 @@
 	char *cmd = malloc(cmd_size);
 	int next_at = 0;
 
+	if (!cmd)
+		die("Out of memory, malloc failed");
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    diff_cmd, name_sq, name_sq);
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
Index: git-hack/strbuf.c
===================================================================
--- git-hack.orig/strbuf.c	2005-04-26 10:52:47.000000000 -0400
+++ git-hack/strbuf.c	2005-04-26 10:54:23.000000000 -0400
@@ -1,6 +1,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include "strbuf.h"
+#include "cache.h"
 
 void strbuf_init(struct strbuf *sb) {
 	sb->buf = 0;
@@ -16,6 +17,8 @@
 	if (sb->alloc <= sb->len) {
 		sb->alloc = sb->alloc * 3 / 2 + 16;
 		sb->buf = realloc(sb->buf, sb->alloc);
+		if (!sb->buf)
+			die("Out of memory, realloc failed");
 	}
 	sb->buf[sb->len++] = ch;
 }
