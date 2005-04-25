From: Matthias-Christian Ott <matthias.christian@tiscali.de>
Subject: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 13:18:09 +0200
Message-ID: <426CD1F1.2010101@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 13:16:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ1Za-0002QV-DX
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 13:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVDYLVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVDYLVG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 07:21:06 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:9401 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262583AbVDYLS3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 07:18:29 -0400
Received: from [169.254.101.1] (213.54.84.11) by webmail.tiscali.de (7.0.036.1) (authenticated as matthias.christian@tiscali.de)
        id 426359FA0003D7D6; Mon, 25 Apr 2005 13:18:17 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The "git" didn't try store small variables, which aren't referenced, in 
the processor registers. It also didn't use the size_t type. I corrected 
a C++ style comment too.

Signed-off-by: Matthias-Christian Ott <matthias.christian@tiscali.de>

--

diff -Npru git-0.6/check-files.c git-0.6-ott/check-files.c
--- git-0.6/check-files.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/check-files.c	2005-04-24 17:27:17.000000000 +0200
@@ -38,7 +38,7 @@ static void check_file(const char *path)

  int main(int argc, char **argv)
  {
-	int i;
+	register unsigned int i;

  	read_cache();
  	for (i = 1; i < argc ; i++)
diff -Npru git-0.6/checkout-cache.c git-0.6-ott/checkout-cache.c
--- git-0.6/checkout-cache.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/checkout-cache.c	2005-04-24 17:29:59.000000000 +0200
@@ -52,7 +52,7 @@ static void create_directories(const cha

  static int create_file(const char *path, unsigned int mode)
  {
-	int fd;
+	register int fd;

  	mode = (mode & 0100) ? 0777 : 0666;
  	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
@@ -67,10 +67,10 @@ static int create_file(const char *path,

  static int write_entry(struct cache_entry *ce, const char *path)
  {
-	int fd;
+	register int fd;
  	void *new;
  	unsigned long size;
-	long wrote;
+	register long wrote;
  	char type[20];

  	new = read_sha1_file(ce->sha1, type, &size);
@@ -142,7 +142,7 @@ static int checkout_file(const char *nam

  static int checkout_all(const char *base_dir)
  {
-	int i;
+	register unsigned int i;

  	for (i = 0; i < active_nr ; i++) {
  		struct cache_entry *ce = active_cache[i];
@@ -156,7 +156,8 @@ static int checkout_all(const char *base

  int main(int argc, char **argv)
  {
-	int i, force_filename = 0;
+	register unsigned int i;
+	register int force_filename = 0;
  	const char *base_dir = "";

  	if (read_cache() < 0) {
diff -Npru git-0.6/commit.c git-0.6-ott/commit.c
--- git-0.6/commit.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/commit.c	2005-04-24 17:30:31.000000000 +0200
@@ -23,7 +23,7 @@ struct commit *lookup_commit(unsigned ch

  static unsigned long parse_commit_date(const char *buf)
  {
-	unsigned long date;
+	register unsigned long date;

  	if (memcmp(buf, "author", 6))
  		return 0;
diff -Npru git-0.6/commit-tree.c git-0.6-ott/commit-tree.c
--- git-0.6/commit-tree.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/commit-tree.c	2005-04-24 19:57:37.000000000 +0200
@@ -5,6 +5,7 @@
   */
  #include "cache.h"

+#include <stddef.h>
  #include <pwd.h>
  #include <time.h>
  #include <string.h>
@@ -32,7 +33,7 @@ static void add_buffer(char **bufp, unsi
  {
  	char one_line[2048];
  	va_list args;
-	int len;
+	register int len;
  	unsigned long alloc, size, newsize;
  	char *buf;

@@ -64,8 +65,8 @@ static int prepend_integer(char *buffer,

  static void finish_buffer(char *tag, char **bufp, unsigned int *sizep)
  {
-	int taglen;
-	int offset;
+	size_t taglen;
+	register int offset;
  	char *buf = *bufp;
  	unsigned int size = *sizep;

@@ -82,7 +83,7 @@ static void finish_buffer(char *tag, cha

  static void remove_special(char *p)
  {
-	char c;
+	register char c;
  	char *dst = p, *src = p;

  	for (;;) {
@@ -137,7 +138,8 @@ static void parse_rfc2822_date(char *dat
  {
  	struct tm tm;
  	char *p;
-	int i, offset;
+	register unsigned short int i;
+	register int offset;
  	time_t then;

  	memset(&tm, 0, sizeof(tm));
@@ -277,8 +279,9 @@ static char *commit_tree_usage = "commit

  int main(int argc, char **argv)
  {
-	int i, len;
-	int parents = 0;
+	register int i;
+	register size_t len;
+	register unsigned int parents = 0;
  	unsigned char tree_sha1[20];
  	unsigned char parent_sha1[MAXPARENT][20];
  	unsigned char commit_sha1[20];
diff -Npru git-0.6/convert-cache.c git-0.6-ott/convert-cache.c
--- git-0.6/convert-cache.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/convert-cache.c	2005-04-24 17:42:09.000000000 +0200
@@ -1,5 +1,7 @@
  #include "cache.h"

+#include <stddef.h>
+
  struct entry {
  	unsigned char old_sha1[20];
  	unsigned char new_sha1[20];
@@ -29,7 +31,8 @@ static struct entry *insert_new(unsigned

  static struct entry *lookup_entry(unsigned char *sha1)
  {
-	int low = 0, high = nr_convert;
+	register unsigned int low = 0;
+	register int high = nr_convert;

  	while (low < high) {
  		int next = (low + high) / 2;
@@ -70,8 +73,10 @@ static void convert_ascii_sha1(void *buf

  static void convert_tree(void *buffer, unsigned long size)
  {
+	register size_t len;
+	
  	while (size) {
-		int len = 1+strlen(buffer);
+		len = 1+strlen(buffer);

  		convert_binary_sha1(buffer + len);

@@ -98,7 +103,8 @@ static struct entry * convert_entry(unsi
  	struct entry *entry = lookup_entry(sha1);
  	char type[20];
  	void *buffer, *data;
-	unsigned long size, offset;
+	unsigned long size;
+	register unsigned long offset;

  	if (entry->converted)
  		return entry;
diff -Npru git-0.6/diff-cache.c git-0.6-ott/diff-cache.c
--- git-0.6/diff-cache.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/diff-cache.c	2005-04-24 19:59:51.000000000 +0200
@@ -1,5 +1,7 @@
  #include "cache.h"

+#include <stddef.h>
+
  static int cached_only = 0;
  static int recursive = 0;
  static int line_termination = '\n';
@@ -9,8 +11,8 @@ static int diff_cache(void *tree, unsign
  static void update_tree_entry(void **bufp, unsigned long *sizep)
  {
  	void *buf = *bufp;
-	unsigned long size = *sizep;
-	int len = strlen(buf) + 1 + 20;
+	register unsigned long size = *sizep;
+	register size_t len = strlen(buf) + 1 + 20;

  	if (size < len)
  		die("corrupt tree file 1 (%s)", size);
@@ -20,7 +22,7 @@ static void update_tree_entry(void **buf

  static const unsigned char *extract(void *tree, unsigned long size, 
const char **pathp, unsigned int *modep)
  {
-	int len = strlen(tree)+1;
+	register size_t len = strlen(tree)+1;
  	const unsigned char *sha1 = tree + len;
  	const char *path = strchr(tree, ' ');

@@ -84,10 +86,10 @@ static void show_file(const char *prefix
  static int compare_tree_entry(const char *path1, unsigned int mode1, 
const unsigned char *sha1,
  			      struct cache_entry **ac, int *entries, const char *base)
  {
-	int baselen = strlen(base);
+	register size_t baselen = strlen(base);
  	struct cache_entry *ce = *ac;
  	const char *path2 = ce->name + baselen;
-	unsigned int mode2 = ntohl(ce->ce_mode);
+	register unsigned int mode2 = ntohl(ce->ce_mode);
  	const unsigned char *sha2 = ce->sha1;
  	int cmp, pathlen1, pathlen2;
  	char old_sha1_hex[50];
@@ -160,7 +162,7 @@ static int compare_tree_entry(const char

  static int diff_cache(void *tree, unsigned long size, struct 
cache_entry **ac, int entries, const char *base)
  {
-	int baselen = strlen(base);
+	register size_t baselen = strlen(base);

  	for (;;) {
  		struct cache_entry *ce;
diff -Npru git-0.6/diff-tree.c git-0.6-ott/diff-tree.c
--- git-0.6/diff-tree.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/diff-tree.c	2005-04-24 17:48:24.000000000 +0200
@@ -1,5 +1,7 @@
  #include "cache.h"

+#include <stddef.h>
+
  static int recursive = 0;
  static int line_termination = '\n';

@@ -8,8 +10,8 @@ static int diff_tree_sha1(const unsigned
  static void update_tree_entry(void **bufp, unsigned long *sizep)
  {
  	void *buf = *bufp;
-	unsigned long size = *sizep;
-	int len = strlen(buf) + 1 + 20;
+	register unsigned long size = *sizep;
+	register size_t len = strlen(buf) + 1 + 20;

  	if (size < len)
  		die("corrupt tree file");
@@ -19,7 +21,7 @@ static void update_tree_entry(void **buf

  static const unsigned char *extract(void *tree, unsigned long size, 
const char **pathp, unsigned int *modep)
  {
-	int len = strlen(tree)+1;
+	register size_t len = strlen(tree)+1;
  	const unsigned char *sha1 = tree + len;
  	const char *path = strchr(tree, ' ');

@@ -31,7 +33,7 @@ static const unsigned char *extract(void

  static char *malloc_base(const char *base, const char *path, int pathlen)
  {
-	int baselen = strlen(base);
+	register size_t baselen = strlen(base);
  	char *newbase = malloc(baselen + pathlen + 2);
  	memcpy(newbase, base, baselen);
  	memcpy(newbase + baselen, path, pathlen);
@@ -85,7 +87,8 @@ static int compare_tree_entry(void *tree
  	unsigned mode1, mode2;
  	const char *path1, *path2;
  	const unsigned char *sha1, *sha2;
-	int cmp, pathlen1, pathlen2;
+	register int cmp;
+	register size_t pathlen1, pathlen2;
  	char old_sha1_hex[50];

  	sha1 = extract(tree1, size1, &path1, &mode1);
diff -Npru git-0.6/fsck-cache.c git-0.6-ott/fsck-cache.c
--- git-0.6/fsck-cache.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/fsck-cache.c	2005-04-24 17:50:15.000000000 +0200
@@ -14,7 +14,7 @@ static unsigned char head_sha1[20];

  static void check_connectivity(void)
  {
-	int i;
+	register unsigned int i;

  	/* Look up all the requirements, warn about missing objects.. */
  	for (i = 0; i < nr_objs; i++) {
@@ -133,7 +133,7 @@ static int fsck_dir(int i, char *path)

  int main(int argc, char **argv)
  {
-	int i, heads;
+	register unsigned int i, heads;
  	char *sha1_dir;

  	sha1_dir = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
diff -Npru git-0.6/init-db.c git-0.6-ott/init-db.c
--- git-0.6/init-db.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/init-db.c	2005-04-24 19:53:49.000000000 +0200
@@ -24,7 +24,8 @@ void safe_create_dir(char *dir)
  int main(int argc, char **argv)
  {
  	char *sha1_dir, *path;
-	int len, i;
+	register size_t len;
+	register unsigned short int i;

  	safe_create_dir(".git");

diff -Npru git-0.6/merge-cache.c git-0.6-ott/merge-cache.c
--- git-0.6/merge-cache.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/merge-cache.c	2005-04-24 19:59:07.000000000 +0200
@@ -8,7 +8,8 @@ static const char *arguments[5];

  static void run_program(void)
  {
-	int pid = fork(), status;
+	register int pid = fork();
+	int status;

  	if (pid < 0)
  		die("unable to fork");
@@ -27,7 +28,7 @@ static void run_program(void)

  static int merge_entry(int pos, const char *path)
  {
-	int found;
+	register unsigned int found;
  	
  	if (pos >= active_nr)
  		die("merge-cache: %s not in the cache", path);
@@ -56,7 +57,7 @@ static int merge_entry(int pos, const ch

  static void merge_file(const char *path)
  {
-	int pos = cache_name_pos(path, strlen(path));
+	register int pos = cache_name_pos(path, strlen(path));

  	/*
  	 * If it already exists in the cache as stage0, it's
@@ -68,7 +69,7 @@ static void merge_file(const char *path)

  static void merge_all(void)
  {
-	int i;
+	register unsigned int i;
  	for (i = 0; i < active_nr; i++) {
  		struct cache_entry *ce = active_cache[i];
  		if (!ce_stage(ce))
@@ -79,7 +80,7 @@ static void merge_all(void)

  int main(int argc, char **argv)
  {
-	int i, force_file = 0;
+	register unsigned short int i, force_file = 0;

  	if (argc < 3)
  		usage("merge-cache <merge-program> (-a | <filename>*)");
diff -Npru git-0.6/object.c git-0.6-ott/object.c
--- git-0.6/object.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/object.c	2005-04-24 19:51:16.000000000 +0200
@@ -9,7 +9,8 @@ static int obj_allocs;

  static int find_object(unsigned char *sha1)
  {
-	int first = 0, last = nr_objs;
+	register int first = 0;
+	register int last = nr_objs;

          while (first < last) {
                  int next = (first + last) / 2;
diff -Npru git-0.6/read-cache.c git-0.6-ott/read-cache.c
--- git-0.6/read-cache.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/read-cache.c	2005-04-24 20:53:51.000000000 +0200
@@ -3,6 +3,7 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <stddef.h>
  #include <stdarg.h>
  #include "cache.h"

@@ -11,7 +12,7 @@ unsigned int active_nr = 0, active_alloc

  int cache_match_stat(struct cache_entry *ce, struct stat *st)
  {
-	unsigned int changed = 0;
+	register unsigned int changed = 0;

  	if (ce->ce_mtime.sec != htonl(st->st_mtime))
  		changed |= MTIME_CHANGED;
@@ -46,10 +47,10 @@ int cache_match_stat(struct cache_entry

  int cache_name_compare(const char *name1, int flags1, const char 
*name2, int flags2)
  {
-	int len1 = flags1 & CE_NAMEMASK;
-	int len2 = flags2 & CE_NAMEMASK;
-	int len = len1 < len2 ? len1 : len2;
-	int cmp;
+	register int len1 = flags1 & CE_NAMEMASK;
+	register int len2 = flags2 & CE_NAMEMASK;
+	register int len = len1 < len2 ? len1 : len2;
+	register int cmp;

  	cmp = memcmp(name1, name2, len);
  	if (cmp)
@@ -67,7 +68,7 @@ int cache_name_compare(const char *name1

  int cache_name_pos(const char *name, int namelen)
  {
-	int first, last;
+	register unsigned int first, last;

  	first = 0;
  	last = active_nr;
@@ -98,7 +99,7 @@ static int remove_entry_at(int pos)

  int remove_file_from_cache(char *path)
  {
-	int pos = cache_name_pos(path, strlen(path));
+	register int pos = cache_name_pos(path, strlen(path));
  	if (pos < 0)
  		pos = -pos-1;
  	while (pos < active_nr && !strcmp(active_cache[pos]->name, path))
@@ -108,13 +109,13 @@ int remove_file_from_cache(char *path)

  static int same_name(struct cache_entry *a, struct cache_entry *b)
  {
-	int len = ce_namelen(a);
+	register int len = ce_namelen(a);
  	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
  }

  int add_cache_entry(struct cache_entry *ce, int ok_to_add)
  {
-	int pos;
+	register int pos;

  	pos = cache_name_pos(ce->name, htons(ce->ce_flags));

@@ -173,9 +174,11 @@ static int verify_hdr(struct cache_heade

  int read_cache(void)
  {
-	int fd, i;
+	register int fd;
+	register unsigned int i;
  	struct stat st;
-	unsigned long size, offset;
+	register unsigned long size;
+	register size_t offset;
  	void *map;
  	struct cache_header *hdr;

@@ -192,7 +195,7 @@ int read_cache(void)
  	if (fd < 0)
  		return (errno == ENOENT) ? 0 : error("open failed");

-	size = 0; // avoid gcc warning
+	size = 0; /* avoid gcc warning */
  	map = (void *)-1;
  	if (!fstat(fd, &st)) {
  		size = st.st_size;
@@ -254,7 +257,7 @@ static int ce_write(SHA_CTX *context, in

  static int ce_flush(SHA_CTX *context, int fd)
  {
-	unsigned int left = write_buffer_len;
+	register unsigned int left = write_buffer_len;

  	if (left) {
  		write_buffer_len = 0;
@@ -273,7 +276,7 @@ int write_cache(int newfd, struct cache_
  {
  	SHA_CTX c;
  	struct cache_header hdr;
-	int i;
+	register unsigned int i;

  	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
  	hdr.hdr_version = htonl(2);
diff -Npru git-0.6/read-tree.c git-0.6-ott/read-tree.c
--- git-0.6/read-tree.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/read-tree.c	2005-04-24 19:57:05.000000000 +0200
@@ -9,8 +9,8 @@ static int stage = 0;

  static int read_one_entry(unsigned char *sha1, const char *base, int 
baselen, const char *pathname, unsigned mode)
  {
-	int len = strlen(pathname);
-	unsigned int size = cache_entry_size(baselen + len);
+	register size_t len = strlen(pathname);
+	register unsigned int size = cache_entry_size(baselen + len);
  	struct cache_entry *ce = malloc(size);

  	memset(ce, 0, size);
@@ -29,8 +29,10 @@ static int read_tree_recursive(void *buf
  {
  	if (!buffer || strcmp(type, "tree"))
  		return -1;
+	register size_t len;
+	
  	while (size) {
-		int len = strlen(buffer)+1;
+		len = strlen(buffer)+1;
  		unsigned char *sha1 = buffer + len;
  		char *path = strchr(buffer, ' ')+1;
  		unsigned int mode;
@@ -89,7 +91,7 @@ static void remove_lock_file(void)

  static int path_matches(struct cache_entry *a, struct cache_entry *b)
  {
-	int len = ce_namelen(a);
+	register int len = ce_namelen(a);
  	return ce_namelen(b) == len &&
  		!memcmp(a->name, b->name, len);
  }
@@ -113,7 +115,7 @@ static struct cache_entry *merge_entries
  					 struct cache_entry *b,
  					 struct cache_entry *c)
  {
-	int len = ce_namelen(a);
+	register int len = ce_namelen(a);

  	/*
  	 * Are they all the same filename? We won't do
@@ -221,7 +223,8 @@ static char *read_tree_usage = "read-tre

  int main(int argc, char **argv)
  {
-	int i, newfd, merge;
+	register unsigned int i,merge;
+	register int newfd;
  	unsigned char sha1[20];
  	static char lockfile[MAXPATHLEN+1];
  	const char *indexfile = get_index_file();
diff -Npru git-0.6/revision.h git-0.6-ott/revision.h
--- git-0.6/revision.h	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/revision.h	2005-04-24 18:43:36.000000000 +0200
@@ -33,7 +33,8 @@ static int nr_revs, rev_allocs;

  static int find_rev(unsigned char *sha1)
  {
-	int first = 0, last = nr_revs;
+	register unsigned int first = 0;
+	register int last = nr_revs;

  	while (first < last) {
  		int next = (first + last) / 2;
diff -Npru git-0.6/rev-tree.c git-0.6-ott/rev-tree.c
--- git-0.6/rev-tree.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/rev-tree.c	2005-04-24 18:46:47.000000000 +0200
@@ -32,7 +32,7 @@ static void read_cache_file(const char *
   */
  static int interesting(struct commit *rev)
  {
-	unsigned mask = rev->object.flags;
+	register unsigned int mask = rev->object.flags;

  	if (!mask)
  		return 0;
@@ -77,8 +77,8 @@ void process_commit(unsigned char *sha1)
   */
  int main(int argc, char **argv)
  {
-	int i;
-	int nr = 0;
+	register unsigned int i;
+	register unsigned int nr = 0;
  	unsigned char sha1[MAX_COMMITS][20];

  	/*
diff -Npru git-0.6/sha1_file.c git-0.6-ott/sha1_file.c
--- git-0.6/sha1_file.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/sha1_file.c	2005-04-24 20:46:32.000000000 +0200
@@ -6,6 +6,7 @@
   * This handles basic git sha1 object files - packing, unpacking,
   * creation etc.
   */
+#include <stddef.h>
  #include <stdarg.h>
  #include "cache.h"

@@ -24,7 +25,7 @@ static unsigned hexval(char c)

  int get_sha1_hex(const char *hex, unsigned char *sha1)
  {
-	int i;
+	register unsigned int i;
  	for (i = 0; i < 20; i++) {
  		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
  		if (val & ~0xff)
@@ -40,7 +41,7 @@ char * sha1_to_hex(const unsigned char *
  	static char buffer[50];
  	static const char hex[] = "0123456789abcdef";
  	char *buf = buffer;
-	int i;
+	register unsigned short int i;

  	for (i = 0; i < 20; i++) {
  		unsigned int val = *sha1++;
@@ -57,7 +58,7 @@ char * sha1_to_hex(const unsigned char *
   */
  char *sha1_file_name(const unsigned char *sha1)
  {
-	int i;
+	register unsigned short int i;
  	static char *name, *base;

  	if (!base) {
@@ -96,7 +97,7 @@ int check_sha1_signature(unsigned char *
  void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
  {
  	char *filename = sha1_file_name(sha1);
-	int fd = open(filename, O_RDONLY);
+	register int fd = open(filename, O_RDONLY);
  	struct stat st;
  	void *map;

@@ -118,7 +119,7 @@ void *map_sha1_file(const unsigned char

  void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, 
unsigned long *size)
  {
-	int ret, bytes;
+	register int ret, bytes;
  	z_stream stream;
  	char buffer[8192];
  	char *buf;
@@ -173,7 +174,7 @@ void *read_tree_with_tree_or_commit_sha1
  	char type[20];
  	void *buffer;
  	unsigned long isize;
-	int was_commit = 0;
+	register unsigned short int was_commit = 0;
  	unsigned char tree_sha1[20];

  	buffer = read_sha1_file(sha1, type, &isize);
@@ -208,13 +209,13 @@ void *read_tree_with_tree_or_commit_sha1

  int write_sha1_file(char *buf, unsigned len, unsigned char *returnsha1)
  {
-	int size;
+	register size_t size;
  	char *compressed;
  	z_stream stream;
  	unsigned char sha1[20];
  	SHA_CTX c;
  	char *filename;
-	int fd;
+	register int fd;

  	/* Sha1.. */
  	SHA1_Init(&c);
@@ -264,9 +265,9 @@ static inline int collision_check(char *
  {
  #ifdef COLLISION_CHECK
  	void *map;
-	int fd = open(filename, O_RDONLY);
+	register int fd = open(filename, O_RDONLY);
  	struct stat st;
-	int cmp;
+	register int cmp;

  	/* Unreadable object, or object went away? Strange. */
  	if (fd < 0)
@@ -290,7 +291,7 @@ static inline int collision_check(char *
  int write_sha1_buffer(const unsigned char *sha1, void *buf, unsigned 
int size)
  {
  	char *filename = sha1_file_name(sha1);
-	int fd;
+	register int fd;

  	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
  	if (fd < 0) {
diff -Npru git-0.6/show-diff.c git-0.6-ott/show-diff.c
--- git-0.6/show-diff.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/show-diff.c	2005-04-24 19:53:09.000000000 +0200
@@ -38,7 +38,7 @@ static void prepare_diff_cmd(void)
  static char *sq_expand(char *src)
  {
  	static char *buf = NULL;
-	int cnt, c;
+	register int cnt, c;
  	char *cp;

  	/* count bytes needed to store the quoted string. */
@@ -71,7 +71,7 @@ static void show_differences(char *name,
  	int cmd_size = strlen(name_sq) + strlen(label_sq) * 2 +
  		strlen(diff_cmd) + strlen(diff_opts) + strlen(diff_arg);
  	char *cmd = malloc(cmd_size);
-	int next_at;
+	register int next_at;

  	fflush(stdout);
  	next_at = snprintf(cmd, cmd_size, diff_cmd, label_sq, label_sq);
@@ -106,7 +106,7 @@ static const char *show_diff_usage = "sh

  static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
  {
-	int i;
+	register int i;
  	int namelen = ce_namelen(ce);
  	for (i = 0; i < cnt; i++) {
  		int speclen = strlen(spec[i]);
@@ -121,12 +121,12 @@ static int matches_pathspec(struct cache

  int main(int argc, char **argv)
  {
-	int silent = 0;
-	int silent_on_nonexisting_files = 0;
-	int machine_readable = 0;
-	int reverse = 0;
-	int entries = read_cache();
-	int i;
+	register unsigned short int silent = 0;
+	register unsigned short int silent_on_nonexisting_files = 0;
+	register unsigned short int machine_readable = 0;
+	register unsigned short int reverse = 0;
+	register int entries = read_cache();
+	register int i;

  	while (1 < argc && argv[1][0] == '-') {
  		if  (!strcmp(argv[1], "-R"))
@@ -153,7 +153,7 @@ int main(int argc, char **argv)
  	for (i = 0; i < entries; i++) {
  		struct stat st;
  		struct cache_entry *ce = active_cache[i];
-		int changed;
+		register unsigned short int changed;
  		unsigned long size;
  		char type[20];
  		void *old;
diff -Npru git-0.6/show-files.c git-0.6-ott/show-files.c
--- git-0.6/show-files.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/show-files.c	2005-04-24 19:08:07.000000000 +0200
@@ -5,6 +5,7 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <stddef.h>
  #include <dirent.h>

  #include "cache.h"
@@ -91,14 +92,14 @@ static int cmp_name(const void *p1, cons
  {
  	const char *n1 = *(const char **)p1;
  	const char *n2 = *(const char **)p2;
-	int l1 = strlen(n1), l2 = strlen(n2);
+	register size_t l1 = strlen(n1), l2 = strlen(n2);

  	return cache_name_compare(n1, l1, n2, l2);
  }

  static void show_files(void)
  {
-	int i;
+	register unsigned int i;

  	/* For cached/deleted files we don't need to even do the readdir */
  	if (show_others | show_ignored) {
@@ -142,7 +143,7 @@ static void show_files(void)

  int main(int argc, char **argv)
  {
-	int i;
+	register unsigned int i;

  	for (i = 1; i < argc; i++) {
  		char *arg = argv[i];
diff -Npru git-0.6/tree.c git-0.6-ott/tree.c
--- git-0.6/tree.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/tree.c	2005-04-24 19:52:40.000000000 +0200
@@ -1,6 +1,7 @@
  #include "tree.h"
  #include "blob.h"
  #include "cache.h"
+#include <stddef.h>
  #include <stdlib.h>

  const char *tree_type = "tree";
@@ -40,7 +41,7 @@ int parse_tree(struct tree *item)
  			     sha1_to_hex(item->object.sha1));
  	while (size) {
  		struct object *obj;
-		int len = 1+strlen(bufptr);
+		size_t len = 1+strlen(bufptr);
  		unsigned char *file_sha1 = bufptr + len;
  		char *path = strchr(bufptr, ' ');
  		unsigned int mode;
diff -Npru git-0.6/unpack-file.c git-0.6-ott/unpack-file.c
--- git-0.6/unpack-file.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/unpack-file.c	2005-04-24 19:11:17.000000000 +0200
@@ -6,7 +6,7 @@ static char *create_temp_file(unsigned c
  	void *buf;
  	char type[100];
  	unsigned long size;
-	int fd;
+	register int fd;

  	buf = read_sha1_file(sha1, type, &size);
  	if (!buf || strcmp(type, "blob"))
diff -Npru git-0.6/update-cache.c git-0.6-ott/update-cache.c
--- git-0.6/update-cache.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/update-cache.c	2005-04-24 19:46:03.000000000 +0200
@@ -3,6 +3,8 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <stddef.h>
+
  #include "cache.h"

  /*
@@ -17,11 +19,11 @@ static int allow_add = 0, allow_remove =
  static int index_fd(unsigned char *sha1, int fd, struct stat *st)
  {
  	z_stream stream;
-	unsigned long size = st->st_size;
-	int max_out_bytes = size + 200;
+	register unsigned long size = st->st_size;
+	register int max_out_bytes = size + 200;
  	void *out = malloc(max_out_bytes);
  	void *metadata = malloc(200);
-	int metadata_size;
+	register int metadata_size;
  	void *in;
  	SHA_CTX c;

@@ -87,10 +89,11 @@ static void fill_stat_cache_info(struct

  static int add_file_to_cache(char *path)
  {
-	int size, namelen;
+	register int size;
+	register size_t namelen;
  	struct cache_entry *ce;
  	struct stat st;
-	int fd;
+	register int fd;

  	fd = open(path, O_RDONLY);
  	if (fd < 0) {
@@ -123,7 +126,7 @@ static int match_data(int fd, void *buff
  {
  	while (size) {
  		char compare[1024];
-		int ret = read(fd, compare, sizeof(compare));
+		register int ret = read(fd, compare, sizeof(compare));

  		if (ret <= 0 || ret > size || memcmp(buffer, compare, ret))
  			return -1;
@@ -135,8 +138,8 @@ static int match_data(int fd, void *buff

  static int compare_data(struct cache_entry *ce, unsigned long 
expected_size)
  {
-	int match = -1;
-	int fd = open(ce->name, O_RDONLY);
+	register int match = -1;
+	register int fd = open(ce->name, O_RDONLY);

  	if (fd >= 0) {
  		void *buffer;
@@ -169,7 +172,7 @@ static struct cache_entry *refresh_entry
  {
  	struct stat st;
  	struct cache_entry *updated;
-	int changed, size;
+	register int changed, size;

  	if (stat(ce->name, &st) < 0)
  		return NULL;
@@ -197,7 +200,7 @@ static struct cache_entry *refresh_entry

  static void refresh_cache(void)
  {
-	int i;
+	register unsigned int i;

  	for (i = 0; i < active_nr; i++) {
  		struct cache_entry *ce, *new;
@@ -231,7 +234,7 @@ static void refresh_cache(void)
   */
  static int verify_path(char *path)
  {
-	char c;
+	register char c;

  	goto inside;
  	for (;;) {
@@ -250,7 +253,8 @@ inside:

  static int add_cacheinfo(char *arg1, char *arg2, char *arg3)
  {
-	int size, len;
+	register int size;
+	register size_t len;
  	unsigned int mode;
  	unsigned char sha1[20];
  	struct cache_entry *ce;
@@ -284,8 +288,8 @@ static void remove_lock_file(void)

  int main(int argc, char **argv)
  {
-	int i, newfd, entries;
-	int allow_options = 1;
+	register int i, newfd, entries;
+	register unsigned short int allow_options = 1;
  	static char lockfile[MAXPATHLEN+1];
  	const char *indexfile = get_index_file();

diff -Npru git-0.6/write-tree.c git-0.6-ott/write-tree.c
--- git-0.6/write-tree.c	2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-ott/write-tree.c	2005-04-24 19:22:22.000000000 +0200
@@ -8,7 +8,7 @@
  static int check_valid_sha1(unsigned char *sha1)
  {
  	char *filename = sha1_file_name(sha1);
-	int ret;
+	register int ret;

  	/* If we were anal, we'd check that the sha1 of the contents actually 
matches */
  	ret = access(filename, R_OK);
@@ -32,9 +32,9 @@ static int prepend_integer(char *buffer,
  static int write_tree(struct cache_entry **cachep, int maxentries, 
const char *base, int baselen, unsigned char *returnsha1)
  {
  	unsigned char subdir_sha1[20];
-	unsigned long size, offset;
+	register unsigned long size, offset;
  	char *buffer;
-	int i, nr;
+	register int i, nr;

  	/* Guess at some random initial size */
  	size = 8192;
@@ -100,8 +100,8 @@ static int write_tree(struct cache_entry

  int main(int argc, char **argv)
  {
-	int i, unmerged;
-	int entries = read_cache();
+	register int i, unmerged;
+	register int entries = read_cache();
  	unsigned char sha1[20];

  	if (entries <= 0)
