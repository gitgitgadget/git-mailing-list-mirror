From: Geert Bosch <bosch@gnat.com>
Subject: PATCH: New diff-delta.c implementation (updated)
Date: Thu, 27 Apr 2006 21:59:53 -0400 (EDT)
Message-ID: <Pine.GSO.4.60.0604272132170.9650@nile.gnat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri Apr 28 04:00:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZIHP-0001kh-ET
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 04:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWD1CAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 22:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWD1CAU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 22:00:20 -0400
Received: from nile.gnat.com ([205.232.38.5]:52689 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S965172AbWD1CAR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 22:00:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 6A3E748CEFD
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 21:59:53 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 03261-01-2 for <git@vger.kernel.org>;
 Thu, 27 Apr 2006 21:59:53 -0400 (EDT)
Received: by nile.gnat.com (Postfix, from userid 4190)
	id 3BB2A48CEFA; Thu, 27 Apr 2006 21:59:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by nile.gnat.com (Postfix) with ESMTP id 36D9B48E475
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 21:59:53 -0400 (EDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19262>

Even though the previous version did really well on large files
with many changes, performance was lacking for the many small
files with very few changes that are so common for a VCS.

For example, it turns out that, for packing the 17005 objects in
my git.git repository, diff_delta processes 240 MB worth of target
data in about 12s on my powerbook. (There's even a little more
source data, and the 12s includes compression/decompression time.)

So the fancy fingerprint calculations really take too much time.
Fortunately, it turns out that of the 240M, 120M matches directly
at the start or the end of the source data. After this trivial
matching, most remaining matches are quite small. The overhead
of setting up buffers, computing longest runs of the same character
and computing 64-bit fingerprints becomes very noticeable and
can't be regained later.

As a result I implemented special indexing and matching routines
for "small" files. Here a fixed hash table size and index step
are used. The fingerprint window has been reduced to be equal to
the step size, which essentially gets rid of computation for
characters leaving the window. Finally, the fingerprint size
has been reduced to 32 bits with polynome of 31st degree.

The result has been only a slight increase in delta size for
very large test cases (but with better performance), and
both smaller deltas and faster execution speed for repacking
git.git. I had trouble cloning the Linux kernel repository,
but am now reasonably confident this will outperform the
existing algorithm pretty consistently.

On PPC, the trivial matching in head and tail, and for long
matching runs now shows up high in the profile. On x86,
byte operations are very fast, so I think things should
be at least equally good there.

Please play around with this and let me know of any results.

   -Geert

Signed-off-by: Geert Bosch <bosch@gnat.com>

#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <sys/types.h>

#undef assert
#define assert(x) do { } while (0)

/*
  * MIN_HTAB_SIZE is fixed amount to be added to the size of the hash table
  * used for indexing and must be a power of two. This allows for small files
  * to have a sparse hash table, since in that case it's cheap.
  * Hash table sizes are rounded up to a power of two to avoid integer division.
  */
#define MIN_HTAB_SIZE 8192
#define MAX_HTAB_SIZE (1024*1024*1024)
#define SMALL_HTAB_SIZE 8192
#define SMALL_INDEX_STEP 16

/*
  * Diffing files of gigabyte range is impractical with the current
  * algorithm, so we're assuming 32-bit sizes everywhere.
  * Size leaves some room for expansion when diffing random files.
  */
#define MAX_SIZE (0x7eff0000)

/* For small files, indices are represented in 16 bits.
  * Since indices are always a multiple of the index_step, they
  * can be shifted right a few bits to accommodate files larger than 64K
  */
#define SMALL_SHIFT 4
#define MAX_SMALL_SIZE (0xff00<<SMALL_SHIFT)

/* Initial size of copies table, dynamically extended as needed. */
#define MAX_COPIES 512

/*
  * Matching is done using a sliding window for which a Rabin
  * polynomial is computed. The advantage of such polynomials is
  * that they can efficiently be updated at every position.
  * The tables needed for this are precomputed, as it is desirable
  * to use the same polynomial all the time for repeatable results.
  * The 16 byte window is convenient for indexing with index_step 16.
  * In that special case, the U table is not needed during indexing.
  * The 32-bit hash helps on register-starved 32-bit architectures.
  */

#define RABIN_POLY 0xf3a03ce5
#define RABIN_DEGREE 31
#define RABIN_SHIFT 23
#define RABIN_WINDOW_SIZE 16

unsigned T[256] =
{ 0x00000000, 0xf3a03ce5, 0x14e0452f,
   0xe74079ca, 0x29c08a5e, 0xda60b6bb, 0x3d20cf71, 0xce80f394, 0x538114bc,
   0xa0212859, 0x47615193, 0xb4c16d76, 0x7a419ee2, 0x89e1a207, 0x6ea1dbcd,
   0x9d01e728, 0x54a2159d, 0xa7022978, 0x404250b2, 0xb3e26c57, 0x7d629fc3,
   0x8ec2a326, 0x6982daec, 0x9a22e609, 0x07230121, 0xf4833dc4, 0x13c3440e,
   0xe06378eb, 0x2ee38b7f, 0xdd43b79a, 0x3a03ce50, 0xc9a3f2b5, 0x5ae417df,
   0xa9442b3a, 0x4e0452f0, 0xbda46e15, 0x73249d81, 0x8084a164, 0x67c4d8ae,
   0x9464e44b, 0x09650363, 0xfac53f86, 0x1d85464c, 0xee257aa9, 0x20a5893d,
   0xd305b5d8, 0x3445cc12, 0xc7e5f0f7, 0x0e460242, 0xfde63ea7, 0x1aa6476d,
   0xe9067b88, 0x2786881c, 0xd426b4f9, 0x3366cd33, 0xc0c6f1d6, 0x5dc716fe,
   0xae672a1b, 0x492753d1, 0xba876f34, 0x74079ca0, 0x87a7a045, 0x60e7d98f,
   0x9347e56a, 0x4668135b, 0xb5c82fbe, 0x52885674, 0xa1286a91, 0x6fa89905,
   0x9c08a5e0, 0x7b48dc2a, 0x88e8e0cf, 0x15e907e7, 0xe6493b02, 0x010942c8,
   0xf2a97e2d, 0x3c298db9, 0xcf89b15c, 0x28c9c896, 0xdb69f473, 0x12ca06c6,
   0xe16a3a23, 0x062a43e9, 0xf58a7f0c, 0x3b0a8c98, 0xc8aab07d, 0x2feac9b7,
   0xdc4af552, 0x414b127a, 0xb2eb2e9f, 0x55ab5755, 0xa60b6bb0, 0x688b9824,
   0x9b2ba4c1, 0x7c6bdd0b, 0x8fcbe1ee, 0x1c8c0484, 0xef2c3861, 0x086c41ab,
   0xfbcc7d4e, 0x354c8eda, 0xc6ecb23f, 0x21accbf5, 0xd20cf710, 0x4f0d1038,
   0xbcad2cdd, 0x5bed5517, 0xa84d69f2, 0x66cd9a66, 0x956da683, 0x722ddf49,
   0x818de3ac, 0x482e1119, 0xbb8e2dfc, 0x5cce5436, 0xaf6e68d3, 0x61ee9b47,
   0x924ea7a2, 0x750ede68, 0x86aee28d, 0x1baf05a5, 0xe80f3940, 0x0f4f408a,
   0xfcef7c6f, 0x326f8ffb, 0xc1cfb31e, 0x268fcad4, 0xd52ff631, 0x7f701a53,
   0x8cd026b6, 0x6b905f7c, 0x98306399, 0x56b0900d, 0xa510ace8, 0x4250d522,
   0xb1f0e9c7, 0x2cf10eef, 0xdf51320a, 0x38114bc0, 0xcbb17725, 0x053184b1,
   0xf691b854, 0x11d1c19e, 0xe271fd7b, 0x2bd20fce, 0xd872332b, 0x3f324ae1,
   0xcc927604, 0x02128590, 0xf1b2b975, 0x16f2c0bf, 0xe552fc5a, 0x78531b72,
   0x8bf32797, 0x6cb35e5d, 0x9f1362b8, 0x5193912c, 0xa233adc9, 0x4573d403,
   0xb6d3e8e6, 0x25940d8c, 0xd6343169, 0x317448a3, 0xc2d47446, 0x0c5487d2,
   0xfff4bb37, 0x18b4c2fd, 0xeb14fe18, 0x76151930, 0x85b525d5, 0x62f55c1f,
   0x915560fa, 0x5fd5936e, 0xac75af8b, 0x4b35d641, 0xb895eaa4, 0x71361811,
   0x829624f4, 0x65d65d3e, 0x967661db, 0x58f6924f, 0xab56aeaa, 0x4c16d760,
   0xbfb6eb85, 0x22b70cad, 0xd1173048, 0x36574982, 0xc5f77567, 0x0b7786f3,
   0xf8d7ba16, 0x1f97c3dc, 0xec37ff39, 0x39180908, 0xcab835ed, 0x2df84c27,
   0xde5870c2, 0x10d88356, 0xe378bfb3, 0x0438c679, 0xf798fa9c, 0x6a991db4,
   0x99392151, 0x7e79589b, 0x8dd9647e, 0x435997ea, 0xb0f9ab0f, 0x57b9d2c5,
   0xa419ee20, 0x6dba1c95, 0x9e1a2070, 0x795a59ba, 0x8afa655f, 0x447a96cb,
   0xb7daaa2e, 0x509ad3e4, 0xa33aef01, 0x3e3b0829, 0xcd9b34cc, 0x2adb4d06,
   0xd97b71e3, 0x17fb8277, 0xe45bbe92, 0x031bc758, 0xf0bbfbbd, 0x63fc1ed7,
   0x905c2232, 0x771c5bf8, 0x84bc671d, 0x4a3c9489, 0xb99ca86c, 0x5edcd1a6,
   0xad7ced43, 0x307d0a6b, 0xc3dd368e, 0x249d4f44, 0xd73d73a1, 0x19bd8035,
   0xea1dbcd0, 0x0d5dc51a, 0xfefdf9ff, 0x375e0b4a, 0xc4fe37af, 0x23be4e65,
   0xd01e7280, 0x1e9e8114, 0xed3ebdf1, 0x0a7ec43b, 0xf9def8de, 0x64df1ff6,
   0x977f2313, 0x703f5ad9, 0x839f663c, 0x4d1f95a8, 0xbebfa94d, 0x59ffd087,
   0xaa5fec62
};

unsigned U[256] =
{ 0x00000000, 0x302a7c89, 0x6054f912,
   0x507e859b, 0x3309cec1, 0x0323b248, 0x535d37d3, 0x63774b5a, 0x66139d82,
   0x5639e10b, 0x06476490, 0x366d1819, 0x551a5343, 0x65302fca, 0x354eaa51,
   0x0564d6d8, 0x3f8707e1, 0x0fad7b68, 0x5fd3fef3, 0x6ff9827a, 0x0c8ec920,
   0x3ca4b5a9, 0x6cda3032, 0x5cf04cbb, 0x59949a63, 0x69bee6ea, 0x39c06371,
   0x09ea1ff8, 0x6a9d54a2, 0x5ab7282b, 0x0ac9adb0, 0x3ae3d139, 0x7f0e0fc2,
   0x4f24734b, 0x1f5af6d0, 0x2f708a59, 0x4c07c103, 0x7c2dbd8a, 0x2c533811,
   0x1c794498, 0x191d9240, 0x2937eec9, 0x79496b52, 0x496317db, 0x2a145c81,
   0x1a3e2008, 0x4a40a593, 0x7a6ad91a, 0x40890823, 0x70a374aa, 0x20ddf131,
   0x10f78db8, 0x7380c6e2, 0x43aaba6b, 0x13d43ff0, 0x23fe4379, 0x269a95a1,
   0x16b0e928, 0x46ce6cb3, 0x76e4103a, 0x15935b60, 0x25b927e9, 0x75c7a272,
   0x45eddefb, 0x0dbc2361, 0x3d965fe8, 0x6de8da73, 0x5dc2a6fa, 0x3eb5eda0,
   0x0e9f9129, 0x5ee114b2, 0x6ecb683b, 0x6bafbee3, 0x5b85c26a, 0x0bfb47f1,
   0x3bd13b78, 0x58a67022, 0x688c0cab, 0x38f28930, 0x08d8f5b9, 0x323b2480,
   0x02115809, 0x526fdd92, 0x6245a11b, 0x0132ea41, 0x311896c8, 0x61661353,
   0x514c6fda, 0x5428b902, 0x6402c58b, 0x347c4010, 0x04563c99, 0x672177c3,
   0x570b0b4a, 0x07758ed1, 0x375ff258, 0x72b22ca3, 0x4298502a, 0x12e6d5b1,
   0x22cca938, 0x41bbe262, 0x71919eeb, 0x21ef1b70, 0x11c567f9, 0x14a1b121,
   0x248bcda8, 0x74f54833, 0x44df34ba, 0x27a87fe0, 0x17820369, 0x47fc86f2,
   0x77d6fa7b, 0x4d352b42, 0x7d1f57cb, 0x2d61d250, 0x1d4baed9, 0x7e3ce583,
   0x4e16990a, 0x1e681c91, 0x2e426018, 0x2b26b6c0, 0x1b0cca49, 0x4b724fd2,
   0x7b58335b, 0x182f7801, 0x28050488, 0x787b8113, 0x4851fd9a, 0x1b7846c2,
   0x2b523a4b, 0x7b2cbfd0, 0x4b06c359, 0x28718803, 0x185bf48a, 0x48257111,
   0x780f0d98, 0x7d6bdb40, 0x4d41a7c9, 0x1d3f2252, 0x2d155edb, 0x4e621581,
   0x7e486908, 0x2e36ec93, 0x1e1c901a, 0x24ff4123, 0x14d53daa, 0x44abb831,
   0x7481c4b8, 0x17f68fe2, 0x27dcf36b, 0x77a276f0, 0x47880a79, 0x42ecdca1,
   0x72c6a028, 0x22b825b3, 0x1292593a, 0x71e51260, 0x41cf6ee9, 0x11b1eb72,
   0x219b97fb, 0x64764900, 0x545c3589, 0x0422b012, 0x3408cc9b, 0x577f87c1,
   0x6755fb48, 0x372b7ed3, 0x0701025a, 0x0265d482, 0x324fa80b, 0x62312d90,
   0x521b5119, 0x316c1a43, 0x014666ca, 0x5138e351, 0x61129fd8, 0x5bf14ee1,
   0x6bdb3268, 0x3ba5b7f3, 0x0b8fcb7a, 0x68f88020, 0x58d2fca9, 0x08ac7932,
   0x388605bb, 0x3de2d363, 0x0dc8afea, 0x5db62a71, 0x6d9c56f8, 0x0eeb1da2,
   0x3ec1612b, 0x6ebfe4b0, 0x5e959839, 0x16c465a3, 0x26ee192a, 0x76909cb1,
   0x46bae038, 0x25cdab62, 0x15e7d7eb, 0x45995270, 0x75b32ef9, 0x70d7f821,
   0x40fd84a8, 0x10830133, 0x20a97dba, 0x43de36e0, 0x73f44a69, 0x238acff2,
   0x13a0b37b, 0x29436242, 0x19691ecb, 0x49179b50, 0x793de7d9, 0x1a4aac83,
   0x2a60d00a, 0x7a1e5591, 0x4a342918, 0x4f50ffc0, 0x7f7a8349, 0x2f0406d2,
   0x1f2e7a5b, 0x7c593101, 0x4c734d88, 0x1c0dc813, 0x2c27b49a, 0x69ca6a61,
   0x59e016e8, 0x099e9373, 0x39b4effa, 0x5ac3a4a0, 0x6ae9d829, 0x3a975db2,
   0x0abd213b, 0x0fd9f7e3, 0x3ff38b6a, 0x6f8d0ef1, 0x5fa77278, 0x3cd03922,
   0x0cfa45ab, 0x5c84c030, 0x6caebcb9, 0x564d6d80, 0x66671109, 0x36199492,
   0x0633e81b, 0x6544a341, 0x556edfc8, 0x05105a53, 0x353a26da, 0x305ef002,
   0x00748c8b, 0x500a0910, 0x60207599, 0x03573ec3, 0x337d424a, 0x6303c7d1,
   0x5329bb58
};


static unsigned char rabin_window[RABIN_WINDOW_SIZE];
static unsigned rabin_pos = 0;

#ifndef MIN
#define MIN(x,y) ((y)<(x) ? (y) : (x))
#endif
#ifndef MAX
#define MAX(x,y) ((y)>(x) ? (y) : (x))
#endif

/*
  * The copies array is the central data structure for diff generation.
  * Data statements are implicit, for ranges not covered by any copy command.
  *
  * The sum of tgt and length for each entry must be monotonically increasing,
  * and data ranges must be non-overlapping. This is accomplished by not
  * extending matches backwards during initial matching.
  *
  * Copies may have zero length, to make it quick to delete copies during
  * optimization. However, the last copy in the list must always be a
  * non-trivial copy.
  *
  * Before committing copies, an important optimization is performed: during
  * a backward pass through the copies array, each entry is extended backwards,
  * and redundant copies are eliminated.
  *
  * If each match were extended backwards on insertion, the same data may be
  * matched an arbitrary number of times, resulting in potentially quadratic
  * time behavior.
  */

typedef struct copyinfo {
 	unsigned src;
 	unsigned tgt;
 	unsigned length;
} CopyInfo;

static CopyInfo *copies;
static int copy_count = 0;
static unsigned max_copies = 0; /* Dynamically increased */

static unsigned *idx;
static unsigned idx_size;
static unsigned char *idx_data;
static unsigned idx_data_len;

typedef unsigned poly_t;

static void rabin_reset(void)
{
 	memset(rabin_window, 0, sizeof(rabin_window));
}

static poly_t rabin_slide (poly_t fp, unsigned char m)
{
 	unsigned char om;
 	if (++rabin_pos == RABIN_WINDOW_SIZE) rabin_pos = 0;
 	om = rabin_window[rabin_pos];
 	fp ^= U[om];
 	rabin_window[rabin_pos] = m;
 	fp = ((fp << 8) | m) ^ T[fp >> RABIN_SHIFT];
 	return fp;
}

static int add_copy (unsigned src, unsigned tgt, unsigned length)
{
 	if (copy_count == max_copies) {
 		max_copies *= 2;

 		if (!max_copies) {
 			max_copies = MAX_COPIES;
 			copies = malloc (max_copies * sizeof (CopyInfo));
 		} else
 			copies = realloc(copies,
 			   max_copies * sizeof (CopyInfo));
 		if (!copies)
 			return 0;
 	}

 	copies[copy_count].src = src;
 	copies[copy_count].tgt = tgt;
 	copies[copy_count].length = length;
 	return ++copy_count;
}

static unsigned maxofs[256];
static unsigned maxlen[256];
static unsigned maxfp[256];

static const unsigned small_idx_size = SMALL_HTAB_SIZE;
static short unsigned small_idx[SMALL_HTAB_SIZE];

static void small_init_idx (unsigned char * data, unsigned len,
                      	    unsigned head, unsigned tail)
{
 	const unsigned index_step = SMALL_INDEX_STEP;
 	unsigned j = head - head % index_step;
 	unsigned k;

 	if (len < index_step) return;

 	idx_data = data;
 	idx_data_len = len;
 	len -= MIN (len, tail + (index_step - 1));

 	memset (small_idx, 0, sizeof(small_idx));

 	while (j < len) {
 		poly_t fp = 0;
 		do
 			fp = ((fp << 8) | data[j++]) ^ T[fp >> RABIN_SHIFT];
 		while (j % index_step);
 		small_idx[fp % small_idx_size] = j >> SMALL_SHIFT;
 	}
}

static void init_idx (unsigned char *data, unsigned len, int level,
 		      unsigned head, unsigned tail)
{
 	unsigned index_step
 	  = RABIN_WINDOW_SIZE / sizeof(unsigned) * sizeof(unsigned);
 	unsigned j, k;
 	unsigned char ch = 0;
 	unsigned runlen = 0;
 	poly_t fp = 0;

 	/* Special case small files at low optimization levels */
 	if (level <= 1 && len < MAX_SMALL_SIZE
 	  && len - head - tail < (SMALL_HTAB_SIZE * SMALL_INDEX_STEP)) {
 		small_init_idx(data, len, head, tail);
 		return;
 	}

 	assert (len <= MAX_SIZE);
 	assert (head < len);
 	assert (level >= 0 && level <= 9);
 	memset(maxofs, 0, sizeof(maxofs));
 	memset(maxlen, 0, sizeof(maxlen));
 	memset(maxfp, 0, sizeof(maxfp));

 	/* Smaller step size for higher optimization levels.
 	   The index_step must be a multiple of the word size */
 	if (level >= 1)
 		index_step = MIN(index_step, 4 * sizeof (unsigned));
 	if (level >= 3)
 		index_step = MIN (index_step, 3 * sizeof (unsigned));
 	if (level >= 4)
 		index_step = MIN (index_step, 2 * sizeof (unsigned));
 	if (level >= 6)
 		index_step = MIN (index_step, 1 * sizeof (unsigned));
 	assert (index_step && !(index_step % sizeof (unsigned)));

 	/* Add fixed amount to hash table size, as small files will benefit
 	   a lot without using significantly more memory or time. */
 	idx_size = (level + 1) * ((len - head - tail) / index_step) / 2;
 	idx_size = MIN (idx_size + MIN_HTAB_SIZE, MAX_HTAB_SIZE - 1);

 	/* Round up to next power of two, but limit to MAX_HTAB_SIZE. */
 	{
 		unsigned s = MIN_HTAB_SIZE;
 		while (s < idx_size) s += s;
 		idx_size = s;
 	}

 	idx_data = data;
 	idx_data_len = len;
 	idx = calloc(idx_size, sizeof(unsigned));

 	/* It is tempting to first index higher addresses, so hashes of lower
 	   addresses will get preference in the hash table. However, for
 	   repetitive patterns with a period that is a divisor of the
 	   fingerprint window, this may mean the match is not anchored at
 	   the end. Furthermore, even when using a window length that is
 	   prime, the benefits are small and the irregularity of the first
 	   matches being more important is not worth it. */

 	rabin_reset();

 	ch = 0;
 	runlen = 0;

 	if (head < RABIN_WINDOW_SIZE + index_step)
 		head = 0;
 	else {
 		head -= head % index_step;
 		for (j = head - RABIN_WINDOW_SIZE + 1; j < head; j++)
 			fp = rabin_slide (fp, data[j]);
 	}

 	for (j = head; j + index_step < len - tail; j += index_step) {
 		unsigned char pch = 0;
 		unsigned hash;

 		for (k = 0; k < index_step; k++) {
 			pch = ch;
 			ch = data[j + k];
 			if (ch != pch)
 				runlen = 0;
 			runlen++;
 			fp = rabin_slide(fp, ch);
 		}

 		/* See if there is a word-aligned window-sized run of
 		   equal characters */
 		if (runlen >= RABIN_WINDOW_SIZE + sizeof(unsigned) - 1) {
 			/* Skip ahead to end of run */
 			while (j + k < len && data[j + k] == ch) {
 				k++;
 				runlen++;
 			}

 			/* Although matches are usually anchored at the end,
 			   in the case of extended runs of equal characters
 			   it is better to anchor after the first
 			   RABIN_WINDOW_SIZE bytes. This allows for quick
 			   skip ahead while matching such runs, avoiding
 			   unneeded fingerprint calculations.
 			   Also, when anchoring at the end, matches will be
 			   generated after every word, because the fingerprint
 			   stays constant. Even though all matches would get
 			   combined during match optimization, it wastes time
 			   and space. */
 			if (runlen > maxlen[pch] + 4) {
 				unsigned ofs;
 				/* ofs points RABIN_WINDOW_SIZE bytes after
 				   the start of the run, rounded up to the
 				   next word */
 				ofs = j + k - runlen + RABIN_WINDOW_SIZE
 				   + (sizeof (unsigned) - 1);
 				ofs -= ofs % sizeof(unsigned);
 				maxofs[pch] = ofs;
 				maxlen [pch] = runlen;
 				assert(maxfp[pch] == 0
 				  || maxfp[pch] == (unsigned)fp);
 				maxfp[pch] = (unsigned)fp;
 			}
 			/* Keep input aligned as if no special run
 			   processing had taken place */
 			j += k - (k % index_step) - index_step;
 			k = index_step;
 		}

 		/* Testing showed that avoiding collisions using secondary
 		   hashing, or hash chaining had little effect and is not
 		   worth the time. */
 		hash = ((unsigned)fp) & (idx_size - 1);
 		idx[hash] = j + k;
 	}

 	/* Lastly, index the longest runs of equal characters found before.
 	   This ensures we always match the longerst such runs available.  */
 	for (j = 0; j < 256; j++)
 		if (maxlen[j])
 			idx[maxfp[j] % idx_size] = maxofs[j];
}

/* Match data against the current index and record all possible copies */
static int small_find_copies(unsigned char *data, unsigned len, unsigned head)
{
 	unsigned j = head < RABIN_WINDOW_SIZE ? 0 : head - RABIN_WINDOW_SIZE;
 	poly_t fp = 0;

 	while (j < MAX (head, RABIN_WINDOW_SIZE) && j < len)
 		fp = ((fp << 8) | data[j++]) ^ T[fp >> RABIN_SHIFT];

 	while (j < len) {
 		unsigned ofs, src, tgt, runlen, maxrun;

 		fp ^= U[data[j - RABIN_WINDOW_SIZE]];
 		fp = ((fp << 8) | data[j++]) ^ T[fp >> RABIN_SHIFT];

 		ofs = small_idx[fp & (small_idx_size - 1)] << SMALL_SHIFT;

 		/* Invariant:
 		   data[0] .. data[j-1] has been processed
 		   fp is fingerprint of sliding window ending at j-1
 		   ofs is zero or points just past tentative match
 		   ofs is a multiple of index_step */

 		if (!ofs)
 			continue;

 		runlen = 0;
 		tgt = j - 4;
 		src = ofs - 4;
 		maxrun = MIN(idx_data_len - src, len - tgt);

 		/* Hot loop */
 		while (runlen < maxrun &&
 		       data[tgt + runlen] == idx_data[src + runlen])
 			runlen++;
 		if (runlen < 4)
 			continue;

 		if (!add_copy(src, tgt, runlen)) return 0;

 		/* For runs extending more than RABIN_WINDOW_SIZE bytes past j,
 		   skip ahead to prevent useless fingerprint computations. */
 		if (tgt + runlen > j + RABIN_WINDOW_SIZE)
 		{
 			fp = 0;
 			j = tgt + runlen - RABIN_WINDOW_SIZE;
 			while (j < tgt + runlen)
 				fp = ((fp << 8) | data[j++])
 				      ^ T[fp >> RABIN_SHIFT];
 		}

 		/* Quickly scan ahead without looking for matches
 		   until the end of this run */
 		while (j < tgt + runlen) {
 			fp ^= U[data[j - RABIN_WINDOW_SIZE]];
 			fp = ((fp << 8) | data[j++]) ^ T[fp >> RABIN_SHIFT];
 		}
 	}

 	return 1;
}

/* Match data against the current index and record all possible copies */
static int find_copies(unsigned char *data, unsigned len, unsigned head)
{
 	unsigned j = head < RABIN_WINDOW_SIZE ? 0 : head - RABIN_WINDOW_SIZE;
 	poly_t fp = 0;

 	assert (idx_data);

 	if (!idx) return small_find_copies (data, len, head);

 	rabin_reset();

 	while (j < head + RABIN_WINDOW_SIZE && j < len)
 		fp = rabin_slide(fp, data[j++]);

 	while (j < len) {
 		unsigned ofs, src, tgt, runlen, maxrun;

 		fp = rabin_slide(fp, data[j++]);
 		ofs = idx[fp & (idx_size - 1)];

 		/* Invariant:
 		   data[0] .. data[j-1] has been processed
 		   fp is fingerprint of sliding window ending at j-1
 		   ofs is zero or points just past tentative match
 		   ofs is a multiple of index_step */

 		if (!ofs)
 			continue;

 		runlen = 0;
 		tgt = j - 4;
 		src = ofs - 4;
 		maxrun = MIN(idx_data_len - src, len - tgt);

 		/* Hot loop */
 		while (runlen < maxrun &&
 		       data[tgt + runlen] == idx_data[src + runlen])
 			runlen++;
 		if (runlen < 4)
 			continue;

 		if (!add_copy(src, tgt, runlen)) return 0;

 		/* For runs extending more than RABIN_WINDOW_SIZE bytes past j,
 		   skip ahead to prevent useless fingerprint computations. */
 		if (tgt + runlen > j + RABIN_WINDOW_SIZE)
 			j = tgt + runlen - RABIN_WINDOW_SIZE;

 		/* Quickly scan ahead without looking for matches
 		   until the end of this run */
 		while (j < tgt + runlen)
 			fp = rabin_slide(fp, data[j++]);
 	}

 	return 1;
}

static unsigned header_length(unsigned srclen, unsigned tgtlen)
{
 	unsigned len = 0;
 	assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);

 	/* GIT headers start with the length of the source and target,
 	   with 7 bits per byte, least significant byte first, and
 	   the high bit indicating continuation. */
 	do { len++; srclen >>= 7; } while (srclen);
 	do { len++; tgtlen >>= 7; } while (tgtlen);

 	return len;
}

static unsigned char *
write_header(unsigned char *patch, unsigned srclen, unsigned tgtlen)
{
 	assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);

 	while (srclen >= 0x80) {
 		*patch++ = srclen | 0x80;
 		srclen >>= 7;
 	}
 	*patch++ = srclen;

 	while (tgtlen >= 0x80) {
 		*patch++ = tgtlen | 0x80;
 		tgtlen >>= 7;
 	}
 	*patch++ = tgtlen;

 	return patch;
}

