Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D5C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 04:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjBOEwW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 23:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBOEwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 23:52:20 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84852D161
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 20:52:19 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so831635pjw.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 20:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od4pY4GdOTjcWpo8guqkPGoY2rdywjv96J6RFTNbBRg=;
        b=0KbkhGFkV7j8y0gc3nSkDXmJL+LLLaSSC3crHjuP4K2FnU3iKctwTWPmviFqAi5ixP
         cYLVYZWSEDvChP4tTpuAlGJQjwFHEiNp8T6p4mjxHM95XCJCUdG/TnjGjF372eak46f6
         I9o4FjEogtV4hFM8yMoG7T6UvTdh1BLsQlELeaVLDpfDmCEjtqv8Nyk5s7ey7CCxJNBm
         05w3N0DgYCAohkieWdARoF/bNeffYE9enjD2BUfEeQYU5KUIjePAfoK/PzbjSAlmY3QY
         YiBguBPq7pQUzFIFpdFhbZW5JpVL6WkNk8yNGQU9H0Xxzrg8CreGcabheTpDxz1VYdUe
         nDog==
X-Gm-Message-State: AO0yUKUnTG/EXumqv/SvmoxcqaKUrHHKLJvFzMHyKRR+LvuEAPwrJv7Q
        /WlL2TFIJMFdJ2SZjrHfBhJwvbzBoTH+FualoUs=
X-Google-Smtp-Source: AK7set+j5GNpPuwys9wNSDkVwPr+Ki5n1DeibHB62HCoVjNLc+PM3oxs7vMRZFD67bPb64IU56TOjx6b/QGcROhAetc=
X-Received: by 2002:a17:90a:4107:b0:234:190f:87e6 with SMTP id
 u7-20020a17090a410700b00234190f87e6mr414870pjf.8.1676436739097; Tue, 14 Feb
 2023 20:52:19 -0800 (PST)
MIME-Version: 1.0
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com> <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
In-Reply-To: <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 23:52:08 -0500
Message-ID: <CAPig+cQPVMKui=AiXBHEfNWY5e4fMbxixdnzvZmXsSkW9ZMLyg@mail.gmail.com>
Subject: Re: [PATCH v2] bisect: fix "reset" when branch is checked out elsewhere
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2023 at 6:02 PM Rubén Justo <rjusto@gmail.com> wrote:
> Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
> have a safety valve in checkout/switch to prevent the same branch from
> being checked out simultaneously in multiple worktrees.
>
> If a branch is bisected in a worktree while also being checked out in
> another worktree; when the bisection is finished, checking out the
> branch back in the current worktree may fail.
>
> Let's teach bisect to use the "--ignore-other-worktrees" flag.
>
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> @@ -122,6 +122,29 @@ test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
> +test_expect_success 'bisect reset: back in a branch checked out also elsewhere' '
> +       echo "shared" > branch.expect &&
> +       test_bisect_reset() {
> +               git -C $1 bisect start &&
> +               git -C $1 bisect good $HASH1 &&
> +               git -C $1 bisect bad $HASH3 &&
> +               git -C $1 bisect reset &&
> +               git -C $1 branch --show-current > branch.output &&
> +               cmp branch.expect branch.output
> +       } &&
> +       test_when_finished "
> +               git worktree remove wt1 &&
> +               git worktree remove wt2 &&
> +               git branch -d shared
> +       " &&

As mentioned in my review[1] of one of your other patches, &&-chaining
within the argument to test_when_finished() is probably undesirable in
this case since failure of any cleanup command would cause
test_when_finish() to fail, which would cause the test to fail
overall.

[1]: https://lore.kernel.org/git/CAPig+cQpizjmhmDKb=HPrcYqqRq7JpvC-NZvY7B9eBbG+NrfKw@mail.gmail.com/

> +       git worktree add wt1 -b shared &&
> +       git worktree add wt2 -f shared &&
> +       # we test in both worktrees to ensure that works
> +       # as expected with "first" and "next" worktrees
> +       test_bisect_reset wt1 &&
> +       test_bisect_reset wt2
> +'
