From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] run-command: add new check_command helper
Date: Mon, 1 Apr 2013 23:11:20 -0600
Message-ID: <CAMP44s3-DnBM7Tm_+igLN+c5MGrbJNXUBwcj1HvGCPEJEwJSBQ@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
	<20130401232326.GA30935@sigill.intra.peff.net>
	<CAMP44s3NxBexkaQa=KxJ963L29T4BAn7e+-3YVz-vgUp8jrb4A@mail.gmail.com>
	<20130402022214.GA719@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 07:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtVg-0005aV-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 07:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759899Ab3DBFLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 01:11:24 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:45492 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758411Ab3DBFLX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 01:11:23 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so32183lab.41
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZxWgZIiGDOe6SMX9yEOoMaO1d4rcesfqS0O05JhKOHk=;
        b=s+hOsPCNLYnWCeKRdbdSw2d243pQ9S3RKKCEG1FP1GPsyqiUAHFFU1i1NeNQSqift5
         xiuHSak7IcDR5aUkDgm9V6vSlXUrgF3XlzXHGQ1DhP5AMQjrV+/D7D47Fw+Knieysf2y
         LLO8r1RgntetgL16t4jRE4vAjx3KzYhyxuhC52cPMrWv7rE2hV76/t/TFHu4FFNTCUrW
         0QiwUk1JXE24iXKIvYdFjiEO+psnPQL9sBaFH6t40ri045AWv4d7sRKgebg0a5dAKaJO
         55UalCEc5RHwAsNyLCHNQHaeJLb79KtAayZXIO0PkIRvoeNbc2MwohXGfpCNpsBZkZf0
         DeXg==
X-Received: by 10.112.145.8 with SMTP id sq8mr7035718lbb.55.1364879481036;
 Mon, 01 Apr 2013 22:11:21 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 22:11:20 -0700 (PDT)
In-Reply-To: <20130402022214.GA719@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219735>

On Mon, Apr 1, 2013 at 8:22 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 01, 2013 at 05:58:55PM -0600, Felipe Contreras wrote:

>> Are you saying that even if we have stored the result of a waitpid
>> command, if errno is EINTR, then we should still loop waitpid()? If
>> so, I guess this would do the trick:
>
> Yes, I think that would work. Though I wonder if it is even worth
> storing EINTR at all in the first place. It tells us nothing. In fact,
> does storing any error condition really tell us anything?

Probably not, I just tried to minimize the potential behavior changes.

> The two states
> we are interested in at this point are:
>
>   1. We have reaped the child via waitpid; here is its status.
>
>   2. We have not (either we did not try, it was not dead yet, or we were
>      not able to due to an error). We should now try it again.
>
> If we got EINTR the first time around, we would likely get the "real"
> answer this time. If we get anything else (like EINVAL or ECHILD), then
> we would get the same thing again calling waitpid() later.
>
>> > We now take argv0 into wait_or_whine. But I don't see it being used.
>> > What's it for?
>>
>> It was there before:
>> -static int wait_or_whine(pid_t pid, const char *argv0)
>> +static int wait_or_whine(struct child_process *cmd, pid_t pid, const
>> char *argv0)
>
> Ah, sorry, I misread the diff. We are adding "cmd", not "argv0".

Yeah, which in fact was already there before.

> That would trigger the rest of your code in the error case, which I
> think was your original intent. But then we return "0" from
> check_command. Is that right?
>
> There are three states we can be in from calling waitpid:
>
>   1. The process is dead.
>
>   2. The process is not dead.
>
>   3. We could not determine which because waitpid returned an error.
>
> It is clear that check_command is trying to tell its caller (1) or (2);
> but what should it say in case of (3)?
>
> Naively, given how patch 2 uses it, I think it would actually make sense
> for it to return 1. That is, the semantics are "return 0 if and only if
> the pid is verified to be dead; otherwise return 1".

I thought if there was an error that constituted a failure.

> But if we know from reading waitpid(3) that waitpid should only fail due
> to EINTR, or due to bogus arguments (e.g., a pid that does not exist or
> has already been reaped), then maybe something like this makes sense:
>
>   while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
>           ; /* nothing */

But we don't want to wait synchronously here, we just want to ping.

>   /* pid definitely still going */
>   if (!waiting)
>           return 1;
>
>   /* pid definitely died */
>   if (waiting == cmd->pid) {
>           cmd->last_status.valid = 1;
>           cmd->last_status.status = status;
>           return 0;
>   }
>
>   /*
>    * this should never happen, since we handed waitpid() a single
>    * pid, so it should either return that pid, 0, or an error.
>    */
>   if (waiting > 0)
>           die("BUG: waitpid reported a random pid?");
>
>   /*
>    * otherwise, we have an error. Assume the pid is gone, since that
>    * is the only reason for waitpid to report a problem besides EINTR.
>    * We don't bother recording errno, since we can just repeat
>    * the waitpid again later.
>    */
>    return 0;

The rest makes sense.

>> >> +     cmd->last_wait.code = -1;
>> >> +     cmd->last_wait.failed_errno = failed_errno;
>> >> +     cmd->last_wait.status = status;
>> >
>> > Since we can only get here when waiting == cmd->pid,
>>
>> No, also when waiting < 0.
>
> After the fix above, yes; in the original we would always have exited
> already.

No:

+       if (waiting != cmd->pid)
+               return 1;

If waiting < 0, waiting != cmd->pid, and therefore this return is not
triggered, and there's only one more return at the end of the
function.

Cheers.

-- 
Felipe Contreras
