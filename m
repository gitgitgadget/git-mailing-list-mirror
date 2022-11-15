Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4CC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 21:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiKOVaL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Nov 2022 16:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiKOVaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 16:30:09 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9AC1C
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:30:08 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id z3so11746713iof.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nofT7j1yyXglBW1JAelNjT5QQrNp1iK+bWkbVMaWxg=;
        b=3MEMxarSQp5q8XToYNe1xcZVEgYsaoVQWBIqQLiLUjsd0rh++ibEXWTluNRuDUtemm
         tn721ZcM38netbH/NdyJSpuuCwiOzLd1/CFWqYR2oorj23JsBQuuGGLhw+AcFwvAgzC/
         S+RAgp2vH/AFOUSMmQRoLwhgT8KXCukLuhoTF0OArQszbHf6ZzwnLdabI4875hP3Zh2b
         O2ev7p1oAsQ7WHh1RVfl3lyB11FzngL717WA2HiNdgJ7AQ7OtRSDQB8SgJIb3sX/ExpI
         JIdLokFBXEgz2AJ3EZsE1vujZfjPys2BkanYi1eC5QAB2+llY9q6X41lE1jXfiOMQpOx
         4VdQ==
X-Gm-Message-State: ANoB5pkAPkNQpok1NqDAfs6rsk98as3BrQzDvEZHd7oKUyTbey1kwJL2
        PZnzOZm/mA+SJhTVn+8T+KfyfF0qu4HCJ+sYbyo=
X-Google-Smtp-Source: AA0mqf5Teg4nhLlE2L8zKK0SWuefxaLLkoN1H93aMCx9kn9N7RHfDDPjvwAP9c5yoMeRITIchoBvGeGk7HjitRon/tY=
X-Received: by 2002:a05:6638:3781:b0:373:2fc2:96d7 with SMTP id
 w1-20020a056638378100b003732fc296d7mr8613953jal.177.1668547807934; Tue, 15
 Nov 2022 13:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev>
 <221115.86iljfkjjo.gmgdl@evledraar.gmail.com>
In-Reply-To: <221115.86iljfkjjo.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Nov 2022 16:29:56 -0500
Message-ID: <CAPig+cRuJVN2Hc-oNF10sx=ZzArb8skXUQ8m5Qek2e-o4c9VEg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 4:13 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Nov 10 2022, Jacob Abel wrote:
> > Adds support for creating an orphan branch when adding a new worktree.
> > This functionality is equivalent to git switch's --orphan flag.
> >
> > The original reason this feature was implemented was to allow a user
> > to initialise a new repository using solely the worktree oriented
> > workflow. Example usage included below.
> >
> > $ GIT_DIR=".git" git init --bare
> > $ git worktree add --orphan master master/
> >
> > Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> > ---
> > +Create a worktree containing an orphan branch named `<branch>` with a
> > +clean working directory.  See `--orphan` in linkgit:git-switch[1] for
> > +more details.
>
> Seeing as "git switch" is still marked "EXPERIMENTAL", it may be prudent
> in general to avoid linking to it in lieu of "git checkout".
>
> In this case in particular though the "more details" are almost
> completely absent from the "git-switch" docs, and they don't (which is
> their won flaw) link to the more detailed "git-checkout" docs.
>
> But for this patch, it seems much better to link to the "checkout" docs,
> no?

Sorry, no. The important point here is that the --orphan option being
added to `git worktree add` closely follows the behavior of `git
switch --orphan`, which is quite different from the behavior of `git
checkout --orphan`.

The `git switch --orphan` documentation doesn't seem particularly
lacking; it correctly describes the (very) simplified behavior of that
command over `git checkout --orphan`. I might agree that there isn't
much reason to link to git-switch for "more details", though, since
there isn't really anything else that needs to be said.

If we did want to say something else here, we might copy one sentence
from the `git checkout --orphan` documentation:

    The first commit made on this new branch will have no parents and
    it will be the root of a new history totally disconnected from all
    the other branches and commits.

The same sentence could be added to `git switch --orphan`
documentation, but that's outside the scope of this patch series (thus
can be done later by someone).

> > +test_expect_success '"add" --orphan/-b mutually exclusive' '
> > +     test_must_fail git worktree add --orphan poodle -b poodle bamboo
> > +'
> > +
> > +test_expect_success '"add" --orphan/-B mutually exclusive' '
> > +     test_must_fail git worktree add --orphan poodle -B poodle bamboo
> > +'
> > +
> > +test_expect_success '"add" --orphan/--detach mutually exclusive' '
> > +     test_must_fail git worktree add --orphan poodle --detach bamboo
> > +'
> > +
> > +test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
> > +     test_must_fail git worktree add --orphan poodle --no-checkout bamboo
> > +'
> > +
> > +test_expect_success '"add" -B/--detach mutually exclusive' '
> > +     test_must_fail git worktree add -B poodle --detach bamboo main
> > +'
> > +
>
> This would be much better as a for-loop:
>
> for opt in -b -B ...
> do
>         test_expect_success "...$opt" '<test here, uses $opt>'
> done
>
> Note the ""-quotes for the description, and '' for the test, that's not
> a mistake, we eval() the latter.

Such a loop would need to be more complex than this, wouldn't it, to
account for all the combinations? I'd normally agree about the loop,
but given that it requires extra complexity, I don't really mind
seeing the individual tests spelled out manually in this case; they're
dead simple to understand as written. I don't feel strongly either
way, but I also don't want to ask for extra work from the patch author
for a subjective change.
