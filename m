From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] multi item packed files
Date: Mon, 25 Apr 2005 18:20:57 -0400
Message-ID: <200504251820.58985.mason@suse.com>
References: <200504211113.13630.mason@suse.com> <200504221632.26278.mason@suse.com> <200504221955.15422.mason@suse.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_K1WbCVvpFaJg0OU"
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 00:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBu4-0000ch-8X
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDYWXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVDYWXH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:23:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:37511 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261248AbVDYWVF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 18:21:05 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 76B81160B787;
	Tue, 26 Apr 2005 00:21:04 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <200504221955.15422.mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_K1WbCVvpFaJg0OU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 22 April 2005 19:55, Chris Mason wrote:
> On Friday 22 April 2005 16:32, Chris Mason wrote:
> > If I pack every 64k (uncompressed), the checkout-tree time goes down to
> > 3m14s. That's a very big difference considering how stupid my code is 
> > .git was only 20% smaller with 64k chunks.  I should be able to do
> > better...I'll do one more run.
>
> This run also packed tree files together (everything produced by write-tree
> went into a packed file), but not the commits.  I estimate I could save
> about another 168m by packing the tree files and commits into the same file
> with the blobs, but this wouldn't make any of the times below faster.
>
> git - original (28k commits)	                packed
> FS size                2,675,408k		1,723,820k
> read-tree            24.45s			18.9s
> checkout-cache   4m30s			3m5s
> patch time	   2h30m				1h55m
>

It was a rainy weekend, so I took a break from lawn care and hacked in some 
simple changes to the packed file format.  There's now a header listing the 
sha1 for each subfile and the offset where to find it in the main file.  Each 
subfile is compressed individually so you don't have to decompress the whole 
packed file to find one.  commits were added into the packed files as well.

Some results were about what I expected:

FS size              -- 1,614,376k
read-tree          -- 18s
checkout-cache -- 2m35s (cold cache)
checkout-cache -- 18s      (hot cache)
patch time        -- 96m

vanilla git needs 56s to checkout with a hot cache.  The hot cache numbers 
weren't done before because I hadn't expected my patch to help at all.  Even 
though we both do things entirely from cache, vanilla git is much slower at 
writing the checked out files back to the drive.  I've made no optimizations 
to that code, and the drive is only 30% full, so this seems to just be a bad 
interaction with filesystem layout.

I also expected vanilla git to perform pretty well when there were no commits 
in the tree.  My test was to put a copy of 2.6.11 under git.
                                              vanilla                   packed
update-cache (for all files)      2m1s                     48s
checkout-cache (cold)            1m23s                    28s
checkout-cache (hot)             12s                         15s

The difference in hot cache checkout time is userland cpu time.  It could be 
avoided with smarter caching of the packed file header.  Right now I'm 
decompressing it over and over again for each checkout.  Still, the 
performance hit is pretty small because I try to limit the number of subfiles 
that get packed together.

My current patch is attached for reference, it's against a git from late last 
week.  I wouldn't suggest using this for anything other than benchmarking, 
and since I don't think I can get much better numbers easily, I'll stop 
playing around with this for a while.

-chris

--Boundary-00=_K1WbCVvpFaJg0OU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="comp-tree-4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="comp-tree-4.diff"

diff -ur linus.back/cache.h linus/cache.h
--- linus.back/cache.h	2005-04-25 17:30:21.616654304 -0400
+++ linus/cache.h	2005-04-25 10:56:15.000000000 -0400
@@ -64,6 +64,16 @@
 	char name[0];
 };
 
