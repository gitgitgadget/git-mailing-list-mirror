From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 23:44:47 -0400
Message-ID: <CAGZ=bqJ7k5h_-62M3y-Jype4a7mOTe+FxeU13JreGj0mOnSRSg@mail.gmail.com>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
 <4EA6D594.90402@viscovery.net> <CABPQNSZ8wesy-px-n1LYbVwFT3gBNcrHfe+_553sinTferqsog@mail.gmail.com>
 <4EA716FC.2010804@kdbg.org> <CABPQNSY6-j7iNagsJc3WKVZ94=yZHdfBswA-v0XY7vH+RxyjYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 26 05:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIuSi-0006nU-Ei
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 05:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab1JZDpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 23:45:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59699 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668Ab1JZDpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 23:45:07 -0400
Received: by ywm3 with SMTP id 3so1157067ywm.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 20:45:07 -0700 (PDT)
Received: by 10.68.72.104 with SMTP id c8mr34078799pbv.34.1319600707101; Tue,
 25 Oct 2011 20:45:07 -0700 (PDT)
Received: by 10.142.77.10 with HTTP; Tue, 25 Oct 2011 20:44:47 -0700 (PDT)
In-Reply-To: <CABPQNSY6-j7iNagsJc3WKVZ94=yZHdfBswA-v0XY7vH+RxyjYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184246>

On Tue, Oct 25, 2011 at 16:51, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Tue, Oct 25, 2011 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 25.10.2011 17:42, schrieb Erik Faye-Lund:
>>> On Tue, Oct 25, 2011 at 5:28 PM, Johannes Sixt <j.sixt@viscovery.ne=
t> wrote:
>>>> Am 10/25/2011 16:55, schrieb Erik Faye-Lund:
>>>>> +int pthread_mutex_lock(pthread_mutex_t *mutex)
>>>>> +{
>>>>> + =C2=A0 =C2=A0 if (mutex->autoinit) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (InterlockedCompar=
eExchange(&mutex->autoinit, -1, 1) !=3D -1) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pthread_mutex_init(mutex, NULL);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mutex->autoinit =3D 0;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 while (mutex->autoinit !=3D 0)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; /* wait for other thread */
>>>>> + =C2=A0 =C2=A0 }
>>>>
>>>> The double-checked locking idiom. Very suspicious. Can you explain=
 why it
>>>> works in this case? Why are no Interlocked functions needed for th=
e other
>>>> accesses of autoinit? ("It is volatile" is the wrong answer to thi=
s last
>>>> question, BTW.)
>>>
>>> I agree that it should look a bit suspicious; I'm generally skeptic=
al
>>> whenever I see 'volatile' in threading-code myself. But I think it'=
s
>>> the right answer in this case. "volatile" means that the compiler
>>> cannot optimize away accesses, which is sufficient in this case.
>>
>> No, it is not, and it took me a train ride to see what's wrong. It h=
as
>> nothing to do with autoinit, but with all the other memory locations
>> that are written. See here, with pthread_mutex_init() inlined:
>>
>> =C2=A0if (mutex->autoinit) {
>>
>> Assume two threads enter this block.
>>
>> =C2=A0 =C2=A0 if (InterlockedCompareExchange(&mutex->autoinit, -1, 1=
) !=3D -1) {
>>
>> Only one thread, A, say on CPU A, will enter this block.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0InitializeCriticalSection(&mutex->cs);
>>
>> Thread A writes some values. Note that there are no memory barriers
>> involved here. Not that I know of or that they would be documented.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex->autoinit =3D 0;
>>
>> And it writes another one. Thread A continues below to contend for t=
he
>> mutex it just initialized.
>>
>> =C2=A0 =C2=A0 } else
>>
>> Meanwhile, thread B, say on CPU B, spins in this loop:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (mutex->autoinit !=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; /* wait for other thread */
>>
>> When thread B arrives here, it sees the value of autoinit that threa=
d A
>> has written above.
>>
>> HOWEVER, when it continues, there is NO [*] guarantee that it will a=
lso
>> see the values that InitializeCriticalSection() has written, because
>> there were no memory barriers involved. When it continues, there is =
a
>> chance that it calls EnterCriticalSection() with uninitialized value=
s!
>>
>
> Thanks for pointing this out, I completely forgot about write re-orde=
ring.
>
> This is indeed a problem. So, shouldn't replacing "mutex->autoinit =3D
> 0;" with "InterlockedExchange(&mutex->autoinit, 0)" solve the problem=
?
> InterlockedExchange generates a full memory barrier:
> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683590(v=3D=
vs.85).aspx

No, I'm afraid that won't solve the issue (at least in GCC, not sure ab=
out MSVC)

A write barrier in one thread is only effective if it is paired with a
read barrier in the other thread.

Since there's no read barrier in the "while(mutex->autoinit !=3D 0)",
you don't have any guaranteed ordering.

I guess if MSVC assumes that volatile reads imply barriers then it migh=
t work...

Cheers,
Kyle Moffett

--=20
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
