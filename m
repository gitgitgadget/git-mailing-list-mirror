From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 21:42:21 +0200
Message-ID: <201104012142.22065.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104011927.03366.j6t@kdbg.org> <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 21:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5kEu-0004lR-5T
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 21:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab1DATm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 15:42:29 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:57287 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753658Ab1DATm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 15:42:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AB5A72C4004;
	Fri,  1 Apr 2011 21:42:22 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2C74319F5DA;
	Fri,  1 Apr 2011 21:42:22 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170611>

On Freitag, 1. April 2011, Erik Faye-Lund wrote:
> On Fri, Apr 1, 2011 at 7:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > On Freitag, 1. April 2011, Erik Faye-Lund wrote:
> >> OK, I've read up on thread-cancellation, and this code seems correct.
> >> pthread_cancel doesn't kill the thread right away, it just signals a
> >> cancellation-event, which is checked for at certain
> >> cancellation-points. A lot of the CRT functions are defined as
> >> cancellation points, so it'll be a matter for us Win32-guys to
> >> implement pthread_testcancel() and inject that into the
> >> function-wrappers of the CRT functions that are marked as
> >> cancellation-points.
> >
> > That's not going to happen. We cannot implement pthread_cancel() on
> > Windows because it would have to be able to interrupt blocking system
> > calls. (TerminateThread() is a no-no, given all the caveats about leaking
> > system resources that are mentioned in the manual.)
>
> Did you read my suggestion?

Yes, I did.

> I was talking about implementing 
> cancellation-points, just like on other platforms. This should not
> lead to TerminateThread, but instead a conditional ExitThread from the
> thread in question.
>
> Something like this (I've only added a cancellation-point at close,
> just to illustrate what I mean):

But this does not help the case at hand in any way. How would you interrupt a 
thread that is blocked in ReadFile()? The point of pthread_cancel() is that 
it interrupts blocked system calls, something that you cannot achieve if you 
want to keep using MS's C runtime.

-- Hannes
