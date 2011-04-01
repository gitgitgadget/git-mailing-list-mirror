From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 22:13:23 +0200
Message-ID: <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104011927.03366.j6t@kdbg.org>
 <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
 <201104012142.22065.j6t@kdbg.org> <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
 <20110401200537.GA15778@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:13:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5kj7-00021b-HH
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab1DAUNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 16:13:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41315 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab1DAUNo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 16:13:44 -0400
Received: by fxm17 with SMTP id 17so2850277fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=bUNL+VKNnYSZ5Cjn2+Vx+XIhZmJAQi9ZPrRMRxe/k/8=;
        b=Wl6RE7Xy7YFp9fX+DUsFQFetNstulnhcQmTy5McgnmyAyRxmKG4gBOpvWfbtdZzZQ+
         Hzn6DO40C3uXlHFlGSVmYs96Yr+3+/1w1bLuwwm2LIbn3PoErC2UhwFH6L+6sHL/WzIf
         zahqg0V0Ss9VAqTN7dXOhsVisYpquDLIt8NQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=qle7dmzifbdwq1rdBCYNpHaR1qtcxaZtFTaJxm40eWS8gqceNKnpU4HPNsQKAWQXfK
         h+wbkXtv9BFyk9Dj3Bbodm8QU3tT45U8efS98TK923rOQ1q1BVSQ8sz8c8jjLVWVxbXH
         srRJKzsiI1AY6ASQKK57JDkgeeKxOCuZCST+k=
Received: by 10.223.35.147 with SMTP id p19mr4801859fad.13.1301688823084; Fri,
 01 Apr 2011 13:13:43 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 13:13:23 -0700 (PDT)
In-Reply-To: <20110401200537.GA15778@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170614>

On Fri, Apr 1, 2011 at 10:05 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 01, 2011 at 09:57:14PM +0200, Erik Faye-Lund wrote:
>
>> > But this does not help the case at hand in any way. How would you interrupt a
>> > thread that is blocked in ReadFile()? The point of pthread_cancel() is that
>> > it interrupts blocked system calls
>>
>> There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
>> Cancellation), so relying on that is undefined behavior.
>
> Eh? My pthreads(7) says that read() is required to be a cancellation
> point acrroding to POSIX. I didn't dig up the actual reference in the
> standard, though.

I don't understand where the implementor would get that from after
reading through it, but if there's something I've missed we can fix it
by replacing my pthread_cancel with this, no?

static inline int pthread_cancel(pthread_t thread)
{
	SetEvent(thread.cancel_event);
	CancelSynchronousIo(thread.handle);
}
