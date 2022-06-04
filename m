Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6ABC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 20:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbiFDUUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiFDUUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 16:20:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E63D128
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 13:20:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o10so14073938edi.1
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WSrgn52jtszxjkPmPcagDz5HO2e7lJI4uHPWEaHhjyo=;
        b=N6H6vV7mQ4pWCwDbp4XC1Hr3TPnfs8J1IohFXlhv8YMsNQyZZzbFj/+6WhuFQRGbks
         pLtJ+eOcGzWf1xV41jMny7E5Ip4mKkSulJ0fGhogGMwmwtTvljE+Ja7NP0u547XX8gbR
         ynANqNQE9JP62IZTZaLhsmlr1HUdjhvSWiUw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WSrgn52jtszxjkPmPcagDz5HO2e7lJI4uHPWEaHhjyo=;
        b=5oshIA5sNGytFGHj6BZkdSJYDuVQCOp03FfvnDz0K6VMO4znF53CLbqIO7YBQteSrp
         OH8uy1WBZcGNvbYtcH8iOe+qJkCCt5RSdPXms43syOLvXwiFHNAsuM+CNB5Y60F1Yr5c
         NTwseE4XFkZ5wmQDKI5scg3PyBo7qt+MWt39NWNDk+B9B6jP2B0e1dviJf2izr1tQV7d
         Gh7iaN2bCzPvQN8bOgbCHK8mwlzWih0pqSeRX0eLSwxLnPlBMpR7AY7WRR58AcksxNkY
         XFtOZwncSt1uO+QaqWB+KN90bWmJz6Ev8dctPrlqN4v2bZE6GPoLBz44JlbElHhz5yVN
         RNIg==
X-Gm-Message-State: AOAM532TDAR9xfvojjoNv1Va2WX3x8bkmcYGJ41tloCL7S8tj8jaJZfY
        f+K0uvPGkY1tnK9pOCZAKspKPtqR4BlXXTwoxHCB2jNuf/POa87Z
X-Google-Smtp-Source: ABdhPJzWW5RCS7KUXC6jy9Wwu0AKGpR2kYxln8LFkyC0/M9R69+VeeXpdV7bzwdFIEcuz5nmkjy4l8Y9A97uavKbg+o=
X-Received: by 2002:a05:6402:1857:b0:42d:bcd6:3a88 with SMTP id
 v23-20020a056402185700b0042dbcd63a88mr18104404edy.6.1654374035084; Sat, 04
 Jun 2022 13:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <87h750q1b9.fsf@gnu.org>
In-Reply-To: <87h750q1b9.fsf@gnu.org>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 4 Jun 2022 22:20:24 +0200
Message-ID: <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(resending as text-only after having stupidly replied from my mobile)

I can add a couple things that may or may not be related here. I work
with a large proprietary repo, like you, and it is also not absurdly
large. I maintain some custom tooling for a large scale perforce
interop process.

I used to use "git show" (without patch) in this custom tooling to get
commit metadata, because it has the advantage that you can specify an
arbitrary list of commits in one call, saving some process overheads
in Windows especially.

I stopped using "git show" when user reports of slowness eventually
revealed two things:

1. Large commits (eg merges to feature branches from the fast-moving
main trunk) were taking a surprisingly long time, despite the
no-patch, which made me think it was doing the patch work anyway, and
just discarding it at the end.

2. Merge commits from long-outdated feature branches, even though the
final patch displayed by "git show" is small, also take a long time.
It seems as though whatever patch-related work "git show" does (and
given your observations I guess it might well be rename-detection), it
does it with respect to *both parents* in the case of a merge request,
even though the patch it shows is only changes wrt the first parent.

All this to say: I haven't understood your branch setup, but I'm
guessing that you're regularly integrating work from "far-behind"
branches, and most or all of your commits on master are therefore
merges with large diffs wrt the second parent, and those large diffs
wrt the second parent are what's "getting worse".

I haven't attempted to debug this, and personally have little
incentive to do, as switching to "git log" and accepting the process
overheads solved *my* problem.

If I get the chance to, I will obviously report back here.

Thanks,
Tao

