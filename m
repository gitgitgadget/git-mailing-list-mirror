Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F721F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441835AbfJQXtO (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:49:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37466 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441728AbfJQXtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:49:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so4231079wro.4
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tybt1OKfvYMxUC4ys/J7mhehwruq1Q0Jj7Bqv4K2rkI=;
        b=icW71CRqxGNpMdbJu6o2jbCIu247hzgxvpDKpUW+vXsXE4OPwgtCyqQ+fQ80KFyqX3
         DlI6QrVXHga/YHKnO+/P+WesprjcxPWqNsNzfXXdF9og54gSCaDKy8moDH9PgPz02cU/
         K8p3qEFEfVxY7WK+KEcMetOScS1LSTuxE7uhskHbsvM+w54JTTIDdU31nTPkVD5gcDpY
         7jU1+zicI2w7DtqreRUry3Rt+2vsukDaNHE8zApy7iBsr3T/m17oXKEnbhbnZw3j8n12
         CPVRD8CYcJfavqfYlZxtnPRMnhkl8J86F1Gj1fogDokbKBEbdtr9cHTlwBxf8Hqp8EP7
         xl3g==
X-Gm-Message-State: APjAAAUm8EY1rVR/vTLgf5CL+SjzagkFmXCezurUA4svq0fATtAfdGCl
        UOVNVTKw2lf+cTIKmLLnAxw9eOJYkA0vrhmpzyU=
X-Google-Smtp-Source: APXvYqz3aj3KqpDKFp65a+gJo77WP9btByZiEQ0xti91/WBmi+1Fnx+9/D1OGglls0g2lCP6zKdyJ3oQ+394X8bIYgc=
X-Received: by 2002:a5d:430d:: with SMTP id h13mr5066393wrq.163.1571356152151;
 Thu, 17 Oct 2019 16:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571354136.git.liu.denton@gmail.com> <f1b515fc0ed431f03244eefbe9f8f34921f4c62d.1571354136.git.liu.denton@gmail.com>
In-Reply-To: <f1b515fc0ed431f03244eefbe9f8f34921f4c62d.1571354136.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 19:49:01 -0400
Message-ID: <CAPig+cTkqu6mmBV2sfXzfnxomkji1bhH-u=OToGkLQMVF1CRMQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] t5520: test single-line files by git with test_cmp
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 7:17 PM Denton Liu <liu.denton@gmail.com> wrote:
> In case an invocation of a Git command fails within the subshell, the
> failure will be masked. Replace the subshell with a file-redirection and
> a call to test_cmp.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -622,10 +648,16 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
>                 git add staged-file &&
> -               test "$(git ls-files)" = staged-file &&
> +               echo staged-file >expect &&
> +               git ls-files >actual &&
> +               test_cmp expect actual &&
>                 test_must_fail git pull --rebase .. master 2>err &&
> -               test "$(git ls-files)" = staged-file &&
> -               test "$(git show :staged-file)" = staged-file &&
> +               echo staged-file >expect &&
> +               git ls-files >actual &&
> +               test_cmp expect actual &&
> +               echo staged-file >expect &&
> +               git show :staged-file >actual &&
> +               test_cmp expect actual &&

Nit: I'm not convinced that it makes sense to re-create the "expect"
file with the exact same content repeatedly in this one test. There is
some value in creating the file once and then _using_ it repeatedly
since that shows intent that the the result of these various commands
is not expected to change.
