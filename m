From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/5] compat/bswap.h: Fix build on cygwin, MinGW and msvc
Date: Fri, 8 Nov 2013 01:45:50 +0100
Message-ID: <20131108004550.GA16843@goldbirke>
References: <527C0D4A.7070101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 08 01:46:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeaD7-0004WC-3P
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 01:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab3KHAqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Nov 2013 19:46:00 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:50734 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab3KHAp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 19:45:59 -0500
Received: from localhost6.localdomain6 (f050238080.adsl.alicedsl.de [78.50.238.80])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LgBIO-1VzZ0M3Jtk-00ngTw; Fri, 08 Nov 2013 01:45:51 +0100
Content-Disposition: inline
In-Reply-To: <527C0D4A.7070101@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:C9m+y8QBe1Lc1uPQwytEfCnJcn63DhAEIeYTJn5f+Si
 9OAAPACNmxhZYH6k6SU1ojx1VwDLXbDRkkFOyLuqeRZV5tIbtt
 BIf7/UeNEU2mjO+aE3LdKJnEslaeFFL/c+F/3jh12r0IbYB4+I
 u8/hX3p3SLxTTtXYgGn2kCkNOp0Xc2d0zHUty9acRQiFNJnP70
 zU87K2txL0Wmll0gydTJ7HMJIEMM6JVeTKYSAHnGhrApAE+fH5
 01odgIfvCEyGz0t63ajFvSGXEjS6ETDwXyRGE0cAMGNT+DWS+x
 ubMt8rAlvmzovqVGuKyzlTzo8WZnMjwHqRfeQ5LPLoziuH1D58
 NrvsTcJJn2JBAA7+84ao=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237446>

Hi,

On Thu, Nov 07, 2013 at 09:59:38PM +0000, Ramsay Jones wrote:
> +static inline uint64_t default_bswap64(uint64_t val)
> +{
> +	return (((val & (uint64_t)0x00000000000000ffULL) << 56) |
> +		((val & (uint64_t)0x000000000000ff00ULL) << 40) |
> +		((val & (uint64_t)0x0000000000ff0000ULL) << 24) |
> +		((val & (uint64_t)0x00000000ff000000ULL) <<  8) |
> +		((val & (uint64_t)0x000000ff00000000ULL) >>  8) |
> +		((val & (uint64_t)0x0000ff0000000000ULL) >> 24) |
> +		((val & (uint64_t)0x00ff000000000000ULL) >> 40) |
> +		((val & (uint64_t)0xff00000000000000ULL) >> 56));
> +}

This got me thinking.
To swap 8 bytes this function performs 8 bitwise shifts, 8 bitwise
ANDs and 7 bitwise ORs plus uses 8 64bit constants.  We could do
better than that:

static inline uint64_t hacked_bswap64(uint64_t val)
{
	uint64_t tmp =3D val << 32 | val >> 32;
	return (((tmp & (uint64_t)0xff000000ff000000ULL) >> 24) |
		((tmp & (uint64_t)0x00ff000000ff0000ULL) >>  8) |
		((tmp & (uint64_t)0x0000ff000000ff00ULL) <<  8) |
		((tmp & (uint64_t)0x000000ff000000ffULL) << 24));
}

This performs only 6 shifts, 4 ANDs, 4 ORs and uses 4 64bit constants.

bswap64ing 1000000000 64bit ints with default_bswap64() compiled
with -O2 takes:

  real    0m1.808s
  user    0m1.796s
  sys     0m0.000s

The same with hacked_bswap64():

  real    0m0.823s
  user    0m0.816s
  sys     0m0.000s

I doubt that in normal usage git would spend enough time bswap64ing to
make this noticeable, but it was a fun micro-optimization on a wet
Thursday evening nevertheless :)

Best,
G=E1bor
