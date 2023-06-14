Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB155EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjFNQqY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 14 Jun 2023 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjFNQqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:46:19 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29000199
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:46:18 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-760929a1783so230495785a.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761177; x=1689353177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3G1Z6VQ0xf55JxuqlAoOn5VwMkFj+G4F1Y7yLtJVJY=;
        b=Ojo/tIBipDttli2UMUepZyCdCFdjCluKAdX7A1HDzGRlaJysJZbQ/y4+ph9f7mRkKv
         kABGYuxelsrptdoqL07Sv3HqI+Pl053NxoakKuRJgCs/mwGymKEsHzuazQe0AolM5oOM
         RVkxzdyyxz5b+thEwl557oMetypxJWL0rhZkXWrKHKkGu4Vsr86OURjLZFFCugvwC00w
         N4NYUV4KrIySsyd2ll31KiR/CHAdLtC10ri1QalQqZ9uENQdshKj/UZMHOmt6mOlBs9A
         181mSx8WGvWAX4tZmKoI2Sw+W+2IzeZgQyFm6I2S0OcURNqedHJSYNofEi2t0JmiV2LJ
         gmaw==
X-Gm-Message-State: AC+VfDwlOJt92E4WaYMeIJynrWPRZabfbS60rPx2/+9GZVcxjvrQddxE
        r1a/rEFeZd/wD6E+nnBRshBs3jYh3jl7RgtZnII=
X-Google-Smtp-Source: ACHHUZ6hgLNxBLL0DF2zRC4smhl/gliG33fn26JLN3DAg/+pxCXsVybtmfwucryM3X22tl6+y3Dg3EoUUtF4xjJS81g=
X-Received: by 2002:ad4:5aeb:0:b0:62b:4590:78d6 with SMTP id
 c11-20020ad45aeb000000b0062b459078d6mr19291685qvh.25.1686761177198; Wed, 14
 Jun 2023 09:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230614163127.3182986-2-sokcevic@google.com>
In-Reply-To: <20230614163127.3182986-2-sokcevic@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Jun 2023 12:46:06 -0400
Message-ID: <CAPig+cR9Zv87ZmKaYKX2Acu=0vun+HonyXKOWd8juMPfE7by2Q@mail.gmail.com>
Subject: Re: [PATCH v3] diff-lib: honor override_submodule_config flag bit
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2023 at 12:37 PM Josip Sokcevic <sokcevic@google.com> wrote:
> When `diff.ignoreSubmodules = all` is set and submodule commits are
> manually staged (e.g. via `git-update-index`), `git-commit` should
> record the commit  with updated submodules.
>
> `index_differs_from` is called from `prepare_to_commit` with flags set to
> `override_submodule_config = 1`. `index_differs_from` then merges the
> default diff flags and passed flags.
>
> When `diff.ignoreSubmodules` is set to "all", `flags` ends up having
> both `override_submodule_config` and `ignore_submodules` set to 1. This
> results in `git-commit` ignoring staged commits.
>
> This patch restores original `flags.ignore_submodule` if
> `flags.override_submodule_config` is set.
>
> Signed-off-by: Josip Sokcevic <sokcevic@google.com>

Looking much better. Just a minor (nitpicky) style comment...

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> @@ -1179,4 +1179,27 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
> +add_submodule_commit_and_validate () {
> +       HASH=$(git rev-parse HEAD) &&
> +       git update-index --add --cacheinfo 160000,$HASH,sub &&
> +       git commit -m "create submodule" &&
> +       echo "160000 commit $HASH       sub" > expect &&

Drop the space after the redirection operator:

    echo "160000 commit $HASH       sub" >expect &&

> +       git ls-tree HEAD -- sub >actual &&

This one correctly omits whitespace after the redirection operator.

> +       test_cmp expect actual
> +}
