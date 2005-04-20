From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Blob chunking code. [First look.]
Date: Wed, 20 Apr 2005 09:30:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504200917070.28851@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com>
 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com>
 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 15:27:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOFEX-000361-Qc
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 15:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVDTNbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVDTNbZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 09:31:25 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:39043 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261618AbVDTNax (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 09:30:53 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOFI4-00082f-00; Wed, 20 Apr 2005 09:30:52 -0400
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

So I wrote up my ideas regarding blob chunking as code; see attached.
This is against git-0.4 (I know, ancient, but I had to start somewhere.)

The idea here is that blobs are chunked using a rolling checksum (so the 
chunk boundaries are content-dependent and stay fixed even if you mutate 
pieces of the file).  The chunks are then tree-structured as 'treaps', 
which will ensure that chunk trees can be profitably reused.  (If you 
create a flat 'chunk index' instead of tree-structuring it, then you need 
to write two files even if you make a small change to a small file.  If 
you use a full binary tree, then insertions at the beginning (say) still 
change the entire tree structure.  The treap ensures that on avg O(ln N) 
chunks need to be written per change, where N is the number of chunks in 
the file).  More details are in the code.

Compatibility with existing archives in git-0.4 was tricky, because of 
git's 'compress-before-hash' thingy.  Moving to 'hash before compress' is 
*much* better, although because the file size is included in the hash, I will 
need to perform (the equivalent of) O(ln N) hashes of the complete file.
If the file size weren't included, or if it were put at the end, then 2 
hashes would suffice. (Basically, we can save work hashing subranges which 
are prefix-identical, but including the length means that no subtrees are
prefix-identical.)

I'll work on bringing this forward to the latest git, but I thought I'd 
post it here for early reviews and comments.  My informal testing shows 
that 1) my chunk size is currently too small, and 2) subrange sharing 
works well even on relatively small files.  I'll be working on getting 
concrete numbers for larger archives.
  --scott

