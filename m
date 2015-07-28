From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 00:38:03 +0200
Message-ID: <CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:38:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKDVp-0000cD-7k
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbG1WiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:38:12 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:49592 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbbG1WiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:38:12 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKDVh-000Mnl-Jv
	for git@vger.kernel.org; Wed, 29 Jul 2015 00:38:09 +0200
Received: by ykba194 with SMTP id a194so5686973ykb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:38:03 -0700 (PDT)
X-Received: by 10.170.163.6 with SMTP id f6mr40358126ykd.5.1438123083534; Tue,
 28 Jul 2015 15:38:03 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 28 Jul 2015 15:38:03 -0700 (PDT)
In-Reply-To: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274862>

On Tue, Jul 28, 2015 at 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> David Turner <dturner@twopensource.com> writes:
>>> All-caps files like NOTES_MERGE_REF are pseudorefs, and thus are
>>> per-worktree.  We don't want multiple notes merges happening at once
>>> (in different worktrees), so we want to make these refs true refs.
>>> ...
>> The two "rev-parse --verify" looks semi-sensible [*1*];
>> notes_merge_partial is all lowercase and it refers to
>> $GIT_DIR/notes_merge_partial, because they are shared across working
>> tree.
>>
>> But then why are $GIT_DIR/notes_merge_worktree/* still checked with
>> "test -f"?  If they are not refs or ref-like things, why should they
>> be downcased?  If they are, why not "rev-parse --verify"?
>>
>> [Footnote]
>>
>> *1* I say "semi-" sensible, because it looks ugly.  All ref-like
>>     things immediately below $GIT_DIR/ are all-caps by convention.
>>     Perhaps it is a better idea to move it under refs/; "everything
>>     under refs/ is shared across working trees" is probably a much
>>     better rule than "all caps but HEAD is special".
>
> I am not sure if "we don't want multiple notes merges at once" is a
> valid cause for this inconsistency in the first place.  When you try
> to start merging a notes tree in one place (leaving NOTES_MERGE_REF
> and friends in the ref storage shared across worktrees), should you
> be prevented from merging a different notes tree in another?  Isn't
> the whole point of having refs/notes/ hierarchy to allow different
> notes to hang underneath there, and isn't NOTES_MERGE_REF symref
> about keeping track of which one of them is being worked on in this
> working tree?

I believe the current M.O. for notes merge is to allow only one
simultaneous notes merge per _repo_. AFAIR, the notes merge code is
completely unrelated to the work tree (you could probably even do a
notes merge in a _bare_ repo), so IINM, the NOTES_MERGE_* refs should
be bound to the _repo_, NOT to the worktree.

So if I understand the pseudoref concept correctly, that should make
NOTES_MERGE_* "regular" refs, and not pseudorefs.

> We don't want multiple usual merges at once in different worktrees,
> either; rather, we don't want conflicting updates to the same branch,
> be it done by a merge or a single-parent commit, from different
> worktrees.  And the way we protect ourselves is by forbidding two
> checkout of the same branch by controlling what HEAD can point at.
>
> Making NOTES_MERGE_REF shared across working trees feels like
> solving that "no multiple checkouts" problem by making HEAD shared
> across working trees, ensuring that only one of them can have usable
> HEAD.  Instead, shouldn't we be solving the issue by allowing
> NOTES_MERGE_REF in multiple working trees point at different refs
> but ensuring that there is at most one working tree that updates one
> particular ref in refs/notes/ hierarchy?  Can't we learn from (and
> even better, reuse) the logic that controls HEAD for this purpose?
>
> I think it is OK for us to admit that the "notes" subsystem is not
> quite ready to work well with multiple working tree world yet [*1*],
> and move this series forward without worrying about them.
>
>
> [Footnote]
>
> *1* I am not saying that the notes subsystem can forever stay to be
>     second class citizen that does not know about multiple worktrees
>     or pluggable ref backends.  But my brief scan of builtin/notes.c
>     seems to indicate that there are quite a lot of work to be done
>     to prepare it for these two big changes.  My gut feeling is
>     that:
>
>     - NOTES_MERGE_REF symref is like HEAD, that is per working tree
>       but is controlled across working trees---no two working trees
>       can "checkout" the same refs/notes/* tree for conflict
>       resolution at the same time.

This sentence does not make sense to me. IMHO, a notes merge has
nothing to do with the worktree at all. Instead, the notes merge
creates its _own_ worktree (under .git/NOTES_MERGE_WORKTREE) when
needed (i.e. when there are notes conflicts to be resolved).

>       It should be all-caps and live
>       directly under $GIT_DIR/.

It should definitely live under $GIT_DIR (and not inside each
worktree's .git/). Whether or not it's all-caps is not that important
to me.

>
>     - NOTES_MERGE_PARTIAL is like MERGE_HEAD or the index in that it
>       is merely a state of in-progress merge that is private to a
>       single working tree.  $GIT_DIR/NOTES_MERGE_PARTIAL is just
>       fine, and we do not have to change it.

Agreed.

>
>     - NOTES_MERGE_WORKTREE is a temporary area in the filesystem
>       that houses bunch of blob files (i.e. notes contents).  It
>       should be per-working tree but it is not even refs.
>       $GIT_DIR/NOTES_MERGE_WORKTREE is just fine, and we do not have
>       to change it.

>From the notes merge perspective, NOTES_MERGE_WORKTREE _is_ the
worktree. There is no other worktree that is relevant to the notes
merge code. So I'm not quite sure how to handle notes merges in the
multiple worktree scenario. Do we expect users running notes merges
simultaneously from mulitple worktrees? If that is something we need
to support, why not take it one step further and support simultaneous
notes merges from a single worktree?

>
>     And as to adjusting to the "ref backend with pseudo ref" world,
>     I think the code is more-or-less ready, especially because your
>     recent round of this series teaches the "pseudorefs private to
>     working tree" to update_ref() and delete_ref(), relieving the
>     ref API users like notes subsystem from having to worry about
>     them.
>
>     So the only potential issue in the notes subsystem is to ensure
>     NOTES_MERGE_REF from multiple working trees do not point at the
>     same thing at the same time, with a similar protection we have
>     for HEAD, I think.

Agreed. Namespacing the NOTES_MERGE_* files based on the contents of
NOTES_MERGE_REF is probably the way to go here. I.e. instead of

  .git/NOTES_MERGE_REF
  .git/NOTES_MERGE_PARTIAL
  .git/NOTES_MERGE_WORKTREE

you would have (assuming NOTES_MERGE_REF == refs/notes/foo):

  .git/NOTES_MERGE/refs/notes/foo/REF
  .git/NOTES_MERGE/refs/notes/foo/PARTIAL
  .git/NOTES_MERGE/refs/notes/foo/WORKTREE

and then a simultaneous notes-merge on a different notes ref
(refs/notes/bar) would live in

  .git/NOTES_MERGE/refs/notes/bar/REF
  .git/NOTES_MERGE/refs/notes/bar/PARTIAL
  .git/NOTES_MERGE/refs/notes/bar/WORKTREE

Also, we would need support on the command side, i.e. "git notes merge
commit/abort" needs to be told _which_ notes merge to commit/abort...

However, in any case, notes merges are always per _repo_ and never per
_worktree_, so this is all unrelated to the current patch/discussion
AFAICS.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
