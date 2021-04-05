Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F0C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CAD61399
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhDERxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:53:03 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35345 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhDERxC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:53:02 -0400
Received: by mail-ed1-f53.google.com with SMTP id p4so3165567edr.2
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 10:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14kp04bK1TIohedvl9noxRz4mkptIKm/MWVdlbDujN4=;
        b=QjZWHvLTrIqucKtVgD1WRB5bOSCYkhX8yCfKk2vdvTZn4NYZfvNdzgyLUUvS2t+a3E
         Vus5Aig33h8bSTA0z2bjWoZnxrR9TgZVA+j16Ie4UVY2yQsd8lU5T8m/YRzsrx4UgEag
         RG5R2bX+CWSwgNCWIrPZN6nz3cCx1nDja18acyXoUV2Nfwc0/aZ318HOkzI3S/V+G8ZS
         qQfbwU9jkA33QAeYx17Gq3GZtlRhSptuNMBNEIPvf53sBMAbgV3DbUs8eo0ahnjTAIsL
         827Ulseu9sndHyz8shVcaszs1rtFof9XxzJVazgjXxaoy3bL9ya6SyL9/ZNzcGIh0jbG
         EWvA==
X-Gm-Message-State: AOAM533jIZ3zKqVOo2l0ht3W3VtVIuboSln77DFssP5XSB7FT6goTmuE
        ZdwZnl3Kiub7UBR+wscP7WWpB2P321LLk8zoIaU=
X-Google-Smtp-Source: ABdhPJzyAEygKq0uXvBFrvakZvBx050lBxso+rIIO45/42/PsEVZ70OSZaXHIHS1z2Qi9JnF4y9F47OoOoZ6KNkBYQg=
X-Received: by 2002:a05:6402:145:: with SMTP id s5mr32560913edu.221.1617645174832;
 Mon, 05 Apr 2021 10:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.924.git.1617627856.gitgitgadget@gmail.com> <c8d1de06f84499f2f56b3a06df665630806f94ce.1617627856.git.gitgitgadget@gmail.com>
In-Reply-To: <c8d1de06f84499f2f56b3a06df665630806f94ce.1617627856.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Apr 2021 13:52:43 -0400
Message-ID: <CAPig+cTCeED-Q_64+S5MDVFjCJdnCqYXWNS2ZDWKm4Ehjn=VXw@mail.gmail.com>
Subject: Re: [PATCH 4/5] test-tool: test refspec input/output
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Tom Saeger <tom.saeger@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 9:04 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add a new test-helper, 'test-tool refspec', that currently reads stdin
> line-by-line and translates the refspecs using the parsing logic of
> refspec_item_init() and writes them to output.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/helper/test-refspec.c b/t/helper/test-refspec.c
> @@ -0,0 +1,39 @@
> +int cmd__refspec(int argc, const char **argv)
> +{
> +       struct strbuf line = STRBUF_INIT;
> +       [...]
> +       return 0;
> +}

Leaking `strbuf line` here. Yes, I realize that the function is
returning and test-tool exiting immediately after this, so not a big
deal, but it's easy to do this correctly by releasing the strbuf, thus
setting good precedence for people who might use this as a template
for new test-tool functions they add in the future.

> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
> @@ -93,4 +93,45 @@ test_refspec fetch "refs/heads/${good}"
> +test_expect_success 'test input/output round trip' '
> +       cat >input <<-\EOF &&
> +               +refs/heads/*:refs/remotes/origin/*
> +               refs/heads/*:refs/remotes/origin/*
> +               refs/heads/main:refs/remotes/frotz/xyzzy
> +               :refs/remotes/frotz/deleteme
> +               ^refs/heads/secrets
> +               refs/heads/secret:refs/heads/translated
> +               refs/heads/secret:heads/translated
> +               refs/heads/secret:remotes/translated
> +               secret:translated
> +               refs/heads/*:remotes/xxy/*
> +               refs/heads*/for-linus:refs/remotes/mine/*
> +               2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
> +               HEAD
> +               @
> +               :
> +       EOF

Over-indented heredoc body. It is customary[1] in this codebase for
the body and EOF to have the same indentation as the command which
starts the heredoc.

> +       cat >expect <<-\EOF &&
> +               +refs/heads/*:refs/remotes/origin/*
> +               refs/heads/*:refs/remotes/origin/*
> +               refs/heads/main:refs/remotes/frotz/xyzzy
> +               :refs/remotes/frotz/deleteme
> +               ^refs/heads/secrets
> +               refs/heads/secret:refs/heads/translated
> +               refs/heads/secret:heads/translated
> +               refs/heads/secret:remotes/translated
> +               secret:translated
> +               refs/heads/*:remotes/xxy/*
> +               refs/heads*/for-linus:refs/remotes/mine/*
> +               2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
> +               HEAD
> +               HEAD
> +               :
> +       EOF

Ditto.

> +       test-tool refspec <input >output &&
> +       test_cmp expect output &&
> +       test-tool refspec --fetch <input >output &&
> +       test_cmp expect output
> +'

[1]: https://lore.kernel.org/git/CAPig+cSBVG0AdyqXH2mZp6Ohrcb8_ec1Mm_vGbQM4zWT_7yYxQ@mail.gmail.com/
