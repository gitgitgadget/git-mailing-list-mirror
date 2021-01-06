Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F33CC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D192310C
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbhAFJjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:39:55 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34188 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFJjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 04:39:54 -0500
Received: by mail-ed1-f54.google.com with SMTP id dk8so3874541edb.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzrUjx3QnOPVgSEvIIo7pXJbyZzMZEGWVnh5QZQA3uU=;
        b=HDFAwVpcwdSK2t9/DA86hU2G8hw1h0JviyPrfaFlw8XbC7idmpv0RCaPV+QqjxvVNj
         Wa8FD5z/BeZEi2crSkc6CxdKEjcvu9OR51VqalYwyi8TXLfHzbuq90JKB8ORuHtTRnf4
         2ALVp7ZoHHBxgHiDU6uhr3xV+3tB8Cxh9Z9bqLTr1CmD++yHFRzSFRqE65x9WKWkDscV
         C8mqtnOwCtLyg7uNC05ji2uJUz/sH5KRdaIT4M2oSKy9h5Ab71ycHg7yGc678JTdHKFd
         SaJZ6NXTqiIBxRS3nKuhwO6KxnG7dgCxV51ZRCmsYJtYD6esxBbd3mbZia+h5djp1Kdl
         tHQw==
X-Gm-Message-State: AOAM532gdNz0239FSrvdp4aV+4iDzNbd4M1i1jyXbxkyQvhB7pE301V2
        wPuORtaVO2eoT3gRKATjOC4wVlfyX2fB8wFFy/M=
X-Google-Smtp-Source: ABdhPJw+d0v5FeAg0QgDKGR6NqOYwWpnK2I4mzPVwW/jRJIgoplgG14SzQQLb52/KsEJkauGXqXmfd8aQGLwVUiJD7w=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr3395153edu.163.1609925952989;
 Wed, 06 Jan 2021 01:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-7-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-7-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 04:39:01 -0500
Message-ID: <CAPig+cRysXpK0e1xXOuVd+EtkeyTk8FR6MUrL=Bg3W4ve8jdNA@mail.gmail.com>
Subject: Re: [PATCH 6/7] worktree: add tests for `list` verbose and annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Add tests for "git worktree list" verbose mode, prunable and locked
> annotations for both default and porcelain format and ensure the
> "prunable" annotation is consistent with what "git worktree prune"
> command will eventually remove. Additionally, add one test case to
> ensure any newline characters are escaped from locked reason for the
> porcelain format to prevent breaking the format.
>
> The c57b3367be (worktree: teach `list` to annotate locked worktree,
> 2020-10-11) introduced a new test to ensure locked worktrees are listed
> with "locked" annotation. However, the test does not remove the worktree
> as the "git worktree prune" is not going to remove any locked worktrees.
> Let's fix that by unlocking the worktree before the "prune" command.
>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -62,7 +62,9 @@ test_expect_success '"list" all worktrees --porcelain' '
>  test_expect_success '"list" all worktrees with locked annotation' '
> -       test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
> +       test_when_finished "rm -rf locked unlocked out &&
> +               git worktree unlock locked &&
> +               git worktree prune" &&
>         git worktree add --detach locked master &&
>         git worktree add --detach unlocked master &&
>         git worktree lock locked &&

You might need to be a bit more careful here. If the test fails before
the worktree is locked, then the `git worktree unlock` in the cleanup
code will return an error, which will make the code executed by
test_when_finished() fail, as well, which makes it harder to debug
problems. Moving the `unlock` cleanup after you know the lock
succeeded will address this issue:

    test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
    git worktree add --detach locked master &&
    git worktree add --detach unlocked master &&
    git worktree lock locked &&
    test_when_finished "git worktree unlock locked" &&
    ...

Same comment applies to other new tests added by this patch which lock
worktrees.

> @@ -71,6 +73,96 @@ test_expect_success '"list" all worktrees with locked annotation' '
> +test_expect_success '"list" all worktrees with prunable consistent with "prune"' '
> +       test_when_finished "rm -rf prunable out && git worktree prune" &&
> +       git worktree add --detach prunable &&
> +       rm -rf prunable &&
> +       git worktree list >out &&
> +       grep "/prunable  *[0-9a-f].* prunable$" out &&
> +       git worktree prune --verbose >out &&
> +       test_i18ngrep "^Removing worktrees/prunable" out
> +'

To be trustworthy, doesn't this test also need to have an unprunable
worktree, and test that `git worktree list` doesn't annotate it as
"prunable" _and_ that `git worktree prune` didn't prune it? Otherwise,
we really don't know that the two commands agree about what is and is
not prunable -- we only know they agree that this particular worktree
was prunable.

> +test_expect_success '"list" all worktrees --porcelain with newline escaped locked reason' '
> +       test_when_finished "rm -rf locked_lf locked_crlf reason_lf reason_crlf out actual expect reason &&
> +               git worktree unlock locked_lf &&
> +               git worktree unlock locked_crlf &&
> +               git worktree prune" &&

Nit: It's not a big deal, but we don't normally bother cleaning up
every junk file in tests, such as `out`, `actual`, `expect` if those
files aren't going to be a problem for subsequent tests. We are
explicitly cleaning up the worktrees in these tests because this
script is all about testing worktree behavior, and some random
leftover worktree could be a problem for other tests. I don't care
strongly one way or the other, but I worry a tiny bit that the list of
files being cleaned up could become outdated as changes are made to
the tests later...

> +test_expect_success '"list" all worktrees --porcelain with prunable' '
> +       test_when_finished "rm -rf prunable list out && git worktree prune" &&
> +       git worktree add --detach prunable &&
> +       rm -rf prunable &&
> +       git worktree list --porcelain >out &&
> +       test_i18ngrep "^prunable gitdir file points to non-existent location$" out
> +'

... for instance, the file `list` being cleaned up in this test is not
even created by this test.

> +
> +test_expect_success '"list" all worktrees --verbose and --porcelain mutually exclusive' '
> +       test_must_fail git worktree list --verbose --porcelain
> +'

Nit: This test title could probably be shortened to:

    '"list' --verbose and --porcelain mutually exclusive' '

Finally, I haven't tried it myself, but I was wondering if it is
possible to make a test which shows both "locked" and "prunable"
annotations for the same worktree. Would that be possible by
specifying a particular value for `--expire`? If it's too much work,
don't worry about it.
