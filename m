From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Sun, 7 Apr 2013 21:03:25 -0500
Message-ID: <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
	<1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
	<20130408005155.GA24030@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:48:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5sB-0000sy-8m
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934696Ab3DHCDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 22:03:30 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:55487 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934687Ab3DHCD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 22:03:29 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so4843435lab.5
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 19:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YNnHqdDt1RJ9qWmJLeqTK5N5ko0vK90d3f+h2VudPM4=;
        b=vprxTrAldxxdfi6dA+tWjkxX5qA+8E8Bmr7gJCHZ/T7EOKRwGeUl72vdmyO88UysAR
         C3B/HiWQQNWF3XtnWn02OzkMflrpo0dW4kI1kMOZ50NN+Ky97fYwTj4L4hOr+cIzR/jS
         RK1NBTiW+mMMvt/KQttFaK6r8ym5hANzWshJQiwYmD7WtyyBXc+jCbb5zg+i6537ZGIR
         cxIKKzCU8JaePY4+Y2Psv21+Nc7hNSznG25VAXGllbMYV6x0FqgqQP3ljDsvpi1rtfz7
         1mbAKfkq9Uo3dahbA+KE0YYkywoaDjMoWDN4KPkh7oBAkKYCcahbXGjIK4iNUvXNFyBJ
         8htA==
X-Received: by 10.152.104.199 with SMTP id gg7mr10661366lab.14.1365386605977;
 Sun, 07 Apr 2013 19:03:25 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 19:03:25 -0700 (PDT)
In-Reply-To: <20130408005155.GA24030@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220391>

On Sun, Apr 7, 2013 at 7:51 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 07, 2013 at 01:45:06AM -0600, Felipe Contreras wrote:
>
>> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
>> index f387027..efe67e2 100755
>> --- a/t/t5801-remote-helpers.sh
>> +++ b/t/t5801-remote-helpers.sh
>> @@ -166,4 +166,23 @@ test_expect_success 'push ref with existing object' '
>>       compare_refs local dup server dup
>>  '
>>
>> +test_expect_success 'proper failure checks for fetching' '
>> +     (GIT_REMOTE_TESTGIT_FAILURE=1 &&
>> +     export GIT_REMOTE_TESTGIT_FAILURE &&
>> +     cd local &&
>> +     test_must_fail git fetch 2> error &&
>> +     grep "Error while running helper" error
>> +     )
>> +'
>
> Hmm.  If you drop the final "grep" (which is looking for the error
> message you add elsewhere in this patch), this test passes even without
> the addition of the check_command calls added by your patch. Which made
> me wonder if we should be checking something else (repo state, error
> messages, etc), since we seem to otherwise be detecting the error. More
> analysis below on exactly what is going on there.

It fails all right, because the fetch process assumes the
remote-helper succeeded and only later eventually fails with an error
that is anything but user-friendly:

fatal: bad object 0000000000000000000000000000000000000000
error: testgit::/home/felipec/dev/git/t/trash
directory.t5801-remote-helpers/server did not send all necessary
objects

>> +# We sleep to give fast-export a chance to catch the SIGPIPE
>
> I'm not sure what this means; I don't see a sleep anywhere.

That's right, I'll remove the comment. It was cruft from the next
patch (see below).

>> +test_expect_failure 'proper failure checks for pushing' '
>> +     (GIT_REMOTE_TESTGIT_FAILURE=1 &&
>> +     export GIT_REMOTE_TESTGIT_FAILURE &&
>> +     cd local &&
>> +     test_must_fail git push --all 2> error &&
>> +     grep "Error while running helper" error
>> +     )
>> +'
>
> I wondered why this one is marked for failure.

Because it fails to report the right error.

> Even without check_command, the push produces:
>
>   error: fast-export died of signal 13
>   fatal: Error while running fast-export
>
> which explains why the test fails: it does not even make it to the
> check_command call at all. Why do we need check_command here, then? Is
> it racy/non-deterministic for fast-export to die due to the pipe?

It does not make it to check_command because the wait is missing. I
added that in a separate patch:
http://article.gmane.org/gmane.comp.version-control.git/219715

With that patch the check_command happens reliably, the error is
reported correctly, and the test passes. However, the way to trigger
it is ugly.

In a real use-case the chances of check_command catching the issue are
much higher..

