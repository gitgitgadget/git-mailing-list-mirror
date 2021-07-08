Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B58C07E99
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 23:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A1861469
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 23:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhGHXPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 19:15:02 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:28491 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhGHXPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 19:15:00 -0400
Received: from [84.163.72.131] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1dBg-0004GN-Uz; Fri, 09 Jul 2021 01:12:08 +0200
Subject: Re: What actually is a branch?
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
Date:   Fri, 9 Jul 2021 01:11:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e762243aab1_30a7b02089@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2021 22:37, Felipe Contreras wrote:
> Technically a branch is a file with an object id in it. That doesn't
> give the user any useful information.
> 
> What is important is the *meaning* of that file.
> 
>> People indeed tend to thing, I branched at X, so anything before is not
>> part of the branch.
>> "--contains" says otherwise.
> 
> Yes, that is the status quo, but the fact that X is the case doesn't
> mean it *should* be the case.

Well yes. So lets start over.

A branch is a container for commits. Those commits have a start (root or 
base / not sure), and an end (head).
The commits are continuous, in that they have no gaps.

The big question is the start point of the branch.

And there is a further consequence:
If a branch "starts" at "base" then
  --contains  needs to be changed
  --reachable needs to be added (for what contains does now)

This also complicates it, because now there are 3 types of relation 
between commits and a branch
- unrelated (outside / not reachable)
- inside (base..head)
- reachable (base and all its parents) // better word needed

The last is important:

A => B => C master
      \ => D  foo

If I delete master, without the concept of reachable, I would expect 
commit A to be dropped. Technically B should drop too, but it takes some 
insight to expect that.
So then with only the branch foo left, I would also have only the commit 
D (well maybe B too, if the system is lenient)

One might even go an say if master is deleted, then the base of foo is 
deleted. since foo must have a base, and it no longer has, foo can not 
exist any longer.

The problem here is that git permits to change history.
If branches could not be rewritten or deleted, then the "base" would be 
a simple concept.
No branch would ever have to look what was before its base.
But as it stands, branches must reach to what was before their base.


> 
> A branch that you hold, or point to, is a concete concept easy to
> underand. When I say: "me, my sister, and my father are one tiny branch
> of the Contreras family", people understand what that means inuitively.
> 
> On the other hand saying "Felipe contains his great-great-grandfather"
> would stop anyone on their tracks.

The Chicago branch of your family contains Al Capone.
That works.

Contains is also nice, because we have 2 boundaries (base/head) to 
enclose the selection.


> But if you do `git reset --hard origin/master`, you are saying: drop
> everything about this branch, and make it the same 'origin/master'.
> *Now* we have a reason to distinguish `git merge --ff-only` from `git
> reset --hard`.

No you don't. IMHO not.
"reset --hard" resets the branch to a commit. You can specify that 
commit by giving a branch-name (that then will be resolved). But it 
could be any commit, even a detached one.

So "reset --hard" has to set the base and the head to the same commit. 
Effectively creating an empty branch based at that commit.

But local tracking branches still are counter intuitive.

IMHO local tracking branches should follow one of the following 
scenarios. (And ideally that should be the same for all local tracking 
branches, for any user.)

1) Always have the same base as their remote branch.
Therefore always have the same content as the remote branch, up to where 
they diverge, if they diverge.

2) Not include the remote branches content. Just hold my local commits, 
until they will be pushed to the remote.

But neither works:

Say I have a local commit, and you pushed new changes to the remote.
    git pull --rebase
My branch is rebased.
So my local tracking branch has its base at the head of the remote. It 
has only local commits => case 1.

Say I have no local commits, and you pushed new changes to the remote.
    git pull --ff-only
If I understand correct the --ff-only move the head of my local branch, 
but leaves the base where it is.
Now I have some shared commits with the remote branch.
=> either case 2, or worse none of the 2 cases.

So, how should local tracking branches behave?


> If you send a pull request for your 'master' branch, which then gets
> merged to 'origin/master', then you can do `git merge --ff-only` to
> advance the head pointer of the 'master' branch to the remote branch so
> both are in sync... Except the base won't be the same.

There may be something I missed. ff should not touch the base?
So the 2 base will still be the same or not the same, depending on if 
they were equal before the ff?


>>
>> So yes, what is a branch? More exactly what does it contain.
>> Two examples, that to me suggest two answers.
> 
> Not necessarily. See above.

I feel we must have some understandingly on the part how base and local 
branches would interact.

You agree: rebase changes the base (it creates a new branch on to --onto)

You pointed out there also is fast-forward. But see my above example.
I am not even doing a pull request. I simply go for you and I both can 
push to the same remote. So we both commit to master and pull/push it.



> 
>> Also if branch@{base}..branch  then there is a problem.
>> - branch@{base} is then correctly not part of the branch
>> - So immediately after "git switch -c branch" the branch is empty => ok
>> But if so, then what is the branch head at that time?
>> The Pointer would point the @{base}, but @base is outside the branch. So
>> the pointer of the branch points outside the branch?
> 
> Yes, the base pointer doesn't include the branch. When you do
> `branch@{base}..branch` that's the same as `^branch@{base} branch` so that
> excludes all the commits rechable from branch@{base} *including* that
> commit iself.

My question is, where you see the branch head pointing to?
If the branch is empty, i.e. if it has no commit at all, then to what 
commit does the branch head point?



>> The only problem is:
>> branch is too often used for "the commits contained in the branch". That
>> is way to common to even try to stop it.
> 
> We don't need to stop it, we can sidestep it.
> 
> Instead of talking about the branch, talk about the branch head:
> "the brach head is moved to X".

Yes well, we need to be very concise, if we speak about anything that is 
not the "commits in the branch".


>>> When you change the branch head you are effectively changing the branch.
>> Well if branch is the pointer, then you change the branch, and head is
>> being changed.
>> If branch is the content, then you change the head, and yes the content
>> changes.
> 
> Exactly, so regardless of which semantics you choose, everyone
> understands that the branch is not the same anymore.
> 

Your original text was
> When you change the branch head you are effectively changing the branch.
> If @{base} existed, then changing the base would also change the branch
> (although that would be a much less dangerous operation).
> 
> Does that make sense?

And yes, if either boundary changes, the branch changed.


