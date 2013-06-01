From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 09:30:50 -0500
Message-ID: <CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uimpd-00021I-3m
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab3FAOax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:30:53 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34178 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123Ab3FAOav (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:30:51 -0400
Received: by mail-wi0-f175.google.com with SMTP id hn14so1476364wib.8
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nCqnUfVZlYXuJ72qicFGwev/C7diDBPGRfLg/Wf7Jxg=;
        b=dGsjl+VtEGiJrs97JcCUloadGayQCUUccwOQgsqXgbvjv2tLVmc9hDLehw/3JN5SYT
         nbhcej1MChU7e9xocQvMRLwxdJxphAV2tvB6wDhKrxs7yI9j0wMui7bQUYuVLBmR2ocY
         8YreMCA/SghdW386AeCmswus+zhXSZ3IMhC6y7oWh7639DXr3ex8/C/oBQ8I/sfTuFe4
         HLCukxlOrIuQuogOEXlnldDxXKQQXlQ+smMGiIgXEtAVfvPcIOYnSmB2BOISFUafePVQ
         8+685H8fTrlFxFQzfMTsJv0gDJWDuFaJbUTSJXGMY0bK8rMjLY7SE6++vwcBfd78WJbG
         sdYg==
X-Received: by 10.180.189.136 with SMTP id gi8mr7165444wic.11.1370097050132;
 Sat, 01 Jun 2013 07:30:50 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Sat, 1 Jun 2013 07:30:50 -0700 (PDT)
In-Reply-To: <CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226135>

On Sat, Jun 1, 2013 at 9:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Nobody is checking for specific error codes; it's the errno that's
>> important.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  run-command.c | 14 ++------------
>>  1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 1b32a12..e54e943 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -244,21 +244,11 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>>                 code = WTERMSIG(status);
>>                 if (code != SIGINT && code != SIGQUIT)
>>                         error("%s died of signal %d", argv0, code);
>> -               /*
>> -                * This return value is chosen so that code & 0xff
>> -                * mimics the exit code that a POSIX shell would report for
>> -                * a program that died from this signal.
>> -                */
>> -               code += 128;
>>         } else if (WIFEXITED(status)) {
>
> The original commit that introduces this says
>
>     run_command: encode deadly signal number in the return value
>
>     We now write the signal number in the error message if the program
>     terminated by a signal. The negative return value is constructed such that
>     after truncation to 8 bits it looks like a POSIX shell's $?:
>
>        $ echo 0000 | { git upload-pack .; echo $? >&2; } | :
>        error: git-upload-pack died of signal 13
>        141
>
>     Previously, the exit code was 255 instead of 141.
>
> So this is part of the interface to the user. With your changes, the
> exit code is now different. I tested by force segfaulting upload-pack.
> $? returned 11. So NAK.

Yeah, and last year we returned a different code. The world didn't
end, because nobody is checking for the specific code. But if you want
to retain complexity forever, suit yourselves.

commit 709ca730f8e093005cc882bfb86c0ca9c83d345b
Author: Jeff King <peff@peff.net>
Date:   Sat Jan 5 09:49:49 2013 -0500

    run-command: encode signal death as a positive integer

    When a sub-command dies due to a signal, we encode the
    signal number into the numeric exit status as "signal -
    128". This is easy to identify (versus a regular positive
    error code), and when cast to an unsigned integer (e.g., by
    feeding it to exit), matches what a POSIX shell would return
    when reporting a signal death in $? or through its own exit
    code.

    So we have a negative value inside the code, but once it
    passes across an exit() barrier, it looks positive (and any
    code we receive from a sub-shell will have the positive
    form). E.g., death by SIGPIPE (signal 13) will look like
    -115 to us in inside git, but will end up as 141 when we
    call exit() with it. And a program killed by SIGPIPE but run
    via the shell will come to us with an exit code of 141.

    Unfortunately, this means that when the "use_shell" option
    is set, we need to be on the lookout for _both_ forms. We
    might or might not have actually invoked the shell (because
    we optimize out some useless shell calls). If we didn't invoke
    the shell, we will will see the sub-process's signal death
    directly, and run-command converts it into a negative value.
    But if we did invoke the shell, we will see the shell's
    128+signal exit status. To be thorough, we would need to
    check both, or cast the value to an unsigned char (after
    checking that it is not -1, which is a magic error value).

    Fortunately, most callsites do not care at all whether the
    exit was from a code or from a signal; they merely check for
    a non-zero status, and sometimes propagate the error via
    exit(). But for the callers that do care, we can make life
    slightly easier by just using the consistent positive form.

    This actually fixes two minor bugs:

      1. In launch_editor, we check whether the editor died from
         SIGINT or SIGQUIT. But we checked only the negative
         form, meaning that we would fail to notice a signal
         death exit code which was propagated through the shell.

      2. In handle_alias, we assume that a negative return value
         from run_command means that errno tells us something
         interesting (like a fork failure, or ENOENT).
         Otherwise, we simply propagate the exit code. Negative
         signal death codes confuse us, and we print a useless
         "unable to run alias 'foo': Success" message. By
         encoding signal deaths using the positive form, the
         existing code just propagates it as it would a normal
         non-zero exit code.

    The downside is that callers of run_command can no longer
    differentiate between a signal received directly by the
    sub-process, and one propagated. However, no caller
    currently cares, and since we already optimize out some
    calls to the shell under the hood, that distinction is not
    something that should be relied upon by callers.

    Fix the same logic in t/test-terminal.perl for consistency [jc:
    raised by Jonathan in the discussion].

    Signed-off-by: Jeff King <peff@peff.net>
    Acked-by: Johannes Sixt <j6t@kdbg.org>
    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

-- 
Felipe Contreras
