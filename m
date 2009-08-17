From: "George Spelvin" <linux@horizon.com>
Subject: Re: Linus' sha1 is much faster!
Date: 17 Aug 2009 14:54:48 -0400
Message-ID: <20090817185448.30254.qmail@science.horizon.com>
References: <alpine.LFD.2.00.0908171228570.6044@xanadu.home>
Cc: art.08.09@gmail.com, bdonlan@gmail.com, git@vger.kernel.org,
	johnflux@gmail.com, P@draigBrady.com, torvalds@linux-foundation.org
To: linux@horizon.com, nico@cam.org
X-From: git-owner@vger.kernel.org Mon Aug 17 20:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7MC-0007J0-N0
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 20:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbZHQSyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 14:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbZHQSyt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 14:54:49 -0400
Received: from science.horizon.com ([71.41.210.146]:47083 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750924AbZHQSys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 14:54:48 -0400
Received: (qmail 30255 invoked by uid 1000); 17 Aug 2009 14:54:48 -0400
In-Reply-To: <alpine.LFD.2.00.0908171228570.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126253>

> I don't think this trick of making source code textually different from 
> another work while still intimately mimicking the same structure entitles 
> you to any copyright (or non copyright) claims over that other work.  I 
> certainly wouldn't bet any dime for this standing up in court.  

<div type="legal digression">
Actually, I would.  I did a lot more than text search and replace;
I re-implemented it from FIPS 180-2 (work of U.S. government, no copyright)
and then merged in the *ideas* from the mailing list.  

(And from elsewhere; the idea of a five-round macro is from Brian Gladman.)

Remember, to the extent that something is *functional*, it is not
copyrightable; copyright only covers the non-functional expressive bits.
The vast majority of that code is simply required by the standard,
or the desired calling interface.

For a large portion of the rest, remember that standard programming
conventions (e.g.  brace style, macro names IN CAPS, etc.) that's also
non-copyrightable "scene a faire" material.

It's well established that paraphrasing a recipe avoids copyright;
the proportions and treatment of the ingredients is not copyrightable.

For more details, see the extensive coverage of the NEC v. Intel decision
(1989) regarding the firmware for NEC's 8086-clone V20 microprocessor.
It was found non-infringing despite non-clean-room implementation and
substantial similarities.
</div>

> It is probably much safer to simply ask the people involved to agree
> with your relicensing.  And so far I don't see anyone with a stake in
> this fiercely wanting to stick to a particular license.

As for politeness, that's exactly why I did post it and solicit
objections.  The purpose of the rewrite is to avoid having to make
pessimistic assumptions about people who don't respond.

I suppose I should have made that request clearer:
Is there anyone who claims copyright on anything here?
Or would just like credit?
If so, are you willing to donate it to the public domain?

I like the GPL, but some code is generally applicable enough, and unlikely
to be improved on by others enough, that I'd rather just let everyone
use the same version.

> It's not quite 100% finished, as I haven't benchmarked it against Linus's
> code yet, but it's functionally correct.
> 
> It's also clean with -W -Wall -Wextra.

> Not if you try with the unaligned put_be32() as the destination pointer 
> is marked const.

Oops.  And the "||" in get_be32() doesn't help either.
There was another major bug I found, too.

And I'm still trying to match "linusv" performance.

> As to the actual result on ARM... Well, the assembly _looks_ much worse 
> than Linus' version.  It uses a stack frame of 152 bytes instead of 64 
> bytes.  The resulting binary is also 6868 bytes large compared to 6180 
> bytes.  Surprisingly, the performance is not that bad (the reason for 
> the underlined "looks" above) albeit still a bit worse, like 5% slower.  
> I was expecting much worse than that.

Thanks, I'll work on it.

> Also, wrt skipping the last 3 write back to the 16 word array...  For 
> all the (limited) attempts I've made so far to do that, it always ended 
> up making things worse.  I've yet to investigate why though.

Thanks.  That's certainly surprising!


If anyone cares, my current code (adapted to fit sha1bench) is appended.

/*
 * Secure Hash Algorith SHA-1, as published in FIPS PUB 180-2.
 *
 * This implementation is in the public domain.  Copyright abandoned.
 * You may do anything you like with it, including evil things.
 *
 * This is a rewrite from scratch, based on Linus Torvalds' "block-sha1"
 * from the git mailing list (August, 2009).  Additional optimization
 * ideas cribbed from
 * - Artur Skawina (x86, particularly P4, and much benchmarking)
 * - Nicolas Pitre (ARM)
 *
 * Contributors to this code are requested to donate their changes to
 * the public domain to avoid version skew.  If you don't want to, be
 * sure to change the copyright waiver above.
 */

#include <string.h>	/* For memcpy() */
#include <arpa/inet.h>	/* For ntohl() */

#include "pdsha1.h"

#define SHA_CTX pd_SHA_CTX
#define SHA_context pd_SHA_context
#define SHA1_Init pd_SHA1_Init
#define SHA1_Update pd_SHA1_Update
#define SHA1_Final pd_SHA1_Final

static void sha1_core(uint32_t iv[5], unsigned char const *p);


void SHA1_Init(struct SHA_context *c)
{
	/* This is a prefix of the SHA_context structure */
	static struct {
		uint64_t len;
		uint32_t iv[5];
	} const iv = { 0,
		{ 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0 }
	};

	memcpy(c, &iv, sizeof iv);
}

void SHA1_Update(struct SHA_context *c, void const *p, size_t n)
{
	size_t pos = c->len & 63;	/* Offset into current input block */
	size_t nblocks;

	c->len += n;

	/* Initial partial block (if any) */
	if (pos) {
		size_t space = 63 - pos;
		if (n < space)
			goto end;
		memcpy(c->buf + pos, p, space);
		sha1_core(c->iv, c->buf);
		n -= space;
		p = (char const *)p + space;
	}

	/* The large middle piece */
	nblocks = n >> 6;
	while (nblocks--) {
		sha1_core(c->iv, p);
		p += 64;
	}
	n &= 63;
	pos = 0;
end:
	/* Final partial block (may be zero size) */
	memcpy(c->buf + pos, p, n);
}

/* Machine specific hacks */
#if defined(__i386__) || defined(__x86_64__) || defined (__ppc__) || \
    defined(__ppc64__) || defined(__powerpc__) || defined (__powerpc64__) || \
    defined(__s390__) || defined(__s390x__)
/* Unaligned access is okay */
#define GET_BE32(p) ntohl(*(uint32_t const *)(p))
#define PUT_BE32(p,v) (*(uint32_t *)(p) = htonl(v))

#else
/*
 * Unaligned access is not okay; do conversion as byte fetches
 * These macros are IN_CAPS, as they are not side-effect safe
 * The argument p must be an "unsigned char *" or "uint8_t *"
 */
#define GET_BE32(p) \
	((uint32_t)(p)[0]<<24 | (p)[1]<<16 | (p)[2]<<8 | (p)[3])
#define PUT_BE32(p,v) \
	( (p)[0] = (v)>>24, (p)[1] = (v)>>16, (p)[2] = (v)>>8, (p)[3] = (v) )
#endif

void SHA1_Final(unsigned char hash[20], struct SHA_context *c)
{
	size_t pos = c->len & 63;
	unsigned i;

	/* Append a single 1 bit */
	c->buf[pos++] = 0x80;

	/* Append 0 bits until 64 bits remain in a block */
	if (pos > 56) {
		memset(c->buf + pos, 0, 64 - pos);
		sha1_core(c->iv, c->buf);
		pos = 0;
	}
	memset(c->buf + pos, 0, 56 - pos);

	/* Append total input length in bits */
	((uint32_t *)c->buf)[14] = htonl((uint32_t)(c->len >> 29));
	((uint32_t *)c->buf)[15] = htonl((uint32_t)c->len << 3);

	/* Final hash round */
	sha1_core(c->iv, c->buf);

	/* Copy hash result out */
	for (i = 0; i < 5; i++)
		PUT_BE32(hash + 4*i, c->iv[i]);
}


/*
 * Helper macros for sha1_core function.  To avoid clutter, these macros
 * are NOT fully parenthesized if it doesn't matter to the actual use.
 */

#if __GNUC__ && (defined(__i386__) || defined(__x86_64__))
/*
 * GCC by itself only generates left rotates.  Use right rotates if
 * possible to be kinder to dinky implementations with iterative rotate
 * instructions.
 */
#define ROT(op, x, k) \
	({ uint32_t y; __asm__(op " %1,%0" : "=r" (y) : "I" (k), "0" (x)); y; })
#define ROL(x,k) ROT("roll", x, k)
#define ROR(x,k) ROT("rorl", x, k)

#else
/* Generic C equivalent */
#define ROT(x,l,r) ((x) << (l) | (x) >> (r))
#define ROL(x,k) ROT(x,k,32-(k))
#define ROR(x,k) ROT(x,32-(k),k)
#endif


/*
 * An important temporary array in SHA-1 is the working array W[],
 * which holds a scheduled key word per round.  Only the last 16 words
 * are relevant, so only use 16 words...
 */
#define W(i) w[(i) & 15]

/*
 * If you have a small register set, it helps GCC to force stores to
 * the w[] array to memory.  Given 22 or more registers (e.g. PowerPC),
 * GCC can map the entire w[] array to registers and this becomes
 * counterproductive.
 *
 * The optimal kludge seems to differ between x86 and ARM.  On the latter,
 * forcing a full memory barrier is required to stop GCC from splitting
 * live ranges for each round and generating a separate stack slot for
 * each.  (Which produces a huge stack frame and kills performance.)
 */
#if __GNUC__ && defined(__i386__) || defined(__x86_64__)
#define STORE(i, x) W(i) = x; __asm__ volatile("" : "+m" (W(x)))

#elif defined(__i386__) || defined(__x86_64__)
#define STORE(i, x) *(volatile uint32_t *)&W(i) = x

#elif __GNUC__ && defined(__arm__)
#define STORE(i, x) W(i) = x; __asm__("":::"memory")

#else
#define STORE(i, x) W(i) = x
#endif


/* The three round functions.  F2 is also used as F4 */
#define F1(b,c,d) (((d ^ c) & b) ^ d)		/* Bitwise b ? c : d */
#define F2(b,c,d) (d ^ c ^ b)			/* Even parity */
#define F3(b,c,d) (d & c) + ((d ^ c) & b)	/* Majority function */

/* The four round constants */
#define K1 0x5a827999	/* 2^30 * sqrt(2) */
#define K2 0x6ed9eba1	/* 2^30 * sqrt(3) */
#define K3 0x8f1bbcdc	/* 2^30 * sqrt(5) */
#define K4 0xca62c1d6	/* 2^30 * sqrt(10) */

/* Rounds 0..15 fetch a word from the input */
#define FETCH(t,i)	t = GET_BE32(p + 4*(i)); STORE(i,t)
//#define FETCH(t,i)	t = W(i)
/* Rounds 16..79 mix previous words to get a new one */
#define MIX(t,i)	t = W(i) ^ W(i+2) ^ W(i+8) ^ W(i+13); t = ROL(t, 1)
/* Rounds 16..76 have to store back the result */
#define CALC(t,i)	MIX(t,i); STORE(i,t)

/* The basic SHA-1 round */
#if 0
#define SHA_ROUND(a,b,c,d,e,f,k,src,t,i)	\
	src(t,i);				\
	e += t + f(b,c,d) + k + ROL(a,5);	\
	b = ROR(b,2)
#elif 0
#define SHA_ROUND(a,b,c,d,e,f,k,src,t,i) do {	\
	uint32_t t;				\
	src(t,i);				\
	e += f(b,c,d);				\
	e += t + k;				\
	b = ROR(b,2);				\
	e += ROL(a,5); } while (0)
