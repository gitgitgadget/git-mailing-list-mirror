From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 11:22:35 -0400
Message-ID: <200504201122.35448.mason@suse.com>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com> <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7OnZCRaKIqr8pZx"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 17:20:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOGys-0007MO-Tr
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVDTPXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVDTPXZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:23:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:50586 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261657AbVDTPWl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 11:22:41 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 857A616096F1;
	Wed, 20 Apr 2005 17:22:38 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_7OnZCRaKIqr8pZx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 20 April 2005 02:43, Linus Torvalds wrote:
> On Tue, 19 Apr 2005, Chris Mason wrote:
> > I'll finish off the patch once you ok the basics below.  My current code
> > works like this:
>
> Chris, before you do anything further, let me re-consider.
>
> Assuming that the real cost of write-tree is the compression (and I think
> it is), I really suspect that this ends up being the death-knell to my
> "use the sha1 of the _compressed_ object" approach. 

Thanks for looking at this.  Your new tree is faster, it gets the commit 100 
patches time down from 1m5s to 50s.  I've attached my patch from last night, 
which is mostly a rough guess of the changes we would need, I haven't 
validated or cleaned things up.

With the basic changes I described before, the  100 patch time only goes down 
to 40s.  Certainly not fast enough to justify the changes.  In this case, the 
bulk of the extra time comes from write-tree writing the index file, so I 
split write-tree.c up into libwrite-tree.c, and created update-cache 
--write-tree.

This gets our time back down to 21s.

The attached patch is not against your latest revs.  After updating I would 
need to sprinkle a few S_ISDIR checks into diff-cache.c and checkout-cache.c, 
but the changes should be small.

-chris

--Boundary-00=_7OnZCRaKIqr8pZx
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fast-dirs-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fast-dirs-3.diff"

Index: Makefile
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/Makefile  (mode:100644 sha1:6a04941a337ec50da06cf4cf52aa58f3b1435776)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/Makefile  (mode:100644 sha1:2ba6d49196e8a2335cfcd77ec0dbe9cda3e402dd)
@@ -29,7 +29,7 @@
 
 VERSION= VERSION
 
-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
+LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o libwrite-tree.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h
 
