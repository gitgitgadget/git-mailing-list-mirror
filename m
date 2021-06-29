Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8080CC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 15:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605D061D5E
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 15:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhF2PNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:13:39 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:17457 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhF2PNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 11:13:37 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2021 11:13:37 EDT
Received: from [79.233.236.111] (helo=[192.168.2.202])
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lyFEn-0005Yp-Gz; Tue, 29 Jun 2021 17:01:21 +0200
From:   Martin <git@mfriebe.de>
Subject: Re: feedback/idea about "switch -C" force create
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20eb626d-89b4-fe2a-7cf4-c596b634f0f8@mfriebe.de>
 <87wnqcg9k1.fsf@evledraar.gmail.com>
Message-ID: <7ba8386c-9355-fa99-3a9f-986a0b616e0f@mfriebe.de>
Date:   Tue, 29 Jun 2021 17:01:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87wnqcg9k1.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/06/2021 13:33, Ævar Arnfjörð Bjarmason wrote:
> I had some more general proposals for the UI of "git switch" recently at
> https://lore.kernel.org/git/877dkdwgfe.fsf@evledraar.gmail.com/
>
> None of that steps on the toes of the idea you have explicitly, but it's
> a very adjacent area, so I'd be interested to know what you think.
>

> I think it's quite confusing that "git switch" doesn't switch to a new
> "doesnotexist" branch on something like:
>
>      git switch doesnotexist
>
> But requires:
>
>      git switch -c doesnotexist

I think that creation should require a parameter.
If not you end up on a non tracking branch, while you might expect to be 
on a local tracking branch.


>   But it really
> should be:
>
>      # -n or -N for --new / --new --force (the latter just in case of a
>      # race, and just for consistency)
>      git switch -n doesnotexist

This is an interesting one. I haven't taken the time to check if there 
are other commands where a letter used as option, translates to a 
different option between different commands.
Using -n would be ok.

BUT it is only halve the issue
> (branch: add a --copy (-c) option to go
> with --move (-m), 2017-06-18) has the knock-on effect that we can't
> mirror the "git branch" UI. I.e. to make "switch" be "branch with
> checkout" for these common cases.
even if -c became -n, there still be plenty of people/scripts who would 
not be aware.

"-c" would have to be disused for a real long time, before I would feel 
comfortable to use it for another purpose.

Some users are stuck for long time on an old git version, depending on 
their OS. When they upgrade they may skip many releases.
So they could easily issue a -c for create, and trigger a copy.

As for "move", this is not the most intuitive name for "rename" anyway. 
(I get it, move the content to the new name, but its also move the old 
name, since that does not remain)
But all good letters are take (branch -r => list remotes)

I can see some sense, in a shortcut for "copy and switch".
But does git switch, need to have move/rename ?

Especially in the one branch only specified version
       git switch -m newname
does the same as
     git branch -m newname
The branch is renamed. There is no actual switch happening. The same 
branch is still checked out, just under new name.

       git switch -m newname  existingbranch
That would be a shortcut for rename, then switch. (not sure if that common)

> I.e. to me the ideal end state would be to deprecate (or at least
> warn/discourage) the "git branch -m" case where it does its own checkout
> (but for nothing else), and to make "git switch" a "branch with
> checkout" with the same -c/-C/-m/-M semantics, just also with a -n/-N
> for "create first".
I never thought as "git switch" as a "git branch" replacement.

I think those 2 are (and should be) distinct entities.
My understanding is, that "git switch" (and restore) are a result of 
the  fact that "git checkout" combined to many functions in one command.

Btw, a general issue...
"git reset" also is a case of "grab all".


> I.e. to me the ideal end state would be to deprecate (or at least
> warn/discourage) the "git branch -m" case where it does its own checkout
> (but for nothing else),
I am missing something?
   git branch -m
does not seem to perform a checkout?

Well, maybe it is depending on how you view it.
     git branch --move  current-name   new-name

If you say, it moves the content of current to new, then yes it does 
checkout new.
But it also does delete current (because the old name no longer exists.)

This is, why I think the whole think is more of a "rename".
But if this is a rename command, then you are still on the same branch, 
only under new name. And then, there was no checkout.


> So at the end of the day you still have to use "git branch" for these
> common (at least for me) operations of copy/move, *and* maintain a
> mental model that "-c" means "xyz" here, but "abc" there.
I think "git branch" should be the main command to deal with branches, 
but it should not do any checkout.
If it currently does "switch" depends on what --move really is.

> The "switch" command also solves the very real problem (and I believe
> this was the main motivation) of not knowing beforehand if "checkout"
> will interpret your "foo" as a file, a branch or whatever.
On top of that, by splitting the different operations that checkout 
performs to new commands (with IMHO easier to remember name) also makes 
it easier to learn.
For a new user checkout just combined to many things.
For a seasoned user this is of course not that much of an issue.

For example  if you give "git checkout" a branch name, then you switch 
to that branch. Ok.
But If you give "git checkout" a branch and a file, you do not switch:  
git checkout master~2 Makefile  (get only the file)

The latter is now
    git restore --source=master~2  Makefile

It is a few chars more to type. But it is much more expressive what it does.
The command name alone makes it clear, this is not "switch".


There are also small improvements, like switch now insists on --detach. 
checkout would be happy to go without it.




