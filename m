From: Jim Meyering <jim@meyering.net>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 22:24:40 +0200
Message-ID: <87zkgoakfr.fsf@rho.meyering.net>
References: <20111024201153.GA1647@x4.trippels.de>
	<201110251800.28054.trast@student.ethz.ch>
	<87sjmhauyo.fsf@rho.meyering.net>
	<201110251854.43369.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	<git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 25 22:24:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RInYO-0000li-An
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 22:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab1JYUYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 16:24:51 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38276 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213Ab1JYUYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 16:24:50 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E3269D481EF
	for <git@vger.kernel.org>; Tue, 25 Oct 2011 22:24:42 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 175D16008E;
	Tue, 25 Oct 2011 22:24:41 +0200 (CEST)
In-Reply-To: <201110251854.43369.trast@student.ethz.ch> (Thomas Rast's message
	of "Tue, 25 Oct 2011 18:54:43 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184236>

Thomas Rast wrote:
...
>> The real problem seems to be in glibc, with its addition of
>> the "leaf" attribute to those synchronization primitives:
>>
>>   http://bugzilla.redhat.com/747377#c22
>
> Aha.  Glad you found it :-)
>
> Meanwhile I read
>
>   http://www.hpl.hp.com/techreports/2004/HPL-2004-209.html
>
> which discusses a similar issue in section 4.3, but is very
> interesting on its own.  It's funny how it says
>
>   We know of at least three optimizing compilers (two of them
>   production compilers) that performed this transformation at some
>   point during their lifetime; usually at least partially reversing
>   the decision when the implications on multi-threaded code became
>   known.
>
> I guess that would be four now if it was literally the same problem.

Yep.  For those not following the BZ comments at the about URL,
POSIX is quite clear.  Quoting from
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_11:

    The following functions synchronize memory with respect to other threads:

        fork
        pthread_barrier_wait
        pthread_cond_broadcast
        pthread_cond_signal
        pthread_cond_timedwait
        pthread_cond_wait
        pthread_create
        pthread_join
        pthread_mutex_lock
        pthread_mutex_timedlock
        pthread_mutex_trylock
        pthread_mutex_unlock
        pthread_spin_lock
        pthread_spin_trylock
        pthread_spin_unlock
        pthread_rwlock_rdlock
        pthread_rwlock_timedrdlock
        pthread_rwlock_timedwrlock
        pthread_rwlock_tryrdlock
        pthread_rwlock_trywrlock
        pthread_rwlock_unlock
        pthread_rwlock_wrlock
        sem_post
        sem_timedwait
        sem_trywait
        sem_wait
        semctl
        semop
        wait
        waitpid

glibc's addition of the leaf attribute to any of those
appears to make gcc violate that.
