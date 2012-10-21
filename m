From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Mon, 22 Oct 2012 00:20:34 +0200
Message-ID: <CAMP44s2Gs8Mucw5hkcDg2vA_MpCypWEzUVFLAT8zRG4opKMPkg@mail.gmail.com>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
	<7v7gqjftuj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3t0-0003NP-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 00:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660Ab2JUWUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 18:20:35 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64999 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655Ab2JUWUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 18:20:35 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1903692oag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aH+6iHFDz+JuSWerEc3esdELtMHdNgqPcKJGZULCgJ0=;
        b=zbOTDcFe6LnstWyGVhJ7KUb60gUTvbuvUaw2HRyr8uMO4uRTWfU+ijjR5ZHNlNcbT2
         +pX7I4BbwlqY0OyyH3Q55YGba1hXk8ggChNiWWPsCRaQso4S6EF5o1TnB607NZmrUEBn
         FIO+zzFfSrBEVBXu2gqVsVoiKee0yn0/hwzSoK+iKua6xjzVaY0x3u2elUUXndHWbg0v
         B/Pl5NVNHL+WxJCsg75a233BMMQf7ugWTZ1OkOe7RwG18xWQE32YTl6W1IfUvsZ48a7k
         OHTbMcz5sZ8BSneJVPz/Q+T62TTF3e//LtuJTtNpCaZzRXio3mZotRKT49+xsm+MflWK
         qFyQ==
Received: by 10.60.170.179 with SMTP id an19mr6594986oec.46.1350858034641;
 Sun, 21 Oct 2012 15:20:34 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Sun, 21 Oct 2012 15:20:34 -0700 (PDT)
In-Reply-To: <7v7gqjftuj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208161>

On Sun, Oct 21, 2012 at 10:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> +int check_command(struct child_process *cmd)
>> +{
>> +     int status;
>> +     pid_t pid;
>> +
>> +     pid = waitpid(cmd->pid, &status, WNOHANG);
>> +
>> +     if (pid < 0)
>> +             return -1;
>> +     if (WIFSIGNALED(status))
>> +             return WTERMSIG(status);
>> +     if (WIFEXITED(status))
>> +             return WEXITSTATUS(status);
>> +
>> +     return 0;
>> +}
>
> It is nice to have a separate helper that would theoretically be
> useful by anybody who runs a child process, but I have to wonder:
>
>  - How other codepaths that run child process check their results?
>    Do they ignore the result altogether?  Do they check the results
>    in an ad-hoc way without a good reason?  Do they check the
>    results differently because their error handling need to be
>    different?

They probably check at the end, truly waiting for the process to
finish, that's not what we want, thus the WNOHANG that apparently
nobody else in git is using.

The reason is that the transport-helpers are special; they are
re-used, so we can't wait for the process to finish after running a
certain command.

>    With this, I am not requesting to port these other codepaths to
>    use this helper in this patch series.  But designing the helper
>    with potential others' use in mind is within the scope of this
>    patch.

That's what I did. If somebody else needs to check the status of the
command mid-stream, they can do that.

>  - How does the caller use the return value from this helper?  I can
>    see that "zero is success, non-zero is failure", unless there is
>    a platform what defines a signum 0 for some signal that can kill
>    the child process.  But I am not sure if the caller can tell more
>    than that from the return value ("did it die with a signal, or
>    did it exit with non-zero status"?)

I don't really care, I'm fine returning -1 on all errors.

>> diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
>> index e7dc668..d4b17ae 100755
>> --- a/t/t5800-remote-helpers.sh
>> +++ b/t/t5800-remote-helpers.sh
>> @@ -145,4 +145,10 @@ test_expect_failure 'push new branch with old:new refspec' '
>>       compare_refs clone HEAD server refs/heads/new-refspec
>>  '
>>
>> +test_expect_success 'proper failure checks' '
>> +     export GIT_REMOTE_TESTGIT_FAILURE=1 &&
>> +     ! git clone "testgit::$PWD/server" failure 2> errors &&
>> +     grep -q "Error while running helper" errors
>> +'
>> +
>>  test_done
>
> Please be nicer to people who come *after* you are done with this
> change.  Forcing failure will propagate to any new test added after
> this piece with this patch.
>
> Perhaps like this:
>
>         test_expect_success 'proper failure checks' '
>                 (
>                         GIT_REMOTE_TESTGIT_FAILURE=1 &&
>                         export GIT_REMOTE_TESTGIT_FAILURE &&
>                         test_must_fail git clone "testgit::$PWD/server" failure
>                 ) 2>errors &&
>                 grep "Error while running helper" errors
>         '

LGTM.

-- 
Felipe Contreras