Index: cache.h
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/cache.h  (mode:100644 sha1:c182ea0c5c1def37d899f9a05f8884ebe17c9d92)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/cache.h  (mode:100644 sha1:0882b713222b71e67c9dab5d58ab6f15c3c49ed6)
@@ -74,7 +74,7 @@
 #define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
 
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
-#define create_ce_mode(mode) htonl(S_IFREG | ce_permissions(mode))
+#define create_ce_mode(mode) htonl((mode & (S_IFREG|S_IFDIR)) | ce_permissions(mode))
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 
Index: libwrite-tree.c
===================================================================
--- /dev/null  (tree:dbeacafeb442bcfd39dfdc90c360d47d4215c185)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/libwrite-tree.c  (mode:100644 sha1:52202930d02b3721f5a388ae1178c5a4d99ec1b4)
@@ -0,0 +1,174 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include "cache.h"
+
+struct new_ce {
+	struct new_ce *next;
+	struct cache_entry ce;
+};
+
+static struct new_ce *add_list = NULL;
+
+static int check_valid_sha1(unsigned char *sha1)
+{
+	char *filename = sha1_file_name(sha1);
+	int ret;
+
+	/* If we were anal, we'd check that the sha1 of the contents actually matches */
+	ret = access(filename, R_OK);
+	if (ret)
+		perror(filename);
+	return ret;
+}
+
+static int prepend_integer(char *buffer, unsigned val, int i)
+{
+	buffer[--i] = '\0';
+	do {
+		buffer[--i] = '0' + (val % 10);
+		val /= 10;
+	} while (val);
+	return i;
+}
+
+#define ORIG_OFFSET (40)	/* Enough space to add the header of "tree <size>\0" */
+
+static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
+{
+	unsigned char subdir_sha1[20];
+	unsigned long size, offset;
+	char *buffer;
+	int i, nr;
+
+	/* Guess at some random initial size */
+	size = 8192;
+	buffer = malloc(size);
+	offset = ORIG_OFFSET;
+
+	nr = 0;
+	do {
+		struct cache_entry *ce = cachep[nr];
+		const char *pathname = ce->name, *filename, *dirname;
+		int pathlen = ce_namelen(ce), entrylen;
+		unsigned char *sha1;
+		unsigned int mode;
+
+		/* Did we hit the end of the directory? Return how many we wrote */
+		if (baselen >= pathlen || memcmp(base, pathname, baselen))
+			break;
+
+		sha1 = ce->sha1;
+		mode = ntohl(ce->ce_mode);
+
+		/* Do we have _further_ subdirectories? */
+		filename = pathname + baselen;
+		dirname = strchr(filename, '/');
+		if (dirname) {
+			int subdir_written;
+			int len = dirname - pathname;
+			unsigned int size = cache_entry_size(len);
+			struct new_ce *new_ce = malloc(size + sizeof(struct new_ce *));
+			struct cache_entry *c = &new_ce->ce;
+			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
+			nr += subdir_written - 1;
+
+			/* Now we need to write out the directory entry into this tree.. */
+			mode = S_IFDIR;
+			pathlen = dirname - pathname;
+
+			sha1 = subdir_sha1;
+
+			memset(c, 0, size);
+
+			/* create a new cache entry for what we just calculated.
+			 * place the new entry on a list for adding later so we
+			 * don't change the size of the cache right now.
+			 */
+			c->ce_mode = create_ce_mode(mode);
+			c->ce_flags = create_ce_flags(len, 0);
+			memcpy(c->name, pathname, len);
+			c->name[len] = '\0';
+			memcpy(c->sha1, sha1, 20);
+			new_ce->next = add_list;
+			add_list = new_ce;
+		} else if (mode & S_IFDIR) {
+			/* eat all the entries below this directory */
+			while(++nr < maxentries) {
+				struct cache_entry *c = cachep[nr];
+				
+				if (strlen(c->name) < pathlen)
+					break;
+				if (memcmp(c->name, pathname, pathlen) ||
+				    c->name[pathlen] != '/')
+					break;
+			}
+			/* our loop went too far by 1 */
+			nr--;
+			mode = S_IFDIR;
+		}
+
+		if (check_valid_sha1(sha1) < 0)
+			exit(1);
+
+		entrylen = pathlen - baselen;
+		if (offset + entrylen + 100 > size) {
+			size = alloc_nr(offset + entrylen + 100);
+			buffer = realloc(buffer, size);
+		}
+		offset += sprintf(buffer + offset, "%o %.*s", mode, entrylen, filename);
+		buffer[offset++] = 0;
+		memcpy(buffer + offset, sha1, 20);
+		offset += 20;
+		nr++;
+	} while (nr < maxentries);
+
+	i = prepend_integer(buffer, offset - ORIG_OFFSET, ORIG_OFFSET);
+	i -= 5;
+	memcpy(buffer+i, "tree ", 5);
+
+	write_sha1_file(buffer + i, offset - i, returnsha1);
+	free(buffer);
+	return nr;
+}
+
+void write_full_tree(int entries) {
+	unsigned char sha1[20];
+	int i, unmerged;
+
+	if (entries <= 0)
+		die("write-tree: no cache contents to write");
+
+	/* Verify that the tree is merged */
+	unmerged = 0;
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
+			if (++unmerged > 10) {
+				fprintf(stderr, "...\n");
+				break;
+			}
+			fprintf(stderr, "%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
+		}
+	}
+	if (unmerged)
+		die("write-tree: not able to write tree");
+
+	/* Ok, write it out */
+	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
+		die("write-tree: internal error");
+	printf("%s\n", sha1_to_hex(sha1));
+	if (add_list) {
+		struct new_ce *nc = add_list;
+		while(nc) {
+			add_cache_entry(&nc->ce, 1);
+			nc = nc->next;
+		}
+	}
+}
+
+int write_tree_updated_cache(void) {
+	return add_list != NULL;
+}
Index: merge-cache.c
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/merge-cache.c  (mode:100644 sha1:96c86c26d06837bf604a70caf9dd2133884a63bc)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/merge-cache.c  (mode:100644 sha1:1b45bfc8cf5b4c610a4b149f3a4295081bc0e00f)
@@ -63,8 +63,16 @@
 	 * If it already exists in the cache as stage0, it's
 	 * already merged and there is nothing to do.
 	 */
-	if (pos < 0)
-		merge_entry(-pos-1, path);
+	if (pos < 0) {
+		pos = -pos-1;
+		while(pos > 0) {
+			int mode = htonl(active_cache[pos]->ce_mode);
+			if (S_ISREG(mode))
+				break;
+			pos--;
+		}
+		merge_entry(pos, path);
+	}
 }
 
 static void merge_all(void)
@@ -74,7 +82,8 @@
 		struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		i += merge_entry(i, ce->name)-1;
+		if (S_ISREG(htonl(ce->ce_mode)))
+			i += merge_entry(i, ce->name)-1;
 	}
 }
 
Index: read-cache.c
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/read-cache.c  (mode:100644 sha1:17d4d2284e79d3f1070b51200d797115f2d09d6a)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/read-cache.c  (mode:100644 sha1:d2fc8e35f5ef602f7baa1a4c83c74dbf373fc3e0)
@@ -96,11 +96,30 @@
 	return 1;
 }
 
