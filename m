Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F583C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E2223741
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 10:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgLQKXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 05:23:50 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:37764 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQKXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 05:23:49 -0500
Received: by mail-ej1-f52.google.com with SMTP id ga15so37060016ejb.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 02:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUeFbu4O3Yrxc+7avqwt6zZKmWftZghkeR/gIwifcNg=;
        b=gN69n7qBxCxvROgnRum0VHiC5NxR7nOKl5O7WN+N0mP8cJcNx5YgFd/IMUJoJkjXWb
         wiYMLKI2pYOmd4wviLm/1oL8UzxpbArEEPQSzlahX5cFQKCcaVceqSJDipn5IfcTPD/v
         EnO9WVEAt0ljXXlkSxwOm1vhq+HNwngbmXTKDbM2RFlzk81nfnpfW6dsvMvKkM0C7Kx8
         zu20dpCaOU9XYw11LjnyiV6r3TbIj/Ax5RSkfq0/AlGdCMgARH8QJWGe2RH2a3nHSU3z
         3cj30ZVoqt1TdyNADUWMZksjOZAVw6mLE2aQhMvjScHWTmhud3yXstqvcVi+vRyarGdz
         B0xQ==
X-Gm-Message-State: AOAM5327dsmH8omw7/G9GyClYgJ9K9CNmNx6W3hSPgOt8ybu4VSbfpe2
        ftZ7XU8Z1W8wisxwSyT8pp0yOwJyYvaq1XGnRoY=
X-Google-Smtp-Source: ABdhPJxBMXG3Lry4YipiqtBdG/uHEthZz/dbR/n/zW5ivAn+5kBbmtloZZCOn0Ty+d796DxAWqlNYLKndl1Q1/8Dz8Q=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr34641703ejb.168.1608200585481;
 Thu, 17 Dec 2020 02:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20201208173705.5770-1-sunshine@sunshineco.com> <xmqqwnxs55rn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnxs55rn.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Dec 2020 05:22:54 -0500
Message-ID: <CAPig+cQT2Cj4i=2kq_svMyKiFmNLxvpa5kG=XNeaT+8UD5238Q@mail.gmail.com>
Subject: Re: [PATCH] worktree: teach `repair` to fix multi-directional breakage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 4:48 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > However, if both the repository and the worktrees are moved, then links
> > are severed in both directions, and no repair is possible. [...]
>
> Third, when a worktree of an unrelated repository is moved to
> location the worktree moved like that used to occupy, or an
> unrelated repository is moved to the repository moved like that used
> to occupy, the gitfile of the moved worktree would point at an
> unrelated repository (which may not even be a clone of the same
> project).
>
> There probably are other failure cases possible.

There are indeed many ways to shoot oneself in the foot.

> Perhaps having to
> notice and fail when both worktree and repository moved (i.e. the
> case your patch handles) indicates that we would need to be able to
> handle such a situation sensibly as well?  Do we leave some clue to
> help us validate that the repository the gitfile points at indeed
> corresponds to the one our worktree works with and vice versa?  If
> we don't currently, should we?

We only have the paths making the two-way link between the repository
and the secondary worktrees. Specifically, the outgoing
<repo>/worktrees/<id>/gitdir points at /path/to/worktree/.git, and the
incoming /path/to/worktree/.git points at <repo>/worktrees/<id>.

