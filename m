From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFT PATCH 1/2] win32: optimize condition variable implementation
Date: Tue, 08 Jun 2010 18:16:02 +0200
Message-ID: <4C0E6CC2.1080605@viscovery.net>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org> <1275917892-16437-2-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:16:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1TJ-0004Ev-4D
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab0FHQQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:16:07 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:56347 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754638Ab0FHQQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:16:06 -0400
X-Greylist: delayed 1189 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2010 12:16:06 EDT
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B887A1001D;
	Tue,  8 Jun 2010 18:16:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1275917892-16437-2-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148684>

Am 07.06.2010 15:38, schrieb Paolo Bonzini:
>   int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
>   {
> -	int last_waiter;
> +	int num_waiters;
>
> -	EnterCriticalSection(&cond->waiters_lock);
> +	/*
> +	 * This access is protected under the mutex.
> +	 */
>   	cond->waiters++;
> -	LeaveCriticalSection(&cond->waiters_lock);
>
>   	/*
>   	 * Unlock external mutex and wait for signal.
> @@ -105,17 +104,17 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
>   	WaitForSingleObject(cond->sema, INFINITE);
>
>   	/*
> -	 * Decrease waiters count. If we are the last waiter, then we must
> +	 * Decrease waiters count.  The mutex prevents concurrent increments,
> +	 * so doing this decrement atomically is enough.
> +	 */
> +	num_waiters = InterlockedDecrement(&cond->waiters);
> +
> +	/* If we are the last waiter, then we must
>   	 * notify the broadcasting thread that it can continue.
>   	 * But if we continued due to cond_signal, we do not have to do that
>   	 * because the signaling thread knows that only one waiter continued.
>   	 */
> -	EnterCriticalSection(&cond->waiters_lock);
> -	cond->waiters--;
> -	last_waiter = cond->was_broadcast&&  cond->waiters == 0;
> -	LeaveCriticalSection(&cond->waiters_lock);
> -
> -	if (last_waiter) {
> +	if (num_waiters == 0&&  cond->was_broadcast) {
>   		/*
>   		 * cond_broadcast was issued while mutex was held. This means
>   		 * that all other waiters have continued, but are contending

This is not correct. While it is not possible that two threads increment 
waiters at the same time due to the external mutex, it is still possible 
that on thread increments, and a different one decrements. You lost all 
provisions to avoid that.

Furthermore, waiters_lock not only protects waiters, but also the combined 
state of waiters and was_broadcast. You break this protection. See also here:

> @@ -168,12 +168,18 @@ int pthread_cond_signal(pthread_cond_t *cond)
>    */
>   int pthread_cond_broadcast(pthread_cond_t *cond)
>   {
> -	EnterCriticalSection(&cond->waiters_lock);
> +	/*
> +	 * As in pthread_cond_signal, access to cond->waiters and
> +	 * cond->was_broadcast is locked via the external mutex.
> +	 */
>
>   	if ((cond->was_broadcast = cond->waiters>  0)) {
> +		BOOLEAN result;
>   		/* wake up all waiters */
> -		ReleaseSemaphore(cond->sema, cond->waiters, NULL);
> -		LeaveCriticalSection(&cond->waiters_lock);
> +		result = ReleaseSemaphore(cond->sema, cond->waiters, NULL);
> +		if (!result)
> +			return err_win_to_posix(GetLastError());
> +
>   		/*
>   		 * At this point all waiters continue. Each one takes its
>   		 * slice of the semaphor. Now it's our turn to wait: Since

-- Hannes
