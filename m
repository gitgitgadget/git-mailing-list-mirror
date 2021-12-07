Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A0C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 22:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhLGWR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:17:58 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:41853 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhLGWR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 17:17:58 -0500
Received: by mail-pg1-f178.google.com with SMTP id k4so311349pgb.8
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 14:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihu+cloOoPhJCa71MP78S8c8n0JGu2Awj0ZDwlcsXxs=;
        b=jMV1W7rtCLyWNrwCE+bUauPCVTZKkSX2Mh1MTM8ABrdVPpXj/FUZsGIgwTH+Ev7GZY
         1lKwf3oyfVMvADvaydis9zCUBcEdQiXsMYok6wHmaKtbtz7CQTF29rGjphGp8WZ0mppP
         TPNnVTYjmywe7uuttAlBUkZbzmwDbYHFMBmVNFU554/af5xn44EpYWwIj+Uixh28l3eZ
         80gDMWCslS5durG8aLX8mmuMtITNr2snNXzz6acb2pjId4D0NIqDhjiHAUG/lU+hWEHd
         31DidJw3UCHDUU0JVbOz2YPrs06hve+6eP8OaZHv7Wj0X0XLonKdVz2O773v8sxJD0r4
         h8aQ==
X-Gm-Message-State: AOAM531Uu37ZIe7kSePiBF6IEsVT005pgdQt4ywNd7AXCeeaXtWCxXjK
        hw2Rvk4Y6A0FVp1nji+VrpzuFxGqo2dN2fzI2KttVOkwaBHHSA==
X-Google-Smtp-Source: ABdhPJzM64Sf+7cHU0zKyuyS+F3g8GdHfqGMgmPbqVjzDd/6Aw2uL/FrSm/1tMOjGJEILGVSIV1NJbmT+IDSf0/M4kc=
X-Received: by 2002:a63:8048:: with SMTP id j69mr26136260pgd.139.1638915267019;
 Tue, 07 Dec 2021 14:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
 <20211207182300.4361-1-chakrabortyabhradeep79@gmail.com> <20211207182300.4361-2-chakrabortyabhradeep79@gmail.com>
In-Reply-To: <20211207182300.4361-2-chakrabortyabhradeep79@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Dec 2021 17:14:15 -0500
Message-ID: <CAPig+cRxU=pT-qCp-xpHcoae45oxz1d-eRh+QF-SJFM3B-6KyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] push: make '-u' have default arguments
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 4:11 PM Abhradeep Chakraborty
<chakrabortyabhradeep79@gmail.com> wrote:
> [...]
> Teach "git push -u" not to require repository and refspec.  When
> the user do not give what repository to push to, or which
> branch(es) to push, behave as if the default remote repository
> and a refspec (depending on the "push.default" configuration)
> are given.
> [...]
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

This is not a proper review... just some superficial comments from
scanning my eye over the patch...

> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> @@ -60,6 +60,75 @@ test_expect_success 'push -u :topic_2' '
> +default_u_setup() {
> +       git checkout main
> +       remote=$(git config --get branch.main.remote)
> +       if [ ! -z "$remote" ]; then
> +               git branch --unset-upstream
> +       fi
> +       git config push.default $1
> +       git config remote.pushDefault upstream
> +}

A few issues...

* since callers of this function incorporate it into their &&-chains,
the body of the function itself should probably also have an intact
&&-chain

* use `test` rather than `[`

* `then` goes on its own line

* probably want to use test_config() here rather than raw `git config`

* `! -z` can be written more simply as `-n`

Taking the above into account, gives:

    default_u_setup() {
        git checkout main &&
        remote=$(git config --default '' --get branch.main.remote) &&
        if test -n "$remote"
        then
            git branch --unset-upstream
        fi &&
        test_config push.default $1 &&
        test_config remote.pushDefault upstream
    }

The `--default` ensures that `git config` will exit with a success
code which is important now that it's part of the &&-chain.
Alternatively, you could skip the dance of checking for
`branch.main.remote` and just call `git branch --unset-upstream`
unconditionally, but wrap it with test_might_fail() so it can be part
of the &&-chain without worrying about whether that command succeeds
or fails:

    default_u_setup() {
        git checkout main &&
        test_might_fail git branch --unset-upstream &&
        test_config push.default $1 &&
        test_config remote.pushDefault upstream
    }

> +test_expect_success 'push -u with push.default=simple' '
> +       default_u_setup simple &&
> +       git push -u &&
> +       check_config main upstream refs/heads/main &&
> +       git push -u upstream main:other &&
> +       git push -u &&
> +       check_config main upstream refs/heads/main
> +'
> +
> +test_expect_success 'push -u with push.default=current' '
> +       default_u_setup current &&
> +       git push -u &&
> +       check_config main upstream refs/heads/main &&
> +       git push -u upstream main:other &&
> +       git push -u &&
> +       check_config main upstream refs/heads/main
> +'
> +
> +test_expect_success 'push -u with push.default=upstream' '
> +       default_u_setup upstream &&
> +       git push -u &&
> +       check_config main upstream refs/heads/main &&
> +       git push -u upstream main:other &&
> +       git push -u &&
> +       check_config main upstream refs/heads/main
> +'

When a number of tests have nearly identical bodies like this, it is
sometimes clearer and more convenient to turn them into a for-loop
like this:

    for i in simple current upstream
    do
        test_expect_success "push -u with push.default=$i" '
            default_u_setup $i &&
            git push -u &&
            check_config main upstream refs/heads/main &&
            git push -u upstream main:other &&
            git push -u &&
            check_config main upstream refs/heads/main
        '
    done

> +check_empty_config() {
> +       test_expect_code 1 git config "branch.$1.remote"
> +       test_expect_code 1 git config "branch.$1.merge"
> +}

As above, because calls to this function are part of the &&-chain in
test bodies, it is important for the &&-chain to be intact in the
function too. It's especially important in this case since this
function is actually checking for specific conditions. As it's
currently written -- with a broken &&-chain -- if the first
test_expect_code() fails, we'll never know about it since that exit
code gets lost; only the exit code from the second test_expect_code()
has any bearing on the overall result of the test.

> +test_expect_success 'progress messagesdo not go to non-tty (default -u)' '

s/messagesdo/messages do/

> +       ensure_fresh_upstream &&
> +
> +       # skip progress messages, since stderr is non-tty
> +       git push -u >out 2>err &&
> +       test_i18ngrep ! "Writing objects" err
> +'

The captured stdout in `out` doesn't seem to be used, so it's probably
better to drop that redirection.

> +test_expect_success 'progress messages go to non-tty with default -u (forced)' '
> +       ensure_fresh_upstream &&
> +
> +       # force progress messages to stderr, even though it is non-tty
> +       git push -u --progress >out 2>err &&
> +       test_i18ngrep "Writing objects" err
> +'

Ditto. And repeat for the remaining tests.
