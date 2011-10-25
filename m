From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 22:51:19 +0200
Message-ID: <CABPQNSY6-j7iNagsJc3WKVZ94=yZHdfBswA-v0XY7vH+RxyjYQ@mail.gmail.com>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
 <4EA6D594.90402@viscovery.net> <CABPQNSZ8wesy-px-n1LYbVwFT3gBNcrHfe+_553sinTferqsog@mail.gmail.com>
 <4EA716FC.2010804@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 22:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RInyj-0003gn-Df
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 22:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab1JYUwD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 16:52:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55471 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab1JYUwC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 16:52:02 -0400
Received: by vws1 with SMTP id 1so883397vws.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ZFYu851HET65Od4vwmue7TLHYFDtzEx+r9jm3JkkXxM=;
        b=i9/ZoeSqgBQNja1A9blShS9z2TyC+emMauGDyuIFMpWxOwtmH/EZMIBs6JgDGQlDzP
         zEUWgiy2B1yM3GJJveOIgSQFJlB0e4iUR/QdRmrRy7XFiQ7WnNK/Xigvb7PfW83uUQMH
         5ku4MgVdOphjkQRyR2+KEF3yO0ZjSrY39QvZE=
Received: by 10.52.38.99 with SMTP id f3mr18358001vdk.117.1319575920351; Tue,
 25 Oct 2011 13:52:00 -0700 (PDT)
Received: by 10.220.193.140 with HTTP; Tue, 25 Oct 2011 13:51:19 -0700 (PDT)
In-Reply-To: <4EA716FC.2010804@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184238>

On Tue, Oct 25, 2011 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 25.10.2011 17:42, schrieb Erik Faye-Lund:
>> On Tue, Oct 25, 2011 at 5:28 PM, Johannes Sixt <j.sixt@viscovery.net=
> wrote:
>>> Am 10/25/2011 16:55, schrieb Erik Faye-Lund:
>>>> +int pthread_mutex_lock(pthread_mutex_t *mutex)
>>>> +{
>>>> + =A0 =A0 if (mutex->autoinit) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (InterlockedCompareExchange(&mutex->a=
utoinit, -1, 1) !=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pthread_mutex_init(mutex=
, NULL);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex->autoinit =3D 0;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (mutex->autoinit !=
=3D 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* wai=
t for other thread */
>>>> + =A0 =A0 }
>>>
>>> The double-checked locking idiom. Very suspicious. Can you explain =
why it
>>> works in this case? Why are no Interlocked functions needed for the=
 other
>>> accesses of autoinit? ("It is volatile" is the wrong answer to this=
 last
>>> question, BTW.)
>>
>> I agree that it should look a bit suspicious; I'm generally skeptica=
l
>> whenever I see 'volatile' in threading-code myself. But I think it's
>> the right answer in this case. "volatile" means that the compiler
>> cannot optimize away accesses, which is sufficient in this case.
>
> No, it is not, and it took me a train ride to see what's wrong. It ha=
s
> nothing to do with autoinit, but with all the other memory locations
> that are written. See here, with pthread_mutex_init() inlined:
>
> =A0if (mutex->autoinit) {
>
> Assume two threads enter this block.
>
> =A0 =A0 if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) !=3D =
-1) {
>
> Only one thread, A, say on CPU A, will enter this block.
>
> =A0 =A0 =A0 =A0InitializeCriticalSection(&mutex->cs);
>
> Thread A writes some values. Note that there are no memory barriers
> involved here. Not that I know of or that they would be documented.
>
> =A0 =A0 =A0 =A0mutex->autoinit =3D 0;
>
> And it writes another one. Thread A continues below to contend for th=
e
> mutex it just initialized.
>
> =A0 =A0 } else
>
> Meanwhile, thread B, say on CPU B, spins in this loop:
>
> =A0 =A0 =A0 =A0while (mutex->autoinit !=3D 0)
> =A0 =A0 =A0 =A0 =A0 ; /* wait for other thread */
>
> When thread B arrives here, it sees the value of autoinit that thread=
 A
> has written above.
>
> HOWEVER, when it continues, there is NO [*] guarantee that it will al=
so
> see the values that InitializeCriticalSection() has written, because
> there were no memory barriers involved. When it continues, there is a
> chance that it calls EnterCriticalSection() with uninitialized values=
!
>

Thanks for pointing this out, I completely forgot about write re-orderi=
ng.

This is indeed a problem. So, shouldn't replacing "mutex->autoinit =3D
0;" with "InterlockedExchange(&mutex->autoinit, 0)" solve the problem?
InterlockedExchange generates a full memory barrier:
http://msdn.microsoft.com/en-us/library/windows/desktop/ms683590(v=3Dvs=
=2E85).aspx

> =A0}
>
>
> [*] If you compile this code with MSVC >=3D 2005, "No guarantee" is n=
ot
> true, it's exactly the opposite because Microsoft extended the meanin=
g
> of 'volatile' to imply a memory barriere.

Do you have a source for this? I'm not saying it isn't true, I just
never heard of this, and would like to read up on it :)

> This is *NOT* true for gcc in
> general. It may be true for MinGW gcc, but I do not know.
>
>> Basically, the thread that gets the original 1 returned from
>> InterlockedCompareExchange is the only one who writes to
>> mutex->autoinit. All other threads only read the value, and the
>> volatile should make sure they actually do. Since all 32-bit reads a=
nd
>> writes are atomic on Windows (see
>> http://msdn.microsoft.com/en-us/library/windows/desktop/ms684122(v=3D=
vs.85).aspx
>> "Simple reads and writes to properly-aligned 32-bit variables are
>> atomic operations.") and mutex->autoinit is a LONG, this should be
>> safe AFAICT. In fact, Windows specifically does not have any
>> explicitly atomic writes exactly for this reason.
>
> There is a difference between atomic and coherent: Yes, 32-bit access=
es
> are atomic, but they are not automatically coherent: A 32-bit value
> written by one CPU is not instantly visible on the other CPU. 'volati=
le'
> as per the C lanugage does not add any guarantees that would be of
> interest here. OTOH, Microsoft's definition of 'volatile' does.
>

I never meant to imply this either, I simply forgot about write re-orde=
ring ;)

>> The only ways mutex->autoinit can be updated is:
>> - InterlockedCompareExchange compares it to 1, finds it's identical
>> and inserts -1
>> - intialization is done
>> Both these updates happens from the same thread.
>>
>> Yes, details like this should probably go into the commit message ;)
>
> A comment in the function is preferred!
>

Yes, good point. This is code that looks dangerous (and in this case
potentially was - hopefully eventual future iteration won't be), and
should of course be documented inline...
