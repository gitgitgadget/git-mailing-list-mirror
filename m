From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 3/4] t7800: modernize tests
Date: Wed, 20 Mar 2013 15:59:19 -0700
Message-ID: <CAJDDKr4O-OU57j0f7F2E2_4EvtCTE1gFP5uLv+fvD6VcpPiifg@mail.gmail.com>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
	<1361419428-22410-2-git-send-email-davvid@gmail.com>
	<1361419428-22410-3-git-send-email-davvid@gmail.com>
	<514985FB.8080806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 23:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIRz3-0004v1-J8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 23:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab3CTW7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 18:59:22 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:40423 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3CTW7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 18:59:21 -0400
Received: by mail-wg0-f51.google.com with SMTP id 8so1755048wgl.6
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jxrHlO6UpMqNw99RsvzYmlw0Zib51Cfm7qSukKAVCFU=;
        b=LeO4mq/4jw2wNvREPRH84dF/8f0gdm5eF0rcAWYHmv9plTM+6g1V+j2bUjQixxPi2v
         gdDMh7eETHkZvTuu8NV5dyszHcUQaDZZX7BlemO1SAvO7VGiMyO6rhRXAWvdHKgArhDh
         jhyYbrcS2LHU6PDsQok5YU/YszT4iDILJAnDAShQ1WozKRVUVnrOOTteHyO7qh7qZ5M5
         wDicX9Ep7zfJltoXLpJINJpINOQPHPVvItGaQxfUno09ZibgJo6SXfji4/I9LeZr+nR4
         SBK/8vOnC8LpkpaoCriS8bm/2s22DquTViGLPg0vo87XgS+I/6E+cOXKDg5dUgbPK7nz
         gHYw==
X-Received: by 10.180.84.8 with SMTP id u8mr1458143wiy.1.1363820360085; Wed,
 20 Mar 2013 15:59:20 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Wed, 20 Mar 2013 15:59:19 -0700 (PDT)
In-Reply-To: <514985FB.8080806@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218685>

On Wed, Mar 20, 2013 at 2:48 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 2/21/2013 5:03, schrieb David Aguilar:
>>  test_expect_success PERL 'difftool -d' '
>> -     diff=$(git difftool -d --extcmd ls branch) &&
>> -     echo "$diff" | stdin_contains sub &&
>> -     echo "$diff" | stdin_contains file
>> +     git difftool -d --extcmd ls branch >output &&
>> +     stdin_contains sub <output &&
>> +     stdin_contains file <output
>>  '
>
> This test is broken on Windows. There is this code in git-difftool.perl
>
>         for my $file (@worktree) {
> ...
>                         copy("$b/$file", "$workdir/$file") or
>                         exit_cleanup($tmpdir, 1);
> ...
>         }
>
> @worktree is populated with all files in the worktree. At this point,
> "output" is among them. Then follows an attempt to copy a file over
> "$workdir/$file". I guess that is some link+remove magic going on behind
> the scenes. At any rate, this fails on Windows with
> "D:/Src/mingw-git/t/trash directory.t7800-difftool/../../git-difftool line
> 408: Bad file number", because files that are open cannot be written from
> outside (the file is open due to the redirection in the test snippet).
>
> What is going on here? Why can this ever succeed even on Unix?

Thanks for the report.  Yes, these do pass on Unix.

Hmm I wonder what's going on here?

I started digging in and the @worktree_files (aka @worktree above)
is populated from the output of "git diff --raw ...".

Seeing the "output" filename in "diff --raw" implies that one of the
tests added "output" to the index somehow.  I do not see that
happening anywhere, though, so I do not know how it would end up in
the @worktree array if it is not reported by "diff --raw".


My current understanding of how it could possibly be open twice:

1. via the >output redirect
2. via the copy() perl code which is fed by @worktree

So I'm confused.  Why would we get different results on Windows?

I just re-ran these tests from "next" to check my sanity and they
passed on both Linux and OS X.

> Same for some later tests.

Ditto.

> BTW, while debugging this, I found the use of the helper function
> stdin_contains() highly unhelpful; it just resolves to a 'grep' that on
> top of all hides stdout. Please don't do that. Just use unadorned grep
> like we do everywhere else.

I'm not too opposed to that.
The one small advantage to the helper is that you can tweak the redirect
in one central place, so it's not all for naught.

Sitaram, you added this back in:

ba959de1 git-difftool: allow skipping file by typing 'n' at prompt

Do you have any thoughts?

It seems like removing the stdout redirect could be helpful for debugging,
and if we did that then there's really no point in having the helper
(aside from the indirection which can sometimes help during debugging).
I don't really feel too strongly either way, but it did bother you
while debugging the test script, so unadorned grep seems like the way to go.

I'll wait and see if anybody else has any Windows-specific clues that
we can use to narrow down this problem.

In lieu of an immediate fix, are there any test prerequisite we can
use to skip these tests on windows?  One or both of NOT_CYGWIN,NOT_MINGW?
-- 
David
