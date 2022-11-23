Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7555C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 02:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiKWCrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 21:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiKWCrg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 21:47:36 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10F63E8
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 18:47:32 -0800 (PST)
Date:   Wed, 23 Nov 2022 02:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1669171650; x=1669430850;
        bh=GR5YbFHNw+Gs0pCkxcguwci8ui7yv/xgPdsOelOx3a8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=1pmHOT84ZXSqaGnvCZPvxYrJMLP+j9vgScESQ2bNac+A5ga5lHdyDHa7hvfn44dOt
         nbOfbTQnDMOsrWiPmMaqLZdDWcF6m3s/67hVHCLj5WwMZEairE4ELDBdIW/gtEEJ5q
         cN60yBkDLrqxqeIU6RYsDw60EYplid4J9IygtTedxaF0f1TmMunK6HfUgVhs2/FG50
         eWBJnlPxHVJ4M8Z5FWpF5KnPNcWDX6INxYhz0TeFTkuk55nACVbL2+g3Y6AEOqtlNH
         KEymRDZGuAELqCETJZlzUxsdQjDBhonDjKqlChooBnmQwm/P78VBqltAegoE7W/Q1B
         D6Tc7sLeRZbiQ==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221123024711.6whxch3lngauyvf2@phi>
In-Reply-To: <221123.86a64ia6bx.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com> <221117.86sfihj3mw.gmgdl@evledraar.gmail.com> <20221119034728.m4kxh4tdpof7us7j@phi> <221119.86a64nf9k5.gmgdl@evledraar.gmail.com> <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com> <20221122232647.2jdsp5kioq7muymb@phi> <221123.86a64ia6bx.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/23 12:55AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Tue, Nov 22 2022, Jacob Abel wrote:
>
> > On 22/11/22 12:16AM, Eric Sunshine wrote:
> >> On Sat, Nov 19, 2022 at 6:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> >> <avarab@gmail.com> wrote:
> >> > On Sat, Nov 19 2022, Jacob Abel wrote:
> >> > > I'd support adding an `advise()` for at least the basic case where=
 you try to
> >> > > create a worktree and no branches currently exist in the repositor=
y.
> >> > > i.e. something like this:
> >> > >
> >> > >     % git -C foo.git worktree add foobar/
> >> > >     hint: If you meant to create a new initial branch for this rep=
ository,
> >> > >     hint: e.g. 'main', you can do so using the --orphan option:
> >> > >     hint:
> >> > >     hint:   git worktree add --orphan main main/
> >> > >     hint:
> >> > >     fatal: invalid reference: 'foobar'
> >> > > and
> >> > >     % git -C foo.git worktree add -b foobar foobardir/
> >> > >     hint: If you meant to create a new initial branch for this rep=
ository,
> >> > >     hint: e.g. 'main', you can do so using the --orphan option:
> >> > >     hint:
> >> > >     hint:   git worktree add --orphan main main/
> >> > >     hint:
> >> > >     fatal: invalid reference: 'foobar'
> >> >
> >> > I think those would make sense, yes.
> >>
> >> Yes, this sort of advice could go a long way toward addressing my
> >> discoverability concerns. (I think, too, we should be able to
> >> dynamically customize the advice to mention "foobar" rather than
> >> "main" in order to more directly help the user.) Along with that,
> >> explaining this use-case in the git-worktree documentation would also
> >> be valuable for improving discoverability.
> >
> > Perfect. I think I've got this working already on my end using more or =
less
> > the following:
> >
> >     diff --git a/builtin/worktree.c b/builtin/worktree.c
> >     index 71786b72f6..f65b63d9d2 100644
> >     --- a/builtin/worktree.c
> >     +++ b/builtin/worktree.c
> >     @@ -736,7 +736,21 @@ static int add(int ac, const char **av, const =
char *prefix)
> >         if (!opts.quiet)
> >             print_preparing_worktree_line(opts.detach, branch, new_bran=
ch, !!new_branch_force);
> >
> >     -=09if (new_branch && !opts.orphan_branch) {
> >     +=09if (opts.orphan_branch) {
> >     +=09=09branch =3D new_branch;
> >     +=09} else if (!lookup_commit_reference_by_name("head")) {
> >     +=09=09/*
> >     +=09=09 * if head does not reference a valid commit, only worktrees
> >     +=09=09 * based on orphan branches can be created.
> >     +=09=09 */
> >     +=09=09advise("if you meant to create a new orphan branch for this =
repository,\n"
> >     +=09=09=09 "e.g. '%s', you can do so using the --orphan option:\n"
> >     +=09=09=09 "\n"
> >     +=09=09=09 "=09git worktree add --orphan %s %s\n"
> >     +=09=09=09 "\n",
> >     +=09=09=09 new_branch, new_branch, path);
>
> We don't consistently check for this, unfortunately (but I have some
> local patches for it), but to add an advice you should:
>
>  * Add it to Documentation/config/advice.txt (in sorted order)
>  * Add the corresponding enum to advice.h
>  * And to the advice.c listing
>  * Then use advise_if_enabled(<that new enum>, ...) in cases such as this=
 one.
>  * End your message with a suggstion about how to disable the advice:
>    git grep -W -F 'git config advice.' -- '*.c'
>
> That's rather tedious, sorry, but that's the extent of the current
> boilerplate...

Noted. Will do.

