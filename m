From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v3] Support for setitimer() on platforms lacking it
Date: Sat, 8 Sep 2012 17:31:29 +0200
Message-ID: <001d01cd8dd7$04eabc70$0ec03550$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 17:31:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAN0e-00085x-Iv
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 17:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab2IHPbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 11:31:41 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:50568 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab2IHPbk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 11:31:40 -0400
Received: from DualCore (dsdf-4db5dae6.pool.mediaWays.net [77.181.218.230])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Me7bO-1SvTXx1EoI-00Pvka; Sat, 08 Sep 2012 17:31:39 +0200
References: 
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2M3uYsNXj3/yNlToSgsL44k0ht9wA9w2pw
Content-Language: de
X-Provags-ID: V02:K0:hBgC0jj4pEBgtdzR4MSsLK6p10zdX/wdR1qH0nNueWy
 OsApaIrEsS0FauOMVpr1L0Oez/UdL1CjXRmvyTWVH23zKdV3uE
 vIfLJ541Cc/i4W4PQKNOcdSFc3wwbFRrAC3YuJw2DLOicI7KmX
 vOI0vo/rpJvsEpTQ3FOdTHmyX4+DTlzzoraYN0tsDJcNv2o312
 711/yQUwfIofuZXdDQlDirY/iuszHt87LjCMNNEXJ5S/yOWFaS
 hN+D/CGzPoKaW9cu1jpV/nPrBKsnxlcMkjehIEe4RbuOaVvjOG
 VvMXVGz3PxFMuK504jXk/9ew1FBSyQ4KOHWvvSsp+GaqR+a1oG
 SaNfo5eU1XhDm4M4+no5uPEj3fcQ3S5hdtIcjzL/b63J//rFFC
 kI14V32BGnRKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205016>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Friday, September 07, 2012 11:55 AM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'
> Subject: RE: [PATCH v3] Support for setitimer() on platforms lacking it
> 
> HP NonStop (currently) doesn't have setitimer(). The previous attempt of an
> emulation (reverted by this commit) was not a real substitute for a recurring
> itimer (as here we also don't have SA_RESTART, so can't re-arm the timer).
> As setitimer() is only used in cases of perceived latency and it doesn't affect
> correctness, it now gets disabled entirely, if NO_SETITIMER is set.
> HP NonStop does provide struct itimerval, but other platforms may not, so this
> is taken care of in this commit too, by setting NO_STRUCT_ITIMERVAL.
> 
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  Makefile          |  5 +++++
>  compat/itimer.c   | 50 --------------------------------------------------
>  git-compat-util.h | 11 +++++++++--
>  3 files changed, 14 insertions(+), 52 deletions(-)
>  delete mode 100644 compat/itimer.c
> 
> diff --git a/Makefile b/Makefile
> index ac49320..7be555b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -157,6 +157,11 @@ all::
>  # Define NO_PREAD if you have a problem with pread() system call (e.g.
>  # cygwin1.dll before v1.5.22).
>  #
> +# Define NO_SETITIMER if you don't have setitimer()
> +#
> +# Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
> +# This also implies NO_SETITIMER
> +#
>  # Define NO_THREAD_SAFE_PREAD if your pread() implementation is not
>  # thread-safe. (e.g. compat/pread.c or cygwin)
>  #

Here too (just like in my MKDIR_WO_TRAILING_SLASH patch) it is missing the part that adds

ifdef NO_STRUCT_ITIMERVAL
	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
	NO_SETITIMER=YesPlease
endif
ifdef NO_SETITIMER
	COMPAT_CFLAGS += -DNO_SETITIMER
endif

> diff --git a/compat/itimer.c b/compat/itimer.c
> deleted file mode 100644
> index 713f1ff..0000000
> --- a/compat/itimer.c
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -#include "../git-compat-util.h"
> -
> -static int git_getitimer(int which, struct itimerval *value)
> -{
> -	int ret = 0;
> -
> -	switch (which) {
> -		case ITIMER_REAL:
> -			value->it_value.tv_usec = 0;
> -			value->it_value.tv_sec = alarm(0);
> -			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> -			break;
> -		case ITIMER_VIRTUAL: /* FALLTHRU */
> -		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
> -		default: errno = EINVAL; ret = -1;
> -	}
> -	return ret;
> -}
> -
> -int git_setitimer(int which, const struct itimerval *value,
> -				struct itimerval *ovalue)
> -{
> -	int ret = 0;
> -
> -	if (!value
> -		|| value->it_value.tv_usec < 0
> -		|| value->it_value.tv_usec > 1000000
> -		|| value->it_value.tv_sec < 0) {
> -		errno = EINVAL;
> -		return -1;
> -	}
> -
> -	else if (ovalue)
> -		if (!git_getitimer(which, ovalue))
> -			return -1; /* errno set in git_getitimer() */
> -
> -	else
> -	switch (which) {
> -		case ITIMER_REAL:
> -			alarm(value->it_value.tv_sec +
> -				(value->it_value.tv_usec > 0) ? 1 : 0);
> -			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> -			break;
> -		case ITIMER_VIRTUAL: /* FALLTHRU */
> -		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
> -		default: errno = EINVAL; ret = -1;
> -	}
> -
> -	return ret;
> -}
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 18089f0..4628d7a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -162,9 +162,16 @@
>  #define probe_utf8_pathname_composition(a,b)
>  #endif
> 
> +#ifdef NO_STRUCT_ITIMERVAL
> +struct itimerval {
> +	struct timeval it_interval;
> +	struct timeval it_value;
> +}
> +#define NO_SETITIMER

The above line gets obsolete with further up mentioned change in Makefile

> +#endif
> +
>  #ifdef NO_SETITIMER
> -#define setitimer(a,b,c) git_setitimer((a),(b),(c))
> -extern int git_setitimer(int, const struct itimerval *, struct itimerval *);
> +#define setitimer(which,value,ovalue)
>  #endif
> 
>  #ifdef MKDIR_WO_TRAILING_SLASH
> --
> 1.7.12
