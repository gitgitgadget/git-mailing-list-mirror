Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4404C433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E306124B
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 16:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhDCQKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 12:10:06 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:24290 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236364AbhDCQKG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 12:10:06 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 73D342003FC;
        Sat,  3 Apr 2021 18:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1617466172;
        bh=C5e6Muvz69h6/vwO4gUJNygFBXq64POFNkMEhOEPjRo=;
        h=Date:From:To:Cc:In-Reply-To:Subject:From;
        b=SFxnxJkRMwx8vx9N7U1dXbtnFr8pLWxj1CvgbH6XoAchTxlyTKKk4gc5j9mWOkX86
         ifygzJiNDLWgco/97qlmLiu707JZ7y7EDh4FmVWEYEhNLoipocFux5uyRWEXBVRkQt
         pXarBb86fCpI9ScVOcOlFFsVT35yFG21HApOr3K0v7fGxiALGfaxQ4kfajFO/Q/Olg
         WIY0JPuCW4tigHcByUg3JMnGIivlbzmebONf8V4OKsvG8X/rf2jMZ1txKBuLg1I7zl
         zgRCav7O6nkMVCb0b3ubkQZ6kFmejnPYxVq3rHdxCc5YQ5xcOH6OUCYGYLnMf0FOPU
         lD34bymoT7j6g==
Date:   Sat, 3 Apr 2021 18:09:32 +0200 (CEST)
From:   ydirson@free.fr
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <667025246.521774815.1617466172428.JavaMail.root@zimbra39-e7>
In-Reply-To: <87zgyfmpif.fsf@osv.gnss.ru>
Subject: Re: git rebase --rebase-merges information loss (and other woes)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

> > 1. when a merge has been done with "-s ours", rebase replays it
> > without
> > any special options, I proceed with the manual resolution, and if I
> > just
> > --continue, the rebase mechanism believes I want to drop the
> > commit, which
> > could not be more wrong.  I can still be careful myself, and use
> > "git commit
> > --allow-empty" before --continue, but this feels awkward.
> >
> > Is there any compelling reason not record the merge here ?
> 
> This looks like rather easy case to fix indeed. I mean empty commit
> issue, not the original cause of the problem.
> 
> >
> > 2. more generally, when a merge has been done with special options,
> > it
> > would be a useful help in solving conflicts if rebase could use the
> > same
> > options.  Maybe we could allow the rebase "merge" instruction to
> > use more
> > merge options.  The user would still have to edit the instruction
> > sheet
> > manually for those, however, and we could then want "rebase -i" to
> > fill
> > them automatically, but that would seem to require recording the
> > merge
> > options somewhere to start with - maybe in a note.
> 
> That could help now an then, but doesn't solve the problem in
> general,
> as, first, the behavior of merge algorithms could change over time,
> and,
> second, the merge could have been performed with external merge
> algorithm in the first place, including entirely manual merge, and
> after
> all, the person rebasing may have no idea at all how the original
> merge
> has been achieved.
> 
> Recording information about merges at merge time has similar problems
> to
> recording information about renames, both being "obvious" solutions
> that
> in fact end-up being sub-optimal.
> 
> Fortunately, we still have the original merge handy, that Git simply
> doesn't care to take into account, see below.
> 
> >
> > 3. while it's made clear that any conflict resolution and
> > amendments
> > have to be redone, maybe we could provide some support for a common
> > use case, namely "sink that commit/fixup down".  The conflict
> > resolution would then be like "checkout $OLD && cherry-pick -n
> > $FIXUP".
> >
> > Maybe this could be activated by a merge option in
> > rebase-interactive
> > instructions, like "merge -C$OLD --fixup $F1 --fixup $F2".
> >
> > Would that seem reasonable ?
> 
> I still (as this has been already heavily discussed some time ago)
> believe that the most reasonable solution to all this is to rebase
> merges rather than to throw them away. Redoing them, as Git does, is
> wrong choice in most cases as what it means is that Git, despite the
> option name --rebase-merges (and even better old name
> --preserve-merges), simply still throws away your precious merge
> commits, only then it substitutes something potentially entirely
> different for them, often silently.
> 
> In addition to the problems you've encountered, silent drop of user
> content is possible, and what's worse than that for a content
> preserving
> tool? As a result, to be on the safe side, with current approach to
> handling merges during rebase, any non-trivial merge that is expected
> to
> be rebased (and how would one be sure it never will?) is to be very
> carefully performed in 2 commits: merge itself and fixups, otherwise
> chances are high fixups are silently lost during rebase.

This reminds me of the approach used in git-reintegrate: to get merges
redone without loosing the fixup, it allows you to do exactly this, and
then is able to use rerere information to redo that often-incomplete part
of conflict resolution.  Then it squashes the fixup commit in the merge,
and is able to do that as long as the fixup commit is reachable.

One thing we could do given a merge commit, and provided that 1. we have
access to rerere cache, 2. a "standard merge" was done, and 3. the merge
algorithm did not change, we can pretty easily derive the two "separate
commits" (or arguably "separate parts of the merge").

That alone could maybe form the basis of the "redo merge" you're suggesting,
and would already cover a good number of use-cases.

For the case where the rerere cache is not available any more, I saw
we have a contrib/rerere-train.sh script, although I never tried it, as I
had written mine at the time, though I felt it had left it had too many rough edges
to share.  I'm attaching it for reference, as it also creates the separate fixup
commit (originally for use by git-reintegrate).

In fact, I wonder how much replaying merges created by other strategies would
perform, if we simply try to apply this idea to them too.


However, before I get too high on the idea, I have to say that in the rebase
that triggered this mail the rerere cache failed to get used in a couple of
situations: I did not care to check but I'd wager those were the commits in
conflict with precisely the fixup I was bringing down below the merges.
In this case (quite lots of conflicts to re-resolve because of a one-line
conflict, I felt so bad), the "apply the one-line by hand and juste resolve
*that* conflict" approach was really effective - so maybe it makes sense to
provide the two options, which may be suitable for different situations.

> 
> Further, even this two-step approach doesn't solve all the problems.
> For
> instance, issues with merges being originally performed with
> non-default
> algorithm still remain (as in your case 1.) Moreover, if we notice
> that
> default (or any thereof) algorithm itself could change over time,
> inherent problems with the policy of recreating merge commits from
> scratch during rebase get even more obvious.
> 
> Overall, to get this right, Git should finally refrain (at least by
> default) from generally hopeless attempts to re-create merges from
> scratch on rebase. Instead it should try to actually rebase existing
> merges when user asks to preserve history shape. When and if
> automatic
> rebase fails, one of the options to resolve the issue, besides fixing
> rebase conflicts, is indeed to redo the merge, but then the user will
> be
> perfectly aware of particular re-merge, and will be responsible for
> the
> end result himself.
> 
> -- Sergey
> 