static unsigned data_length(unsigned length)
{
 	/* Can only include 0x7f data bytes per command */
 	unsigned partial = length % 0x7f;
 	assert (length > 0 && length <= MAX_SIZE);
 	if (partial) partial++;
 	return partial + (length / 0x7f) * 0x80;
}

static unsigned char *
write_data(unsigned char *patch, unsigned char *data, unsigned size)
{
 	assert (size > 0 && size < MAX_SIZE);
 	/* The return value must be equal to patch + data_length (patch, size).
 	   This correspondence is essential for calculating the patch size.  */

 	/* GIT has no data commands for large data, rest is same as GDIFF */
 	do {
 		unsigned s = size;
 		if (s > 0x7f)
 			s = 0x7f;
 		*patch++ = s;
 		memcpy(patch, data, s);
 		data += s;
 		patch += s;
 		size -= s;
 	} while (size);

 	return patch;
}

static unsigned copy_length (unsigned offset, unsigned length)
{
 	unsigned size = 0;

 	assert (offset < MAX_SIZE && length < MAX_SIZE);

 	/* For now we only copy a maximum of 0x10000 bytes per command.
 	   Longer copies are broken into pieces of that size. */
 	do {
 		signed s = length;
 		if (s > 0x10000)
 			s = 0x10000;
 		size += !!(s & 0xff) + !!(s & 0xff00);
 		size += !!(offset & 0xff) + !!(offset & 0xff00) +
 			!!(offset & 0xff0000) + !!(offset & 0xff000000);
 		size += 1;
 		offset += s;
 		length -= s;
 	} while (length);

 	return size;
}

