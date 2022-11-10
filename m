Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7336EC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKJVWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiKJVVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 16:21:50 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50AA31DCE
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 13:21:47 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668115305; x=1668374505;
        bh=XuFFy1cvZdwWqKVoAm+N+5jquCuDhgVKxdWlZUyO5NQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=0fD1ly8/c7ohvMIYr5IH22v44LdCq0jqjSL3mZ2kDhjaCrZosMJ7GBeSCPb4au3Ui
         gYXLvb92YYz7KUl6OiwTT+vttxFTDLuYUG1vMG66+t7DZ+ROKc5Xuct88zGZh4Dl4q
         eelFmMYNsvUO5OVkAQF9fvnyRL8TEXAwZV+fYROsRsd3Qq10g71md3octtswf7oXYT
         UT010aqy3FU9RuamGpX9gMb0TrIPAKvRKQdgpQUY18HLH+/1pbhpcmGs8uxWAT/dl+
         Ttlcre9AS5x06GR6DtQlhAr4q0AYAXdlgbOMyMrt8U2CV2/BgUoL84ibUwakuuD/+B
         JmEc0GqgILJ2w==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] worktree add: add --orphan flag
Message-ID: <20221110212132.3se4imsksjo3gsso@phi>
In-Reply-To: <CAPig+cRNpGUkRWW=q7-UckceeK0k37ncW-rH38boD=kY2oqLSg@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-4-jacobabel@nullpo.dev> <CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcdLCU5svw@mail.gmail.com> <20221104164147.izizapz5mdwwalxu@phi> <CAPig+cRNpGUkRWW=q7-UckceeK0k37ncW-rH38boD=kY2oqLSg@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/09 11:13PM, Eric Sunshine wrote:
> On Fri, Nov 4, 2022 at 12:42 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> > On 22/11/04 01:03AM, Eric Sunshine wrote:
> > > On Thu, Nov 3, 2022 at 9:07 PM Jacob Abel <jacobabel@nullpo.dev> wrot=
e:
> > > Are we sure we want to be modeling this after `git checkout --orphan`=
?
> > > If I understand correctly, that option has long been considered (by
> > > some) too clunky, which is why `git switch --orphan` was simplified t=
o
> > > accept only a branch name but no commit-ish, and to start the orphan
> > > branch with an empty directory. My own feeling is that modeling it
> > > after `git switch --orphan` is probably the way to go...
> >
> > I would argue that the `git checkout --orphan` command format is prefer=
able to
> > `git switch --orphan` when creating new worktrees. Reason being that in=
 many
> > cases (except when working in a new repo), if you are trying to create =
a
> > worktree from an orphan you will be doing it with a different commit-is=
h
> > currently checked out in your worktree than the one you want to use for=
 the
> > orphan (or you aren't in any worktree).
>
> I guess I'm not understanding the use-case being described here or
> that this series is trying to address. In my own experience, the very,
> very few times I've used --orphan was when I needed a branch with no
> existing history (i.e. "orphan") and with no existing files. For that
> use-case, `git switch --orphan` is ideal, whereas `git checkout
> --orphan` is a bother since it requires manually removing all content
> from the directory and clearing the index.
>
> > Requiring the commit-ish to be inferred would limit the user to checkin=
g out
> > an orphan from an existing worktree (in which case they could just crea=
te a
> > new worktree normally and use `git switch --orphan` to move that to an =
orphan
> > branch).
>
> I'm not following what you mean by inferred commit-ish. `git switch
> --orphan` does not infer any commit-ish; it starts the orphaned branch
> with an empty directory, hence there is no commit-ish involved.
>
> The `git switch --orphan` behavior was intentionally implemented to
> "fix" what has long been considered (by some) a UX botch in the
> behavior of `git checkout --orphan`. It was argued that in the vast
> majority of cases, people wanted an orphan branch to mean both "no
> history" and "no files". So, in that sense, it feels like a step
> backward to adopt `git checkout --orphan` when introducing `git
> worktree --orphan`.
>
> But, as I said, I'm genuinely not grasping your use-case, so I'm
> having trouble understanding why you consider `git checkout --orphan`
> a better model. If you can elaborate your use-case more thoroughly,
> perhaps it would help (at least me).

Ah I see where my misunderstanding was. I have significantly less experienc=
e
with `git switch` vs `git checkout` so prior to responding I was trying to
understand the difference in behaviour and I ended up misunderstanding what
`git switch --orphan` was doing.

I wrongly assumed that `git switch --orphan` was doing the same thing as
`git checkout --orphan` but using the currently checked out branch.
Additionally I had assumed that there was an important reason for being abl=
e
to create orphans from existing branches and that not being able to select
which branch to use would somehow be removing functionality.

After re-reading your replies, I can see that this is not the case and that
I jumped the gun on my reply prior to doing my research properly. I will ma=
ke
the requested change (moving from `git checkout` to `git switch` semantics)
for v3. Apologies for the misunderstanding.

