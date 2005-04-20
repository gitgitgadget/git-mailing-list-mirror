From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Blob chunking code. [Second look]
Date: Wed, 20 Apr 2005 13:31:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201325550.2630@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com>
 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com>
 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
 <Pine.LNX.4.61.0504200917070.28851@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Wed Apr 20 19:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOJ2Y-0005qN-DR
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVDTRfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVDTRfO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:35:14 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:43673 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261774AbVDTRbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 13:31:20 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOJ2k-0001O9-00
	for <git@vger.kernel.org>; Wed, 20 Apr 2005 13:31:18 -0400
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0504200917070.28851@cag.csail.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's a quick rev of the chunking code.  This is compatible with 
git-current, where the hashes are of the *uncompressed* file.
The 'chunk' file gets dropped in at the same SHA1 filename as the
'blob' file, as it represents identical contents.  Martin won't like
this (because of how the hash is computed), but this is the short-term
direction I want to pursue to validate the concept: it means I can
run a simple converter over all the blob objects and don't have to
rewrite tree and commit objects.

If the approach is seen to have merit, then we can perhaps think about 
doing another bulk repository format conversion where all the hashes
change.  But (IMO) it's a little early to be thinking of this yet.
  --scott

nuclear RUCKUS KUPALM ODACID LA STANDEL Mossad LITEMPO atomic mail drop 
Hussein JUBILIST class struggle SSBN 731 Bush quiche Nazi MKULTRA
                          ( http://cscott.net/ )
---------  chunk.c ----------
/*
  * This file implements a treap-based chunked content store.  The
  * idea is that every stored file is broken down into tree-structured
  * chunks (that is, every chunk has an optional 'prefix' and 'suffix'
  * chunk), and these chunks are put in the object store.  This way
  * similar files will be expected to share chunks, saving space.
  * Files less than one disk block long are expected to fit in a single
  * chunk, so there is no extra indirection overhead for this case.
  *
  * Copyright (C) 2005 C. Scott Ananian <cananian@alumni.princeton.edu>
  */

/*
  * We assume that the file and the chunk information all fits in memory.
  * A slightly more-clever implementation would work even if the file
  * didn't fit.  Basically, we could scan it an keep the
  * 'N' lowest heap keys (chunk hashes), where 'N' is chosen to fit
  * comfortably in memory.  These would form the root and top
  * of the resulting treap, constructing it top-down.  Then we'd scan
  * again any only keep the next 'N' lowest heap keys, etc.
  *
  * But we're going to keep things simple.  We do try to maintain locality
  * where possible, so if you need to swap things still shouldn't be too bad.
  */

#include <assert.h>
#include <stdlib.h>
#include "cache.h"
#include "chunk.h"

typedef unsigned long ch_size_t;

/* Our magic numbers: these can be tuned without breaking files already
  * in the archive, although space re-use is only expected between files which
  * have these constants set to the same values. */

/* The window size determines how much context we use when looking for a
  * chunk boundary.
  * C source has approx 5 bits per character of entropy.
  * We'd like to get 32 bits of good entropy into our boundary checksum;
  * that means 7 bytes is a rough minimum for the window size.
  * 30 bytes is what 'rsyncable zlib' uses; that should be fine. */
#define ROLLING_WINDOW 30
/* The ideal chunk size will fit most chunks into a disk block.  A typical
  * disk block size is 4k, and we expect (say) 50% compression. */
#define CHUNK_SIZE 7901 /* primes are nice to use */

/* Data structures: */
struct chunk {
     /* a chunk represents some range of the underlying file */
     ch_size_t start /* inclusive */, end /*exclusive*/;
     unsigned char sha1[20]; /* sha1 for this chunk; used as the heap key */
};
struct chunklist {
     /* a dynamically-sized list of chunks */
     struct chunk *chunk; /* an array of chunks */
     ch_size_t num_items; /* how many items are currently in the list */
     ch_size_t allocd;    /* how many items we've allocated space for */
};
struct treap {
     /* A treap node represents a run of consecutive chunks. */

     /* the start and end of the run: */
     ch_size_t start /* inclusive */, end /*exclusive*/;
     struct chunk *chunk; /* some chunk in the run. */
     /* treaps representing the run before 'chunk' (left) and
      * after 'chunk' (right).  */
     struct treap *left, *right;
     /* sha1 for the run represented by this treap */
     unsigned char sha1[20];
};

static struct chunklist *
create_chunklist(int expected_items) {
     struct chunklist *cl = malloc(sizeof(*cl));
     cl->num_items = 0;
     cl->allocd = expected_items;
     cl->chunk = malloc(sizeof(cl->chunk[0]) * cl->allocd);
     return cl;
}
static void
free_chunklist(struct chunklist *cl) {
     free(cl->chunk);
     free(cl);
}

/* Add a chunk to the chunk list, calculating its SHA1 in the process. */
/* The chunk includes buf[start] to buf[end-1].                        */
static void
add_chunk(struct chunklist *cl, char *buf, ch_size_t start, ch_size_t end) {
     struct chunk *ch;
     SHA_CTX c;
     assert(start<end); assert(cl); assert(buf);
     if (cl->num_items >= cl->allocd) {
 	cl->allocd = cl->allocd*3/2;
 	cl->chunk = realloc(cl->chunk, cl->allocd * sizeof(*(cl->chunk)));
     }
     assert(cl->num_items < cl->allocd);
     ch = cl->chunk + (cl->num_items++);
     ch->start = start;
     ch->end = end;
     /* compute SHA-1 of the chunk. */
     SHA1_Init(&c);
     SHA1_Update(&c, buf+start, end-start);
     SHA1_Final(ch->sha1, &c);
     /* done! */
}

/* Split a buffer into chunks, using a rolling checksum over ROLLING_WINDOW
  * bytes to determine chunk boundaries.  We try to split chunks into pieces
  * whose size averages out to be 'CHUNK_SIZE'. */
static void
chunkify(struct chunklist *cl, char *buf, ch_size_t size) {
     int i, rsync_s1=0, rsync_s2=0, last=-1;
     /* While window is filling: */
     for (i=0; i<ROLLING_WINDOW && i<size; i++) {
 	/* add one to char so that leading 0s don't behave strangely. */
 	rsync_s1 = (rsync_s1 + (1 + (unsigned char)buf[i])) & 0xFFFF;
 	rsync_s2 = (rsync_s2 + rsync_s1) & 0xFFFF;
 	/* Is this the end of a chunk? */
 	if (0 == ((rsync_s1 + rsync_s2) % CHUNK_SIZE)) {
 	    add_chunk(cl, buf, last+1, i+1);
 	    last = i;
 	}
     }
     /* After window is full: */
     for ( ; i<size; i++) {
 	/* Old character out */
 	rsync_s1 = (rsync_s1 - (1 + (unsigned char)buf[i-ROLLING_WINDOW])) & 0xFFFF;
 	rsync_s2 = (rsync_s2 - ROLLING_WINDOW * (1 + (unsigned char)buf[i-ROLLING_WINDOW])) & 0xFFFF;
 	/* New character in */
 	rsync_s1 = (rsync_s1 + (1 + (unsigned char)buf[i])) & 0xFFFF;
 	rsync_s2 = (rsync_s2 + rsync_s1) & 0xFFFF;
 	/* Is this the end of a chunk? */
 	if (0 == ((rsync_s1 + rsync_s2) % CHUNK_SIZE)) {
 	    add_chunk(cl, buf, last+1, i+1);
 	    last = i;
 	}
     }
     /* One last chunk at the end: */
     if (last+1!=size)
 	add_chunk(cl, buf, last+1, size);
     /* done! */
}

/* A treap is a 'heap-ordered tree'.  There are two constraints maintained:
  *   left tree key < this tree key < right tree key
  * and
  *   this heap key < left and right heap keys.
  * We use the sha1 of the chunk (chunk->sha1) as the heap key and the
  * file location (chunk->start) as the tree key.
  * For more info on treaps, see:
  *   C. R. Aragon and R. G. Seidel, "Randomized search trees",
  *   Proc. 30th IEEE FOCS (1989), 540-545.
  * There are many possible binary trees we could build; enforcing the
  * heap constraint ensures that similar files will build similar trees.
  * (The root of the constructed tree will always be the chunk with the
  *  smallest hash key; it's left child will be the chunk with the smallest
  *  hash among those chunk before the root in file order; and so on
  *  recursively.)
  */

/* Assertion helper: check tree and heap constraints. */
static int
treap_valid(struct treap *t) {
     int valid = 1;
     if (!t) return 1;
     if (t->chunk==NULL) return 0;
     if (t->left!=NULL) {
 	/* Tree constraint. */
 	valid = valid && (t->left->chunk->start < t->chunk->start);
 	/* Heap constraint. */
 	valid = valid && (memcmp(t->chunk->sha1, t->left->chunk->sha1,
 				 sizeof(t->chunk->sha1)) < 0);
 	/* 'start' validity */
 	valid = valid && (t->start == t->left->start);
     } else
 	valid = valid && (t->start == t->chunk->start);
     if (t->right!=NULL) {
 	/* Tree constraint. */
 	valid = valid && (t->chunk->start < t->right->chunk->start);
 	/* Heap constraint. */
 	valid = valid && (memcmp(t->chunk->sha1, t->right->chunk->sha1,
 				 sizeof(t->chunk->sha1)) < 0);
 	/* 'end' validity. */
 	valid = valid && (t->end == t->right->end);
     } else
 	valid = valid && (t->end == t->chunk->end);
     return valid;
}

/* Restore heap constraint without disturbing tree ordering. */
/* Only the root of the given treap will violate the heap constraint. */
static struct treap *
treapify(struct treap *t) {
     struct treap *x, *y, *a, *b, *c;
     int left_ok, right_ok, rotate_left;
     assert(treap_valid(t->left));
     assert(treap_valid(t->right));
     left_ok = (t->left == NULL) ||
 	(memcmp(t->chunk->sha1, t->left->chunk->sha1,
 		sizeof(t->chunk->sha1)) < 0);
     right_ok = (t->right == NULL) ||
 	(memcmp(t->chunk->sha1, t->right->chunk->sha1,
 		sizeof(t->chunk->sha1)) < 0);
     if (left_ok && right_ok) { /* well, that's easy */
 	assert(treap_valid(t));
 	return t;
     }
     /* okay, someone needs to rotate */
     rotate_left = (!left_ok) &&
 	(right_ok || /* if neither is okay, then rotate smallest up */
 	 memcmp(t->left->chunk->sha1, t->right->chunk->sha1,
 		sizeof(t->chunk->sha1)) < 0);
     /*   Rotation:
      *     y   -bring left up->  x
      *    / \                   / \
      *   x   c                 a   y
      *  / \                       / \
      * a   b <-bring right up-   b   c
      */
     if (rotate_left) {
 	y = t;  x = y->left;  c = y->right;  a = x->left;  b = x->right;
 	y->left = b;
 	y->right = c;
 	y->start = y->left ? y->left->start : y->chunk->start;
 	y->end = y->right ? y->right->end : y->chunk->end;
 	x->left = a;
 	x->right = treapify(y); // recurse to check heap constraint
 	x->start = x->left ? x->left->start : x->chunk->start;
 	x->end = x->right ? x->right->end : x->chunk->end;
 	assert(treap_valid(x));
 	return x;
     } else {
 	x = t;  a = x->left;  y = x->right;  b = y->left;  c = y->right;
 	x->left = a;
 	x->right = b;
 	x->start = x->left ? x->left->start : x->chunk->start;
 	x->end = x->right ? x->right->end : x->chunk->end;
 	y->right = c;
 	y->left = treapify(x); // recurse to check heap constraint.
 	y->start = y->left ? y->left->start : y->chunk->start;
 	y->end = y->right ? y->right->end : y->chunk->end;
 	assert(treap_valid(y));
 	return y;
     }
}

/* Use list of chunks to build treap bottom-up, calling treapify to
  * restore heap order on the subtree after we add each interior node.
  * This is O(N), where N is the number of chunks. */
static struct treap *
build_treap(struct chunklist *cl, int chunk_st, int chunk_end) {
     struct treap *result;
     /* Some treaps are trivial to build: */
     if (chunk_st >= chunk_end) return NULL;
     /* Claim a chunk in the middle for ourself. */
     int c = (chunk_st + chunk_end)/2;
     result = (struct treap *)malloc(sizeof(*result));
     result->chunk = &(cl->chunk[c]);
     /* Divide and conquer: build well-formed treaps for our kids.*/
     result->left = build_treap(cl, chunk_st, c);
     result->right = build_treap(cl, c+1, chunk_end);
     result->start = result->left ? result->left->start : result->chunk->start;
     result->end = result->right ? result->right->end : result->chunk->end;
     /* Now we need to ensure that the heap constraint is satisfied; that is,
      * result->chunk->sha1 < result->left->chunk->sha1  and
      * result->chunk->sha1 < result->right->chunk->sha1.
      */
     assert(treap_valid(result->left));
     assert(treap_valid(result->right));
     return treapify(result);
}

static void
free_treap(struct treap *t) {
     if (!t) return;
     free_treap(t->left);
     free_treap(t->right);
     free(t);
}

static int
treap_depth(struct treap *t) {
     int l, r;
     if (!t) return 0;
     l = treap_depth(t->left);
     r = treap_depth(t->right);
     return 1 + ((l > r) ? l : r);
}

/* Fill in the treap hashes.  This will be O(N ln M), where N is the
  * file length and M is the number of chunks.  We could actually do
  * this in 2*N time if the subtree hashes were prefix-identical.
  * Since we need to include the chunk length in the hash prefix,
  * we can't reuse the hashing context and we need to pay the extra
  * O(ln M) factor. */
static void
do_treap_hash(struct treap *t, void *data, SHA_CTX *accum, int accum_len) {
     char prefix[200];
     SHA_CTX *cp;
     int i;

     assert(treap_valid(t));
     if (!t) return;

     /* Start a new treap context. */
     cp = &(accum[accum_len++]);
     SHA1_Init(cp);
     /* Sticking the size in the prefix makes me unhappy. =( */
     SHA1_Update(cp, prefix, 1+sprintf(prefix, "blob %lu", t->end - t->start));
     /* Recurse on the left. */
     do_treap_hash(t->left, data, accum, accum_len);
     /* Add in our chunk. */
     for (i=0; i<accum_len; i++)
 	SHA1_Update(accum + i, data + t->chunk->start,
 		    t->chunk->end - t->chunk->start);
     /* Recurse on the right. */
     do_treap_hash(t->right, data, accum, accum_len);
     /* Finalize and write it to t->sha1. */
     SHA1_Final(t->sha1, cp);
     /* Done! */
}
/* Helper method. */
static void
compute_treap_hashes(struct treap *t, void *data) {
     /* Allocate space for each level of the treap to have its own context. */
     SHA_CTX contexts[treap_depth(t)];
     do_treap_hash(t, data, contexts, 0);
}
/* Yuck. */
static const char *
compute_null_treap_hash() {
     static const char fixed[] = { "blob 0" };
     static char sha1[20], *cp=NULL;
     SHA_CTX c;
     if (cp) return cp;
     SHA1_Init(&c);
     SHA1_Update(&c, fixed, sizeof(fixed));
     SHA1_Final(sha1, &c);
     cp = sha1;
     return cp;
}


/* Now that we've broken it down into treap-structured pieces, let's write
  * them to the object store. */

/* Write a single treap piece to the object store.  Note that 't' may be
  * NULL for the special case of a zero-byte file.  Writes the hash of
  * this piece back to 'sha1', which must be non-NULL. Returns 0 on success.*/
static int
write_one(struct treap *t, char *buf) {
/* two hundred bytes is two 20-byte SHA1 hashes, two presence bytes,
  * six bytes of type, one null, and plus 10^151 file length. (Conservative.) */
#define MAX_METADATA_LEN 200
     z_stream stream;
     ch_size_t max_out_bytes;
     ch_size_t chunk_size = t ? (t->chunk->end - t->chunk->start) : 0;
     ch_size_t content_size, metadata_size;
     char metadata[MAX_METADATA_LEN];
     void *out;

     /*
      * Metadata: Type, ASCII size, null byte, then left & right hashes.
      */
     content_size = chunk_size+2; /* prefix/suffix delimiters */
     if (t && t->left) content_size += sizeof(t->left->sha1);
     if (t && t->right) content_size += sizeof(t->right->sha1);
     metadata_size =  1+sprintf(metadata, "chunk %lu", content_size);
     if (t && t->left) { /* left hash */
 	metadata[metadata_size++] = 1;
 	memcpy(metadata + metadata_size, t->left->sha1, sizeof(t->left->sha1));
 	metadata_size += sizeof(t->left->sha1);
     } else
 	metadata[metadata_size++] = 0; /* no prefix chunk */
     if (t && t->right) { /* right hash */
 	metadata[metadata_size++] = 1;
 	memcpy(metadata + metadata_size,t->right->sha1,sizeof(t->right->sha1));
 	metadata_size += sizeof(t->right->sha1);
     } else
 	metadata[metadata_size++] = 0; /* no suffix chunk */

     memset(&stream, 0, sizeof(stream));
     deflateInit(&stream, Z_BEST_COMPRESSION);
     max_out_bytes = deflateBound(&stream, chunk_size+metadata_size);
     out = malloc(max_out_bytes);
     stream.next_out = out;
     stream.avail_out = max_out_bytes;

     /* Compress metadata. */
     stream.next_in = metadata;
     stream.avail_in = metadata_size;
     while (deflate(&stream, 0) == Z_OK)
 	    /* nothing */;

     /*
      * Chunk content.
      */
     stream.next_in = buf + ( t ? t->chunk->start : 0);
     stream.avail_in = chunk_size; /* possibly zero */
     while (deflate(&stream, Z_FINISH) == Z_OK)
 	/* nothing */;

     deflateEnd(&stream);

     return write_sha1_buffer(t ? (const char*) t->sha1 :
 			     compute_null_treap_hash(),
 			     out, stream.total_out);
}

/* Write all treap nodes to disk. */
static int
write_treap(struct treap *t, char *buf, char *sha1) {
     /* First write children (which initializes their SHA1 info). */
     if (t && t->left)
 	if (write_treap(t->left, buf, NULL) < 0)
 	    return -1; /* failure. */
     if (t && t->right)
 	if (write_treap(t->right, buf, NULL) < 0)
 	    return -1; /* failure. */
     /* Now write us.  Note t may == NULL for a zero-byte file. */
     if (write_one(t, buf) < 0)
 	return -1; /* failure. */
     /* Write back sha1, if wanted. */
     if (sha1)
 	memcpy(sha1, t ? (const char*)t->sha1 : compute_null_treap_hash(),
 	       sizeof(t->sha1));
     return 0;
}

/* EXPORTED FUNCTION: write the file open on file descriptor 'fd'
  * and described by 'ce' and 'st' to the object store.   Return
  * 0 on success, -1 on failure. */
/* This does the same thing as 'index_fd' in Linus' update-cache.c */
int
chunk_index_fd(struct cache_entry *ce, int fd, struct stat *st) {
     struct chunklist *cl;
     struct treap *t;
     char *in;

     /* We expect there to be 'file length / CHUNK_SIZE' chunks.  Over-estimate
      * a little, and do the initial chunk list allocation. */
     cl = create_chunklist(1 + ((3 * st->st_size) / (2 * CHUNK_SIZE)));
     /* Split the file into chunks. */
     in = "";
     if (st->st_size)
 	in = mmap(NULL, st->st_size, PROT_READ, MAP_PRIVATE, fd, 0);
     close(fd);
     if (in==MAP_FAILED) return -1;

     chunkify(cl, in, st->st_size);
     /* Build the treap. */
     t = build_treap(cl, 0, cl->num_items);
     assert(treap_valid(t));
     /* Compute all the hashes. */
     compute_treap_hashes(t, in);
     /* Now write all the pieces, updating SHA1 for this file in the process. */
     if (write_treap(t, in, ce->sha1) < 0)
 	return -1;
     /* Free everything; we're done. */
     free_treap(t);
     free_chunklist(cl);
     if (st->st_size)
 	munmap(in, st->st_size);
     return 0; /* success! */
}

/*** Functions to read a chunked file into a contiguous buffer. ***/

struct read_chunk {
     void *data, *chunk_data;
     ch_size_t chunk_size, total_size;
     struct read_chunk *left, *right;
};
static struct read_chunk *
read_chunk2(const unsigned char *sha1, void *data, ch_size_t size);

static struct read_chunk *
read_chunk(const unsigned char *sha1) {
     void *data;
     ch_size_t size;
     char type[10];
     data = read_sha1_file(sha1, type, &size);
     assert(strcmp(type, "chunk")==0);
     return read_chunk2(sha1, data, size); 
}
static struct read_chunk *
read_chunk2(const unsigned char *sha1, void *data, ch_size_t size) {
     unsigned char *cp;
     struct read_chunk *result = malloc(sizeof(*result));
     cp = result->data = data;
     printf("CHUNK %s (%lu bytes)\n", sha1_to_hex(sha1), size);
     /* Parse the chunk data. */
     result->left = result->right = NULL;
     if (*cp++) {
 	result->left = read_chunk(cp); cp+=20;
     }
     if (*cp++) {
 	result->right = read_chunk(cp); cp+=20;
     }
     result->chunk_data = cp;
     result->chunk_size = size - (result->chunk_data - result->data);
     result->total_size = result->chunk_size +
 	(result->left ? result->left->total_size : 0) +
 	(result->right ? result->right->total_size : 0);
     return result;
}
static void
copy_read_chunk(void *dest, struct read_chunk *rc) {
     if (rc->left) {
 	copy_read_chunk(dest, rc->left);
 	dest += rc->left->total_size;
     }
     memcpy(dest, rc->chunk_data, rc->chunk_size);
     if (rc->right)
 	copy_read_chunk(dest + rc->chunk_size, rc->right);
}
static void
free_read_chunk(struct read_chunk *rc) {
     if (rc->left) free_read_chunk(rc->left);
     if (rc->right) free_read_chunk(rc->right);
     free(rc->data);
     free(rc);
}

/* This does the same thing as 'read_sha1_file' in Linus' read_cache.c,
  * except that it knows about the 'chunk' encoding and will transparently
  * stitch together the appropriate prefix and suffix chunks and pass it
  * off as a 'blob'. */
void *
chunk_read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size) {
     struct read_chunk *rc;
     void *result = read_sha1_file(sha1, type, size);
     if (strcmp(type, "chunk")!=0) return result;
     /* This is a 'chunk' object; get the rest of the pieces. */
     rc = read_chunk2(sha1, result, *size);
     /* Now concatenate them together. */
     strcpy(type, "blob");
     *size = rc->total_size;
     result = malloc(*size);
     copy_read_chunk(result, rc);
     /* done! */
     free_read_chunk(rc);
     return result;
}

#if 0
/* Exercise this code. */
int main(int argc, char **argv) {
     struct cache_entry ce;
     struct stat st;
     char *buf, type[10];
     unsigned long size;
     int fd;
     fd = open(argv[1], O_RDONLY);
     if (fd < 0) exit(1);
     if (fstat(fd, &st) < 0) exit(1);
     if (chunk_index_fd(&ce, fd, &st) < 0) exit(1);
     printf("Wrote file %s.\n", sha1_to_hex(ce.sha1));
     /* seemed to work! */
     buf = chunk_read_sha1_file(ce.sha1, type, &size);
     if (!buf) exit(1);
     printf("Read file %s, of type %s (%lu bytes):\n",
 	   sha1_to_hex(ce.sha1), type, size);
     fwrite(buf, size, 1, stdout);
     /* done! */
     return 0;
}
#endif
