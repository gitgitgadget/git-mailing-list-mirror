Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F441F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJQHTn (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:19:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43662 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQHTn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:19:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so27920251qtq.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/a2CfGyyVdaXKujwQDs+j6EPG7nLdQWMe9HMNB5WME=;
        b=YdTJBcRU7qZuZHXxWHXUZoFmw1uEYDNCjx21abGI9gryla2+O60ALocTvrfGdVSsmJ
         SqS8nSzdbm8EI4gYPuBA+gw4W2kjTO4DgGp4+M476HLVELLgoSHI8E5y2zgVWj6AZSIV
         pkBN9cpExNUr2qO79umr2sv3cR41QDcBcRoq4fDjIUwQSXVSVtOwmpxX+0a6dqZEDzUy
         XtkUdsqc+orTjwhe2E8iFTcOG/cMeB/JF/clHIYnj15az7DZB+ZDWzgMuTZverquMblK
         heJw7kPyX6fKIwk2PpR88Ebflec1ysk0aNPPqfeJfPuSe3NTfsgTZyAZ+YwQp5wa1wid
         RgOQ==
X-Gm-Message-State: ABuFfojCgBij9jU+3fJrl7OxPcjZMR2GqqEKD/C+RFKByzOOH0QqKLxP
        JTfX0ZCd6c4Zrfmhen66zm1Yjroec0cNRUp/rB4=
X-Google-Smtp-Source: ACcGV617NZ2nkOzanH3MXjhITanaJ6IBBGsz4FBoxWRCFN33R5FEQE774aw61SUbL7omdhLhUbiwHAeGidlXJq3iK+Y=
X-Received: by 2002:a0c:967b:: with SMTP id 56mr23536714qvy.62.1539732420183;
 Tue, 16 Oct 2018 16:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com> <20181012133321.20580-1-daniels@umanovskis.se>
 <CAPig+cRCfO=3BB6bvDSKLKkhiSA-4=p4-zZkAXvN446_6B1_HA@mail.gmail.com> <xmqqk1mhxzcz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1mhxzcz.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 16 Oct 2018 19:26:48 -0400
Message-ID: <CAPig+cRwy2Xhq7uJJ0OfY2nRZgPK9yHr=G+KMKuWx-PXyWv8Gg@mail.gmail.com>
Subject: Re: [PATCH v4] branch: introduce --show-current display option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 7:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > This cleanup "checkout" needs to be encapsulated within a
> > test_when_finished(), doesn't it? Preferably just after the "git
> > checkout -b" invocation.
>
> In the meantime, here is what I'll have in 'pu' on top.
>
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> @@ -119,12 +119,14 @@ test_expect_success 'git branch `--show-current` works properly when tag exists'
>         cat >expect <<-\EOF &&
>         branch-and-tag-name
>         EOF
> -       test_when_finished "git branch -D branch-and-tag-name" &&
> +       test_when_finished "
> +               git checkout branch-one
> +               git branch -D branch-and-tag-name
> +       " &&
>         git checkout -b branch-and-tag-name &&
>         test_when_finished "git tag -d branch-and-tag-name" &&
>         git tag branch-and-tag-name &&
>         git branch --show-current >actual &&
> -       git checkout branch-one &&
>         test_cmp expect actual
>  '

This make sense to me.

> @@ -137,8 +139,7 @@ test_expect_success 'git branch `--show-current` works properly with worktrees'
>         git worktree add worktree branch-two &&
>         (
>                 git branch --show-current &&
> -               cd worktree &&
> -               git branch --show-current
> +               git -C worktree branch --show-current
>         ) >actual &&
>         test_cmp expect actual
>  '

The subshell '(...)' could become '{...}' now that the 'cd' is gone,
but that's a minor point.
