From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of
 Pthreads API
Date: Wed, 13 Jan 2010 15:53:12 +0300
Message-ID: <20100113125312.GD10586@dpotapov.dyndns.org>
References: <cover.1262895936.git.j6t@kdbg.org>
 <20100108033232.GA28263@dpotapov.dyndns.org>
 <40aa078e1001080258n67e0711sf4733a99d512bf1@mail.gmail.com>
 <201001122213.38287.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, msysgit <msysgit@googlegroups.com>,
	git@vger.kernel.org, "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:55:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV2kX-0005qN-7q
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 13:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab0AMMy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 07:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530Ab0AMMy4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 07:54:56 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:58114 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab0AMMyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 07:54:55 -0500
Received: by fg-out-1718.google.com with SMTP id 22so187153fge.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kwdt2jCa1BRKxFrIwj/WiL8H5KvUYUcAtfgAzfzqUPE=;
        b=ZRHVw/I8Quz1OAOlkvtBvlw9X7ZEm32V68yliWBuo/qd/FQmN3yqK5MqdPt8jsozw9
         IsYUcI2keY7fNobxHHboB4EzQyMyZ8cf4Got3mVl58TvVm2yKf2rsJ45t7cF7PFRf9n+
         kb/L5EOnA3rD9ayUT1hgiMRge3sCGwlevHvRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JWlgrjTxfX9nWoFZg7pU0iZUaXBsXcxlzWjkn+m8lVBDnkPTJTC9WOs0oCDg+gIkPa
         03yiH6wJJ8aId0Vj3azk404ptdzHSZ/iOOcLDsOfo3rIVgi/USD8uAaABUqfVyBRympr
         bb3zp5xhfbSu9/R9d3q9M0dSpZJ7VdS3uRIyI=
Received: by 10.87.55.24 with SMTP id h24mr5070132fgk.1.1263387294052;
        Wed, 13 Jan 2010 04:54:54 -0800 (PST)
Received: from localhost (ppp91-77-224-149.pppoe.mtu-net.ru [91.77.224.149])
        by mx.google.com with ESMTPS id e3sm4642498fga.26.2010.01.13.04.54.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 04:54:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001122213.38287.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136813>

On Tue, Jan 12, 2010 at 10:13:38PM +0100, Johannes Sixt wrote:
> On Freitag, 8. Januar 2010, Erik Faye-Lund wrote:
> > On Fri, Jan 8, 2010 at 4:32 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > > AFAIK, Win32 API assumes that reading LONG is always atomic, so
> > > the critical section is not really necesary here, but you need
> > > to declare 'waiters' as 'volatile':
> >
> > "Simple reads and writes to properly-aligned 32-bit variables are
> > atomic operations."
> > http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx
> 
> But then the next sentence is:
> 
> "However, access is not guaranteed to be synchronized. If two threads are 
> reading and writing from the same variable, you cannot determine if one 
> thread will perform its read operation before the other performs its write 
> operation."
> 
> This goes without saying, IOW, those Microsofties don't know what they write, 
> which makes the documentation a bit less trustworthy.

The fact that Microsoft documentation is not written by brightest people
in the world is well known...

> 
> Nevertheless, I rewrote the code to use Interlocked* functions, and then read 
> the documentation again. InterlockedIncrement reads, for example:
> 
> "... This function is atomic with respect to calls to other interlocked 
> functions."

I have no clue what the author meant here. Perhaps Microsoft wanted to
reserve the right to implement Interlocked functions using an internal
lock on those architectures that do not have atomic operations. (For
instance, ARMv5 does not have atomic operations).

But any sane implementation of a critical section primitive requires
some operation that is atomic with respect to the user space (or you
kill the performance by calling some syscall in noncontentious case).
For instance, the Linux kernel provides this possibility by providing
__kernel_cmpxchg for ARM, which can be used to implement all other
synchronization primitives such mutexes and conditions. (Or on some
small MMU-less embedded system, disabling interrupts or the scheduler
lock is used). So, any sane implementation should atomic not only in
respect to other Interlock functions but also other synchronization
primitives.

In any case, on x86, it is implemented as _InterlockedIncrement, which
is a built-in function that generates the appropriate assembler instruction.

> 
> In particular, it doesn't say that it is atomic WRT reads such as we have 
> here:
> 
> > >> +     /* we're done waiting, so make sure we decrease waiters count */
> > >> +     EnterCriticalSection(&cond->waiters_lock);
> > >> +     --cond->waiters;
> > >> +     LeaveCriticalSection(&cond->waiters_lock);

and these lines should be replaced with

  InterlockedDecrement(&cond->waiters)

so it will be safe even on utterly idiotic implementation of Interlocked
functions that uses some internal lock; and as I said earlier on x86,
Interlocked functions are translated in appropriate assembler instructions.


Dmitry
