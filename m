From: "C. Scott Ananian" <cscott@cscott.net>
Subject: final report: chunking
Date: Fri, 6 May 2005 13:48:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0505061249510.26267@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri May 06 19:46:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU6tI-0000ip-GY
	for gcvg-git@gmane.org; Fri, 06 May 2005 19:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVEFRwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEFRwQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 13:52:16 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:15085 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261229AbVEFRsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 13:48:20 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DU6vz-0000xM-00
	for <git@vger.kernel.org>; Fri, 06 May 2005 13:48:19 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

So it looks like the xdelta/zdelta approach is the clear win for 
repository compression.  I had been working on a merkle-hash-treap 
chunking scheme, and I thought I'd present my results for the record, even 
though the benefits turned out to be not-that-great.

Basically, the chunking scheme aims to save space by only storing *one* 
copy of each unique 'chunk' in the file.  The chunking points are decided 
using a content-sensitive checksum over a window, so 
additions/deletions/mutations of the file won't cause all the chunking 
points to move.  The chunks are then arranged in a heap-structured tree 
(treap) with content stored in the nodes as well as at the leaves, so 
that: 1) a one-chunk file stays in one file (there's no a separate 'chunk 
index'), and 2) versions of the file while share entire subtrees of chunks 
can share those subtrees.

Space savings are expected due to the chunk-treap sharing; balanced 
against increases in space caused by:
  1) filesystem blocking (small files waste space)
  2) headers on each chunk (more of a problem the smaller the chunks get)
and
  3) zlib compression doesn't work as well on small chunks as it does on
     large files.

The last was addressed by realizing that interior nodes of the tree can 
use their entire left subtree as a zlib 'dictionary', which greatly 
improves compression efficiency.  The tree structure constrains this:
about half of the nodes are expected to be leaves, which can't use 
dictionaries, another 1/4 are on level up, so they can only use a 
single-chunk dictionary, etc.  Nevertheless, this dictionary hack 
basically solves the issue, at little cost in decompression time.

The 'chunk headers' issue was addressed by using a very efficient chunk 
representation.  The 'type' of the chunk was set to the one-character 
string '0', '1', '2', or '3' (depending on whether it had left/right 
children), and the SHA1 of the child chunks was suffixed to the end of the 
file in binary form, so that zlib wouldn't try to 'compress' this 
uncompressible data.

Using a benchmark repository consisting of all released versions of the 
2.4, 2.5, and 2.6 kernels, using these two techniques the repository was 
compressed from 821 Mb in 176,251 files to 802 Mb in 337,273 files, using
a 'expected chunk size' of 16,381 bytes.  (I ran benchmarks with chunk 
sizes ranging from ~500 bytes to ~65k bytes; this was the best.)
For this 2% 'ideal' (or 'network') size improvement, the 'real' disk space 
(on an ext3 filesystem) increased from 1.2G to 1.6G.

The 'rolling checksum' scheme of chunking files yields a geometric size 
distribution, which is rather suboptimal, as you have lots of very small 
pieces and a long tail extending to rather large chunk sizes.  You'd 
rather have something like a normal distribution centered around something 
just shy of a disk block.  Further, since chunking is done before 
compression, the compressed chunk sizes are very unpredictable.  This 
makes it hard to pack them efficiently in disk blocks.

Also, it's not clear that a 'binary' tree structure is best; most on-disk 
structures benefit from higher arity.

So, the final improvement to the algorithm was to 'block' subtrees 
together so that their *compressed* size was as large as possible w/o 
overflowing the 'block size'.  This necessitated a tweak to the on-disk 
block header format as well.  The algorithm was then much less sensitive 
to 'chunk size', although a number of chunk sizes and block sizes were 
benchmarked.  On the same respository as described before, the best space 
savings were obtained using an expected average chunk size of 16,381 
bytes, and a 4k 'block size'.  This yielded 275,105 files taking up 803 Mb 
ideal/network, and 1.4Gb 'real' ext3 disk space.

I've got a lot more numbers, if anyone is interested.

Note that I'd expect to do slightly better on the benchmarks if I were 
looking at 'smaller' changesets.  Since I'm only looking at 'released' 
kernels, the changes between one version of the file and the next are 
rather big, which means a rather larger number of chunks are unshareable 
between versions.
  --scott

