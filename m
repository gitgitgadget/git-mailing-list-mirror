From: Dimitar Bonev <dsbonev@gmail.com>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD
 state while preserving its staged state
Date: Sat, 4 May 2013 14:13:25 +0300
Message-ID: <CADeMBopNestsZT4maGr3+tdOBf_Q0ukUbRCbXyucOiZZeHx6nQ@mail.gmail.com>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	<87obcryvcw.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 04 13:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYaPK-00087o-Vd
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 13:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757151Ab3EDLNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 07:13:30 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36241 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339Ab3EDLN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 07:13:26 -0400
Received: by mail-pd0-f169.google.com with SMTP id 14so1313672pdc.0
        for <git@vger.kernel.org>; Sat, 04 May 2013 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=d/ROd0eg4R2v46mm2ktAaF6rc8+o7TdWrj1kP3sYyBw=;
        b=NC5BCKTNwFYvhKCvEPSeZeg2kvI4hDc7hUq0yqFcbvGvCiMEIPIYq2AuVLIFTWSgm1
         SXBGR3A2wANg70q8pZc08+pN/RvFnmRCG+miQ/sbBNCoDAsv5HqdeLARKGfu5/4aVgH0
         8zQMlcDUwfpUNYBv2XKqMFifNMRI2Ni94RAoKgFUXd2t3GjcaOZ4BZ77xBtttintencz
         84AcVJAY/09+uoNmH3YFFpyad0FDnMLs9oATFA0EmEQ3vsoBNzpYt+A9FUcWXk5CJAU0
         qNQshqJCDxBxOVqxn5vOzizM9x0Cb3XaLz9jwzYTXA7D1h8FzHAHSnxl9haA/lEE9Gdl
         cykQ==
X-Received: by 10.68.60.130 with SMTP id h2mr17331459pbr.208.1367666005530;
 Sat, 04 May 2013 04:13:25 -0700 (PDT)
Received: by 10.70.78.37 with HTTP; Sat, 4 May 2013 04:13:25 -0700 (PDT)
In-Reply-To: <87obcryvcw.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223364>

I think if there was such a command, it could well be common, at least
for me. I am somewhat surprised that  from the three combinations of
resetting index and working dir's states of a file this is the one
that is missing (it is missing at commit level also for what is
worth). Summary table of resetting commands is present at the end of
this article: http://www.progit.org/blog/2011/07/11/reset.html

Here is how I see the workflow for a file: you start with a state that
matches the HEAD state, you modify the file until reaching the point
of a sufficient solution, you mark it as finished work by staging it
for the next commit, now that you have a solution you can start over
from the HEAD state of the file and try to improve it by choosing a
different path of implementation.

My initial thought was to checkout the file, but surprisingly this
reset the staged state also in addition the working dir's state.
Generally git-checkout modifies the working tree, but indeed if you
use its form for a single file and specify a treeish argument it will
"update the index for the given paths before updating the working
tree". I am curious which are the valid use cases for this behavior of
git-checkout and if it was the right thing to do to implement it this
way. In its current form git-checkout does more work than expected by
me:

git checkout HEAD -- targetfile

The above command should have been implemented to reset the working
dir' state of the file only and if one wants to reset its staged state
he could use 'git reset HEAD targetfile'. This gives you more
flexibility (reset one state, the other state or both states),
git-checkout has more consistent behavior (git-checkout a file and
git-checkout a branch keeps your staged changes), and makes harder to
lose your staged changes (there is a reason for a change to be staged
so it should not be so easy to lose it). As the current behavior is
released I guess it couldn't not be (or it should not be at all)
accommodated to the one described above, so at least another
command/option should be added to implement it.

@ThomasRast: 'git show HEAD:targetfile > targetfile' was proposed in
the both links that I provided in the email that your replied to, but
this introduces external dependency to the command interpreter to
output the file unmodified but not every interpreter does this.
PowerShell in particular modifies the encoding of the file, so I get
strange behavior: 'git diff' states that html files are binary ones
and it does not show me the differences; 'git apply' prints 'fatal:
unrecognized input'. I tried your second suggestion 'git commit'
followed by 'git revert', but this reverses the states of all
committed files. I prefer something that applies to a single file,
like git-checkout and git-reset do. Here is a set of commands more
close to what I wish:

git commit -m 'a provisional stable solution'
git checkout HEAD~1 -- targetfile
git commit  --amend -am 'add solution to problem x'

This requires more commands, makes assumptions about making a commit
to a branch, deviates from the rest of git commands about resetting a
file's state (inconsistent git API).

On Sat, May 4, 2013 at 11:58 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Dimitar Bonev <dsbonev@gmail.com> writes:
>
>> I have been looking for such a command/option and no one gave me
>> sufficient answer. So this message should be considered as a feature
>> request. I had a situation where I had staged a file with a problem
>> solution in it, then I wanted to experiment with a different solution
>> so I had to revert the file to its HEAD state and I couldn't find a
>> way that preserves the staged state of that file. More discussions:
>>
>> https://groups.google.com/forum/?fromgroups=#!topic/git-users/nYiN-rE_3i0
>>
>> http://stackoverflow.com/questions/16335799/git-porcelain-command-to-revert-a-single-file-to-its-head-state-but-keep-its-sta
>
> Is that a common enough issue to warrant a better solution than
>
>   git show HEAD:targetfile > targetfile
>
> which is how we would do it?
>
> Or more likely,
>
>   git commit -m WIP
>   git revert -n HEAD
>
> which is safer anyway, since it doesn't lose the formerly-staged state
> so easily (you have the reflog in case of any mistakes).
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
