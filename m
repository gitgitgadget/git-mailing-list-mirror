From: "C. Scott Ananian" <cscott@cscott.net>
Subject: blowing chunks (quick update)
Date: Fri, 22 Apr 2005 17:02:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504221652180.1746@cag.csail.mit.edu>
References: <200504201000.DAA04988@emf.net> <20050420213114.GF19112@pasky.ji.cz>
 <Pine.LNX.4.61.0504201754450.2630@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504201510520.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:59:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP5FR-0006Jq-LI
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 22:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVDVVEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 17:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVDVVEA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 17:04:00 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:17853 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S262129AbVDVVCi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 17:02:38 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DP5IJ-0004Ya-00; Fri, 22 Apr 2005 17:02:35 -0400
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504201510520.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just a quick status update on my chunking work: I've got working code (see 
attached, but it's very rough) and am tweaking the various knobs and dials 
to try to get reasonable space savings.  I can save a modest amount of 
space using a 64k chunk size, but it's surprisingly hard to get 
substantial reductions.  Not because there's not a lot of redundancy in 
the archive --- there is --- but because 'gzip -9' is damn good at 
compressing source code.  Splitting files up into chunks hampers the 
compression, causing more 'extra space' to be used that the chunking 
format by itself would seem to indicate. [The patch below pre-seeds zlib's 
dictionary for non-leaf chunks to help mitigate this.]

I'm not giving up yet: there are a number of tricks left I'd like to play.
This is just a quick update to let y'all know I'm still hard at work.
  --scott [I'll also be off-line until Sunday.]

Khaddafi tonight Shoal Bay D5 SLBM LCPANGS ODIBEX Cheney ammunition 
counter-intelligence Japan overthrow Chechnya Mossad explosion ZRBRIEF
                          ( http://cscott.net/ )

diff -ruHp -x .dircache -x .git -x '*.o' -x '*~' -x 'blow-chunks.?.*' git.repo.orig/Makefile git.repo/Makefile
--- git.repo.orig/Makefile	2005-04-21 15:45:39.000000000 -0400
+++ git.repo/Makefile	2005-04-21 17:46:10.000000000 -0400
@@ -8,6 +8,7 @@
  # break unless your underlying filesystem supports those sub-second times
  # (my ext3 doesn't).
  CFLAGS=-g -O3 -Wall
+CFLAGS=-g -Wall

  CC=gcc
  AR=ar
@@ -16,16 +17,17 @@ AR=ar
  PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
  	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
  	check-files ls-tree merge-base merge-cache unpack-file git-export \
-	diff-cache convert-cache
+	diff-cache convert-cache \
+	chunktest blow-chunks chunk-size chunk-ref

  all: $(PROG)

  install: $(PROG)
  	install $(PROG) $(HOME)/bin/

-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
+LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o chunk.o
  LIB_FILE=libgit.a
-LIB_H=cache.h object.h
+LIB_H=cache.h object.h chunk.h

  $(LIB_FILE): $(LIB_OBJS)
  	$(AR) rcs $@ $(LIB_OBJS)
@@ -91,6 +93,16 @@ diff-cache: diff-cache.o $(LIB_FILE)
  convert-cache: convert-cache.o $(LIB_FILE)
  	$(CC) $(CFLAGS) -o convert-cache convert-cache.o $(LIBS)

+chunktest: chunktest.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
+
+blow-chunks: blow-chunks.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
+chunk-ref: chunk-ref.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
+chunk-size: chunk-size.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
+
  blob.o: $(LIB_H)
  cat-file.o: $(LIB_H)
  check-files.o: $(LIB_H)
diff -ruHp -x .dircache -x .git -x '*.o' -x '*~' -x 'blow-chunks.?.*' git.repo.orig/fsck-cache.c git.repo/fsck-cache.c
--- git.repo.orig/fsck-cache.c	2005-04-21 15:45:41.000000000 -0400
+++ git.repo/fsck-cache.c	2005-04-21 17:38:33.000000000 -0400
@@ -6,6 +6,7 @@
  #include "commit.h"
  #include "tree.h"
  #include "blob.h"
+#include "chunk.h"

  #define REACHABLE 0x0001

@@ -88,11 +89,16 @@ static int fsck_name(char *hex)
  			void *buffer = unpack_sha1_file(map, mapsize, type, &size);
  			if (!buffer)
  				return -1;
+			if (TYPE_IS_TREAP(type))
+			    /* xxx: we really should check chunk structure */
+			    buffer = chunk_read_sha1_file(sha1, type, &size, buffer);
  			if (check_sha1_signature(sha1, buffer, size, type) < 0)
  				printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
  			munmap(map, mapsize);
-			if (!fsck_entry(sha1, type, buffer, size))
-				return 0;
+			if (fsck_entry(sha1, type, buffer, size) < 0)
+				return -1;
+			free(buffer);
+			return 0;
  		}
  	}
  	return -1;
diff -ruHp -x .dircache -x .git -x '*.o' -x '*~' -x 'blow-chunks.?.*' git.repo.orig/sha1_file.c git.repo/sha1_file.c
--- git.repo.orig/sha1_file.c	2005-04-21 15:45:41.000000000 -0400
+++ git.repo/sha1_file.c	2005-04-21 22:12:40.000000000 -0400
@@ -8,6 +8,7 @@
   */
  #include <stdarg.h>
  #include "cache.h"
