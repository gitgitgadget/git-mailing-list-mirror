Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB304C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3F20748
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCZPYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:24:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34938 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgCZPYT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:24:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so8347262wrn.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xx9gFLIvxP/ApmU3pg9ZZDuDWxSgi6Wn6Z6U7pqn8U0=;
        b=ILZEz5/Yl//91vZO/+F+9H2pr2zZk1YWje+FulN8RhEaci10pyno3NKXK9KezxJq45
         GJq2q70bZvMo4SsB3Ao5Yvz6ZAvKUmqZJmDlivINO9ItlN1rcvFZOtmR+HmBS3zk6nYB
         gR7BqWnGUDcy9a1qhNTNKjKw7JnOgcp3Ae0/Ak6LmkcQ3sdSlBQM6NAUj6K2C90TAwoc
         xQ+DVID300UKgdMo5XiCVt5lucvM+//Vdm2FORoOEFlpZK8LbP2/Up6CF77vFB7YGq5D
         ml2UKz0JyPBK6c+4EVivt79vKKKvMMeEzn1jgjr5cVErTzZ7n0IuLNXbwK5PHi/BokSg
         Po1Q==
X-Gm-Message-State: ANhLgQ2Uo9E20PKQyHNERR+3iTQpkqmkwIUsNQw7zI4/C98r4tlG7unM
        UNgc9NA/tKkulciHNh+SD181kfYWXJyaazT9RPS8OwOJ
X-Google-Smtp-Source: ADFU+vvsN5/VtsZA+7Wmpr8udICWLfbS/fvxdtYXSjx37Ac3K3ThShvRafFqQThGPqlYLFJSE9+k5nR06ifd3yfmA50=
X-Received: by 2002:adf:94c6:: with SMTP id 64mr10105688wrr.386.1585236257575;
 Thu, 26 Mar 2020 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
 <97bc46e4a9105f13b5284f86907eb1459a9987b6.1585209554.git.liu.denton@gmail.com>
In-Reply-To: <97bc46e4a9105f13b5284f86907eb1459a9987b6.1585209554.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Mar 2020 11:24:06 -0400
Message-ID: <CAPig+cTpV2n66nYJdQpG0tYCu5f=PB-a9Boa_NNfVaUOshDVug@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] t5512: stop losing git exit code in here-docs
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 4:28 AM Denton Liu <liu.denton@gmail.com> wrote:
> The expected references are generated using a here-doc with some inline
> command substitutions. If one of the `git rev-parse` invocations within
> the command substitutions fails, its return code is swallowed and we
> won't know about it. Replace these command substitutions with
> generate_references(), which actually reports when `git rev-parse`
> fails.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> @@ -212,17 +217,18 @@ test_expect_success 'protocol v2 supports hiderefs' '
>  test_expect_success 'ls-remote --symref' '
> +       echo "$oid      refs/remotes/origin/HEAD" >>expect &&
> +       generate_references \
> +       refs/remotes/origin/master \
> +               refs/tags/mark \
> +               refs/tags/mark1.1 \
> +               refs/tags/mark1.10 \
> +               refs/tags/mark1.2 >>expect &&

Botched indentation of the "refs/remotes/origin/master" line.
