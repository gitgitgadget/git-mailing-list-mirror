Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3A51F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 09:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfKPJA4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 04:00:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46873 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfKPJAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 04:00:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so13476506wrs.13
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 01:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+B9O0VGnbiEA2SiFFk5CUooRiug22pDxZ4uuOdTHf0=;
        b=lYWEcG4hhGjG50SLeZhNEb0CRyJ2SvVSIjNTr/CQuhuQdF1PK+Ukz9uRTX/aGEzlsV
         OC8lX87M/vjCePc2ZncNNeMY9lRrPIJ2YOB3Kz781YOZ9HQE90a5C6hRsU1grLIuAUsB
         XlxYlQg1kzglS59XgSkvduWmjWyeksQMYPslvXRBRAoX/g78d+KHJDE3qshMmFytXmN/
         7cO1I3xhGmRuvVzfW86tz1VDn+YCSofflrO0EGpTb0OQEXnzF+tQcXEhV5CVEVaO3EOb
         Azk7l0dUbrPj0f4U7VN9l6FrTp6Juv1osQguQtdTSisOa/4fRpFdFOZU+UksQc6R9fDY
         38GQ==
X-Gm-Message-State: APjAAAXwSOvOZ9DxT4tTsLZK4E8wenZIBZD/jzY/g3PGIaKqSYfEQt/r
        i6RVL/9gsQNRFC7qe30k1/Y6zCDX7ipPoEPVOtSZGhKj
X-Google-Smtp-Source: APXvYqwWplk5daNi0U6ZugwOzAimsP+8HbljUpseaZaX6GuaCwkMXT7p1y7eqcaG4FAYg48a50wPVav6pby1wtA3/l8=
X-Received: by 2002:a5d:6410:: with SMTP id z16mr1229407wru.78.1573894846349;
 Sat, 16 Nov 2019 01:00:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779465.git.liu.denton@gmail.com> <d617cbaaf1232e45b077786afaa9d3465a9bbd35.1573779465.git.liu.denton@gmail.com>
In-Reply-To: <d617cbaaf1232e45b077786afaa9d3465a9bbd35.1573779465.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Nov 2019 04:00:35 -0500
Message-ID: <CAPig+cSFoksyqTGeL7tNh7sjXWVPi9HYS6+6qui6C-VE0LqedA@mail.gmail.com>
Subject: Re: [PATCH 10/27] t4138: stop losing return codes of git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 8:01 PM Denton Liu <liu.denton@gmail.com> wrote:
> In a pipe, only the return code of the last command is used. Thus, all
> other commands will have their return codes masked. Rewrite pipes so
> that there are no git commands upstream so that we will know if a
> command fails.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
> @@ -17,8 +17,8 @@ test_expect_success setup '
> -       git diff --no-index before after |
> -               sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
> +       test_must_fail git diff --no-index before after >patch1.patch.raw &&
> +       sed -e "s/before/test-1/" -e "s/after/test-1/" patch1.patch.raw >patch1.patch &&

I think this is a semantically incorrect use of test_must_fail(). What
you're interested here is that git-diff found differences (as opposed
to not finding any), so you want to test its exit code which reflects
whether or not the files were different. Hence, the following would be
more appropriate:

    test_expect_code 1 git diff --no-index before after >patch1.patch.raw &&

Same comment applies to remaining changes in this patch.
