From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 8/9] autoconf: Check for timer_settime
Date: Fri, 29 Aug 2014 19:26:26 +0200
Message-ID: <5400B7C2.20603@kdbg.org>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com> <1409330561-11806-8-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 19:26:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPwm-0003Nt-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 19:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbaH2R0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 13:26:44 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:47316 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753727AbaH2R0b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 13:26:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 87353130051;
	Fri, 29 Aug 2014 19:26:27 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9696119F497;
	Fri, 29 Aug 2014 19:26:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <1409330561-11806-8-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256167>

Am 29.08.2014 18:42, schrieb Jacob Keller:
> From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
> 
> This function will be used in a following commit.
> 
> The timer_settime function is provided in librt on some systems. We
> already use this library sometimes to get clock_gettime, so rework the
> logic so we don't link with it twice.
> 
> This function was not previously used by git. This can cause trouble for
> people on systems without timer_settime if they only rely on
> config.mak.uname. They will need to set NO_TIMER_SETTIME manually.
> 
> Add proper replacement function macros for setitimer and timer_settime
> that implement timer_settime as a wrapper for setitimer. In this way, if
> the system has setitimer but not timer_settime then we will be able to
> call timer_create, timer_settime, and timer_delete correctly and it will
> wrap to setitimer under the hood. This will be used in the following
> commit.
> 
> Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  Makefile          | 21 +++++++++++++++++++++
>  config.mak.uname  |  3 +++
>  configure.ac      |  8 ++++++++
>  git-compat-util.h | 20 +++++++++++++++++++-
>  4 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 66329e4b372b..5337ef0b7cd6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -182,16 +182,22 @@ all::
>  #
>  # Define NO_SETITIMER if you don't have setitimer()
>  #
> +# Define NO_TIMER_SETTIME if you don't have timer_settime()
> +#
>  # Define NO_TIMER_T if you don't have timer_t.
> +# This also implies NO_TIMER_SETTIME
>  #
>  # Define NO_STRUCT_TIMESPEC if you don't have struct timespec
> +# This also implies NO_TIMER_SETTIME
>  #
>  # Define NO_STRUCT_SIGEVENT if you don't have struct sigevent
> +# This also implies NO_TIMER_SETTIME
>  #
>  # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
>  # This also implies NO_SETITIMER
>  #
>  # Define NO_STRUCT_ITIMERSPEC if you don't have struct itimerspec
> +# This also implies NO_TIMER_SETTIME
>  #
>  # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
>  # generally faster on your platform than accessing the working directory.
> @@ -1348,12 +1354,15 @@ ifdef OBJECT_CREATION_USES_RENAMES
>  endif
>  ifdef NO_TIMER_T
>  	COMPAT_CFLAGS += -DNO_TIMER_T
> +	NO_TIMER_SETTIME = YesPlease
>  endif
>  ifdef NO_STRUCT_TIMESPEC
>  	COMPAT_CFLAGS += -DNO_STRUCT_TIMESPEC
> +	NO_TIMER_SETTIME = YesPlease
>  endif
>  ifdef NO_STRUCT_SIGEVENT
>  	COMPAT_CFLAGS += -DNO_STRUCT_SIGEVENT
> +	NO_TIMER_SETTIME = YesPlease
>  endif
>  ifdef NO_STRUCT_ITIMERVAL
>  	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
> @@ -1361,10 +1370,14 @@ ifdef NO_STRUCT_ITIMERVAL
>  endif
>  ifdef NO_STRUCT_ITIMERSPEC
>  	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERSPEC
> +	NO_TIMER_SETTIME = YesPlease
>  endif
>  ifdef NO_SETITIMER
>  	COMPAT_CFLAGS += -DNO_SETITIMER
>  endif
> +ifdef NO_TIMER_SETTIME
> +	COMPAT_CFLAGS += -DNO_TIMER_SETTIME
> +endif
>  ifdef NO_PREAD
>  	COMPAT_CFLAGS += -DNO_PREAD
>  	COMPAT_OBJS += compat/pread.o
> @@ -1524,6 +1537,14 @@ endif
>  
>  ifdef HAVE_CLOCK_GETTIME
>  	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
> +	LINK_WITH_LIBRT = YesPlease
> +endif
> +
> +ifndef NO_TIMER_SETTIME
> +	LINK_WITH_LIBRT = YesPlease
> +endif
> +
> +ifdef LINK_WITH_LIBRT
>  	EXTLIBS += -lrt
>  endif
>  
> diff --git a/config.mak.uname b/config.mak.uname
> index f0d93ef868a7..d04deab2dfa8 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -99,6 +99,7 @@ ifeq ($(uname_S),Darwin)
>  	USE_ST_TIMESPEC = YesPlease
>  	HAVE_DEV_TTY = YesPlease
>  	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
> +	NO_TIMER_SETTIME = UnfortunatelyYes
>  	COMPAT_OBJS += compat/precompose_utf8.o
>  	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
>  endif
> @@ -360,6 +361,7 @@ ifeq ($(uname_S),Windows)
>  	NO_STRUCT_TIMESPEC = UnfortunatelyYes
>  	NO_STRUCT_SIGEVENT = UnfortunatelyYes
>  	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
> +	NO_TIMER_SETTIME = UnfortunatelyYes
>  
>  	CC = compat/vcbuild/scripts/clink.pl
>  	AR = compat/vcbuild/scripts/lib.pl
> @@ -513,6 +515,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_STRUCT_TIMESPEC = UnfortunatelyYes
>  	NO_STRUCT_SIGEVENT = UnfortunatelyYes
>  	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
> +	NO_TIMER_SETTIME = UnfortunatelyYes
>  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>  	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
> diff --git a/configure.ac b/configure.ac
> index 954f9ddb03c2..9d6ec41acc82 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -946,6 +946,14 @@ GIT_CHECK_FUNC(setitimer,
>  [NO_SETITIMER=YesPlease])
>  GIT_CONF_SUBST([NO_SETITIMER])
>  #
> +# Define NO_TIMER_SETTIME if you don't have timer_settime
> +GIT_CHECK_FUNC(timer_settime,
> +[NO_TIMER_SETTIME=],
> +[AC_SEARCH_LIBS(timer_settime,[rt],
> +  [NO_TIMER_SETTIME=],
> +  [NO_TIMER_SETTIME=YesPlease])])
> +GIT_CONF_SUBST([NO_TIMER_SETTIME])
> +#
>  # Define NO_STRCASESTR if you don't have strcasestr.
>  GIT_CHECK_FUNC(strcasestr,
>  [NO_STRCASESTR=],
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4ef17df86b0e..b23602196323 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -225,7 +225,25 @@ struct itimerspec {
>  #endif
>  
>  #ifdef NO_SETITIMER
> -#define setitimer(which,value,ovalue)
> +#define setitimer(which,value,ovalue) ((void) (which), (void) (value), (void) (ovalue), errno = ENOSYS, -1)
> +#endif
> +
> +#ifdef NO_TIMER_SETTIME
> +#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) (sevp), (void) (timerp), errno = ENOSYS, -1)
> +
> +#define timer_delete(timer) do {		\
> +	struct itimerval v = {{0,},};		\
> +	setitimer(ITIMER_REAL, &v, NULL);	\
> +} while (0)
> +
> +#define timer_settime(timer, flags, value, ovalue) do {				\
> +	struct itimerval _ivalue;						\
> +	_ivalue.it_interval.tv_sec = value.it_interval.tv_sec;			\
> +	_ivalue.it_interval.tv_usec = value.it_interval.tv_nsec / 1000L;	\
> +	_ivalue.it_value.tv_sec  value.it_value.tv_sec;				\
> +	_ivalue_it_value.tv_usec = value.it_value.tv_nsec / 1000L;		\
> +	setitimer(ITIMER_REAL, &_ivalue, NULL);					\
> +while (0)
>  #endif
>  
>  #ifndef NO_LIBGEN_H
> 

This looks like that the features that we need can be mapped back and
forth between setitimer() and timer_settime(). So, why don't you define
a compat/setitimer.[ch] for your system that does not have setitimer()
and implement setitimer() in terms of timer_settime() instead of the
other way round? Then you don't need to change any of the client code.
Also, you won't have to worry about the odd timer_settime() in OpenBSD.

-- Hannes
