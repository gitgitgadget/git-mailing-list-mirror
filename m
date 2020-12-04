Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C6C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912A622B4E
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgLDSHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:07:44 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:36665 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDSHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:07:43 -0500
Received: by mail-ej1-f52.google.com with SMTP id lt17so9999731ejb.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 10:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuN0//StOEdrBXYOzwayr0QPoXnSYhQZkml4gI0gJgA=;
        b=fTbcljx50IVik4/b+8YnvEM+gpy3ZrR9DPvU8jj9a5kSu62PYFfPBpgi25eUdXBUC3
         2NRJNyUeaDAKatwu+STWbZND6mlG9xp+J+EkM82WkuT0BqiZ+bZT9wWMQal4iBk/Slg0
         X2U70YNEveOfMb2JPK4styQ/E8MKJ8h6fQz6l3OibrltGcEb0FCSAgXWlBw9HDrFgu4z
         2aGuV6QN2HH3T3GhtQ1SZm/rK/vnqV3/y83A7ZkDjMCZz6n6vZ1lmLsm6tIdNphllO4G
         PwhJovPc+l3oPs+9Yb19aqPwehbxAjeRikqXWG96tJpvDQPb+9myWcWaYIMeqqTDse9u
         IbYw==
X-Gm-Message-State: AOAM530x4SnG+pO45Xy6dC4uGVJRMRBhT54VC3P6b/V6CyU+uf8zHvxh
        ZiYn2ybJEmidHh1FZBJ9ystuZQRWuZ31zei8iUNojRSPh48=
X-Google-Smtp-Source: ABdhPJwwIJrTlZ/71bnglyAwGqyNaRGLufl7pIRdrATNbtQd+ohceoRkY0OD2ezdMQ28auLA9KIAg2eAAP47xxjujPg=
X-Received: by 2002:a17:906:4944:: with SMTP id f4mr8442518ejt.231.1607105221187;
 Fri, 04 Dec 2020 10:07:01 -0800 (PST)
MIME-Version: 1.0
References: <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com> <1607095412-40109-1-git-send-email-peter.kaestle@nokia.com>
In-Reply-To: <1607095412-40109-1-git-send-email-peter.kaestle@nokia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Dec 2020 13:06:50 -0500
Message-ID: <CAPig+cR69HJefRMfH_5-dHOMVY-VmVgbqQuWV90ednDEjrnExw@mail.gmail.com>
Subject: Re: [PATCH] submodules: fix of regression on fetching of non-init subsub-repo
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 10:25 AM Peter Kaestle <peter.kaestle@nokia.com> wrote:
> [...]
> Furthermore a regression test case is added, which tests for recursive
> fetches on a superproject with uninitialized sub repositories.  This
> issue was leading to an infinite loop when doing a revert of a62387b.

Just a few small comments (nothing comprehensive) from a quick scan of
the patch...

Mostly they are just minor style issues, not necessarily worth a
re-roll, but there is one actionable item.

> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> ---
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> @@ -719,4 +719,98 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
> +add_commit_push () {
> +       dir="$1"
> +       msg="$2"
> +       shift 2

We typically recommend including these assignments in the &&-chain to
future-proof against someone later inserting code above them and not
realizing that that code is not part of the &&-chain, in which case if
the new code fails, the failure might go unnoticed.

> +       git -C "$dir" add "$@" &&
> +       git -C "$dir" commit -a -m "$msg" &&
> +       git -C "$dir" push
> +}
> +
> +compare_refs_in_dir () {
> +       fail= &&
> +       if test "x$1" = 'x!'
> +       then
> +               fail='!' &&
> +               shift
> +       fi &&
> +       git -C "$1" rev-parse --verify "$2" >expect &&
> +       git -C "$3" rev-parse --verify "$4" >actual &&
> +       eval $fail test_cmp expect actual
> +}

We have a test_cmp_rev() similar to this but it doesn't support -C as
some of our other test functions do. I briefly wondered if it would
make sense to extend it to understand -C, but even that wouldn't help
this case since compare_refs_in_dir() introduced here involves two
distinct directories. The need here is so special-purpose that it
likely would not make sense to upgrade test_cmp_rev() to accommodate
it. Okay.

> +test_expect_success 'setup nested submodule fetch test' '
> +       # does not depend on any previous test setups
> +
> +       for repo in outer middle inner
> +       do
> +               (
> +                       git init --bare $repo &&
> +                       git clone $repo ${repo}_content &&
> +                       echo "$repo" >"${repo}_content/file" &&
> +                       add_commit_push ${repo}_content "initial" file
> +               ) || return 1
> +       done &&

What is the purpose of the subshell here? Is it to ensure that commits
in each repo have identical timestamps? Or is it just for making the
&& and || expression more clear? If the latter, we normally don't
bother with the parentheses.

> +       git clone outer A &&
> +       git -C A submodule add "$pwd/middle" &&
> +       git -C A/middle/ submodule add "$pwd/inner" &&
> +       add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
> +       add_commit_push A/ "adding middle sub" .gitmodules middle &&
> +
> +       git clone outer B &&
> +       git -C B/ submodule update --init middle &&
> +
> +       compare_refs_in_dir A HEAD B HEAD &&
> +       compare_refs_in_dir A/middle HEAD B/middle HEAD &&
> +       test -f B/file &&
> +       test -f B/middle/file &&
> +       ! test -f B/middle/inner/file &&

These days we typically use test_path_exists() (or
test_path_is_file()) and test_path_is_missing() rather than bare
`test`.

> +test_expect_success 'setup recursive fetch with uninit submodule' '
> +       # does not depend on any previous test setups
> +
> +       git init main &&
> +       git init sub &&
> +
> +       touch sub/file &&

Unless the timestamp of the file is significant to the test, in which
case `touch` is used, we normally create empty files like this:

    >sub/file &&

> +test_expect_success 'recursive fetch with uninit submodule' '
> +       git -C main submodule deinit -f sub &&
> +       ! git -C main fetch --recurse-submodules |&
> +               grep -v -m1 "Fetching submodule sub$" &&

We want the test scripts to be portable, thus avoid Bashisms such as `|&`.

We also avoid placing a Git command upstream in a pipe since doing so
causes the exit code of the Git command to be lost. Instead, we would
normally send the Git output to a file and then send that file to
whatever would be downstream of the Git command in the pipe. So, a
mechanical rewrite of the above (without thinking too hard about it)
might be:

    git -C main fetch --recurse-submodules >out 2>&1 &&
    ! grep -v -m1 "Fetching submodule sub$" &&

> +       git -C main submodule status |
> +               sed -e "s/^-//" -e "s/ sub$//" >actual &&

Same comment about avoiding Git upstream in a pipe, so perhaps:

    git -C main submodule status >out &&
    sed -e "s/^-//" -e "s/ sub$//" out >actual &&

> +       test_cmp expect actual
> +'