+struct packed_item {
+	/* lenght of compressed data */
+	unsigned long len;
+	struct packed_item *next;
+	/* sha1 of uncompressed data */
+	char sha1[20];
+	/* compressed data */
+	char *data;
+};
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_STAGESHIFT 12
@@ -117,7 +127,7 @@
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
+extern void * unpack_sha1_file(const unsigned char *sha1, void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(char *buf, unsigned len, unsigned char *return_sha1);
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
@@ -125,6 +135,9 @@
 /* Convert to/from hex/sha1 representation */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern int pack_sha1_buffer(void *buf, unsigned long buf_len, 
+                            unsigned char *returnsha1, struct packed_item **);
+int write_packed_buffer(struct packed_item *head);
 
 /* General helper functions */
 extern void usage(const char *err);
@@ -137,4 +150,9 @@
 						unsigned long *size,
 						unsigned char *tree_sha1_ret);
 
+extern int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1, struct packed_item **head);
+
+#define MAXPARENT 16
+extern int commit_tree(char *tree_sha1_hex, unsigned char parent_sha1[MAXPARENT][20], int num_parents, struct packed_item **head);
+extern void check_valid_sha1_file(unsigned char *sha1, const char *expect);
 #endif /* CACHE_H */
diff -ur linus.back/commit-tree.c linus/commit-tree.c
--- linus.back/commit-tree.c	2005-04-25 17:30:21.626652784 -0400
+++ linus/commit-tree.c	2005-04-25 10:58:15.000000000 -0400
@@ -4,360 +4,32 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
-
-#include <pwd.h>
-#include <time.h>
-#include <string.h>
-#include <ctype.h>
-#include <time.h>
-
-#define BLOCKING (1ul << 14)
-#define ORIG_OFFSET (40)
-
-/*
- * Leave space at the beginning to insert the tag
- * once we know how big things are.
- *
- * FIXME! Share the code with "write-tree.c"
- */
-static void init_buffer(char **bufp, unsigned int *sizep)
-{
-	char *buf = malloc(BLOCKING);
-	memset(buf, 0, ORIG_OFFSET);
-	*sizep = ORIG_OFFSET;
-	*bufp = buf;
-}
-
-static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
-{
-	char one_line[2048];
-	va_list args;
-	int len;
-	unsigned long alloc, size, newsize;
-	char *buf;
-
-	va_start(args, fmt);
-	len = vsnprintf(one_line, sizeof(one_line), fmt, args);
-	va_end(args);
-	size = *sizep;
-	newsize = size + len;
-	alloc = (size + 32767) & ~32767;
-	buf = *bufp;
-	if (newsize > alloc) {
-		alloc = (newsize + 32767) & ~32767;
-		buf = realloc(buf, alloc);
-		*bufp = buf;
-	}
-	*sizep = newsize;
-	memcpy(buf + size, one_line, len);
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
-static void finish_buffer(char *tag, char **bufp, unsigned int *sizep)
-{
-	int taglen;
-	int offset;
-	char *buf = *bufp;
-	unsigned int size = *sizep;
-
-	offset = prepend_integer(buf, size - ORIG_OFFSET, ORIG_OFFSET);
-	taglen = strlen(tag);
-	offset -= taglen;
-	buf += offset;
-	size -= offset;
-	memcpy(buf, tag, taglen);
-
-	*bufp = buf;
-	*sizep = size;
-}
-
-static void remove_special(char *p)
-{
-	char c;
-	char *dst = p, *src = p;
-
-	for (;;) {
-		c = *src;
-		src++;
-		switch(c) {
-		case '\n': case '<': case '>':
-			continue;
-		}
-		*dst++ = c;
-		if (!c)
-			break;
-	}
-
-	/*
-	 * Go back, and remove crud from the end: some people
-	 * have commas etc in their gecos field
-	 */
-	dst--;
-	while (--dst >= p) {
-		unsigned char c = *dst;
-		switch (c) {
-		case ',': case ';': case '.':
-			*dst = 0;
-			continue;
-		}
-		break;
-	}
-}
-
-static const char *month_names[] = {
-        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
-        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
-};
-
-static const char *weekday_names[] = {
-        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
-};
-
-
-static char *skipfws(char *str)
-{
-	while (isspace(*str))
-		str++;
-	return str;
-}
-
-	
-/* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
-   (i.e. English) day/month names, and it doesn't work correctly with %z. */
-static void parse_rfc2822_date(char *date, char *result, int maxlen)
-{
-	struct tm tm;
-	char *p;
-	int i, offset;
-	time_t then;
-
-	memset(&tm, 0, sizeof(tm));
-
-	/* Skip day-name */
-	p = skipfws(date);
-	if (!isdigit(*p)) {
-		for (i=0; i<7; i++) {
-			if (!strncmp(p,weekday_names[i],3) && p[3] == ',') {
-				p = skipfws(p+4);
-				goto day;
-			}
-		}
-		return;
-	}					
-
-	/* day */
- day:
-	tm.tm_mday = strtoul(p, &p, 10);
-
-	if (tm.tm_mday < 1 || tm.tm_mday > 31)
-		return;
-
-	if (!isspace(*p))
-		return;
-
-	p = skipfws(p);
-
-	/* month */
-
-	for (i=0; i<12; i++) {
-		if (!strncmp(p, month_names[i], 3) && isspace(p[3])) {
-			tm.tm_mon = i;
-			p = skipfws(p+strlen(month_names[i]));
-			goto year;
-		}
-	}
-	return; /* Error -- bad month */
-
-	/* year */
- year:	
-	tm.tm_year = strtoul(p, &p, 10);
-
-	if (!tm.tm_year && !isspace(*p))
-		return;
-
-	if (tm.tm_year > 1900)
-		tm.tm_year -= 1900;
-		
-	p=skipfws(p);
-
-	/* hour */
-	if (!isdigit(*p))
-		return;
-	tm.tm_hour = strtoul(p, &p, 10);
-	
-	if (!tm.tm_hour > 23)
-		return;
-
-	if (*p != ':')
-		return; /* Error -- bad time */
-	p++;
-
-	/* minute */
-	if (!isdigit(*p))
-		return;
-	tm.tm_min = strtoul(p, &p, 10);
-	
-	if (!tm.tm_min > 59)
-		return;
-
-	if (isspace(*p))
-		goto zone;
-
-	if (*p != ':')
-		return; /* Error -- bad time */
-	p++;
-
-	/* second */
-	if (!isdigit(*p))
-		return;
-	tm.tm_sec = strtoul(p, &p, 10);
-	
-	if (!tm.tm_sec > 59)
-		return;
-
-	if (!isspace(*p))
-		return;
-
- zone:
-	p = skipfws(p);
-
-	if (*p == '-')
-		offset = -60;
-	else if (*p == '+')
-		offset = 60;
-	else
-	       return;
-
-	if (!isdigit(p[1]) || !isdigit(p[2]) || !isdigit(p[3]) || !isdigit(p[4]))
-		return;
-
-	i = strtoul(p+1, NULL, 10);
-	offset *= ((i % 100) + ((i / 100) * 60));
-
-	if (*(skipfws(p + 5)))
-		return;
-
-	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
-	if (then == -1)
-		return;
-
-	then -= offset;
-
-	snprintf(result, maxlen, "%lu %5.5s", then, p);
-}
-
-static void check_valid(unsigned char *sha1, const char *expect)
-{
-	void *buf;
-	char type[20];
-	unsigned long size;
-
-	buf = read_sha1_file(sha1, type, &size);
-	if (!buf || strcmp(type, expect))
-		die("%s is not a valid '%s' object", sha1_to_hex(sha1), expect);
-	free(buf);
-}
-
 /*
  * Having more than two parents is not strange at all, and this is
  * how multi-way merges are represented.
  */
-#define MAXPARENT (16)
 
 static char *commit_tree_usage = "commit-tree <sha1> [-p <sha1>]* < changelog";
 
 int main(int argc, char **argv)
 {
-	int i, len;
+	int i;
 	int parents = 0;
 	unsigned char tree_sha1[20];
 	unsigned char parent_sha1[MAXPARENT][20];
-	unsigned char commit_sha1[20];
-	char *gecos, *realgecos, *commitgecos;
-	char *email, *commitemail, realemail[1000];
-	char date[20], realdate[20];
-	char *audate;
-	char comment[1000];
-	struct passwd *pw;
-	time_t now;
-	struct tm *tm;
-	char *buffer;
-	unsigned int size;
 
 	if (argc < 2 || get_sha1_hex(argv[1], tree_sha1) < 0)
 		usage(commit_tree_usage);
 
-	check_valid(tree_sha1, "tree");
+	check_valid_sha1_file(tree_sha1, "tree");
 	for (i = 2; i < argc; i += 2) {
 		char *a, *b;
 		a = argv[i]; b = argv[i+1];
 		if (!b || strcmp(a, "-p") || get_sha1_hex(b, parent_sha1[parents]))
 			usage(commit_tree_usage);
-		check_valid(parent_sha1[parents], "commit");
+		check_valid_sha1_file(parent_sha1[parents], "commit");
 		parents++;
 	}
-	if (!parents)
-		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
-	pw = getpwuid(getuid());
-	if (!pw)
-		die("You don't exist. Go away!");
-	realgecos = pw->pw_gecos;
-	len = strlen(pw->pw_name);
-	memcpy(realemail, pw->pw_name, len);
-	realemail[len] = '@';
-	gethostname(realemail+len+1, sizeof(realemail)-len-1);
-	if (!strchr(realemail+len+1, '.')) {
-		strcat(realemail, ".");
-		getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
-	}
-	time(&now);
-	tm = localtime(&now);
-
-	strftime(realdate, sizeof(realdate), "%s %z", tm);
-	strcpy(date, realdate);
-
-	commitgecos = getenv("COMMIT_AUTHOR_NAME") ? : realgecos;
-	commitemail = getenv("COMMIT_AUTHOR_EMAIL") ? : realemail;
-	gecos = getenv("AUTHOR_NAME") ? : realgecos;
-	email = getenv("AUTHOR_EMAIL") ? : realemail;
-	audate = getenv("AUTHOR_DATE");
-	if (audate)
-		parse_rfc2822_date(audate, date, sizeof(date));
-
-	remove_special(gecos); remove_special(realgecos); remove_special(commitgecos);
-	remove_special(email); remove_special(realemail); remove_special(commitemail);
-
-	init_buffer(&buffer, &size);
-	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
-
-	/*
-	 * NOTE! This ordering means that the same exact tree merged with a
-	 * different order of parents will be a _different_ changeset even
-	 * if everything else stays the same.
-	 */
-	for (i = 0; i < parents; i++)
-		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]));
-
-	/* Person/date information */
-	add_buffer(&buffer, &size, "author %s <%s> %s\n", gecos, email, date);
-	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", commitgecos, commitemail, realdate);
-
-	/* And add the comment */
-	while (fgets(comment, sizeof(comment), stdin) != NULL)
-		add_buffer(&buffer, &size, "%s", comment);
-
-	finish_buffer("commit ", &buffer, &size);
-
-	write_sha1_file(buffer, size, commit_sha1);
-	printf("%s\n", sha1_to_hex(commit_sha1));
+	commit_tree(tree_sha1, parent_sha1, parents, NULL);
 	return 0;
 }
