Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87FEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 18:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGUS2b convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Jul 2023 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGUS2a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 14:28:30 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64258EB
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:28:29 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-48165cd918dso907816e0c.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964108; x=1690568908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB80i+l8oBnRLTnjIjJBjKBsE/xog+AAUci/7lNadXY=;
        b=B9lcX6dwT/4PuLSesEnWztBB8MMrC2Rto+fb4hS5CN09aIqbiPRmWBfb4AiajyZcWd
         oxZjw+7zO7jSx4dOMrNx6gcpAAiNp5X+6aQgUocW8NpVlLNIoxy/S7WTiA+WKUeEeiOH
         wu5GzPbcnpo7zggdAlivBmK2JWdk9Tw9RK00ERa+xqJnhkFn8dcigGF/puihiBa4kRzO
         nb3/aNXvPsUPZ9Sv8ShkHyCzFqbW7cUOIE1CzXB1AlP881mPEH1FEK1vxy00Qd+2pL8C
         rSFdyoCXW4Yo2n8qbGdfJxUiXyiSmFV9E5Fm+6/Ij90fa5wtrefvzFdEXEjOqf22Cbns
         ATOQ==
X-Gm-Message-State: ABy/qLZsiobv7rZF+tVcO46bySncveqH42UMyRxhedYHygmYw9/SNArH
        AxokV+56ynz3Z4vpzjRt1mkaNR9dDjWpJyByQrE=
X-Google-Smtp-Source: APBJJlFviMDS43g7b+DfmGWfkudxREdx6uGbihiyAyhxuWLZFJXkGntPMZxfMfRwRxt2n1knv4E23QC6jSXtmPv5ALY=
X-Received: by 2002:a1f:4115:0:b0:471:1b41:dbb2 with SMTP id
 o21-20020a1f4115000000b004711b41dbb2mr2054612vka.10.1689964108400; Fri, 21
 Jul 2023 11:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689960606.git.me@ttaylorr.com> <451ec003be8714bc38cc8cdc159add3e8899ce57.1689960606.git.me@ttaylorr.com>
In-Reply-To: <451ec003be8714bc38cc8cdc159add3e8899ce57.1689960606.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Jul 2023 14:28:17 -0400
Message-ID: <CAPig+cSkoHnUY0obKkz93k7mHXrFj+kwJ21yPHy=KYroAQtiUA@mail.gmail.com>
Subject: Re: [PATCH 3/5] t5318: avoid top-level directory changes
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 1:33 PM Taylor Blau <me@ttaylorr.com> wrote:
> Avoid changing the current working directory from outside of a sub-shell
> during the tests in t5318.
>
> Each test has mostly straightforward changes, either:
>
>   - Removing the top-level `cd "$TRASH_DIRECTORY/full"`, which is
>     unnecessary after ensuring that other tests don't change their
>     working directory outside of a sub-shell.
>
>   - Changing any Git invocations which want to be in a sub-directory by
>     either (a) adding a "-C $DIR" argument, or (b) moving the whole test
>     into a sub-shell.
>
> While we're here, remove any explicit "git config core.commitGraph true"
> invocations which were designed to enable use of the commit-graph. These
> are unnecessary following 31b1de6a09b (commit-graph: turn on
> commit-graph by default, 2019-08-13).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> @@ -69,117 +64,106 @@ test_expect_success 'create commits and repack' '
>  test_expect_success 'Add more commits' '
>  ...
> -       git reset --hard commits/2 &&
> -       git merge commits/4 &&
> -       git branch merge/1 &&
> -       git reset --hard commits/4 &&
> -       git merge commits/6 &&
> -       git branch merge/2 &&
> -       git reset --hard commits/3 &&
> -       git merge commits/5 commits/7 &&
> -       git branch merge/3 &&
> -       git repack
> +       git -C full reset --hard commits/2 &&
> +       git -C full merge commits/4 &&
> +       git -C full branch merge/1 &&
> +       git -C full reset --hard commits/4 &&
> +       git -C full merge commits/6 &&
> +       git -C full branch merge/2 &&
> +       git -C full reset --hard commits/3 &&
> +       git -C full merge commits/5 commits/7 &&
> +       git -C full branch merge/3 &&
> +       git -C full repack
>  '

This is one of those cases in which "cd full" while in subshell,
rather than using "-C full" repeatedly, would perhaps make the code a
bit less noisy, but it is, of course, subjective and what you have
here is good enough.

> @@ -229,114 +211,101 @@ graph_git_behavior 'mixed mode, commit 8 vs merge 1' full commits/8 merge/1
>  test_expect_success 'build graph from latest pack with closure' '
> -       cd "$TRASH_DIRECTORY/full" &&
> -       cat new-idx | git commit-graph write --stdin-packs &&
> -       test_path_is_file $objdir/info/commit-graph &&
> -       graph_read_expect "9" "generation_data extra_edges"
> +       git -C full commit-graph write --stdin-packs <new-idx &&
> +       test_path_is_file full/$objdir/info/commit-graph &&
> +       graph_read_expect -C full 9 "generation_data extra_edges"
>  '

This works because an earlier test created "new-idx", and it created
it directly in the trash-directory rather than in the "full"
subdirectory where it used to reside before this patch. Okay.

> @@ -495,25 +464,24 @@ GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
>  corrupt_graph_setup() {
> -       cd "$TRASH_DIRECTORY/full" &&
> -       test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> -       cp $objdir/info/commit-graph commit-graph-backup &&
> -       chmod u+w $objdir/info/commit-graph
> +       test_when_finished mv commit-graph-backup full/$objdir/info/commit-graph &&
> +       cp full/$objdir/info/commit-graph commit-graph-backup &&
> +       chmod u+w full/$objdir/info/commit-graph
>  }

Prior to this patch, "commit-graph-backup" was placed in the "full"
subdirectory and test_when_finished() removed it from that location.
As of this patch, "commit-graph-backup" is placed in the top-level
trash-directory and cleaned up from there. Okay.
