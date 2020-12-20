Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96341C4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 02:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6169423AC1
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 02:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgLTC63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 21:58:29 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:37914 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgLTC62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 21:58:28 -0500
Received: by mail-ej1-f47.google.com with SMTP id 6so8824357ejz.5
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 18:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Hro4p4gsoNoQ09Xc2MrW2hPhhhriVa/TSSomaSFRYg=;
        b=i8KQfJSM7b1gF7Y6UH7wJ9l+VVKkckWRZ0vU06ilGE2AN7j/EzkYEK3Gy9CAbFrR3D
         XRAynzajuxSAAMvoevYGQ291hdyRFmnqT0M52QP6Y7y0RFaLErqcd9JNB1WauKzKXe33
         5DGijzdkLuFFacMZEs1SWl7T04g3AKQYbX1im005T8RiIdXq0Xx5zrFOjqYbPSZlcJUJ
         UNdbeNsp2cZ+05+au/hqtBQuqwvK3pzMqGao9nkzDieDoyq+orcx3QrZN/hyGpfXPj/h
         F0DOrkmpcu+NcTWeyxXIIKZL2RJhUzft8+NosiGL567tYQAkwPVlja8r4Y/Iv934peW5
         afuQ==
X-Gm-Message-State: AOAM533RnUCogxcA69iFIb/x0ZOM3kD032i8uMz5gGTlS1LxDTgKTNG1
        SvDJ1P7/pODe5x3lRjLUYFbnff9mca8FEFLdw7SycBek7Bk=
X-Google-Smtp-Source: ABdhPJybn4bvf2rhG6IB5KQkrUtmk63T7ia9ME4vk6h/ChTFoQretlB5f8oAX1m7/n28zPcqLrb820YJ5dHoB8qbsMI=
X-Received: by 2002:a17:906:6b88:: with SMTP id l8mr10379687ejr.482.1608433066336;
 Sat, 19 Dec 2020 18:57:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.git.1608398598893.gitgitgadget@gmail.com>
 <pull.820.v2.git.1608415117.gitgitgadget@gmail.com> <e42200b644adab3ad78bf23e0258466287dbae70.1608415117.git.gitgitgadget@gmail.com>
In-Reply-To: <e42200b644adab3ad78bf23e0258466287dbae70.1608415117.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Dec 2020 21:57:35 -0500
Message-ID: <CAPig+cTBn6fPgkjaf=fYXi4XrHqc5Kf-ZJiMhxvdCDsMBuLTDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] negative-refspec: fix segfault on : refspec
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 5:00 PM Nipunn Koorapati via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The logic added to check for negative pathspec match by c0192df630
> (refspec: add support for negative refspecs, 2020-09-30) looks at
> refspec->src assuming it is never NULL, however when
> remote.origin.push is set to ":", then refspec->src is NULL,
> causing a segfault within strcmp
>
> Added testing for this case in fetch-negative-refspec

A couple minor comments below...

> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
> diff --git a/remote.c b/remote.c
> @@ -751,9 +751,13 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
> +               } else if (refspec->matching) {
> +                       /* For the special matching refspec, any query should match */
> +                       string_list_append(&reversed, needle);
> +               } else if (refspec->src == NULL) {
> +                       BUG("refspec->src should not be null here");

I realize that you copied Junio's example, but style on this project
is to write this as:

    } else if (!refspec->src) {
        ...

> diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> @@ -186,4 +186,19 @@ test_expect_success "fetch --prune with negative refspec" '
> +test_expect_success "push with matching ':' refspec" '
> +       (
> +               cd two &&
> +               git config remote.one.push : &&
> +               # Fails w/ tip behind counterpart - but should not segfault
> +               test_must_fail git push one master &&
> +
> +               git config remote.one.push +: &&
> +               # Fails w/ tip behind counterpart - but should not segfault
> +               test_must_fail git push one master &&
> +
> +               git config --unset remote.one.push
> +       )
> +'

If anything in this test fails prior to the final `git config
--unset`, then that cleanup command won't be executed, which might
negatively impact tests which follow. To ensure cleanup whether the
test succeeds or fails, use test_config(). Unfortunately,
test_config() has the limitation that it can't be used in subshells,
so you may have to restructure the test a bit, perhaps like this:

    test_config remote.one.push : &&
    (
        cd two &&
        test_must_fail git push one master &&

        git config remote.one.push +: &&
        test_must_fail git push one master
    )

Driving the test with a for-loop and taking advantage of -C to avoid
the subshell is also an option:

    for v in : +:
    do
        test_config -C two remote.one.push $v &&
        test_must_fail git -C two push one master || return 1
    done
