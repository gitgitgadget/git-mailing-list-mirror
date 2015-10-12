From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase` fails
Date: Mon, 12 Oct 2015 13:28:53 -0700
Message-ID: <xmqqio6bltkq.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
	<CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
	<xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
	<xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
	<ed70803ecd73415f1bbafb68502fbbda@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZljiV-0004xN-3h
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 22:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbbJLU27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 16:28:59 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36608 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbbJLU24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 16:28:56 -0400
Received: by pacex6 with SMTP id ex6so8531666pac.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=X9PkOkzz1jlEkpSsDxTI+vAC182ymRKTvMn2giiyONc=;
        b=gCn0H+u3xLAY7g9opKQAyWfhbwJoReis/uGDtmJ2rJ4FLtf45r2gVidoNiUd3uWL/3
         Rujg+r9JFs4EfPQhNOjv+wh4oMO81p+QEknTlcCg8NdfSG2In3qE3gV8GuWJ1khA1kw/
         JmemdbzhAznxI48EYBijlcH8lhnpbRc67MyIp8mlbEm4WbQO28ZX8CSj/zH10Uq3tJBl
         BqqAW/YrRHXUClByDw+acVINcF5A+S8GS/XmsjTc0rMTln2rLgv0oQXw4GYEdJ9+spC/
         w8jQ0Gio1zdo2Z5ZBytBIBkkp2r0xX8BIDatRC1OeM+ppsCpY4gg76U2YuEqnXYvjVTY
         DCGQ==
X-Received: by 10.68.249.34 with SMTP id yr2mr25888718pbc.73.1444681735392;
        Mon, 12 Oct 2015 13:28:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id d13sm18421533pbu.20.2015.10.12.13.28.54
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 12 Oct 2015 13:28:54 -0700 (PDT)
In-Reply-To: <ed70803ecd73415f1bbafb68502fbbda@dscho.org> (Johannes
	Schindelin's message of "Mon, 12 Oct 2015 11:40:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279417>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> I think the most sensible regression fix as the first step at this
>> point is to call it as a separate process, just like the code calls
>> "apply" as a separate process for each patch.  Optimization can come
>> later when it is shown that it matters---we need to regain
>> correctness first.
>
> I fear that you might underestimate the finality of this "first
> step". If you reintroduce that separate process, not only is it a
> performance regression, but could we really realistically expect any
> further steps to happen after that? I do not think so.
> ...
> For the above reasons, I respectfully remain convinced that
> reintroducing the separate process would be a mistake.

I am not saying we should forever do run_command() going forward.

But I do not want to keep the direct call to merge_recursive() in
'maint'.  The topic was supposed to be "rewrite in C".  I do not
recall (and do not feel the need to read "git log" output to find
out) exactly how the series progressed, but a logical progression
would have been to run merge-recursive via run_command() like I
showed in the quick-fix in an early part of the series, followed by
a patch to turn it into a direct call to merge_recursive() as an
optimization change.

And the latter step turned out to be a regression caused by a
premature optimization.  If something introduces a regression, it
gets reverted.  As the scripted version certainly did not make an
internal call, we should just run_command().  And that is what we
want to have in the stable version people use every day.

The only thing I am saying is that the change to make a direct call
should come on top of the run_command() version with its own
justification as an optimization patch.

Going that route may require you to redo your patch, measure
performance improvements, ensure there is no unintended fallout in
other callers and longer term maintainability of the codebaths
involved, write a good log message, etc.  And such a fix to
merge_recursive() needs to be cooked sufficiently in 'pu' and
'next'.  And I view all that as a good thing.  I really hate to see
that this premature optimization to come back and bite us again---we
didn't see it while reviewing because "builtin-am: implement --3way"
was done in a single step with premature optimization from the
beginning.

Now, there are many reasons why the "first step" might turn out to
be the permanent optimal solution.

I did an unscientific experiment to rebase each of the 25 topics
that are cooking in 'next' on top of 'master'.  Only 3 of them will
fall back to the three-way merge machinery.  One possible reason why
the "first step" could stay a good-enough solution is that people
would not care and/or notice, because it is not like you are paying
unnecessary cost to spawn merge-recursive for each and every change.
It only kicks in when the patch does not apply.

Then I randomly picked one (jc/merge-drop-old-syntax) of the three
topics that does fall back, made it into a patch and ran "am -3" on
top of 'master' with and without the "first step".  The numbers from
5 runs of each look like this:

    real    0m0.109s                      real    0m0.109s
    user    0m0.080s                      user    0m0.079s
    sys     0m0.034s                      sys     0m0.035s

    real    0m0.109s                      real    0m0.105s
    user    0m0.095s                      user    0m0.087s
    sys     0m0.018s                      sys     0m0.022s

    real    0m0.109s                      real    0m0.110s
    user    0m0.075s                      user    0m0.086s
    sys     0m0.038s                      sys     0m0.028s

    real    0m0.107s                      real    0m0.108s
    user    0m0.083s                      user    0m0.075s
    sys     0m0.029s                      sys     0m0.038s

    real    0m0.106s                      real    0m0.108s
    user    0m0.086s                      user    0m0.090s
    sys     0m0.025s                      sys     0m0.023s

I am curious to see a similar number on platforms with slower
run_command().  From the above numbers alone, I cannot even see
which ones are with run_command(), even though I know the numbers on
the right hand side column were taken with run_command() and the
numbers on the left hand side column were taken with internal call.

Another possible reason why the "first step" could stay a
good-enough solution is that merge_recursive() in itself is a
heavy-weight operation that the cost of spawning a process is not
even felt [*1*].  After all, it's not like we are talking about
spawning the cost of "update-ref HEAD" dominating the cost of the
actual operation.

By the way, in order to make sure that I am running the correct
binary, I did "strace -f -e execve" on "am -3".  "mailsplit" and
"mailinfo", both of which are a lot more likely to be affected by
the cost of spawning because they are mostly dumb and straight
text-to-text filters, are spawned via run_command() interface.  And
then we do "apply --index" (which is always done), and after seeing
that fail, we do "apply --build-fake-ancestor" and "apply --cached"
before finally spawning merge-recursive (or making a direct call
internally before the "quick-fix") when we fall back to threeway.

Among the run_commands() invocations in the "am -3", I do not think
the one that spawns "merge-recursive" is the most profitable one to
turn into an internal call.  Libifying mailsplit and/or mailinfo and
making them directly callable may be a lot more useful thing to do
if you want to avoid run_command().


[Footnote]

*1* That is what I am seeing here, but this _is_ platform dependent
and that is why I said I am curious.
