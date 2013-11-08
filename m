From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] compat/bswap.h: Fix build on cygwin, MinGW and msvc
Date: Fri, 8 Nov 2013 14:27:49 -0800
Message-ID: <20131108222749.GA19912@sigill.intra.peff.net>
References: <527C0D4A.7070101@ramsay1.demon.co.uk>
 <20131108004550.GA16843@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 08 23:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeuWz-0000Lp-F5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 23:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065Ab3KHW1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Nov 2013 17:27:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:35765 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757473Ab3KHW1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 17:27:51 -0500
Received: (qmail 21765 invoked by uid 102); 8 Nov 2013 22:27:51 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Nov 2013 16:27:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Nov 2013 14:27:49 -0800
Content-Disposition: inline
In-Reply-To: <20131108004550.GA16843@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237468>

On Fri, Nov 08, 2013 at 01:45:50AM +0100, SZEDER G=C3=A1bor wrote:

> Hi,
>=20
> On Thu, Nov 07, 2013 at 09:59:38PM +0000, Ramsay Jones wrote:
> > +static inline uint64_t default_bswap64(uint64_t val)
> > +{
> > +	return (((val & (uint64_t)0x00000000000000ffULL) << 56) |
> > +		((val & (uint64_t)0x000000000000ff00ULL) << 40) |
> > +		((val & (uint64_t)0x0000000000ff0000ULL) << 24) |
> > +		((val & (uint64_t)0x00000000ff000000ULL) <<  8) |
> > +		((val & (uint64_t)0x000000ff00000000ULL) >>  8) |
> > +		((val & (uint64_t)0x0000ff0000000000ULL) >> 24) |
> > +		((val & (uint64_t)0x00ff000000000000ULL) >> 40) |
> > +		((val & (uint64_t)0xff00000000000000ULL) >> 56));
> > +}
>=20
> This got me thinking.
> To swap 8 bytes this function performs 8 bitwise shifts, 8 bitwise
> ANDs and 7 bitwise ORs plus uses 8 64bit constants.  We could do
> better than that:
>=20
> static inline uint64_t hacked_bswap64(uint64_t val)
> {
> 	uint64_t tmp =3D val << 32 | val >> 32;
> 	return (((tmp & (uint64_t)0xff000000ff000000ULL) >> 24) |
> 		((tmp & (uint64_t)0x00ff000000ff0000ULL) >>  8) |
> 		((tmp & (uint64_t)0x0000ff000000ff00ULL) <<  8) |
> 		((tmp & (uint64_t)0x000000ff000000ffULL) << 24));
> }
>=20
> This performs only 6 shifts, 4 ANDs, 4 ORs and uses 4 64bit constants=
=2E

You can do better still by using the bswap instruction. :)

I tried timing the program below.

With -O0, your version is actually _slower_ than the naive version (14s
versus 13s), and the bswap version is better than either (8s). Oddly, i=
n
an earlier iteration of my test, your version was faster than naive,
with bswap faster still (10s, 8s, 5s, respectively). In that version, I
was not assigning the result of the bswap anywhere.

So I think the timing is highly dependent on the code surrounding the
call, but of course the asm instruction seems to always perform better.

If I turn on -O2, all three take about 1.2s.  Inspecting the generated
assembly, it's because gcc converts the raw-code cases into a bswap
instruction.  We end up with something like:

  .L3:
          subq $1, %rdx
          bswap %rax
          jne .L3

And according to perf, we spend all of our time on the jump. The bswap
hardly registers.

> I doubt that in normal usage git would spend enough time bswap64ing t=
o
> make this noticeable, but it was a fun micro-optimization on a wet
> Thursday evening nevertheless :)

We do a fair number, but it's dwarfed by the real work. And from the
numbers above, I think our best bet is to use the system bswap if it's
there, and then not worry too hard about micro-optimizing the rest.

-Peff

-- >8 --
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef NAIVE
static inline uint64_t test(uint64_t val)
{
        return ((val & (uint64_t)0x00000000000000ffULL) << 56)
                | ((val & (uint64_t)0x000000000000ff00ULL) << 40)
                | ((val & (uint64_t)0x0000000000ff0000ULL) << 24)
                | ((val & (uint64_t)0x00000000ff000000ULL) <<  8)
                | ((val & (uint64_t)0x000000ff00000000ULL) >>  8)
                | ((val & (uint64_t)0x0000ff0000000000ULL) >> 24)
                | ((val & (uint64_t)0x00ff000000000000ULL) >> 40)
                | ((val & (uint64_t)0xff00000000000000ULL) >> 56);
}

#elif defined(OPTIM)
static inline uint64_t test(uint64_t val)
{
        uint64_t tmp =3D val << 32 | val >> 32;
	return (((tmp & (uint64_t)0xff000000ff000000ULL) >> 24) |
                ((tmp & (uint64_t)0x00ff000000ff0000ULL) >>  8) |
                ((tmp & (uint64_t)0x0000ff000000ff00ULL) <<  8) |
                ((tmp & (uint64_t)0x000000ff000000ffULL) << 24));
}

#elif defined(ASM)
static inline uint64_t test(uint64_t val)
{
	register uint64_t v, x =3D val;
	__asm__("bswap %q0" : "=3Dr" (v) : "0" (x));
	return v;
}
#endif

int main(int argc, char **argv)
{
	unsigned long i;
        uint64_t n =3D strtoull(argv[1], NULL, 10);

	for (i =3D 0; i < 1000000000; i++)
		n =3D test(n);
	/* convince gcc that we really want the output value, so
	 * it won't optimize out the whole program */
        printf("%d\n", (int)n);
	return 0;
}
