From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] run-command: add new check_command helper
Date: Mon, 1 Apr 2013 17:58:55 -0600
Message-ID: <CAMP44s3NxBexkaQa=KxJ963L29T4BAn7e+-3YVz-vgUp8jrb4A@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
	<20130401232326.GA30935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 01:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UModU-0002QS-2A
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 01:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759432Ab3DAX65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 19:58:57 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:62501 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060Ab3DAX64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 19:58:56 -0400
Received: by mail-la0-f52.google.com with SMTP id fs12so2604150lab.11
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 16:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=gLyqz8QRryQfhOXu2tu3qyHMrLSmHKoRxlXx41UzDe0=;
        b=E6zWbR+qK8EkBJMRPoCtGk8pvDC/BmzEUSaARt+5ACfTZiYCMRJTL8TNqp7arWYq2e
         19YV5kf3fAPQTH1TdULFQBJWlkZgTqrNEl632MPBwQY+AxHsDI+3wb3yqcTJ6ecJarIy
         y0Cr/2feKl0E8pP9f8tSy1kfpR+f2aWS6Op7Fhf8zGDtEIFOVNEPETaGIMfyzM/6q20e
         XeZnq/rYURC/T69Dvzof/Ztdn3ZGN2jZT5MCz2x4fJQWSXM9nba1W+XCWJp7LyaQwpfY
         loyGejPWnfyNIyMpWf21XZ1js7ro80pfXjpgFj5PMzhoQHL5iWeI0IEA3Yc7wVjGAxJe
         YnuA==
X-Received: by 10.152.105.109 with SMTP id gl13mr6564344lab.40.1364860735221;
 Mon, 01 Apr 2013 16:58:55 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 16:58:55 -0700 (PDT)
In-Reply-To: <20130401232326.GA30935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219727>

On Mon, Apr 1, 2013 at 5:23 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 01, 2013 at 03:46:41PM -0600, Felipe Contreras wrote:

>> -static int wait_or_whine(pid_t pid, const char *argv0)
>> +static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *stat_loc)
>> +{
>> +     if (cmd->last_wait.code) {
>> +             errno = cmd->last_wait.failed_errno;
>> +             *stat_loc = cmd->last_wait.status;
>> +             return errno ? -1 : pid;
>> +     } else {
>> +             pid_t waiting;
>> +             while ((waiting = waitpid(pid, stat_loc, 0)) < 0 && errno == EINTR)
>> +                     ;       /* nothing */
>> +             return waiting;
>> +     }
>> +}
>
> So it looks we are trying to save the waitpid state from a previous run
> and use the saved value. Otherwise, waitpid as normal.
>
> We loop on EINTR when we actually call waitpid(). But we don't check
> whether the saved errno is waitpid. What happens if we EINTR during the
> saved call to waitpid?

Are you saying that even if we have stored the result of a waitpid
command, if errno is EINTR, then we should still loop waitpid()? If
so, I guess this would do the trick:

static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid,
int *stat_loc)
{
	pid_t waiting;

	if (cmd->last_wait.code) {
		errno = cmd->last_wait.failed_errno;
		*stat_loc = cmd->last_wait.status;
		if (errno != EINTR)
			return errno ? -1 : pid;
	}

	while ((waiting = waitpid(pid, stat_loc, 0)) < 0 && errno == EINTR)
		;	/* nothing */
	return waiting;
}

>> +static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0)
>>  {
>>       int status, code = -1;
>>       pid_t waiting;
>>       int failed_errno = 0;
>>
>> -     while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
>> -             ;       /* nothing */
>> +     waiting = persistent_waitpid(cmd, pid, &status);
>>
>>       if (waiting < 0) {
>>               failed_errno = errno;
>
> We now take argv0 into wait_or_whine. But I don't see it being used.
> What's it for?

It was there before:
-static int wait_or_whine(pid_t pid, const char *argv0)
+static int wait_or_whine(struct child_process *cmd, pid_t pid, const
char *argv0)

>> +int check_command(struct child_process *cmd)
>> +{
>> +     int status;
>> +     pid_t waiting;
>> +     int failed_errno = 0;
>> +
>> +     waiting = waitpid(cmd->pid, &status, WNOHANG);
>
> This might return the pid if it has died, -1 if there was an error, or 0
> if the process still exists but hasn't died. So...
>
>> +     if (waiting != cmd->pid)
>> +             return 1;
>> +
>> +     if (waiting < 0)
>> +             failed_errno = errno;
>
> How would we ever trigger this second conditional? It makes sense to
> return 1 when "waiting == 0", as that is saying "yes, your process is
> still running" (though documenting the return either at the top of the
> function or in the commit message would be helpful)
>
> But if we get an error from waitpid, we would also return 1, which
> doesn't make sense (especially if it is something like EINTR -- I don't
> know offhand if we can get EINTR during WNOHANG. It should not block,
> but I don't know if it can race with a signal).

How about this?

if (waiting >= 0 && waiting != cmd->pid)
		return 1;

>> +     cmd->last_wait.code = -1;
>> +     cmd->last_wait.failed_errno = failed_errno;
>> +     cmd->last_wait.status = status;
>
> Since we can only get here when waiting == cmd->pid,

No, also when waiting < 0.

> Why is code set to -1?  It
> seems to be used as a flag to say "this structure is valid". Should it
> be defined as "unsigned valid:1;" instead?

Yeap. I was using it for other purposes before, 'valid' would be better now.

Cheers.

-- 
Felipe Contreras
