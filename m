From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 13:27:37 +0100
Message-ID: <4AF2C4B9.10402@viscovery.net>
References: <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com> <1257416325-5605-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	kusmabite@gmail.com
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 13:29:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N61RT-0007z8-H4
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 13:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbZKEM1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 07:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbZKEM1o
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 07:27:44 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:22417 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944AbZKEM1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 07:27:43 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N61RB-0003Xe-KO; Thu, 05 Nov 2009 13:27:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 60D924E9; Thu,  5 Nov 2009 13:27:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1257416325-5605-1-git-send-email-ahaczewski@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132225>

Andrzej K. Haczewski schrieb:
> diff --git a/Makefile b/Makefile
> index bc039ac..30089a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -453,6 +453,7 @@ LIB_H += commit.h
>  LIB_H += compat/bswap.h
>  LIB_H += compat/cygwin.h
>  LIB_H += compat/mingw.h
> +LIB_H += compat/win32/pthread.h
>  LIB_H += csum-file.h
>  LIB_H += decorate.h
>  LIB_H += delta.h
> @@ -971,15 +972,15 @@ ifdef MSVC
>  	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
>  	NO_REGEX = YesPlease
>  	NO_CURL = YesPlease
> -	NO_PTHREADS = YesPlease
> +	THREADED_DELTA_SEARCH = YesPlease
>  	BLK_SHA1 = YesPlease
>  
>  	CC = compat/vcbuild/scripts/clink.pl
>  	AR = compat/vcbuild/scripts/lib.pl
>  	CFLAGS =
>  	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
> -	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
> -	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
> +	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o
> +	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
>  	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
>  	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
>  	lib =

What compiles compat/win32/pthread.c?

Please don't forget to add compat/win32/*.o to the clean target.

> +int pthread_create(pthread_t *thread, const void *unused,
> +		   void *(*start_routine)(void*), void *arg)
> +{
> +	thread->arg = arg;
> +	thread->handle = CreateThread(NULL, 0, win32_start_routine, thread, 0, NULL);

Elsewhere we use _beginthreadex(). What's the difference?

> +static inline int pthread_cond_init(pthread_cond_t *cond, const void *unused)
> +{
> +	cond->waiters = 0;
> +
> +	InitializeCriticalSection(&cond->waiters_lock);
> +
> +	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
> +	if (!cond->sema)
> +		die("");
> +	return 0;
> +}
> +
> +static inline int pthread_cond_destroy(pthread_cond_t *cond)
> +{
> +	CloseHandle(cond->sema);
> +	cond->sema = NULL;
> +
> +	DeleteCriticalSection(&cond->waiters_lock);
> +
> +	return 0;
> +}
> +
> +static inline int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
> +{
> +	/* serialize access to waiters count */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	++cond->waiters;
> +	LeaveCriticalSection(&cond->waiters_lock);
> +
> +	/*
> +	 * Unlock external mutex and wait for signal.
> +	 * NOTE: we've held mutex locked long enough to increment
> +	 * waiters count above, so there's no problem with
> +	 * leaving mutex unlocked before we wait on semaphore.
> +	 */
> +	LeaveCriticalSection(mutex);
> +
> +	/* let's wait */
> +	WaitForSingleObject(cond->sema, INFINITE))
> +
> +	/* we're done waiting, so make sure we decrease waiters count */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	--cond->waiters;
> +	LeaveCriticalSection(&cond->waiters_lock);
> +
> +	/* lock external mutex again */
> +	EnterCriticalSection(mutex);
> +
> +	return 0;
> +}
> +
> +static inline int pthread_cond_signal(pthread_cond_t *cond)
> +{
> +	int have_waiters;
> +
> +	/* serialize access to waiters count */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	have_waiters = cond->waiters > 0;
> +	LeaveCriticalSection(&cond->waiters_lock);
> +
> +	/*
> +	 * Signal only when there are waiters
> +	 */
> +	if (have_waiters)
> +		return ReleaseSemaphore(cond->sema, 1, NULL) ?
> +			0 : err_win_to_posix(GetLastError();
> +	else
> +		return 0;
> +}

The pthread_cond_* functions are quite voluminous, but not performance
critical. Could you please move them to pthread.c as well?

-- Hannes
