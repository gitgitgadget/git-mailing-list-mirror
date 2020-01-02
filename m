Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F23C2D0DD
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CC7215A4
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 08:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgABISl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:18:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39426 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgABISl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 03:18:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so4918037wmj.4
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 00:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr8YzdNb9KfsXhd27LmEXpwf4wh3i/RcgfGpfG3eQIw=;
        b=rKMMTB321t2RwRXqbVoBdvmLlkjDoSlgCKRJOncuL+nNsJ7lQVRn0vxX85TVQJxX6E
         YNo0VhccMQ3QmnKRolo3zvF+SdudSji/7EbU0HUBZpNIXU+YhIdSAfiJp0x/VdVHF+Pp
         WMauzZCYcLrzQtb/o6P5wgHZE70kDNIy9SY/WNoAa5GIcNte7D57wF7qHFxdtsKzu31v
         eyLop+g+DCDI3z/PKtuQb9mowtpp5DroZbNxrTqyGIl255ctQh65yyT877lmRfPwjCTO
         8Kvyp6IcEwrqoOKq/2ACHxGGTPJfCBKh4BqfxTm2gbeQp2Rm0eEbJ17plY063RjAO7Oo
         QQJg==
X-Gm-Message-State: APjAAAVUmpVFNlcCWIJ8pZLtumg4/0PdaIqvY7DvI8cUYHvK5XV+ouGQ
        hyo5W2MOUiQP4E2383gPptbc+3fHfsfQ57M9RiWLeKs5
X-Google-Smtp-Source: APXvYqyNiCEDRWM8E0j3xy8nk5kWNR2JcvsJRII6yI8ZtTAeAkXh/UM4avDyugzVvQczLx7k+W/gOjDYOHEtRQ8/340=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr13802693wml.55.1577953120055;
 Thu, 02 Jan 2020 00:18:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com> <82bf24ce537ca9333d72c2b4698864817801f10f.1577933387.git.gitgitgadget@gmail.com>
In-Reply-To: <82bf24ce537ca9333d72c2b4698864817801f10f.1577933387.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Jan 2020 03:18:29 -0500
Message-ID: <CAPig+cS39vcy6yT3Dg2HfGVCyg2U+7t7Xj85ayM7LaAk3zTjrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 1, 2020 at 9:50 PM Heba Waly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Display a hint to the user when attempting to delete a checked out
> branch saying "Checkout another branch before deleting this one:
> git checkout <branch_name>".
>
> Currently the user gets an error message saying: "error: Cannot delete
> branch <branch_name> checked out at <path>". The hint will be displayed
> after the error message.
>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -240,6 +240,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>                                 error(_("Cannot delete branch '%s' "
>                                         "checked out at '%s'"),
>                                       bname.buf, wt->path);
> +                               advise(_("Checkout another branch before deleting this "
> +                                                "one: git checkout <branch_name>"));

s/another/a different/ would make the meaning clearer.

Let's try to avoid underscores in placeholders. <branch-name> would be
better, however, git-checkout documentation just calls this <branch>,
so that's probably a good choice.

However, these days, I think we're promoting git-switch rather than
git-checkout, so perhaps this advice should follow suit.

Finally, is this advice sufficient for newcomers when the branch the
user is trying to delete is in fact checked out in a worktree other
than the worktree in which the git-branch command is being invoked?
That is:

    $ pwd
    /home/me/foo
    $ git branch -D bip
    Cannot delete  branch 'bip' checked out at '/home/me/bar'
    hint: Checkout another branch before deleting this one:
    hint: git checkout <branch>
    $ git checkout master # user follows advice
    $ git branch -D bip
    Cannot delete  branch 'bip' checked out at '/home/me/foo'
    hint: Checkout another branch before deleting this one:
    hint: git checkout <branch>
    $

And the user is left scratching his or her head wondering why
git-branch is still showing the error despite following the
instructions in the hint.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -808,7 +808,8 @@ test_expect_success 'test deleting branch without config' '
>  test_expect_success 'deleting currently checked out branch fails' '
>         git worktree add -b my7 my7 &&
>         test_must_fail git -C my7 branch -d my7 &&
> -       test_must_fail git branch -d my7 &&
> +       test_must_fail git branch -d my7 >actual.out 2>actual.err &&
> +       test_i18ngrep "hint: Checkout another branch" actual.err &&

Why does this capture standard output into 'actual.out' if that file
is never consulted?

>         rm -r my7 &&
>         git worktree prune
>  '
