Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E39C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE7461D8B
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhF2Nr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:47:57 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:64516 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhF2Nr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 09:47:56 -0400
Received: from [79.233.236.111] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lyE2A-0005pk-Ja; Tue, 29 Jun 2021 15:44:14 +0200
Subject: Re: feedback/idea about "switch -C" force create
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20eb626d-89b4-fe2a-7cf4-c596b634f0f8@mfriebe.de>
 <87wnqcg9k1.fsf@evledraar.gmail.com>
From:   Martin <git@mfriebe.de>
Message-ID: <eb3e0019-a127-cf75-6679-347b6d98140d@mfriebe.de>
Date:   Tue, 29 Jun 2021 15:44:42 +0200
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
>
> Makes sense. So basically the users are not using "-C" as some typo for
> "-c" (e.g. as a result of using the readline M-u key-combo), but mean
> "force", they just don't know what "force" actually does, and lose data.
>
> While I suspect the answer is something like "they had no idea, git
> errored, and they tried another option" I'd be interested if you know
> what these users were expecting the "force version of -c" to do in this
> case & what the use-case is.
There are 2 groups of scenarios.

1)
New users sometime mess up their branches. They may have started on the 
wrong branch and now want to fix the fork point, or the branch diverted 
from the remote and they try to fix the "cannot fast forward". Or they 
created an earlier branch with the same name, and want to re-use it.
Often it is something where a local branch needs rebasing.
In the last case, the earlier branch should be renamed. So that is a 
real user error. But new users are not always aware, how commits are 
hold by branches (I.e. they expect them to stay without needing a branch).

Of course, here the extra force flag needed, only helps, if the error 
explains what is going to happen. So users will not just blindly add the 
force flag.

2)
For the more experienced users, it comes down to oversight. The may 
honestly believe that there was a 2nd branch holding the commits.
I've seen people having a 2nd branch on their feature branch. Maybe 
where the 2nd branch added some commits on top of the feature branch, 
but the feature branch has not yet diverged.

However if you believe your feature branch hasn't diverged -- while in 
reality it has diverged -- then you would expect commits to be hold by 
the 2nd branch.
Therefore you would not expect any loss, from the switch -C.
This could be because you want to push feature~10, and then fast forward 
to your 2nd branch and continue on your local work.
   git switch -C feature  feature~10

And that should mean: I have another branch holding the commits, and I 
use force because I do not care about the exact commit this branch was on.

While, if you really mean: "Move my branch, and drop whatever may get 
dropped" you do
   git switch -f -C feature  new-location
indicating your additional awareness, that there are (or could be) 
commits that will get dropped (you could do -D instead of -f (Drop/Delete))

So you give 2 params that say both "force", if you mean to force 2 actions.


> ...so just to clarify, do you mean that forcing it would be OK if you
> advance the branch, so in git.git terms you could do:
>
>      git switch -c mynewbranch master # creates new branch
>      git switch -C mynewbranch next
>
> Which would be OK since what's in "next" is in "master", But doing the
> reverse would error:
>
>      git switch -c mynewbranch next # creates new branch
>      git switch -C mynewbranch master
Yes going forward (move to children of the current commit) will preserve 
the existing commit, and is fine.

Going to parents, would loose commits. Unless those commits are hold by 
any other branch.
I.e. if an feature branch diverge from some child of the current commit, 
then the feature branch will hold the commit that you move away from.

So it is not needed for the branch that is moved, to keep holding the 
commit. Any other branch does fine too.



> Do you think just a plain "-c" should also error if you "lose" a commit
> by committing on a detached head, or that should be treated differently
> (and if so, why?). I.e.:
>      
This is an interesting idea.

And, yes I think that this should be done too.
At least for "git switch", which being marked as experimental does allow 
for those changes.
Changing "git checkout", may cause problems for users relaying on the 
behaviour.

However, I agree for the reason of treating it equal, and only for that 
reason.

The scenario with the detached commit, is something that an experienced 
user could fall for, if they "forget".

But it is less an issue for newbies. At least, if they are taught to use 
"git switch", and don't use "git checkout" at all.
"git switch" does not let you detach by accident. It requires you to 
specify --detach.
So users should be aware they are detached.

With "git checkout" you can indeed get easily detached, without having 
intended this. (Back in my newby days, when git switch did not even 
exist as an idea, I learned that the hard way)


> I mean, you could pun on that warning for what you're suggesting, but it
> seems to me that it would be sensible that they're consistent, no?
Yes.

> I.e. either we don't error on -C and give a similar useful warning (now
> we don't say anything), or error on both.
Yes.
Adding a warning would be an option too.

I think the error is more sensible though. It makes sure it is not 
overlooked.
And, this is why there are "force" options.

I.e. switching from a detached commit, requires one count of force (to 
loose the commit)
git switch -f some-branch

Recreation of an existing branch, and at the same time loosing commits, 
should require to counts of force
git switch -f -C existing-branch new-location

If force is used, the warning can be reduced to
         $ git switch -f -C existing-branch new-location
         Info: The commit ABC123456 and <n> parents were dropped.

Since the user forced it, recovery info is not needed. But I would not 
object to include a line
        To recover those commits run
          git branch new-name ABC123456


> Don't read any of the above as disagreement with your proposal, just
> spitballing ideas & edge cases.
Absolutely. I did not expect my idea to be pitch perfect.
It's an idea, it needs to grow into a well formulated plan.

>> There could be
>> - a git config to  toggle this

> Ideas are most welcome, unfortunately the git project is almost entirely
> limited by who can come up with patches.
I understand this too. I participate in other open source projects, so those limitations are not new to me.

  
> I had some more general proposals for the UI of "git switch" recently at
> https://lore.kernel.org/git/877dkdwgfe.fsf@evledraar.gmail.com/
>
> None of that steps on the toes of the idea you have explicitly, but it's
> a very adjacent area, so I'd be interested to know what you think.

I will reply in a 2nd email.

  

> If the "I won't be able to provide a patch" has to do with not thinking
> you have the know-how to do so I and others would be happy to
> help.
At the moment it is a time restraint.


> E.g. in the case of the documentation change you can even do the change
> entirely on the github.com/git/git web UI, no C compilation
> etc. needed. Our Documentation/SubmittingPatches has more info on the
> general process.
Making a mental note of it.

> Most of the actual work in doing the sort of change you're suggesting is
> the leg-work of figuring out the relevant UI edge cases. E.g. I could
> write (and could provide you, if you want to run with it) a patch for
> "git switch" that dies on "-C" unless "--force-i-really-mean-it" or
> whatever is provided. The real work is then going through the test
> failures, checking/explaining that each thing you need to change as a
> result makes sense etc.
As I said, it's a not enough time issue.
And C is not my main field. I do not even have a work environment set up 
for it. Not an excuse, just an "needs even more spare time"
Unfortunately it's not likely I will find that time soon, but if I can 
find it, and get to the point were I can set up an environment to run 
the tests, I may come back on this.
It is a slim "if" though.


> I think your idea of a config option for this sort of thing might make
> sense, but really only if it's done in a more holistic way. That's
> basically saying "I wouldn't like the small change you want unless it's
> a more general feature", but I think for users having just *one* of our
> many --force options behave this way would just be more confusing than
> not.
Agreed. But then that part can currently be left out.
It becomes an entire feature of it's own.

