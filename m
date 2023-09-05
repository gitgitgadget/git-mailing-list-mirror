Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98346C83F33
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 00:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjIEA01 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 4 Sep 2023 20:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjIEA00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 20:26:26 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A7191
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 17:26:22 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-649c6ea6e72so11828436d6.2
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 17:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693873581; x=1694478381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft+1jCzYvZaHNWZNMjk0xX+POYzT54aYwrlyPIxaUa0=;
        b=Kaqn2XRVMNZBnY2xsmtIaqd0879yAuK9AFY+R6UdSLXEeuTXQM4mnePfH6HY8GaIwC
         2J7j3H8q/8imURMQoDXkldseBz1MLfLuZBjoIx965VtVdmrgYcRYzdAZmOuKBRzZi2vD
         shWseflkAgi997Z7i+8KgLlr1CpAZ6v6A7XKiNcCmCqMC+QkNGXrIB2f6KD/git1ZaBI
         mxLehXMHaCwdxyv59RwvRu1HTepKmlRiNl5VHnNq21pM3u0Exd2yw0OX87djW8zKKp5P
         CLtJhzN9ZkIKLyE78DRjvDsscJr6/qKB32v0mF3hsVoEF1V1JcAZsJkpfmYAjvhIwwSf
         3Bpg==
X-Gm-Message-State: AOJu0YylFCYo6BuJeKszfNowCUgCHqiu6f6zSaU/jjgQ1tlLz3HL0LoG
        2S8ZDqBLG++9MEGmn3UpEmQ2J60fsPp7xR4uGwA=
X-Google-Smtp-Source: AGHT+IGE6GBcCwoQ4qrgitxbNZTkQr/Y6a4P6YJrygC/PiqhTg/lkp66t8zaW857fzNE7cbyZCrWGGyYdCp8SeMsEF4=
X-Received: by 2002:ad4:5b8f:0:b0:645:df54:cf83 with SMTP id
 15-20020ad45b8f000000b00645df54cf83mr12863325qvp.38.1693873581518; Mon, 04
 Sep 2023 17:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
In-Reply-To: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Sep 2023 20:26:10 -0400
Message-ID: <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 4, 2023 at 10:41 AM Tao Klerks <tao@klerks.biz> wrote:
> I work with a project that often, or typically, benefits from having
> multiple worktrees where users are working with different versions of
> the code.
>
> Worktrees make particular sense in this project for all the usual
> reasons, plus the fact that it is a very *large* repo - multiple gigs
> of repo, and very fast-moving; cloning and fetching less often is
> nice.
>
> One problem that we found users to have, early on when we introduced
> worktrees, was that it was not obvious to users that there was (or why
> there was) a "main" worktree, containing the actual ".git" repo, and
> "subsidiary" worktrees, in the same directory location. Git by default
> makes worktrees *subfolders* of the initial/main worktree/folder, but

This is not accurate. There is no default location for new worktrees;
git-worktree creates the new worktree at the location specified by the
user:

    git worktree add [<options>] <path> [<commit>]

where <path> -- the only mandatory argument -- specifies the location.

> we put them alongside each other to make other project tooling be able
> to treat all worktrees consistently; in daily use there is absolutely
> no difference between them, in all the "project tooling" there cannot
> be a practical difference... but if you choose to delete a worktree,
> and it happens to be the "special" one that contains the repo...
> you've just lost stuff that you didn't expect to lose (any local
> branches and stashes, basically).
>
> Because worktree use was so useful/widespread/critical on this
> project, and we already had a custom cloning process that introduced
> selective refspecs etc, we introduced a special clone topology: the
> initial clone is a bare repo, and that folder gets a specific clear
> name (ending in .git). Then we create worktrees attached to that bare
> repo.
>
> Generally speaking, this has worked *very* well: I would recommend it
> generally as a recognized/supported local-repo-setup. The most
> important thing that makes this *possible* is the fact that "git
> rev-parse --is-bare-repository" returns True in the bare repo folder,
> where the lack of index and HEAD shouldn't bother git, and it returns
> False in any one of the worktrees. It feels like things were designed
> to work this way, even though I can find no explicit mention of this
> topology in the docs.

It indeed was designed to work this way. It is perfectly legitimate to
create worktrees attached to a bare repository[1].

[1]: Support for bare repositories in conjunction with multiple-
worktrees, however, came after the initial implementation of multiple-
worktrees. An unfortunate side-effect is that established terminology
became somewhat confusing. In particular, in a bare repository
scenario, the term "main worktree" refers to the bare repository, not
to the "blessed" worktree containing the ".git/" directory (since
there is no such worktree in this case).

