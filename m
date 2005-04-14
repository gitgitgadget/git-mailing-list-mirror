From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] cleanup: read_sha1_file() -> malloc_read_sha1_file()
Date: Thu, 14 Apr 2005 14:23:52 +0200
Message-ID: <20050414122352.GA15049@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414121819.GA14380@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 14:22:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM3LN-00007F-NV
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVDNMYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDNMYd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:24:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19948 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261486AbVDNMYU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:24:20 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 1632D320170;
	Thu, 14 Apr 2005 14:23:20 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 34B411FC2; Thu, 14 Apr 2005 14:23:55 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414121819.GA14380@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


this patch renames read_sha1_file() to malloc_read_sha1_file().

There were a handful of memory-leaks related to read_sha1_file(), and 
some of those could possibly have been found sooner if the name 
indicated that an implicit malloc() is occurs within read_sha1_file().  
This patch is ontop of the previous patches i sent.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- cat-file.c.orig
+++ cat-file.c
@@ -14,7 +14,7 @@ int main(int argc, char **argv)
 
 	if (argc != 3 || get_sha1_hex(argv[2], sha1))
 		usage("cat-file [-t | tagname] <sha1>");
-	buf = read_sha1_file(sha1, type, &size);
+	buf = malloc_read_sha1_file(sha1, type, &size);
 	if (!buf)
 		die("cat-file %s: bad file", argv[2]);
 	if (!strcmp("-t", argv[1])) {
--- merge-tree.c.orig
+++ merge-tree.c
@@ -11,7 +11,7 @@ static struct tree_entry *read_tree(unsi
 {
 	char type[20];
 	unsigned long size;
-	void *buf = read_sha1_file(sha1, type, &size);
+	void *buf = malloc_read_sha1_file(sha1, type, &size);
 	struct tree_entry *ret = NULL, **tp = &ret;
 
 	if (!buf || strcmp(type, "tree"))
--- diff-tree.c.orig
+++ diff-tree.c
@@ -62,7 +62,7 @@ static void show_file(const char *prefix
 		char *newbase = malloc_base(base, path, strlen(path));
 		void *tree;
 
-		tree = read_sha1_file(sha1, type, &size);
+		tree = malloc_read_sha1_file(sha1, type, &size);
 		if (!tree || strcmp(type, "tree"))
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
@@ -164,10 +164,10 @@ static int diff_tree_sha1(const unsigned
 	char type[20];
 	int retval;
 
-	tree1 = read_sha1_file(old, type, &size1);
+	tree1 = malloc_read_sha1_file(old, type, &size1);
 	if (!tree1 || strcmp(type, "tree"))
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_sha1_file(new, type, &size2);
+	tree2 = malloc_read_sha1_file(new, type, &size2);
 	if (!tree2 || strcmp(type, "tree"))
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	retval = diff_tree(tree1, size1, tree2, size2, base);
--- show-diff.c.orig
+++ show-diff.c
@@ -25,7 +25,7 @@ static void show_diff_empty(struct cache
 	int lines=0;
 	unsigned char type[20], *p, *end;
 
-	old = read_sha1_file(ce->sha1, type, &size);
+	old = malloc_read_sha1_file(ce->sha1, type, &size);
 	if (size > 0) {
 		int startline = 1;
 		int c = 0;
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 		if (silent)
 			continue;
 
-		new = read_sha1_file(ce->sha1, type, &size);
+		new = malloc_read_sha1_file(ce->sha1, type, &size);
 		show_differences(ce->name, new, size);
 		free(new);
 	}
--- read-cache.c.orig
+++ read-cache.c
@@ -183,7 +183,7 @@ void * unpack_sha1_file(void *map, unsig
 	return buf;
 }
 
-void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
+void * malloc_read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
--- update-cache.c.orig
+++ update-cache.c
@@ -141,7 +141,7 @@ static int compare_data(struct cache_ent
 		unsigned long size;
 		char type[20];
 
-		buffer = read_sha1_file(ce->sha1, type, &size);
+		buffer = malloc_read_sha1_file(ce->sha1, type, &size);
 		if (buffer) {
 			if (size == expected_size && !strcmp(type, "blob"))
 				match = match_data(fd, buffer, size);
--- ls-tree.c.orig
+++ ls-tree.c
@@ -11,7 +11,7 @@ static int list(unsigned char *sha1)
 	unsigned long size;
 	char type[20];
 
-	buffer = read_sha1_file(sha1, type, &size);
+	buffer = malloc_read_sha1_file(sha1, type, &size);
 	if (!buffer)
 		die("unable to read sha1 file");
 	if (strcmp(type, "tree"))
--- checkout-cache.c.orig
+++ checkout-cache.c
@@ -72,7 +72,7 @@ static int write_entry(struct cache_entr
 	long wrote;
 	char type[20];
 
-	new = read_sha1_file(ce->sha1, type, &size);
+	new = malloc_read_sha1_file(ce->sha1, type, &size);
 	if (!new || strcmp(type, "blob")) {
 		if (new)
 			free(new);
--- cache.h.orig
+++ cache.h
@@ -95,7 +95,7 @@ extern int write_sha1_buffer(const unsig
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
-extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
+extern void * malloc_read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(char *buf, unsigned len, unsigned char *return_sha1);
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size);
 
--- rev-tree.c.orig
+++ rev-tree.c
@@ -73,7 +73,7 @@ static int parse_commit(unsigned char *s
 		unsigned char parent[20];
 
 		rev->flags |= SEEN;
-		buffer = bufptr = read_sha1_file(sha1, type, &size);
+		buffer = bufptr = malloc_read_sha1_file(sha1, type, &size);
 		if (!buffer || strcmp(type, "commit")) {
 			if (buffer)
 				free(buffer);
--- read-tree.c.orig
+++ read-tree.c
@@ -27,7 +27,7 @@ static int read_tree(unsigned char *sha1
 	unsigned long size;
 	char type[20];
 
-	buffer0 = buffer = read_sha1_file(sha1, type, &size);
+	buffer0 = buffer = malloc_read_sha1_file(sha1, type, &size);
 	if (!buffer)
 		return -1;
 	if (strcmp(type, "tree")) {

