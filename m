From: linux@horizon.com
Subject: Re: cleaner/better zlib sources?
Date: 16 Mar 2007 13:39:28 -0400
Message-ID: <20070316173928.1877.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0703160841360.3816@woody.linux-foundation.org>
Cc: git@vger.kernel.org
To: linux@horizon.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Mar 16 18:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSGOz-0004Yn-9x
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 18:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965768AbXCPRjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965780AbXCPRjf
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 13:39:35 -0400
Received: from science.horizon.com ([192.35.100.1]:14237 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965768AbXCPRja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 13:39:30 -0400
Received: (qmail 1883 invoked by uid 1000); 16 Mar 2007 13:39:28 -0400
In-Reply-To: <Pine.LNX.4.64.0703160841360.3816@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42385>

> so yes, inflate_fast() is certainly up there too, but plain "inflate()" is 
> actually more important.

Ah, okay.  Thanks for the real data.

> I'd obviously *also* like to see inflate_fast() go down, and it has some 
> really strange code too, like:
...
> which looks rather odd, wouldn't you say? That's a memcpy.

Actually, no, it's not a memcpy.  memcpy is undefined for overlapping
operands.  The way that gzip compresses 80 "x" characters is:
- Emit literal "x"
- Copy 79 bytes starting at (relative) offset -1

For this to work, the copy *must* proceed byte-at-a-time.  libc memcpy(),
or even rep movsw, won't do.  It has to be rep movsb.

Now, you could check for overlap and call memcpy() when the source and
destination don't overlap (the length is no larger than the offset),
but it's not clear that it's useful.

> But I especially find the nice "unrolled" memcpy interestign:
> 
>		...
>                    while (len > 2) {
>                        PUP(out) = PUP(from);
>                        PUP(out) = PUP(from);
>                        PUP(out) = PUP(from);
>                        len -= 3;
>                    }
>                    if (len) {
>                        PUP(out) = PUP(from);
>                        if (len > 1)
>                            PUP(out) = PUP(from);
>                    }
>		...
>
> yeah, that's right - we unroll memcpy() BY DOING IT THREE BYTES AT A TIME!

They're actually not that stupid.  A lot of copies are very short, so
getting too fancy is counterproductive.  It's been a while, so it may
not be optimal on current processors, but the code was heavily profiled
and optimized at one point.

>> There's equivalent inflate code in the PGP 5.0i distribution

> Interesting. I'll take a look.

I think I figured out the whitespace damage - that code was transmitted
using  RFC1149-like technology: printed on paper and OCRed in.

I can see how that could play hell with the whitespace.  It makes a lot
more sense after that is fixed.  A properly indented version is appended,
if anyone cares.




/*
 * inflate.c -- Not copyrighted 1992,1993 by Mark Adler
 * Latest hacking on this version by Colin Plumb
 * version p3, 19 Oct 1995
 *
 * $Id: pgpZInflate.c,v 1.2 1997/01/24 23:35:54 mhw Exp $
 */


/*
 * You can do whatever you like with this source file, though I would
 * prefer that if you modify it and redistribute it that you include
 * comments to that effect with your name and the date. Thank you.
 *
 * History:
 * vers  date	    who         what
 * ----  ---------  ----------  ------------------------------------
 * a     ~~ Feb 92  M. Adler	used full (large, one-step) lookup table
 * b1    21 Mar 92  M. Adler	first version with partial lookup tables
 * b2    21 Mar 92  M. Adler	fixed bug in fixed-code blocks
 * b3    22 Mar 92  M. Adler	sped up match copies, cleaned up some
 * b4    25 Mar 92  M. Adler	added prototypes; removed window[] (now
 *				is the responsibility of unzip.h--also
 *				changed name to slide[]), so needs diffs
 *				for unzip.c and unzip.h (this allows
 *				compiling in the small model on MSDOS);
 *				fixed cast of q in huft_build();
 * b5    26 Mar 92  M. Adler	got rid of unintended macro recursion.
 * b6    27 Mar 92  M. Adler	got rid of nextbyte() routine. fixed
 *				bug in inflate_fixed().
 * c1    30 Mar 92  M. Adler	removed lbits, dbits environment variables.
 *				changed BMAX to 16 for explode. Removed
 *				OUTB usage, and replaced it with flush()--
 *				this was a 20% speed improvement! Added
 *				an explode.c (to replace unimplode.c) that
 *				uses the huft routines here. Removed
 *				register union.
 * c2     4 Apr 92  M. Adler	fixed bug for file sizes a multiple of 32k.
 * c3    10 Apr 92  M. Adler	reduced memory of code tables made by
 *				huft_build significantly (factor of two to
 *				three).
 * c4    15 Apr 92  M. Adler	added NOMEMCPY do kill use of memcpy().
 *				worked around a Turbo C optimization bug.
 * c5    21 Apr 92  M. Adler	added the WSIZE #define to allow reducing
 *				the 32K window size for specialized
 *				applications.
 * c6    31 May 92  M. Adler	added some typecasts to eliminate warnings
 * c7    27 Jun 92  G. Roelofs	added some more typecasts (444: MSC bug).
 * c8     5 Oct 92  J-l. Gailly	added ifdef'd code to deal with PKZIP bug.
 * c9     9 Oct 92  M. Adler	removed a memory error message (~line 416).
 * c10   17 Oct 92  G. Roelofs	changed ULONG/UWORD/byte to ulg/ush/uch,
 *				removed old inflate, renamed inflate_entry
 *				to inflate, added Mark's fix to a comment.
 * c11   2 Jan 93  M. Adler	fixed bug in detection of incomplete
 *				tables, and removed assumption that EOB is
 *				the longest code (bad assumption).
 * c12   3 Jan 93  M. Adler	make tables for fixed blocks only once.
 * c13   5 Jan 93  M. Adler	allow all zero length codes (pkzip 2.04c
 *				outputs one zero length code for an empty
 *				distance tree).
 * c14   12 Mar 93  M. Adler	made inflate.c standalone with the
 *				introduction of inflate.h.
 * d0    25 Apr 93  M. Adler	several speedups in inflate_codes of
 *				almost 20% (suggested by Urban Mueller)--
 *				now requires the use of backfill.[ch]
 * d1     4 May 93  M. Adler	deleted extraneous statement in cheap loop,
 *				optimized common copy a little more.
 * d2     5 May 93  M. Adler	calculate number of cheap loops, a few
 *				other small optimizations.
 * p1       Nov 93  C. Plumb 	Adpated to be able to suspend itself.
 *				Pretty massive reorganization.
 *				Many comments added.
 * p2    18 Oct 95  C. Plumb	Improved interface some more. Now
 *				nicely re-entrant. Still more comments.
 * p3    19 Oct 95  C. Plumb	Changed infInflate core function so that
 *				it sucks the input completely dry before
 *				returning. This gets rid of the old ad-hoc
 *				technique for flushing out the last little
 *				bit of a compressed file by padding it
 *				with some dummy data, which was ugly.
 */


/*
 * Inflate deflated (PKZIP's method 8 compressed) data. The compression
 * method searches for as much of the current string of bytes (up to a
 * length of 258) in the previous 32K bytes. If it doesn't find any
 * matches (of at least length 3), it codes the next byte. Otherwise, it
 * codes the length of the matched string and its distance backwards from
 * the current position. There is a single Huffman code that codes both
 * single bytes (called "literals") and match lengths. A second Huffman
 * code codes the distance information, which follows a length code. Each
 * length or distance code actually represents a base value and a number
 * of "extra" (sometimes zero) bits to get to add to the base value. At
 * the end of each deflated block is a special end-of-block (EOB) literal/
 * length code. The decoding process is basically: get a literal/length
 * code; if EOB then done; if a literal, emit the decoded byte; if a
 * length then get the distance and emit the referred-to bytes from the
 * sliding window of previously emitted data.
 *
 * There are (currently) three kinds of inflate blocks: stored, fixed, and
 * dynamic. The compressor outputs a chunk of data at a time and decides
 * which method to use on a chunk-by-chunk basis. A chunk might typically
 * be 32K to 64K, uncompressed. If the chunk is uncompressible, then the
 * "stored" method is used. In this case, the bytes are simply stored as
 * is, eight bits per byte, with none of the above coding. The bytes are
 * preceded by a (16-bit) count, since there is no longer an EOB code.
 *
 * If the data is compressible, then either the fixed or dynamic methods
 * are used. In the dynamic method, the compressed data is preceded by
 * an encoding of the literal/length and distance Huffman codes that are
 * to be used to decode this block. The representation is itself Huffman
 * coded, and so is preceded by a description of that code. These code
 * descriptions take up a little space, and so for small blocks, there is
 * a predefined set of codes, called the fixed codes. The fixed method is
 * used if the block ends up smaller that way (usually for quite small
 * chunks); otherwise the dynamic method is used. In the latter case, the
 * codes are customized to the probabilities in the current block and so
 * can code it much better than the pre-determined fixed codes can.
 *
 * The Huffman codes themselves are decoded using a mutli-level table
 * lookup, in order to maximize the speed of decoding plus the speed of
 * building the decoding tables. See the comments below that precede the
 * LBITS and DBITS tuning parameters.
 */


/*
 *  Notes beyond the 1.93a  appnote.txt:
 *
 * 1. Distance pointers never point before the beginning of the output
 * stream.
 * 2. Distance pointers can point back across blocks, up to 32k away.
 * 3. There is an implied maximum of 7 bits for the bit length table and
 * 15 bits for the actual data.
 * 4. If only one code exists, then it is encoded using one bit. (Zero
 * would be more efficient, but perhaps a little confusing.) If two
 * codes exist, they are coded using one bit each (0 and 1).
 * 5. There is no way of sending zero distance codes--a dummy must be
 * sent if there are none. (History: a pre 2.0 version of PKZIP would
 * store blocks with no distance codes, but this was discovered to be
 * too harsh a criterion.) Valid only for 1.93a. 2.04c does allow
 * zero distance codes, which is sent as one code of zero bits in
 * length.
 * 6. There are up to 286 literal/length codes. Code 256 represents the
 * end-of-block. Note however that the static length tree defines
 * 288 codes just to fill out the Huffman codes. Codes 286 and 287
 * cannot be used though, since there is no length base or extra bits
 *	defined for them. Similarily, there are up to 30 distance codes.
 *	However, static trees define 32 codes (all 5 bits) to fill out the
 *	Huffman codes, but the last two had better not show up in the data.
 * 7. Unzip can check dynamic Huffman blocks for complete code sets.
 * The exception is that a single code would not be complete (see #4).
 * 8. The five bits following the block type is really the number of
 * literal codes sent minus 257.
 * 9. Length codes 8,16,16 are interpreted as 13 length codes of 8 bits
 * (1+6+6). Therefore, to output three times the length, you output
 * three codes (1+1+1), whereas to output four times the same length,
 * you only need two codes (1+3). Hmm.
 * 10. In the tree reconstruction algorithm, Code = Code + Increment
 * only if BitLength(i) is not zero. (Pretty obvious.)
 * 11. Correction: 4 Bits: # of Bit Length codes - 4 (4 - 19)
 * 12. Note: length code 284 can represent 227-258, but length code 285
 * really is 258. The last length deserves its own, short code
 * since it gets used a lot in very redundant files. The length
 * 258 is special since 258 - 3 (the min match length) is 255.
 * 13. The literal/length and distance code bit lengths are read as a
 * single stream of lengths. It is possible (and advantageous) for
 * a repeat code (16, 17, or 18) to go across the boundary between
 * the two sets of lengths.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <string.h> /* for memset() */

#include "pgpDebug.h"
#include "pgpMem.h"
#include "pgpUsuals.h"
#include "pgpZInflate.h"

/* Increasing these only wastes space, so they can be changed if necessary */
typedef word16 ush;
typedef word32 ulg;

/* Private context structure for use by all functions. */
struct InflateContext {
	/* Major state information */
	int state;
	int substate;
	int lastblock;

	/* Output-related information */
	unsigned char *slide; /* Circular output buffer */
	unsigned char *slideend;
	unsigned slidelen; /* slideend-slide - MUST BE POWER OF 2 */
	unsigned slidemask; /* slidelen-1 */
	unsigned char *outptr; /* Pointer into slide */
	unsigned char const *readptr; /* Pointer into slide for reading */

	/* Input-related information */
	unsigned char const *inptr; /* Input pointer */
	int inlen;  /* Input length */
	ulg bitbuffer;
	unsigned bufbits;

	/* The literal/length tree - also used for the bit-length tree */
	struct huft *tree1;
	unsigned bits1;

	/* The distance tree */
	struct huft *tree2;
	unsigned bits2;

	/* Encoded huffman tree */
	unsigned char bitlen[286+30];

	/* For dynamic trees */
	unsigned bitlengths;
	unsigned litcodes;
	unsigned distcodes;

	/* Used in various places */
	struct huft const *t;
	unsigned copylen;
	int distbase;
	int numbits; /* # of bits in dyn. tree repeat and after dist. code*/
	unsigned index; /* Position in dynamic tree bit lengths we've read to*/
};

/* Options for behaviour */
#ifndef SECURE
#define SECURE 1	/* Wipe memory before freeing it? */
#endif

#ifndef WSIZE
#define WSIZE 32768	/* Window size - 32768 for PKZIP compatibility */
#endif

#ifndef STRICT
#define STRICT 1	/* Require unused bits to be zero? */
#endif

/*
 * Huffman code lookup table entry--this entry is four bytes for machines
 * that have 16-bit pointers (e.g. PC's in the small or medium model).
 * Valid extra bits are 0..13. e == 32 is EOB (end of block), e == 16
 * means that v is a literal, e < 0 means that v is a pointer to the next
 * table, which codes -e bits, and lastly e == -128 indicates an unused
 * code. If a code with e == -128 is looked up, this implies an error in
 * the data.
 */
struct huft {
	union {
		struct {
			signed char exop; /* # of extra bits or operation */
			char bits; /* # of bits in this code/subcode */
		} what;
		char *pad;	/* pad structure to a power of 2 (4 bytes for*/
	} word; 		/* 16-bit, 8 bytes for 32-bit machines) */
	union {
		ush base;	/* literal, length base, or distance base */
		struct huft *next; /* pointer to next level of table */
	} more;
};

#define base more.base
#define next more.next
#define exop word.what.exop
#define bits word.what.bits

/* Function prototypes */
#ifndef OF
# if defined(__STDC__) || defined(__cplusplus)
# define OF(a) a
# else
# define OF(a) ()
# endif
#endif

static int huft_build OF((unsigned char const *, unsigned, unsigned,
			  ush const *, ush const *, struct huft **,
			  unsigned *));
static int huft_free OF((struct huft *));

/*
 * The inflate algorithm uses a sliding 32K byte window on the uncompressed
 * stream to find repeated byte strings. This is implemented here as a
 * circular buffer. The index is updated simply by incrementing and then
 * and'ing with 0x7fff (32K-1).
 */

/* Tables for deflate from PKZIP's appnote.txt. */
static unsigned const border[] = { /* Order of the bit length code lengths */
 16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};

static ush const cplens[] = { /* Copy lengths for literal codes 257..285 */
 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 17, 21, 25, 29,
 33, 41, 49, 57, 65, 81, 97, 113, 129, 161, 193, 225, 256, 0, 0};
 /* actually lengths - 2; also see note #13 above about 258 */

static ush const cplext[] = { /* Extra bits for literal codes 257..285 */
 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 128, 128}; /* 128==invalid */

static ush const cpdist[] = { /* Copy offsets for distance codes 0..29 */
 1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
 8193, 12289, 16385, 24577};

static ush const cpdext[] = { /* Extra bits for distance codes */
 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
 7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
 12, 12, 13, 13};

/* And'ing with mask[n] masks the lower n bits */
static unsigned const mask[17] = {
0x0000,
0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
};


/* Macros for inflate() bit peeking and grabbing.
 * The usage is:
 *
 *	NEEDBITS(j)
 *	x = b & mask[j];
 *	DUMPBITS(j)
 *
 * where NEEDBITS makes sure that b has at least j bits in it, and
 * DUMPBITS removes the bits from b. The macros use the variable k
 * for the number of bits in b. Normally, b and k are register
 * variables for speed, and are initialized at the beginning of a
 * routine that uses these macros from a global bit buffer and count.
 *
 * It is allowed for more bits to be requested than actually used.
 * The remainder stay in the bit buffer. NOTE that a few more
 * bytes than necessary may be grabbed at the end of input.
 * This should not be fatal as long as the grabbed bits stay
 * in the bit buffer. The wrapup functions should check for this.
 *
 * There is also the macro GRABBITS which is like NEEDBITS, but uses
 * *g++ to get the byte without checking availability. This requires
 * using AVAILBYTES first to assure that the needed bytes are there
 * already. g is set to inptr and then inptr is restored to g around
 * this usage.
 */

/*
 * Variable usage:
 * b = bit buffer, k least-significant bits valid
 * k = # of bits in bit buffer
 * g = grab bits pointer (pointer to next byte to add: b |= *g++ << k)
 * s = # of bytes available
 * ctx = InflateContext
 */

/* Functions to save the state of the bit buffer before returning */
#define LOADBITBUF \
	(b=ctx->bitbuffer, k=ctx->bufbits, g=ctx->inptr, s=ctx->inlen)
#define SAVEBITBUF \
	(ctx->bitbuffer=b, ctx->bufbits=k, ctx->inptr=g, ctx->inlen=s)
#define SAVEBITBUFEMPTY \
	(ctx->bitbuffer=b, ctx->bufbits=k, ctx->inptr=g, ctx->inlen=0)

/*
 * A simple macro to ensure that at least "x" bits are in the bit buffer.
 * Does NOT check for input underflow (s < 0).
 */
#define GRABBITS(x) \
	while (k < x) { \
		--s; \
		b |= (ulg)*g++ << k; \
		k += 8; \
	}

/*
 * Get "x" bits in the input buffer or execute the "whatif" code.
 * NOTE NOTE NOTE that if the "whatif" code is executed, s is set to -1!
 * (This is faster on a lot of machines.) You will usually have to
 * reset it to 0 manually.
 */
#define GETBITSOR(x, whatif) \
	while (k < (unsigned)(x)) { \
		if (--s < 0) { \
			whatif; \
		} \
		b |= (ulg)*g++ << k; \
		k += 8; \
	}

/*
 * A macro to ensure that there are at least "x" bits available in the
 * bit buffer. If there are not, the bit buffer is saved back into the
 * context, and any code in "savestate" is run to save any additional
 * context that might be needed. Then, "return 1" means that more input is
 * needed.
 */
#define NEEDBITS(x, savestate) \
	GETBITSOR(x, savestate; SAVEBITBUFEMPTY; return 1)

/*
 * NEEDBITS2 uses two figures for the number of bits required. The first,
 * x, is cheap to compute and is used unless we run out of input data.
 * If that happens, the more expensive value, x2, is used.
 */
#define NEEDBITS2(x, x2, savestate) \
	NEEDBITS(x, if (k >= (unsigned)(x2)) {s=0; break;} savestate)

#define DUMPBITS(x) (b >>= x, k -= x)

/*
 * Huffman code decoding is performed using a multi-level table lookup.
 * The fastest way to decode is to simply build a lookup table whose
 * size is determined by the longest code. However, the time it takes
 * to build this table can also be a factor if the data being decoded
 * is not very long. The most common codes are necessarily the
 * shortest codes, so those codes dominate the decoding time, and hence
 * the speed. The idea is you can have a shorter table that decodes the
 * shorter, more probable codes, and then point to subsidiary tables for
 * the longer codes. The time it costs to decode the longer codes is
 * then traded against the time it takes to make longer tables.
 *
 * This results of this trade are in the values LBITS and DBITS
 * below. LBITS is the number of bits the first level table for literal/
 * length codes can decode in one step, and DBITS is the same thing for
 * the distance codes. Subsequent tables are also less than or equal to
 * those sizes. These values may be adjusted either when all of the
 * codes are shorter than that, in which case the longest code length in
 * bits is used, or when the shortest code is *longer* than the requested
 * table size, in which case the length of the shortest code in bits is
 * used.
 *
 * There are two different values for the two tables, since they code a
 * different number of possibilities each. The literal/length table
 * codes 286 possible values, or in a flat code, a little over eight
 * bits. The distance table codes 30 possible values, or a little less
 * than five bits, flat. The optimum values for speed end up being
 * about one bit more than those, so LBITS is 8+1 and DBITS is 5+1.
 * The optimum values may differ though from machine to machine, and
 * possibly even between compilers. Your mileage may vary.
 */

#define LBITS 9 /* bits in base literal/length lookup table */
#define DBITS 6 /* bits in base distance lookup table */

/* If BMAX needs to be larger than 16, then h and x[] should be ulg. */
#define BMAX 15 /* maximum bit length of any code (16 for explode) */
#define N_MAX 288 /* maximum number of codes in any set */

#if defined(__STDC__) || defined(__cplusplus)
static int
huft_build(unsigned char const *b, unsigned n, unsigned s, ush const *d,
           ush const *e, struct huft **t, unsigned *m)
#else
static int
huft_build(b, n, s, d, e, t, m)
    unsigned char *b; /* code lengths in bits (all assumed <= BMAX) */
    unsigned n; /* number of codes (assumed <= N_MAX) */
    unsigned s; /* number of simple-valued codes (0..s-1) */
    ush const *d;	/* list of base values for non-simple codes */
    ush const *e;	/* list of extra bits for non-simple codes */
    struct huft **t;	/* result: starting table */
    unsigned *m;	/* suggested lookup bits, returns actual */
#endif
/*
 * Given a list of code lengths and a maximum table size, make a set of
 * tables to decode that set of codes. Return values:
 * 0 = success
 * 1 = the given code set is incomplete
 * (the tables are still built in this case)
 * 2 = the input is invalid
 * (all zero length codes or an oversubscribed set of lengths)
 * 3 = not enough memory.
 */
{
    unsigned a;	/* counter for codes of length k */
    unsigned c[BMAX+1];	/* bit length count table */
    unsigned f;	/* i repeats in table every f entries */
    int g;	/* maximum code length */
    int h;	/* table level */
    register unsigned i;	/* counter, current code */
    register unsigned j;	/* counter */
    register int k;	/* number of bits in current code */
    int l;	/* bits per table (returned in m) */
    register unsigned char const *bp; /* pointer into b[] */
    register unsigned *p;	/* pointer into c[] or v[] */
    register struct huft *q;	/* points to current table */
    struct huft r;	/* table entry for structure assignment */
    struct huft *u[BMAX];	/* table stack */
    unsigned v[N_MAX];	/* values in order of bit length */
    register int w;	/* bits before this table == (l * h) */
    unsigned x[BMAX+1];	/* bit offsets, then code stack */
    unsigned *xp;	/* pointer into x */
    int y;	/* number of dummy codes added */
    unsigned z;	/* number of entries in current table */


    /* Generate counts for each bit length */
    memset(c, 0, sizeof(c));
    bp = b; i = n;
    do {
	c[*bp++]++;	/* assume all entries <= BMAX */
    } while (--i);
    if (c[0] == n) {	/* null input--all zero length codes */
	*t = (struct huft *)NULL;
	*m = 0;
	return 0;
    }


    /* Find minimum and maximum length, bound *m by those */
    l = *m;
    for (j = 1; j <= BMAX; j++)
	if (c[j])
	    break;
    k = j;	/* minimum code length */
    if ((unsigned)l < j)
	l = j;
    for (i = BMAX; i; i--)
	if (c[i])
	    break;
    g = i;	/* maximum code length */
    if ((unsigned)l > i)
	l = i;
    *m = l;


    /* Adjust last length count to fill out codes, if needed */
    for (y = 1 << j; j < i; j++, y <<= 1)
	if ((y -= c[j]) < 0)
	    return 2;	/* bad input: more codes than bits */
    if ((y -= c[i]) < 0)
	return 2;
    c[i] += y;


    /* Generate starting offsets into the value table for each length */
    x[1] = j = 0;
    p = c + 1;
    xp = x + 2;
    while (--i) {	/* note that i == g from above */
	*xp++ = (j += *p++);
    }


    /* Make a table of values in order of bit lengths */
    bp = b; i = 0;
    do {
	if ((j = *bp++) != 0)
	    v[x[j]++] = i;
    } while (++i < n);


    /* Generate the Huffman codes and for each, make the table entries */
    x[0] = i = 0;	/* first Huffman code is zero */
    p = v;	/* grab values in bit order */
    h = -1;	/* no tables yet--level -1 */
    w = -l;	/* bits decoded == (l * h) */
    u[0] = (struct huft *)NULL; /* just to keep compilers happy */
    q = (struct huft *)NULL;    /* ditto */
    z = 0;	/* ditto */

    /* go through the bit lengths (k already is bits in shortest code) */
    for (; k <= g; k++) {
	a = c[k];
	while (a--) {
	    /* here i is the Huffman code of length k bits for value *p */
	    /* make tables up to required level */
	    while (k > w + l) {
		h++;
		w += l; /* previous table always l bits */

		/* compute minimum size table less than or equal to l bits */
		z = (z = g - w) > (unsigned)l ? l : z; /* upper limit on table size */
		if ((f = 1 << (j = k - w)) > a + 1) /* try a k-w bit table */
		{	/* too few codes for k-w bit table */
		    f -= a + 1; /* deduct codes from patterns left */
		    xp = c + k;
		    while (++j < z) { /* try smaller tables up to z bits */
			if ((f <<= 1) <= *++xp)
			    break;	/* enough codes to use up j bits */
			f -= *xp;	/* else deduct codes from patterns */
		    }
		}
		z = 1 << j;			/* table entries for j-bit table */

		/* allocate and link in new table */
		q = (struct huft *)pgpMemAlloc((z + 1)*sizeof(struct huft));
		if (q == (struct huft *)NULL) {
			if (h)
				huft_free(u[0]);
			return 3;		/* not enough memory */
		}
#if SECURE
		q->bits = (char)j;			/* Track size for free */
#endif
		*t = q + 1;			/* link to list for huft_free() */
		*(t = &(q->next)) = (struct huft *)NULL;
		u[h] = ++q; /* table starts after link */

		/* connect to last table, if there is one */
		if (h) {
		    x[h] = i;		/* save pattern for backing up */
		    r.bits = (char)l;		/* bits to dump before this table */
		    r.exop = -(char)j;		/* bits in this table */
		    r.next = q;		/* pointer to this table */
		    j = i >> (w - l);		/* (get around Turbo C bug) */
		    u[h-1][j] = r;		/* connect to last table */
		}
	    }

	    /* set up table entry in r */
	    r.bits = (char)(k - w);
	    if (p >= v + n) {
		r.exop = -128; /* out of values--invalid code */
	    } else if (*p < s) {
		r.exop = (char)(*p < 256 ? 16 : 32); /* 256 is end-of-block code */
		r.base = *p++; /* simple code is just the value */
	    } else {
		r.exop = (char)e[*p - s]; /* non-simple--look up in lists */
		r.base = d[*p++ - s];
	    }

	    /* fill code-like entries with r */
	    f = 1 << (k - w);
	    for (j = i >> w; j < z; j += f)
		q[j] = r;

	    /* backwards increment the k-bit code i */
	    for (j = 1 << (k - 1); i & j; j >>= 1)
		i ^= j;
	    i ^= j;

	    /* back up over finished tables */
	    while ((i & ((1 << w) - 1)) != x[h]) {
		h--; /* don't need to update q */
		w -= l;
	    }
	}
    }

    /* Return true (1) if we were given an incomplete table */
    return y != 0 && g != 1;
}


#if defined(__STDC__) || defined(__cplusplus)
static int
huft_free(struct huft *t)
#else
static int
huft_free(t)
	struct huft *t;	/* table to free */
#endif
/*
 * Free the malloc'ed tables built by huft_build(), which makes a linked
 * list of the tables it made, with the links in a dummy -1st entry of
 * each table.
 */
{
	register struct huft *p, *q;

	/* Go through linked list, freeing from the malloced (t[-1]) address. */
	p = t;
	while (p != (struct huft *)NULL)
	{
		q = (--p)->next;
#if SECURE
		memset(p, 0, (1+(1<<p->bits)) * sizeof(*p));
#endif
		pgpMemFree(p);
		p = q;
	}
	return 0;
}


/*
 * Colin's new code.
 */

#define STATE_START 0
#define STATE_STOREDLEN 1
#define STATE_STORED 2
#define STATE_DYN_HDR 3
#define STATE_DYN_BITS 4
#define STATE_DYN_TREE 5
#define STATE_INFLATE 6
#define STATE_DONE 7
#define STATE_STOP 8

/*
 * All these functions return
 * 2 if the output buffer is full
 * 1 if the input buffer is empty
 * 0 if things should continue with the new ctx->state, and
 * <0 on error.
 */

static int
infStoredLen(struct InflateContext *ctx)
{
	ulg b;
	unsigned k;
	int s;
	unsigned char const *g;
	unsigned t;

	LOADBITBUF;
	t = k & 7;
#if STRICT
	if (b & mask[t])	/* Require unused bits are zero */
		return INFERR_BADINPUT;
#endif
	DUMPBITS(t);

	NEEDBITS(32, (void)0);

	/* At this point, k is exactly 32 */

	ctx->copylen = (unsigned)b & 0xffff;
	t = ~(unsigned)(b>>16) & 0xffff;
	b = 0;
	k = 0;

	SAVEBITBUF;
	if (t != ctx->copylen)
		return INFERR_BADINPUT; /* Two lengths not identical */

	ctx->state = STATE_STORED;
	ctx->substate = 0;

	return 0;
}

/*
 * Process the data in a stored block. Copy the input data to
 * the circular buffer, flushing it as necessary.
 */
static int
infStored(struct InflateContext *ctx)
{
	int len; /* # of bytes to copy */
	int retval = 1; /* Out of memory */

	pgpAssert(ctx->bufbits == 0);

	len = ctx->inlen;
	if ((unsigned)len >= ctx->copylen) {
		len = ctx->copylen; /* Copy done! */
		ctx->state = STATE_START;
		retval = 0;
	}
	if (len > ctx->slideend-ctx->outptr) {
		len = (int)(ctx->slideend-ctx->outptr);
		retval = 2; /* Output buffer full */
	}

	memcpy(ctx->outptr, ctx->inptr, len);
	ctx->inptr += len;
	ctx->inlen -= len;
	ctx->outptr += len;
	ctx->copylen -= (unsigned)len;

	/* Return 2 if output full, 1 if input empty, 0 otherwise (copy done)*/
	return retval;
}

static int
infDynHdr(struct InflateContext *ctx)
{
	ulg b;
	unsigned k;
	int s;
	unsigned char const *g;

	LOADBITBUF;
	NEEDBITS(14, (void)0);

	ctx->litcodes = 257 + ((unsigned)b & 0x1f);
	DUMPBITS(5);
	ctx->distcodes = 1 + ((unsigned)b & 0x1f);
	DUMPBITS(5);
	ctx->bitlengths = 4 + ((unsigned)b & 0xf);
	DUMPBITS(4);

	SAVEBITBUF;

#ifndef PKZIP_BUG_WORKAROUND
	if (ctx->litcodes > 286 || ctx->distcodes > 30)
		return INFERR_BADINPUT; /* Bad lengths */
#endif
	ctx->state = STATE_DYN_BITS;
	return 0;
}

/* Load up the ctx->bitlen array with the bit lengths for the encoded
 * trees. Unpermute them according to the border[] array.
 */
static int
infDynBits(struct InflateContext *ctx)
{
	ulg b;
	unsigned k;
	int s;
	unsigned char const *g;
	struct huft *t;
	int i, lim;

	LOADBITBUF;
	i = ctx->substate;
	lim = ctx->bitlengths;

	while (i < lim) {
		NEEDBITS(3, ctx->substate=i)
		ctx->bitlen[border[i++]] = (unsigned)b & 7;
		DUMPBITS(3);
	}
	SAVEBITBUF;

	while (i < 19)
		ctx->bitlen[border[i++]] = 0;

	k = 7; /* Bits in tree table */

	i = huft_build(ctx->bitlen, 19, 19, NULL, NULL, &t, &k);
	if (i) {
		if (i == 1)
			huft_free(t); /* Incomplete code set */
			return i == 3 ? INFERR_NOMEM : INFERR_BADINPUT;
		}
	ctx->tree1 = t;
	ctx->bits1 = k;

	ctx->state = STATE_DYN_TREE;
	ctx->substate = 0;

	return 0;
}

/* The static tree (built on demand) */
static struct huft *fixed_tl = NULL;
static struct huft *fixed_td;
static unsigned fixed_bl, fixed_bd;

static int
infFixedTree(void)
{
	int i;
	unsigned char l[288];

	if (fixed_tl)
		return 0;	/* All okay */

	/* literal table */
	for (i = 0; i < 144; i++)
		l[i] = 8;
	for (; i < 256; i++)
		l[i] = 9;
	for (; i < 280; i++)
		l[i] = 7;
	for (; i < 288; i++)	/* make a complete, but wrong code set */
		l[i] = 8;
	fixed_bl = 7;
	i = huft_build(l, 288, 257, cplens, cplext, &fixed_tl, &fixed_bl);
	if (i != 0) {
		fixed_tl = NULL;
		return INFERR_NOMEM;
	}

	/* distance table */
	for (i = 0; i < 30; i++)	/* make an incomplete code set */
		l[i] = 5;
	fixed_bd = 5;
	i = huft_build(l, 30, 0, cpdist, cpdext, &fixed_td, &fixed_bd);
	if (i > 1) {
		huft_free(fixed_tl);
		fixed_tl = NULL;
		return INFERR_NOMEM;
	}

	return 0;
}

static int
infDynTree(struct InflateContext *ctx)
{
	ulg b;
	unsigned k;
	int s;
	unsigned char const *g;
	struct huft *tl, *td;
	unsigned bl, bd;
	unsigned i, j, l, m, lim;

	LOADBITBUF;
	i = ctx->index;
	l = ctx->numbits; /* Previous # of bits for repeat code use */
	lim = ctx->litcodes + ctx->distcodes;
	tl = ctx->tree1;
	bl = ctx->bits1;
	m = mask[bl];

	switch(ctx->substate) {
	case 0:
		i = 0;
		l = 0;
		/*FALLTHROUGH*/
	case 1:
		while (i < lim) {
			NEEDBITS2(bl, tl[(unsigned)b & m].bits,
				  ctx->index=i; ctx->numbits=l; ctx->substate=1)
			td = tl + ((unsigned)b & m);
			j = td->bits;
			DUMPBITS(j);
			j = td->base;
			if (j < 16) {
				ctx->bitlen[i++] = l = j;
			} else if (j == 16) { /* 3 to 6 repeats */
				/*FALLTHROUGH*/
	case 2:
				NEEDBITS(2, ctx->index=i; ctx->numbits=l;
					 ctx->substate=2)
				j = 3 + ((unsigned)b & 3);
				DUMPBITS(2);
				if (i + j > lim)
					return INFERR_BADINPUT;
				do {
					ctx->bitlen[i++] = (unsigned char)l;
				} while (--j);
			} else if (j == 17) { /* 3 to 10 zeros */
				/*FALLTHROUGH*/
	case 3:
				NEEDBITS(3, ctx->index=i; ctx->substate=3)
				j = 3 + ((unsigned)b & 7);
				DUMPBITS(3);
				if (i + j > lim)
					return INFERR_BADINPUT;
				do {
					 ctx->bitlen[i++] = 0;
				} while (--j);
					l = 0;
			} else { /* j == 18 -- 11 to 138 zeros */
				pgpAssert(j == 18);
				/*FALLTHROUGH*/
	case 4:
				NEEDBITS(7, ctx->index=i; ctx->substate=4)
				j = 11 + ((unsigned)b & 127);
				DUMPBITS(7);
				if (i + j > lim)
					return INFERR_BADINPUT;
				do {
					ctx->bitlen[i++] = 0;
				} while (--j);
				l = 0;
			}
		}
	}

	/* Input finished */
	SAVEBITBUF;
	huft_free(tl);
	ctx->tree1 = 0;

	/* Now build the trees - literal/length, then distance */

	bl = LBITS;
	i = huft_build(ctx->bitlen, ctx->litcodes, 257,
		cplens, cplext, &tl, &bl);
	if (i != 0) {
		if (i == 1)
			huft_free(tl);
		return i == 3 ? INFERR_NOMEM : INFERR_BADINPUT;
	}
	bd = DBITS;
	i = huft_build(ctx->bitlen+ctx->litcodes, ctx->distcodes, 0,
		 cpdist, cpdext, &td, &bd);
#ifdef PKZIP_BUG_WORKAROUND
	if (i > 1) {
#else
	if (i != 0) {
		if (i == 1)
			huft_free(td);
#endif
		huft_free(tl);
		return i == 3 ? INFERR_NOMEM : INFERR_BADINPUT;
	}
	ctx->tree1 = tl;
	ctx->bits1 = bl;
	ctx->tree2 = td;
	ctx->bits2 = bd;

	ctx->state = STATE_INFLATE;
	ctx->substate = 0;

	return 0;
}

/*
 * This is the heart of ZIP inflation. The code is heavily optimized
 * for speed, including for many brain-damaged compilers that can only
 * optimize one statement at a time. To generate better code from
 * such idiot compilers (which are distressingly common on platforms
 * such as MS-DOS), expressions are made big and complex, and intermediate
 * results are assigned to variables in the expression where possible
 * so the compiler won't try to use a disjoint temporary and have to
 * spill. This makes the code a little hard to follow at times.
 * Sorry.
 *
 * Also, due to the deep nesting (it's all in one function, again, for
 * speed even on systems that can't inline), the indent amount is only
 * two spaces and variable names are very short.
 *
 * This does NOT currently detect a reference to before the beginning of
 * the file. It just blindly uses the circular buffer.
 */
static int
infInflate(struct InflateContext *ctx)
{
  ulg b;  /* Bit buffer info - bit buffer itself */
  unsigned k;  /* Number of low0order bits of b that are valid */
  int s;  /* Bytes of valid input remaining */
  unsigned char const *g; /* Input buffer pointer */

  unsigned char *w; /* Window output write pointer */
  unsigned r;  /* Space available after w (always >0) */

  struct huft *tl, *td; /* Tree info (const except for EOB processing) */
  unsigned bl, bd;
  unsigned ml, md;
  struct huft const *t; /* Temporary tree pointer */

  unsigned char const *p; /* Copy source pointer */
  int i;
  int e;
  unsigned n;  /* Copy length */
  unsigned d;  /* Copy distance */

  LOADBITBUF; 	/* Load b, k, s, g */

  w = ctx->outptr;
  r = ctx->slideend-w;
  pgpAssert(r);

  tl = ctx->tree1;	/* Literal/length tree */
  bl = ctx->bits1;	/* Number of bits in top-level table */
  ml = mask[bl];	/* Mask of that many bits */

  td = ctx->tree2;	/* Distance tree */
  bd = ctx->bits2;	/* Number of bits in top-level table */
  md = mask[bd];	/* Mask of that many bits */

  /*
  * We don't always need all of these, but it's easier to always
  * load them than to do it conditionally.
  */
  t = ctx->t;
  n = ctx->copylen;
  d = ctx->distbase;
  e = ctx->numbits;

  switch (ctx->substate) {
  case 0:
    for (;;) {	/* do until end of block */
      /*
       * This cheap loop does no input or output checking.
       * At most 258 bytes of output are produced per iteration,
       * so we must do no more than r/258 iterations.
       * Also, at most 15+5+15+13 = 48 bits = 6 bytes are consumed
       * every iteration, so we can do no more than s/6 iterations.
       * Also, to allow for starting with an empty bit buffer and
       * ending with a full one, subtract 4 bytes, so it's (s-4)/6.
       *
       * These are approximated by r/256-1 and (s-2)/8, respectively.
       * Note: for a file that compresses to 258 bytes per symbol (e.g. all
       * the same character), that approximation would break down if
       *
       * r/256-1 > r/258
       * thus, 258 * r - 256 * 258 > 256*r
       * thus, 2 * r > 256 * 258
       * thus, r > 128 * 258 = 33024 > 32768
       *
       * Of course, the window is <= 32768, so it's not a concern.
       *
       * For the input approximation to break down, you'd have to have
       *
       * (s-2)/8 > (s-4)/6
       * thus, 6*s - 12 > 8*s - 32
       * thus, 20 > 2*s
       * thus, 10 > s
       *
       * But for s<10, both approximations (since this is integer math)
       * return 0, so it's not a problem. The r/258 limit is usually
       * hit first, so the crudeness of this approximation is acceptable.
       */
      while (r >= 512 && s >= 10) {
	/* Compute number of iterations we can do, worst-case */
	if ((e = (s - 2) >> 3) < (i = (r >> 8) - 1))
	  i = e;
	/*
	 * This is the cheap loop, which is performed i times before
	 * the available buffer space is re-evaluated. If you want to
	 * understand how the inflation process works, this is the best
	 * part of the code to read, since it isn't cluttered up with
	 * error checking. First comes a literal/length code, which
	 * can be either a literal (0-255), an end of block code (256),
	 */
	do {
	  GRABBITS(20); /* max bits for literal/length code */
	  t = tl + ((unsigned)b & ml);
	  if ((e = t->exop) < 0) {
	    do {
	      if (e == -128)
		return INFERR_BADINPUT;
	      DUMPBITS(t->bits);
	      e = -e;
	      t = t->next + ((unsigned)b & mask[e]);
	    } while ((e = t->exop) < 0);
	  }
	  DUMPBITS(t->bits);
	  if (e & 16) { /* then it's a literal */
	    *w++ = (unsigned char)t->base;
	    continue;
	  }
	  if (e & 32)  /* EOB */
	    goto EOB; /* At end of function */

	  /* Else length code */

	  /* get length of block to copy */
	  n = t->base + ((unsigned)b & mask[e]);
	  DUMPBITS(e);

	  /* decode distance of block to copy */
	  GRABBITS(15);
	  t = td + ((unsigned)b & md);
	  if ((e = t->exop) < 0) {
	    do {
	      if (e == -128)
		return INFERR_BADINPUT;
	      DUMPBITS(t->bits);
	      e = -e;
	      t = t->next + ((unsigned)b & mask[e]);
	    } while ((e = t->exop) < 0);
	  }
	  DUMPBITS(t->bits);
	  GRABBITS((unsigned)e); /* get up to 13 extra bits */
	  d = t->base + ((unsigned)b & mask[e]);
	  DUMPBITS((unsigned)e);

#if WSIZE < 32768
	  if (d > ctx->slidelen)
	    return INFERR_BADINPUT;
#endif

	  /* do the copy */
	  if ((unsigned)(w - ctx->slide) >= d) {
	    p = w - d;
	    *w++ = *p++;
	    *w++ = *p++;
	    do {
	      *w++ = *p++;
	    } while (--n);
	  } else {
	    n += 2;
	    p = w - d + ctx->slidelen;
	    do {
	      n -= (e = (unsigned)(e = ctx->slideend - (p>w?p:w)) > n ? n : e);
	      do {
		*w++ = *p++;
	      } while (--e);
	      if (p == ctx->slideend)
		p = ctx->slide;
	    } while (n);
	  }
	} while (--i);

	r = ctx->slideend - w;
      } /* while (we can use the cheap loop) */

      /*
       * Okay, we've fallen through from the cheap loop to the
       * expensive loop. This one checks each time it gets bits
       * from the input or writes bytes to the output that there
       * is enough room. However, there are two versions of
       * much of *this*, too! The first uses worst-case figures
       * for the amount of input data needed, and obtains one batch of
       * input bits for several uses.
       * The second carefully avoids asking for any more bits than it really
       * needs. When it gives up and returns, it is really not possible
       * to extract any more symbols from the input data.
       */
      /* Pessimistic estimate of bits for literal/length: 15+5 */
      GETBITSOR(20, goto getlitlength2)
      t = tl + ((unsigned)b & ml);
      if ((e = t->exop) < 0) {
	do {
	  if (e == -128)
	    return INFERR_BADINPUT;
	  DUMPBITS(t->bits);
	  e = -e;
	  t = t->next + ((unsigned)b & mask[e]);
	} while ((e = t->exop) < 0);
      }
      DUMPBITS(t->bits);
      if (e & 16) { /* then it's a literal */
	*w++ = (unsigned char)t->base;
	if (--r == 0) {
	  SAVEBITBUF;
	  ctx->outptr = w;
	  ctx->substate = 0; /* Restart at top of loop */
	  return 2; /* Output buffer full */
	}
	continue;
      }

      if (e & 32)
	break; /* Leave infinite loop */

      goto gotlength;

getlitlength2:
      /* Method 2: We don't even have 20 bits available - do it bit-by-bit. */
      t = tl + ((unsigned)b & ml);
      /*
       * See if higher-order bits we're missing actually matter.
       * We don't have to try to fill the bit buffer, because we only get
       * here if s (number of following input bytes) is supposed to be zero.
       */
      if (k < (unsigned)t->bits) {
	ctx->outptr = w;
	ctx->substate = 0;
	SAVEBITBUFEMPTY;
	return 1;
      }
      /* Actually, s is set (see GETBITSOR comment) to -1, so reset it */
      s = 0;
      if ((e = t->exop) < 0) {
	do {
	  if (e == -128)
	    return INFERR_BADINPUT;
	  DUMPBITS(t->bits);
	  e = -e;
	  t = t->next;
case 1:
	  NEEDBITS2(e, t[(unsigned)b & mask[e]].bits,
		    ctx->t=t; ctx->outptr=w; ctx->numbits=e; ctx->substate=1)
	  t += (unsigned)b & mask[e];
	} while ((e = t->exop) < 0);
      }
      DUMPBITS(t->bits);
      if (e & 16) { /* then it's a literal */
	*w++ = (unsigned char)t->base;
	if (--r == 0) {
	  /* We just filled the output buffer - return */
	  SAVEBITBUF;
	  ctx->outptr = w;
	  ctx->substate = 0; /* Restart at top of loop */
	  return 2; /* Output buffer full */
	}
	continue;
      }

      if (e & 32) /* EOB */
	break; /* Leave infinite loop */

      /*FALLTHROUGH*/
case 2:
      NEEDBITS(e, ctx->t = t; ctx->outptr=w; ctx->numbits=e; ctx->substate=2)

gotlength:

      /* All data is available - compute total length of block to copy */
      n = t->base + ((unsigned)b & mask[e]);
      DUMPBITS((unsigned)e);

      /*FALLTHROUGH*/
case 3:
      /* Get distance code - 15 is maximum code size */
      GETBITSOR(15, goto getdistance2)
      t = td + ((unsigned)b & md);
      /* Negative t->exop means there's a subtable of 2^-e entries */
      if ((e = t->exop) < 0) {
	do {
	  if (e == -128)
	    return INFERR_BADINPUT;	/* Invalid code (static table case) */
	  DUMPBITS(t->bits);
	  e = -e;
	  t = t->next + ((unsigned)b & mask[e]);
	} while ((e = t->exop) < 0);
      }
      goto gotdistance;

getdistance2:
      /* We don't even have 15 bits available - do it bit-by-bit. */
      t = td + ((unsigned)b & md);
      /*
       * See if higher-order bits we're missing actually matter.
       * We don't have to try to fill the bit buffer, because we only get
       * here if s (number of following input bytes) is supposed to be zero.
       */
      if (k < (unsigned)t->bits) {
	ctx->outptr = w;
	ctx->copylen = n;
	ctx->substate = 3;
	SAVEBITBUFEMPTY;
	return 1;
      }
      /* Actually (see GETBITSOR comment) s is set to -1, so reset it */
      s = 0;
      /* Negative t->exop means there's a subtable of 2^-e entries */
      if ((e = t->exop) < 0) {
	do {
	  if (e == -128)
	    return INFERR_BADINPUT;	/* Invalid code (static table case) */
	  DUMPBITS(t->bits);
	  e = -e;
	  t = t->next;
case 4:
	  NEEDBITS2(e, t[(unsigned)b & mask[e]].bits, ctx->t=t; ctx->outptr=w;
		      ctx->copylen = n; ctx->numbits=e; ctx->substate=4)
	  t += (unsigned)b & mask[e];
	} while ((e = t->exop) < 0);
      }

gotdistance:
      /* All data is available - compute the base distance */
      DUMPBITS(t->bits);
      d = t->base;
      /*FALLTHROUGH*/
case 5:
      /* e is number of bits extra following distance code (0..13) */
      NEEDBITS(e, ctx->outptr=w; ctx->copylen=n; ctx->distbase=d;
	       ctx->numbits=e; ctx->substate=5)
      d += ((unsigned)b & mask[e]);
      DUMPBITS((unsigned)e);

#if WSIZE < 32768
      if (d > ctx->slidelen)
	return INFERR_BADINPUT;
#endif

      /* do the copy, with handling for wrapping around end of buffer */
      if ((unsigned)(w - ctx->slide) >= d && w + n < ctx->slideend - 2) {
	/* Simple case - neither source nor dest cross end of buffer */
	p = w - d;
	r -= n + 2;
	*w++ = *p++;
	*w++ = *p++;
	do {
	  *w++ = *p++;
	} while (--n);
      } else {
	n += 2; /* # of bytes to copy */
	p = ctx->slide + ((w - ctx->slide - d) & ctx->slidemask); /* src */
	do {
	  /* Set e to number of bytes we can copy at once */
	  n -= (e = (unsigned)(e = ctx->slideend - (p>w?p:w)) > n ? n : e);
	  r -= e;
	  do {
	    *w++ = *p++;
	  } while (--e);
	  if (r == 0) { /* Did we just write everything we could? */
	    SAVEBITBUF;
	    ctx->outptr = w;
	    ctx->copylen = n;
	    ctx->distbase = d; /* Save copy distance to recompute p */
	    ctx->substate = 6;
	    return 2; /* Need more output space */
case 6:
	    p = ctx->slide + ((w - ctx->slide - d) & ctx->slidemask);
	  }
	  if (p == ctx->slideend)
	    p = ctx->slide;
	} while (n);
      }
    } /* for(;;) */
  } /* switch(ctx->subcase) */

EOB:
  /* End of Block */
  ctx->outptr = w;
  SAVEBITBUF;
  ctx->state = STATE_START;
  ctx->substate = 0;

  if (tl && tl != fixed_tl)
    huft_free(tl);
  if (td && td != fixed_td)
    huft_free(td);
  ctx->tree1 = 0;
  ctx->tree2 = 0;

  return 0;
}


/*
 * Start state - read 3 bits, which are last block flag (set to 1 on
 * last block), and 2 bits of block type.
 */
static int
infStart(struct InflateContext *ctx)
{
	ulg b;
	unsigned k;
	int s;
	unsigned char const *g;
	int retval = 0;

	if (ctx->lastblock) {
		ctx->state = STATE_DONE;
		return 0;
	}

	LOADBITBUF;
	NEEDBITS(3, (void)0);

	ctx->lastblock = (int)(b & 1);
	DUMPBITS(1);

	switch(b & 3) {
	case 0: /* Stored */
		ctx->state = STATE_STOREDLEN;
		break;
	case 1: /* Static - build fixed trees and start decoding */
		retval = infFixedTree();
		ctx->tree1 = fixed_tl;
		ctx->bits1 = fixed_bl;
		ctx->tree2 = fixed_td;
		ctx->bits2 = fixed_bd;
		ctx->state = STATE_INFLATE;
		break;
	case 2: /* Dynamic */
		ctx->state = STATE_DYN_HDR;
		break;
	case 3: /* Illegal */
		retval = INFERR_BADINPUT;
		break;
	}

	DUMPBITS(2);
	SAVEBITBUF;

	ctx->substate = 0;
	return retval;
}

/*
 * Get a pointer to available data in the output buffer
 */
unsigned char const *
infGetBytes(struct InflateContext *ctx, unsigned *len)
{
	*len = ctx->outptr - ctx->readptr;
	return *len ? ctx->readptr : 0;
}

/*
 * Mark data in the output buffer as already read. We don't start
 * accepting new data until the entire output buffer has been read,
 * at which point the outptr is set back to the beginning of the
 * buffer.
 */
void
infSkipBytes(struct InflateContext *ctx, unsigned len)
{
	pgpAssert(len <= (unsigned)(ctx->outptr - ctx->readptr));

	ctx->readptr += len;

	/* If at end of buffer, recirculate */
	if (ctx->readptr == ctx->slideend) {
		pgpAssert(ctx->outptr == ctx->slideend);
		ctx->readptr = ctx->outptr = ctx->slide;
	}
}


/*
 * Returns number of bytes written.
 * *error < 0 on error, == 0 if no error (done with input or output full)
 */
size_t
infWrite(struct InflateContext *ctx, unsigned char const *buf, size_t len,
int *error)
{
	int i;

	if (ctx->outptr == ctx->slideend) {
		*error = (ctx->state == STATE_STOP) ? 0 : ctx->substate;
		return 0; /* Out of output space! */
	}

	ctx->inptr = buf;
	/* Decompression code can't handle more than INT_MAX bytes at a time */
	ctx->inlen = len > INT_MAX ? INT_MAX : (int)len;

	do {
		switch(ctx->state) {
		case STATE_START:
			i = infStart(ctx);
			break;
		case STATE_STOREDLEN:
			i = infStoredLen(ctx);
			break;
		case STATE_STORED:
			i = infStored(ctx);
			break;
		case STATE_DYN_HDR:
			i = infDynHdr(ctx);
			break;
		case STATE_DYN_BITS:
			i = infDynBits(ctx);
			break;
		case STATE_DYN_TREE:
			i = infDynTree(ctx);
			break;
		case STATE_INFLATE:
			i = infInflate(ctx);
			break;
		case STATE_DONE:
			if (ctx->inlen || ctx->bufbits > 7)
				 i = INFERR_LONG;
#if STRICT
			else if (ctx->bitbuffer & mask[ctx->bufbits])
				i = INFERR_BADINPUT; /* Unused bits != 0 */
#endif
			else
				i = 2; /* Read output, please */
			break;
		case STATE_STOP:
			i = ctx->substate;
			break;
		default:
			pgpAssert(i=0); /* To shut up compiler warnings */
		}
	} while (i == 0);

	if (i < 0) {
		ctx->state = STATE_STOP;
		ctx->substate = i;
		*error = i;
	} else {
		*error = 0;
	}

	pgpAssert((size_t)(ctx->inptr - buf) == len - ctx->inlen);
	return (size_t)(ctx->inptr - buf); /* Bytes read */
}

/*
 * Signal EOF, detecting truncated messages.
 * If another error has been reported, this just repeats it.
 */
/* New version, hopefully useful. */
int
infEOF(struct InflateContext *ctx)
{
	/* If processing is halted, just return the last error (if any) */
	if (ctx->state == STATE_STOP)
		return ctx->substate;

	/* If expecting still more input, we're short */
	if (ctx->state != STATE_DONE)
		return INFERR_SHORT;

	/* Otherwise, all is well. */
	return 0;
}

struct InflateContext *
infAlloc(void)
{
	struct InflateContext *ctx;
	unsigned char *slide;

	slide = (unsigned char *)pgpMemAlloc(WSIZE);
	if (!slide)
		return 0;
	ctx = (struct InflateContext *)pgpMemAlloc(sizeof(*ctx));
	if (!ctx) {
		pgpMemFree(slide);
		return 0;
	}
	ctx->slide = slide;
	ctx->slideend = slide+WSIZE;
	ctx->slidelen = WSIZE;
	ctx->slidemask = WSIZE-1;

	ctx->outptr = slide;
	ctx->readptr = slide;

	ctx->state = STATE_START;
	ctx->substate = 0;
	ctx->inlen = 0;
	ctx->bitbuffer = 0;
	ctx->bufbits = 0;
	ctx->lastblock = 0;

	ctx->tree1 = 0;
	ctx->tree2 = 0;

	return ctx;
}

void
infFree(struct InflateContext *ctx)
{
	if (ctx->tree1 && ctx->tree1 != fixed_tl)
		huft_free(ctx->tree1);
	if (ctx->tree2 && ctx->tree2 != fixed_td)
		huft_free(ctx->tree2);

	if (ctx->slide) {
#if SECURE
		memset(ctx->slide, 0, ctx->slidelen);
#endif
		pgpMemFree(ctx->slide);
	}
#if SECURE
	memset(ctx, 0, sizeof(*ctx));
#endif
	pgpMemFree(ctx);
}
