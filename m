From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/5] thread-utils: add a threaded task queue
Date: Thu, 27 Aug 2015 10:02:42 -0700
Message-ID: <CAGZ79kZQ6z8L6Cp-Z56EBq1e-700NsxW9XmFq7fXuMwtUyRSvg@mail.gmail.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
	<1440636766-12738-3-git-send-email-sbeller@google.com>
	<a35977776a7ea97b0ddd4d1921e3e95f@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 19:02:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV0Zc-0004NF-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 19:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbbH0RCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 13:02:44 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35174 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbH0RCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 13:02:43 -0400
Received: by ykbi184 with SMTP id i184so26660464ykb.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AhHl26AHhANlx1HmTBJVpp2VZtFshScWWOaPQNc6CsQ=;
        b=dgHEx3zSPx3lI9EBekbAjxJFZLOvYtKWiZKUJ3mtkgTvqiyLNbckjnFUQGq/mBMJ9c
         EZNggqbCNOlYQ/cVwN2mQtKPuWdSqjNs3o18iFIDHr/z3lTdi26xyzfDzwM54BZJzCvh
         JEewqBY/Qe36s6Qqqj03yIFpP/VzTMfQgfxJi3e+6feKj2M2ksXP1hp9oxeSKqum7Y8L
         nTY+gJfUQisBjy3aLg9CLe9Q5Yu52K7e8+3MDcktWKxnUeeIp5LR3SN2ke3hH/mNjwo6
         Hci8GkE99+sIWH+Npc/L23xs0aTRugIIjayZffK7rRQFFk8dc73sfYJgfLZXG8WvapAo
         FOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AhHl26AHhANlx1HmTBJVpp2VZtFshScWWOaPQNc6CsQ=;
        b=mepptun5yFbQm2kpJ67zNAsOG6wdAIJGD4Qv95Wu+PWPME59N/KBD0BbxOLWptvTvj
         UCgDelKlEjy6uX4NrhpRAS+HC6WZxrgSYcpwkJTQvSysN8uHeUorHbEDAh+yqDXv1q+w
         vYNQod78+wkyBcuwEnFHnpPaii1To7eIjZ4+Wg9sewFEc8i9QbJIolgb1iHjVCfK7+Gt
         ISwI1NtRHX5mfYUPq+u5Jhk2dTzDHDX+3oRpMkNvssri7eZPo7a/6nj0JG8FzEv97GHn
         fSmle245XADGD4WqkUcqFjfN6K42jCrHWZDSqoHLpm47rzOH0FI2N+tDiDHFjxoEUQDl
         Pi5A==
X-Gm-Message-State: ALoCoQktaLm/Edik1O8GLODQmfaeIenKUh52MQohvVi3T/3Rzt/g2QYgRXLnMvHshi6VvEjepmBm
X-Received: by 10.129.16.212 with SMTP id 203mr3641904ywq.142.1440694962889;
 Thu, 27 Aug 2015 10:02:42 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Thu, 27 Aug 2015 10:02:42 -0700 (PDT)
In-Reply-To: <a35977776a7ea97b0ddd4d1921e3e95f@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276683>

On Thu, Aug 27, 2015 at 5:59 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On 2015-08-27 02:52, Stefan Beller wrote:
>
>> diff --git a/run-command.c b/run-command.c
>> index 28e1d55..cb15cd9 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -668,6 +668,22 @@ int git_atexit(void (*handler)(void))
>>
>>  #endif
>>
>> +void setup_main_thread(void)
>> [...]
>>
>> diff --git a/thread-utils.c b/thread-utils.c
>> index a2135e0..b45ab92 100644
>> --- a/thread-utils.c
>> +++ b/thread-utils.c
>> [...]
>> +/* FIXME: deduplicate this code with run-command.c */
>> +static void setup_main_thread(void)
>
> Do you remember off-hand why the code could not be moved to thread-utils.c wholesale? Just curious.

The code in run-command has a few things regarding the struct async
handling in there,
which we don't  need/want. I just realized there is some duplicate
code, but I couldn't cut
it clearly out.

>
>> +#else /* NO_PTHREADS */
>> +
>> +struct task_queue {
>> +     int early_return;
>> +};
>> +
>> +struct task_queue *create_task_queue(unsigned max_threads)
>> +{
>> +     struct task_queue *tq = xmalloc(sizeof(*tq));
>> +
>> +     tq->early_return = 0;
>> +}
>> +
>> +void add_task(struct task_queue *tq,
>> +           int (*fct)(struct task_queue *tq, void *task),
>
> Might make sense to typedef this... Maybe task_t?
>
>> +           void *task)
>> +{
>> +     if (tq->early_return)
>> +             return;
>
> Ah, so "early_return" actually means "interrupted" or "canceled"?

The early_return is meant to return early in case of an error in some thread.
In the threaded version, the `dispatcher` is executed in each thread.
It gets its
new tasks via `next_task`, which takes the early_return value from the thread,
ORs it into the early_return of the task queue (which all threads have
access to).
So by the ORing into the task queues early_return the signal to abort
early is propagated to a place all threads have access to. And in case
that value is
set, the `next_task` will return NULL as an indication to cleanup and
pthread_exit.

>
> I guess I will have to set aside some time to wrap my head around the way tasks are handled here, in particular how the two `early_return` variables (`dispatcher()`'s local variable and the field in the `task_queue`) interact.
>
> Thanks!
> Dscho
