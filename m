From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 04 Nov 2009 09:15:21 +0100
Message-ID: <4AF13819.7050306@viscovery.net>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 09:15:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5b1e-0002HF-IM
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 09:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbZKDIPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 03:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbZKDIPT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 03:15:19 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:54911 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752404AbZKDIPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 03:15:18 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5b1V-0000DG-Hx; Wed, 04 Nov 2009 09:15:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 56390BC81; Wed,  4 Nov 2009 09:15:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132060>

Andrzej K. Haczewski schrieb:
> ---

You should sign-off your patches.

>  #ifdef THREADED_DELTA_SEARCH
> -#include "thread-utils.h"
> -#include <pthread.h>
> +# include "thread-utils.h"
> +# ifndef _WIN32
> +#  include <pthread.h>
> +# else
> +#  include <winthread.h>
> +# endif
>  #endif

Can't you just use the pthread package that is included in msysgit?

> +#ifndef _WIN32
>  static void *threaded_find_deltas(void *arg)
> +#else
> +static DWORD WINAPI threaded_find_deltas(LPVOID arg)
> +#endif
> ...
> +#ifndef _WIN32
>  	return NULL;
> +#else
> +	return 0;
> +#endif
> etc ...

You have far too many #ifdef in the generic code. There must be a better
way to hide the implementation details of this emulation.

> +#ifdef _WIN32
> +	/*
> +	 * Windows require initialization of mutex (CRITICAL_SECTION)
> +	 * and conditional variable.
> +	 */
> +	pthread_mutex_init(&read_mutex);
> +	pthread_mutex_init(&cache_mutex);
> +	pthread_mutex_init(&progress_mutex);
> +	win32_cond_init(&progress_cond);
> +#endif

*If* we are going to use this minimal pthreads implementation, then I
think it will be OK to call pthread_*_init even on non-Windows.

> +static __inline int win32_cond_init(win32_cond_t *cond)
> +{
> +	cond->waiters = 0;
> +
> +	InitializeCriticalSection(&cond->waiters_lock);
> +
> +	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);

Wouldn't an Event object be lighter-weight? (I'm only guessing.)

> +	if (NULL == cond->sema)
> +		return -1;
> +	return 0;
> +}
> +
> +static __inline int win32_cond_destroy(win32_cond_t *cond)
> +{
> +	CloseHandle(cond->sema);
> +	cond->sema = NULL;
> +
> +	DeleteCriticalSection(&cond->waiters_lock);
> +
> +	return 0;
> +}
> +
> +static __inline int win32_cond_wait(win32_cond_t *cond, CRITICAL_SECTION *mutex)

And the reason that this is not pthread_cond_wait, is...?

> +{
> +	DWORD result;
> +	int ret = 0;
> +
> +	/* we're waiting... */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	++cond->waiters;
> +	LeaveCriticalSection(&cond->waiters_lock);
> +
> +	/* unlock external mutex and wait for signal */
> +	LeaveCriticalSection(mutex);
> +	result = WaitForSingleObject(cond->sema, INFINITE);

Releasing the mutex and entering the wait state as well as leaving the
wait state and reacquiring the mutex should be atomic. Neither are in this
implementation. You are not mentioning why you are implementing things
like this and why this would be acceptable.

> +
> +	if (0 != result)
> +		ret = -1;
> +
> +	/* one waiter less */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	--cond->waiters;
> +	LeaveCriticalSection(&cond->waiters_lock);
> +
> +	/* lock external mutex again */
> +	EnterCriticalSection(mutex);

> +/* almost copy-paste code of mingw.c */
> +static int err_win_to_posix()
> +{

There must be a better way than to just copy & paste this huge piece of code.

-- Hannes