+static void invalidate_trees(char *path) {
+	char *p;
+	int len = strlen(path);
+	int pos;
+	extern void *memrchr(__const void *, int, size_t);
+	while(1) {
+		p = memrchr(path, '/', len);
+		if (!p || p == path)
+			return;
+		len = p-path;
+		pos = cache_name_pos(path, len);
+		if (pos < 0)
+			return;
+		remove_entry_at(pos);
+	}	
+}
+
 int remove_file_from_cache(char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
-	if (pos >= 0)
+	if (pos >= 0) {
 		remove_entry_at(pos);
+		invalidate_trees(path);
+	}
 	return 0;
 }
 
@@ -113,12 +132,16 @@
 int add_cache_entry(struct cache_entry *ce, int ok_to_add)
 {
 	int pos;
+	int invalidate = S_ISREG(htonl(ce->ce_mode));
 
 	pos = cache_name_pos(ce->name, htons(ce->ce_flags));
 
 	/* existing match? Just replace it */
 	if (pos >= 0) {
 		active_cache[pos] = ce;
+		if (invalidate) {
+			invalidate_trees(ce->name);
+		}
 		return 0;
 	}
 	pos = -pos-1;
@@ -149,6 +172,9 @@
 	if (active_nr > pos)
 		memmove(active_cache + pos + 1, active_cache + pos, (active_nr - pos - 1) * sizeof(ce));
 	active_cache[pos] = ce;
+	if (invalidate) {
+		invalidate_trees(ce->name);
+	}
 	return 0;
 }
 
Index: read-tree.c
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/read-tree.c  (mode:100644 sha1:a573a3155e532081a8be0dab60f1ec35ea159ddf)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/read-tree.c  (mode:100644 sha1:fa497650937a62caadd043897032cf5f9e07dea2)
@@ -63,7 +63,6 @@
 				free(buffer);
 				return -1;
 			}
