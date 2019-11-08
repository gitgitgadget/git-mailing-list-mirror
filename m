Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17991F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbfKHUgj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:36:39 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40702 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbfKHUgi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:36:38 -0500
Received: by mail-wm1-f52.google.com with SMTP id f3so7509474wmc.5
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4W2gfGJy9mJKdpd7s21pQy8VGaytE6xK7iiGzSKvVx0=;
        b=dYZHplTMnpJuNKBUAj1GtXYgfcY3VpnUbsm/xCI8tgGX1SZ6wd6jotI6OM9EkKIoOM
         b9CqEBLGOPj6iW2vDlZDhueh7hxOzUgmxzjJ1HncokRRLvB1HSrKRlqFLHdKxDN4P4ez
         UaEjeuXjo7BcsOfmUm/yx+wN4sqK776KMHV1B0kemHssP5CUm2hRgjZxcH5JkD40jEuE
         Ns5Hx97fCFEirGHAmTI4z+Ed5hOaUC6eNgwUlEvHyAw1Ga64l5BFAOBKYMJviDZJyuu2
         Z1NMaN3RUazpHRt6yNswYOhtYYZZy19S0D79NbriaDQjyKAnPPTUoPLThvLSkvrmg1E9
         Ff7g==
X-Gm-Message-State: APjAAAWVWHEyZkP0IKZmNyIk4qbsLzLyugaGaani1qEDspXX6MFDygZJ
        zUQC+bC/qlumf6YoYtO8e+C276Lh5LJeFT97Dik=
X-Google-Smtp-Source: APXvYqzFe2t0XplS7d9hr5WR+q4dzuJxmIi8Cx4XNwd/anWD54bNbbRbunz8ZlsLbkXSO6TLyhGXvF1zOpZN6FUe0Hg=
X-Received: by 2002:a1c:3843:: with SMTP id f64mr9417884wma.129.1573245396144;
 Fri, 08 Nov 2019 12:36:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572897736.git.liu.denton@gmail.com> <cover.1573241590.git.liu.denton@gmail.com>
 <b5950823ce90dd2476f002ed0370b7e0099a4d85.1573241590.git.liu.denton@gmail.com>
In-Reply-To: <b5950823ce90dd2476f002ed0370b7e0099a4d85.1573241590.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Nov 2019 15:36:25 -0500
Message-ID: <CAPig+cQDMSwP5-D-=LgjBPH2kJK16Fv4c619Pg6OTU95CQ9sgw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] t4205: cover `git log --reflog -z` blindspot
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 8, 2019 at 3:08 PM Denton Liu <liu.denton@gmail.com> wrote:
> The test suite does not include any tests where `--reflog` and `-z` are
> used together in `git log`. Cover this blindspot. Note that the
> `--pretty=oneline` case is written separately because it follows a
> slightly different codepath.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> @@ -134,6 +134,41 @@ test_expect_failure C_LOCALE_OUTPUT 'NUL termination with --stat' '
> +emit_nul () {
> +       echo | tr '\n' '\000'
> +}

A simple:

    printf "\0"

would be simpler, and I don't think you even need to introduce a shell
function to encapsulate it, as it's quite clear at a glance what it
does.

> +for p in short medium full fuller email raw
> +do
> +       test_expect_success "NUL termination with --reflog --pretty=$p" '
> +               >expect &&

You can drop this line...

> +               revs="$(git rev-list --reflog)" &&
> +               for r in $revs
> +               do
> +                       git show -s "$r" --pretty='$p' >>expect || return 1
> +                       emit_nul >>expect

...and simplify all this capturing into 'expect'...

> +               done &&

... by just redirecting the output of the for-loop itself:

    for r in $(git rev-list --reflog)
    do
        git show -s --pretty="$p" "$r" &&
        printf "\0" || return 1
    done >expect &&

For completeness, the above example also drops the unnecessary 'revs'
variable, uses double quotes rather than single when interpolating $p,
and makes the loop early-exit a bit more idiomatic.

> +               git log -z --reflog --pretty='$p' >actual &&
> +               emit_nul >>actual &&

Likewise, you can capture 'actual' in its entirety:

    {
        git log -z --reflog --pretty="$p" &&
        printf "\0"
    } >actual &&

> +               test_cmp expect actual
> +       '
> +done
> +
> +test_expect_success 'NUL termination with --reflog --pretty=oneline' '
> +       >expect &&
> +       revs="$(git rev-list --reflog)" &&
> +       for r in $revs
> +       do
> +               # trim trailing newline
> +               output="$(git show -s --pretty=oneline "$r")" || return 1
> +               printf "%s" "$output" >>expect
> +               emit_nul >>expect
> +       done &&

Replacing the newline with NUL could be done more simply and
idiomatically (with regard to other test scripts) by passing the
output of "git show" through the lf_to_nul() function from
test-lib-functions.sh. Something like this should do it:

    for r in $(git rev-list --reflog)
    do
        git show -s --pretty=oneline "$r" >raw &&
        cat raw | lf_to_nul || return 1
    done >expect &&

> +       git log -z --pretty=oneline --reflog >actual &&
> +       # no trailing NUL

To what is this comment referring?

> +       test_cmp expect actual
> +'