diff -ur linus.back/fsck-cache.c linus/fsck-cache.c
--- linus.back/fsck-cache.c	2005-04-25 17:30:21.630652176 -0400
+++ linus/fsck-cache.c	2005-04-22 10:25:07.000000000 -0400
@@ -85,7 +85,7 @@
 		if (map) {
 			char type[100];
 			unsigned long size;
-			void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+			void *buffer = unpack_sha1_file(sha1, map, mapsize, type, &size);
 			if (!buffer)
 				return -1;
 			if (check_sha1_signature(sha1, buffer, size, type) < 0)
diff -ur linus.back/Makefile linus/Makefile
--- linus.back/Makefile	2005-04-25 17:30:21.631652024 -0400
+++ linus/Makefile	2005-04-25 10:03:53.000000000 -0400
@@ -23,7 +23,7 @@
 install: $(PROG)
 	install $(PROG) $(HOME)/bin/
 
-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
+LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o lib-tree.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h
 
@@ -71,6 +71,7 @@
 show-diff.o: $(LIB_H)
 show-files.o: $(LIB_H)
 tree.o: $(LIB_H)
+lib-tree.o: $(LIB_H)
 update-cache.o: $(LIB_H)
 usage.o: $(LIB_H)
 unpack-file.o: $(LIB_H)
diff -ur linus.back/sha1_file.c linus/sha1_file.c
--- linus.back/sha1_file.c	2005-04-25 17:30:21.633651720 -0400
+++ linus/sha1_file.c	2005-04-25 17:15:53.050696400 -0400
@@ -116,12 +116,14 @@
 	return map;
 }
 
