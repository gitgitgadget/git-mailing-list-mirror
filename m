From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 07 Jun 2013 14:19:32 +0200
Message-ID: <51B1CFD4.3030908@viscovery.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net> <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net> <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com> <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org> <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com> <51B1B4DF.90705@viscovery.net> <CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 07 14:19:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukve1-0004W4-9S
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 14:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3FGMTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 08:19:45 -0400
Received: from so.liwest.at ([212.33.55.13]:53353 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab3FGMTo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 08:19:44 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ukvdl-0006uy-8j; Fri, 07 Jun 2013 14:19:38 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 03A811660F;
	Fri,  7 Jun 2013 14:19:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226623>

Am 6/7/2013 14:00, schrieb Erik Faye-Lund:
> On Fri, Jun 7, 2013 at 12:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 6/7/2013 12:12, schrieb Erik Faye-Lund:
>>> On Thu, Jun 6, 2013 at 7:40 PM, Jeff King <peff@peff.net> wrote:
>>>> On Thu, Jun 06, 2013 at 10:21:47AM -0700, Junio C Hamano wrote:
>>>>
>>>>>> The particular deficiency is that when a signal is raise()d whose SIG_DFL
>>>>>> action will cause process death (SIGTERM in this case), the
>>>>>> implementation of raise() just calls exit(3).
>>>>>
>>>>> After a bit of web searching, it seems to me that this behaviour of
>>>>> raise() is in msvcrt, and compat/mingw.c::mingw_raise() just calls
>>>>> that.  In other words, "the implementation of raise()" is at an even
>>>>> lower level than mingw/msys, and I would agree that it is a platform
>>>>> issue.
>>>>
>>>> Yeah, if it were mingw_raise responsible for this, I would suggest using
>>>> the POSIX shell "128+sig" instead. We could potentially check for
>>>> SIG_DFL[1] mingw_raise and intercept and exit there. I don't know if
>>>> that would create headaches or confusion for other msys programs,
>>>> though. I'd leave that up to the msysgit people to decide whether it is
>>>> worth the trouble.
>>>>
>>>
>>> ...and here's the code to do just that:
>>>
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index b295e2f..8b3c1b4 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> @@ -1573,7 +1573,8 @@ static HANDLE timer_event;
>>>  static HANDLE timer_thread;
>>>  static int timer_interval;
>>>  static int one_shot;
>>> -static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
>>> +static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL,
>>> +    sigterm_fn = SIG_DFL;
>>>
>>>  /* The timer works like this:
>>>   * The thread, ticktack(), is a trivial routine that most of the time
>>> @@ -1688,6 +1689,10 @@ sig_handler_t mingw_signal(int sig,
>>> sig_handler_t handler)
>>>               sigint_fn = handler;
>>>               break;
>>>
>>> +     case SIGTERM:
>>> +             sigterm_fn = handler;
>>> +             break;
>>> +
>>>       default:
>>>               return signal(sig, handler);
>>>       }
>>> @@ -1715,6 +1720,13 @@ int mingw_raise(int sig)
>>>                       sigint_fn(SIGINT);
>>>               return 0;
>>>
>>> +     case SIGTERM:
>>> +             if (sigterm_fn == SIG_DFL)
>>> +                     exit(128 + SIGTERM);
>>> +             else if (sigterm_fn != SIG_IGN)
>>> +                     sigterm_fn(SIGTERM);
>>> +             return 0;
>>> +
>>>       default:
>>>               return raise(sig);
>>>       }
>>
>> That's pointless and does not work. The handler would only be called when
>> raise() is called, but not when a SIGTERM is received, e.g., via Ctrl-C
>> from the command line, because that route ends up in MSVCRT, which does
>> not know about this handler.
> 
> That's not entirely true. On Windows, there's only *one* way to
> generate SIGTERM; "signal(SIGTERM)". Ctrl+C does not generate SIGTERM.
> We generate SIGINT on Ctrl+C in mingw_fgetc, but the default Control+C
> handler routine calls ExitProcess():
> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683242(v=vs.85).aspx

But a call to signal(SIGTERM, my_handler) should divert Ctrl+C to
my_handler. The unpatched version does, because MSVCRT now knows about
my_handler and sets things up so that the event handler calls my_handler.
But your patched version bypasses MSVCRT, and the default (whatever MSVCRT
has set up) happens, and my_handler is not called.

-- Hannes
