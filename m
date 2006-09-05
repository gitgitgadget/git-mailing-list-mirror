From: linux@horizon.com
Subject: Re: Starting to think about sha-256?
Date: 5 Sep 2006 05:05:21 -0400
Message-ID: <20060905090521.24944.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Sep 05 11:05:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKWsF-0006X3-73
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 11:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWIEJFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 05:05:32 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWIEJFc
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 05:05:32 -0400
Received: from science.horizon.com ([192.35.100.1]:53068 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965070AbWIEJFb
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 05:05:31 -0400
Received: (qmail 24946 invoked by uid 1000); 5 Sep 2006 05:05:22 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26470>

=46or those worrying, note that even a "complete" break of SHA-1 doesn'=
t
imply the ability to sneak a trojan into a git repository via a patch
or something.

What cryptographers consider a break is finding a collision, two messag=
es
x and y such that hash(x) =3D=3D hash(y).  But note that the attacker g=
ets
to pick both x and y!

A so-called second pre-image attack, where x is fixed beforehand is far
harder, even if you get to choose from the 320K or so objects in the
linux kernel repository.

Merely inducing you to somehow import the trojan object y into your
object database doesn't help unless you trust and are willing to build
and run source including the object x that it is a doppelg=E4nger for.
So, armed with only a collision-finding attack, the attacker has to
create a collision pair including an innocent source file that can get
included (without any bizarre contents getting "fixed" by a maintainer)
before anyone can attempt to substitute the trojan y.

That requirement eliminates most collision attacks, which generate
good-sized binary blobs.  There's a demo where someone did it with a
postscript file, but that was basically

	if (parity("line noise"))
		print innocent message
	else
		print trojan message

Now, admittedly, this sort of fine reasoning does reduce the possible
application domain of git to human-readable source.  If I'm using git
as a back-end for (say) an archive of statically verified but opaque
java byte-code files, then there's potential for trouble.

But I just want to remind people that even if a "complete" break of SHA=
-1
were announced tomorrow, it wouldn't imply that using git is dangerous.
=46rankly, it would *still* probably be less work to hide a trojan in t=
he
source code well enough that it sneaks under the maintainer's radar.


> Why? Because a git SHA1 is actually _not_ the SHA1 of the file itself=
,=20
> it's the SHA1 of the file _with_the_git_header_added_.
>=20
> So if you find two files that have the same SHA1, they would also hav=
e to=20
> have the same length in order to actually generate the same object na=
me.=20
> If they have different lenths, you can just check them into git, and=20
> they'll get two different git SHA1 names and you'll have a cool git=20
> archive that when you check the files out, they checked-out files wil=
l=20
> share the same SHA1 ;)

This has always seemed silly to me.  Every cryptographic hash
algorithm since the (catastrophically broken) MD4 has used the standard
Merkle-Damg=E5rd strengthening construction to include the length.
There's no point in doing it a second time.

It's done as a suffix, not a prefix, but it's there.  And an odd-sized
prefix makes it hard to have a fast-path aligned hash for the bulk of
the data on machines with alignment restrictions.