On Sat, Jun 4, 2022 at 10:29 AM Tassilo Horn <tsdh@gnu.org> wrote:
>
> Hi all,
>
> [spoiler alert: I've figured out the config option causing the problem
> while writing this long mail, so you might jump straight to the SOLUTION
> section at the bottom of this mail.]
>
> at my day job, I work on a git repo (sadly non-public, proprietary) with
> these stats:
>
> - master has about 150000 commits, the last release branch I've also benc=
hmarked above has 144000 commits
> - the history dates back to 2001
> - .git/ is about 1.8 GB
>
> So it's quite big but not unusually big when compared to linux or other
> free software projects.
>
> The typical git commands I use (status, fetch, pull, commit, push,
> rebase, ...) are all quick.  However, I use the git porcelain Magit [1]
> which invokes several plumbing commands in order to present to the user
> an always up-to-date extended status buffer of the currently checked out
> branch showing the current branch.  Some of those plumbing commands are
> extremely slow for no obvious reasons.  The most outstanding command I
> could pinpoint is this:
>
> --8<---------------cut here---------------start------------->8---
> =E2=9D=AF time git show --no-patch --format=3D"%h %s" "master^{commit}" -=
-
> 6192a0cfdc6 Merge remote-tracking branch 'origin/SHD_ECORO_3_9_7'
>
> ________________________________________________________
> Executed in   13.21 secs    fish           external
>    usr time   12.99 secs  462.00 micros   12.99 secs
>    sys time    0.17 secs  119.00 micros    0.17 secs
> --8<---------------cut here---------------end--------------->8---
>
> The interesting thing is that I have this problem only with the master
> branch.  When I run it for the last release branch, I get these times:
>
> --8<---------------cut here---------------start------------->8---
> =E2=9D=AF time git show --no-patch --format=3D"%h %s" "SHD_ECORO_3_9_7^{c=
ommit}" --
> 994334fc9fb ECOJ-33833 HTML-Formbrief: Bestellungs-Anh=C3=A4nge im KV-Kon=
text
>
> ________________________________________________________
> Executed in   22.68 millis    fish           external
>    usr time    7.71 millis  761.00 micros    6.95 millis
>    sys time   10.47 millis  194.00 micros   10.28 millis
> --8<---------------cut here---------------end--------------->8---
>
> So you see, it's almost a factor of 1000 difference!  How can that be?
>
> The split between master and the SHD_ECORO_3_X_X series of branches has
> happened almost 2 years ago and master is way ahead of those.
>
> --8<---------------cut here---------------start------------->8---
> =E2=9D=AF git log --oneline master...origin/SHD_ECORO_3_9_7 | wc -l
> 5013
> --8<---------------cut here---------------end--------------->8---
>
> But there are around 9 merges from the last release branch into master
> daily.
>
> --8<---------------cut here---------------start------------->8---
> =E2=9D=AF git log --merges --oneline --since 6months | wc -l
> 1611
> --8<---------------cut here---------------end--------------->8---
>
> From my memory, the issue hasn't popped up out of sudden but has gotten
> worse slowly over time.  I have the impression that the worsening
> increased pace over the last few month which might be the result of our
> workflow.  Before, I've been the merge guy doing two "merge waves" from
> the last supported release branch upwards into master once or twice a
> day (usually release-branch -> next-release-branch -> master).  Since
> about 3 month, we've switched to a workflow where every developer does
> merge upwards herself just after committing/pushing to some lesser
> branch than master simply because branches have diverged so much that
> you'd need to be an expert in everything in order to be able to resolve
> conflicts sensibly.
>
> I should mention that I haven't seen this issue with any other repo I
> have.  But that's also the biggest one I use.  The Emacs repository I
> also work on is comparable in the number of commits but with much less
> merges.
>
> At last, here's the git bugreport sysinfo section on that machine and
> repository.
>
> --8<---------------cut here---------------start------------->8---
> [System Info]
> git version:
> git version 2.36.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.18.1-zen1-1-zen #1 ZEN SMP PREEMPT_DYNAMIC Mon, 30 May 202=
2 17:53:16 +0000 x86_64
> compiler info: gnuc: 11.2
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /usr/bin/fish
>
> [Enabled Hooks]
> --8<---------------cut here---------------end--------------->8---
>
> SOLUTION
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> While writing this long mail, I've figured out that the performance
> penalty is caused by my setting of diff.renameLimit =3D 10000.  If I
> comment that option in my ~/.gitconfig, the above command finishes in
> 150 millis instead of 13 seconds:
>
> --8<---------------cut here---------------start------------->8---
> =E2=9D=AF time git show --no-patch --format=3D"%h %s" "master^{commit}" -=
-
> 6192a0cfdc6 Merge remote-tracking branch 'origin/SHD_ECORO_3_9_7'
>
> ________________________________________________________
> Executed in  147.99 millis    fish           external
>    usr time  114.52 millis  713.00 micros  113.81 millis
>    sys time   34.78 millis  193.00 micros   34.59 millis
> --8<---------------cut here---------------end--------------->8---
>
> But there's still the question why diff.renameLimit has an influence
> here when --no-patch is provided so no diff should be generated.
>
> Bye,
> Tassilo
>
> [1] https://magit.vc/
