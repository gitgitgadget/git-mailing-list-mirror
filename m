From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 04/21] harden REALLOC_ARRAY and xcalloc against size_t
 overflow
Date: Sat, 20 Feb 2016 22:32:00 +0100
Message-ID: <56C8DB50.7070606@web.de>
References: <20160219111941.GA31906@sigill.intra.peff.net>
 <20160219112200.GD9319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 22:32:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXF8X-0004Lj-QC
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 22:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759439AbcBTVcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2016 16:32:17 -0500
Received: from mout.web.de ([212.227.17.11]:51696 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbcBTVcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 16:32:15 -0500
Received: from [192.168.178.36] ([79.213.114.152]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MOzoR-1adYFm1fIV-006KPI; Sat, 20 Feb 2016 22:32:05
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160219112200.GD9319@sigill.intra.peff.net>
X-Provags-ID: V03:K0:KE73s/flwc1A4jMMX+qK7j+4T5paxCRtsABno8U4bKX89zPwFrt
 tKqMnk0xqTd2/4txAG8Ys/PBktgnApi+IR4GbCCBKzW2sKvl0WWY6OVylzd629k5cZ86nbl
 Bfn6K6GGlEB0MsSULqU0c9rojX3tpLDVFvPl4t6sy4sSb+ATJN8C0/l3lmZN8vM2qs5H1el
 i9QNY632c4WNT9g5u2zDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zy7cXfqoP90=:l/2EVSHsHAbO4PKbccggTA
 GHJA9XDQI24kCeMOQQuORGSXh4ZGYzHHWt59uUl904jDsFD8AtLxiAXzLnSuxvdEAV9Shkej7
 8VJNsvvAPZgbrKxZCk6wBDgLKYLWlhklIaeUDzvAyg2fHlMEZ3AkIT9RSLzj5ibOE1TH4P49N
 41foxyvEvZpIZ7MGkSQMiuWNdQayv0B6Xju6SA2kN2jyAWmNw6dhg0OcE4HOWY2WWCBQPyqJv
 1oo47BQoyFj7iiHtSOQM7i+T00Zp8r18Hh8jzk+DlnMcO+2E29qukz7mxOWPqhy1cMrqRvoU6
 QilRVy4Dq+NgzF65VraQuS1DlpTuK54VpPk4/gIG+GtMteeC/7OutgadD95sdO27c85zphw71
 Z07v8585dARylSGBXZg5vf3VSB2fBk8X6aH/73FskcA5pN4KRiyI/Bv0m5UGL3fLeX9VTsVqB
 8sfJIk1IbVQRosl2ZfI0D/1dX7ifW+wkMT5yUkwEjTXiJ0OchgqKkCSj5gZBfbA7hGUnJx9HG
 4zQZU91nAYFUNUAtpzBMnNJUbZIqyNSDCX6fr4tRIQyed9aNDIf922kL3ffqlI45kzOwGZYvF
 Hd1InaufTff0H0+ajnUDcH4r57vN/6oUoOnWB6M+yYy3VCnUNc82+Cm1mDtPzW+LxCEvjRGsh
 vZq4+4rCaY+GoMLi9brciwAS0WiG4H8O5jNHfxlLaAhzL3ENUUxPEX7hE+IDldvJG0CkZWSaW
 kPlF9qkx+wWVO8djePdEQTWOpuPIVo3DnxRx5yWiAXt2gX6ijZCLWIKwK8yBcvyJUDcBxD+B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286787>

Am 19.02.2016 um 12:22 schrieb Jeff King:
> REALLOC_ARRAY inherently involves a multiplication which can
> overflow size_t, resulting in a much smaller buffer than we
> think we've allocated. We can easily harden it by using
> st_mult() to check for overflow.  Likewise, we can add
> ALLOC_ARRAY to do the same thing for xmalloc calls.

Good idea!

> xcalloc() should already be fine, because it takes the two
> factors separately, assuming the system calloc actually
> checks for overflow. However, before we even hit the system
> calloc(), we do our memory_limit_check, which involves a
> multiplication. Let's check for overflow ourselves so that
> this limit cannot be bypassed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   git-compat-util.h | 3 ++-
>   wrapper.c         | 3 +++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 0c65033..55c073d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -779,7 +779,8 @@ extern int odb_pack_keep(char *name, size_t names=
z, const unsigned char *sha1);
>   extern char *xgetcwd(void);
>   extern FILE *fopen_for_writing(const char *path);
>
> -#define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), (alloc) * size=
of(*(x)))
> +#define ALLOC_ARRAY(x, alloc) (x) =3D xmalloc(st_mult((alloc), sizeo=
f(*(x))))
> +#define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), st_mult((alloc=
), sizeof(*(x))))

st_mult(x, y) calls unsigned_mult_overflows(x, y), which divides by x.=20
This division can be done at compile time if x is a constant.  This can=
=20
be guaranteed for all users of the two macros above by reversing the=20
arguments of st_mult(), so that sizeof comes first.  Probably not a big=
=20
win, but why not do it if it's that easy?

Or perhaps a macro like this could help here and in other places which=20
use st_mult with sizeof:

   #define SIZEOF_MULT(x, n) st_mult(sizeof(x), (n))

(I'd call it ARRAY_SIZE, but that name is already taken. :)

Ren=C3=A9