jihad Sugar Grove LCPANES QKFLOWAGE ESSENCE milita TASS Marxist Justice 
BOND HTPLUME JMTIDE JMWAVE MHCHAOS security Saddam Hussein genetic
                          ( http://cscott.net/ )
------
This is the code, against (ancient) git head
5750e913cfe75e20d0bbee4e368b6f1321014877

--- /dev/null	2005-04-27 10:20:44.511990864 -0400
+++ git.repo/chunk.c	2005-05-06 09:54:06.529832174 -0400
@@ -0,1 +1,900 @@
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
+#define ROLLING_WINDOW 33
+/* The ideal chunk size will fit most chunks into a disk block.  A typical
+ * disk block size is 4k, and we expect (say) 50% compression. */
+/* some primes: 61 127 251 509 1021 2039 4091 8191 16381 32749 65521 */
+//#define CHUNK_SIZE 7901 /* primes are nice to use */
+#define CHUNK_SIZE 16381
+/* This is the ideal size of a compressed on-disk chunk, which will include
+ * several CHUNK_SIZE pieces.  Typically larger than CHUNK_SIZE. */
+#define FILE_BLOCK_SIZE 4096
+
+#define WINDOW_MAGIC 0x0000 /* less than CHUNK_SIZE */
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
+    /* is this the root of a 'large enough' run? */
+    int block_root;
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
+ * whose size averages out to be 'CHUNK_SIZE' (nice if this is a prime).
+ * Note however that we get a geometric distribution of chunk sizes, with
+ * a preponderance of 'small' chunks, and a very long tail occassionally
+ * yielding very large chunks.   Our later treap-blocking pass attempts to
+ * normalize this somewhat by lumping together small chunks. */
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
+ *  smallest hash key; its left child will be the chunk with the smallest
+ *  hash among those chunks before the root in file order; and so on
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
+    /*   Rotation: (note that tree order is maintained)
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
+    result->block_root = 0;
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
+    if (t->block_root) {
+	/* Start a new treap context. */
+	cp = &(accum[accum_len++]);
+	SHA1_Init(cp);
+	/* Sticking the size in the prefix makes me unhappy. =( */
+	SHA1_Update
+	    (cp, prefix, 1+sprintf(prefix, "blob %lu", t->end - t->start));
+    }
+    /* Recurse on the left. */
+    do_treap_hash(t->left, data, accum, accum_len);
+    /* Add in our chunk. */
+    for (i=0; i<accum_len; i++)
+	SHA1_Update(accum + i, data + t->chunk->start,
+		    t->chunk->end - t->chunk->start);
+    /* Recurse on the right. */
+    do_treap_hash(t->right, data, accum, accum_len);
+    /* Finalize and write it to t->sha1. */
+    if (t->block_root)
+	SHA1_Final(t->sha1, cp);
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
+/* Chunk-blocking code. */
+/* Traverse tree in-order to find largest subtrees whose compressed stream
+ * is less than FILE_BLOCK_SIZE. */
+struct block_info {
+    z_stream z_ctxt; /* compression state (dictionaries, etc) */
+    int size; /* size of the compressed subtree, including header info */
+    int has_data; /* have we put anything in this block yet? */
+};
+#define SIZE_IS_OKAY(block) ((block)->size < (FILE_BLOCK_SIZE-20/*slop*/))
+
+static void
+init_block(struct block_info *block, int is_reset) {
+    if (is_reset) {
+	deflateReset(&(block->z_ctxt));
+	block->has_data = 0;
+    } else {
+	memset(block, 0, sizeof(*block));
+	deflateInit(&(block->z_ctxt), Z_BEST_COMPRESSION);
+    }
+    /* 1 byte blocked-chunk header, possible leading/trailing zeros */
+    block->size = 3;
+}
+
+static void
+block_add_chunk(struct chunk *c, void *data, struct block_info *block) {
+    char buf[512];
+    block->z_ctxt.next_in = data + c->start;
+    block->z_ctxt.avail_in = c->end - c->start;
+    while (SIZE_IS_OKAY(block)) {
+	block->z_ctxt.next_out = buf;
+	block->z_ctxt.avail_out = sizeof(buf);
+	if (deflate(&(block->z_ctxt), 0)!=Z_OK) break; // done.
+	block->size += sizeof(buf) - block->z_ctxt.avail_out;
+    }
+    block->size += 2; // chunk size bytes (estimate)
+    block->has_data = 1;
+}
+static void
+block_add_treap_chunk(struct treap *t, void *data, struct block_info *block) {
+    if (t->left && !block->has_data) // use better dictionary.
+	deflateSetDictionary(&(block->z_ctxt), data + t->left->start,
+			     t->left->end - t->left->start);
+    block_add_chunk(t->chunk, data, block);
+}
+
+static void
+block_add_subtree(struct treap *t, void *data, struct block_info *block) {
+    if (!SIZE_IS_OKAY(block)) return; // bail early
+    if (t==NULL) return;
+    if (t->block_root) {
+	block->size+=20; // SHA for the omitted root
+	return;
+    }
+    if (t->left)
+	block_add_subtree(t->left, data, block);
+    block_add_chunk(t->chunk, data, block);
+    if (t->right)
+	block_add_subtree(t->right, data, block);
+}
+
+static void
+copy_finish_and_free(struct block_info *dst, struct block_info *src) {
+    char buf[512];
+    if (dst) {
+	*dst = *src;
+	deflateCopy(&(dst->z_ctxt), &(src->z_ctxt));
+    }
+    while (SIZE_IS_OKAY(src)) {
+	src->z_ctxt.next_out = buf;
+	src->z_ctxt.avail_out = sizeof(buf);
+	if (deflate(&(src->z_ctxt), Z_FINISH)!=Z_OK) break; // done.
+	src->size += sizeof(buf) - src->z_ctxt.avail_out;
+    }
+    deflateEnd(&(src->z_ctxt));
+}
+
+/* Mark subtrees such that each can be represented on disk in no more than
+ * FILE_BLOCK_SIZE bytes.  (Oversized chunks might create larger blocks.)
+ * Return size and compression context information about the subtree rooted
+ * at 't' in 'block', which should represent an empty block when this function
+ * is invoked. */
+static void
+block_mark_treap_roots(struct treap *t, void *data,
+		       struct block_info *block, int leave_open) {
+    struct block_info empty_block, copy_block, copy2_block;
+    assert(!block->has_data);
+    assert(t);
+
+    /* Recurse on the left.  On return, 'block' will contain the compressed
+     * size of the left subtree (excluding already-blocked subtrees). */
+    if (t->left)
+	block_mark_treap_roots(t->left, data, block, 1);
+
+    if (SIZE_IS_OKAY(block)) /* skip this if we're going to redo it anyway */
+	block_add_treap_chunk(t, data, block);
+    else assert (t->left);
+
+    if (t->left) {
+	copy_finish_and_free(&copy_block, block);
+	if (!SIZE_IS_OKAY(block)) {
+	    /* Left subtree plus this chunk doesn't fit in a block.  Make
+	     * left subtree a block root. */
+	    t->left->block_root = 1;
+	    deflateEnd(&(copy_block.z_ctxt));
+	    init_block(block, 0);
+	    block->size += 20; /* reserve space to reverse left-hand block */
+	    block_add_treap_chunk(t, data, block);
+	} else
+	    *block = copy_block;
+    }
+
+    /* Recurse on the right, creating blocks as necessary. */
+    if (!t->right) {
+	if (!leave_open) deflateEnd(&(block->z_ctxt));
+	return; /* save some work: we're done already */
+    }
+    init_block(&empty_block, 0);
+    block_mark_treap_roots(t->right, data, &empty_block, 0);
+
+    /* Now that we've marked subtrees on the right, add unmarked chunks to
+     * our current block, then check our size. */
+
+    if (!SIZE_IS_OKAY(block)) {
+	if (!leave_open) deflateEnd(&(block->z_ctxt));
+	goto skip_deflate; /* avoid doing unnecessary work */
+    }
+    /* save a copy of our block state, in case this doesn't work out */
+    if (leave_open) {
+	copy2_block = *block;
+	deflateCopy(&(copy2_block.z_ctxt), &(block->z_ctxt));
+    }
+    /* okay, add the chunks on the right to this block */
+    block_add_subtree(t->right, data, block);
+
+    copy_finish_and_free(leave_open ? &copy_block : NULL, block);
+    if (SIZE_IS_OKAY(block)) {
+	if (!leave_open) return;
+	deflateEnd(&(copy2_block.z_ctxt)); /* free saved state */
+	*block = copy_block;
+    } else {
+	if (!leave_open) goto skip_deflate;
+	/* Didn't work out; restore our block state */
+	deflateEnd(&(copy_block.z_ctxt));
+	*block = copy2_block;
+    skip_deflate:
+	/* Right-hand subtree didn't fit.  Make it a block root. */
+	t->right->block_root = 1;
+	block->size += 20; /* Space needed for the reference */
+    }
+
+    /* done! */
+}
+static void
+mark_block_roots(struct treap *t, void *data) {
+    struct block_info empty_block;
+    if (!t) return;
+    init_block(&empty_block, 0);
+    block_mark_treap_roots(t, data, &empty_block, 0);
+    t->block_root = 1; /* topmost block */
+}
+
+
+/* Now that we've broken it down into blocked treap-structured pieces, let's
+ * write them to the object store. */
+
+/* Write as 0x50 ( <size> <hash> )* <size> <compressed content>
+ * where <size> is 7 bit chunks of the big-endian (size*2), with the MSB set
+ * on all but the last chunk, and the LSB of the last chunk set unless
+ * this is the last <size> in the header.  <hash> is a 20-byte SHA-1
+ * hash, of course.  The contents should be reconstituted by weaving together
+ * <size> bytes of the uncompressed content, the contents of the
+ * referenced block/blob, the next <size> bytes of the uncompressed content,
+ * and so on. */
+
+static void
+emit_num(ch_size_t num, unsigned char **buf, unsigned char *buf_end) {
+    unsigned char scratch[sizeof(num)*2];
+    int i;
+    for (i=0; num>0 || i==0; num>>=7, i++)
+	scratch[i] = 0x80 | (num & 0x7F);
+    scratch[0] &= 0x7F; /* zero indicates 'last byte' */
+    for (i--; i>=0; i--, (*buf)++)
+	if (*buf < buf_end)
+	    **buf = scratch[i];
+}
+
+/* returns the uncompressed size of this block's data, and the header space
+ * needed (indirectly, in buf). */
+static int
+write_block_header(struct treap *t,
+		   unsigned char **buf, unsigned char *buf_end,
+		   ch_size_t *trailing_chunk, int follow) {
+    ch_size_t csz = t->chunk->end - t->chunk->start, sz=csz;
+    assert(t);
+    /* write the left-hand header */
+    if (follow && t->left)
+	sz += write_block_header(t->left, buf, buf_end, trailing_chunk, !t->left->block_root);
+
+    /* now write us. */
+    if (follow)
+	*trailing_chunk += csz;
+    else {
+	assert(t->block_root);
+	/* emit chunk size (even if zero) */
+	emit_num(((*trailing_chunk)<<1) | 1, buf, buf_end);
+	*trailing_chunk = 0;
+	/* emit sha1 hash */
+	if (*buf + sizeof(t->sha1) < buf_end)
+	    memcpy(*buf, t->sha1, sizeof(t->sha1));
+	*buf += sizeof(t->sha1);
+    }
+
+    /* write the right-hand header */
+    if (follow && t->right)
+	sz += write_block_header(t->right, buf, buf_end, trailing_chunk, !t->right->block_root);
+
+    /* write trailing size (even if zero) if this is the topmost call */
+    if (follow && t->block_root)
+	emit_num((*trailing_chunk)<<1, buf, buf_end);
+
+    /* done */
+    return follow ? sz : 0;
+}
+static void
+write_block_data(struct treap *t, char *data, z_streamp streamp, int first,
+		 int bufsize) {
+    /* Write left-hand block data */
+    if (t->left && !t->left->block_root) {
+	write_block_data(t->left, data, streamp, first, bufsize);
+	first = 0;
+    }
+    /* Compress this chunk */
+    if (first && t->left) {
+	/* Use left subtree as dictionary to improve compression. */
+	assert(t->left->block_root);
+	deflateSetDictionary(streamp, data + t->left->start,
+			     t->left->end - t->left->start);
+    }
+    streamp->next_in = data + t->chunk->start;
+    streamp->avail_in = t->chunk->end - t->chunk->start;
+    while (streamp->avail_in > 0 && deflate(streamp, 0) == Z_OK)
+	if (streamp->avail_out==0) {
+		streamp->next_out -= bufsize;
+		streamp->avail_out = bufsize;
+	}
+    /* Write right-hand block data */
+    if (t->right && !t->right->block_root)
+	write_block_data(t->right, data, streamp, 0, bufsize);
+}
+
+/* Write a single treap block to the object store.  */
+static int
+write_one(struct treap *t, char *data) {
+    z_stream stream;
+    int n;
+ 
+    assert(t); assert(data);
+
+    memset(&stream, 0, sizeof(stream));
+    deflateInit(&stream, Z_BEST_COMPRESSION);
+
+    for (n=FILE_BLOCK_SIZE; ;) {
+	unsigned char buf[n], *cp=buf, *buf_end=buf+sizeof(buf);
+	ch_size_t zero = 0;
+	int sz;
+
+	/* This is a little tricky: all zlib streams start with 0xW8, where W
+	 * is usually '7'.  Write a tag byte which can be differentiated
+	 * from this. */
+	assert(n>0);
+	*cp++ = BLOCK_HEADER_BYTE;
+	/* Now write the header (chunk sizes and block references). */
+	sz = write_block_header(t, &cp, buf_end, &zero, 1);
+	/* If we didn't allocate enough space the first time, go back and
+	 * do so now. */
+	if (cp > buf_end) {
+	    n = (cp-buf)+deflateBound(&stream, sz);
+	    continue;
+	}
+	/* Now let's compress our chunk content. */
+	stream.next_out = cp;
+	stream.avail_out = buf_end - cp;
+	stream.total_out = cp-buf;
+	write_block_data(t, data, &stream, 1, n);
+	/* Finish off the zlib stream (write trailer). */
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+	    if (stream.avail_out==0) {
+		stream.next_out = buf;
+		stream.avail_out = sizeof(buf);
+	    }
+	/* If we didn't allocate enough space, go back and do so now. */
+	if (stream.total_out > n) {
+	    n = stream.total_out;
+	    deflateReset(&stream);
+	    continue;
+	}
+	/* hey, success! our block data is in 'buf' */
+	deflateEnd(&stream);
+	return write_sha1_buffer(t->sha1, buf, stream.total_out);
+    }
+}
+
+/* Write all treap blocks to disk. */
+static int
+write_block(struct treap *t, char *buf, char *sha1_ret) {
+    const char *sha1 = t ? (const char*)t->sha1 : compute_null_treap_hash();
+    /* Provide sha1 to parent, if asked for. */
+    if (sha1_ret) memcpy(sha1_ret, sha1, sizeof(t->sha1));
+    /* Write us, if we're a block root. */
+    if (t==NULL) {
+	unsigned char empty_block[] = { BLOCK_HEADER_BYTE, 0 };
+	return write_sha1_buffer(sha1, empty_block, sizeof(empty_block));
+    }
+    if (t->block_root) {
+	if (write_one(t, buf) < 0)
+	    return -1; /* failure. */
+	/* We don't need to write children if this already existed. */
+	if (errno == EEXIST) return 0;
+    }
+    /* No such luck.  Write our children. */
+    if (t->left)
+	if (write_block(t->left, buf, NULL) < 0)
+	    return -1; /* failure. */
+    if (t->right)
+	if (write_block(t->right, buf, NULL) < 0)
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
+    /* Block it. */
+    mark_block_roots(t, buffer);
+    /* Compute all the hashes. */
+    compute_treap_hashes(t, buffer);
+    /* Now write all the pieces, updating SHA1 for this file in the process. */
+    st = write_block(t, buffer, sha1);
+    if (force_write && st==0 && errno == EEXIST)
+	if (unlink(sha1_file_name(sha1))==0)
+	    st = write_block(t, buffer, sha1);
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
+struct read_block {
+    void *block_map, *chunk_start;
+    ch_size_t mapsize, total_size;
+    unsigned num_refs;
+    struct read_block *ref[0];
+};
+static void
+free_read_block(struct read_block *rb) {
+    int i;
+    for (i=0; i<rb->num_refs; i++)
+	free_read_block(rb->ref[i]);
+    if (rb->block_map) munmap(rb->block_map, rb->mapsize);
+    free(rb);
+}
+static struct read_block *read_block_header_map(void *, ch_size_t);
+
+static struct read_block *
+read_block_header(unsigned char *sha1) {
+    void *block_map;
+    ch_size_t mapsize;
+    /* Memory map block file. */
+    block_map = map_sha1_file(sha1, &mapsize);
+    if (!block_map) return NULL; /* error! */
+    // XXX should check & accept blobs, too.
+    return read_block_header_map(block_map, mapsize);
+}
+static struct read_block *
+read_block_header_map(void *block_map, ch_size_t mapsize) {
+    struct read_block *result;
+    ch_size_t sz;
+    unsigned char *cp;
+    unsigned num_refs;
+
+    assert(PACKED_IS_BLOCK(block_map, mapsize));
+    /* Count the number of external references. */
+    for (cp=block_map+1, num_refs=0; *cp & 0x81 ; cp++)
+	if (!(*cp & 0x80)) cp+=20, num_refs++;
+    /* Allocate the result */
+    result = malloc(sizeof(*result) + num_refs*sizeof(*(result->ref)));
+    result->block_map = block_map;
+    result->chunk_start = (cp+1);
+    result->mapsize = mapsize;
+    result->num_refs = num_refs;
+    result->total_size = 0;
+    /* Now calculate size (and recurse to create read_block tree) */
+    for (cp=block_map+1, num_refs=0, sz=0; ; cp++) {
+	sz = (sz<<7) | (*cp & 0x7F);
+	if (0 == (*cp & 0x80)) {
+	    result->total_size += (sz>>1); /* ignore lsb */
+	    sz = 0; /* reset */
+	    if (0 == (*cp & 1)) break; /* done */
+	    result->ref[num_refs] = read_block_header(cp+1);
+	    if (!result->ref[num_refs]) return NULL; /* error! */
+	    result->total_size += result->ref[num_refs]->total_size;
+	    num_refs++; cp+=20;
+	}
+    }
+    /* Done. */
+    return result;
+}
+
+/* Decompress data and copy it to the output buffer, starting at 'offset'. */
+static void
+read_block_data(struct read_block *rb, void *buffer) {
+    z_stream stream;
+    unsigned char *cp;
+    unsigned num_refs;
+    ch_size_t sz;
+    memset(&stream, 0, sizeof(stream));
+    stream.next_in = rb->chunk_start;
+    stream.avail_in = (rb->block_map + rb->mapsize) - rb->chunk_start;
+    stream.next_out = buffer;
+    stream.avail_out = 0;
+    inflateInit(&stream);
+    for (cp=rb->block_map+1, num_refs=0, sz=0; ; cp++) {
+	sz = (sz<<7) | (*cp & 0x7F);
+	if (0 == (*cp & 0x80)) {
+	    /* decompress 'sz>>1' bytes. */
+	    stream.avail_out = (sz>>1);
+	    while (stream.avail_out > 0)
+		switch(inflate(&stream, 0)) {
+		case Z_NEED_DICT:
+		    /* use previous chunk as dictionary */
+		    assert(num_refs>0);
+		    sz = rb->ref[num_refs-1]->total_size;
+		    inflateSetDictionary(&stream, stream.next_out-sz, sz);
+		    break;
+		case Z_OK: case Z_STREAM_END: break;
+		default:
+		    return; /* error! bail. */
+		}
+	    sz = 0; /* reset */
+	    if (0 == (*cp & 1)) break; /* done */
+	    /* splice in referenced chunk */
+	    read_block_data(rb->ref[num_refs], stream.next_out);
+	    stream.next_out += rb->ref[num_refs]->total_size;
+	    num_refs++; cp+=20;
+	}
+    }
+}
+
+/* This is called from unpack_sha1_file in sha1_file.c as a lookaside
+ * when a 'block' type file is found.  It will transparently stick
+ * together the prefix and suffix chunks and pass the result off as a
+ * 'blob'. */
+void * unpack_block_file(void *map, unsigned long mapsize, char *type, unsigned long *size) {
+    struct read_block *rb;
+    void *result;
+    assert(PACKED_IS_BLOCK(map, mapsize));
+    /* This is a 'blocked-chunk' object; get the rest of the pieces. */
+    rb = read_block_header_map(map, mapsize);
+    if (!rb) return NULL; /* error! */
+    /* Now concatenate them together. */
+    strcpy(type, "blob");
+    *size = rb->total_size;
+    result = malloc(*size);
+    read_block_data(rb, result);
+    /* done! */
+    rb->block_map = NULL; /* don't unmap top-level block memory */
+    free_read_block(rb);
+    return result;
+
+}
+
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
--- /dev/null	2005-04-27 10:20:44.511990864 -0400
+++ git.repo/chunk.h	2005-05-03 13:27:12.000000000 -0400
@@ -0,0 +1,27 @@
+#ifndef CHUNK_H
+#define CHUNK_H
+
+/* note: zlib streams all start with 0xW8YZ, where W is usually 7, and
+ * (0xW8YZ % 31) is zero.  We will start with a distinguishable header
+ * byte. */
+
+#define BLOCK_HEADER_BYTE (0x50) /* low nybble must not be '8' */
+#define PACKED_IS_BLOCK(map,mapsize) \
+	((mapsize) > 0 && BLOCK_HEADER_BYTE == (*((unsigned char*)(map))))
+
+extern int
+chunk_index_fd(unsigned char *sha1, int fd, struct stat *st);
+
+void *
+unpack_block_file(void *map, unsigned long mapsize,
+		  char *type, unsigned long *size);
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
diff -ruHp -x .dircache -x .git -x '*.o' -x '*~' -x 'blow-chunks.?.*' git.repo.orig/Makefile git.repo/Makefile
--- git.repo.orig/Makefile	2005-04-21 15:45:39.000000000 -0400
+++ git.repo/Makefile	2005-05-03 15:01:03.000000000 -0400
@@ -16,16 +17,17 @@ AR=ar
  PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
  	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
  	check-files ls-tree merge-base merge-cache unpack-file git-export \
-	diff-cache convert-cache
+	diff-cache convert-cache \
+	blow-chunks

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
@@ -91,7 +93,11 @@ diff-cache: diff-cache.o $(LIB_FILE)
  convert-cache: convert-cache.o $(LIB_FILE)
  	$(CC) $(CFLAGS) -o convert-cache convert-cache.o $(LIBS)

+blow-chunks: blow-chunks.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
+blow-chunks.o chunk-ref.o chunk-size.o: $(LIB_H)
+
  blob.o: $(LIB_H)
  cat-file.o: $(LIB_H)
  check-files.o: $(LIB_H)
diff -ruHp -x .dircache -x .git -x '*.o' -x '*~' -x 'blow-chunks.?.*' git.repo.orig/sha1_file.c git.repo/sha1_file.c
--- git.repo.orig/sha1_file.c	2005-04-21 15:45:41.000000000 -0400
+++ git.repo/sha1_file.c	2005-05-03 12:59:21.000000000 -0400
@@ -8,6 +8,7 @@
   */
  #include <stdarg.h>
  #include "cache.h"
+#include "chunk.h"

  const char *sha1_file_directory = NULL;

@@ -120,8 +121,13 @@ void * unpack_sha1_file(void *map, unsig
  {
  	int ret, bytes;
  	z_stream stream;
 	char buffer[8192];
  	char *buf;

+	/* Specially-process 'chunk' files. */
+	if (PACKED_IS_BLOCK(map, mapsize))
+	    return unpack_block_file(map, mapsize, type, size);
+
  	/* Get the data stream */
  	memset(&stream, 0, sizeof(stream));
  	stream.next_in = map;
@@ -215,6 +225,7 @@ int write_sha1_file(char *buf, unsigned

  	if (write(fd, compressed, size) != size)
  		die("unable to write file");
+	free(compressed);
  	close(fd);

  	return 0;
@@ -259,9 +270,11 @@ int write_sha1_buffer(const unsigned cha
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
@@ -113,8 +120,8 @@ static int add_file_to_cache(char *path)
  	ce->ce_mode = create_ce_mode(st.st_mode);
  	ce->ce_flags = htons(namelen);

-	if (index_fd(ce->sha1, fd, &st) < 0)
+	if (chunk_index_fd(ce->sha1, fd, &st) < 0)
  		return -1;

  	return add_cache_entry(ce, allow_add);
--- /dev/null	2005-04-27 10:20:44.511990864 -0400
+++ git.repo/blow-chunks.c	2005-04-20 21:33:33.000000000 -0400
@@ -0,1 +1,35 @@
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
