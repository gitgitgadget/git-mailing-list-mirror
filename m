Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65CF1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 13:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392012AbfJWNcj (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 09:32:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46774 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389224AbfJWNcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 09:32:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so11327154wrw.13
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 06:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+gHBYjbFzEHq6w/KuEJxJh+yRTP73SlsqiNMAviJXM=;
        b=HcVouhFGrMdMwQbrhioBTXayFnzzl98Ys/lpVZqIEN+kUmoUS9DwCg1Bkgjw4XISak
         pDCfap3xEdVhBC+80ipo8+UmZNHDXSfbny/GQBRTuuGymdYvS0kwvlWQr6hD319XkFXD
         06tI5j/FiRZMklZa8RFutywhWHNhhqrEswnAg/en969U9fE1MAcUiDp+5Ca/dwZJkijk
         bCYLwhnFF98rgZBsr1OblRS8RvpR9GAR/dECQmCbQXsl4G8KWEQUJZecwGI932HNCa4I
         Qb312nY+NRzn12JWpoANOgaODwvUMRmxk4IqJLyYS0OG+jmAG/q6gz35k40SIg/RVIye
         XIDQ==
X-Gm-Message-State: APjAAAUmU/B1KyxyVnTap18hhC5LMAYQHrnhZPfQXdtHK6ixInu4jzsR
        +i/+uwuW2bGczjTxcR7XlsNX7yFEintsI2TRP2M=
X-Google-Smtp-Source: APXvYqz5mTJCUvViOD0so9aui8KV0ybzBUyEhNSq8twFwKdUzCqbQVOB31wGaEY2ndLOBpE7sdj+MvLr+GdbJcDJM2Y=
X-Received: by 2002:adf:f44e:: with SMTP id f14mr8217198wrp.56.1571837557193;
 Wed, 23 Oct 2019 06:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571832176.git.liu.denton@gmail.com> <9d915748c1953cc2683fa3189c3c98b1e9a1e299.1571832176.git.liu.denton@gmail.com>
In-Reply-To: <9d915748c1953cc2683fa3189c3c98b1e9a1e299.1571832176.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 Oct 2019 09:32:26 -0400
Message-ID: <CAPig+cQ6RCMOaf4ZtOKNtiDdKu1JED=zMKZ8afwSr0cvE2zMgw@mail.gmail.com>
Subject: Re: [PATCH 2/5] t4108: remove git command upstream of pipe
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 8:04 AM Denton Liu <liu.denton@gmail.com> wrote:
> Before, the output of `git diff HEAD` would always be piped to
> sanitize_conflicted_diff(). However, since the Git command was upstream
> of the pipe, in case the Git command fails, the return code would be
> lost. Rewrite into separate statements so that the return code is no
> longer lost.
>
> Since only the command `git diff HEAD` was being piped to
> sanitize_conflicted_diff(), move the command into the function and rename
> it to print_sanitized_diff().
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> @@ -4,11 +4,12 @@ test_description='git apply --3way'
> -sanitize_conflicted_diff () {
> +print_sanitized_diff () {
> +       git diff HEAD >diff.raw &&
>         sed -e '
>                 /^index /d
>                 s/^\(+[<>][<>][<>][<>]*\) .*/\1/
> -       '
> +       ' diff.raw
>  }

Nit: By hard-coding "HEAD" in this function, you lose the flexibility
of the original. An alternative would have been to accept the ref
against which to diff as an argument to this function:

    print_sanitized_diff () {
        git diff "$@" >diff.raw &&
        ...

Or, better yet, keep the original design and pass the diff in as the
shell function's input, so a caller would say:

    git diff HEAD >diff.raw &&
    sanitize_conflicted_diff <diff.raw >expect.diff &&

However, not necessarily worth a re-roll if we never expect anyone to
pass anything other than "HEAD".