#else
#define SHA_ROUND(a,b,c,d,e,f,k,src,t,i) do {	\
	uint32_t t = ROL(a,5);			\
	e += f(b,c,d);				\
	e += k + t;				\
	src(t,i);				\
	b = ROR(b,2);				\
	e += t;	} while(0)			
#endif

/* An aligned group of 5 rounds */
#define SHA_ROUND5(f,k,src,t,i) \
	SHA_ROUND(a,b,c,d,e, f,k,src,t,i);	\
	SHA_ROUND(e,a,b,c,d, f,k,src,t,i+1);	\
	SHA_ROUND(d,e,a,b,c, f,k,src,t,i+2);	\
	SHA_ROUND(c,d,e,a,b, f,k,src,t,i+3);	\
	SHA_ROUND(b,c,d,e,a, f,k,src,t,i+4)

/*
 * The core SHA-1 transform.
 *
 * iv[5] = Current SHA-1 hash state.
 * p = Pointer to 64 bytes of source data.  Not necessarily aligned.
 */
static void
sha1_core(uint32_t iv[5], unsigned char const *p)
{
	//uint32_t e = iv[4], d = iv[3], c = iv[2], b = iv[1], a = iv[0];
	uint32_t a = iv[0], b = iv[1], c = iv[2], d = iv[3], e = iv[4];
	uint32_t w[16];

#if 0
	{
		int i;
		for (i = 0; i < 16; i++) {
			STORE(i, get_be32(p + 4*i));
		}
	}
#endif
	SHA_ROUND5(F1, K1, FETCH, t,  0);
	SHA_ROUND5(F1, K1, FETCH, t,  5);
	SHA_ROUND5(F1, K1, FETCH, t, 10);
	SHA_ROUND(a,b,c,d,e, F1, K1, FETCH, t, 15);
	SHA_ROUND(e,a,b,c,d, F1, K1, CALC, t, 16);
	SHA_ROUND(d,e,a,b,c, F1, K1, CALC, t, 17);
	SHA_ROUND(c,d,e,a,b, F1, K1, CALC, t, 18);
	SHA_ROUND(b,c,d,e,a, F1, K1, CALC, t, 19);

	SHA_ROUND5(F2, K2, CALC, t, 20);
	SHA_ROUND5(F2, K2, CALC, t, 25);
	SHA_ROUND5(F2, K2, CALC, t, 30);
	SHA_ROUND5(F2, K2, CALC, t, 35);

	SHA_ROUND5(F3, K3, CALC, t, 40);
	SHA_ROUND5(F3, K3, CALC, t, 45);
	SHA_ROUND5(F3, K3, CALC, t, 50);
	SHA_ROUND5(F3, K3, CALC, t, 55);

	SHA_ROUND5(F2, K4, CALC, t, 60);
	SHA_ROUND5(F2, K4, CALC, t, 65);
	SHA_ROUND5(F2, K4, CALC, t, 70);

	SHA_ROUND(a,b,c,d,e, F2, K4, CALC, t, 75);
	SHA_ROUND(e,a,b,c,d, F2, K4, CALC, t, 76);
	/* Last 3 rounds don't need to store mixed value */
	SHA_ROUND(d,e,a,b,c, F2, K4, MIX, t, 77);
	SHA_ROUND(c,d,e,a,b, F2, K4, MIX, t, 78);
	SHA_ROUND(b,c,d,e,a, F2, K4, MIX, t, 79);

	iv[0] += a;
	iv[1] += b;
	iv[2] += c;
	iv[3] += d;
	iv[4] += e;
}


