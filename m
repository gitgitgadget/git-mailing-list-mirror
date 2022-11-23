Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A63C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 05:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiKWFhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 00:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiKWFhg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 00:37:36 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5787B1141
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 21:37:32 -0800 (PST)
Date:   Wed, 23 Nov 2022 05:37:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1669181849; x=1669441049;
        bh=CTqZLXJMmZuMssazAJ5q1KddTI397mpheRunM/rnpr8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=imDsKZZ2m+Uul0hKAjvRXj/XiVXbKU0j0L4EAsTi34kTLysni6Fe10i7OoPPK/YUt
         Fc4VYGLWrc6FoXgidLC1GzUse7BbSD9JPMjbl61JhxFTxtAYGQn+2GsN8wOT8WMaRb
         LLh1jbTL9KnMLPtjLITyHPMr8RGm0YeRJH2Utm2uR0ed/rcizYJRtdA8UKZGAZAlWh
         rsrmTaGyFKe28wTNbAfbsj5CIOAgoAdWkbl72ch2L+fE8f+bLgnaozr3lkUEDtcpu+
         JpV/hmixJclasgkQBSmI6TizPy3W3dWiQDLqmgMQAGo5icntf+UW3zEPSqYJ0RbaqI
         aUsjam/qnA7Lg==
To:     =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221123053708.rrbcphg7uukafdsg@phi>
In-Reply-To: <e027dc5b-dbb9-c511-038e-5440d59d976c@gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com> <221117.86sfihj3mw.gmgdl@evledraar.gmail.com> <20221119034728.m4kxh4tdpof7us7j@phi> <221119.86a64nf9k5.gmgdl@evledraar.gmail.com> <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com> <20221122232647.2jdsp5kioq7muymb@phi> <e027dc5b-dbb9-c511-038e-5440d59d976c@gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/23 03:43AM, Rub=C3=A9n Justo wrote:
> On 22-nov-2022 23:26:57, Jacob Abel wrote:
> > On 22/11/22 12:16AM, Eric Sunshine wrote:
> > > On Sat, Nov 19, 2022 at 6:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > > <avarab@gmail.com> wrote:
> > > > On Sat, Nov 19 2022, Jacob Abel wrote:
> > > > > I'd support adding an `advise()` for at least the basic case wher=
e you try to
> > > > > create a worktree and no branches currently exist in the reposito=
ry.
> > > > > i.e. something like this:
> > > > >
> > > > >     % git -C foo.git worktree add foobar/
> > > > >     hint: If you meant to create a new initial branch for this re=
pository,
> > > > >     hint: e.g. 'main', you can do so using the --orphan option:
> > > > >     hint:
> > > > >     hint:   git worktree add --orphan main main/
> > > > >     hint:
> > > > >     fatal: invalid reference: 'foobar'
> > > > > and
> > > > >     % git -C foo.git worktree add -b foobar foobardir/
> > > > >     hint: If you meant to create a new initial branch for this re=
pository,
> > > > >     hint: e.g. 'main', you can do so using the --orphan option:
> > > > >     hint:
> > > > >     hint:   git worktree add --orphan main main/
> > > > >     hint:
> > > > >     fatal: invalid reference: 'foobar'
> > > >
> > > > I think those would make sense, yes.
> > >
> > > Yes, this sort of advice could go a long way toward addressing my
> > > discoverability concerns. (I think, too, we should be able to
> > > dynamically customize the advice to mention "foobar" rather than
> > > "main" in order to more directly help the user.) Along with that,
> > > explaining this use-case in the git-worktree documentation would also
> > > be valuable for improving discoverability.
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
>
> I haven't read the full thread and sorry to enter this way in the
> conversation, but this line got my attention.

No worries. It's always nice to have more eyes to catch mistakes.

> This needs to be "HEAD", in capital letters.

