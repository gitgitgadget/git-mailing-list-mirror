Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB27C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 05:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA204208B8
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 05:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgITFbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 01:31:37 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33724 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgITFbh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 01:31:37 -0400
Received: by mail-ej1-f67.google.com with SMTP id j11so13432222ejk.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 22:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUcSN29ZtXZDrq1Z3kyMlBYkodtJ3p5ZhGxCLe9nssk=;
        b=rJ8MyPx4rpPIa1bFZrCW+hqQFBMbNTBCJhoGl2vsJ7l3nT8+WXivA9VoOQq+HpetMw
         Jovey47IO6mVmMgkTS+fdlXmfqQjnhWGItmF5cH2W3l6H/FbMCIu7wvshKPE9hgOAwR8
         1pfOfukmMn7B048IewOOtjFq570GqLH4CG7yzkMNJxkshTpQ1IZJFfUaW1j3lXZEG9ho
         BOW0R/EcVtVyQEaGXhJpUx7edVIBc50HRrs/27YAMEpJjwX3PIQAIBkFGEATknQccg86
         yjv7m5rz2jrez78GCduAFU/uSRvmURboPOhmhcLU4jn/LDgBpY2Q3+vC8qFQbEuoytHo
         dAQA==
X-Gm-Message-State: AOAM531jpqBfVRU1ioqrYrpEX+zEuGQpQQaJFO5xqB9RENTI9oGhX2UD
        sJtnddRqXgc65Iqp0YstnAFtxqTEgSaiqwNkeFPis5GTkwg=
X-Google-Smtp-Source: ABdhPJymZUJX2rTXgLZjkKnKstrndgEtwzszWEbTAbq0mewT2CA3iDvRsBv0UqoV3LrqY+BhDmXaiHtt5zI0Bm4gfIE=
X-Received: by 2002:a17:906:c045:: with SMTP id bm5mr6380065ejb.311.1600579896116;
 Sat, 19 Sep 2020 22:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200919085441.7621-1-luke@diamand.org> <20200919085441.7621-2-luke@diamand.org>
In-Reply-To: <20200919085441.7621-2-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 20 Sep 2020 01:31:25 -0400
Message-ID: <CAPig+cSx35oTR_Er-DyxqV0HZw+tDHPf1GdARfw=-2bhTz02gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-p4 unshelve: adding a commit breaks git-p4 unshelve
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 19, 2020 at 4:54 AM Luke Diamand <luke@diamand.org> wrote:
> git-p4 unshelve: adding a commit breaks git-p4 unshelve
>
> git-p4 unshelve uses HEAD^$n to find the parent commit, which
> fails if there is an additional commit.

It was a bit difficult understanding the purpose of this patch based
upon the commit message alone. It might be clearer if written like
this:

    git-p4: demonstrate `unshelve` bug

    `git p4 unshelve` uses HEAD^$n to find the parent commit, which
    fails if there is an additional commit. Augment the tests to
    demonstrate this problem.

> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> @@ -29,8 +29,11 @@ test_expect_success 'init depot' '
> +# Create an initial clone, with a commit unrelated to the P4 change
> +# on HEAD
>  test_expect_success 'initial clone' '
> -       git p4 clone --dest="$git" //depot/@all
> +       git p4 clone --dest="$git" //depot/@all &&
> +    test_commit -C "$git" "unrelated"
>  '

Strange indentation of the new line. Use TAB rather than spaces.