/* Compile with -DUNITTEST for self-tests */
#if UNITTEST

#include <stdio.h>
#include <stdlib.h>

/* Known answer test */
static void katest(char const *text, size_t len, unsigned char const hash[20])
{
	SHA_CTX c;
	unsigned char hash2[20];
	int i;

	SHA1_Init(&c);
	SHA1_Update(&c, text, len);
	SHA1_Final(hash2, &c);

	for (i = 0; i < 20; i++)
		if (hash[i] != hash2[i])
			goto mismatch;
	printf("%u-byte known answer test PASSED\n", len);
	return;

mismatch:
	printf("%u-byte known answer test FAILED:\n", len);
	if (len < 64)
		printf("Input: \"%.*s\"\n", len, text);
	else
		printf("Input: \"%.64s\"...\n", text);
	printf("Computed:");
	for (i = 0; i < 20; i++)
		printf(" %02x", hash2[i]);
	printf("\nExpected:");
	for (i = 0; i < 20; i++)
		printf(" %02x", hash[i]);
	putchar('\n');
}

int
main(void)
{
	/* FIPS PUB 180.1 example A.1 */
	static char const text1[3] = "abc";
	static unsigned char const hash1[20] = {
		0xa9, 0x99, 0x3e, 0x36, 0x47, 0x06, 0x81, 0x6a, 0xba, 0x3e,
		0x25, 0x71, 0x78, 0x50, 0xc2, 0x6c, 0x9c, 0xd0, 0xd8, 0x9d };

	/* FIPS PUB 180.1 example A.2 */
	static char const text2[56] =
		"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq";
	static unsigned char const hash2[20] = {
		0x84, 0x98, 0x3e, 0x44, 0x1c, 0x3b, 0xd2, 0x6e, 0xba, 0xae,
		0x4a, 0xa1, 0xf9, 0x51, 0x29, 0xe5, 0xe5, 0x46, 0x70, 0xf1 };

	/* FIPS PUB 180.1 example A.3 */
	char *text3;
	static unsigned char const hash3[20] = {
		0x34, 0xaa, 0x97, 0x3c, 0xd4, 0xc4, 0xda, 0xa4, 0xf6, 0x1e,
		0xeb, 0x2b, 0xdb, 0xad, 0x27, 0x31, 0x65, 0x34, 0x01, 0x6f };

	katest(text1, sizeof text1, hash1);
	katest(text2, sizeof text2, hash2);
	text3 = malloc(1000000);
	memset(text3, 'a', 1000000);
	katest(text3, 1000000, hash3);
	
	return 0;
}
#endif
