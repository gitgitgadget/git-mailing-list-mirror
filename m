From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of
 Pthreads API
Date: Thu, 14 Jan 2010 08:12:41 +0300
Message-ID: <20100114051241.GF10586@dpotapov.dyndns.org>
References: <cover.1262895936.git.j6t@kdbg.org>
 <201001122213.38287.j6t@kdbg.org>
 <20100113125312.GD10586@dpotapov.dyndns.org>
 <201001131940.43868.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, msysgit <msysgit@googlegroups.com>,
	git@vger.kernel.org, "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVI2a-0001Jo-PH
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab0ANFOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 00:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306Ab0ANFOf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:14:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:64594 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab0ANFOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:14:35 -0500
Received: by fg-out-1718.google.com with SMTP id 19so35952fgg.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 21:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S0ztnVMFJcOhKJrrEPAiT92MtmmzDw0UB3PQ2RX4lx0=;
        b=qkjlkMDGkJ7aCL6236pJi67PMsdDfQ8rklYh5ltCV7/CSG+m0v+zBfxM5xgbZzFdxT
         DPmpxG56KGN90uucIHB/GDSIFin4k0uOqcRuUzzL2op5h7mwVi8ZY4MT4K3fNWMeNP91
         FyWqq0pkOYyE7c9TgiUovI5dRwCHmDjz2csxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F6VCHvfJjlhartyI4RvS60H7JGy9QGmy5wEVO6xQRT/BM5LWtEmmJanZoHeGlnpECv
         S35anMYAtvCXhmjT4QADIG6oaSgqDBmxp+8a2XZ5Jt/mNhll1v6XkD/tQ5xtIWiuZn7P
         7k6vEA/EHu54ZdH3JyKSKPCXV1i0dmiYkbY8U=
Received: by 10.87.40.20 with SMTP id s20mr367815fgj.60.1263446073419;
        Wed, 13 Jan 2010 21:14:33 -0800 (PST)
Received: from localhost (ppp91-77-224-149.pppoe.mtu-net.ru [91.77.224.149])
        by mx.google.com with ESMTPS id e20sm494356fga.17.2010.01.13.21.14.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 21:14:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001131940.43868.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136927>

On Wed, Jan 13, 2010 at 07:40:43PM +0100, Johannes Sixt wrote:
> On Mittwoch, 13. Januar 2010, Dmitry Potapov wrote:
> > On Tue, Jan 12, 2010 at 10:13:38PM +0100, Johannes Sixt wrote:
> > > In particular, it doesn't say that it is atomic WRT reads such as=
 we have
> > >
> > > here:
> > > > >> +     /* we're done waiting, so make sure we decrease waiter=
s count
> > > > >> */ +     EnterCriticalSection(&cond->waiters_lock);
> > > > >> +     --cond->waiters;
> > > > >> +     LeaveCriticalSection(&cond->waiters_lock);
> >
> > and these lines should be replaced with
> >
> >   InterlockedDecrement(&cond->waiters)
>=20
> Ah, yes, of course. I quoted the wrong section, sorry. By "atomic WRT=
 reads" I=20
> meant this snippet:
>=20
> >> +     EnterCriticalSection(&cond->waiters_lock);
> >> +     have_waiters =3D cond->waiters > 0;
> >> +     LeaveCriticalSection(&cond->waiters_lock);
>=20
> Is there "InterlockedRead()"? I suppose no, but I would get confirmat=
ion that=20
> a simple memory mov instruction is atomic WRT Interlocked* functions.

If I were writing Interlocked API, I would certainly add InterlockedRea=
d()
and InterlockedWrite() functions, but somehow Microsoft decided that th=
ese
functions are redundant. Instead, they provided the following comment:
"Simple reads and writes to properly-aligned 32-bit variables are atomi=
c
operations."
http://msdn.microsoft.com/en-us/library/ms684122%28VS.85%29.aspx

If an operation is atomic, it means that no matter what else is happeni=
ng
on the system, this operation will performed atomically WRT with any ot=
her.
So, yes, the 'mov' instruction is atomic WRT Interlocked functions, no
matter how Interlocked functions are implemented.

