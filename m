Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD8C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C5422C9C
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbhAXIne (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 03:43:34 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34879 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbhAXInc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 03:43:32 -0500
Received: by mail-ed1-f42.google.com with SMTP id j13so11582051edp.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 00:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NauqjFI5RxtP0C0qJpH4EzfY+oFSU3kx6FUhvK6MUM=;
        b=ZQPGL1Awq8/cZE55IP9u76H3udBb3I/ZxVfAdE1/jW9w6pou+bSXikPh7vMoNALfJo
         8xEo3xC/0IjS3erOR6+p8ubtrSmZP5VdF5mFyeD7HZVvwgV1x/HfrtuTPRuw7cxzigCM
         8fu9epXtnmedR4ndDd0oR1UOV/LwxLfTp430+1JD2+nhLE+kI2J+6dHTxoFJovGrXquh
         ij+fB3StgBj50aFFiEPh1zpszUz71CssID4pHUXCkvdoVP1eIRfoqt+VnzNjyzgewY0C
         JlZJE54dnSoTpy8pghL2xVx+8mcB3X/2gQ7mNpargPTMd7Lk4IyU5JKJ3R4tlpkRMsA/
         qMYQ==
X-Gm-Message-State: AOAM5333fTYDZxZOYcaSYW7lHxJJyUhveiLJoecqMpfoPCq1rQRL2OxT
        386eaZG7s788r31J+ZqDts2MqZBd5/HcsFO/aWc=
X-Google-Smtp-Source: ABdhPJzhCVMNiwlp/1kv5913lN5ipMQd/+TB29+I0+ORcTOEpUTlLGe0opQHRZ3bZ/exyLSjogM5QlOqlGL4wumWZ3w=
X-Received: by 2002:a05:6402:310d:: with SMTP id dc13mr1021565edb.291.1611477770615;
 Sun, 24 Jan 2021 00:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com> <20210119212739.77882-8-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210119212739.77882-8-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Jan 2021 03:42:39 -0500
Message-ID: <CAPig+cQnp1iV4u9Z6cArSEq-oMrQW6yQVG6VTTjnOZ3MNO9nEQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] worktree: teach `list` verbose mode
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> [...]
> Let's teach "git worktree list" a --verbose mode that outputs the reason
> why the worktrees are being annotated. The reason is a text that can take
> virtually any size and appending the text on the default columned format
> will make it difficult to extend the command with other annotations and
> not fit nicely on the screen. In order to address this shortcoming the
> annotation is then moved to the next line indented followed by the reason
> If the reason is not available the annotation stays on the same line as
> the worktree itself.
> [...]
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -134,6 +134,36 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
> +test_expect_success '"list" all worktrees --verbose with locked' '
> +       test_when_finished "rm -rf locked1 locked2 out actual expect && git worktree prune" &&
> +       git worktree add locked1 --detach &&
> +       git worktree add locked2 --detach &&
> +       git worktree lock locked1 &&
> +       git worktree lock locked2 --reason "with reason" &&
> +       test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&

Same minor problem here as mentioned in my review of [5/7]: If locking
of the second worktree fails then test_when_finished() won't get
invoked, so the first worktree won't get unlocked, thus won't be
pruned. To fix:

    git worktree lock locked1 &&
    test_when_finished "git worktree unlock locked1" &&
    git worktree lock locked2 --reason "with reason" &&
    test_when_finished "git worktree unlock locked2" &&

> +       echo "$(git -C locked2 rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
> +       printf "\tlocked: with reason\n" >>expect &&
> +       git worktree list --verbose >out &&
> +       grep "/locked1  *[0-9a-f].* locked$" out &&
> +       sed -n "s/  */ /g;/\/locked2  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
> +       test_cmp actual expect
> +'
