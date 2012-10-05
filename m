From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 08/10] Integrate wildmatch to git
Date: Fri, 5 Oct 2012 18:20:02 -0300
Message-ID: <CACnwZYeob34c6hbMX-CNvJ67Qu5b+v7J8SbfcBOgZv6Qu+aqFg@mail.gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
	<1349412069-627-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 23:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKFJf-0003Q6-Gl
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 23:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801Ab2JEVUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 17:20:05 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55030 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932725Ab2JEVUE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 17:20:04 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1837525wgb.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=07/4+aOEymHNmrn80WvB2Jnw1nVLZ9FlG7LCex4kvdY=;
        b=LkBlbBIw7nLccw3svnvAfXU8rCJJX7R5uldMUMYJ8rWXA5PodEE02ufzpmbO8L6Zou
         KM6regGQogg+dfIMUbwmVn4NE3a7lhmNQMEVNpU0dzT2HbxNzLAHKwwKr1uA2Mlc6sE2
         fQj8pOnzShUEejtmtNpRjE5UaYsnb/Zzyf8P7OO0GNQHT6+Xxi6Bxmq6RzqJnfBXzQeI
         pfnGntJ+gEFKF3cHXbjP6joTgIjefByzNf9wfsRM+x8y33OhV0w6D+ZHPKIrZRCBT+wE
         07x2PlbnbLbYIeGAuZbbbwmt8UgLUMqagkfHycm3w9ueoiNIMflIzmQq2PiE67owAoIM
         28lQ==
Received: by 10.180.84.202 with SMTP id b10mr5752325wiz.13.1349472002976; Fri,
 05 Oct 2012 14:20:02 -0700 (PDT)
Received: by 10.194.19.166 with HTTP; Fri, 5 Oct 2012 14:20:02 -0700 (PDT)
In-Reply-To: <1349412069-627-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207122>

On Fri, Oct 5, 2012 at 1:41 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This makes wildmatch.c part of libgit.a and builds test-wildmatch; th=
e
> dependency on libpopt in the original has been replaced with the use
> of our parse-options. Global variables in test-wildmatch are marked
> static to avoid sparse warnings.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  .gitignore           |  1 +
>  Makefile             |  3 ++
>  t/t3070-wildmatch.sh | 27 ++++++++++++++++
>  test-wildmatch.c     | 88 ++++++++++++++++++++++--------------------=
----------
>  wildmatch.c          | 26 +++++-----------
>  5 files changed, 75 insertions(+), 70 deletions(-)
>  create mode 100755 t/t3070-wildmatch.sh
>
> diff --git a/test-wildmatch.c b/test-wildmatch.c
> index 88585c2..bb726c8 100644
> --- a/test-wildmatch.c
> +++ b/test-wildmatch.c
> @@ -19,34 +19,38 @@
>
>  /*#define COMPARE_WITH_FNMATCH*/
>
> -#define WILD_TEST_ITERATIONS
> -#include "lib/wildmatch.c"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "wildmatch.h"
>
> -#include <popt.h>
> +#ifndef MAXPATHLEN
> +#define MAXPATHLEN 1024
> +#endif
> +#ifdef NO_STRLCPY
> +#include "compat/strlcpy.c"
> +#define strlcpy gitstrlcpy
> +#endif
>
>  #ifdef COMPARE_WITH_FNMATCH
>  #include <fnmatch.h>
>
> -int fnmatch_errors =3D 0;
> +static int fnmatch_errors =3D 0;
>  #endif
>
> -int wildmatch_errors =3D 0;
> -char number_separator =3D ',';
> +static int wildmatch_errors =3D 0;
>
>  typedef char bool;
>
> -int output_iterations =3D 0;
> -int explode_mod =3D 0;
> -int empties_mod =3D 0;
> -int empty_at_start =3D 0;
> -int empty_at_end =3D 0;
> -
> -static struct poptOption long_options[] =3D {
> -  /* longName, shortName, argInfo, argPtr, value, descrip, argDesc *=
/
> -  {"iterations",     'i', POPT_ARG_NONE,   &output_iterations, 0, 0,=
 0},
> -  {"empties",        'e', POPT_ARG_STRING, 0, 'e', 0, 0},
> -  {"explode",        'x', POPT_ARG_INT,    &explode_mod, 0, 0, 0},
> -  {0,0,0,0, 0, 0, 0}
> +static int explode_mod =3D 0;
Isn't static variables like this initialized to zero by default? There
is a high chance that I might be wrong though.