As to your concern about gcc doing something different. Let's take a lo=
ok
how atomic_read is implemented in the Linux kernel:

arch/alpha/include/asm/atomic.h:
#define atomic_read(v)		((v)->counter + 0)

arch/arm/include/asm/atomic.h
#define atomic_read(v)	((v)->counter)

arch/avr32/include/asm/atomic.h
#define atomic_read(v)		((v)->counter)

arch/blackfin/include/asm/atomic.h
#define atomic_read(v)	__raw_uncached_fetch_asm(&(v)->counter)

arch/cris/include/asm/atomic.h
#define atomic_read(v) ((v)->counter)

arch/frv/include/asm/atomic.h
#define atomic_read(v)		((v)->counter)

arch/h8300/include/asm/atomic.h
#define atomic_read(v)		((v)->counter)

arch/ia64/include/asm/atomic.h
#define atomic_read(v)		((v)->counter)

arch/m32r/include/asm/atomic.h
#define atomic_read(v)	((v)->counter)

arch/m68k/include/asm/atomic_mm.h
#define atomic_read(v)		((v)->counter)

arch/m68k/include/asm/atomic_no.h
#define atomic_read(v)		((v)->counter)

arch/mips/include/asm/atomic.h
#define atomic_read(v)		((v)->counter)

arch/mn10300/include/asm/atomic.h
#define atomic_read(v)	((v)->counter)

arch/parisc/include/asm/atomic.h
static __inline__ int atomic_read(const atomic_t *v)
{
	return v->counter;
}

arch/powerpc/include/asm/atomic.h
static __inline__ int atomic_read(const atomic_t *v)
{
	int t;

	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=3Dr"(t) : "m"(v->counter));

	return t;
}

arch/s390/include/asm/atomic.h
static inline int atomic_read(const atomic_t *v)
{
	barrier();
	return v->counter;
}

arch/sh/include/asm/atomic.h
#define atomic_read(v)		((v)->counter)

arch/sparc/include/asm/atomic_32.h
#define atomic_read(v)          ((v)->counter)

arch/sparc/include/asm/atomic_64.h
#define atomic_read(v)		((v)->counter)

arch/x86/include/asm/atomic_32.h
static inline int atomic_read(const atomic_t *v)
{
	return v->counter;
}

arch/x86/include/asm/atomic_64.h
static inline int atomic_read(const atomic_t *v)
{
	return v->counter;
}

arch/xtensa/include/asm/atomic.h
#define atomic_read(v)		((v)->counter)

=3D=3D=3D

You see, except PowerPC and s390, it is just 'mov' written in C.
Moreover, if you look at git log, you will see that using asm
for PowerPC is just a matter of optimization:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D9f0cbea0d8cc47801b853d3c61d0e17475b0cc89

As to s390, I have no idea why it uses barrier(), but I do not think
that Windows will ever run on this obsolete architecture, so I don't
even care to look at it closer...

In fact, ability to read and write some integer type is a requirement o=
f
the C standard (at least, for C99):

Section 7.14, paragraph 2:
"The type defined is
       sig_atomic_t
which is the (possibly volatile-qualified) integer type of an object
that can be accessed as an atomic entity, even in the presence of
asynchronous interrupts."

Section 7.18.3, paragraph 3:
"If sig_atomic_t (see 7.14) is defined as a signed integer type, the
value of SIG_ATOMIC_MIN shall be no greater than =E2=88=92127 and the v=
alue of
SIG_ATOMIC_MAX shall be no less than 127; otherwise, sig_atomic_t is
defined as an unsigned integer type, and the value of SIG_ATOMIC_MIN
shall be 0 and the value of SIG_ATOMIC_MAX shall be no less than 255."

So, for any architecture where you can use C, it should exist some
integer type that can be read and written atomically (though, it can
be as small as one byte).

=46inally, there is a paranoiac implementation of InterlockedRead(&foo)=
:

   result =3D InterlockedAdd(&foo, 0)

but, IMHO, it is pathetic...


I hope I have explained well enough why I can vouch that the above
assignment works atomically WRT any Interlock function.


Dmitry