+#include "chunk.h"

  const char *sha1_file_directory = NULL;

@@ -120,7 +121,7 @@ void * unpack_sha1_file(void *map, unsig
  {
  	int ret, bytes;
  	z_stream stream;
-	char buffer[8192];
+	char buffer[SMALL_FILE_LIMIT];
  	char *buf;

  	/* Get the data stream */
@@ -132,10 +133,15 @@ void * unpack_sha1_file(void *map, unsig

  	inflateInit(&stream);
  	ret = inflate(&stream, 0);
+	//if (ret==Z_NEED_DICT) ...
  	if (sscanf(buffer, "%10s %lu", type, size) != 2)
  		return NULL;
-
  	bytes = strlen(buffer) + 1;
+
+	/* Tricky optimization; avoid encoding size for small files. */
+	if (ret==Z_STREAM_END && *size==0)
+	    *size = stream.total_out - bytes;
+
  	buf = malloc(*size);
  	if (!buf)
  		return NULL;
@@ -161,6 +167,8 @@ void * read_sha1_file(const unsigned cha
  	if (map) {
  		buf = unpack_sha1_file(map, mapsize, type, size);
  		munmap(map, mapsize);
+		if (TYPE_IS_TREAP(type))
+		    return chunk_read_sha1_file(sha1, type, size, buf);
  		return buf;
  	}
  	return NULL;
@@ -215,6 +223,7 @@ int write_sha1_file(char *buf, unsigned

  	if (write(fd, compressed, size) != size)
  		die("unable to write file");
+	free(compressed);
  	close(fd);

  	return 0;
@@ -259,9 +268,11 @@ int write_sha1_buffer(const unsigned cha
  		if (collision_check(filename, buf, size))
  			return error("SHA1 collision detected!"
  					" This is bad, bad, BAD!\a\n");
+		errno = EEXIST; /* indicate to caller that this exists */
  		return 0;
  	}
  	write(fd, buf, size);
  	close(fd);
+	errno = 0;
  	return 0;
  }
diff -ruHp -x .dircache -x .git -x '*.o' -x '*~' -x 'blow-chunks.?.*' git.repo.orig/update-cache.c git.repo/update-cache.c
--- git.repo.orig/update-cache.c	2005-04-21 15:45:41.000000000 -0400
+++ git.repo/update-cache.c	2005-04-20 17:32:07.000000000 -0400
@@ -4,6 +4,7 @@
   * Copyright (C) Linus Torvalds, 2005
   */
  #include "cache.h"
+#include "chunk.h"

  /*
   * Default to not allowing changes to the list of files. The
@@ -23,6 +24,7 @@ static int index_fd(unsigned char *sha1,
  	void *metadata = malloc(200);
  	int metadata_size;
  	void *in;
+	int retval, err;
  	SHA_CTX c;

  	in = "";
@@ -51,6 +53,7 @@ static int index_fd(unsigned char *sha1,
  	stream.avail_out = max_out_bytes;
  	while (deflate(&stream, 0) == Z_OK)
  		/* nothing */;
+	free(metadata);

  	/*
  	 * File content
@@ -62,7 +65,11 @@ static int index_fd(unsigned char *sha1,

  	deflateEnd(&stream);

-	return write_sha1_buffer(sha1, out, stream.total_out);
+	retval = write_sha1_buffer(sha1, out, stream.total_out);
+	err = errno;
+	free(out);
+	errno = err;
+	return retval;
  }

  /*
@@ -113,7 +120,7 @@ static int add_file_to_cache(char *path)
  	ce->ce_mode = create_ce_mode(st.st_mode);
  	ce->ce_flags = htons(namelen);

-	if (index_fd(ce->sha1, fd, &st) < 0)
+	if (chunk_index_fd(ce->sha1, fd, &st) < 0)
  		return -1;

  	return add_cache_entry(ce, allow_add);
--- /dev/null	2005-04-20 20:21:45.319868048 -0400
+++ git.repo/blow-chunks.c	2005-04-20 21:33:33.000000000 -0400
@@ -0,0 +1,34 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "chunk.h"
+
+/* For every file on the command-line, if it is a blob, convert it to a chunk.
+ */
+void convert_one(char *filename) {
+    char type[10];
+    int fd = open(filename, O_RDONLY);
+    struct stat st;
+    void *map, *buf;
+    unsigned long size;
+    if (fd < 0) { perror(filename); return; }
+    if (fstat(fd, &st) < 0) { perror(filename); close(fd); return; }
+    map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+    close(fd);
+    if (map == MAP_FAILED) { perror("mmap failed"); return; }
+    buf = unpack_sha1_file(map, st.st_size, type, &size);
+    munmap(map, st.st_size);
+    if (buf == NULL) { perror("Couldn't open file"); return; }
+    if (strcmp(type, "blob")==0) {
+	unsigned char sha1[20];
+	/* a-ha! */
+	chunkify_blob(buf, size, sha1);
+    }
+    free(buf);
+}
+
+int main(int argc, char **argv) {
+    int i;
+    for (i=1; i<argc; i++)
+	convert_one(argv[i]);
+    return 0;
+}
--- /dev/null	2005-04-20 20:21:45.319868048 -0400
+++ git.repo/chunk-ref.c	2005-04-21 17:45:10.000000000 -0400
@@ -0,0 +1,44 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "chunk.h"
+
+void ref_one(char *filename, char *find_parent) {
+    char type[10];
+    int fd = open(filename, O_RDONLY);
+    struct stat st;
+    void *map, *buf;
+    unsigned long size;
+    if (fd < 0) { perror(filename); return; }
+    if (fstat(fd, &st) < 0) { perror(filename); close(fd); return; }
+    map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+    close(fd);
+    if (map == MAP_FAILED) { perror("mmap failed"); return; }
+    buf = unpack_sha1_file(map, st.st_size, type, &size);
+    munmap(map, st.st_size);
+    if (buf == NULL) { perror("Couldn't open file"); return; }
+    if (TYPE_IS_TREAP(type)) {
+	int num_children = 0, i;
+	if (TREAP_HAS_LEFT(type)) num_children++;
+	if (TREAP_HAS_RIGHT(type)) num_children++;
+	for (i=0; i<num_children; i++) {
+	    size -= 20;
+	    if (find_parent) {
+		if (strcmp(sha1_file_name(buf + size), find_parent)==0)
+		    printf("%s\n", filename);
+	    } else
+		printf("%s -> %s\n", filename, sha1_file_name(buf + size));
+	}
+    }
+    free(buf);
+}
+
+/* If you provide a filename followed by '--' on the command line, will print
+ * all of the given chunks which are parents of that chunk.   Else, print all
+ * children of the given chunks. */
+int main(int argc, char **argv) {
+    char *parent = (argc>2) && (strcmp("--", argv[2])==0) ? argv[1] : NULL;
+    int i = parent ? 3 : 1;
+    for (; i<argc; i++)
+	ref_one(argv[i], parent);
+    return 0;
+}
--- /dev/null	2005-04-20 20:21:45.319868048 -0400
+++ git.repo/chunk-size.c	2005-04-21 17:41:00.000000000 -0400
@@ -0,0 +1,34 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "chunk.h"
+
+/* For every file on the command-line, if it is a blob, convert it to a chunk.
+ */
+void size_one(char *filename) {
+    char type[10];
+    int fd = open(filename, O_RDONLY);
+    struct stat st;
+    void *map, *buf;
+    unsigned long size;
+    if (fd < 0) { perror(filename); return; }
+    if (fstat(fd, &st) < 0) { perror(filename); close(fd); return; }
+    map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+    close(fd);
+    if (map == MAP_FAILED) { perror("mmap failed"); return; }
+    buf = unpack_sha1_file(map, st.st_size, type, &size);
+    munmap(map, st.st_size);
+    if (buf == NULL) { perror("Couldn't open file"); return; }
+    if (TYPE_IS_TREAP(type)) {
+	if (TREAP_HAS_LEFT(type)) size-=20;
+	if (TREAP_HAS_RIGHT(type)) size-=20;
+	printf("%s %lu\n", filename, size);
+    }
+    free(buf);
+}
+
+int main(int argc, char **argv) {
+    int i;
+    for (i=1; i<argc; i++)
+	size_one(argv[i]);
+    return 0;
+}
--- /dev/null	2005-04-20 20:21:45.319868048 -0400
+++ git.repo/chunk.c	2005-04-22 12:30:59.000000000 -0400
@@ -0,0 +1,640 @@
+/*
+ * This file implements a treap-based chunked content store.  The
+ * idea is that every stored file is broken down into tree-structured
+ * chunks (that is, every chunk has an optional 'prefix' and 'suffix'
+ * chunk), and these chunks are put in the object store.  This way
+ * similar files will be expected to share chunks, saving space.
+ * Files less than one disk block long are expected to fit in a single
+ * chunk, so there is no extra indirection overhead for this case.
+ *
+ * Copyright (C) 2005 C. Scott Ananian <cananian@alumni.princeton.edu>
+ */
+
+/*
+ * We assume that the file and the chunk information all fits in memory.
+ * A slightly more-clever implementation would work even if the file
+ * didn't fit.  Basically, we could scan it an keep the
+ * 'N' lowest heap keys (chunk hashes), where 'N' is chosen to fit
+ * comfortably in memory.  These would form the root and top
+ * of the resulting treap, constructing it top-down.  Then we'd scan
+ * again any only keep the next 'N' lowest heap keys, etc.
+ *
+ * But we're going to keep things simple.  We do try to maintain locality
+ * where possible, so if you need to swap things still shouldn't be too bad.
+ */
+
+#include <assert.h>
+#include <stdlib.h>
+#include "cache.h"
+#include "chunk.h"
+
+typedef unsigned long ch_size_t;
+
+/* Our magic numbers: these can be tuned without breaking files already
+ * in the archive, although space re-use is only expected between files which
+ * have these constants set to the same values. */
+
+/* The window size determines how much context we use when looking for a
+ * chunk boundary.
+ * C source has approx 5 bits per character of entropy.
+ * We'd like to get 32 bits of good entropy into our boundary checksum;
+ * that means 7 bytes is a rough minimum for the window size.
+ * 30 bytes is what 'rsyncable zlib' uses; that should be fine. */
+#define ROLLING_WINDOW 67
+/* The ideal chunk size will fit most chunks into a disk block.  A typical
+ * disk block size is 4k, and we expect (say) 50% compression. */
+/* some primes: 61 127 251 509 1021 2039 4091 8191 16381 32749 65521 */
+//#define CHUNK_SIZE 7901 /* primes are nice to use */
+#define CHUNK_SIZE 16381
+
+#define WINDOW_MAGIC 0x0000 /* aka, never */
+
+/* Data structures: */
+struct chunk {
+    /* a chunk represents some range of the underlying file */
+    ch_size_t start /* inclusive */, end /*exclusive*/;
+    unsigned char sha1[20]; /* sha1 for this chunk; used as the heap key */
+};
+struct chunklist {
+    /* a dynamically-sized list of chunks */
+    struct chunk *chunk; /* an array of chunks */
+    ch_size_t num_items; /* how many items are currently in the list */
+    ch_size_t allocd;    /* how many items we've allocated space for */
+};
+struct treap {
+    /* A treap node represents a run of consecutive chunks. */
+
+    /* the start and end of the run: */
+    ch_size_t start /* inclusive */, end /*exclusive*/;
+    struct chunk *chunk; /* some chunk in the run. */
+    /* treaps representing the run before 'chunk' (left) and
+     * after 'chunk' (right).  */
+    struct treap *left, *right;
+    /* sha1 for the run represented by this treap */
+    unsigned char sha1[20];
+};
+
+static struct chunklist *
+create_chunklist(int expected_items) {
+    struct chunklist *cl = malloc(sizeof(*cl));
+    assert(expected_items > 0);
+    cl->num_items = 0;
+    cl->allocd = expected_items;
+    cl->chunk = malloc(sizeof(cl->chunk[0]) * cl->allocd);
+    return cl;
+}
+static void
+free_chunklist(struct chunklist *cl) {
+    free(cl->chunk);
+    free(cl);
+}
+
+/* Add a chunk to the chunk list, calculating its SHA1 in the process. */
+/* The chunk includes buf[start] to buf[end-1].                        */
+static void
+add_chunk(struct chunklist *cl, char *buf, ch_size_t start, ch_size_t end) {
+    struct chunk *ch;
+    SHA_CTX c;
+    assert(start<end); assert(cl); assert(buf);
+    if (cl->num_items >= cl->allocd) {
+	cl->allocd *= 2;
+	cl->chunk = realloc(cl->chunk, cl->allocd * sizeof(*(cl->chunk)));
+    }
+    assert(cl->num_items < cl->allocd);
+    ch = cl->chunk + (cl->num_items++);
+    ch->start = start;
+    ch->end = end;
+    /* compute SHA-1 of the chunk. */
+    SHA1_Init(&c);
+    SHA1_Update(&c, buf+start, end-start);
+    SHA1_Final(ch->sha1, &c);
+    /* done! */
+}
+
+/* Split a buffer into chunks, using an adler-32 checksum over ROLLING_WINDOW
+ * bytes to determine chunk boundaries.  We try to split chunks into pieces
+ * whose size averages out to be 'CHUNK_SIZE' (nice if this is a prime).*/
+static void
+chunkify(struct chunklist *cl, char *buf, ch_size_t size) {
+    int i, adler_s1=1, adler_s2=0, last=-1;
+
+    for (i=0; i<size; i++) {
+	if (i >= ROLLING_WINDOW) { /* After window is full: */
+	    /* Old character out */
+	    adler_s1 = (65521 + adler_s1 - (unsigned char)buf[i-ROLLING_WINDOW]) % 65521;
+	    adler_s2 = (65521 + adler_s2 - ROLLING_WINDOW * (unsigned char)buf[i-ROLLING_WINDOW]) % 65521;
+	}
+	/* New character in */
+	adler_s1 = (adler_s1 + (unsigned char)buf[i]) % 65521;
+	adler_s2 = (adler_s2 + adler_s1) % 65521;
+	/* Is this the end of a chunk? */
+	if (WINDOW_MAGIC == ((adler_s1 + adler_s2*65536) % CHUNK_SIZE)) {
+	    add_chunk(cl, buf, last+1, i+1);
+	    last = i;
+	    //adler_s1 = 1; adler_s2 = 0; /* reset window */
+	}
+    }
+    /* One last chunk at the end: */
+    if (last+1!=size)
+	add_chunk(cl, buf, last+1, size);
+    /* done! */
+}
+
+/* A treap is a 'heap-ordered tree'.  There are two constraints maintained:
+ *   left tree key < this tree key < right tree key
+ * and
+ *   this heap key < left and right heap keys.
+ * We use the sha1 of the chunk (chunk->sha1) as the heap key and the
+ * file location (chunk->start) as the tree key.
+ * For more info on treaps, see:
+ *   C. R. Aragon and R. G. Seidel, "Randomized search trees",
+ *   Proc. 30th IEEE FOCS (1989), 540-545.
+ * There are many possible binary trees we could build; enforcing the
+ * heap constraint ensures that similar files will build similar trees.
+ * (The root of the constructed tree will always be the chunk with the
+ *  smallest hash key; it's left child will be the chunk with the smallest
+ *  hash among those chunk before the root in file order; and so on
+ *  recursively.)
+ */
+
+/* Compare the 'heap keys' of two chunks. */
+static int
+chunk_hash_cmp(struct chunk *c1, struct chunk *c2) {
+    int c = memcmp(c1->sha1, c2->sha1, sizeof(c1->sha1));
+    if (c!=0) return c;
+    /* Use file location to break ties (caused by repeated content w/in
+     * a single file).  This ensures that our heap keys are unique. */
+    return c1->start - c2->start;
+}
+
+/* Assertion helper: check tree and heap constraints. */
+static int
+treap_valid(struct treap *t) {
+    if (!t) return 1;
+    if (t->chunk==NULL) return 0;
+    if (t->left!=NULL) {
+	/* Tree constraint. */
+	assert(t->left->chunk->start < t->chunk->start);
+	/* Heap constraint. */
+	assert(chunk_hash_cmp(t->chunk, t->left->chunk) < 0);
+	/* 'start' validity */
+	assert(t->start == t->left->start);
+    } else
+	assert(t->start == t->chunk->start);
+    if (t->right!=NULL) {
+	/* Tree constraint. */
+	assert(t->chunk->start < t->right->chunk->start);
+	/* Heap constraint. */
+	assert(chunk_hash_cmp(t->chunk, t->right->chunk) < 0);
+	/* 'end' validity. */
+	assert(t->end == t->right->end);
+    } else
+	assert(t->end == t->chunk->end);
+    return 1;
+}
+
+/* Restore heap constraint without disturbing tree ordering. */
+/* Only the root of the given treap will violate the heap constraint. */
+static struct treap *
+treapify(struct treap *t) {
+    struct treap *x, *y, *a, *b, *c;
+    int left_ok, right_ok, rotate_left;
+    assert(treap_valid(t->left));
+    assert(treap_valid(t->right));
+    left_ok = (t->left == NULL) ||
+	(chunk_hash_cmp(t->chunk, t->left->chunk) < 0);
+    right_ok = (t->right == NULL) ||
+	(chunk_hash_cmp(t->chunk, t->right->chunk) < 0);
+    if (left_ok && right_ok) { /* well, that's easy */
+	assert(treap_valid(t));
+	return t;
+    }
+    /* okay, someone needs to rotate */
+    rotate_left = (!left_ok) &&
+	(right_ok || /* if neither is okay, then rotate smallest up */
+	 chunk_hash_cmp(t->left->chunk, t->right->chunk) < 0);
+    /*   Rotation:
+     *     y   -bring left up->  x 
+     *    / \                   / \
+     *   x   c                 a   y
+     *  / \                       / \
+     * a   b <-bring right up-   b   c
+     */
+    if (rotate_left) {
+	y = t;  x = y->left;  c = y->right;  a = x->left;  b = x->right;
+	y->left = b;
+	y->right = c;
+	y->start = y->left ? y->left->start : y->chunk->start;
+	y->end = y->right ? y->right->end : y->chunk->end;
+	x->left = a;
+	x->right = treapify(y); // recurse to check heap constraint
+	x->start = x->left ? x->left->start : x->chunk->start;
+	x->end = x->right ? x->right->end : x->chunk->end;
+	assert(treap_valid(x));
+	return x;
+    } else {
+	x = t;  a = x->left;  y = x->right;  b = y->left;  c = y->right;
+	x->left = a;
+	x->right = b;
+	x->start = x->left ? x->left->start : x->chunk->start;
+	x->end = x->right ? x->right->end : x->chunk->end;
+	y->right = c;
+	y->left = treapify(x); // recurse to check heap constraint.
+	y->start = y->left ? y->left->start : y->chunk->start;
+	y->end = y->right ? y->right->end : y->chunk->end;
+	assert(treap_valid(y));
+	return y;
+    }
+}
+
+/* Use list of chunks to build treap bottom-up, calling treapify to
+ * restore heap order on the subtree after we add each interior node.
+ * This is O(N), where N is the number of chunks. */
+static struct treap *
+build_treap(struct chunklist *cl, int chunk_st, int chunk_end) {
+    struct treap *result;
+    /* Some treaps are trivial to build: */
+    if (chunk_st >= chunk_end) return NULL;
+    /* Claim a chunk in the middle for ourself. */
+    int c = (chunk_st + chunk_end)/2;
+    result = (struct treap *)malloc(sizeof(*result));
+    result->chunk = &(cl->chunk[c]);
+    /* Divide and conquer: build well-formed treaps for our kids.*/
+    result->left = build_treap(cl, chunk_st, c);
+    result->right = build_treap(cl, c+1, chunk_end);
+    result->start = result->left ? result->left->start : result->chunk->start;
+    result->end = result->right ? result->right->end : result->chunk->end;
+    /* Now we need to ensure that the heap constraint is satisfied; that is,
+     * result->chunk->sha1 < result->left->chunk->sha1  and
+     * result->chunk->sha1 < result->right->chunk->sha1.
+     */
+    assert(treap_valid(result->left));
+    assert(treap_valid(result->right));
+    return treapify(result);
+}
+
+static void
+free_treap(struct treap *t) {
+    if (!t) return;
+    free_treap(t->left);
+    free_treap(t->right);
+    free(t);
+}
+
+static int
+treap_depth(struct treap *t) {
+    int l, r;
+    if (!t) return 0;
+    l = treap_depth(t->left);
+    r = treap_depth(t->right);
+    return 1 + ((l > r) ? l : r);
+}
+
+/* Fill in the treap hashes.  This will be O(N ln M), where N is the
+ * file length and M is the number of chunks.  We could actually do
+ * this in 2*N time if the subtree hashes were prefix-identical.
+ * Since we need to include the chunk length in the hash prefix,
+ * we can't reuse the hashing context and we need to pay the extra
+ * O(ln M) factor. */
+static void
+do_treap_hash(struct treap *t, void *data, SHA_CTX *accum, int accum_len) {
+    char prefix[200];
+    SHA_CTX *cp;
+    int i;
+
+    assert(treap_valid(t));
+    if (!t) return;
+
+    /* Start a new treap context. */
+    cp = &(accum[accum_len++]);
+    SHA1_Init(cp);
+    /* Sticking the size in the prefix makes me unhappy. =( */
+    SHA1_Update(cp, prefix, 1+sprintf(prefix, "blob %lu", t->end - t->start));
+    /* Recurse on the left. */
+    do_treap_hash(t->left, data, accum, accum_len);
+    /* Add in our chunk. */
+    for (i=0; i<accum_len; i++)
+	SHA1_Update(accum + i, data + t->chunk->start,
+		    t->chunk->end - t->chunk->start);
+    /* Recurse on the right. */
+    do_treap_hash(t->right, data, accum, accum_len);
+    /* Finalize and write it to t->sha1. */
+    SHA1_Final(t->sha1, cp);
+    /* Done! */
+}
+/* Helper method. */
+static void
+compute_treap_hashes(struct treap *t, void *data) {
+    /* Allocate space for each level of the treap to have its own context. */
+    SHA_CTX contexts[treap_depth(t)];
+    do_treap_hash(t, data, contexts, 0);
+}
+/* Yuck. */
+static const char *
+compute_null_treap_hash() {
+    static const char fixed[] = { "blob 0" };
+    static char sha1[20], *cp=NULL;
+    SHA_CTX c;
+    if (cp) return cp;
+    SHA1_Init(&c);
+    SHA1_Update(&c, fixed, sizeof(fixed));
+    SHA1_Final(sha1, &c);
+    cp = sha1;
+    return cp;
+}
+
+
+/* Now that we've broken it down into treap-structured pieces, let's write
+ * them to the object store. */
+
+/* Write a single treap piece to the object store.  Note that 't' may be
+ * NULL for the special case of a zero-byte file.  Writes the hash of
+ * this piece back to 'sha1', which must be non-NULL. Returns 0 on success.*/
+static int
+write_one(struct treap *t, char *buf) {
+/* two hundred bytes is two 20-byte SHA1 hashes, two presence bytes,
+ * six bytes of type, one null, and plus 10^151 file length. (Conservative.) */
+#define MAX_METADATA_LEN 200
+    z_stream stream;
+    ch_size_t max_out_bytes;
+    ch_size_t chunk_size = t ? (t->chunk->end - t->chunk->start) : 0;
+    ch_size_t content_size, metadata_size;
+    char metadata[MAX_METADATA_LEN];
+    void *out;
+ 
+    /* Calcuate size, create type tag. */
+    content_size = chunk_size;
+    if (t && t->left) content_size += sizeof(t->left->sha1);
+    if (t && t->right) content_size += sizeof(t->right->sha1);
+    metadata_size = 1+sprintf
+	(metadata, "%c %lu", TREAP_TAG(t&&t->left,t&&t->right),
+	 /* optimize saving small files by skipping the 'length' field. */
+	 ((content_size + MAX_METADATA_LEN) < SMALL_FILE_LIMIT) ? 0 :
+	 content_size);
+ 
+    memset(&stream, 0, sizeof(stream));
+    deflateInit(&stream, Z_BEST_COMPRESSION);
+    max_out_bytes = deflateBound(&stream, content_size+metadata_size);
+    out = malloc(max_out_bytes);
+    stream.next_out = out;
+    stream.avail_out = max_out_bytes;
+
+    /* Use left subtree as dictionary to improve compression. */
+    if (t && t->start < t->chunk->start)
+	deflateSetDictionary
+	    (&stream, buf + t->start, t->chunk->start - t->start);
+
+    /* 
+     * Metadata: Type, ASCII size, null byte.
+     */
+    stream.next_in = metadata;
+    stream.avail_in = metadata_size;
+    while (deflate(&stream, 0) == Z_OK)
+	    /* nothing */;
+
+    /*
+     * Chunk content.
+     */
+    stream.next_in = buf + ( t ? t->chunk->start : 0);
+    stream.avail_in = chunk_size; /* possibly zero */
+    while (deflate(&stream, 0) == Z_OK)
+	/* nothing */;
+
+    /*
+     * Append uncompressed hashes to the end.
+     */
+    if (t && (t->left || t->right))
+	/* This is random data; it just expands if you try to compress it. */
+	deflateParams(&stream, Z_NO_COMPRESSION, Z_DEFAULT_STRATEGY);
+    if (t && t->left) { /* left hash */
+	stream.next_in = t->left->sha1;
+	stream.avail_in = sizeof(t->left->sha1);
+	while (deflate(&stream, 0) == Z_OK)
+	    /* nothing */;
+    }
+    if (t && t->right) { /* right hash */
+	stream.next_in = t->right->sha1;
+	stream.avail_in = sizeof(t->right->sha1);
+	while (deflate(&stream, 0) == Z_OK)
+	    /* nothing */;
+    }
+    /* Okay, finish up. */
+    stream.next_in = "";
+    stream.avail_in = 0;
+    while (deflate(&stream, Z_FINISH) == Z_OK)
+	/* nothing */;
+    deflateEnd(&stream);
+
+    return write_sha1_buffer(t ? (const char*) t->sha1 :
+			     compute_null_treap_hash(),
+			     out, stream.total_out);
+}
+
+/* Write all treap nodes to disk. */
+/* Return rightmost chunk in 'dict' if non-null. */
+static int
+write_treap(struct treap *t, char *buf, char *sha1_ret) {
+    const char *sha1 = t ? (const char*)t->sha1 : compute_null_treap_hash();
+    /* Provide sha1 to parent, if asked for. */
+    if (sha1_ret) memcpy(sha1_ret, sha1, sizeof(t->sha1));
+    /* Write us. */
+    if (write_one(t, buf) < 0)
+	return -1; /* failure. */
+    /* We don't need to write children if this already existed. */
+    if (errno == EEXIST) return 0;
+    /* No such luck.  Write our children. */
+    if (t && t->left)
+	if (write_treap(t->left, buf, NULL) < 0)
+	    return -1; /* failure. */
+    if (t && t->right)
+	if (write_treap(t->right, buf, NULL) < 0)
+	    return -1; /* failure. */
+    /* Now write us.  Note t may == NULL for a zero-byte file. */
+    /* Write back sha1, if wanted. */
+    errno = 0;
+    return 0;
+}
+
+static int
+chunky_write_buffer(unsigned char *sha1, void *buffer, unsigned long size,
+		    int force_write) {
+    struct chunklist *cl;
+    struct treap *t;
+    int st = 0;
+    /* We expect there to be 'file length / CHUNK_SIZE' chunks.  Over-estimate
+     * a little, and do the initial chunk list allocation. */
+    cl = create_chunklist(1 + ((3 * size) / (2 * CHUNK_SIZE)));
+    /* Split the file into chunks. */
+    chunkify(cl, buffer, size);
+    /* Build the treap. */
+    t = build_treap(cl, 0, cl->num_items);
+    assert(treap_valid(t));
+    /* Compute all the hashes. */
+    compute_treap_hashes(t, buffer);
+    /* Now write all the pieces, updating SHA1 for this file in the process. */
+    st = write_treap(t, buffer, sha1);
+    if (force_write && st==0 && errno == EEXIST)
+	if (unlink(sha1_file_name(sha1))==0)
+	    st = write_treap(t, buffer, sha1);
+    /* Free everything; we're done. */
+    free_treap(t);
+    free_chunklist(cl);
+    return st;
+}
+
+/* EXPORTED FUNCTION: write the file open on file descriptor 'fd'
+ * and described by 'ce' and 'st' to the object store.   Return
+ * 0 on success, -1 on failure. */
+/* This does the same thing as 'index_fd' in Linus' update-cache.c */
+int
+chunk_index_fd(unsigned char *sha1, int fd, struct stat *st) {
+    char *in; int rc;
+
+    in = "";
+    if (st->st_size)
+	in = mmap(NULL, st->st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+    close(fd);
+    if (in==MAP_FAILED) return -1;
+
+    rc = chunky_write_buffer(sha1, in, st->st_size, 0/* don't force write*/);
+
+    if (st->st_size)
+	munmap(in, st->st_size);
+
+    return rc;
+}
+
+/*** A similar function: this just chunkifies an existing blob. */
+void
+chunkify_blob(void *buffer, unsigned long size, unsigned char *sha1) {
+    unsigned char t[20];
+    chunky_write_buffer(sha1?sha1:t, buffer, size, 1/*force write*/);
+}
+
+
+/*** Functions to read a chunked file into a contiguous buffer. ***/
+
+struct read_chunk {
+    void *chunk_data;
+    ch_size_t chunk_size, total_size;
+    struct read_chunk *left, *right;
+};
+static struct read_chunk *
+read_chunk(const unsigned char *sha1);
+
+static struct read_chunk *
+read_chunk_chunk(const unsigned char *sha1, const char *type, ch_size_t size, void *data) {
+    struct read_chunk *result = malloc(sizeof(*result));
+ 
+    /* Parse the chunk data. */
+    result->left = result->right = NULL;
+    result->chunk_data = data;
+    result->chunk_size = size;
+    if (TREAP_HAS_LEFT(type)) {
+	result->chunk_size -= 20;
+	result->left = read_chunk(result->chunk_data + result->chunk_size);
+	if (!result->left) return NULL; /* error! */
+    }
+    if (TREAP_HAS_RIGHT(type)) {
+	result->chunk_size -= 20;
+	result->right = read_chunk(result->chunk_data + result->chunk_size);
+	if (!result->right) return NULL; /* error! */
+    }
+    result->total_size = result->chunk_size +
+	(result->left ? result->left->total_size : 0) +
+	(result->right ? result->right->total_size : 0);
+    return result;
+}
+static struct read_chunk *
+read_chunk_blob(const unsigned char *sha1, void *data, ch_size_t size) {
+    struct read_chunk *result = malloc(sizeof(*result));
+    result->chunk_data = data;
+    result->chunk_size = result->total_size = size;
+    result->left = result->right = NULL;
+    return result;
+}
+static struct read_chunk *
+read_chunk(const unsigned char *sha1) {
+    void *data;
+    ch_size_t size;
+    char type[10];
+    /* This used to be:
+     * data = read_sha1_file(sha1, type, &size);
+     * But we hacked read_sha1_file to transparently decompress chunks.
+     * So now we need to duplicate a little bit of code. */
+    void *map; unsigned long mapsize;
+    map = map_sha1_file(sha1, &mapsize);
+    if (!map) return NULL;
+    data = unpack_sha1_file(map, mapsize, type, &size);
+    munmap(map, mapsize);
+    /* End duplicate code. */
+    if (!data) return NULL;
+    /* Leaves may be blobs. */
+    if (strcmp(type, "blob")==0)
+	return read_chunk_blob(sha1, data, size);
+    assert(TYPE_IS_TREAP(type));
+    return read_chunk_chunk(sha1, type, size, data); 
+}
+static void
+copy_read_chunk(void *dest, struct read_chunk *rc) {
+    if (rc->left) {
+	copy_read_chunk(dest, rc->left);
+	dest += rc->left->total_size;
+    }
+    memcpy(dest, rc->chunk_data, rc->chunk_size);
+    if (rc->right)
+	copy_read_chunk(dest + rc->chunk_size, rc->right);
+}
+static void
+free_read_chunk(struct read_chunk *rc) {
+    if (rc->left) free_read_chunk(rc->left);
+    if (rc->right) free_read_chunk(rc->right);
+    free(rc->chunk_data);
+    free(rc);
+}
+
+/* This is called from 'read_sha1_file' in sha1_file.c as a
+ * 'post-processor' when a 'chunk' type file is found.  It will
+ * transparently stitch together the appropriate prefix and suffix
+ * chunks and pass the result off as a 'blob'. */
+void *
+chunk_read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size, void *chunkdata) {
+    struct read_chunk *rc;
+    void *result;
+    assert(TYPE_IS_TREAP(type));
+    /* This is a 'chunk' object; get the rest of the pieces. */
+    rc = read_chunk_chunk(sha1, type, *size, chunkdata);
+    if (!rc) return NULL; /* error! */
+    /* Now concatenate them together. */
+    strcpy(type, "blob");
+    *size = rc->total_size;
+    result = malloc(*size);
+    copy_read_chunk(result, rc);
+    /* done! */
+    free_read_chunk(rc);
+    return result;
+}
+
+#if 0
+/* Exercise this code. */
+int main(int argc, char **argv) {
+    struct cache_entry ce;
+    struct stat st;
+    char *buf, type[10];
+    unsigned long size;
+    int fd;
+    fd = open(argv[1], O_RDONLY);
+    if (fd < 0) exit(1);
+    if (fstat(fd, &st) < 0) exit(1);
+    if (chunk_index_fd(ce.sha1, fd, &st) < 0) exit(1);
+    printf("Wrote file %s.\n", sha1_to_hex(ce.sha1));
+    /* seemed to work! */
+    buf = read_sha1_file(ce.sha1, type, &size);
+    if (!buf) exit(1);
+    printf("Read file %s, of type %s (%lu bytes):\n",
+	   sha1_to_hex(ce.sha1), type, size);
+    fwrite(buf, size, 1, stdout);
+    /* done! */
+    return 0;
+}
+#endif
--- /dev/null	2005-04-20 20:21:45.319868048 -0400
+++ git.repo/chunk.h	2005-04-21 22:11:53.000000000 -0400
@@ -0,0 +1,27 @@
+#ifndef CHUNK_H
+#define CHUNK_H
+
+#define TYPE_IS_TREAP(type) \
+   ({char*_ty=(type); _ty[0] >= '0' && _ty[0] <= '3' && !_ty[1];})
+
+#define TREAP_TAG(has_left,has_right) \
+   ('0' + ((has_left)?2:0) + ((has_right)?1:0))
+#define TREAP_HAS_LEFT(tag) ((tag)[0]&2)
+#define TREAP_HAS_RIGHT(tag) ((tag)[0]&1)
+
+extern int
+chunk_index_fd(unsigned char *sha1, int fd, struct stat *st);
+
+void *
+chunk_read_sha1_file(const unsigned char *sha1, char *type,
+		     unsigned long *size, void *result);
+
+void
+chunkify_blob(void *buffer, unsigned long size, unsigned char *sha1);
+
+/* Avoid encoding the file length explicitly for files smaller than this.
+ * Should always be large enough to hold all the file metadata (type, length
+ * in ASCII, and a null byte) at least. */
+#define SMALL_FILE_LIMIT 16384
+
+#endif /* CHUNK_H */
--- /dev/null	2005-04-20 20:21:45.319868048 -0400
+++ git.repo/chunktest.c	2005-04-20 14:49:46.000000000 -0400
@@ -0,0 +1,25 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "chunk.h"
+
+/* Exercise this code. */
+int main(int argc, char **argv) {
+    struct cache_entry ce;
+    struct stat st;
+    char *buf, type[10];
+    unsigned long size;
+    int fd;
+    fd = open(argv[1], O_RDONLY);
+    if (fd < 0) exit(1);
+    if (fstat(fd, &st) < 0) exit(1);
+    if (chunk_index_fd(ce.sha1, fd, &st) < 0) exit(1);
+    printf("Wrote file %s.\n", sha1_to_hex(ce.sha1));
+    /* seemed to work! */
+    buf = read_sha1_file(ce.sha1, type, &size);
+    if (!buf) exit(1);
+    printf("Read file %s, of type %s (%lu bytes):\n",
+	   sha1_to_hex(ce.sha1), type, size);
+    fwrite(buf, size, 1, stdout);
+    /* done! */
+    return 0;
+}
