From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Fri, 28 Oct 2011 08:00:37 +0900
Message-ID: <20111028080033.57FC.B013761@chejz.com>
References: <CAGZ=bqJ7k5h_-62M3y-Jype4a7mOTe+FxeU13JreGj0mOnSRSg@mail.gmail.com> <CABPQNSY9LdqOK=1nN_61ZRMv-ieXzSDYgNsQe0w21RAOw_D7yA@mail.gmail.com>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <kyle@moffetthome.net>, Johannes Sixt <j6t@kdbg.org>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 28 01:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJYwL-0002wR-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 01:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578Ab1J0XAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 19:00:45 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49869 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab1J0XAo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 19:00:44 -0400
Received: by qyk4 with SMTP id 4so1423728qyk.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 16:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:cc:reply-to:in-reply-to:references:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer;
        bh=Umf1R/kl4VtPQWze4AoBufuwbKlPPc+4yBeyqtMDTDI=;
        b=SejCzDoM1AkuD35EwllfiCWU7ZKcNg4xf8n0QRSlWnpxQ61pjNi0TPgdrTfuKtJLf0
         +7D/lG07sYw25ZaqjBf0YmxbMatvrbrwgZbZe8eKDpYyyL7zwBrLNXud6B3UX09jew3r
         3Med3mMFkc6uKxnIW2nTPKwON/snBYSGUxJ3A=
Received: by 10.68.28.3 with SMTP id x3mr626037pbg.132.1319756442758;
        Thu, 27 Oct 2011 16:00:42 -0700 (PDT)
Received: from [127.0.0.1] (KD113155065059.ppp-bb.dion.ne.jp. [113.155.65.59])
        by mx.google.com with ESMTPS id y4sm18334933pbe.4.2011.10.27.16.00.38
        (version=SSLv3 cipher=OTHER);
        Thu, 27 Oct 2011 16:00:39 -0700 (PDT)
In-Reply-To: <CABPQNSY9LdqOK=1nN_61ZRMv-ieXzSDYgNsQe0w21RAOw_D7yA@mail.gmail.com>
X-Mailer: Becky! ver. 2.57.01 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184329>

Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Wed, Oct 26, 2011 at 5:44 AM, Kyle Moffett <kyle@moffetthome.net> wrote:
> > On Tue, Oct 25, 2011 at 16:51, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >> On Tue, Oct 25, 2011 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> >>> Am 25.10.2011 17:42, schrieb Erik Faye-Lund:
> >>>> On Tue, Oct 25, 2011 at 5:28 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> >>>>> Am 10/25/2011 16:55, schrieb Erik Faye-Lund:
> >>>>>> +int pthread_mutex_lock(pthread_mutex_t *mutex)
> >>>>>> +{
> >>>>>> + [snip]
> >>>>>
> >>>>> The double-checked locking idiom. Very suspicious. Can you explain why it
> >>> [snip]
> >>>
> >>>  if (mutex->autoinit) {
> >>>
> >>> Assume two threads enter this block.
> >>>
> >>>     if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) != -1) {
> >>>
> >>> Only one thread, A, say on CPU A, will enter this block.
> >>>
> >>>        InitializeCriticalSection(&mutex->cs);
> >>>
> >>> Thread A writes some values. Note that there are no memory barriers
> >>> involved here. Not that I know of or that they would be documented.
> >>>
> >>>        mutex->autoinit = 0;
> >>>
> >>> And it writes another one. Thread A continues below to contend for the
> >>> mutex it just initialized.
> >>>
> >>>     } else
> >>>
> >>> Meanwhile, thread B, say on CPU B, spins in this loop:
> >>>
> >>>        while (mutex->autoinit != 0)
> >>>           ; /* wait for other thread */
> >>>
> >>> When thread B arrives here, it sees the value of autoinit that thread A
> >>> has written above.
> >>>
> >>> [snip]
> >>>
> >>
> >> Thanks for pointing this out, I completely forgot about write re-ordering.
> >>
> >> This is indeed a problem. So, shouldn't replacing "mutex->autoinit =
> >> 0;" with "InterlockedExchange(&mutex->autoinit, 0)" solve the problem?
> >> InterlockedExchange generates a full memory barrier:
> >> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683590(v=vs.85).aspx
> >
> > No, I'm afraid that won't solve the issue (at least in GCC, not sure about MSVC)
> >
> > A write barrier in one thread is only effective if it is paired with a
> > read barrier in the other thread.
> >
> > Since there's no read barrier in the "while(mutex->autoinit != 0)",
> > you don't have any guaranteed ordering.

Out of curiosity, where could re-ordering be a problem here?  I'm
thinking probably at "EnterCriticalSection(&mutex->cs)" and the contents
of "mutex->cs" not being propagated to the waiting thread.  However,
shouldn't that be a non-problem, as far as compiler reordering goes,
because it's an external function call and only the address of mutex->cs
is passed?

The only other cause I could think of is if ordering at the CPU was
somehow different (it could be if there're no special provisions for
calling external functions) or if "InterlockedExchange(&mutex->autoinit,
0)" wasn't atomic in updating autoinit and doing the memory barrier.

Either way, I couldn't vouch for the safety of the above logic without
a memory barrier so this question is purely of an academical nature. :)

> > I guess if MSVC assumes that volatile reads imply barriers then it might work...
> 
> OK, so I should probably do something like this instead?
> 
> while (InterlockedCompareExchange(&mutex->autoinit, 0, 0) != 0)
> 	; /* wait for other thread */

Technically, assuming only the updating of "mutex->cs" is in question,
the ICE should only be required once after exiting the loop...

There's a question of the propagation of the value of "mutex->autoinit"
itself, but my take is that the memory barrier on the writing thread
will push out the updated value across all CPUs, thus preventing an
infinite loop.  The other factors, value caching and loop optimization
by the compiler, should be prevented by the "volatile" keyword even with
gcc or MSVC 2003.

> I really appreciate getting some extra eyes on this, thanks.
> Concurrent programming is not my strong-suit (as this exercise has
> shown) ;)

So would I. :)

-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
