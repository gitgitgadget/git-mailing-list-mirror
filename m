From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 04 Nov 2009 12:23:15 +0100
Message-ID: <hcro74$fgb$1@ger.gmane.org>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 12:23:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dxs-0000Qo-OS
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 12:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbZKDLXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 06:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755387AbZKDLXh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 06:23:37 -0500
Received: from lo.gmane.org ([80.91.229.12]:47166 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212AbZKDLXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 06:23:37 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N5dxm-0000Nu-2q
	for git@vger.kernel.org; Wed, 04 Nov 2009 12:23:42 +0100
Received: from nat-pool-brq-t.redhat.com ([209.132.186.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 12:23:42 +0100
Received: from bonzini by nat-pool-brq-t.redhat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 12:23:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-pool-brq-t.redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132080>

The condition variable implementation seems more complicated than 
necessary.  The mutex can be used to protect access to cond->waiters, so 
waiters_lock is not necessary.  On the other hand, it seems to me that 
pthread_cond_signal should be the one that decrements the waiters count. 
  Otherwise, a loop like

	while (pthread_cond_signal (cond, mutex));

will fill the semaphore with signals and the waiters will get lots of 
spurious accesses.

static __inline int pthread_cond_wait(pthread_cond_t *cond,
                                       CRITICAL_SECTION *mutex)
{
	int ret = 0;

	/* the mutex protects access to waiters count */
	++cond->waiters;

	/*
	 * Unlock external mutex and wait for signal.
	 * NOTE: cond->waiters > 0 now.  If pthread_cond_signal
	 * is called after leaving mutex unlocked before we wait on
	 * semaphore, it will add a signal to the semaphore,
	 * and we'll happily go on with the wait.  This would not
	 * happen with an event, for example.
	 */
	LeaveCriticalSection(mutex);
	if (0 != WaitForSingleObject(cond->sema, INFINITE))
		ret = -1;

	EnterCriticalSection(mutex);
	return ret;
}

static __inline int pthread_cond_signal(pthread_cond_t *cond)
{
	/* the mutex protects access to waiters count */
	if (cond->waiters > 0) {
		--cond->waiters;
		return ReleaseSemaphore(cond->sema, 1, NULL) ? 0 : -1;
	} else
		return 0;
}

Paolo
