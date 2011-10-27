From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Thu, 27 Oct 2011 19:20:40 -0400
Message-ID: <CAGZ=bqKA7P_FJz447AZA5HjWdghKnZqAWGuKAuvjsGp5bAGC1w@mail.gmail.com>
References: <CAGZ=bqJ7k5h_-62M3y-Jype4a7mOTe+FxeU13JreGj0mOnSRSg@mail.gmail.com>
 <CABPQNSY9LdqOK=1nN_61ZRMv-ieXzSDYgNsQe0w21RAOw_D7yA@mail.gmail.com> <20111028080033.57FC.B013761@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Atsushi Nakagawa <atnak@chejz.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 01:21:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJZGH-0000b3-5W
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 01:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1J0XVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 19:21:03 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39042 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab1J0XVC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 19:21:02 -0400
Received: by pzk36 with SMTP id 36so8959559pzk.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 16:21:01 -0700 (PDT)
Received: by 10.68.209.103 with SMTP id ml7mr958914pbc.17.1319757661089; Thu,
 27 Oct 2011 16:21:01 -0700 (PDT)
Received: by 10.143.168.21 with HTTP; Thu, 27 Oct 2011 16:20:40 -0700 (PDT)
In-Reply-To: <20111028080033.57FC.B013761@chejz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184330>

On Thu, Oct 27, 2011 at 19:00, Atsushi Nakagawa <atnak@chejz.com> wrote=
:
> Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Wed, Oct 26, 2011 at 5:44 AM, Kyle Moffett <kyle@moffetthome.net>=
 wrote:
>> > On Tue, Oct 25, 2011 at 16:51, Erik Faye-Lund <kusmabite@gmail.com=
> wrote:
>> >> Thanks for pointing this out, I completely forgot about write re-=
ordering.
>> >>
>> >> This is indeed a problem. So, shouldn't replacing "mutex->autoini=
t =3D
>> >> 0;" with "InterlockedExchange(&mutex->autoinit, 0)" solve the pro=
blem?
>> >> InterlockedExchange generates a full memory barrier:
>> >> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683590(=
v=3Dvs.85).aspx
>> >
>> > No, I'm afraid that won't solve the issue (at least in GCC, not su=
re about MSVC)
>> >
>> > A write barrier in one thread is only effective if it is paired wi=
th a
>> > read barrier in the other thread.
>> >
>> > Since there's no read barrier in the "while(mutex->autoinit !=3D 0=
)",
>> > you don't have any guaranteed ordering.
>
> Out of curiosity, where could re-ordering be a problem here? =C2=A0I'=
m
> thinking probably at "EnterCriticalSection(&mutex->cs)" and the conte=
nts
> of "mutex->cs" not being propagated to the waiting thread. =C2=A0Howe=
ver,
> shouldn't that be a non-problem, as far as compiler reordering goes,
> because it's an external function call and only the address of mutex-=
>cs
> is passed?
>
> The only other cause I could think of is if ordering at the CPU was
> somehow different (it could be if there're no special provisions for
> calling external functions) or if "InterlockedExchange(&mutex->autoin=
it,
> 0)" wasn't atomic in updating autoinit and doing the memory barrier.
>
> Either way, I couldn't vouch for the safety of the above logic withou=
t
> a memory barrier so this question is purely of an academical nature. =
:)
>
>> > I guess if MSVC assumes that volatile reads imply barriers then it=
 might work...
>>
>> OK, so I should probably do something like this instead?
>>
>> while (InterlockedCompareExchange(&mutex->autoinit, 0, 0) !=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 ; /* wait for other thread */
>
> Technically, assuming only the updating of "mutex->cs" is in question=
,
> the ICE should only be required once after exiting the loop...
>
> There's a question of the propagation of the value of "mutex->autoini=
t"
> itself, but my take is that the memory barrier on the writing thread
> will push out the updated value across all CPUs, thus preventing an
> infinite loop. =C2=A0The other factors, value caching and loop optimi=
zation
> by the compiler, should be prevented by the "volatile" keyword even w=
ith
> gcc or MSVC 2003.
>
>> I really appreciate getting some extra eyes on this, thanks.
>> Concurrent programming is not my strong-suit (as this exercise has
>> shown) ;)
>
> So would I. :)

Ok, so here's the race condition:

Thread1				Thread2
				/* Speculative prefetch */
				prefetch(*mutex);

if (mutex->autoinit) {
if (ICE(&mutex->autoinit, -1, 1) !=3D -1) {
/* Now mutex->autoinit =3D=3D -1 */
pthread_mutex_init(mutex, NULL);
/* This forces writes out to memory */
ICE(&mutex->autoinit, 0, -1);

				if (mutex->autoinit) {} /* false */
				/* No read barrier here */
				EnterCriticalSection(&mutex->cs);
				/* Use cached mutex->cs from earlier */

Even though you forced the memory write to be ordered in Thread 1 you
did not ensure that the read of autoinit occurred before the read of
mutex->cs in Thread 2.  If the first thing that EnterCriticalSection
does is follow a pointer or read a mutex key value in mutex->cs then
won't necessarily get the right answer.

The rule of memory barriers is the ALWAYS come in pairs.  This simple
example guarantees that Thread2 will read "tmp_a" =3D=3D 1 if it
previously read "tmp_b" =3D=3D 1, although getting "tmp_a" =3D=3D 1 and
"tmp_b" !=3D 1 is still possible.

Thread1:
a =3D 1;
write_barrier();
b =3D 1;

Thread2:
tmp_b =3D b;
read_barrier();
tmp_a =3D a;

I think there's a Documentation/memory-barriers.txt file in the kernel
source code with more helpful info.

Cheers,
Kyle Moffett

--=20
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
