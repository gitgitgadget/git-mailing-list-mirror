From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Wed, 04 Jun 2014 10:04:01 +0200
Message-ID: <538ED2F1.9030003@web.de>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com> <1401853091-15535-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 04 10:04:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws6BO-0006vh-HK
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 10:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbaFDIEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 04:04:20 -0400
Received: from mout.web.de ([212.227.15.4]:61099 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205AbaFDIES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 04:04:18 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M3jof-1WaZKJ2lnt-00rGo8; Wed, 04 Jun 2014 10:04:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401853091-15535-2-git-send-email-dturner@twitter.com>
X-Provags-ID: V03:K0:Lg2eqQcnkmKjHYAzG6r3p55tphhQkzNGbi9HsP6MFIplvwy3cs9
 0LsYR2/UROeZmCL1YuA7Ptx2haNYRfpUh/I4C4Ltj+4ypXyYGUPvSzih0NtLWst7pcnYK9H
 hbkaxwUJxLiNE/b749OsLii7sifPZunsFXo47WGavH+70uCTEqLDvQBdURdRtiPNkTFg1fZ
 mOUq/07ckyArm3KqyNF+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250718>


On 2014-06-04 05.38, David Turner wrote:
[]
> []
> diff --git a/Makefile b/Makefile
> index a53f3a8..dd2127a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1326,6 +1326,11 @@ else
>  		COMPAT_OBJS += compat/win32mmap.o
>  	endif
>  endif
> +ifdef NO_SSE42
> +	BASIC_CFLAGS += -DNO_SSE42
> +else
> +	BASIC_CFLAGS += -msse4.2
> +endif
This does work for some people, but break for others, like the systems in my test-lab.
On 2 different systems the gcc has support for -msse4.2, but the processor has not,
and t5511 fails with "Illegal instruction".
How can that be?
The maintainer of a Linux distro wants to ship gcc with all possible features,
an the end-user can compile the code with all the features his very processor has.

On the other hand, a pre-compiled package like e.g. Git is compiled into a binary package
with all the latest features switched of, to be able to run the binary on as many different
processor variants as possible.

He already needs to make 3 binaries only for x86:

- the minimum version is a 32 bit processor like 486/586/686.
- a "medium" version for systems with 4GB RAM (or more) which have 32 bit processors with PAE (686-pae)
- a version for x86_64

E.g. a maintainer wants to have SSE42 enabled, when he builds Git for his system,
but disabled when he builds an RPM.
The people compiling Git need to know what the binary is used for, how about
using something like this in Makefile:

ifdef HAVE_SSE42
	BASIC_CFLAGS += -msse4.2 -DHAS_SSE42

+endif

>  ifdef OBJECT_CREATION_USES_RENAMES
>  	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
>  endif
> @@ -2199,6 +2204,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
>  	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
> +	@echo NO_SSE42=\''$(subst ','\'',$(subst ','\'',$(NO_SSE42)))'\' >>$@
Same here: Use HAVE_SSE42 rather than NO_SSE42

> diff --git a/aclocal.m4 b/aclocal.m4
> index f11bc7e..d9f3f19 100644
> --- a/aclocal.m4
> +++ b/aclocal.m4
> @@ -38,3 +38,9 @@ AC_DEFUN([TYPE_SOCKLEN_T],
>        [#include <sys/types.h>
>  #include <sys/socket.h>])
>  ])
As the whole detection logic does not work as expected (we need to compile and test-run the code,
not only compile),
can we drop this part completely ? (at least for the first round)

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -668,6 +668,28 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>  #endif
>  #endif
>  
> +#ifndef NO_SSE42
> +#include <nmmintrin.h>
> +/*
> + * Clang ships with a version of nmmintrin.h that's incomplete; if
> + * necessary, we define the constants that we're going to use.
> + */
> +#ifndef _SIDD_UBYTE_OPS
> +#define _SIDD_UBYTE_OPS                 0x00
> +#define _SIDD_CMP_EQUAL_ANY             0x00
> +#define _SIDD_CMP_RANGES                0x04
> +#define _SIDD_CMP_EQUAL_ORDERED         0x0c
> +#define _SIDD_NEGATIVE_POLARITY         0x10
> +#endif
Why do this defines end up in git-compat-util.h when they are needed by one file?
(see even below)

> --- a/refs.c
> +++ b/refs.c
> @@ -24,6 +24,25 @@ static unsigned char refname_disposition[256] = {
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
>  };
>  
> +static int check_refname_component_trailer(const char *cp, const char *refname, int flags)
> +{
> +	if (cp == refname)
> +		return 0; /* Component has zero length. */
> +	if (refname[0] == '.') {
> +		if (!(flags & REFNAME_DOT_COMPONENT))
> +			return -1; /* Component starts with '.'. */
> +		/*
> +		 * Even if leading dots are allowed, don't allow "."
> +		 * as a component (".." is prevented by a rule above).
> +		 */
> +		if (refname[1] == '\0')
> +			return -1; /* Component equals ".". */
> +	}
> +	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
> +		return -1; /* Refname ends with ".lock". */
> +	return cp - refname;
> +}
> +
>  /*
>   * Try to read one refname component from the front of refname.
>   * Return the length of the component found, or -1 if the component is
> @@ -37,7 +56,7 @@ static unsigned char refname_disposition[256] = {
>   * - it ends with ".lock"
>   * - it contains a "\" (backslash)
>   */
> -static int check_refname_component(const char *refname, int flags)
> +static int check_refname_component_1(const char *refname, int flags)
The name check_refname_component_1() doesn't tell too much,
(check_refname_component_sse42()  or check_refname_component_nonsse42() say more)

can I suggest to move all SSE code out to a file under compat/,
like compat/refs_sse42.c, or something similar ?
(And here we need the missing sse4 defines from git-compat-util.h)
>  {
>  	const char *cp;
>  	char last = '\0';
> @@ -47,7 +66,7 @@ static int check_refname_component(const char *refname, int flags)
>  		unsigned char disp = refname_disposition[ch];
>  		switch(disp) {
>  		case 1:
> -			goto out;
> +			return check_refname_component_trailer(cp, refname, flags);
>  		case 2:
>  			if (last == '.')
>  				return -1; /* Refname contains "..". */
> @@ -61,23 +80,91 @@ static int check_refname_component(const char *refname, int flags)
>  		}
>  		last = ch;
>  	}
> -out:
> -	if (cp == refname)
> -		return 0; /* Component has zero length. */
> -	if (refname[0] == '.') {
> -		if (!(flags & REFNAME_DOT_COMPONENT))
> -			return -1; /* Component starts with '.'. */
> +}
> +
> +#ifdef NO_SSE42
> +#define check_refname_component check_refname_component_1
> +#else
> +#define SSE_VECTOR_BYTES 16
See above, all sse42 related stuff, should it be isolated in a seperate file?
> +
> +/* Vectorized version of check_refname_component */
> +static int check_refname_component(const char *refname, int flags)
> +{
[]