-			continue;
 		}
 		if (read_one_entry(sha1, base, baselen, path, mode) < 0) {
 			free(buffer);
Index: show-diff.c
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/show-diff.c  (mode:100644 sha1:007dabd2978de4c58f49050d3969ca353278dbb6)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/show-diff.c  (mode:100644 sha1:a7b0a0bca00c173f591a0d8ef0dfbcbdd96ef8a9)
@@ -163,6 +163,8 @@
 		if (1 < argc &&
 		    ! matches_pathspec(ce, argv+1, argc-1))
 			continue;
+		if (S_ISDIR(htonl(ce->ce_mode)))
+			continue;
 		matched++;
 
 		if (ce_stage(ce)) {
Index: update-cache.c
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/update-cache.c  (mode:100644 sha1:11388582a830a6161d1c769aa8616bed6f593b8a)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/update-cache.c  (mode:100644 sha1:cab4e8e1fa7aceff287cfb3464710b1dd52f3a5f)
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "write-tree.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -12,7 +13,7 @@
  * like "update-cache *" and suddenly having all the object
  * files be revision controlled.
  */
-static int allow_add = 0, allow_remove = 0;
+static int allow_add = 0, allow_remove = 0, write_tree = 0;
 
 static int index_fd(unsigned char *sha1, int fd, struct stat *st)
 {
@@ -182,7 +183,6 @@
 
 	if (stat(ce->name, &st) < 0)
 		return NULL;
-
 	changed = cache_match_stat(ce, &st);
 	if (!changed)
 		return ce;
@@ -191,12 +191,11 @@
 	 * If the mode has changed, there's no point in trying
 	 * to refresh the entry - it's not going to match
 	 */
-	if (changed & MODE_CHANGED)
+	if (changed & MODE_CHANGED) {
 		return NULL;
-
+	}
 	if (compare_data(ce, st.st_size))
 		return NULL;
-
 	size = ce_size(ce);
 	updated = malloc(size);
 	memcpy(updated, ce, size);
@@ -222,7 +221,8 @@
 
 		new = refresh_entry(ce);
 		if (!new) {
-			printf("%s: needs update\n", ce->name);
+			if (S_ISREG(ntohl(ce->ce_mode)))
+				printf("%s: needs update\n", ce->name);
 			continue;
 		}
 		/* You can NOT just free active_cache[i] here, since it
@@ -336,6 +336,10 @@
 				i += 3;
 				continue;
 			}
+			if (!strcmp(path, "--write-tree")) {
+				write_tree = 1;
+				continue;
+			}
 			die("unknown option %s", path);
 		}
 		if (!verify_path(path)) {
@@ -345,6 +349,9 @@
 		if (add_file_to_cache(path))
 			die("Unable to add %s to database", path);
 	}
+	if (write_tree) {
+		write_full_tree(active_nr);
+	}
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    rename(".git/index.lock", ".git/index"))
 		die("Unable to write new cachefile");
Index: write-tree.c
===================================================================
--- dbeacafeb442bcfd39dfdc90c360d47d4215c185/write-tree.c  (mode:100644 sha1:fb046aa6ce6b9fce6a523a1e36ff43adab9bdd93)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/write-tree.c  (mode:100644 sha1:c3d62242f0d5fff0c245cd46ac8a5b72d4aef4cd)
@@ -4,127 +4,28 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
-
-static int check_valid_sha1(unsigned char *sha1)
-{
-	char *filename = sha1_file_name(sha1);
-	int ret;
-
-	/* If we were anal, we'd check that the sha1 of the contents actually matches */
-	ret = access(filename, R_OK);
-	if (ret)
-		perror(filename);
-	return ret;
-}
-
-static int prepend_integer(char *buffer, unsigned val, int i)
-{
-	buffer[--i] = '\0';
-	do {
-		buffer[--i] = '0' + (val % 10);
-		val /= 10;
-	} while (val);
-	return i;
-}
-
-#define ORIG_OFFSET (40)	/* Enough space to add the header of "tree <size>\0" */
-
-static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
-{
-	unsigned char subdir_sha1[20];
-	unsigned long size, offset;
-	char *buffer;
-	int i, nr;
-
-	/* Guess at some random initial size */
-	size = 8192;
-	buffer = malloc(size);
-	offset = ORIG_OFFSET;
-
-	nr = 0;
-	do {
-		struct cache_entry *ce = cachep[nr];
-		const char *pathname = ce->name, *filename, *dirname;
-		int pathlen = ce_namelen(ce), entrylen;
-		unsigned char *sha1;
-		unsigned int mode;
-
-		/* Did we hit the end of the directory? Return how many we wrote */
-		if (baselen >= pathlen || memcmp(base, pathname, baselen))
-			break;
-
-		sha1 = ce->sha1;
-		mode = ntohl(ce->ce_mode);
-
-		/* Do we have _further_ subdirectories? */
-		filename = pathname + baselen;
-		dirname = strchr(filename, '/');
-		if (dirname) {
-			int subdir_written;
-
-			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
-			nr += subdir_written;
-
-			/* Now we need to write out the directory entry into this tree.. */
-			mode = S_IFDIR;
-			pathlen = dirname - pathname;
-
-			/* ..but the directory entry doesn't count towards the total count */
-			nr--;
-			sha1 = subdir_sha1;
-		}
-
-		if (check_valid_sha1(sha1) < 0)
-			exit(1);
-
-		entrylen = pathlen - baselen;
-		if (offset + entrylen + 100 > size) {
-			size = alloc_nr(offset + entrylen + 100);
-			buffer = realloc(buffer, size);
-		}
-		offset += sprintf(buffer + offset, "%o %.*s", mode, entrylen, filename);
-		buffer[offset++] = 0;
-		memcpy(buffer + offset, sha1, 20);
-		offset += 20;
-		nr++;
-	} while (nr < maxentries);
-
-	i = prepend_integer(buffer, offset - ORIG_OFFSET, ORIG_OFFSET);
-	i -= 5;
-	memcpy(buffer+i, "tree ", 5);
-
-	write_sha1_file(buffer + i, offset - i, returnsha1);
-	free(buffer);
-	return nr;
-}
+#include "write-tree.h"
 
 int main(int argc, char **argv)
 {
-	int i, unmerged;
 	int entries = read_cache();
-	unsigned char sha1[20];
+	int newfd;
+	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (newfd < 0)
+		die("unable to create new cachefile");
+
 
 	if (entries <= 0)
 		die("write-tree: no cache contents to write");
 
-	/* Verify that the tree is merged */
-	unmerged = 0;
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
-			if (++unmerged > 10) {
-				fprintf(stderr, "...\n");
-				break;
-			}
-			fprintf(stderr, "%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
-		}
+	write_full_tree(entries);
+	if (write_tree_updated_cache()) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    rename(".git/index.lock", ".git/index"))
+			die("Unable to write new cachefile");
+	} else {
+		close(newfd);
+		unlink(".git/index.lock");
 	}
-	if (unmerged)
-		die("write-tree: not able to write tree");
-
-	/* Ok, write it out */
-	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
-		die("write-tree: internal error");
-	printf("%s\n", sha1_to_hex(sha1));
 	return 0;
 }
Index: write-tree.h
===================================================================
--- /dev/null  (tree:dbeacafeb442bcfd39dfdc90c360d47d4215c185)
+++ 27e71cd40ff1dccfbbd996427833fd7bac714dde/write-tree.h  (mode:100644 sha1:0ad5fe36126577e56544e08e0f4dfa766350e841)
@@ -0,0 +1,3 @@
+
+void write_full_tree(int);
+int write_tree_updated_cache(void);

--Boundary-00=_7OnZCRaKIqr8pZx--
