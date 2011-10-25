From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 22:07:24 +0200
Message-ID: <4EA716FC.2010804@kdbg.org>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com> <4EA6D594.90402@viscovery.net> <CABPQNSZ8wesy-px-n1LYbVwFT3gBNcrHfe+_553sinTferqsog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 25 22:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RInHa-0001mm-3X
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 22:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab1JYUH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 16:07:29 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:10419 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751863Ab1JYUH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 16:07:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2F66E10011;
	Tue, 25 Oct 2011 22:07:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0DAA119F4A7;
	Tue, 25 Oct 2011 22:07:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <CABPQNSZ8wesy-px-n1LYbVwFT3gBNcrHfe+_553sinTferqsog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184235>

Am 25.10.2011 17:42, schrieb Erik Faye-Lund:
> On Tue, Oct 25, 2011 at 5:28 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 10/25/2011 16:55, schrieb Erik Faye-Lund:
>>> +int pthread_mutex_lock(pthread_mutex_t *mutex)
>>> +{
>>> +     if (mutex->autoinit) {
>>> +             if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) != -1) {
>>> +                     pthread_mutex_init(mutex, NULL);
>>> +                     mutex->autoinit = 0;
>>> +             } else
>>> +                     while (mutex->autoinit != 0)
>>> +                             ; /* wait for other thread */
>>> +     }
>>
>> The double-checked locking idiom. Very suspicious. Can you explain why it
>> works in this case? Why are no Interlocked functions needed for the other
>> accesses of autoinit? ("It is volatile" is the wrong answer to this last
>> question, BTW.)
> 
> I agree that it should look a bit suspicious; I'm generally skeptical
> whenever I see 'volatile' in threading-code myself. But I think it's
> the right answer in this case. "volatile" means that the compiler
> cannot optimize away accesses, which is sufficient in this case.

No, it is not, and it took me a train ride to see what's wrong. It has
nothing to do with autoinit, but with all the other memory locations
that are written. See here, with pthread_mutex_init() inlined:

  if (mutex->autoinit) {

Assume two threads enter this block.

     if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) != -1) {

Only one thread, A, say on CPU A, will enter this block.

        InitializeCriticalSection(&mutex->cs);

Thread A writes some values. Note that there are no memory barriers
involved here. Not that I know of or that they would be documented.

        mutex->autoinit = 0;

And it writes another one. Thread A continues below to contend for the
mutex it just initialized.

     } else

Meanwhile, thread B, say on CPU B, spins in this loop:

        while (mutex->autoinit != 0)
           ; /* wait for other thread */

When thread B arrives here, it sees the value of autoinit that thread A
has written above.

HOWEVER, when it continues, there is NO [*] guarantee that it will also
see the values that InitializeCriticalSection() has written, because
there were no memory barriers involved. When it continues, there is a
chance that it calls EnterCriticalSection() with uninitialized values!

  }


[*] If you compile this code with MSVC >= 2005, "No guarantee" is not
true, it's exactly the opposite because Microsoft extended the meaning
of 'volatile' to imply a memory barriere. This is *NOT* true for gcc in
general. It may be true for MinGW gcc, but I do not know.

> Basically, the thread that gets the original 1 returned from
> InterlockedCompareExchange is the only one who writes to
> mutex->autoinit. All other threads only read the value, and the
> volatile should make sure they actually do. Since all 32-bit reads and
> writes are atomic on Windows (see
> http://msdn.microsoft.com/en-us/library/windows/desktop/ms684122(v=vs.85).aspx
> "Simple reads and writes to properly-aligned 32-bit variables are
> atomic operations.") and mutex->autoinit is a LONG, this should be
> safe AFAICT. In fact, Windows specifically does not have any
> explicitly atomic writes exactly for this reason.

There is a difference between atomic and coherent: Yes, 32-bit accesses
are atomic, but they are not automatically coherent: A 32-bit value
written by one CPU is not instantly visible on the other CPU. 'volatile'
as per the C lanugage does not add any guarantees that would be of
interest here. OTOH, Microsoft's definition of 'volatile' does.

> The only ways mutex->autoinit can be updated is:
> - InterlockedCompareExchange compares it to 1, finds it's identical
> and inserts -1
> - intialization is done
> Both these updates happens from the same thread.
> 
> Yes, details like this should probably go into the commit message ;)

A comment in the function is preferred!

-- Hannes
