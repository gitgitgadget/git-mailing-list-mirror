Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190BD1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 19:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfBATzF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 1 Feb 2019 14:55:05 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:42986 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfBATzF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 14:55:05 -0500
Received: by mail-qt1-f178.google.com with SMTP id d19so8964502qtq.9
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 11:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DObVZlVMMaUYhs7UPnFG/g+NarjFnAHJqIlwkxfnWnA=;
        b=k8BqV0ZbafLt8Wrc8GZ2DphpA8WV1agfNzisUbbVKyRfvpdec2DkUNa2apiJ6bfCnW
         /Wo5y6DawpSWpdJmhPd7UkGc12KUxbfBehqh6bwQN7MTSIGZ51iIZq++qjjZIt5zFWxd
         8pOw2c9K+mBAUEVDWdk4A7QhpkZpl/AQdiMLaSibzpHA7BTFpsBtSNpNBcfUL6WS9F7z
         BlGFJH3PPzRycw7kxJYevf/u0niNaVsU/apAnRU/n5aeyPUDJ+iJ1o3obHjDi1VkHGrJ
         pq7zqSYootPseF3YHMyRCD4dxT5Jn05ZEgwusR/IhwCEHHIVwlAoIxcBuUHzYbOTKzt+
         Q34g==
X-Gm-Message-State: AJcUukfzRFxHTBtqhnx5K3TJCCXnJ64irPsuEqp+WwbK6XYXPwF8178s
        QbcJjx6w9ZkIB2codi3CIvVqw5Ss7TWNLOqlQPUoLs4U
X-Google-Smtp-Source: ALg8bN6R6g3JaiABgTzC4ka0+7bKqNNuBEq7XaWuC2/GQEWJdWy4UWRLU9i/7FMit5XCRNYFgXqKf63IdQNUtK39D1Y=
X-Received: by 2002:ac8:2a81:: with SMTP id b1mr40519720qta.110.1549050904071;
 Fri, 01 Feb 2019 11:55:04 -0800 (PST)
MIME-Version: 1.0
References: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz> <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
 <CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com>
 <CACsJy8D+zvgtw8RuBefYQsYrvn_vQT1dUO3Veg5ZtfQa2u5QKA@mail.gmail.com> <20190201131659.GA30564@ash>
In-Reply-To: <20190201131659.GA30564@ash>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 14:54:53 -0500
Message-ID: <CAPig+cRg5E=_QuUz4j4sGNR=ziHth0Lv7hncm_hvZboBvv+bnQ@mail.gmail.com>
Subject: Re: Worktree creation race
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Marketa Calabkova <mcalabkova@suse.cz>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 8:17 AM Duy Nguyen <pclouds@gmail.com> wrote:
> I'm not going to bother you with code yet (although if you want, you
> can check out branch worktree-name on my gitlab repo), but this is
> what the user facing changes look like. Looking good?
>
> -- 8< --
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
>  SYNOPSIS
> +'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] [--name <name>] <path> [<commit-ish>]
> @@ -195,6 +195,13 @@ This can also be set up as the default behaviour by using the
> +--name <name>::
> +       Name of the working tree. Each working tree must have a unique
> +       name. This is also the directory name containing all working
> +       tree's specific information under `$GIT_COMMON_DIR/worktrees`.
> +       If `--name` is not given, the name is based on basename(3)
> +       optionally with a number suffix to make it unique.

I think the "DETAILS" section also needs to be updated. It presently says:

    The private sub-directory’s name is usually the base name of the
    linked working tree’s path, possibly appended with a number to
    make it unique.

Perhaps amend it to:

    ...to make it unique, or the name provided by `--name`.

>  Porcelain Format
>  ~~~~~~~~~~~~~~~~
>  The porcelain format has a line per attribute.  Attributes are listed with a
> @@ -341,10 +352,12 @@ $ git worktree list --porcelain
>  worktree /path/to/bare-source
>  bare
>
> +name linked
>  worktree /path/to/linked-worktree
>  HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
>  branch refs/heads/master
>
> +name other
>  worktree /path/to/other-linked-worktree
>  HEAD 1234abc1234abc1234abc1234abc1234abc1234a
>  detached

Unfortunately, this will likely break existing tools. When I had
outlined the proposed porcelain format, my suggestion was that a
"worktree" line would indicate the start of a new stanza (with no
blank line), however, as it eventually got implemented (not by me),
that recommendation wasn't quite followed. Instead, what has been
documented "officially" in the git-worktree man-page is that each
stanza will start with a "worktree" line and that there will be a
blank line between stanzas. So, the new "name" line will need to be
placed somewhere after the "worktree" line in order to avoid tool
breakage.