DNC NRA Kojarena ESCOBILLA QKENCHANT STANDEL shotgun ESGAIN KGB Mossad 
overthrow ASW cracking HOPEFUL KUBARK counter-intelligence Yakima
                          ( http://cscott.net/ )
------- begin chunk.c ----------
#include <stdlib.h>

/* we could be clever and do this even if we don't fit in memory...
  * ... but we're going to be quick and dirty. */

/* C source has approx 5 bits per character of entropy.
  * We'd like to get 32 bits of good entropy; that means 7 bytes is a
  * reasonable minimum for the window size. */
#define ROLLING_WINDOW 30
#define CHUNK_SIZE 1023 /* desired block size */

#include <assert.h>
#include "cache.h"

/*
  * This file implements a treap-based chunked content store.  The
  * idea is that every stored file is broken down into tree-structured
  * chunks (that is, every chunk has an optional 'prefix' and 'suffix'
  * chunk), and these chunks are put in the object store.  This way
  * similar files will be expected to share chunks, saving space.
  * Files less than one disk block long are expected to fit in a single
  * chunk, so there is no extra indirection overhead for this case.
  */

/* First, some data structures: */
struct chunk {
     /* a chunk represents some range of the underlying file */
     size_t start /* inclusive */, end /*exclusive*/;
     unsigned char sha1[20]; /* sha1 for this chunk; used as the heap key */
};
struct chunklist {
     /* a dynamically-sized list of chunks */
     struct chunk *chunk; /* an array of chunks */
     size_t num_items; /* how many items are currently in the list */
     size_t allocd;    /* how many items we've allocated space for */
};
struct treap {
     /* A treap node represents a run of consecutive chunks. */

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
add_chunk(struct chunklist *cl, char *buf, size_t start, size_t end) {
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
     // compute SHA-1
     SHA1_Init(&c);
     SHA1_Update(&c, buf+start, end-start);
     SHA1_Final(ch->sha1, &c);
     // done!
}

/* Split a buffer into chunks, using a rolling checksum over ROLLING_WINDOW
  * bytes to determine chunk boundaries.  We try to split chunks into pieces
  * whose size averages out to be 'CHUNK_SIZE'. */
static void
chunkify(struct chunklist *cl, char *buf, size_t size) {
     int i, rsync_s1, rsync_s2, last=-1;
     /* Make seed non-zero so that leading 0s don't create 1-char chunks. */
     rsync_s1 = rsync_s2 = 0xBABE; /* arbitrary */
     /* While window is filling: */
     for (i=0; i<ROLLING_WINDOW && i<size; i++) {
 	rsync_s1 = (rsync_s1 + ((unsigned char)buf[i])) & 0xFFFF;
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
 	rsync_s1 = (rsync_s1 - ((unsigned char)buf[i-ROLLING_WINDOW]))& 0xFFFF;
 	rsync_s2 = (rsync_s2 - ROLLING_WINDOW * (unsigned char)buf[i-ROLLING_WINDOW]) & 0xFFFF;
 	/* New character in */
 	rsync_s1 = (rsync_s1 + ((unsigned char)buf[i])) & 0xFFFF;
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
     }
     if (t->right!=NULL) {
 	/* Tree constraint. */
 	valid = valid && (t->chunk->start < t->right->chunk->start);
 	/* Heap constraint. */
 	valid = valid && (memcmp(t->chunk->sha1, t->right->chunk->sha1,
 				 sizeof(t->chunk->sha1)) < 0);
     }
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
 	(right_ok || /* if neither is okay, the rotate smallest up */
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
 	x->left = a;
 	x->right = treapify(y); // recurse to check heap constraint
 	assert(treap_valid(x));
 	return x;
     } else {
 	x = t;  a = x->left;  y = x->right;  b = y->left;  c = y->right;
 	x->left = a;
 	x->right = b;
 	y->right = c;
 	y->left = treapify(x); // recurse to check heap constraint.
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
     if (t->left) free_treap(t->left);
     if (t->right) free_treap(t->right);
     free(t);
}

/* Now that we've broken it down into treap-structured pieces, let's write
  * them to the object store. */

/* Write a single treap piece to the object store.  Note that 't' may be
  * NULL for the special case of a zero-byte file.  Writes the hash of
  * this piece back to 'sha1', which must be non-NULL. Returns 0 on success.*/
static int
write_one(struct treap *t, char *buf, unsigned char *sha1) {
/* two hundred bytes is two 20-byte SHA1 hashes, two presence bytes,
  * six bytes of type, one null, and plus 10^151 file length. (Conservative.) */
#define MAX_METADATA_LEN 200
     z_stream stream;
     size_t max_out_bytes;
     size_t chunk_size = t ? (t->chunk->end - t->chunk->start) : 0;
     size_t content_size = chunk_size;
     char metadata[MAX_METADATA_LEN];
     void *out;
     SHA_CTX c;

     memset(&stream, 0, sizeof(stream));
     deflateInit(&stream, Z_BEST_COMPRESSION);
     max_out_bytes = deflateBound(&stream, chunk_size+sizeof(metadata));
     out = malloc(max_out_bytes);
     stream.next_out = out;
     stream.avail_out = max_out_bytes;
     /*
      * Metadata: Type, ASCII size, null byte, then left & right hashes.
      */
     content_size = chunk_size+2; /* prefix/suffix delimiters */
     if (t && t->left) content_size += sizeof(t->left->sha1);
     if (t && t->right) content_size += sizeof(t->right->sha1);

     stream.next_in = metadata;
     stream.avail_in = 1+sprintf(metadata, "chunk %lu",
 				(unsigned long) content_size);
     if (t && t->left) { /* left hash */
 	stream.next_in[stream.avail_in++] = 1;
 	memcpy(stream.next_in + stream.avail_in,
 	       t->left->sha1, sizeof(t->left->sha1));
 	stream.avail_in += sizeof(t->left->sha1);
     } else
 	stream.next_in[stream.avail_in++] = 0; /* no prefix chunk */
     if (t && t->right) { /* right hash */
 	stream.next_in[stream.avail_in++] = 1;
 	memcpy(stream.next_in + stream.avail_in,
 	       t->right->sha1, sizeof(t->right->sha1));
 	stream.avail_in += sizeof(t->right->sha1);
     } else
 	stream.next_in[stream.avail_in++] = 0; /* no suffix chunk */

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

     SHA1_Init(&c);
     SHA1_Update(&c, out, stream.total_out);
     SHA1_Final(sha1, &c);

     return write_sha1_buffer(sha1, out, stream.total_out);
}

/* Write a sub-treap to disk, setting the 'sha1' fields of all nodes
  * as we go. */
static int
write_treap(struct treap *t, char *buf, unsigned char *sha1) {
     /* First write children (which initializes their SHA1 info). */
     if (t && t->left)
 	if (write_treap(t->left, buf, NULL) < 0)
 	    return -1; /* failure. */
     if (t && t->right)
 	if (write_treap(t->right, buf, NULL) < 0)
 	    return -1; /* failure. */
     /* Now write us.  Note t may == NULL for a zero-byte file. */
     if (write_one(t, buf, t ? t->sha1 : sha1) < 0)
 	return -1; /* failure. */
     if (t && sha1)
 	memcpy(sha1, t->sha1, sizeof(t->sha1));
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
     in = mmap(NULL, st->st_size, PROT_READ, MAP_PRIVATE, fd, 0);
     if (!in) return -1;
     chunkify(cl, in, st->st_size);
     /* Build the treap. */
     t = build_treap(cl, 0, cl->num_items);
     assert(treap_valid(t));
     /* Now write all the pieces, updating SHA1 for this file in the process. */
     if (write_treap(t, in, ce->sha1) < 0)
 	return -1;
     /* Free everything; we're done. */
     free_treap(t);
     free_chunklist(cl);
     munmap(in, st->st_size);
     close(fd);
     return 0; /* success! */
}

/*** Functions to read a chunked file into a contiguous buffer. ***/

struct read_chunk {
     void *data, *chunk_data;
     unsigned long chunk_size, total_size;
     struct read_chunk *left, *right;
};
static struct read_chunk *
read_chunk2(const unsigned char *sha1, void *data, unsigned long size);

static struct read_chunk *
read_chunk(const unsigned char *sha1) {
     void *data;
     unsigned long size;
     char type[10];
     data = read_sha1_file(sha1, type, &size);
     assert(strcmp(type, "chunk")==0);
     return read_chunk2(sha1, data, size); 
}
static struct read_chunk *
read_chunk2(const unsigned char *sha1, void *data, unsigned long size) {
     unsigned char *cp;
     struct read_chunk *result = malloc(sizeof(*result));
     cp = result->data = data;
     printf("CHUNK %s (%d bytes)\n", sha1_to_hex(sha1), size);
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
     /* seemed to work! */
     buf = chunk_read_sha1_file(ce.sha1, type, &size);
     if (!buf) exit(1);
     printf("Read file %s, of type %s (%lu bytes):\n",
 	   sha1_to_hex(ce.sha1), type, size);
     fwrite(buf, size, 1, stdout);
     /* done! */
     return 0;
}
