Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11718C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B0861AD1
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355245AbhJAVOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:14:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60617 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJAVOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:14:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4844315369F;
        Fri,  1 Oct 2021 17:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kob0bh6uAl6Ao0BqnEp7ooPQOLrnF7on5dg7WW
        gbDIY=; b=LQnmHj46EzqaMLhvYIFeD28Zgai+AwC+l3ID+rCti/nFqAFWkrN5Bt
        PU4zXh6TIA5zxHnqE97hV5QNNwN+oKeNZiXw/bqIJb+aaAeHpWhO3lkjnI0yHKDP
        99NkWi/caPDpz0ThZiK06NySklQDdIUsFfmHEH+nKp1/CuqoDTqW0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 429D715369E;
        Fri,  1 Oct 2021 17:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C83CB15369C;
        Fri,  1 Oct 2021 17:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 09/11] rebase --apply: fix reflog
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <cdb0de221d56d7087146a43a393cffd66c06a5e8.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 14:12:58 -0700
In-Reply-To: <cdb0de221d56d7087146a43a393cffd66c06a5e8.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:05:00
        +0000")
Message-ID: <xmqq4ka05u05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B2C2460-22FC-11EC-A80F-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> move_to_original_branch() passes the message intended for the branch
> reflog as `orig_head_msg`. Fix this by adding a `branch_msg` member to
> struct reset_head_opts and add a regression test.
> ...
> The "merge" backend already has tests that check both the branch and
> HEAD reflogs.

OK.  This sounds like a good idea.

> +test_expect_success 'rebase --apply reflog' '
> +	git checkout -b reflog-apply start &&
> +	old_head_reflog="$(git log -g --format=%gs -1 HEAD)" &&
> +
> +	git rebase --apply Y &&
> +
> +	git log -g --format=%gs -4 HEAD >actual &&
> +	cat >expect <<-EOF &&
> +	rebase finished: returning to refs/heads/reflog-apply
> +	rebase: Z
> +	rebase: checkout Y
> +	$old_head_reflog
> +	EOF
> +	test_cmp expect actual &&
> +
> +	git log -g --format=%gs -2 reflog-apply >actual &&
> +	cat >expect <<-EOF &&
> +	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
> +	branch: Created from start
> +	EOF
> +	test_cmp expect actual
> +'

Thanks.