-void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+void * unpack_sha1_file(const unsigned char *sha1, void *map, 
+			unsigned long mapsize, char *type, unsigned long *size)
 {
 	int ret, bytes;
 	z_stream stream;
 	char buffer[8192];
 	char *buf;
+	unsigned long offset;
 
 	/* Get the data stream */
 	memset(&stream, 0, sizeof(stream));
@@ -134,12 +136,12 @@
 	ret = inflate(&stream, 0);
 	if (sscanf(buffer, "%10s %lu", type, size) != 2)
 		return NULL;
-
 	bytes = strlen(buffer) + 1;
 	buf = malloc(*size);
-	if (!buf)
+	if (!buf) {
+		perror("malloc");
 		return NULL;
-
+	}
 	memcpy(buf, buffer + bytes, stream.total_out - bytes);
 	bytes = stream.total_out - bytes;
 	if (bytes < *size && ret == Z_OK) {
@@ -149,6 +151,56 @@
 			/* nothing */;
 	}
 	inflateEnd(&stream);
+
+	/* we've found a packed object */
+	if (strcmp(type, "packed") == 0) {
+		char *p = buf;
+		unsigned long header_len = *size;
+		offset = stream.total_in;
+		if (!sha1)
+			return NULL;
+		while(p < buf + header_len) {
+			unsigned long item_len;
+			unsigned char sha1_hex[50];
+			unsigned char item_sha[20];
+			memcpy(item_sha, p, 20);
+			sscanf(p + 20, "%lu ", &item_len);
+			p += 20 + strlen(p + 20) + 1;
+			if (memcmp(item_sha, sha1, 20) == 0) {
+				/* Get the data stream */
+				free(buf);
+				memset(&stream, 0, sizeof(stream));
+				stream.next_in = map + offset;
+				stream.avail_in = mapsize - offset;
+				stream.next_out = buffer;
+				stream.avail_out = sizeof(buffer);
+
+				inflateInit(&stream);
+				ret = inflate(&stream, 0);
+				if (sscanf(buffer, "%10s %lu", type, size) != 2)
+					return NULL;
+				bytes = strlen(buffer) + 1;
+				buf = malloc(*size);
+				if (!buf) {
+					perror("malloc");
+					return NULL;
+				}
+				memcpy(buf, buffer + bytes, 
+					stream.total_out - bytes);
+				bytes = stream.total_out - bytes;
+				if (bytes < *size && ret == Z_OK) {
+					stream.next_out = buf + bytes;
+					stream.avail_out = *size - bytes;
+					while (inflate(&stream, Z_FINISH) == Z_OK)
+						/* nothing */;
+				}
+				inflateEnd(&stream);
+				return buf;
+			}
+			offset += item_len;
+		}
+		return NULL;
+	}
 	return buf;
 }
 
