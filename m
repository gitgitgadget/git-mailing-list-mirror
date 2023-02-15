Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F594C64ED6
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 04:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBOEU0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 23:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjBOETs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 23:19:48 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930796A5E
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 20:17:55 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 24so11672660pgt.7
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 20:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676434673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZWxx+NFaa0z70a26LlBt4qB1LhETQpwaxWhE25fNNk=;
        b=Ekcj9PPp+aGscmpxtQw93peExNUuHCK0P0w2F4+lobPyEdYHXw06bCme6jANk30c+d
         BAWPPBQ5vLXkZael24ZYC0NRW07f43LipowK/5FMUToAi0qIhVQNQAg4E1yJ4OoQ6vQ+
         L/DOQKyfUsN+iBl6wUlQ1AWZFHuBt0C2msmj/kIt++wi06g+TzkjZRsZniy4Q93q5S3w
         bpEhkLnKgLkvPiL0BW2psbNU5Qr3YBsVtZSWsf0WihGTiaqoUae/SVjyDFWUypOOe17Y
         u0Zaq00Qb0CU3F2/280w7gMrdSc1LctWpsZLaiuab7Gwnyi+583rMKvKKJkE00kGcsnW
         qZNg==
X-Gm-Message-State: AO0yUKXxDGWDhceutJfUmghJkWov0S+SUs8AsA0CIdHHM+nm947ElDHm
        uwijVwsYxHOr5tqUPqB3xRrCEe4vQf390p1zqgkcncRB
X-Google-Smtp-Source: AK7set+PxGEsoXM5flUN6mkY+/NyBEUx1r2qI2ZVOCWL8JKfhGOevkspdQNlIcqJ9d4W3DJdX2fj1Ef+w0yhNxiXyDs=
X-Received: by 2002:aa7:8eca:0:b0:5a8:c0e0:3b2 with SMTP id
 b10-20020aa78eca000000b005a8c0e003b2mr94013pfr.45.1676434673269; Tue, 14 Feb
 2023 20:17:53 -0800 (PST)
MIME-Version: 1.0
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com> <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <b18a5710-2791-f892-8460-dda7ea41d88a@gmail.com>
In-Reply-To: <b18a5710-2791-f892-8460-dda7ea41d88a@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 23:17:42 -0500
Message-ID: <CAPig+cQpizjmhmDKb=HPrcYqqRq7JpvC-NZvY7B9eBbG+NrfKw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] switch: reject if the branch is already checked
 out elsewhere (test)
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2023 at 6:33 PM Rubén Justo <rjusto@gmail.com> wrote:
> Since 5883034 (checkout: reject if the branch is already checked out
> elsewhere) in normal use, we do not allow multiple worktrees having the
> same checked out branch.
>
> A bug has recently been fixed that caused this to not work as expected.
>
> Let's add a test to notice if this changes in the future.
>
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> @@ -146,4 +146,33 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
> +test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
> +       test_when_finished "
> +               git worktree remove wt1 &&
> +               git worktree remove wt2 &&
> +               git branch -d shared
> +               git checkout -
> +       " &&
> +       git checkout -b shared &&

A few comments...

The test_when_finished() call has an odd mix of &&-chain and missing &&-chain.

If you do use &&-chaining inside test_when_finished(), you have to be
careful that _none_ of the cleanup commands fail, otherwise
test_when_finished() itself will fail, making the entire test fail,
_even if_ the test body succeeded. So, &&-chaining the commands in
this test_when_finished() is undesirable since any of the `git
worktree remove` and `git branch -d` commands could potentially fail.
Better would be to drop the &&-chain and ensure that the final command
succeeds.

It may be a good idea to use `||:` at the end of each command as
documentation for readers that any of the cleanup commands might fail,
which could happen if something in the body of the test fails.

The `git branch -d shared` cleanup command fails unconditionally
because it's still the checked-out branch in the directory. You need
to swap the `git branch -d shared` and `git checkout -` commands.

Taking all the above points into account, a possible rewrite would be:

  test_when_finished "
    git worktree remove wt1 ||:
    git worktree remove wt2 ||:
    git checkout - ||:
    git branch -d shared ||:
  " &&
  git checkout -b shared &&

> +       test_commit shared-first &&
> +       HASH1=$(git rev-parse --verify HEAD) &&
> +       test_commit shared-second &&
> +       test_commit shared-third &&
> +       HASH2=$(git rev-parse --verify HEAD) &&
> +       git worktree add wt1 -f shared &&
> +       git -C wt1 bisect start &&
> +       git -C wt1 bisect good $HASH1 &&
> +       git -C wt1 bisect bad $HASH2 &&
> +       git worktree add wt2 -f shared &&
> +       git -C wt2 bisect start &&
> +       git -C wt2 bisect good $HASH1 &&
> +       git -C wt2 bisect bad $HASH2 &&
> +       # we test in both worktrees to ensure that works
> +       # as expected with "first" and "next" worktrees
> +       test_must_fail git -C wt1 switch shared &&
> +       git -C wt1 switch --ignore-other-worktrees shared &&
> +       test_must_fail git -C wt2 switch shared &&
> +       git -C wt2 switch --ignore-other-worktrees shared
> +'
