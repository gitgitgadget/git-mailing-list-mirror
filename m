Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3604C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D3E20776
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbhACWpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 17:45:03 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:39621 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhACWpD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 17:45:03 -0500
Received: by mail-ej1-f51.google.com with SMTP id n26so34563451eju.6
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 14:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8ngV1777UDIjGS3hPmGK6ZjkvpmV32UapbLif0tMNo=;
        b=RVq7Rev0oLbX80saf+LDNw4tCZH3xCjCTufB0a/PLwAMKVXS/KVUXvK1OxE3Dvkuix
         WmI9HRyOp0YclrWJNIjFS0abRviN/3pzGiVfhToX1i1yPsfwM0Uq81VGkKoWHwf+3dsl
         3PxIu7CbreL4v9hmoYE079PX3M+/Whjd5bqepdyYe7eiKcbRNb2+VI901HCAIsHr53ga
         isvxjxKzDU/T412fFNDshG2U1BL0VJgvXNJIoTe3f1nDyyGI98zf2unYlXwHIMegmbFv
         bvkcVhf+SscSwfYh1Mw1rtcr8g1Q39XlFO99cIjLU2nIJ2/P7c/PE3tSq1uajb0/FPxB
         rS0w==
X-Gm-Message-State: AOAM533WhUZGGUyCFrN++IABRm7XhCvpRfKA2GfK7XE3SsT0xQD3DNBW
        YM6hYAoLe6deGLsXlbYapG6qE9XkqFuaK9iz+bmnR5ThmLmC4A==
X-Google-Smtp-Source: ABdhPJyHmOsKGtlOC2GXGrtMpCM314mL1HB8T/7c/0U0exUgJzWmq5HWfycgjimlmNCUZcEm/nV5IcXmstOID6NRgog=
X-Received: by 2002:a17:906:7f83:: with SMTP id f3mr53646046ejr.282.1609713860757;
 Sun, 03 Jan 2021 14:44:20 -0800 (PST)
MIME-Version: 1.0
References: <CAAVLcG5Z0UnKVyBYyvPXdPWU-Q0-jEaUC=f3gDxZoaKqSUKN3g@mail.gmail.com>
 <4e508192-c3a9-4cac-3255-1324aba347d4@kdbg.org>
In-Reply-To: <4e508192-c3a9-4cac-3255-1324aba347d4@kdbg.org>
From:   Andrew Oates <andrew@andrewoates.com>
Date:   Sun, 3 Jan 2021 17:44:09 -0500
Message-ID: <CAAVLcG69j8MHDEbEBWrFjbApm1jSzU3WciP_VHCu-N3Mw4BJzw@mail.gmail.com>
Subject: Re: git pull/rebase bug: when "onto" branch has rebasing branch's
 commits in reflog
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 3, 2021 at 5:33 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 03.01.21 um 23:02 schrieb Andrew Oates:
> > I've poked at the source code but haven't found exactly what causes
> > the issue --- but if you do a 'git pull --rebase' or 'git rebase' onto
> > a tracking branch that has previously pointed to a commit that the
> > rebasing branch includes, the rebase will be a noop.
> >
> > In practice I've hit this a few times lately when splitting a topic
> > branch into two branches after the fact.
> >
> > Here is a short repro:
> > ```
> > git init
> > touch file1
> > git add file1
> > git commit -a -m "first commit"
> > touch file2
> > git add file2
> > git commit -a -m "second commit"
> > touch file3
> > git add file3
> > git commit -a -m "third commit"
> > git checkout -b branch
> > git branch --set-upstream-to=master
> > git checkout master
> > git reset --hard 'HEAD^1'
> >
> > touch file2.5
> > git add file2.5
> > git commit -a -m "second-and-a-half commit"
> > git --no-pager log --oneline --all --graph
> >
> > #rm .git/logs/refs/heads/master
> >
> > git checkout branch
> > git pull -v --rebase
> > git --no-pager log --oneline --all --graph
> > ```
> >
> > This outputs,
> > * 58432a7 (branch) third commit
> > | * 0e4f775 (HEAD -> master) second-and-a-half commit
> > |/
> > * 37b2e3f second commit
> > * 5e9f0b7 first commit
> > ...
> > Successfully rebased and updated refs/heads/branch.
> > * 0e4f775 (HEAD -> branch, master) second-and-a-half commit
> > * 37b2e3f second commit
> > * 5e9f0b7 first commit
> >
> > showing that "third commit" is lost.  If you execute the "rm ..."
> > line, then the sequence works as expected, and the final state is,
> >
> > Successfully rebased and updated refs/heads/branch.
> > * b636309 (HEAD -> branch) third commit
> > * 410a5dc (master) second-and-a-half commit
> > * 41981d0 second commit
> > * 286398d first commit
> >
> > My best guess is that there's something odd happening in get_fork_point().

Yeah, I guess this is actually WAI, though the outcome was surprising
to me (git silently dropped my commits).  Of course, after poking for
a while, as soon as I sent this I found some clear documentation for
the behavior :)  Under the git rebase docs:
"If your branch was based on <upstream> but <upstream> was rewound and
your branch contains commits which were dropped, this option can be
used with --keep-base in order to drop those commits from your
branch."

In that case, maybe this is a UX suggestion rather than a bug report.
I experienced this via "git pull" rather than "git rebase", which I
generally consider a pretty safe thing to run --- but in this case,
git silently dropped my commits (which luckily I noticed).

Thoughts on how this would be less surprising to me as a user,
 1) somehow make it just DTRT (though per the rebase --fork-point
docs, and your point, this may not be possible/desirable)
 2) document these commits out when checking out the branch[1]
 3) after a pull, log how many such commits were "dropped" for this reason

As it currently stands, the behavior is surprising --- the commits
that get rebased don't match either what is printed when checking out
the branch, or by the summary in the docs ("This is the same set of
commits that would be shown by git log <upstream>..HEAD"), and the
commits are dropped silently.  The fact that the commits are somehow
tied to the old branch via the reflog breaks my mental model of branch
history not being semantically important, or the fact that "git pull"
in two repositories that are otherwise identical would have a
different outcome based on the individual history.

[1] it currently says something along the lines of "...and have X and
Y different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)", which I've
always assumed would mean that (barring stuff like duplicate commits),
I would end up with X+Y commits after pulling.
>
> To me, the outcome looks reasonable:
>
> By the time when the branch was created, it had no commits on top of
> master. Then master was rewound and grew in a different direction, while
> the branch didn't do anything. When you rebase it to its upstream, you
> should expect that no commits are rebased.

FWIW in the cases where I've actually hit this, I had additional
commits on top of the new branch, so only the commits at the "bottom"
were dropped (which is much harder to notice).  I think the difference
is whether you consider the dropped commits part of the original
branch (now discarded), or the new branch --- my mental model was the
latter, in part because I didn't realize that branch history was
actually semantically important.

>
> -- Hannes
