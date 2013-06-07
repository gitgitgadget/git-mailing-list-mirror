From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 07 Jun 2013 15:07:54 +0200
Message-ID: <51B1DB2A.2060306@viscovery.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net> <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net> <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com> <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org> <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com> <51B1B4DF.90705@viscovery.net> <CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com> <51B1CFD4.3030908@viscovery.net> <CABPQNSasTdkmpeGWb7_wZK2cQhiOyF7bX5ObcBg5kHm0KBGS5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 07 15:08:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkwOh-0004ym-0U
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 15:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab3FGNH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 09:07:59 -0400
Received: from so.liwest.at ([212.33.55.13]:17385 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807Ab3FGNH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 09:07:58 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UkwOY-0001H8-K3; Fri, 07 Jun 2013 15:07:54 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 505BF1660F;
	Fri,  7 Jun 2013 15:07:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CABPQNSasTdkmpeGWb7_wZK2cQhiOyF7bX5ObcBg5kHm0KBGS5w@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226627>

Am 6/7/2013 14:46, schrieb Erik Faye-Lund:
> On Fri, Jun 7, 2013 at 2:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 6/7/2013 14:00, schrieb Erik Faye-Lund:
>>> On Fri, Jun 7, 2013 at 12:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>> Am 6/7/2013 12:12, schrieb Erik Faye-Lund:
>>>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>>>> index b295e2f..8b3c1b4 100644
>>>>> --- a/compat/mingw.c
>>>>> +++ b/compat/mingw.c
>>>>> @@ -1573,7 +1573,8 @@ static HANDLE timer_event;
>>>>>  static HANDLE timer_thread;
>>>>>  static int timer_interval;
>>>>>  static int one_shot;
>>>>> -static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
>>>>> +static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL,
>>>>> +    sigterm_fn = SIG_DFL;
>>>>>
>>>>>  /* The timer works like this:
>>>>>   * The thread, ticktack(), is a trivial routine that most of the time
>>>>> @@ -1688,6 +1689,10 @@ sig_handler_t mingw_signal(int sig,
>>>>> sig_handler_t handler)
>>>>>               sigint_fn = handler;
>>>>>               break;
>>>>>
>>>>> +     case SIGTERM:
>>>>> +             sigterm_fn = handler;
>>>>> +             break;
>>>>> +
>>>>>       default:
>>>>>               return signal(sig, handler);
>>>>>       }
>>>>> @@ -1715,6 +1720,13 @@ int mingw_raise(int sig)
>>>>>                       sigint_fn(SIGINT);
>>>>>               return 0;
>>>>>
>>>>> +     case SIGTERM:
>>>>> +             if (sigterm_fn == SIG_DFL)
>>>>> +                     exit(128 + SIGTERM);
>>>>> +             else if (sigterm_fn != SIG_IGN)
>>>>> +                     sigterm_fn(SIGTERM);
>>>>> +             return 0;
>>>>> +
>>>>>       default:
>>>>>               return raise(sig);
>>>>>       }
>>>>
>>>> That's pointless and does not work. The handler would only be called when
>>>> raise() is called, but not when a SIGTERM is received, e.g., via Ctrl-C
>>>> from the command line, because that route ends up in MSVCRT, which does
>>>> not know about this handler.
>>>
>>> That's not entirely true. On Windows, there's only *one* way to
>>> generate SIGTERM; "signal(SIGTERM)". Ctrl+C does not generate SIGTERM.
>>> We generate SIGINT on Ctrl+C in mingw_fgetc, but the default Control+C
>>> handler routine calls ExitProcess():
>>> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683242(v=vs.85).aspx
>>
>> But a call to signal(SIGTERM, my_handler) should divert Ctrl+C to
>> my_handler. The unpatched version does, because MSVCRT now knows about
>> my_handler and sets things up so that the event handler calls my_handler.
> 
> No, it does not:
> Ctrl+C raises SIGINT, not SIGTERM.

<action type="slap" destination="forehead"/>

You are right. Your change would "fix" SIGTERM as it can be raised only
via raise() on Windows nor can it be caught when a process is killed via
mingw_kill(...,SIGTERM) by another process.

But then the current handling of SIGINT in compat/mingw.c is broken. The
handler is not propagated to MSVCRT, and after a SIGINT handler is
installed, Ctrl+C still terminates the process. No?

BTW, isn't mingw_signal() bogus in that it returns the SIGALRM handler
even if a SIGINT handler is installed?

-- Hannes
