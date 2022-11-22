Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42213C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiKVX1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiKVX1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:27:08 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FAFBEB6D
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:27:06 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:26:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1669159624; x=1669418824;
        bh=HycgCcTnmUB48eIXhEoPxwV+8aWcfAKkKYqbL/TjuSQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VB/+HHK+PpC/VmebijDa6gzQbxDEv8q14KUS26o4jlYajwK3jC+R4wYCuwk78QVx1
         bz3XrKycHaPmlqy7zajS1UybyxPbM+0Q3vLITqdz1XtU2H6qEvOUIfFesDEsd04qwO
         RBKXBAY32cFPdo3TKtQ9J58muxtq5uGqGXA1IeDidC36R5EhrduJ1IK2Q9QHg1j+xL
         rvUWJvgl/u/iYeTEHQpV1hgiPXmfM/pFJJHOaxwfUg90R843BMnM78RjaDp4IEFEK+
         n/VRNGEfry8WZUfQRm3zyLJc4kKxduAL8Z8tQ4xnPDPAOQcKnHLSSniRdGQmKxNXt9
         tj9GDb902Ql3g==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221122232647.2jdsp5kioq7muymb@phi>
In-Reply-To: <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com> <221117.86sfihj3mw.gmgdl@evledraar.gmail.com> <20221119034728.m4kxh4tdpof7us7j@phi> <221119.86a64nf9k5.gmgdl@evledraar.gmail.com> <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/22 12:16AM, Eric Sunshine wrote:
> On Sat, Nov 19, 2022 at 6:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > On Sat, Nov 19 2022, Jacob Abel wrote:
> > > I'd support adding an `advise()` for at least the basic case where yo=
u try to
> > > create a worktree and no branches currently exist in the repository.
> > > i.e. something like this:
> > >
> > >     % git -C foo.git worktree add foobar/
> > >     hint: If you meant to create a new initial branch for this reposi=
tory,
> > >     hint: e.g. 'main', you can do so using the --orphan option:
> > >     hint:
> > >     hint:   git worktree add --orphan main main/
> > >     hint:
> > >     fatal: invalid reference: 'foobar'
> > > and
> > >     % git -C foo.git worktree add -b foobar foobardir/
> > >     hint: If you meant to create a new initial branch for this reposi=
tory,
> > >     hint: e.g. 'main', you can do so using the --orphan option:
> > >     hint:
> > >     hint:   git worktree add --orphan main main/
> > >     hint:
> > >     fatal: invalid reference: 'foobar'
> >
> > I think those would make sense, yes.
>
> Yes, this sort of advice could go a long way toward addressing my
> discoverability concerns. (I think, too, we should be able to
> dynamically customize the advice to mention "foobar" rather than
> "main" in order to more directly help the user.) Along with that,
> explaining this use-case in the git-worktree documentation would also
> be valuable for improving discoverability.

Perfect. I think I've got this working already on my end using more or less
the following:

    diff --git a/builtin/worktree.c b/builtin/worktree.c
    index 71786b72f6..f65b63d9d2 100644
    --- a/builtin/worktree.c
    +++ b/builtin/worktree.c
    @@ -736,7 +736,21 @@ static int add(int ac, const char **av, const char=
 *prefix)
        if (!opts.quiet)
            print_preparing_worktree_line(opts.detach, branch, new_branch, =
!!new_branch_force);

    -=09if (new_branch && !opts.orphan_branch) {
    +=09if (opts.orphan_branch) {
    +=09=09branch =3D new_branch;
    +=09} else if (!lookup_commit_reference_by_name("head")) {
    +=09=09/*
    +=09=09 * if head does not reference a valid commit, only worktrees
    +=09=09 * based on orphan branches can be created.
    +=09=09 */
    +=09=09advise("if you meant to create a new orphan branch for this repo=
sitory,\n"
    +=09=09=09 "e.g. '%s', you can do so using the --orphan option:\n"
    +=09=09=09 "\n"
    +=09=09=09 "=09git worktree add --orphan %s %s\n"
    +=09=09=09 "\n",
    +=09=09=09 new_branch, new_branch, path);
    +=09=09die(_("invalid reference: %s"), new_branch);
    +=09} else if (new_branch) {
            struct child_process cp =3D child_process_init;
            cp.git_cmd =3D 1;
            strvec_push(&cp.args, "branch");

>
> Updating the commit message of patch [2/2] to explain this more fully
> would also be helpful for reviewers. It wasn't clear to me, for
> instance, during initial reviews and discussion that you were adding
> --orphan to make this use-case possible. Simply including in the
> commit message an example usage and associated error of the current
> implementation:
>
>     % git init --bare foo.git
>     % git -C foo.git worktree add -b main bar
>     Preparing worktree (new branch 'main')
>     fatal: not a valid object name: 'HEAD'
>     %
>
> would go a long way to help reviewers understand what this series is
> trying to achieve (at least it would have helped me).

Will do.

>
> > > Would there be any other circumstances where we'd definitely want an =
`advise()`?
> > > Generally I'd assume that outside of those two circumstances, most us=
ers will
> > > rarely intend to make an orphan without already knowing they absolute=
ly need to
> > > make an orphan.
> >
> > I'm not familiar enough with the use-cases & workflow around "worktree"
> > to say, sorry.
>
> It's probably fine to limit this advice to `git worktree add`,
> certainly for an initial implementation.

Perfect. I'll work on getting the next revision for the patchset out then.