@@ -159,7 +211,7 @@
 
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size);
+		buf = unpack_sha1_file(sha1, map, mapsize, type, size);
 		munmap(map, mapsize);
 		return buf;
 	}
@@ -305,3 +357,166 @@
 	close(fd);
 	return 0;
 }
+
+int pack_sha1_buffer(void *buf, unsigned long buf_len, 
+		     unsigned char *returnsha1,
+		     struct packed_item **packed_item)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char *filename;
+	struct stat st;
+	char *compressed;
+	z_stream stream;
+	unsigned long size;
+	struct packed_item *item;
+
+	*packed_item = NULL;
+
+	/* Sha1.. */
+	SHA1_Init(&c);
+	SHA1_Update(&c, buf, buf_len);
+	SHA1_Final(sha1, &c);
+
+	if (returnsha1)
+		memcpy(returnsha1, sha1, 20);
+
+	filename = sha1_file_name(sha1);
+	if (stat(filename, &st) == 0)
+		return 0;
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	size = deflateBound(&stream, buf_len);
+	compressed = malloc(size);
+
+	/*
+	 * ASCII size + nul byte
+	 */	
+	stream.next_in = buf;
+	stream.avail_in = buf_len;
+	stream.next_out = compressed;
+	stream.avail_out = size;
+	/* Compress it */
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+	size = stream.total_out;
+
+	item = malloc(sizeof(struct packed_item));
+	if (!item) {
+		free(compressed);
+		return -1;
+	}
+	memcpy(item->sha1, sha1, 20);
+	item->len = size;
+	item->next = NULL;
+	item->data = compressed;
+	*packed_item = item;
+	return 0;
+}
+
+static char *create_packed_header(struct packed_item *head, unsigned long *size)
+{
+	char *metadata = NULL;
+	int metadata_size = 0;
+	*size = 0;
+
+	while(head) {
+		char *p;
+		metadata = realloc(metadata, metadata_size + 220);
+		if (!metadata)
+			return NULL;
+		p = metadata+metadata_size;
+		memcpy(p, head->sha1, 20);
+		p += 20;
+		metadata_size += 1 + sprintf(p, "%lu ", head->len) + 20;
+		head = head->next;
+	}
+	*size = metadata_size;
+	return metadata;
+}
+
+int write_packed_buffer(struct packed_item *head)
+{
+	unsigned char sha1[20];
+	SHA_CTX c;
+	char *filename;
+	char *metadata = malloc(200);
+	char *header;
+	int metadata_size;
+	int fd;
+	int ret = 0;
+	unsigned long header_len;
+	struct packed_item *item;
+	char *compressed;
+	z_stream stream;
+	unsigned long size;
+	int nr = 0;
+
+	header = create_packed_header(head, &header_len);
+	metadata_size = 1+sprintf(metadata, "packed %lu", header_len);
+
+	SHA1_Init(&c);
+	SHA1_Update(&c, metadata, metadata_size);
+	SHA1_Update(&c, header, header_len);
+	item = head;
+	while(item) {
+		SHA1_Update(&c, item->data, item->len);
+		item = item->next;
+		nr++;
+	}
+	SHA1_Final(sha1, &c);
+
+	filename = strdup(sha1_file_name(sha1));
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		/* add collision check! */
+		if (errno != EEXIST) {
+			ret = -errno;
+		}
+		goto out;
+	}
+       /* compress just the header info */
+        memset(&stream, 0, sizeof(stream));
+        deflateInit(&stream, Z_BEST_COMPRESSION);
+        size = deflateBound(&stream, header_len + metadata_size);
+        compressed = malloc(size);
+
+        stream.next_in = metadata;
+        stream.avail_in = metadata_size;
+        stream.next_out = compressed;
+        stream.avail_out = size;
+        while (deflate(&stream, 0) == Z_OK)
+                /* nothing */;
+        stream.next_in = header;
+        stream.avail_in = header_len;
+        while (deflate(&stream, Z_FINISH) == Z_OK)
+                /* nothing */;
+        deflateEnd(&stream);
+        size = stream.total_out;
+
+	write(fd, compressed, size);
+	free(compressed);
+
+	item = head;
+	while(item) {
+		char *item_file;
+		struct packed_item *next = item->next;
+		write(fd, item->data, item->len);
+		item_file = sha1_file_name(item->sha1);
+		if (link(filename, item_file) && errno != EEXIST) {
+			ret = -errno;
+			break;
+		}
+		free(item->data);
+		free(item);
+		item = next;
+	}
+out:
+	free(header);
+	free(metadata);
+	free(filename);
+	return ret;
+}
diff -ur linus.back/update-cache.c linus/update-cache.c
--- linus.back/update-cache.c	2005-04-25 17:30:21.635651416 -0400
+++ linus/update-cache.c	2005-04-25 14:24:14.000000000 -0400
@@ -12,57 +12,48 @@
  * like "update-cache *" and suddenly having all the object
  * files be revision controlled.
  */
