From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] gc --auto: don't lie about running in background on Windows
Date: Thu, 05 May 2016 09:28:59 -0700
Message-ID: <xmqqbn4kcvuc.fsf@gitster.mtv.corp.google.com>
References: <20160505171430.Horde.-GuvDpZBfS8VI1Zcfn4bJQI@webmail.informatik.kit.edu>
	<20160505151646.13189-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 05 18:29:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayM9G-00020R-8X
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 18:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbcEEQ3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 12:29:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754519AbcEEQ3D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2016 12:29:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAD15188A6;
	Thu,  5 May 2016 12:29:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lzEoxLFA5HYP
	zaFBYBhVGUArw0Y=; b=g52FBOHJelv345tf34PTVCtVknmlpcjr/KJuSzq5dPLb
	q6Ic89Fq24CCniau6Z/2ZurTc/tH//s2tsUI7VcxFtSc3daG7PI/NJkxWw3XguA2
	mYdSbFoyOvpM6cVaO48ZqQK8zqyaxKs1bUL/cDyC08ZQ//3pcpEkKRIrfveQTdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Fi/I5f
	NnbwKUenAODKapA+8zhXbCjHEHZGzf7YjSlTfyyv8Osov/8xeRTvX6Lz48w6T3Mm
	cX1lSWPRU3TXzWyVo3B0gVVMS2ejK+1EWxV+UGta2bdQ3IPBSqS5477JqFOXfFxz
	tCp50ckPsaJWkOeuCnjBq8uNSPuw9aPsifptQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1C90188A5;
	Thu,  5 May 2016 12:29:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 335E5188A4;
	Thu,  5 May 2016 12:29:01 -0400 (EDT)
In-Reply-To: <20160505151646.13189-1-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
	message of "Thu, 5 May 2016 17:16:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7985F83E-12DE-11E6-A548-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293651>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Arguably this helper function could be just a simple variable.  I
> opted for a function because:
>
>   - I preferred a single '#ifdef NO_POSIX_GOODIES', and putting a
>     static variable so near to EOF felt just wrong.  (And this is why
>     it's not an inline-able function defined in a header file.)
>
>   - currently we know already at compile time that Windows can't
>     daemonize, but in the future we might want to extend this helper
>     function to perform some runtime checks, too.  But this is perhap=
s
>     like preparing for crossing a bridge where we'll never get to.

Alternatively, the implementation of daemonize() and can_daemonize()
can live in compat/ and have the #ifdef switch in git-compat-util.h,
e.g. something along the lines of these:

	<< git-compat-util.h >>
	... after conditional inclusion of compat/mingw.h ...
	#ifndef can_daemonize
        #define can_daemonize() 1
	#endif
       =20
	<< compat/mingw.h >>
	#define can_daemonize() 0
	#define daemonize() mingw_daemonize()

	<< setup.c >>
        ...
        #ifndef NO_POSIX_GOODIES
        int daemonize(void)
        {
            ... no ifdef around here ...
	}
	#endif

We can be even more purist and move the daemonize() implementation
for POSIX to compat/posix.c to keep the generic part even more
platform agnostic, which would remove the only #ifdef in setup.c,
but that might be going a bit too far.

These possible implementation choices aside, the goal of this patch
is a worthwhile thing to do, I would think.

Thanks.

>  builtin/gc.c |  1 +
>  cache.h      |  1 +
>  setup.c      | 17 +++++++++++++++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c583aad6ec28..79a0f6dc1126 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -368,6 +368,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>  		 */
>  		if (!need_to_gc())
>  			return 0;
> +		detach_auto &=3D can_daemonize();
>  		if (!quiet) {
>  			if (detach_auto)
>  				fprintf(stderr, _("Auto packing the repository in background for=
 optimum performance.\n"));
> diff --git a/cache.h b/cache.h
> index fd728f079320..3662e5aabb98 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -524,6 +524,7 @@ extern int set_git_dir_init(const char *git_dir, =
const char *real_git_dir, int);
>  extern int init_db(const char *template_dir, unsigned int flags);
> =20
>  extern void sanitize_stdfds(void);
> +extern int can_daemonize(void);
>  extern int daemonize(void);
> =20
>  #define alloc_nr(x) (((x)+16)*3/2)
> diff --git a/setup.c b/setup.c
> index c86bf5c9fabe..6187a4ad9c47 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1033,12 +1033,25 @@ void sanitize_stdfds(void)
>  		close(fd);
>  }
> =20
> +#ifdef NO_POSIX_GOODIES
> +int can_daemonize(void)
> +{
> +	return 0;
> +}
> +
>  int daemonize(void)
>  {
> -#ifdef NO_POSIX_GOODIES
>  	errno =3D ENOSYS;
>  	return -1;
> +}
>  #else
> +int can_daemonize(void)
> +{
> +	return 1;
> +}
> +
> +int daemonize(void)
> +{
>  	switch (fork()) {
>  		case 0:
>  			break;
> @@ -1054,5 +1067,5 @@ int daemonize(void)
>  	close(2);
>  	sanitize_stdfds();
>  	return 0;
> -#endif
>  }
> +#endif /* #ifdef NO_POSIX_GOODIES */
