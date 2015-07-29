From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 04:34:14 +0200
Message-ID: <CALKQrge31G7-Ng8kZmy8=MgB+WQ3-bKimxCxOHOOwUMDuvRBzA@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:34:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKHCO-0000yw-0j
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 04:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbbG2CeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 22:34:23 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:49808 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbbG2CeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 22:34:23 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKHCG-0002o0-RI
	for git@vger.kernel.org; Wed, 29 Jul 2015 04:34:20 +0200
Received: by ykax123 with SMTP id x123so112411872yka.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 19:34:14 -0700 (PDT)
X-Received: by 10.13.206.133 with SMTP id q127mr41094442ywd.10.1438137254957;
 Tue, 28 Jul 2015 19:34:14 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 28 Jul 2015 19:34:14 -0700 (PDT)
In-Reply-To: <xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274876>

On Wed, Jul 29, 2015 at 2:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> Here is where we start to differ. I would say that starting a notes
>> merge is completely unrelated to your worktree. Consider this:
>> ...
>> This is not the case for notes merges. If I start a notes merge from
>> worktree A, there is no "occupation" of that worktree. Before the
>> notes merge is resolved, I can do whatever I want in worktree A
>> (including checking out a different branch, performing a rebase,
>> whatever...). Instead, the notes merge creates its own worktree (that
>> is "occupied" until the notes merge is completed), which is completely
>> unrelated to worktree A.
>
> That does not mean the notes merge that you started when you were
> sitting in worktree A has to be shared with worktree B, by say doing
> "vi .git/NOTES_MERGE_WORKTREE/$commit && git notes merge --commit".
>
> Also the above does not explain why it is sensible for you to forbid
> worktree B from doing an unrelated notes merge of a different ref
> under refs/notes/* while your worktree A is doing a notes merge.

I do not argue that it is sensible to forbid concurrent unrelated
notes merges. I argue that using linked worktrees is a poor solution
for concurrent unrelated notes merges.

A better solution does not concern itself with worktrees at all, and
does not need to add nonsensical conditions like:

    die_if_checked_out("NOTES_MERGE_REF", default_notes_ref());

A better solution does not need to add complexity to the branch or
linked worktree code to deal with notes merges. Instead, it simply
organizes the notes merge worktrees in such a manner that the correct
semantics naturally emerge.

Again, let's compare the two approaches (against the current situation):

Current situation:
 - A single $GIT_COMMON_DIR/NOTES_MERGE_*
 - Concurrent (unrelated or not) notes merges are simply not supported

Proposal A (please correct me where I have misunderstood what's proposed):
 - Each worktree has its own $GIT_DIR/NOTES_MERGE_*
 - Concurrent unrelated notes merges are supported, provided that you
create an additional linked worktree to "host" each concurrent notes
merge.
 - Logic must be added to ensure unrelated-ness, i.e. make sure that
the NOTES_MERGE_REF in worktree X is different from all other
worktrees' NOTES_MERGE_REF.

Proposal B:
 - The repo has a $GIT_COMMON_DIR/notes-merge/$ref/* hierarchy for
organizing concurrent notes merges
 - Concurrent unrelated notes merges are supported, independently of
whether you have zero, one, or several worktrees.
 - The notes merge code must be adjusted to work with the above
hierarchy, and must naturally fail if the user attempts to start a new
notes merge that would clobber an in-progress notes merge (only notes
merges to the same notes ref will clobber).

I obviously feel proposal B is superior to A, so I wonder what I have
missed about A that makes it preferable.

>> In principle, I agree that an ongoing notes-merge into
>> refs/notes/someotherthing should be able to coexist with an ongoing
>> notes-merge into refs/notes/commits. However, it does not make sense
>> to bind those notes-merges to a specific worktree.
>
> The thing is, the choice is between per worktree or per repository.
> Taking the latter would mean you can only be doing one notes merge
> at a time, even though you prepared multiple worktrees so that you
> can work on different things at a time.  It is true that there is
> nothing inherent that ties a note merge to a worktree (a worktree is
> tied to a branch that is checed out, and there is no tie between a
> branch and a notes tree), but "not inherantly tied to" does not
> automatically mean "has to be one per repository".  You'd ideally
> want to allow N workspaces for N refs/notes/* refs.
>
> But people work in worktrees, and that is their unit of working
> space.  From that point of view, unless you are proposing a
> completely different design where the primary worktree can be used
> only for manipulating notes (hence, you can have worktrees for
> resolving refs/notes/A and refs/notes/B, in addition to the other
> worktrees you use to advance branches), treating NOTES_MERGE_REF as
> a per-worktree entity just like HEAD and the index is, would be the
> most sensible comporise.

I believe it is a bad compromise. It complicates the code, and it
provides a concurrent notes merges that is unnecessarily tied to (and
dependent on) worktrees. For example, if I wanted to perform N
concurrent notes merges in a project that happens to have a huge
worktree, I would now have to create N copies of the huge worktree...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
