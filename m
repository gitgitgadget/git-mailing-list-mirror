Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F616C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFCC60F6C
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhGZVb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:31:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52612 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhGZVbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 17:31:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CB27DE6D5;
        Mon, 26 Jul 2021 18:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2hj0y2yiS+KApbrNAttNMpSGf+mJW5QYbtXKKa
        UZf8Y=; b=GzgBDcw6+h8cTcq52pBLAiaGuH/gDRogLTvRL50oH/8D8H1dw09OqT
        YYqbvEjzogwAoLIm8Y2I9kE7aRuG1Ev0vNKeCydV4IGG0VqUGwu8fh874ZuAbms3
        GCMX945STJgbOFNpc+BdVaPFfT+ub3EWdft4Bzz1sNVivHy/oGzQU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 801DDDE6D4;
        Mon, 26 Jul 2021 18:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE189DE6D3;
        Mon, 26 Jul 2021 18:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: run "apt-get update" before "apt-get install"
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
        <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
        <YP72o/1Yg02BcDXw@coredump.intra.peff.net>
Date:   Mon, 26 Jul 2021 15:12:22 -0700
In-Reply-To: <YP72o/1Yg02BcDXw@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 26 Jul 2021 13:53:39 -0400")
Message-ID: <xmqqczr4hghl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D39EE56-EE5E-11EB-A57C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 14, 2021 at 11:50:33AM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> +    - name: Install other dependencies
>> +      run: |
>> +        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
>
> My CI runs based on 'next' started failing today. I think we'd want this
> on top (of js/ci-make-sparse):

Makes sense.

> -- >8 --
> Subject: [PATCH] ci: run "apt-get update" before "apt-get install"
>
> The "sparse" workflow runs "apt-get install" to pick up a few necessary
> packages. But it needs to run "apt-get update" first, or it risks trying
> to download an old package version that no longer exists. And in fact
> this happens now, with output like:
>
>   2021-07-26T17:40:51.2551880Z E: Failed to fetch http://security.ubuntu.com/ubuntu/pool/main/c/curl/libcurl4-openssl-dev_7.68.0-1ubuntu2.5_amd64.deb  404  Not Found [IP: 52.147.219.192 80]
>   2021-07-26T17:40:51.2554304Z E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
>
> Our other ci jobs don't suffer from this; they rely on scripts in ci/,
> and ci/install-dependencies does the appropriate "apt-get update".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I guess this package setup could also be moved into ci/install-dependencies.sh,
> but I don't think it really buys anything (the "apt-get update" line
> would not even be shared, because the outermost layer is a big switch
> statement on the jobname). OTOH, it looks like other one-off jobs are in
> there (e.g., StaticAnalysis).
>
> Anyway, this is the minimal fixup.
>
>  .github/workflows/main.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 1b5c039207..01878884ae 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -368,6 +368,7 @@ jobs:
>        run: sudo dpkg -i sparse-20.04/sparse_*.deb
>      - name: Install other dependencies
>        run: |
> +        sudo apt-get update -q &&
>          sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
>      - uses: actions/checkout@v2
>      - run: make sparse
