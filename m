From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 7 Jun 2013 14:00:41 +0200
Message-ID: <CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
 <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
 <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
 <51B1B4DF.90705@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 07 14:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkvMF-0005TD-7m
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 14:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab3FGMBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 08:01:23 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40010 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab3FGMBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 08:01:22 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so3632377iea.18
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ba2DKpjUaHwOP3iyxzwGZmt5uDunEbQ2nRz0z985T+4=;
        b=e+g5it1uZ80o5bucjp6D8pHVSSvd/X//+BEHrSUhAPYT1StAHnQdn+INWmrh7OlJCD
         BsGpyMRZVoAPDNrGtk4Y//iCmaFpET8JqBiW46UPeATV3GnBwm7uem7s8gJIfGdLvdOs
         r3Mx1JIALjHgk7o65XWnIdSJmYhf4dIy9Hwzy+x1jDwvXbEQKqYAW8z3cFxk3ZmF2ula
         /mY6cdnKC7fSojCQnsIgWCa2vDRmgxutIr0w7gBfZNr+5jDIdYOtAbcmQ5xJhYiX6y06
         KeMX8lpJ+Cuj7e4KYW8IcEDXsLpfiKtCHZNLpO2JeGrd8gri6GOQJoSpK165ILDKsOJ4
         Oi4g==
X-Received: by 10.50.49.5 with SMTP id q5mr972786ign.106.1370606482411; Fri,
 07 Jun 2013 05:01:22 -0700 (PDT)
Received: by 10.64.23.199 with HTTP; Fri, 7 Jun 2013 05:00:41 -0700 (PDT)
In-Reply-To: <51B1B4DF.90705@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226621>

On Fri, Jun 7, 2013 at 12:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 6/7/2013 12:12, schrieb Erik Faye-Lund:
>> On Thu, Jun 6, 2013 at 7:40 PM, Jeff King <peff@peff.net> wrote:
>>> On Thu, Jun 06, 2013 at 10:21:47AM -0700, Junio C Hamano wrote:
>>>
>>>>> The particular deficiency is that when a signal is raise()d whose SIG_DFL
>>>>> action will cause process death (SIGTERM in this case), the
>>>>> implementation of raise() just calls exit(3).
>>>>
>>>> After a bit of web searching, it seems to me that this behaviour of
>>>> raise() is in msvcrt, and compat/mingw.c::mingw_raise() just calls
>>>> that.  In other words, "the implementation of raise()" is at an even
>>>> lower level than mingw/msys, and I would agree that it is a platform
>>>> issue.
>>>
>>> Yeah, if it were mingw_raise responsible for this, I would suggest using
>>> the POSIX shell "128+sig" instead. We could potentially check for
>>> SIG_DFL[1] mingw_raise and intercept and exit there. I don't know if
>>> that would create headaches or confusion for other msys programs,
>>> though. I'd leave that up to the msysgit people to decide whether it is
>>> worth the trouble.
>>>
>>
>> ...and here's the code to do just that:
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index b295e2f..8b3c1b4 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -1573,7 +1573,8 @@ static HANDLE timer_event;
>>  static HANDLE timer_thread;
>>  static int timer_interval;
>>  static int one_shot;
>> -static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
>> +static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL,
>> +    sigterm_fn = SIG_DFL;
>>
>>  /* The timer works like this:
>>   * The thread, ticktack(), is a trivial routine that most of the time
>> @@ -1688,6 +1689,10 @@ sig_handler_t mingw_signal(int sig,
>> sig_handler_t handler)
>>               sigint_fn = handler;
>>               break;
>>
>> +     case SIGTERM:
>> +             sigterm_fn = handler;
>> +             break;
>> +
>>       default:
>>               return signal(sig, handler);
>>       }
>> @@ -1715,6 +1720,13 @@ int mingw_raise(int sig)
>>                       sigint_fn(SIGINT);
>>               return 0;
>>
>> +     case SIGTERM:
>> +             if (sigterm_fn == SIG_DFL)
>> +                     exit(128 + SIGTERM);
>> +             else if (sigterm_fn != SIG_IGN)
>> +                     sigterm_fn(SIGTERM);
>> +             return 0;
>> +
>>       default:
>>               return raise(sig);
>>       }
>
> That's pointless and does not work. The handler would only be called when
> raise() is called, but not when a SIGTERM is received, e.g., via Ctrl-C
> from the command line, because that route ends up in MSVCRT, which does
> not know about this handler.

That's not entirely true. On Windows, there's only *one* way to
generate SIGTERM; "signal(SIGTERM)". Ctrl+C does not generate SIGTERM.
We generate SIGINT on Ctrl+C in mingw_fgetc, but the default Control+C
handler routine calls ExitProcess():
http://msdn.microsoft.com/en-us/library/windows/desktop/ms683242(v=vs.85).aspx

So I believe this *does* entirely fix SIGTERM (as we currently know
it) on Windows. SIGINT is still not entirely clean, but we can fix
that on a case-by-case basis.