>> diff --git a/transport-helper.c b/transport-helper.c
>> index cb3ef7d..dfdfa7a 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -460,6 +460,10 @@ static int fetch_with_import(struct transport *transport,
>>
>>       if (finish_command(&fastimport))
>>               die("Error while running fast-import");
>> +
>> +     if (!check_command(data->helper))
>> +             die("Error while running helper");
>> +
>>       argv_array_free_detached(fastimport.argv);
>
> I'm still not very excited about this approach, as it is racy to detect
> errors. E.g., there is nothing to say that the helper does not close the
> pipe to fast-import prematurely and then die afterwards, leaving the
> refs unwritten, fast-import happy, but a failed exit code from the
> helper.

That's right, and that would leave us in the situation we are right
now, even with "done" check.

> The import test still passes even without the check_command part of your
> patch because some of the refs in refs/testgit do not exist prior to the
> failed fetch, and therefore also do not exist afterwards. When fetch
> tries to feed their sha1s to check_everything_connected, you get the
> funny:
>
>   fatal: bad object 0000000000000000000000000000000000000000
>   error: testgit::/home/peff/compile/git/t/trash
>    directory.t5801-remote-helpers/server did not send all necessary
>    objects

And you think that is desirable? User-friendly?

> we can see that without your check_command, the failure in the second
> fetch is not noticed. Adding in your patch does detect this. _But_ it is
> only checking a specific failure mode of the remote-helper: process
> death that results in closing the fast-import pipe, which is how your
> GIT_REMOTE_TESTGIT_FAILURE is implemented (closing the pipe first and
> then dying is racy).
>
> If we then add this on top of your series (fixing the "status" bug in
> patch 1 that Junio mentioned), the test will start failing (both the
> original, and the more robust one I showed above):
>
> diff --git a/git-remote-testgit b/git-remote-testgit
> index ca0cf09..41b0780 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -64,6 +64,11 @@ do
>
>                 if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
>                 then
> +                       # close stdout
> +                       exec >/dev/null
> +                       # now sleep to make sure fast-import
> +                       # has time to die before we exit
> +                       sleep 1
>                         exit -1
>                 fi

Yeah, again:
http://article.gmane.org/gmane.comp.version-control.git/219715

> I agree that the failure mode from your patch is probably the most
> common order for helpers to fail in (i.e., they just die and that's what
> kills the pipe).  But I wonder if we can just cover all cases.
> Something like:
>
> diff --git a/transport-helper.c b/transport-helper.c
> index dfdfa7a..8562df0 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -461,7 +461,31 @@ static int fetch_with_import(struct transport *transport,
>         if (finish_command(&fastimport))
>                 die("Error while running fast-import");
>
> -       if (!check_command(data->helper))
> +       /*
> +        * We must disconnect from the helper at this point, because even
> +        * though fast-import may have succeeded, it may only be because the
> +        * helper was not able to feed fast-import all of the data, and what
> +        * fast-import got looked OK (e.g., it may have got nothing if the
> +        * helper died early). We still need to check the return code of the
> +        * helper to make sure it is happy with what it sent.
> +        *
> +        * Since the import command does not require the helper to ever report
> +        * success/failure of the import, we have no mechanism to check for
> +        * problems except to check its exit status.
> +        *
> +        * Callers of the transport code are allowed to make more requests
> +        * of our helper, so we may be disconnecting before they expect in that
> +        * case. However:
> +        *
> +        *   1. Current callers don't do that; after fetching refs, there
> +        *      is nothing left for the helper to do.
> +        *
> +        *   2. We transparently start the helper as necessary, so if we were
> +        *      to get another request (e.g., to import more refs), we would
> +        *      simply start a new instantiation of the helper.
> +        *
> +        */

That's a comprehensive essay, unfortunately, it's not correct. The
exit status of the remote-helper is not important, it's the one of
fast-import that we really care about.

> +       if (disconnect_helper(transport) != 0)
>                 die("Error while running helper");

Yeah, that's good, *if* the remote-helper is implemented correctly,
but try this:

               if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
               then
                       exit 0
               fi

>         argv_array_free_detached(fastimport.argv);
>
> which passes both your original test and the more strict one above. Of
> course adding a done-import capability would be nice to fix the protocol
> deficiency, but it is more code.

The done-import capability *is already there*. The remote helper fails
to say "done", fast-import detects that there was a problem and exits
with -1 (or whatever), but it doesn't matter, because we
(transport-helper) are oblivious of that return status until it's too
late.

>> @@ -818,6 +822,10 @@ static int push_refs_with_export(struct transport *transport,
>>
>>       if (finish_command(&exporter))
>>               die("Error while running fast-export");
>> +
>> +     if (!check_command(data->helper))
>> +             die("Error while running helper");
>> +
>>       push_update_refs_status(data, remote_refs);
>>       return 0;
>>  }
>
> And this one is even more likely to race than the import case, I think,
> as the exporter may send all of its data, exit, and then the helper
> chugs on it for a bit (converting, sending across the network, etc). If
> it is still chugging when we run check_command, we will not notice
> anything here.
>
> E.g., if we instrument the failure like this:
>
> diff --git a/git-remote-testgit b/git-remote-testgit
> index ca0cf09..a912bc1 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -75,6 +75,12 @@ do
>         export)
>                 if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
>                 then
> +                       # imagine we read all of fast-export's data
> +                       # first, and then die while trying to convert
> +                       # it
> +                       while read line; do
> +                               test "$line" = "done" && break
> +                       done
>                         exit -1
>                 fi
>
>
> we do not get the sigpipe from fast-export, and depending on the timing,
> your check_command may or may not do anything (in my tests, it did not).
>
> But unlike the import side, the export command _does_ give us a status
> report back from the helper: it prints an ok/error line for each ref
> that was exported, followed by a blank line. So we should be able to
> confirm that we get the blank line at all, and then that each ref was
> present, which would determine whether the export failed or not without
> being subject to race conditions.
>
> And we seem to do those checks already; the only problem I see is that
> recvline does not print a message before dying. Would the patch below be
> sufficient?
>
> diff --git a/transport-helper.c b/transport-helper.c
> index dfdfa7a..cce2062 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer)
>         if (strbuf_getline(buffer, helper, '\n') == EOF) {
>                 if (debug)
>                         fprintf(stderr, "Debug: Remote helper quit.\n");
> -               exit(128);
> +               die("remote helper died unexpectedly");
>         }
>
>         if (debug)

Yeah, I already explored this option, and I said it was possible on
pushing, but now the problem is fetching.

http://article.gmane.org/gmane.comp.version-control.git/219760

And to be frank, I'm tired of this. I keep repeating the same things
over and over, when I ask for input on different ways to achieve this
I get nothing, and when the patch is getting closer to be merged, then
I receive criticism, only so I can repeat the same again.

I don't like the option to die right in recvline(), but it would work.
We would need something else for import though. It would be possible
to tell fast-import to ping the remote-helper, but I ran into a
SIGPIPE, and I don't have the patience to find out if perhaps there's
a way to solve that. This option seems rather hacky and asymmetric to
me.

If this current patch series is not good enough, I think it's best to
leave things as they are for me.

Cheers.

--
Felipe Contreras
