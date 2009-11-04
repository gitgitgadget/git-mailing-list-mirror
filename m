From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 04 Nov 2009 13:39:04 +0100
Message-ID: <4AF175E8.7020400@viscovery.net>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 13:39:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5f8t-00080Q-JG
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 13:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbZKDMjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 07:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbZKDMjD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 07:39:03 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:11493 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755660AbZKDMjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 07:39:01 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5f8i-0001eH-LE; Wed, 04 Nov 2009 13:39:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3F757BC81; Wed,  4 Nov 2009 13:39:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132081>

Please do not cull Cc list when you resend a patch, if possible.

After staring some time on the code, I have convinced myself that the
pthread_cond_wait and pthread_cond_signal implementation will work *in our
usage scenario* that has these preconditions:

- There is no more than one thread waiting on any particular condition
variable instance.

- pthread_cond_signal is called while the mutex is held.

- We retest the condition after pthread_cond_wait returns.

These conditions should be attached in BIG BOLD letters to this
implementation; particularly, the last one.

On to your patch...

The subject is a bit misleading, IMHO. You are not porting the
(p)threading code, but you are adding pthread_* function wrappers for Windows.

Your patch adds whitespace-at-eol. Please use git show --check to see where.

Andrzej K. Haczewski schrieb:
> Here is slightly modified patch with more comments where explanations were
> requested (ie. non atomic release mutex and wait).
> 
> The implementation of conditional variable is based on ACE.
> 
> The patch needs testing from someone capable of compiling Git on Windows
> and running it with msysgit environment. I can confirm that it compiles
> cleanly on both Linux and Windows. I modified Makefile only for MSVC
> part, so if you'd like to compile it with mingw or cygwin, proper
> corrections have to be made. I aim for native MSVC compilation, that's
> why I did it like that. That's also the reason I don't like
> having Pthreads for Win32 dependency - it's faster to use native
> calls than depend on 3rd party wrapper library to do it for you
> (ie. pthreads for win32 does allocations to implement POSIX
> standard, and full-conformance isn't required by Git, since Git uses
> only small subset of pthreads).
> 
> One more motivation I had for the patch: as I was reading through
> archives I had a feeling that Git aims to be as lightweight
> as possible, hence removing additional dependencies (even for
> Windows platform) seems sensible to me.
> 
> Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>

Please drop words from the commit message that do not make sense once this
commit is in git's history. Look at existing commit messages to get a
feeling for the style. Do write about "why" (motivation), "how" (design
choices) and "how not" (dead ends that you tried).

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 02f9246..c96d293 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1592,7 +1592,7 @@ struct thread_params {
>  
>  static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
>  
> -static void *threaded_find_deltas(void *arg)
> +static THREAD_FUNC(threaded_find_deltas, arg)
> ...
> -	return NULL;
> +	THREAD_RETURN(NULL);

See Erik's and Paolo's comments.

> @@ -2327,6 +2327,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  #ifdef THREADED_DELTA_SEARCH
>  	if (!delta_search_threads)	/* --threads=0 means autodetect */
>  		delta_search_threads = online_cpus();
> +
> +#ifdef _WIN32
> +	/*
> +	 * Windows requires initialization of mutex (CRITICAL_SECTION)
> +	 * and conditional variable.
> +	 */
> +	pthread_mutex_init(&read_mutex);
> +	pthread_mutex_init(&cache_mutex);
> +	pthread_mutex_init(&progress_mutex);
> +	pthread_cond_init(&progress_cond, NULL);
> +#endif

I think it would be OK to drop '= PTHREAD_{MUTEX,COND}_INITIALIZER' and
use *_init function calls without the #ifdef. Likewise for *_destroy.

> +cleanup:
> +#if defined(THREADED_DELTA_SEARCH) && defined(_WIN32)
> +	/* cleanup Windows threads thingies */
> +	pthread_cond_destroy(&progress_cond);
> +	pthread_mutex_destroy(&read_mutex);
> +	pthread_mutex_destroy(&cache_mutex);
> +	pthread_mutex_destroy(&progress_mutex);
> +#endif
> +
>  	return 0;
>  }
> +

Drop this empty line at EOF.

> @@ -0,0 +1,143 @@
> +/*
> + * Header used to "adapt" pthread-based POSIX code to Windows API threads.

I think "adapt" is the right word here. You don't need to put it in quotes. ;)

> + *
> + * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
> + */
> + 
> +#ifndef PTHREAD_H
> +#define PTHREAD_H
> +
> +#ifndef WIN32_LEAN_AND_MEAN
> +#define WIN32_LEAN_AND_MEAN
> +#endif
> +
> +#include <windows.h>
> +
> +/*
> + * don't include mingw.h for err_win_to_posix function - mingw.h doesn't 
> + * have include-guards

So what? Is there an #include loop? Can't you add include guards?

> +static __inline int pthread_cond_init(pthread_cond_t *cond, const void *unused)

What's wrong with 'static inline int ...' (without the underscores)?

> +{
> +	cond->waiters = 0;
> +
> +	InitializeCriticalSection(&cond->waiters_lock);
> +
> +	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
> +	if (NULL == cond->sema) 
> +		return -1;
> +	return 0;

In case of failure, the pthread_* functions return the error number, not
-1. Moreover, we write

	if (!cond->sema)
		return err_win_to_posix(GetLastError());
or
	return cond->sema ? 0 : err_win_to_posix(GetLastError());

> +static __inline int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
> +{
> ...
> +	/* let's wait */
> +	if (0 != WaitForSingleObject(cond->sema, INFINITE))
> +		ret = -1;

Mind the return value!

> +static __inline int pthread_cond_signal(pthread_cond_t *cond)
> +{
> ...
> +	if (have_waiters)
> +		return ReleaseSemaphore(cond->sema, 1, NULL) ? 0 : -1;

Return value again.

> +static __inline int pthread_create(pthread_t *t, const void *unused, DWORD (__stdcall *start_routine)(LPVOID), void *arg)
> +{
> +	*t = CreateThread(NULL, 0, start_routine, arg, 0, NULL);
> +
> +	if (NULL == *t) {

	if (!*t)

> +		errno = err_win_to_posix(GetLastError());
> +		return -1;

Return value again. errno is not set.

> +	} else {
> +		errno = 0;
> +		return 0;
> +	}
> +}
> +
> +static __inline int pthread_join(pthread_t t, void **unused)
> +{
> ...
> +			errno = err_win_to_posix(GetLastError());
> +			return -1;

And again.

-- Hannes