Ah yes. I wasn't paying attention when I copied it into my MUA and must hav=
e
accidentally typed `ggvGu` instead of `ggvGy` and lowercased it before I co=
pied
it (thanks vim/user error). It should be:

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
    +=09} else if (!lookup_commit_reference_by_name("HEAD")) {
    +=09=09/*
    +=09=09 * If HEAD does not reference a valid commit, only worktrees
    +=09=09 * based on orphan branches can be created.
    +=09=09 */
    +=09=09advise("If you meant to create a new orphan branch for this repo=
sitory,\n"
    +=09=09=09 "e.g. '%s', you can do so using the --orphan option:\n"
    +=09=09=09 "\n"
    +=09=09=09 "=09git worktree add --orphan %s %s\n"
    +=09=09=09 "\n",
    +=09=09=09 new_branch, new_branch, path);
    +=09=09die(_("invalid reference: %s"), new_branch);
    +=09} else if (new_branch) {
            struct child_process cp =3D CHILD_PROCESS_INIT;
            cp.git_cmd =3D 1;
            strvec_push(&cp.args, "branch");


>
> Thank you for working on this, this is a thing that has hit me several
> times.
>
> The first impression got me thinking.. Why do we need this advise?
> Why not make the orphan branch right away? And why the argument for the
> --orphan option?

I went into my concerns with further overloading `worktree add -b/-B` and
`worktree add` (DWYM) over on the other side of this thread [1]. I won't ec=
ho
it all here but I wanted to mention a few things.

As for why we want the advise, by not short circuiting with the advise and
instead just trying to DWYM, we can catch the following edge case:

A user less well acquainted with git tries out worktrees on a new project (=
no
branches). They create multiple worktrees and since there are no branches, =
they
are all orphans. Unless they've read the docs, they are now accustomed to t=
his
"new worktrees have no history" behavior. Then they make a commit on one of=
 the
orphans and the behavior changes and all new worktrees derive from that bra=
nch
unless `git worktree add` is run from inside another worktree with a non-or=
phan
branch.

There's more to it in the other thread but it gets kinda messy for the user=
 if
they walk off the well trodden path inadvertently. I'd like to avoid that a=
ll
together where possible.

As for the argument, the reason is so that the syntax matches
`git switch --orphan <new_branch>` (and the `git checkout` variant).

> I like what this new flag allows: make a new orphan branch when we
> are in any branch.  But if we are already in an orphan branch (like the
> initial) what's the user's expectation?

Like mentioned above (and in [1]), further overloading DWYM and `-b` impact=
s the
already somewhat complex/unclear expectations for `git worktree add`.

When using the flag and not adding to `-b` and DWYM, we can short circuit t=
his
confusion for the most part by requiring the user to explicitly request
`--orphan`.

As for creating a new orphan in a repo with existing branches but from a
worktree containing an orphan branch, that fails cleanly as shown below:

    # in worktree with orphan branch
    % git worktree add -b foobar ../foobar
    Preparing worktree (new branch 'foobar')
    fatal: invalid reference: foobar

and in the next revision should fail with the following:

    # in worktree with orphan branch
    % git worktree add -b foobar ../foobar
    Preparing worktree (new branch 'foobar')
    hint: If you meant to create a new orphan branch for this repository,
    hint: e.g. 'foobar', you can do so using the --orphan option:
    hint:
    hint:   git worktree add --orphan foobar ../foobar/
    hint:
    fatal: invalid reference: foobar

> Maybe we can use the new flag to indicate that the user unconditionally
> wants an orphan branch, and use the rest of the arguments as they are,
> '-b' included.

I wouldn't necessarily be opposed to this however I do think changing it fr=
om
`--orphan <new_branch>` to `--orphan -b <new_branch>` would be a departure =
from
the syntax used in `git switch` and `git checkout` and that may make it har=
der
for users already familar with those other commands.

>
> This needs more work, but something like this:
>
> --- >8 ---
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d774ff192a..1ea8d05c2f 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -406,7 +406,7 @@ static int add_worktree(const char *path, const char =
*refname,
>
>  =09/* is 'refname' a branch or commit? */
>  =09if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
> -=09    ref_exists(symref.buf)) {
> +=09    (opts->orphan_branch || ref_exists(symref.buf))) {
>  =09=09is_branch =3D 1;
>  =09=09if (!opts->force)
>  =09=09=09die_if_checked_out(symref.buf, 0);
> @@ -738,18 +738,8 @@ static int add(int ac, const char **av, const char *=
prefix)
>
>  =09if (opts.orphan_branch) {
>  =09=09branch =3D new_branch;
> -=09} else if (!lookup_commit_reference_by_name("head")) {
> -=09=09/*
> -=09=09 * if head does not reference a valid commit, only worktrees
> -=09=09 * based on orphan branches can be created.
> -=09=09 */
> -=09=09advise("if you meant to create a new orphan branch for this reposi=
tory,\n"
> -=09=09=09 "e.g. '%s', you can do so using the --orphan option:\n"
> -=09=09=09 "\n"
> -=09=09=09 "=09git worktree add --orphan %s %s\n"
> -=09=09=09 "\n",
> -=09=09=09 new_branch, new_branch, path);
> -=09=09die(_("invalid reference: %s"), new_branch);
> +=09} else if (new_branch && !lookup_commit_reference_by_name("HEAD")) {
> +=09=09branch =3D opts.orphan_branch =3D new_branch;
>  =09} else if (new_branch) {
>  =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
>  =09=09cp.git_cmd =3D 1;

1. https://lore.kernel.org/git/20221123042052.t42jmsqjxgx2k3th@phi/

