Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1FEC43217
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKDQmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKDQmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 12:42:10 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF3D2AC7A
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 09:42:08 -0700 (PDT)
Date:   Fri, 04 Nov 2022 16:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667580125; x=1667839325;
        bh=3dWJr07Rd4GIRAWpE+uHYqL5zXmyuAoaCc2OAMFLG0c=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=IXQfjlwI2rjg9fx6kvUAUiWQ6ELoJONd/3TqktXYkFN7tne0QBkK6LQ0vPvv8lz/u
         UhPCT3tg/UK8mkiN9zUBTo8CockEDRqWkIqOut+WW/mOSJsnxrdlubcuv6c0/+V6Wd
         4WEuRSP+32+8U7EUgN1jvND0l28fnJtQUlA1vq3iRtDpqCOHJTzdhiaKc3H0b5iq3r
         8rEr8w203iROgwnzJagaLIhNunyxWpUTqzvPyHha0yf5/JZC+I9YSRiBu/MxJGOnES
         v3EijWjfrH7rXS8AZh+eMySkqpVZlwzIzdvdhlsyFMChCdSU93RtgkJ7aT0lYYhCyV
         /lvJ2qcKYxR1w==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] worktree add: add --orphan flag
Message-ID: <20221104164147.izizapz5mdwwalxu@phi>
In-Reply-To: <CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcdLCU5svw@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-4-jacobabel@nullpo.dev> <CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcdLCU5svw@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/04 01:03AM, Eric Sunshine wrote:
> On Thu, Nov 3, 2022 at 9:07 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> > ...
>
> Are we sure we want to be modeling this after `git checkout --orphan`?
> If I understand correctly, that option has long been considered (by
> some) too clunky, which is why `git switch --orphan` was simplified to
> accept only a branch name but no commit-ish, and to start the orphan
> branch with an empty directory. My own feeling is that modeling it
> after `git switch --orphan` is probably the way to go...

I would argue that the `git checkout --orphan` command format is preferable=
 to
`git switch --orphan` when creating new worktrees. Reason being that in man=
y
cases (except when working in a new repo), if you are trying to create a
worktree from an orphan you will be doing it with a different commit-ish
currently checked out in your worktree than the one you want to use for the
orphan (or you aren't in any worktree).

Requiring the commit-ish to be inferred would limit the user to checking ou=
t
an orphan from an existing worktree (in which case they could just create a
new worktree normally and use `git switch --orphan` to move that to an orph=
an
branch).

> > ...
>
> The short help message for `git switch --orphan` and `git checkout
> --orphan` say simply "new unparented branch", so this message should
> probably follow suit (or consistency and to ease the job of
> translators).

Noted.

> > ...
>
> Good to have these additional interlocks. I think, however, for the
> sake of translators, we should use the same terminology as the
> existing message above (i.e. "options ... cannot be used together").

Noted.

>
> > +       /*
> > +        * From here on, new_branch will contain the branch to be check=
ed out,
> > +        * and new_branch_force and opts.orphan_branch will tell us whi=
ch one of
> > +        * -b/-B/--orphan is being used.
> > +        */
>
> This can probably be worded a bit differently to make it clear that
> from this point onward, those other variables are interpreted as if
> they are booleans. Moreover, we can make this even clearer by
> following the example of -B in which (by necessity due to
> parse-options) the local variable in add() is a `const char *`, but
> its counterpart in `struct add_opts` is a boolean (int).

The one thing to note with `opts.orphan_branch` is that it is used as both =
a
string and a boolean later in `add_worktree()`. Since orphan branches don't
have any commits tied to them, we have to check out the original commit-ish
in `add_worktree()` and then convert it to an orphan of name
`opts.orphan_branch` instead of creating the branch prior to entering
`add_worktree()` (as is done for `-B` and `-b`).

I do agree that the comment should probably be re-worded. I'll update it to
be clearer in v2.