static unsigned char *
write_copy(unsigned char *patch, unsigned offset, unsigned size)
{
 	/* The return value must be equal to patch + copy_length
 	   (patch, offset, size). This correspondence is essential
 	   for calculating the patch size.  */

 	do {
 		unsigned char c = 0x80, *cmd = patch++;
 		unsigned v, s = size;
 		if (s > 0x10000)
 			s = 0x10000;

 		v = offset;
 		if (v & 0xff) c |= 0x01, *patch++ = v;
 		v >>= 8;
 		if (v & 0xff) c |= 0x02, *patch++ = v;
 		v >>= 8;
 		if (v & 0xff) c |= 0x04, *patch++ = v;
 		v >>= 8;
 		if (v & 0xff) c |= 0x08, *patch++ = v;

 		v = s;
 		if (v & 0xff) c |= 0x10, *patch++ = v;
 		v >>= 8;
 		if (v & 0xff) c |= 0x20, *patch++ = v;

 		*cmd = c;
 		offset += s;
 		size -= s;
 	} while (size);

 	return patch;
}

static unsigned
process_copies (unsigned char *data, unsigned length, unsigned maxlen)
{
 	int j;
 	unsigned ptr = length;
 	unsigned patch_bytes = header_length(idx_data_len, length);

 	/* Work through the copies backwards, extending each one backwards. */
 	for (j = copy_count - 1; j >= 0; j--) {
 		CopyInfo *copy = copies+j;
 		unsigned src = copy->src;
 		unsigned tgt = copy->tgt;
 		unsigned len = copy->length;
 		int data_follows;

 		if (tgt + len > ptr) {
 			/* Part of copy already covered by later one,
 			   so shorten copy. */
 			if (ptr < tgt) {
 				/* Copy completely disappeared, but guess
 				   that a backward extension might still be
 				   useful. This extension is non-contiguous,
 				   as it is irrelevant whether the skipped
 				   data would have matched or not. Be careful
 				   to not extend past the beginning of
 				   the source. */
 				unsigned adjust = tgt - ptr;

 				tgt = ptr;
 				src = (src < adjust) ? 0 : src - adjust;

 				copy->tgt = tgt;
 				copy->src = src;
 			}

 			len = ptr - tgt;
 		}

 		while (src && tgt && idx_data[src - 1] == data[tgt - 1]) {
 			src--;
 			tgt--;
 		}
 		len += copy->tgt - tgt;

 		data_follows = (tgt + len < ptr);

 		/* A short copy may cost as much as 6 bytes for the copy and
 		   5 as result of an extra data command. It's not worth
 		   having extra copies in order to just save a byte or two.
 		   Being too smart here may hurt later compression as well. */
 		if (len < (data_follows ? 16 : 10))
 			len = 0;

 		/* Some target data is not covered by the copies, account for
 		   the DATA command that will follow the copy. */
 		if (len && data_follows)
 			patch_bytes += data_length(ptr - (tgt + len));

 		/* Everything about the copy is known and will not change.
 		   Write back the new information and update the patch size
 		   with the size of the copy instruction. */
 		copy->length = len;
 		copy->src = src;
 		copy->tgt = tgt;

 		if (len) {
 			/* update patch size for copy command */
 			patch_bytes += copy_length (src, len);
 			ptr = tgt;
 		} else if (j == copy_count - 1) {
 			/* Remove empty copies at end of list. */
 			copy_count--;
 		}

 		if (patch_bytes > maxlen)
 			return 0;
 	}

 	/* Account for data before first copy */
 	if (ptr != 0)
 		patch_bytes += data_length(ptr);

 	if (patch_bytes > maxlen)
 		return 0;
 	return patch_bytes;
}