As for the scenario you mention about moving a worktree to the
location previously occupied by a worktree belonging to a different
repository, or moving a repository to a location previously occupied
by a different repository, it is certainly possible to get into odd
situations. For instance, if  "worktree-A" from repository "A" is
moved to the location previously occupied by "worktree-B" from
repository "B", then "worktree-A" won't consider itself broken, but
both repositories "A" and "B" will consider the worktree broken
(because "A" will complain that "worktree-A" is missing, and "B" will
complain that "worktree-A" doesn't point back at "B").

I alluded to such confusion in my original response[1] to Philippe by
saying that, if not careful, a heuristic for inferring the new
location could end up hijacking a worktree from a different
repository.

So, there is no mechanism for reliably associating a worktree with a
repository, and this limitation isn't specific to secondary worktrees
created by `git worktree add`. There is no reliable association
between the repository (which may have been split off with
--separate-git-dir, for instance) and the main worktree either. This
may suggest the need to assign unique signatures to the repository and
each worktree (including the main worktree), but such a change
requires plenty of thought and is far outside the scope of this simple
enhancement to `git worktree repair`.

[1]: https://lore.kernel.org/git/CAPig+cT=-nNcfrzjSmTXymhFkB22bPFE6QRKXqPtat2ipUdboQ@mail.gmail.com/

> > Fix these shortcomings by teaching `repair` to attempt to infer the new
> > location of the <repo>/worktrees/<id>/gitdir file when the location
> > recorded in the worktree's gitfile has become stale but the file is
> > otherwise well-formed.
>
> Hmph, after reading the "first" and "second" above a few times, it
> is unclear how this "inference" would work.  The gitfile points at
> the old location of the repository, which was moved to elsewhere
> without telling the working tree (i.e. "First" problem), so...?

The inference is intentionally simple-minded. There is no path-based
inference or other heuristic at play; the entire inference is based
upon <id>. The worktree's path is specified as an argument. `git
worktree repair` manually reads the ".git" gitfile at that location
and, if it is well-formed, extracts the <id>. It then searches for a
corresponding <id> in <repo>/worktrees/ and, if found, concludes that
there is a reasonable match and "repairs" <repo>/worktrees/<id>/gitdir
to point at the specified worktree path.

I can update the commit message to describe the heuristic rather than
requiring the reader consult infer_backlink() in the patch itself, if
that would help.

The patch incorporates two safeguards to avoid hijacking a worktree
from a different repository. The first, as described above, is that it
requires an <id> match between the repository and the worktree. That
itself is not foolproof for preventing hijack, so the second safeguard
is that the inference will only kick in if the worktree's
/path/to/worktree/.git gitfile does not point at a repository. I can
mention these safeguards in the commit message, as well.

It's still possible to bypass the safeguards by moving the foreign
repository too, in which case the foreign worktree being repaired
won't point at its repository anymore, thus there is no 100% guarantee
of safety (without the introduction of unique signatures mentioned
above). However, the goal of this patch (and `git worktree repair` in
general) is to help users recover from what are likely to be common
problems, not to protect users from shooting themselves in the foot by
the many means available.

A couple observations if, despite the safeguards, the user does manage
to hijack a worktree: (1) the problem will likely be noticed quickly
when, for instance, `git status` reports the bulk of the worktree's
files as untracked and other expected files missing due to the
mismatched `index`; (2) it's easy enough to recover from the situation
(without damage) by manually patching <repo>/worktrees/<id>/gitdir and
/path/to/worktree/.git, which is what the user would have had to do
anyhow prior to the existence of `git worktree repair`.

> > -     repair_worktrees(report_repair, &rc);
> >       p = ac > 0 ? av : self;
> >       for (; *p; p++)
> >               repair_worktree_at_path(*p, report_repair, &rc);
> > +     repair_worktrees(report_repair, &rc);
>
> The reason why repair_worktrees() has to wait until the individual
> repairing is done for all the given paths in the new code is...?

Because the repair can't succeed if both halves of the two-way link
are broken, but can succeed if at least one half is sound. As
described above, the worktree path is specified as an argument to `git
worktree repair` and the new inference may allow
repair_worktree_at_path() to repair the outgoing
<repo>/worktrees/<id>/gitdir, thus restoring one half of the two-way
link, which then allows the subsequent repair_worktrees() to repair
the other half, the incoming /path/to/worktree/.git file.

I realized even when writing the commit message that the reason for
this particular change might not be obvious, but I also was concerned
that I wouldn't be able to explain it in a succinct way without
overwhelming the rest of the commit message. However, I can try to
come up with suitable phrasing and incorporate the explanation into
the commit message.

> > +test_expect_success 'repo not found; .git not referencing repo' '
> > +     test_when_finished "rm -rf side not-a-repo && git worktree prune" &&
> > +     git worktree add --detach side &&
> > +     sed s,\.git/worktrees/side$,not-a-repo, side/.git >side/.newgit &&
> > +     mv side/.newgit side/.git &&
> > +     mkdir not-a-repo &&
> > +     test_must_fail git worktree repair side 2>err &&
> > +     test_i18ngrep ".git file does not reference a repository" err
> > +'
>
> Failing upon empty directory and things that do not make sense is
> good.  A more interesting or realistic case would have the side/.git
> gitlink points at an unrelated repository because the user moved the
> repository and replaced it with another repository, which has the
> ".git/worktree/" directory and even ".git/worktree/side" directory.

Detecting that sort of situation is outside the scope of this patch
since `git worktree repair` itself can't presently detect it. Some
future enhancement may make this possible, but the current change
doesn't deal with it.

This test is aimed specifically at verifying that
repair_worktree_at_path() now specially handles
READ_GITFILE_ERR_NOT_A_REPO returned by read_gitfile_gently() rather
than lumping it together with the other generic errors returned by the
function. It recognizes this specific error because, as a safety
mechanism against hijacking, the new inference is only attempted when
READ_GITFILE_ERR_NOT_A_REPO is returned.

> > +test_expect_success 'repair moved main and linked worktrees' '
> > +     test_when_finished "rm -rf orig moved" &&
> > +     test_create_repo orig/main &&
> > +     test_commit -C orig/main init &&
> > +     git -C orig/main worktree add --detach ../side &&
> > +     sed s,orig/side/\.git,moved/side/.git, \
>
> The pattern needs anchored with '$' to the right, in order not to
> get confused by a substring like "ooorig/side/.gitto/" that appears
> in the $(cwd).

Well spotted. The test I added just above this test correctly anchors
the pattern, but I forgot it here. Will fix.

> > +             orig/main/.git/worktrees/side/gitdir >expect-gitdir &&
> > +     sed s,orig/main/.git/worktrees/side,moved/main/.git/worktrees/side, \
> > +             orig/side/.git >expect-gitfile &&
>
> > +     mv orig moved &&
>
> Hmmm, so this single move is what moves both the repository with the
> primary worktree and the secondary worktree.  Does the "fix" assume
> that the relative location between them do not change?  How realistic
> is that, I wonder?

As mentioned above, the inference is not path-based; it relies only
upon matching up the <id>. So this `mv orig moved` is just a
convenient way to relocate both the repository and worktree; it is not
intended to convey any meaning about the inference mechanism. However,
to avoid potentially misleading readers, I can revise the test to work
with distinct paths and manipulate them separately.

> In any case, I think the problem description in the proposed log
> message is quite well written but the solution seems unclear.

I'll update the commit message to talk about the <id>-based inference.
