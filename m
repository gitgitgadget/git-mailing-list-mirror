Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1431F453
	for <e@80x24.org>; Wed, 30 Jan 2019 23:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfA3Xbq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 18:31:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37542 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Xbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 18:31:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id g125so864881qke.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 15:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82DxBOi3IYbEExhARB2k9FRhMsoChZysWB5kc+40S6s=;
        b=llBgmr72UlcVT4vFsdrPSxm7qWEEKD/oYqoqau/fdK2zU90Lyp4bXxqGPk2SHBqkLo
         lRhXzZ9ekhnL5d0rNlbOmFXClh3Yzvyx4xSuCkzYc5h1PnMsqCkNJJwxzkSD8l+jtzk7
         rBvQPG2qFgqkQjD4CbuEWCyf7FVR1ZjRB99osUNb2uwdnoAHY81PBjmfEYpREQAkMV3u
         PybETIP6MmQkbo4mI1eQplvOQhaggu6MAA/4zxT/6PRCiPMAG0+a8moZJqUNmqzNTYkK
         0wz3KDCQ0p520D8wq2nstjZ5jcTAit6g/s0z92QzGiNrKEaB5P5gacMlexOcdHkjBd7Z
         E/XQ==
X-Gm-Message-State: AJcUukeW/fPw35trkv0CBiBIJc9tZwm3Gjv5oBMnkiupEIu2fxmnzMgR
        6SIovCJVlikNUD/5qzh9eAR2LlngGCJS4LggCj8=
X-Google-Smtp-Source: ALg8bN5QwwaIMz+x7MnHLhb58XtEdYYB5IBW+5k/vxXteNBMHl5Jdxdtmcs1ZXxztYUubz+aUSgfgmYUDGSf8dIb8Mg=
X-Received: by 2002:a37:a315:: with SMTP id m21mr29026682qke.152.1548891105222;
 Wed, 30 Jan 2019 15:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20190130231359.23978-1-max@max630.net>
In-Reply-To: <20190130231359.23978-1-max@max630.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Jan 2019 18:31:34 -0500
Message-ID: <CAPig+cTn2gURyQgWHZQMNf2cZ+zwFhbH1Q4iPmbwuvYjMrPZPg@mail.gmail.com>
Subject: Re: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
To:     Max Kirillov <max@max630.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 6:21 PM Max Kirillov <max@max630.net> wrote:
> If packed-refs is marked as sorted but not really sorted it causes
> very hard to comprehend misbehavior of reference resolving - a reference
> is reported as not found.
>
> As the scope of the issue is not clear, make it visible by failing
> pack-refs command - the one which would not suffer performance penalty
> to verify the sortedness - when it encounters not really sorted existing
> data.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> @@ -1088,6 +1088,7 @@ static int write_with_updates(struct packed_ref_store *refs,
> +       struct strbuf prev_ref = STRBUF_INIT;
> @@ -1137,6 +1138,20 @@ static int write_with_updates(struct packed_ref_store *refs,
> +               if (iter)
> +               {
> +                       if (prev_ref.len &&  strcmp(prev_ref.buf, iter->refname) > 0)
> +                       {
> +                               strbuf_addf(err, "broken sorting in packed-refs: '%s' > '%s'",
> +                                           prev_ref.buf,
> +                                           iter->refname);

strbuf_release(&prev_ref) either here or after the "error" label.

> +                               goto error;
> +                       }
> +
> +                       strbuf_init(&prev_ref, 0);
> +                       strbuf_addstr(&prev_ref, iter->refname);
> +               }
> diff --git a/t/t3212-pack-refs-broken-sorting.sh b/t/t3212-pack-refs-broken-sorting.sh
> @@ -0,0 +1,26 @@
> +test_expect_success 'setup' '
> +       git commit --allow-empty -m commit &&
> +       for num in $(test_seq 10)
> +       do
> +               git branch b$(printf "%02d" $num) || break

This should probably be "|| return 1" rather than "|| break" in order
to fail the test immediately.

> +       done &&
> +       git pack-refs --all &&
> +       head_object=$(git rev-parse HEAD) &&
> +       printf "$head_object refs/heads/b00\\n" >>.git/packed-refs &&
> +       git branch b11
> +'
> +
> +test_expect_success 'off-order branch not found' '
> +       ! git show-ref --verify --quiet refs/heads/b00
> +'

Use test_must_fail() rather than '!' when expecting a Git command to fail.

> +test_expect_success 'subsequent pack-refs fails' '
> +       ! git pack-refs --all
> +'

Ditto.
