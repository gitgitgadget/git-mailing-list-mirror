Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612FCC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 05:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKVFRD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Nov 2022 00:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiKVFQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 00:16:51 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E422F00F
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 21:16:50 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id b29so13328253pfp.13
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 21:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDL354YEy8mDDOOIWJArXdnXU4u35gzkpMi5pP0aYtQ=;
        b=m8SSTMGgrSVwHKNCoXTwWqULCLBWSktSNh+BAZpe3pKIv1ouKHCc7CchgV+aIHsWlo
         NDL1MAw99b5/ygQqMU76s1NVWHAKGxYUEEr6/MKA8KSu2UVHFS4eiSNyoa1/dne25cRS
         4iuzosBb5BBiEsgGGJ5tbMPkkeEIQqEK5yEqbflnZ1NmRO2aCOpv/t12jQ7vk6g5ftYz
         4ZHN826fBYvGow33K04NjSt/d7iugu0TUepRmdxjgUjWXhyhcYikqsDtgjfqNZ2tH1dh
         cs6mitDvgTJBwW1DieD6qA0+uYlISXjhQVTT7amWZdLMtkCW7qIAoqFTNQ2YEKwG+6gR
         Mqgg==
X-Gm-Message-State: ANoB5pn3aPa9gx84UuRiuizEuck70xNBS5aJR7hd8Ez2mPpIpKofm9b3
        9KDva3C3Cx+qXGyd4QI7teA3pCSwuNoffgBV09Q=
X-Google-Smtp-Source: AA0mqf4nkSpADqBF9U+6lV2b0+XMSOASGmTTdLfu9OY8EHiqSE+FGFyeyDgh/U1UxCOItB6/9sJjIQC3zb+FKSFMWZg=
X-Received: by 2002:a05:6a00:18a9:b0:572:6da6:218e with SMTP id
 x41-20020a056a0018a900b005726da6218emr2494567pfh.1.1669094209398; Mon, 21 Nov
 2022 21:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev> <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
 <221117.86sfihj3mw.gmgdl@evledraar.gmail.com> <20221119034728.m4kxh4tdpof7us7j@phi>
 <221119.86a64nf9k5.gmgdl@evledraar.gmail.com>
In-Reply-To: <221119.86a64nf9k5.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 00:16:38 -0500
Message-ID: <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2022 at 6:49 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Nov 19 2022, Jacob Abel wrote:
> > I'd support adding an `advise()` for at least the basic case where you try to
> > create a worktree and no branches currently exist in the repository.
> > i.e. something like this:
> >
> >     % git -C foo.git worktree add foobar/
> >     hint: If you meant to create a new initial branch for this repository,
> >     hint: e.g. 'main', you can do so using the --orphan option:
> >     hint:
> >     hint:   git worktree add --orphan main main/
> >     hint:
> >     fatal: invalid reference: 'foobar'
> > and
> >     % git -C foo.git worktree add -b foobar foobardir/
> >     hint: If you meant to create a new initial branch for this repository,
> >     hint: e.g. 'main', you can do so using the --orphan option:
> >     hint:
> >     hint:   git worktree add --orphan main main/
> >     hint:
> >     fatal: invalid reference: 'foobar'
>
> I think those would make sense, yes.

Yes, this sort of advice could go a long way toward addressing my
discoverability concerns. (I think, too, we should be able to
dynamically customize the advice to mention "foobar" rather than
"main" in order to more directly help the user.) Along with that,
explaining this use-case in the git-worktree documentation would also
be valuable for improving discoverability.

Updating the commit message of patch [2/2] to explain this more fully
would also be helpful for reviewers. It wasn't clear to me, for
instance, during initial reviews and discussion that you were adding
--orphan to make this use-case possible. Simply including in the
commit message an example usage and associated error of the current
implementation:

    % git init --bare foo.git
    % git -C foo.git worktree add -b main bar
    Preparing worktree (new branch 'main')
    fatal: not a valid object name: 'HEAD'
    %

would go a long way to help reviewers understand what this series is
trying to achieve (at least it would have helped me).

> > Would there be any other circumstances where we'd definitely want an `advise()`?
> > Generally I'd assume that outside of those two circumstances, most users will
> > rarely intend to make an orphan without already knowing they absolutely need to
> > make an orphan.
>
> I'm not familiar enough with the use-cases & workflow around "worktree"
> to say, sorry.

It's probably fine to limit this advice to `git worktree add`,
certainly for an initial implementation.
