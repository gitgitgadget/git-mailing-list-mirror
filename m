Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B2BEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGURlY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Jul 2023 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGURlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:41:20 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CBB30DF
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:41:18 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-765a4ff26cdso207808285a.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961278; x=1690566078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgQd/YYVjahdZdmowSFwXJgzEABp9nPpy02N6t/FmH0=;
        b=LT+d85IN3qP2tSzyTiuIouZhISMnTRTI5nLaYH37ggerOG7RSkpxSYBh/Y9j9dyRGJ
         MzdVfNj0a+BpEUNLhwQ9DvvgI54TR4dKf1Lt9jd31FgAeIIDL2JnahpTbIfwUi8xQtAf
         n8UU8tGa91t6/dOjvMzzMRMr9Ni+dlCmtTwkp7uM4uhP26JYAnyTARYwAdlLry0tAGSZ
         FBzZkKPUetoYuA2sA5FHDBxD9+sAPLE9S1CKXDZHgJ9tvRxGnXFnbspdVM3HAXrx16T5
         fdnU9hnwfGqCAYkl6sXdwmqxrCd1DTpW8gRW2jnoEEXncBO6yGIdolTrfor5NtH3PRV5
         cqAQ==
X-Gm-Message-State: ABy/qLZGriOze7qe+k7VdfNvlNZ625ad35ldhYf2JX/TWKgMuaSsO6Qn
        ly5NlfnNqlikEXZxLvU1o19x+l/fDnUXhicAYbY=
X-Google-Smtp-Source: APBJJlFSSNB8B+NAe6oC5GVU05z+3LWe19ULBGoogY6PHrSiWQ4mOijnMvBRVTQ5PZUkQNz+DkhkYeU23gCPPsozr/c=
X-Received: by 2002:ad4:4141:0:b0:62b:993:5ee2 with SMTP id
 z1-20020ad44141000000b0062b09935ee2mr722772qvp.44.1689961277912; Fri, 21 Jul
 2023 10:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689960606.git.me@ttaylorr.com> <084822126301c0e723155fd76942f2e259b77158.1689960606.git.me@ttaylorr.com>
In-Reply-To: <084822126301c0e723155fd76942f2e259b77158.1689960606.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Jul 2023 13:41:06 -0400
Message-ID: <CAPig+cQ2h+67Oxnt7FvZL-LrMF9RazfjLm5pkw4FUh3UU0T+4Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 1:31 PM Taylor Blau <me@ttaylorr.com> wrote:
> The `graph_read_expect()` function is used to ensure that the output of
> the "read-graph" test helper matches certain parameters (e.g., how many
> commits are in the graph, which chunks were written, etc.).
>
> It expects the Git repository being tested to be at the current working
> directory. However, a handful of t5318 tests use different repositories
> stored in sub-directories. To work around this, several tests in t5318
> change into the relevant repository outside of a sub-shell, altering the
> context for the rest of the suite.
>
> Prepare to remove these globally-scoped directory changes by teaching
> `graph_read_expect()` to take an optional "-C dir" to specify where the
> repository containing the commit-graph being tested is.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
> @@ -32,6 +32,13 @@ graph_git_behavior() {
>  graph_read_expect() {
> +       DIR="."
> +       if test "$1" = -C
> +       then
> +               shift
> +               DIR="$1"
> +               shift
> +       fi
> @@ -47,12 +54,15 @@ graph_read_expect() {
> -       cat >expect <<- EOF
> +       cat >$DIR/expect <<- EOF

It may not matter for any of the current callers, but we'd normally
want to quote the expansion of $DIR. Also, as I recall, some versions
of bash complain if the target of '>' is not quoted. So:

    cat >"$DIR/expect" <<-EOF

>         header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
>         num_commits: $1
>         chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
>         options:$OPTIONS
>         EOF
> -       test-tool read-graph >output &&
> -       test_cmp expect output
> +       (
> +               cd "$DIR" &&
> +               test-tool read-graph >output &&
> +               test_cmp expect output
> +       )
>  }
