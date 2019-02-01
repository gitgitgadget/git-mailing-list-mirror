Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329FA1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 19:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfBATnF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 14:43:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39489 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfBATnE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 14:43:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so8946660qtj.6
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 11:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0x62izLpJuNcUMG5F2z9RVcX6dBRrvpYP+dYt0RutI=;
        b=sP3D/78B7gZv6uzvrB1EHEto9D+TQCNRPSG02YURYKglgHA3VJFqUBWLVHwH5Lwz2I
         d8Odbl1WwvE03k2e6fnsZPgXFdZrcX5w7RrfVjFn31OcLUwQYAE4nPRJC53HCpPb1wKF
         sfW+f6qI08alv/EqwIueZbttWLCtOvK+qUTSnkF/C/DSqYIvcMijMsk0XHwhkKg3Uf+D
         dATov+HQyMqzJx3v/pUgyzQWWsOctne22YjSqWgc1bISZbv8C/zuNhf5P44wAUbNRbXp
         K3fDIxEVCw3pwSyXiacNGIIQajVeARtUK+mAjx/rsMWLNXFKS97U9HZejJ2IhF0IE5Uv
         YwpA==
X-Gm-Message-State: AJcUukfNqNMxiseGl4kqb1kgUzBgHE9Ht/clhA0eVOU+DDFKcqgNqyEm
        w3pe1AAJ3kOb+R8n7wFRnxyg8nXr4TXfoTiyny4=
X-Google-Smtp-Source: ALg8bN7hY6DthmTHnrSiGP/OPcrkOHjnoo3OlPj2d0fZybsXqpjTdOkmczqzjiMfbN5qHz/5uB2lqVllXhtGclPDMsA=
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr39282111qtx.352.1549050183841;
 Fri, 01 Feb 2019 11:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20190130114736.30357-1-worldhello.net@gmail.com> <20190201162152.31136-2-worldhello.net@gmail.com>
In-Reply-To: <20190201162152.31136-2-worldhello.net@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 14:42:53 -0500
Message-ID: <CAPig+cRX=ttHWe1C6m1u9-02oT-TpBtHWb48N=-wX4jSYaFuew@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] t5323: test cases for git-pack-redundant
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 11:22 AM Jiang Xin <worldhello.net@gmail.com> wrote:
> Add test cases for git pack-redundant to validate new algorithm for git
> pack-redundant.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> @@ -0,0 +1,510 @@
> +# Note: DO NOT run it in a subshell, otherwise the variables will not be set

Which variables won't be set? It's not clear what this restriction is about.

> +# Usage: create_commits_in <repo> A B C ...
> +create_commits_in () {
> +       repo="$1" &&
> +       parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null) || parent=

Broken &&-chain. Instead, perhaps:

    if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)
    then
        parent=
    fi &&

or something simpler.

> +       T=$(git -C "$repo" write-tree) &&
> +       shift &&
> +       while test $# -gt 0
> +       do
> +               name=$1 &&
> +               test_tick &&
> +               if test -z "$parent"
> +               then
> +                       oid=$(echo $name | git -C "$repo" commit-tree $T)
> +               else
> +                       oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
> +               fi &&
> +               eval $name=$oid &&
> +               parent=$oid &&
> +               shift ||
> +               return 1
> +       done

Broken &&-chain. Use:

    done &&

> +       git -C "$repo" update-ref refs/heads/master $oid
> +}
> +
> +# Note: DO NOT run it in a subshell, otherwise the variables will not be set
> +create_pack_1 () {
> +       P1=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF

Which variables? Note that you can capture output of a subshell into a
variable, if necessary.
