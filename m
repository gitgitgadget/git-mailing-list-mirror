From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 22:34:30 +0200
Message-ID: <AANLkTinr+_9tHj8neHOxZMtKRMQ3LSVzqCPpjFup2hy=@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104011927.03366.j6t@kdbg.org>
 <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
 <201104012142.22065.j6t@kdbg.org> <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
 <20110401200537.GA15778@sigill.intra.peff.net> <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com>
 <20110401201714.GA16501@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:34:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5l3Z-0001AX-Uc
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab1DAUew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 16:34:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48022 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab1DAUev (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 16:34:51 -0400
Received: by fxm17 with SMTP id 17so2861692fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Vegk9KOCvkXa0mQzJKns771MV0eJ+BEbUIExyVyH9Js=;
        b=taagyF/xvnjTmU+KEVNn8w/5OTLDZJQZcF87cN652df7vfOpK+tWde6WCSIxoWx7n3
         rgaZ8ojg6KpJBoPR8T2bYOKjxluoSwe9ENMqie1UGPHBy4VbU+1KwTbFbdIugr/w9HFa
         rRe1sehC7Vj4rg4KM0FfV6BMrc1sTN9GP1hJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=odwnrqbwITs7kZQNZj1kfuc+O88Br4I+rjEY77wSgN8sKKIX9BqMD7bwyWgfrCg45m
         Y8WafHGa5w9kHP4wQrj7Le0/0p3CYXOpRfPgfD60iEaCKKqWOCOsYHSqrdWsvLrV0mZ/
         4bRC2nQjBUWePAjATWJqcpQCGrW4X3Jc3J4yg=
Received: by 10.223.35.147 with SMTP id p19mr4822495fad.13.1301690090090; Fri,
 01 Apr 2011 13:34:50 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 13:34:30 -0700 (PDT)
In-Reply-To: <20110401201714.GA16501@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170619>

On Fri, Apr 1, 2011 at 10:17 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 01, 2011 at 10:13:23PM +0200, Erik Faye-Lund wrote:
>
>> On Fri, Apr 1, 2011 at 10:05 PM, Jeff King <peff@peff.net> wrote:
>> > On Fri, Apr 01, 2011 at 09:57:14PM +0200, Erik Faye-Lund wrote:
>> >
>> >> > But this does not help the case at hand in any way. How would you interrupt a
>> >> > thread that is blocked in ReadFile()? The point of pthread_cancel() is that
>> >> > it interrupts blocked system calls
>> >>
>> >> There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
>> >> Cancellation), so relying on that is undefined behavior.
>> >
>> > Eh? My pthreads(7) says that read() is required to be a cancellation
>> > point acrroding to POSIX. I didn't dig up the actual reference in the
>> > standard, though.
>>
>> I don't understand where the implementor would get that from after
>> reading through it, but if there's something I've missed we can fix it
>> by replacing my pthread_cancel with this, no?
>
> Out of curiosity, which POSIX are you reading? My page references
> POSIX.1-2001, but technically pthreads were originally defined in
> POSIX.1c-1995.
>

Sorry that I wasn't more clear about this:

"The Open Group Base Specifications Issue 6"
"IEEE Std 1003.1, 2004 Edition"

Available here:
http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_09.html
