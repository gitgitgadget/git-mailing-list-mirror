From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 22:41:47 +0200
Message-ID: <AANLkTinQFReBnDAQrJUaCXTY7E6fqo0LySVr9QTQWV33@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <20110401200537.GA15778@sigill.intra.peff.net>
 <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com> <201104012236.12844.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5lAd-0007Og-H0
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab1DAUmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 16:42:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61257 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab1DAUmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 16:42:08 -0400
Received: by fxm17 with SMTP id 17so2865097fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8exxKhj2Pungzc05QZOXPYO4Uj79gs/+Yswf7ZxY5ps=;
        b=ps0gi3CVYeLYo1zPM/2qOFtaTmRihLaIz+cVAvKOLpWscYY+8HPAe0XqRZcZQUb6SK
         NOcVTv1VQndGvK1Rnf/IvcEsO3vY+wgmxDaI7Eg7hUq9DnYlq16CdAfFqHviDdULDf27
         1pl8ut2FfWqzxfXxyqJQ0MCQSlZm4AJyOkMW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=sXTBZtH70bni5hSrbAGx6xTxPL6OTA8bbVpxGuEhUttlDLMNrB8PfBflqlgVawvNCr
         FVhUQlRjznvBYHKI1SgZ8sXIJMFOqL2HdP63xvVaLP2YjfihLAc6kNir7s0ZH2n1dezS
         XX0lYibqd+mInMB3AfnoR2KwvqqQ3EKIrFZ6o=
Received: by 10.223.73.133 with SMTP id q5mr2527572faj.127.1301690527064; Fri,
 01 Apr 2011 13:42:07 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 13:41:47 -0700 (PDT)
In-Reply-To: <201104012236.12844.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170621>

On Fri, Apr 1, 2011 at 10:36 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 1. April 2011, Erik Faye-Lund wrote:
>> On Fri, Apr 1, 2011 at 10:05 PM, Jeff King <peff@peff.net> wrote:
>> > On Fri, Apr 01, 2011 at 09:57:14PM +0200, Erik Faye-Lund wrote:
>> >> > But this does not help the case at hand in any way. How would y=
ou
>> >> > interrupt a thread that is blocked in ReadFile()? The point of
>> >> > pthread_cancel() is that it interrupts blocked system calls
>> >>
>> >> There is no mention of such a guarantee in POSIX (section 2.9.5 T=
hread
>> >> Cancellation), so relying on that is undefined behavior.
>> >
>> > Eh? My pthreads(7) says that read() is required to be a cancellati=
on
>> > point acrroding to POSIX. I didn't dig up the actual reference in =
the
>> > standard, though.
>>
>> I don't understand where the implementor would get that from after
>> reading through it, but if there's something I've missed we can fix =
it
>> by replacing my pthread_cancel with this, no?
>>
>> static inline int pthread_cancel(pthread_t thread)
>> {
>> =A0 =A0 =A0 SetEvent(thread.cancel_event);
>> =A0 =A0 =A0 CancelSynchronousIo(thread.handle);
>> }
>
> Do I deserve this? There *is* a function that does what we need. I ge=
t what I
> deserve when I don't study all 100,000 functions in the manual...
>

Hey, it's mentioned in the ReadFile documentation!

> Wait a minute! I *did* study 100,000 functions. This is one of the 25=
,000
> functions that are new in Vista... Those I haven't studied, yet.
>

Bah, Vista and up. That blows, we support WinXP as well! Well,
dynamically loading the function when it's there is better than doing
NOTHING, which was the previous alternative, no? :)
