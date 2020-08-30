Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EABC433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 07:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E1D206D8
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 07:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgH3HUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:20:47 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45782 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgH3HUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 03:20:46 -0400
Received: by mail-ej1-f67.google.com with SMTP id i26so4071635ejb.12
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 00:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHlpYvt4iSmtqg1I/vA1F6nHzhehJd2YJrh9feTWZG8=;
        b=jXlZq4YFBufRxjUu9aEC5GRx8iNW4nr6ROEfX2G6rV5THQJvgFnYcaJXK0UwSlu66F
         vXsY5D5RxSx5kx7bIyXUJgi3iFuHK0PswmYzbdYFvoYZaHZs0OtHd5vcFjTvp0SHVxyt
         aCFpGVTkzeVhdJ8xLXpNEPWmEKXzzSmZJvk2EKP6P4i2A9Tx3dwptzNQT1+fyf7HS8RV
         LzluwI0VtMSNQA1L17sVusQlZCO5RxCJghH8tZLzlFcAL26lv5Un/fArSK4qrlg4/2vA
         pxnS5jaQ+UlWeNIVykLO0ltfeygE2k1FeUwhKR1kV+IkG1/cNAaFqCQXZ9GZln309QS1
         mcbw==
X-Gm-Message-State: AOAM531YnmGF8h/M8V9SEVAR6iImgZ4uBE9jjeBeOV07rGhyyAHgbhnm
        wiueqWD+w+s8Ay19xaVnSq5WXmGnwOIxzsFQ5XY7upVDAlA=
X-Google-Smtp-Source: ABdhPJx51vrJkNJbCVTzcmEKCsH6AyPPnHZiGaHKlbS4AQFMLN5xe4Uaa5Tvq3auI+H4W8G9UOVJkMgtkM15XvOrekQ=
X-Received: by 2002:a17:906:80da:: with SMTP id a26mr6457335ejx.311.1598772042707;
 Sun, 30 Aug 2020 00:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200827082129.56149-3-sunshine@sunshineco.com> <xmqqlfi0qaru.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfi0qaru.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Aug 2020 03:20:31 -0400
Message-ID: <CAPig+cT-ipENZQ39wpaGukRzx3d52OatKEXjWc3_mv56jMbDRg@mail.gmail.com>
Subject: Re: [PATCH 2/5] worktree: teach "repair" to fix worktree back-links
 to main worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 1:06 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > The .git file in a linked worktree is a "gitlink" which points back to
>
> Please never call it a "gitlink" (which is a word reserved for a
> cache entry with 160000 mode that typically point at a commit
> object, an implementation detail of the mechanism to bind a
> submodule to its superproject) to avoid confusing future readers of
> our code and documentation. The setup.c code calls it as "gitfile",
> since it was introduced at b44ebb19 (Add platform-independent .git
> "symlink", 2008-02-20), I think, and that is how it has been described
> in the glossary.

Thanks. I don't know why my brain latched onto "gitlink" even though I
noted the difference in the name read_gitfile_gently().

> > the .git/worktrees/<id> entry in the main worktree or bare repository.
> > If a worktree's .git file is deleted or becomes corrupted or outdated,
> > then the linked worktree won't know how to find the repository or any of
> > its own administrative files (such as 'index', 'HEAD', etc.). An easy
> > way for the .git file to become outdated is for the user to move the
> > main worktree or bare repository.
>
> I am not sure if a directory that used to be a secondary worktree
> would still appear to be a Git controlled worktree after its ".git"
> removed, but I guess a ".git" pointing at a wrong place won't,
> either.

The directory itself will be disconnected from its object database,
thus non-working, however, its .git/worktrees/<id> entry will still be
present, so the repository will still consider it a linked worktree.

> I am just curious how much more involved in dealing with the "is
> deleted" situation than "becomes corrupted" situation.

They are handled identically. "git worktree repair" simply visits each
.git/worktrees/<id> entry and checks if the /path/to/worktree/.git
gitfile points back to .git/worktrees/<id>. If it doesn't -- whether
because the gitfile is missing, corrupted, or simply pointing at the
wrong location -- it recreates the gitfile with the correct content.

> sequence, the user does
>
>   user goes to a directory D, thinking it is a valid secondary
>   worktree and wanting to work in it, and finds that Git does not
>   think it is.
>
>   user goes to X, which is the location of the primary copy, and
>   tells "worktree repair" that the directory D ought to be the top
>   of the working tree for a secondary worktree.
>
>   "worktree repair" creates/updates D/.git gitfile to point at X.
>
>   user comes back to D and starts working.
>
> because "git worktree repair" wants to do the usual setup sequence
> anyway.

Correct. Perhaps not 100% intuitive now that you mention it but that
sort of interface could be built atop the machinery provided by this
patch series, and I don't think this initial implementation needs to
have all the bells and whistles. Even with what is implemented by this
series, support becomes much easier -- simply ask the user to run "git
worktree repair" in the main worktree (or in any functional worktree)
-- than the situation presently which requires precise instructions
about how to patch administrative files by hand.

