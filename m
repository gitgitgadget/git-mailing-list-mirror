Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B26C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8040D60FE3
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhJ1Vfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 17:35:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64365 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhJ1VfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 17:35:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CC39F98A6;
        Thu, 28 Oct 2021 17:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7UJWcQkwJTZslOXWMIuTCSWOoA2sL4Td6Gra7s
        LxJxY=; b=wtRx49nwKvLHq3IS/gdq0EchFDrtj9X4Gc+WjZnhvlrJhHGDFHlptj
        vSz5nu1pS55mRnXp9wqpFEtkPxieJtrCMCsmg4y1noAB3oYOH6SA6uWvmW/fO+qC
        qeu3uSnAoNNeU1RqM6ZBHG8vJMPyZe8mICsNclZXke0qwOLymT0QM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93339F98A5;
        Thu, 28 Oct 2021 17:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09116F98A3;
        Thu, 28 Oct 2021 17:32:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 01/15] diff --color-moved: add perf tests
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <8fc8914a37b3c343cd92bb0255088f7b000ff7f7.1635336262.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 14:32:55 -0700
In-Reply-To: <8fc8914a37b3c343cd92bb0255088f7b000ff7f7.1635336262.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 27 Oct 2021 12:04:08
        +0000")
Message-ID: <xmqqsfwkq1h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DEC5BCC-3836-11EC-9E78-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add some tests so we can monitor changes to the performance of the
> move detection code. The tests record the performance of a single
> large diff and a sequence of smaller diffs.

"A single large diff" meaning...?

> +if ! git rev-parse --verify v2.29.0^{commit} >/dev/null
> +then
> +	skip_all='skipping because tag v2.29.0 was not found'
> +	test_done
> +fi

Hmph.  So this is designed only to be run in a clone of git.git with
that tag (and a bit of history, at least to v2.28.0 and 1000 commits)?

I am asking primarily because this seems to be the first instance of
a test that hardcodes the dependency on our history, instead of
allowing the tester to use their favourite history by using the
GIT_PERF_LARGE_REPO and GIT_PERF_REPO environment variables.

The intention of the tests themselves looks quite clear.  Thanks.

> +GIT_PAGER_IN_USE=1
> +test_export GIT_PAGER_IN_USE
> +
> +test_perf 'diff --no-color-moved --no-color-moved-ws large change' '
> +	git diff --no-color-moved --no-color-moved-ws v2.28.0 v2.29.0
> +'
> +
> +test_perf 'diff --color-moved --no-color-moved-ws large change' '
> +	git diff --color-moved=zebra --no-color-moved-ws v2.28.0 v2.29.0
> +'
> +
> +test_perf 'diff --color-moved-ws=allow-indentation-change large change' '
> +	git diff --color-moved=zebra --color-moved-ws=allow-indentation-change \
> +		v2.28.0 v2.29.0
> +'
> +
> +test_perf 'log --no-color-moved --no-color-moved-ws' '
> +	git log --no-color-moved --no-color-moved-ws --no-merges --patch \
> +		-n1000 v2.29.0
> +'
> +
> +test_perf 'log --color-moved --no-color-moved-ws' '
> +	git log --color-moved=zebra --no-color-moved-ws --no-merges --patch \
> +		-n1000 v2.29.0
> +'
> +
> +test_perf 'log --color-moved-ws=allow-indentation-change' '
> +	git log --color-moved=zebra --color-moved-ws=allow-indentation-change \
> +		--no-merges --patch -n1000 v2.29.0
> +'
> +
> +test_done