static void *
create_delta (unsigned char *data, unsigned len,
 	      unsigned char *delta, unsigned delta_size)
{
 	unsigned char *ptr = delta;
 	unsigned offset = 0;
 	int j;

 	ptr = write_header(ptr, idx_data_len, len);

 	for (j = 0; j < copy_count; j++) {
 		CopyInfo *copy = copies + j;
 		unsigned copylen = copy->length;

 		if (!copylen)
 			continue;

 		if (copy->tgt > offset) {
 			ptr = write_data(ptr, data + offset,
 			   copy->tgt - offset);
 		}

 		ptr = write_copy(ptr, copy->src, copylen);
 		offset = copy->tgt + copylen;
 	}

 	if (offset < len)
 		ptr = write_data(ptr, data + offset, len - offset);

 	assert(ptr - delta == delta_size);

 	return delta;
}

static void finalize_idx()
{
 	if (max_copies > 8 * MAX_COPIES) {
 		free(copies);
 		copies = 0;
 		max_copies = 0;
 	}
 	copy_count = 0;
 	if (idx) free(idx);
 	idx = 0;
 	idx_size = 0;
 	idx_data = 0;
 	idx_data_len = 0;
}

static unsigned
match_head (unsigned char *from, unsigned char *to, unsigned size)
{
 	unsigned head = 0;
 	while (head < size && from[head] == to[head]) head++;
 	return head;
}

