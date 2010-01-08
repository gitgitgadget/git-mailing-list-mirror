From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of
 Pthreads API
Date: Sat, 9 Jan 2010 00:37:11 +0300
Message-ID: <20100108213711.GA10586@dpotapov.dyndns.org>
References: <cover.1262895936.git.j6t@kdbg.org>
 <20100108033232.GA28263@dpotapov.dyndns.org>
 <40aa078e1001080258n67e0711sf4733a99d512bf1@mail.gmail.com>
 <201001082140.36717.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, msysgit <msysgit@googlegroups.com>,
	git@vger.kernel.org, "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 22:37:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTMWT-0003Cq-NI
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 22:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab0AHVhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 16:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458Ab0AHVhX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 16:37:23 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:55453 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0AHVhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 16:37:21 -0500
Received: by fxm25 with SMTP id 25so13056841fxm.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 13:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4si0aH1OQ21n/pGZfQbhPD6GXIc/hL00h4F3PEqLrVA=;
        b=sjtJgNL/z73oE5c8umObpjoIh0nHTqEjGcG3VyPVTWPadpHKSRHfR8FCDXernZZDmU
         FUJfF5ejuzwysO4PLdRC0vk20yvNLpo10q9ATaq3C8gYTO+zvORsGmPK+tN/biEa0tzb
         LlhcctL8G+XoHKP08l3VSAJJyyL4qB0p5g/T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XiFPiDXPYlAGvuuFDyviTGaL/e8bh4EjDA0+kIhV3qukKIdIUBJ4eh+VBc5MIKYV/z
         hRQZXfiOKmXEbM/Qn4MSA81s8wqhnfTQsigTZoy8pqR0pexZq6nB0idvm1C4AP/tpUq7
         RvsbIpLwLFyTRIEWyV+bSIYsdvj3+8u60ynVk=
Received: by 10.223.98.19 with SMTP id o19mr3332488fan.82.1262986639868;
        Fri, 08 Jan 2010 13:37:19 -0800 (PST)
Received: from localhost (ppp85-140-125-177.pppoe.mtu-net.ru [85.140.125.177])
        by mx.google.com with ESMTPS id 16sm8461688fxm.12.2010.01.08.13.37.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 13:37:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001082140.36717.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2010 at 09:40:36PM +0100, Johannes Sixt wrote:
> On Freitag, 8. Januar 2010, Erik Faye-Lund wrote:
> > On Fri, Jan 8, 2010 at 4:32 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > > AFAIK, Win32 API assumes that reading LONG is always atomic, so
> > > the critical section is not really necesary here, but you need
> > > to declare 'waiters' as 'volatile':
> >
> > "Simple reads and writes to properly-aligned 32-bit variables are
> > atomic operations."
> > http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx
> >
> > In other words: Yes, you are right.
> 
> Quite frankly, I do not want to stretch this statement to apply to the MinGW 
> compiler.

I am sure that MinGW compiler (i.e. gcc) will work fine as long as the
variable is marked as 'volatile'.

> The code in question is not performance critical anyway. I'd prefer 
> to leave it as is - it's undergone 2 months of testing already.

Well, it is a strong argument for not change anything, in general, but
the change is trivial -- instead of increment and decrementing some
varaible under a lock, it is increment/decrement using atomic operation.
There is no change to the logic, or anything that can have unexpected
side effects.

> Besides, 
> IMHO, it is much more readable the way it is written.

I _completely_ disagree with that. Using atomic operations is not only
more efficient, but it is more readable. Having an additional mutex just
to increment and decrement does not increase readability in any way but
only raises additional questions -- why do you need it here? Is it used
for something else besides incrementing and decrementing the variable,
which can be done atomically?


Dmitry
