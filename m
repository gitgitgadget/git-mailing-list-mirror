From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 22:31:42 +0200
Message-ID: <AANLkTi=ec9azPovJoDVO6kyXEik4uFQu3dZNxAJyvDY=@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104012142.22065.j6t@kdbg.org>
 <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com> <201104012218.07872.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5l0t-0007Bq-65
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab1DAUcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 16:32:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48168 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab1DAUcD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 16:32:03 -0400
Received: by fxm17 with SMTP id 17so2860188fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=vMSKL7nWwk8SLme5ZjtBrvZ2nzNF/Kv0KsVKNH+30t8=;
        b=ku/qRej7Bapx7k4/aQ6WE1J1PqqcEbLjhwMcO1ujgBTNO3q09EYcGAELAMM92euHim
         j/C0jvYD4aa/Vxz6c+2WFI9PG28At1OuYQq+Kq9etxtr1oPg7DoTHOZMXCre1GJXFxPI
         e+x+9tTe67sxOwbuFZa6awYtotafny04ZdTTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=X+X05ahU+2dcgRnrRofft23Wi96ttFwugx9+uXfT/RsLBuHmfphe2EPxisn5JrqB//
         vXUOA8dwWPluSU/gXmnlF0XNWvkP+UBzbKDVFwwtm+v6bxnNub+zHMHzLjl+SSKIyc2P
         KMLl/kuJJ3HCrTJsJUfPyExNyGAYvdIkbar24=
Received: by 10.223.100.86 with SMTP id x22mr83951fan.108.1301689922169; Fri,
 01 Apr 2011 13:32:02 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 13:31:42 -0700 (PDT)
In-Reply-To: <201104012218.07872.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170618>

On Fri, Apr 1, 2011 at 10:18 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 1. April 2011, Erik Faye-Lund wrote:
>> On Fri, Apr 1, 2011 at 9:42 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > But this does not help the case at hand in any way. How would you
>> > interrupt a thread that is blocked in ReadFile()? The point of
>> > pthread_cancel() is that it interrupts blocked system calls
>>
>> There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
>> Cancellation), so relying on that is undefined behavior.
>
> In the paragraph before the bulleted list at the end of "Cancellation Points":
>
> "...If a thread has cancelability enabled and a cancellation request is made
> with the thread as a target while the thread is suspended at a cancellation
> point, the thread shall be awakened and the cancellation request shall be
> acted upon..."
>

A blocking thread and a suspended are two different matters. A
suspended thread is a thread that has been explicitly suspended by
wait, waitpid, sleep, pause etc. These functions explicitly say that
they suspend the thread ("shall suspend the calling thread until"),
while read etc does not ("shall block the calling thread until").

Similarly, making a blocking read/write fail (or terminate mid-way) is
not the same thing as awakening the thread.

I see how some people can read something like this into this section,
but I think it's pretty clear - this is not what it's talking about.
In fact, the more I read the relevant texts, the more convinced I get
that implementations that does terminate read/write strictly speaking
is in violation of the standard.