static unsigned
match_tail (unsigned char *from, unsigned char *to, unsigned size)
{
 	unsigned tail = 0;
 	while (tail < size && *(from - tail) == *(to - tail)) tail++;
 	return tail;
}

void *diff_delta(void *from_buf, unsigned long from_size,
 		 void *to_buf, unsigned long to_size,
 		 unsigned long *delta_size, unsigned long max_size)
{
 	unsigned char *delta = 0;
 	unsigned dsize;
         unsigned head = 0;
         unsigned tail = 0;

 	assert (from_size <= MAX_SIZE && to_size <= MAX_SIZE);

 	/* The following actually takes care of about half of all target
 	   data. This is performance critical, and may need some work. */
         head = match_head(from_buf, to_buf, MIN(from_size, to_size));
 	tail = match_tail(from_buf + (from_size - 1), to_buf + (to_size - 1),
 	                  MIN(from_size, to_size - head));

 	if (head <= RABIN_WINDOW_SIZE) head = 0;
 	if (tail <= RABIN_WINDOW_SIZE) tail = 0;

 	if (!max_size)
 		max_size = from_size;

 	init_idx (from_buf, from_size, 1, head, tail);

 	if (head) add_copy (0, 0, head);

 	if (head + tail + RABIN_WINDOW_SIZE < from_size) {
 		if (!find_copies(to_buf, to_size - tail, head))
 			return 0;
 	}
 	if (tail) add_copy (from_size - tail, to_size - tail, tail);

 	dsize = process_copies(to_buf, to_size, max_size);
 	if (dsize)
 	{
 		delta = malloc (dsize);
 		delta = create_delta (to_buf, to_size, delta, dsize);
 	}
 	finalize_idx ();
 	if (delta)
 		*delta_size = dsize;
 	return delta;
}
