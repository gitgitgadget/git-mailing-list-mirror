From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Guard memory overwriting in resolve_ref's static
 buffer
Date: Sat, 10 Dec 2011 15:10:40 -0600
Message-ID: <20111210211040.GB24817@elie.hsd1.il.comcast.net>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
 <1323521631-24320-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tony Wang <wwwjfy@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 22:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZUC5-0006KS-NU
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 22:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab1LJVKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 16:10:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60459 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1LJVKq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 16:10:46 -0500
Received: by iaeh11 with SMTP id h11so708839iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 13:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aRx4PvIAuTKNjckG9sOGOrTLx/Eqz6g+8tc8LtMdOZk=;
        b=JW2go06bje4vra8rIvT0KQ1r5Z+xXb990u4YTZ1p1Q5pmuwRlE00Rwbgp9QW0ha8U9
         LGW6rIBvCfTJyODyRhOPQ5FD/hybwYk5zqWGeRqglUrARv4Bse/57QRH51oGbPoCoq3l
         o9+TcycYK8/cUaBkOxGkI60GP78pmlhVUr8Tc=
Received: by 10.42.136.137 with SMTP id u9mr3778142ict.50.1323551445867;
        Sat, 10 Dec 2011 13:10:45 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e2sm50459337ibe.0.2011.12.10.13.10.44
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 13:10:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323521631-24320-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186793>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Michael Haggerty
> has an idea [1] that, instead of passing the same static buffer to
> caller every time the function is called, we free the old buffer and
> allocate the new one. This way access to the old (now invalid) buffer
> may be caught.
>
> This patch applies the same principle for resolve_ref() with a
> few modifications:
[...]
>  - Rely on mmap/mprotect to catch illegal access. We need valgrind or
>    some other memory tracking tool to reliably catch this in Michael'=
s
>    approach.

I wonder if the lower-tech approach would be so bad in practice.  On
systems using glibc, if MALLOC_PERTURB_ is set, then the value will
always be clobbered on free().  It would be possible to do the same
explicitly in resolve_ref() for platforms without such a feature.

>  - Because mprotect is used instead of munmap, we definitely leak
>    memory. Hopefully callers will not put resolve_ref() in a
>    loop that runs 1 million times.

Have you measured the performance impact when GIT_DEBUG_MEMCHECK is not
set?  (I don't expect major problems, but sometimes code surprises me.)

[...]
> Also introduce a new target, "make memcheck", that runs tests with th=
is
> flag on.

Neat.  Did it catch any bugs?

> --- a/cache.h
> +++ b/cache.h
> @@ -865,7 +865,8 @@ extern int read_ref(const char *filename, unsigne=
d char *sha1);
>   *
>   * errno is sometimes set on errors, but not always.
>   */
> -extern const char *resolve_ref(const char *ref, unsigned char *sha1,=
 int reading, int *flag);
> +#define resolve_ref(ref, sha1, reading, flag) resolve_ref_real(ref, =
sha1, reading, flag, __FUNCTION__, __LINE__)

__FUNCTION__ is nonstandard, though it's probably supported pretty
widely and we can do

	#ifndef __FUNCTION__
	#define __FUNCTION__ something-else
	#endif

in git-compat-util.h when we discover a platform that doesn't support
it if needed.  __func__ was introduced in C99.  __LINE__ and __FILE__
should work everywhere.

[...]
> --- /dev/null
> +++ b/t/t0071-memcheck.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +
> +test_description=3D'test that GIT_DEBUG_MEMCHECK works correctly'
> +. ./test-lib.sh
> +
> +test_expect_success 'test-resolve-ref must crash' '
> +	GIT_DEBUG_MEMCHECK=3D1 test-resolve-ref
> +	exit_code=3D$? &&
> +	test $exit_code -eq 139

Micronit: something like

	(
		GIT_DEBUG_MEMCHECK=3D1 &&
		export GIT_DEBUG_MEMCHECK &&
		test_expect_code 139 test-resolve-ref
	)

would fit better in an &&-list.

> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -60,6 +60,28 @@ void *xmallocz(size_t size)
>  	return ret;
>  }
> =20
> +void *xmalloc_mmap(size_t size, const char *file, int line)
> +{
> +	int *ret;
> +	size +=3D sizeof(int*) * 3;
> +	ret =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
> +		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (ret =3D=3D (int*)-1)
> +		die_errno("unable to mmap %lu bytes anonymously",
> +			  (unsigned long)size);
> +
> +	ret[0] =3D (int)file;
> +	ret[1] =3D line;
> +	ret[2] =3D size;
> +	return ret + 3;

Would this work on 64-bit platforms?

How does one retrieve the line and file number?  I guess one is
expected to retrieve them from the core dump, but a few words of
advice in Documentation/technical would be helpful.
