From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 12:15:50 +0200
Message-ID: <AANLkTin3+PzYcQEaaxgr9_5mgDGO5oiYDyBD_2tJqCTk@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <20110331184546.GA16981@sigill.intra.peff.net>
 <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 12:16:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5bOr-0008Sx-KX
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 12:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab1DAKQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 06:16:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab1DAKQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 06:16:11 -0400
Received: by fxm17 with SMTP id 17so2489750fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vxZa0yiATHVozyS1/PE2HP9LGc9bQabKWauL1urKxoA=;
        b=kLdBhpT9NakIFy6kXZo4YMAKPJTJOUMwZ5ADXZ16IDUwuMQDGfYFWRfi5EV/ihudpI
         pEJaPxflOd5HbYwtl+omJcpftdAhJ2OwtfMiSYInqA/antaUYJB5oj4UmJ8xg+6vHiJl
         6KN1eNWmyT2GxuxeLEmi2RC/FX3PaRXk+ogoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=WeOnEEGXh1F1Vf8kwDUbrMYM6Jf8U7OoouVqHriRxiioinq0EaLu3RnrfVeOQIS526
         hfRrrax4ynJpGADhdPeptd1JYHuKn/WiJXjrOLd5tOr1ODktSEMCQwNkTtMpdUEDgkgj
         CxbIq+KJgsnTBTlidYVQ+1S+mwPcQJA+rUiP0=
Received: by 10.223.110.21 with SMTP id l21mr1398025fap.70.1301652970106; Fri,
 01 Apr 2011 03:16:10 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 03:15:50 -0700 (PDT)
In-Reply-To: <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170578>

On Fri, Apr 1, 2011 at 11:41 AM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Thu, Mar 31, 2011 at 8:45 PM, Jeff King <peff@peff.net> wrote:
>> We just need to cancel the thread, instead of sending it a
>> signal as we do for fork()'d async sections.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> This could also just be part of the merge resolution, but I thought =
it
>> would be easier to see what is going on if I put it here.
>>
>> =A0run-command.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index e31c073..46ea07d 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -607,7 +607,7 @@ void abort_async(struct async *async)
>> =A0#ifdef NO_PTHREADS
>
> This context-line doesn't match 3/4... Did you send out the wrong
> version of that patch?
>
>> =A0 =A0 =A0 =A0kill(async->pid, 15);
>> =A0#else
>> - =A0 =A0 =A0 /* no clue */
>> + =A0 =A0 =A0 pthread_cancel(async->tid);
>
> My worry about terminating a thread that's currently holding a mutex
> (implicitly through the CRT?) still applies though...
>

OK, I've read up on thread-cancellation, and this code seems correct.
pthread_cancel doesn't kill the thread right away, it just signals a
cancellation-event, which is checked for at certain
cancellation-points. A lot of the CRT functions are defined as
cancellation points, so it'll be a matter for us Win32-guys to
implement pthread_testcancel() and inject that into the
function-wrappers of the CRT functions that are marked as
cancellation-points.