> > Move a working tree to a new location. Note that the main working tree
> > -or linked working trees containing submodules cannot be moved.
> > +or linked working trees containing submodules cannot be moved with this
> > +command. (The `git worktree repair` command, however, can reestablish
> > +the connection with linked working trees if you move the main working
> > +tree manually.)
>
> ... meaning after moving the main working tree, repair can be used
> to touch-up the submodule directories?
>
> Ah, no. You are saying "git worktree move" still cannot be used to
> move the main working tree (the ones with submodules in it we do not
> even care), but as a workaround, the user can "mv" it manually and
> run "repair" to fix all the secondary worktrees.

Seeing as the meaning wasn't clear upon your first reading, perhaps I
should remove this change? Or rewrite it in some way?

> Hopefully somewhere in the rest of this series it would become
> automatic? After all, instead of letting users "mv" things without
> us knowing what is going on, if we let them say "worktree move" the
> primary working tree, we know both the source and the destination
> directories of such a move, and because we know all the secondary
> worktrees, we can run "worktree repair" on them as part of this
> "worktree move" of the primary working tree.
>
> It is perfectly fine that it is not happening here in this step to
> keep each step digestible, of course.

Duy's original implementation did automatically repair worktree
administrative files but it ended up being buggy (I don't recall the
precise details) and discussion between the two of you resulted in the
functionality being removed with the possibility of resurrecting it
later. (Unfortunately, I can't find references to any of the
discussion right now.)

Automatic repair was definitely on my mind as I wrote this series, but
as something which could possibly be added later atop the machinery
implemented by this series.

> > +test_corrupt_gitlink () {
>
> See gitglossary::gitfile. We'd need to find all references to
> "gitlink" and "git link" in this series and decide which ones need
> to be fixed (there might be genuine references to gitlink---I
> haven't read the series through).

They all need to be fixed. There aren't any genuine gitlink references
in the series.

> > +static void repair_dotgit(struct worktree *wt,
> > +            worktree_repair_cb *cb, void *cb_data)
>
> "dotgit" is an OK name in this context, I would think. repair_gitfile
> is also fine, but "dotgit" may be more explicit.

I think I originally called the function repair_gitlink() but changed
it to "dotgit" to be more explicit. But now that I know "gitfile" is
the correct term, repair_gitfile() seems preferable.

> > +   /* missing worktree can't be repaired */
> > +   if (!file_exists(wt->path))
> > +       return;
>
> Shouldn't it be a bit stronger? if wt->path is not a directory, it
> cannot be the top of the working tree of a secondary worktree.

I'm not quite sure what you're asking. This code is saying that if the
path recorded in .git/worktrees/<id>/gitdir doesn't exist, then there
simply isn't anything we can repair.

> > +   strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
>
> OK, the need to use git_common_path() is a good justification why it
> is easier to implement if we initialize ourselves using the primary
> copy's repository data (i.e. require the user to start "worktree
> repair" in the primary copy or any working secondary worktrees, and
> let the normal setup.c sequence to prime us in the repository),
> instead of allowing the user to start at the secondary worktree
> whose gitfile got broken.

Yes, and this does highlight that there are conditions under which
"git worktree repair" simply won't operate. I did consider handling a
number of such conditions but ultimately decided that I'd rather keep
this initial implementation as simple and straightforward as
possible. Such improvements can be built atop.

> > +   if (repair) {
> > +       cb(0, wt->path, repair, cb_data);
> > +       write_file(dotgit.buf, "gitdir: %s", repo.buf);
>
> Shouldn't write_file() be monitored for its failure, and the failure
> reported back to the callback function?

Yes and no. write_file() will die() if it can't write the file. That's
not necessarily ideal behavior for a command which wants to repair
_all_ problems, and the decision to use write_file() was not one I
made lightly. The bigger picture is that, although "git worktree
repair" ideally should not abort when attempting repairs, there are a
number of library functions called by "git worktree repair" which
undesirably die(). And writing all that functionality from scratch or
enhancing those functions to have "gentle" modes would have made this
series far longer and far more complex. So, I eventually decided to
keep the implementation simple, with the idea that such enhancements
can be made later as needed and as we gain experience with the
command.

> > +void repair_worktrees(worktree_repair_cb *cb, void *cb_data)
> > +{
> > +   struct worktree **worktrees = get_worktrees();
> > +   struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
> > +
> > +   if (!cb)
> > +       cb = repair_noop_cb;
> > +   for (; *wt; wt++)
> > +       repair_dotgit(*wt, cb, cb_data);
> > +   free_worktrees(worktrees);
> > +}
>
> This "repair"s only in one direction. Manual movement of secondary
> worktrees, if we want to support repairing, needs the user to tell
> where the new location of the secondary is, and we need a code to
> update the record of the location of the secondary kept at the main
> worktree, which is not needed in the repair implemented by this
> step.

Correct. Patch [3/5] implements repair in the other direction.

> Looking good.

Thanks for the thoughtful review comments (including the ones to which
I didn't respond directly -- they will be addressed by the re-roll
itself).
