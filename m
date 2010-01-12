From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of  Pthreads API
Date: Tue, 12 Jan 2010 22:13:38 +0100
Message-ID: <201001122213.38287.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org> <20100108033232.GA28263@dpotapov.dyndns.org> <40aa078e1001080258n67e0711sf4733a99d512bf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	msysgit <msysgit@googlegroups.com>, git@vger.kernel.org,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 12 22:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUo4V-0003cP-5b
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 22:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab0ALVOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 16:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417Ab0ALVOe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 16:14:34 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:56026 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752384Ab0ALVOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 16:14:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 78D3810018;
	Tue, 12 Jan 2010 22:14:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 601F419F5EC;
	Tue, 12 Jan 2010 22:13:38 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001080258n67e0711sf4733a99d512bf1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136758>

On Freitag, 8. Januar 2010, Erik Faye-Lund wrote:
> On Fri, Jan 8, 2010 at 4:32 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > AFAIK, Win32 API assumes that reading LONG is always atomic, so
> > the critical section is not really necesary here, but you need
> > to declare 'waiters' as 'volatile':
>
> "Simple reads and writes to properly-aligned 32-bit variables are
> atomic operations."
> http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx

But then the next sentence is:

"However, access is not guaranteed to be synchronized. If two threads are 
reading and writing from the same variable, you cannot determine if one 
thread will perform its read operation before the other performs its write 
operation."

This goes without saying, IOW, those Microsofties don't know what they write, 
which makes the documentation a bit less trustworthy.

Nevertheless, I rewrote the code to use Interlocked* functions, and then read 
the documentation again. InterlockedIncrement reads, for example:

"... This function is atomic with respect to calls to other interlocked 
functions."

In particular, it doesn't say that it is atomic WRT reads such as we have 
here:

> >> +     /* we're done waiting, so make sure we decrease waiters count */
> >> +     EnterCriticalSection(&cond->waiters_lock);
> >> +     --cond->waiters;
> >> +     LeaveCriticalSection(&cond->waiters_lock);

I've no assembly-fu, but I could imagine that it does not matter, but I really 
would have confirmation from an x86 guru.

-- Hannes
