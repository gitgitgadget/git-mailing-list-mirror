From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 05 Sep 2013 11:20:43 -0400
Message-ID: <5228A14B.3000804@bbn.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com> <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com> <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com> <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com> <20130904081047.GB2582@serenity.lan> <xmqqa9jso69u.fsf@gitster.dls.corp.google.com> <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley> <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 17:20:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHbMe-0004cQ-33
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 17:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3IEPUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 11:20:52 -0400
Received: from smtp.bbn.com ([128.33.0.80]:48550 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931Ab3IEPUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 11:20:51 -0400
Received: from socket.bbn.com ([192.1.120.102]:55463)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHbMT-000LNU-7O; Thu, 05 Sep 2013 11:20:45 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A7FBB408BD
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233962>

On 2013-09-04 18:59, Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> John Keeping <john@keeping.me.uk> writes:
>>>
>>>> I think there are two distinct uses for pull, which boil down to:
>>>>
>>>>     (1) git pull
>>> ...
>>> Peff already covered (1)---it is highly doubtful that a merge is
>>> "almost always wrong".  In fact, if that _were_ the case, we should
>>> simply be defaulting to rebase, not failing the command and asking
>>> between merge and rebase like jc/pull-training-wheel topic did.
>>>
>>> We simply do not know what the user wants, as it heavily depends on
>>> the project, so we ask the user to choose one (and stick to it).
>>
>> We only offer a limited list. It won't be sufficient for all use
>> cases. It wasn't for me.
> 
> Very interesting. Tell us more.

I'm a bit late to the discussion, but I wanted to chime in.  I detest
'git pull' and discourage everyone I meet from using it.  See:
<http://stackoverflow.com/questions/15316601/why-is-git-pull-considered-harmful>
for my reasons.

Instead, I encourage people to do this:

   git config --global alias.up '!git remote update -p; git merge
--ff-only @{u}'

and tell them to run 'git up' whenever they would be tempted to use a
plain 'git pull'.

I usually work with a central repository with topic branches.  I follow
this rule of thumb:
  * When merging a "same-named" branch (e.g., origin/foo into foo, foo
    into origin/foo), it should always be a fast-forward.  This may
    require rebasing.
  * When merging a "differently-named" branch (e.g., feature.xyz into
    master), it should never be a fast-forward.

In distributed workflows, I think of 'git pull <collaborator-repo>
<their-branch>' as merging a differently-named branch (I wouldn't be
merging if they hadn't told me that a separate feature they were working
on is complete), so I generally want the merge commit.  But when I do a
'git pull' without extra arguments, I'm updating a same-named branch so
I never want a merge.

When merging a differently-named branch, I prefer the merge --no-ff to
be preceded by a rebase to get a nice, pretty graph:

       * merge feature.xyz  <- master
       |\
       | * xyz part 3/3
       | * xyz part 2/3
       | * xyz part 1/3
       |/
       * merge feature.foo
       |\
       | * foo part 2/2
       | * foo part 1/2
       |/
       * merge feature.bar
       |\
       ...

The explicit merge has several benefits:
  * It clearly communicates to others that the feature is done.
  * It makes it easier to revert the entire feature by reverting the
    merge if necessary.
  * It allows our continuous integration tool to skip over the
    work-in-progress commits and test only complete features.
  * It makes it easier to review the entire feature in one diff.
  * 'git log --first-parent' shows a high-level summary of the changes
    over time, while a normal 'git log' shows the details.

> 
> When "git pull" stops because what was fetched in FETCH_HEAD does
> not fast-forward, then what did _you_ do (and with the knowledge you
> currently have, what would you do)?

I stop and review what's going on, then make a decision:
  * usually it's a rebase
  * sometimes it's a rebase --onto (because the branch was
    force-updated to undo a particularly bad commit)
  * sometimes it's a rebase -p (because there's an explicit merge of a
    different branch that I want to keep)
  * sometimes it's a reset --hard (my changes were made obsolete by a
    different upstream change)
  * sometimes it's a merge
  * sometimes I do nothing.  This is a fairly regular pattern:  I'm in
    the middle of working on something that I know will conflict with
    some changes that were just pushed upstream, and I want to finish
    my changes before starting the rebase.  My collaborator contacts me
    and asks, "Would you take a look at the changes I just pushed?"  If
    I type 'git pull' out of habit to get the commits, then I'll make a
    mess of my work-in-progress work tree.  If I type 'git up' out of
    habit, then the merge --ff-only will fail as expected and I can
    quickly review the commits without messing with my work tree or
    HEAD.

Even if I always rebase or always merge, I want to briefly review what
changed in the remote branch *before* I start the rebase.  This helps me
understand the conflicts I might encounter.

Thus, ff-only always works for me.  I might have to type a second merge
or rebase command, but that's OK -- it gives me an opportunity to think
about what I want first.  Non-ff merges are rare enough that the
interruption isn't annoying at all.

> In a single project, would you
> choose to sometimes rebase and sometimes merge, and if so, what is
> the choice depend on?  "When I am on these selected branches, I want
> to merge, but on other branches I want to rebase?"

My choice depends on the circumstances of the divergence.  It's never as
simple as branch X always has this policy while branch Y has that policy.

> Are there cases where you do not want to either rebase nor merge?
> If so what do you want to do after "git pull" fetches from the other
> side?  Nothing?
> 
> 	Side note: a knee-jerk response to a "yes" answer to the
> 	last question from me has always been "then why are you
> 	running 'git pull' in the first place.

Habit/muscle memory/I'm tired and not thinking 100% clearly.

-Richard