Now, the case can be made that a prefix is slightly stronger=20
(http://cs.nyu.edu/~puniya/papers/merkle.pdf), but I don't think
that's why it was done.

Note that since the length is included, you can avoid the odd-sized pre=
fix
problem by putting any extra data you like on the hash as a trailer.
As long as it's suffix-free, (e.g. leading null byte), you haven't
hurt anything.



Anyway, SHA-256 is tricky on x86, because it has 8 words of state and
x86 has only 7 registers.

But here's some (public domain) code which works well on x86, and doesn=
't
suck too badly on other processors.  It's designed to be benchmarked
against Brian Gladman's implementation; if you have that, change the
obvious #define and link against sha2.o.

The other interesting benchmark is "nm -n *.o"; on x86, it's 290 bytes
of core transform vs. 4773 bytes for sha256_compile.


#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define DEBUG 0
#define HAVE_GLADMAN_CODE 0

struct sha256_state {
	uint32_t iv[8];	/* h, g, f, e, d, c, b, a */
	uint32_t w[64];	/* Fill in first 16 with ntohl(input) */
	uint32_t d2, c2, b2, a2;
	uint32_t bytes_hi, bytes_lo;
};

/* Rotate right macro.  GCC can usually get this right. */
#define ROTR(x,s) ((x)>>(s) | (x)<<(32-(s)))

/*
 * An implementation of SHA-256 for register-starved architectures like
 * x86 or perhaps the MSP430.  (Although the latter's lack of a multi-b=
it
 * shifter will doom its performance no matter what.)
 * This code is also quite small.
 *
 * If you have 12 32-bit registers to work with, loading the 8 state
 * variables into registers is probably faster.  If you have 28 registe=
rs
 * or so, you can put the input block into registers as well.
 *
 * The key idea is to notice that each round consumes one word from the
 * key schedule w[i], computes a new a, and shifts all the other state
 * variables down one position, discarding the old h.
 *
 * So if we store the state vector in reverse order h..a, immediately
 * before w[i], then a single base pointer can be incremented to advanc=
e
 * to the next round.
 */
void
sha256_transform(uint32_t p[76])
{
	static uint32_t const k[64] =3D {
		0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b,
		0x59f111f1, 0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01,
		0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7,
		0xc19bf174, 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
		0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da, 0x983e5152,
		0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
		0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc,
		0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
		0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819,
		0xd6990624, 0xf40e3585, 0x106aa070, 0x19a4c116, 0x1e376c08,
		0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f,
		0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
		0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
	};
	/*
	 * Look, ma, only 6 local variables including p!
	 * Too bad they're so overloaded it's impossible to give them
	 * meaningful names.
	 */
	register uint32_t const *kp;
	register uint32_t a, s, t, u;

	/* Step 1: Expand the 16 words of w[], at p[8..23] into 64 words */
	for (u =3D 8; u < 8+64-16; u++) {
		/* w[i] =3D s1(w[i-2]) + w[i-7] + s0(w[i-15]) + w[i-16] */
		/* Form s0(x) =3D (x >>> 7) ^ (x >>> 18) ^ (x >> 3) */
		s =3D t =3D p[u+1];
		s =3D ROTR(s, 18-7);
		s ^=3D t;
		s =3D ROTR(s, 7);
		s ^=3D t >> 3;
		/* Form s1(x) =3D (x >>> 17) ^ (x >>> 19) ^ (x >> 10) */
		a =3D t =3D p[u+14];
		a =3D ROTR(a, 19-17);
		a ^=3D t;
		a =3D ROTR(a, 17);
		a ^=3D t >> 10;

		p[u+16] =3D s + a + p[u] + p[u+9];
	}

	/* Step 2: Copy the initial values of d, c, b, a out of the way */
	p[72] =3D p[4];
	p[73] =3D p[5];
	p[74] =3D p[6];
	p[75] =3D a =3D p[7];

	/*
	 * Step 3: The big loop.
	 * We maintain p[0..7] =3D h..a, and p[8] is w[i]
	 * Only the variable a is actually kept in a local register.
	 */
	kp =3D k;

	do {
		/* T1 =3D h + S1(e) + Ch(e,f,g) + k[i] + w[i] */
		/* Form Ch(e,f,g) =3D g ^ (e & (f ^ g)) */
		s =3D t =3D p[1];	/* g */
		s ^=3D p[2];	/* f ^ g */
		s &=3D u =3D p[3];	/* e & (f ^ g), copy of e left in u */
		s ^=3D t;
		/* Form S1(e) =3D (e >>> 6) ^ (e >>> 11) ^ (e >>> 25) */
		t =3D u;
		u =3D ROTR(u, 25-11);
		u ^=3D t;
		u =3D ROTR(u, 11-6);
		u ^=3D t;
		u =3D ROTR(u, 6);
		s +=3D u;
		/* Now add other things to t1 */
		s +=3D p[0] + p[8] + *kp;	/* h + w[i] + kp[i] */
		/* Round function: e =3D d + T1 */
		p[4] +=3D s;
		/* a =3D t1 + (t2 =3D S0(a) + Maj(a,b,c) */
		/* Form S0(a) =3D (a >>> 2) ^ (a >>> 13) ^ (a >>> 22) */
		t =3D a;
		t =3D ROTR(t, 22-13);
		t ^=3D a;
		t =3D ROTR(t, 13-2);
		t ^=3D a;
		t =3D ROTR(t, 2);
		s +=3D t;
		/* Form Maj(a,b,c) =3D (a & b) + (c & (a ^ b)) */
		u =3D p[6];	/* b */
		t =3D a;
		a ^=3D u;		/* a ^ b */
		u &=3D t;		/* a & b */
		a &=3D p[5];	/* c & (a + b) */
		s +=3D u;
		a +=3D s;	/* Sum final result into a */

		/* Now store new a on top of w[i] and shift... */
		p[8] =3D a;
		p++;
#if DEBUG=20
		/* If debugging, print out the state variables each round */
		printf("%2u:", kp-k);
		for (t =3D 8; t--; )
			printf(" %08x", p[t]);
		putchar('\n');
#endif
	} while (++kp !=3D k+64);

	/* Now, do the final summation. */
	kp =3D p;
	p -=3D 64;
	/*
	 * Now, the final h..a are in p[64..71], and the initial values
	 * are in p[0..7].  Except that p[4..7] got trashed in the loop
	 * above, so use the copies we made.
	 */
	p[0] +=3D kp[0];
	p[1] +=3D kp[1];
	p[2] +=3D kp[2];
	p[3] +=3D kp[3];
	p[4] =3D kp[4] + kp[8];
	p[5] =3D kp[5] + kp[9];
	p[6] =3D kp[6] + kp[10];
	p[7] =3D a     + kp[11];
}

/* Initial values H7..H0 for SHA-256, and SHA-224. Note reverse order! =
*/
static uint32_t const _sha256_iv[8] =3D {
	0x5be0cd19, 0x1f83d9ab, 0x9b05688c, 0x510e527f,
	0xa54ff53a, 0x3c6ef372, 0xbb67ae85, 0x6a09e667
};
static uint32_t const _sha224_iv[8] =3D {
	0xbefa4fa4, 0x64f98fa7, 0x68581511, 0xffc00b31,
	0xf70e5939, 0x3070dd17, 0x367cd507, 0xc1059ed8
};

#if HAVE_GLADMAN_CODE

#include "sha2.h"

#else

/* Compatibility wrappers */

typedef struct sha256_state sha256_ctx;

void
sha256_begin(struct sha256_state *s)
{
	memcpy(s->iv, _sha256_iv, sizeof _sha256_iv);
	s->bytes_lo =3D s->bytes_hi =3D 0;
}

#include <netinet/in.h>	/* For ntohl, htohl */

void
sha256_hash(unsigned char const *data, size_t len, struct sha256_state =
*s)
{
	unsigned space =3D 64 - (unsigned)s->bytes_lo % 64;
	unsigned i;

	s->bytes_lo +=3D (uint32_t)len;
	s->bytes_hi +=3D s->bytes_lo < (uint32_t)len;
	if ((size_t)-1 > (uint32_t)-1)
		s->bytes_hi +=3D (uint32_t)(len >> 16 >> 16);

	while (len >=3D space) {
		memcpy((unsigned char *)s->w + 64 - space, data, space);
		len -=3D space;
		space =3D 64;
		for (i =3D 0; i < 16; i++)
			s->w[i] =3D ntohl(s->w[i]);
		sha256_transform(s->iv);
	}
	memcpy((unsigned char *)s->w + 64 - space, data, len);
}

void
sha256_end(unsigned char hash[32], struct sha256_state *s)
{
	unsigned i, pos =3D (unsigned)s->bytes_lo % 64;
	uint32_t *out;

	((unsigned char *)s->w)[pos++] =3D 0x80;
	if (pos > 56) {
		memset((unsigned char *)s->w + pos, 0, 64-pos);
		for (i =3D 0; i < 16; i++)
			s->w[i] =3D ntohl(s->w[i]);
		sha256_transform(s->iv);
		pos =3D 0;
	}
	memset((unsigned char *)s->w + pos, 0, 56-pos);
	for (i =3D 0; i < 14; i++)
		s->w[i] =3D ntohl(s->w[i]);
	s->w[15] =3D s->bytes_lo << 3;
	s->w[14] =3D s->bytes_hi << 3 | s->bytes_lo >> 29;
	sha256_transform(s->iv);

	out =3D (unsigned)hash % sizeof s->iv[0] ? s->w : (uint32_t *)hash;
	for (i =3D 0; i < 8; i++)
		out[i] =3D htonl(s->iv[7-i]);
	if (out =3D=3D s->w)
		memcpy(hash, out, sizeof s->iv);
	memset(s, 0, sizeof s);	/* Good cryptographic hygiene */
}

void
sha256(unsigned char hash[32], const unsigned char *data, size_t len)
{
	struct sha256_state s;
	sha256_begin(&s);
	sha256_hash(data, len, &s);
	sha256_end(hash, &s);
}

#endif /* !HAVE_GLADMAN_CODE */

#include <string.h>
#include <sys/time.h>

#define TESTSIZE 100000000
#if TESTSIZE & 64 !=3D 0
#error For now, TESTSIZE must be a multiple of 64.
#endif

int
main(void)
{
	uint32_t array1[76] =3D {
		/* Initial values, h..a */
		0x5be0cd19, 0x1f83d9ab, 0x9b05688c, 0x510e527f,
		0xa54ff53a, 0x3c6ef372, 0xbb67ae85, 0x6a09e667,
		/* First 16 w[i] values */
		0x61626380, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0x00000018
	};
	uint32_t array2[76] =3D {
		/* Initial values, h..a */
		0x5be0cd19, 0x1f83d9ab, 0x9b05688c, 0x510e527f,
		0xa54ff53a, 0x3c6ef372, 0xbb67ae85, 0x6a09e667,
		/* First 16 w[i] values */
		0x61626364, 0x62636465, 0x63646566, 0x64656667,
		0x65666768, 0x66676869, 0x6768696a, 0x68696a6b,
		0x696a6b6c, 0x6a6b6c6d, 0x6b6c6d6e, 0x6c6d6e6f,
		0x6d6e6f70, 0x6e6f7071, 0x80000000, 0x00000000
	};
	uint32_t array3[76] =3D {
		/* Initial values, h..a */
		0x5be0cd19, 0x1f83d9ab, 0x9b05688c, 0x510e527f,
		0xa54ff53a, 0x3c6ef372, 0xbb67ae85, 0x6a09e667
	};
	unsigned i;
	struct timeval start, stop;
	sha256_ctx s256;
	unsigned char buf[64];

	/* The FIPS180-2 appendix B.1 example */
	printf("Appendix B.1 example:\n");
	sha256_transform(array1);
	printf("=3D=3D>");
	for (i =3D 8; i--; )
		printf(" %08x", array1[i]);
	putchar('\n');

	printf("\nAppendix B.2 example:\n");
	sha256_transform(array2);
	printf("=3D=3D>");
	for (i =3D 8; i--; )
		printf(" %08x", array2[i]);
	putchar('\n');
	putchar('\n');

	for(i =3D 8; i < 23; i++)
		array2[i] =3D 0;
	array2[23] =3D 0x000001c0;
	sha256_transform(array2);
	printf("=3D=3D>");
	for (i =3D 8; i--; )
		printf(" %08x", array2[i]);
	putchar('\n');

	/* Now to hash 1,000,000 letters 'a' */
	printf("\nAppendix B.3 example:\n");

	gettimeofday(&start, 0);
	for (i =3D 0; i < TESTSIZE/64; i++) {
		memset((char *)(array3+8), 'a', 64);
		sha256_transform(array3);
	}
	array3[8] =3D 0x80000000;
	array3[23] =3D i*64*8;	/* Length in bits */
	for (i =3D 9; i < 23; i++)
		array3[i] =3D 0;
	sha256_transform(array3);
	gettimeofday(&stop, 0);
	stop.tv_sec -=3D start.tv_sec;
	stop.tv_usec -=3D start.tv_usec;
	if (stop.tv_usec < 0) {
		stop.tv_usec +=3D 1000000;
		stop.tv_sec--;
	}
	printf("New code: %u.%06ld\n", (unsigned)stop.tv_sec, stop.tv_usec);
	printf("=3D=3D>");
	for (i =3D 8; i--; )
		printf(" %08x", array3[i]);
	putchar('\n');


	sha256_begin(&s256);
	gettimeofday(&start, 0);
	for (i =3D 0; i < TESTSIZE/64; i++) {
		memset(buf, 'a', 64);
		sha256_hash(buf, 64, &s256);
	}
	sha256_end(buf, &s256);
	gettimeofday(&stop, 0);
	stop.tv_sec -=3D start.tv_sec;
	stop.tv_usec -=3D start.tv_usec;
	if (stop.tv_usec < 0) {
		stop.tv_usec +=3D 1000000;
		stop.tv_sec--;
	}
	printf(
#if HAVE_GLADMAN_CODE
		"Gladman code: %u.%06ld\n",
#else
		"Wrapper code: %u.%06ld\n",
#endif
		(unsigned)stop.tv_sec, stop.tv_usec);

	printf("=3D=3D>");
	for (i =3D 0; i < 32; i++) {
		if (i % 4 =3D=3D 0)
			putchar(' ');
		printf("%02x", buf[i]);
	}
	putchar('\n');

	return 0;
}
