From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 01:43:28 +0200
Message-ID: <CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 01:43:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKEXC-0006T4-BB
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 01:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbbG1Xnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 19:43:37 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:56600 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbG1Xng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 19:43:36 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKEX0-000OWD-HW
	for git@vger.kernel.org; Wed, 29 Jul 2015 01:43:34 +0200
Received: by ykdu72 with SMTP id u72so109616519ykd.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 16:43:28 -0700 (PDT)
X-Received: by 10.170.172.212 with SMTP id o203mr41001921ykd.22.1438127008613;
 Tue, 28 Jul 2015 16:43:28 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 28 Jul 2015 16:43:28 -0700 (PDT)
In-Reply-To: <xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274866>

On Wed, Jul 29, 2015 at 12:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> However, in any case, notes merges are always per _repo_ and never per
>> _worktree_, so this is all unrelated to the current patch/discussion
>> AFAICS.
>
> Thanks for chiming in, but I actually think you are confused.
>
> "git merge" is always per _repo_ in the sense that the result of a
> merge of a topic to the 'master' is recorded in the 'master' which
> is per-repo.  In the multi-worktree world order, that does not
> change.  What changes is that you could have different worktrees
> that check out different branches.  Worktree A may have 'master'
> checked out and do the merge there to update the tip of 'master'.
> But while worktree A is doing that, worktree B may have 'next'
> checked out and do an unrelated merge there.  Once worktree A leaves
> 'master' by checking out another branch, worktree B is free to check
> out 'master' and do further merges there.  Merging into 'master' is
> per _repo_, but the act of merging is per worktree.

Agreed thus far.

> I think merges of refs/notes/commits and refs/notes/someotherthing
> works exactly the same way.  In worktree A, you may decide to merge
> a notes tree refs/notes/commits with somebody else's.

Here is where we start to differ. I would say that starting a notes
merge is completely unrelated to your worktree. Consider this:

When you start a "regular" (non-notes) merge in worktree A, that merge
will "occupy" worktree A for the purpose of completing the merge, e.g.
conflicting files will be checked out inside worktree A, and it is
obvious that you cannot do other/unrelated things in worktree A until
you have resolved the conflicts and completed the merge. As such, a
regular merge is inextricably bound to a specific worktree.

This is not the case for notes merges. If I start a notes merge from
worktree A, there is no "occupation" of that worktree. Before the
notes merge is resolved, I can do whatever I want in worktree A
(including checking out a different branch, performing a rebase,
whatever...). Instead, the notes merge creates its own worktree (that
is "occupied" until the notes merge is completed), which is completely
unrelated to worktree A.

>  It may
> conflict and you may need to "lock" refs/notes/commits from being
> touched by other worktrees while resolving that, but that does not
> mean other worktrees cannot do a merge of refs/notes/someotherthing
> at all.

In principle, I agree that an ongoing notes-merge into
refs/notes/someotherthing should be able to coexist with an ongoing
notes-merge into refs/notes/commits. However, it does not make sense
to bind those notes-merges to a specific worktree.

Let's say I have two worktrees, A and B, and from worktree A, I have
started a notes-merge into refs/notes/commits. Now:

 - From worktree B I should NOT be able to start another notes-merge
into refs/notes/commits.

 - From worktree B I SHOULD be able to start another notes-merge into
refs/notes/someotherthing

But this doesn't really have anything to do with worktree B. I can
just as easily say:

 - From worktree A I should NOT be able to start another notes-merge
into refs/notes/commits.

 - From worktree A I SHOULD be able to start another notes-merge into
refs/notes/someotherthing

My conclusion is therefore that binding a notes merge to a specific
worktree does not make any sense. Preventing simultaneous notes merges
into the same notes ref is something that must be solved per _repo_
(and not per worktree), and since the worktree plays no part in the
resolution/completion of the notes merge, it makes more sense to place
all the notes-merge-related refs/files inside the _repo_, and not
inside the worktree.

Now, we do not yet support simultaneous notes merges at all, but my
follow-on point is that the addition of such support is wholly
independent of the multi-worktree support. For now, it would make more
sense to only allow a single notes-merge across all worktrees. I.e.
when starting a notes-merge from ANY worktree, it should simply fail
if there is an existing unresolved notes merge (no matter which
worktree started that unresolved notes merge).

>  The temporary area you use for merging notes, i.e. the
> working tree as far as notes merge is concerned, is private to
> worktree A and does not need to be seen by other worktrees.

Disagree. The private area used to resolve notes merges should be per
_repo_, not per worktree. That is IMHO the only sane way to (in the
future) prevent simultaneous notes merges going into the same notes
ref.

> So while you are working on merging and resolving, that intermediate
> state is *NOT* per _repo_ at all.  It is at most per worktree (Yes
> you could extend and have one notes_merge_ref per each refs/notes/*
> ref to make it even finer grained to allow more than one notes merge
> going on inside a single worktree, but I do not think it is worth
> it).

As stated above, my position is that while you are resolving a notes
merge, the worktree from which you started that notes merge is
completely irrelevant. In fact, you can easily do a notes merge in a
_bare_ repo...

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