> However, from time to time something weird happens: Today I finally
> started to understand why I was seeing a crazy GC error about bitmaps,
> intermittently: It seems to be because "git gc" wants to create
> bitmaps in bare repos, but can't do so properly when we're in a
> partial clone... or something like that?
>
> EG repro:
> ```
> git clone --bare https://github.com/ksylor/ohshitgit dangit_shared.git
> --filter=blob:none
> git -C dangit_shared.git worktree add $PWD/dangit_wt3
> cd dangit_wt3/
> echo "this is some new unique blob in the repo" > new_blob.txt
> git add new_blob.txt && git commit -m "new blob"
> cd ../dangit_shared.git/
> git gc
> ```
>
> This yields, at the end of the GC run:
> ```
> warning: Failed to write bitmap index. Packfile doesn't have full
> closure (object bf86ed1b2602ac3a8d4724bcdf6707b156673aac is missing)
> fatal: failed to write bitmap index
> fatal: failed to run repack
> ```
>
> On the other hand, running "git gc" in one of the worktrees works fine
> (except you first need to delete a couple of ".tmp-*" files from the
> "objects/pack" folder, if you already got the error above).

Worktrees appear to be a red-herring. It's possible to reproduce this
error without them. For instance:

    % git clone --bare --filter=blob:none
https://github.com/ksylor/ohshitgit dangit_shared.git
    % git clone dangit_shared.git foop
    % cd foop
    % echo nothing >nothing
    % git add nothing
    % git commit -m nothing
    fatal: unable to read dbbb0682a7690b62ccf51b2a8648fa71ac671348
    % git push origin master
    % cd ../dangit_shared.git
    % git gc
    ...
    warning: Failed to write bitmap index. Packfile doesn't have full
closure (object bf86ed1b2602ac3a8d4724bcdf6707b156673aac is missing)
    fatal: failed to write bitmap index
    fatal: failed to run repack

> I at first thought this was a bug - but as I realized the problematic
> behavior was tied to the "core.bare" setting (and its expression at
> runtime through "git rev-parse --is-bare-repository"), it became more
> obvious that maybe the system could/should be able to make assumptions
> about the kind of repo that has this "true", and assume there are no
> local-object-derived non-promisor packfiles (or whatever it is about
> this example that makes things unhappy).
>
> So, I guess I'm confused as to what "core.bare" is supposed to mean:
> Is it intended to mean "there is no index nor HEAD here, and that's
> good, don't worry" (in which case my setup is presumably "supported",
> and the gc behavior is buggy?), or is it intended to mean "this is the
> kind of repository in which there are no worktrees" (in which case I
> am abusing the system and get the errors I deserve)?

The former, meaning that your setup should be supported. Citing
documentation for `core.bare`:

    If true this repository is assumed to be bare and has no working
    directory associated with it. If this is the case a number of
    commands that require a working directory will be disabled, such
    as git-add(1) or git-merge(1).

On Mon, Sep 4, 2023 at 10:59 AM Tao Klerks <tao@klerks.biz> wrote:
> I should add that I only recently discovered "git clone
> --separate-git-dir", which I at first though was a formal expression
> of this setup... until I understood that the relationship between the
> "GITDIR" and the worktree that you end up with is not "Bare repo vs
> worktree", but rather... "orphaned repo / repo that doesn't know about
> its worktree, vs worktree".
>
> It seems, to me, that "my setup" makes a lot more sense than what you
> end up with when you use "--separate-git-dir", and that the behavior
> there predates the current "mutual reference" model of
> worktrees-to-their-repo. If "my" use of "core.bare" in the example
> above is sound - then should the implementation of
> "--separate-git-dir" be changed to produce a bare repo with a
> "worktrees" folder, like you get if you clone bare and add a worktree
> in two separate steps?

`--separate-git-dir` predates multiple-worktree support by several
years and is distinct in purpose from --bare and multiple-worktrees
(in fact, a couple somewhat recent fixes [2,3] were needed to prevent
--separate-git-dir from breaking worktree administrative data). My
understand from scanning history is that --separate-git-dir was
introduced in aid of submodule support and perhaps other use-cases.

[2]: 42264bc841 (init: teach --separate-git-dir to repair linked
worktrees, 2020-08-31)
[3]: 59d876ccd6 (init: make --separate-git-dir work from within linked
worktree, 2020-08-31)

On Mon, Sep 4, 2023 at 11:29 AM Tao Klerks <tao@klerks.biz> wrote:
> And to confuse matters further, I just stumbled across
> https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir
> - I don't understand when you would want to use that vs, again, a bare
> repo with one or more worktrees properly attached via two-way
> references, their own indexes, their own reflogs, etc.
>
> Is it the case that this contrib script predates the current "git
> worktree" support?

git-new-workdir predates git-worktree by quite a few years and, as I
understand it, remains in-tree because it fills a niche not entirely
filled by git-worktree.
