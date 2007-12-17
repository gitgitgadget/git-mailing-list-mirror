From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] threaded pack-objects: Use condition variables for thread communication.
Date: Mon, 17 Dec 2007 07:26:48 +0300
Message-ID: <20071217042648.GI14173@dpotapov.dyndns.org>
References: <200712160018.54171.johannes.sixt@telecom.at> <20071216120558.GA4999@xp.machine.xx> <200712161941.38109.johannes.sixt@telecom.at> <20071216190016.GC4999@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 05:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J47kM-0001aC-HF
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 05:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbXLQEiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 23:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbXLQEiG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 23:38:06 -0500
Received: from smtp01.mtu.ru ([62.5.255.48]:57257 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbXLQEiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 23:38:05 -0500
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Dec 2007 23:38:05 EST
Received: from dpotapov.dyndns.org (ppp85-140-169-191.pppoe.mtu-net.ru [85.140.169.191])
	by smtp01.mtu.ru (Postfix) with ESMTP id 76F8AAC5BB8;
	Mon, 17 Dec 2007 07:26:45 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1J47Z2-0007aF-6d; Mon, 17 Dec 2007 07:26:48 +0300
Content-Disposition: inline
In-Reply-To: <20071216190016.GC4999@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68507>

On Sun, Dec 16, 2007 at 08:00:16PM +0100, Peter Baumann wrote:
> On Sun, Dec 16, 2007 at 07:41:37PM +0100, Johannes Sixt wrote:
> > On Sunday 16 December 2007 13:05, Peter Baumann wrote:
> > > On Sun, Dec 16, 2007 at 12:18:53AM +0100, Johannes Sixt wrote:
> > > > +
> > > > +		progress_lock();
> > > > +		me->working = 0;
> > > > +		progress_unlock();
> > > > +		pthread_cond_signal(&progress_cond);
> > >
> > > Shouldn't the pthread_cond_signal be inside the lock?
> > > e.g. swap progress_unlock() with pthread_cond_signal(&progress_cond)
> > 
> > No, that's not necessary. Both ways are correct, but if it's outside the lock 
> > there is less contention on the mutex (because the waiting thread must 
> > acquire the mutex lock before it can return from pthread_cond_wait).
> > 
> 
> At least I was told otherwise and [1] backs my knowledge up. Are you
> really sure?
> 
> -Peter
> 
> http://docs.sun.com/app/docs/doc/806-5257/6je9h032r?a=view#sync-53686

The POSIX standard clearly says that usage of pthread_cond_signal ouside
of the mutex protection is allowed:

===
The pthread_cond_signal() or pthread_cond_broadcast() functions may be
called by a thread whether or not it currently owns the mutex that
threads calling pthread_cond_wait() or pthread_cond_timedwait() have
associated with the condition variable during their waits; however, if
predictable scheduling behaviour is required, then that mutex is locked
by the thread calling pthread_cond_signal() or pthread_cond_broadcast().
===
http://www.opengroup.org/onlinepubs/007908775/xsh/pthread_cond_signal.html

And the argumentation provided by Sun's manual:
> Otherwise, the condition variable could be signaled between the test
> of the associated condition and blocking in pthread_cond_wait(), which
> can cause an infinite wait.

sounds strange to me. Indeed the condition variable could be signaled
between the test and blocking, but the condition itself is false, so the
thread should be blocked anyway. The only effect of signalling outside
of the mutex protection is that the thread blocked on the condition
variable can be waken up while the associated condition is still false,
but it is not a problem.

As to what is more optimal, it is less clear. Because on one side,
signaling under the lock increases contention, but, on the other hand,
it avoids spurious wakeup. So, I suppose it could be implementation
specific.

Dmitry
