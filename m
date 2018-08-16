Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C54F1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 08:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbeHPLxW (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 07:53:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42749 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeHPLxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:53:22 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so4368500qto.9
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 01:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0udPQxkkL0AhqHZe5Y69xeM9Rk1ogckW0c/ozokxQBo=;
        b=IiAFEUriBzZyRqzpB45BUuBQLrf/BTqsXcV3A4YdgZPfqMqaPXysxZEoxglIQtfUlH
         xZ8nh2+NAqWiZZRdVDscXY1MMuxbDT+xBF8oAGP+iqQ6fwFKAGgPCsJZQQABv0kbjglv
         acngCYbzrCsfnAYqXDeXQmKkFV/TQ8rGAgE/ezCQ2yKT5EPfGE1bxymI0WFW2kak0/lF
         AwPkpvHHbNHT/9MEMQ11KOkSvlMNG7UBBaqjjrlGpioqoJ0CKYXrYEkRKvAmMF/rJ9R6
         mPREN8Fn6mbd91SoktDdShgoK7JHKQLsG/MKTYzDeXGjs4ZHSArHOnXd6fT4iu/2Xc4D
         nYbg==
X-Gm-Message-State: AOUpUlGaiBC7fcaU6eMvo7PsgAJOoPTLnEdFmiMxRBde8DdOWaMb6Yp+
        C/cHsMKasaOXTOwi54M68RLwcCF/Y9MHc6IhzGM=
X-Google-Smtp-Source: AA+uWPyrdKk8/a1K6jBYSZNiIrDP4j4rQq6E0YgE2fjAdkrebVb8QD2O+lE6C28F3nqjoaXr6tnLJHA4ahQJYCh7Ndc=
X-Received: by 2002:ac8:1019:: with SMTP id z25-v6mr28993991qti.25.1534409778895;
 Thu, 16 Aug 2018 01:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cSUy7rFwhmJ1SFHsAjPkoWparfY6wAjV=6kJyUL3SLQUw@mail.gmail.com>
 <20180816080549.33544-1-samuel.maftoul@gmail.com>
In-Reply-To: <20180816080549.33544-1-samuel.maftoul@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 Aug 2018 04:56:07 -0400
Message-ID: <CAPig+cR5cu3cxtpdHsbSSK7xWRpMQh_sv5nvunZrojAOkFeedg@mail.gmail.com>
Subject: Re: [PATCH] branch: support configuring --sort via .gitconfig
To:     samuel.maftoul@gmail.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 4:06 AM <samuel.maftoul@gmail.com> wrote:
> Add support for configuring default sort ordering for git branches. Command
> line option will override this configured value, using the exact same
> syntax.
>
> Signed-off-by: Samuel Maftoul <samuel.maftoul@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1034,6 +1034,12 @@ branch.autoSetupRebase::
> +branch.sort::
> +       This variable controls the sort ordering of branches when displayed by
> +       linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
> +       value of this variable will be used as the default.
> +       See linkgit:git-for-each-ref[1] field names for valid values.

Thanks for adding some information about what values are valid for
this config variable.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> @@ -272,6 +272,9 @@ start-point is either a local or remote-tracking branch.
>         full refname (including `refs/...` prefix). This lists
>         detached HEAD (if present) first, then local branches and
>         finally remote-tracking branches.
> +       Sort order defaults to the value configured for the `branch.sort`
> +       variable if it exists, or lexicographic order otherwise. See
> +       linkgit:git-config[1].

This change still has problems pointed out by my earlier review[1].
The existing text in git-branch.txt says:

    Sort order defaults to sorting based on the
    full refname...

Which is both redundant with the new text you add and seems to say
something rather different.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -1305,4 +1305,51 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
> +test_expect_success 'invalid sort parameter in configuration' '
> +       (
> +               cd sort &&
> +               git config branch.sort "v:notvalid" &&
> +               test_must_fail git branch
> +
> +       )
> +'

See my earlier review[1] regarding the unnecessary blank line in this new test.

[1]: https://public-inbox.org/git/CAPig+cSUy7rFwhmJ1SFHsAjPkoWparfY6wAjV=6kJyUL3SLQUw@mail.gmail.com/
