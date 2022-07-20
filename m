Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29901C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 17:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiGTRiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiGTRhu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 13:37:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD9F65D60
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 10:37:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D8271A456F;
        Wed, 20 Jul 2022 13:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SKCivFgZAWcAMdIDTFskLFCJu/kFGQa5jofVnu
        6c7xU=; b=QawYVTIEqWb3rVq0wr0TP+QpQczEILebrxOiQuw+0zcHf8hiuOUW3s
        zl33QmwySMamd1EVLKBXra/Fe/FGm/L5Ebmp2dabf0gmZ9jJ9EJVDfrq+NH1kTV2
        RHYOdKIC6h8m5l7xrJQI6k/IsAHb6V7x4JVunJw9xyGZPIQKcOEO0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D3551A456E;
        Wed, 20 Jul 2022 13:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0279D1A456B;
        Wed, 20 Jul 2022 13:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
        <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 10:37:40 -0700
In-Reply-To: <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Wed, 20 Jul 2022 16:36:22 +0000")
Message-ID: <xmqqbktj3ct7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A82E1502-0852-11ED-BBD8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

It's been quite many iterations, so I'll just comment on the range-diff.

>      -+			usage_msg_opt("--format cannot used with -s, -o, -k, -t"
>      ++			usage_msg_opt("--format cannot used with -s, -o, -k, -t, "
>       +				      "--resolve-undo, --deduplicate, --eol",
>       +				      ls_files_usage, builtin_ls_files_options);

Looks good.

>      @@ t/t3013-ls-files-format.sh (new)
>       +	printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
>       +	printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
>       +	printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
>      -+	ln -s o3.txt o4.txt &&
>      -+	git add "*.txt" &&
>      -+	git add --chmod +x o1.txt &&
>      -+	git update-index --add --cacheinfo 160000 $(git hash-object o1.txt) o5.txt &&
>      ++	git add . &&

We may want to be a bit more strict (like "o?.txt") but because we
know this is the first 'setup' step, let's let it pass.

>      ++	oid=$(git hash-object o1.txt) &&
>      ++	git update-index --add --cacheinfo 120000 $oid o4.txt &&
>      ++	git update-index --add --cacheinfo 160000 $oid o5.txt &&
>      ++	git update-index --add --cacheinfo 100755 $oid o6.txt &&

It is a bit inconvenient that --cacheinfo takes only fully-spelled
raw object name that we need to use $oid like this (otherwise we
would be able to write ":o1.txt" instead), but (1) it is not a fault
of this patch, and (2) update-index is a plumbing command meant for
scripts, so it is not too big a problem.

>       +	git commit -m base
>       +'
>       +
>       +test_expect_success 'git ls-files --format objectmode v.s. -s' '
>      -+	git ls-files -s | awk "{print \$1}" >expect &&
>      ++	git ls-files -s >files &&
>      ++	cut -d" " -f1 files >expect &&

Either "awk" or "cut" is fine and flipping between them is a bit
distracting.  Cutting the pipe into two is a good move.

But is this testing the right thing?

> +test_expect_success 'git ls-files --format objectmode v.s. -s' '
> +	git ls-files -s >files &&
> +	cut -d" " -f1 files >expect &&
> +	git ls-files --format="%(objectmode)" >actual &&
> +	test_cmp expect actual
> +'

It only looks at the first column of the "-s" output, and we are
implicitly assuming that the order of output does not change between
the "-s" output and "--format=<format>" output.  I wonder if it is
more useful and less error prone to come up with a format string
that 100% reproduces the "ls-files -s" output and compare the two,
e.g. 

	format="%(objectmode) %(objectname) %(stage)	%(path)" &&
	git ls-files -s >expect &&
	git ls-files --format="$format" >actual &&
	test_cmp expect actual

I do not know if the $format I wrote without looking at the doc is
correct, but you get the idea.

Thanks.


