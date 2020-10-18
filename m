Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD2C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 06:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C1B2087C
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 06:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgJRGMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 02:12:00 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42307 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgJRGMA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 02:12:00 -0400
Received: by mail-ej1-f67.google.com with SMTP id h24so9400399ejg.9
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 23:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6+xX4xal4uFHnTGV3wPJt6AVAZp39GpvHPPQrnRTHE=;
        b=VNNBHlX047Y21eJJ/g1zIxmVWJjqSJqi2nBofCcc+QPp3cApbSCblBKquY4kWqq9HV
         UE4Uha+jKfuWwNXF5OfSk8Lfr1McbutnQ/pg2h8q0rYLT0G1tmW1L+HSlij1bT/CgTkU
         IrDLOtIjcT06lP8xoCn7VD16QpCqeSxZrOb/olxkx7jf9BltZedOLCOYVILJScCPrWCT
         N4DuO6sKJtQpYg9Ug84Iwt3juRsRoxW9I7nq4X+4TNfKhgYyxttLhDo0gOkvHD4E1mZZ
         sw/9S8Hn6u8PZifuVBXg7l5Ig4ouBUXMs3FEc3YsMLKdRyK9+uPdJcDkH2h6ZUspcQ2e
         P8gA==
X-Gm-Message-State: AOAM533YmdGubAtE4z3qqM0jLfem2Kh54AUIN9bd5qdZKeV80cOV23cl
        CZKG1Fq0HIHcp8AfqV8/7CyEe2Nysy/Xv9P6mQU=
X-Google-Smtp-Source: ABdhPJz2B1feuLHds4UUIgBO3bOX66y4ruKduaSS0AJHij15pTOWYqqRhEF8cRLbpq1kTkwKc62UmwcElWRazHUBOxQ=
X-Received: by 2002:a17:906:50e:: with SMTP id j14mr11593706eja.138.1603001517965;
 Sat, 17 Oct 2020 23:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com> <fc2da014a62c387009e2175435286afef64d6598.1602950552.git.gitgitgadget@gmail.com>
In-Reply-To: <fc2da014a62c387009e2175435286afef64d6598.1602950552.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Oct 2020 02:11:47 -0400
Message-ID: <CAPig+cQnfcc9W3qE5XkyLiwNyK8Wm2SsAyjzatDWEVUi3s8APw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9832,t2200: avoid using pipes in git commands
To:     Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 17, 2020 at 12:02 PM Amanda Shafack via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When the upstream of a pipe throws an error, the downstream still
> executes normally. This happens because the exit code of the upstream
> in a pipe is ignored. This behavior can make debugging very hard
> incase a test fails.

To be more precise, we're not worried about difficulty of debugging
when a Git command is upstream in a pipe. What we are more concerned
with is that an unexpected failure of the Git command will go
unnoticed (unless it also happens to produce wrong output which is
later caught somewhere downstream). By avoiding placing Git upstream
in a pipe, we can actively catch a failure of the Git command. The
commit message should focus on that reason instead.

> Also, pipes are prone to deadlocks. If the
> upstream gets full, the commands downstream will never start.

I don't think this is ever an issue in Git tests, so talking about it
here probably only muddies the waters, thus makes the commit message
less precise and more hand-wavy. Dropping this sentence is
recommended.

> Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) noticed that
> the exit code of upstream in the pipe is ignored, thus using pipes
> should be avoided.

There are a lot of commits in the project history which perform this
sort of transformation, so it's not clear to the reader why this
particular commit is called out as being important. If it's not, then
I'd recommend dropping this sentence, as well.

> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
>  test_expect_success '"add -u non-existent" should fail' '
>         test_must_fail git add -u non-existent &&
> -       ! (git ls-files | grep "non-existent")
> +       ! (
> +               git ls-files >actual &&
> +               grep "non-existent" actual
> +       )
>  '

This transformation appears to be incorrect. See my review of patch
[2/2] for details.

> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> @@ -68,7 +68,8 @@ EOF
> -               git show refs/remotes/p4-unshelved/$change | grep -q "Further description" &&
> +               git show refs/remotes/p4-unshelved/$change >actual &&
> +               grep -q "Further description" actual &&

This transformation looks fine.