-static int allow_add = 0, allow_remove = 0;
+static int allow_add = 0, allow_remove = 0, commit = 0;
 
-static int index_fd(unsigned char *sha1, int fd, struct stat *st)
+static int index_fd(unsigned char *sha1, int fd, struct stat *st, struct packed_item **head, struct packed_item **tail, unsigned long *packed_size)
 {
-	z_stream stream;
 	unsigned long size = st->st_size;
-	int max_out_bytes = size + 200;
-	void *out = malloc(max_out_bytes);
 	void *metadata = malloc(200);
 	int metadata_size;
 	void *in;
-	SHA_CTX c;
+	char *copy;
+	int ret;
+	struct packed_item *new_item;
 
 	in = "";
 	if (size)
 		in = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (!out || (int)(long)in == -1)
+	if (!metadata || (int)(long)in == -1)
 		return -1;
-
 	metadata_size = 1+sprintf(metadata, "blob %lu", size);
-
-	SHA1_Init(&c);
-	SHA1_Update(&c, metadata, metadata_size);
-	SHA1_Update(&c, in, size);
-	SHA1_Final(sha1, &c);
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, Z_BEST_COMPRESSION);
-
-	/*
-	 * ASCII size + nul byte
-	 */	
-	stream.next_in = metadata;
-	stream.avail_in = metadata_size;
-	stream.next_out = out;
-	stream.avail_out = max_out_bytes;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
-
-	/*
-	 * File content
-	 */
-	stream.next_in = in;
-	stream.avail_in = size;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/*nothing */;
-
-	deflateEnd(&stream);
-	
-	return write_sha1_buffer(sha1, out, stream.total_out);
+	copy = malloc(metadata_size + size);
+	if (!copy)
+		return -1;
+	memcpy(copy, metadata, metadata_size);
+	memcpy(copy + metadata_size, in, size);
+	ret = pack_sha1_buffer(copy, metadata_size + size, sha1, &new_item);
+	if (new_item) {
+		if (*tail)
+			(*tail)->next = new_item;
+		*tail = new_item;
+		if (!*head)
+			*head = new_item;
+		*packed_size += new_item->len;
+		if (*packed_size > (512 * 1024)) {
+			write_packed_buffer(*head);
+			*head = NULL;
+			*tail = NULL;
+			*packed_size = 0;
+		}
+	}
+	munmap(in, size);
+	free(copy);
+	return ret;
 }
 
 /*
@@ -85,7 +76,7 @@
 	ce->ce_size = htonl(st->st_size);
 }
 
-static int add_file_to_cache(char *path)
+static int add_file_to_cache(char *path, struct packed_item **packed_head, struct packed_item **packed_tail, unsigned long *packed_size)
 {
 	int size, namelen;
 	struct cache_entry *ce;
@@ -113,7 +104,8 @@
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	ce->ce_flags = htons(namelen);
 
-	if (index_fd(ce->sha1, fd, &st) < 0)
+	if (index_fd(ce->sha1, fd, &st, packed_head, 
+		     packed_tail, packed_size) < 0)
 		return -1;
 
 	return add_cache_entry(ce, allow_add);
@@ -282,12 +274,30 @@
 		unlink(lockfile_name);
 }
 
+static int path_comp(const void *p1, const void *p2)
+{
+	const char *s1 = *(char **)p1;
+	const char *s2 = *(char **)p2;
+	int len1 = strlen(s1);
+	int len2 = strlen(s2);
+	int ret;
+	ret = cache_name_compare(s1, len1, s2, len2);
+	return ret;
+}
+
 int main(int argc, char **argv)
 {
 	int i, newfd, entries;
 	int allow_options = 1;
 	static char lockfile[MAXPATHLEN+1];
 	const char *indexfile = get_index_file();
+	struct packed_item *packed_head = NULL;
+	struct packed_item *packed_tail = NULL;
+	unsigned long packed_size = 0;
+	char **paths = malloc(argc * sizeof(char *));
+	int num_paths = 0;
+	unsigned char parent_sha1[20];
+	int parents = 0;
 
 	snprintf(lockfile, sizeof(lockfile), "%s.lock", indexfile);
 
@@ -318,6 +328,17 @@
 				allow_remove = 1;
 				continue;
 			}
+			if (!strcmp(path, "--commit")) {
+				commit = 1;
+				continue;
+			}
+			if (!strcmp(path, "--parent")) {
+				if (i+1 >= argc || get_sha1_hex(argv[i+1], parent_sha1))
+					die("update-cache: --parent sha1");
+				parents = 1;
+				i+=1;
+				continue;
+			}
 			if (!strcmp(path, "--refresh")) {
 				refresh_cache();
 				continue;
@@ -334,8 +355,27 @@
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
-		if (add_file_to_cache(path))
-			die("Unable to add %s to database", path);
+		paths[num_paths++] = path;
+
+	}
+	// qsort(paths, num_paths, sizeof(char *), path_comp);
+	for(i = 0 ; i < num_paths ; i++) {
+		if (add_file_to_cache(paths[i], &packed_head, &packed_tail, &packed_size))
+			die("Unable to add %s to database", paths[i]);
+
+	}
+	if (commit) {
+		char tree_sha1[20];
+		if (write_tree(active_cache, active_nr, "", 0, tree_sha1, &packed_head) != active_nr)
+			die("write-tree failed");
+fprintf(stderr, "write_tree gave us %s\n", sha1_to_hex(tree_sha1));
+
+		if (commit_tree(tree_sha1, &parent_sha1, parents, &packed_head))
+			die("commit-tree failed");
+	}
+	if (packed_head) {
+		if (write_packed_buffer(packed_head))
+			die("write packed buffer failed");
 	}
 	if (write_cache(newfd, active_cache, active_nr) || rename(lockfile, indexfile))
 		die("Unable to write new cachefile");
diff -ur linus.back/write-tree.c linus/write-tree.c
--- linus.back/write-tree.c	2005-04-25 17:30:21.635651416 -0400
+++ linus/write-tree.c	2005-04-25 10:01:30.000000000 -0400
@@ -3,106 +3,15 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
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
+#include "cache.h"
 
 int main(int argc, char **argv)
 {
 	int i, unmerged;
 	int entries = read_cache();
 	unsigned char sha1[20];
+	struct packed_item *head = NULL;
 
 	if (entries <= 0)
 		die("write-tree: no cache contents to write");
@@ -123,8 +32,12 @@
 		die("write-tree: not able to write tree");
 
 	/* Ok, write it out */
-	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
+	if (write_tree(active_cache, entries, "", 0, sha1, &head) != entries)
 		die("write-tree: internal error");
+	if (head) {
+		if (write_packed_buffer(head))
+			die("write_packed_buffer failed");
+	}
 	printf("%s\n", sha1_to_hex(sha1));
 	return 0;
 }

--Boundary-00=_K1WbCVvpFaJg0OU--
