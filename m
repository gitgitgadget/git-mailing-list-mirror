Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E30C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbhLMOQL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Dec 2021 09:16:11 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:43643 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhLMOQK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 09:16:10 -0500
Received: by mail-pj1-f49.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso13452567pjb.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 06:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WsHpxrKjfqrWnCXcbgqOiAYjtiHMsHPKwwgYSOfiebQ=;
        b=j26DipbNW5d7+OaGhHx8fkFgQCo1bt1f8BdKonVeL1Mwik6xzJ4xp3uma7FdxT2msB
         WW7DwfEzrcsIt+ukioeRNpwjqNALTVFGL3kfTi1mIyXXaKuiestwevLLeHhRC3eLi4nY
         y8RciyozER+YBoUqc/LjFtEEva5P7SLnTscLtiE1+wfxpYIIa7FSDpRXs7LctsfdW11X
         djH+4VwbAwtnmiW6oRT3Pv4MfjEb0kp8G4QJ1ZSlU6Zurfab8b4EOGZVA6qfyWAa/2AS
         XuGdyeYNuIw/0SKPniYu4hhts5S/ta8p5kUIdLe1VnDSMco8MYubGN7Ok1ZV5jE+08A9
         6k6A==
X-Gm-Message-State: AOAM533wgZVpSpGdF9WXt9zWvT3MRPrQkGC+81n7ixnK3CCBZaQzXPxt
        ni+JMQhFH+qZUz6QDm6Lefpahnua0ww97DAGuGw=
X-Google-Smtp-Source: ABdhPJyv5+1L0ISn0+q8vCXtq77esx8PQgu2ApVvp5CMWRa5yIC4ZnCQu4rcQKtmWCZASM91yXWs+SLjGJR4iMYgmhI=
X-Received: by 2002:a17:90b:3558:: with SMTP id lt24mr13514611pjb.150.1639404970220;
 Mon, 13 Dec 2021 06:16:10 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <patch-10.13-ca55471d134-20211212T201308Z-avarab@gmail.com>
In-Reply-To: <patch-10.13-ca55471d134-20211212T201308Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 09:15:59 -0500
Message-ID: <CAPig+cSkiFd27o8uACdX9ftg=N2XukqNSU_Tt+7rWT08JD7CAQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] test-lib-functions: add and use a "write_hook" wrapper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 12, 2021 at 4:24 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Add a "write_hook" wrapper for the common case of "write_script
> .git/hooks/<NAME>". This also accepts a "-C" option like
> "test_commit". Let's convert various trivial cases of "write_script"
> over to it.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -551,6 +551,32 @@ write_script () {
> +## Usage: write-hook pre-receive
> +## Usage: write-hook -C some-dir pre-receive
> +write_hook () {
> +       indir= &&
> +       while test $# != 0
> +       do

It's not clear whether the intention is to maintain the &&-chain in
this function...

> +               case "$1" in
> +               -C)
> +                       indir="$2"
> +                       shift
> +                       ;;

... or not care about it since it's broken here before `shift`...

> +               -*)
> +                       BUG "invalid write_hook: $1"
> +                       ;;
> +               *)
> +                       break
> +                       ;;
> +               esac &&
> +               shift
> +       done &&
> +       git_dir=$(git -C "$indir" rev-parse --absolute-git-dir) &&
> +       hook_dir="$git_dir/hooks" &&
> +       hook_file="$hook_dir/$1"
> +       write_script "$hook_file"

... and here before `write_script`.

> +}
