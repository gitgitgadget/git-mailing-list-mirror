From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of
 Pthreads API
Date: Fri, 8 Jan 2010 06:32:32 +0300
Message-ID: <20100108033232.GA28263@dpotapov.dyndns.org>
References: <cover.1262895936.git.j6t@kdbg.org>
 <44c7183e43089c64fb65bd248f7fa5b9731067ea.1262895936.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit <msysgit@googlegroups.com>, git@vger.kernel.org,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 04:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT5bm-0002Qw-5U
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 04:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799Ab0AHDdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 22:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702Ab0AHDdt
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 22:33:49 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:33475 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab0AHDdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 22:33:49 -0500
Received: by fxm25 with SMTP id 25so12311455fxm.21
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 19:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y9r6lvTg4zJte5gDzDDI2xIAnLNnTSTbkzy7VjI5iaw=;
        b=JzcO3s/tfOnqoFib86qe+gWn/p2K+AZOemkGYMKKTgdu+hRVbdx3p5yjMD5wtDpwde
         /a/1bb5nFeWyTzBFBY9Psu60beiq3zJbZRIUCwQKhti80iGl95IdZFl7YjcaJJcHdNMb
         ak4yt0ml0P8HMy35DSfTs33JadmLrLph87vZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YKT72JUrHMDslqK0TN2PkzI7IvthhIYljiQysnF2Gitu0/24tC5Y0gLO0bbZ5HsLR7
         wxOmp+yPtggwfVLNbpt4hUleSr7LNBjMWKN69bqI/ncs+xZ9jlcMk5cJkk4qFFrKXqr/
         fto3IO92LGRPNUmhgsfn6W7l/pBmmDWCPGcPw=
Received: by 10.223.14.13 with SMTP id e13mr3797863faa.85.1262921626364;
        Thu, 07 Jan 2010 19:33:46 -0800 (PST)
Received: from localhost (ppp85-141-235-181.pppoe.mtu-net.ru [85.141.235.181])
        by mx.google.com with ESMTPS id 26sm887255fks.20.2010.01.07.19.33.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 19:33:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44c7183e43089c64fb65bd248f7fa5b9731067ea.1262895936.git.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136413>

On Thu, Jan 07, 2010 at 10:54:57PM +0100, Johannes Sixt wrote:
> +
> +int pthread_cond_init(pthread_cond_t *cond, const void *unused)
> +{
> +	cond->waiters = 0;
> +
> +	InitializeCriticalSection(&cond->waiters_lock);

Is waiters_lock really necessary?

> +
> +int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
> +{
> +	/* serialize access to waiters count */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	++cond->waiters;
> +	LeaveCriticalSection(&cond->waiters_lock);

InterlockedIncrement(&cond->waiters);

> +
> +	/*
> +	 * Unlock external mutex and wait for signal.
> +	 * NOTE: we've held mutex locked long enough to increment
> +	 * waiters count above, so there's no problem with
> +	 * leaving mutex unlocked before we wait on semaphore.
> +	 */
> +	LeaveCriticalSection(mutex);
> +
> +	/* let's wait - ignore return value */
> +	WaitForSingleObject(cond->sema, INFINITE);
> +
> +	/* we're done waiting, so make sure we decrease waiters count */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	--cond->waiters;
> +	LeaveCriticalSection(&cond->waiters_lock);

InterlockedDecrement(&cond->waiters);

> +
> +	/* lock external mutex again */
> +	EnterCriticalSection(mutex);
> +
> +	return 0;
> +}
> +
> +int pthread_cond_signal(pthread_cond_t *cond)
> +{
> +	int have_waiters;
> +
> +	/* serialize access to waiters count */
> +	EnterCriticalSection(&cond->waiters_lock);
> +	have_waiters = cond->waiters > 0;
> +	LeaveCriticalSection(&cond->waiters_lock);

AFAIK, Win32 API assumes that reading LONG is always atomic, so
the critical section is not really necesary here, but you need
to declare 'waiters' as 'volatile':

> + */
> +typedef struct {
> +	LONG waiters;

	volatile LONG waiters;

> +	CRITICAL_SECTION waiters_lock;
> +	HANDLE sema;
> +} pthread_cond_t;
> +


Dmitry
