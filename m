Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B9AC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 23:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiFIXr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 19:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiFIXr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 19:47:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02635ABA
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 16:47:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73F471AB9AC;
        Thu,  9 Jun 2022 19:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=pqRRvoQiWzYXQgGKnQ8iGcA6FvWwWAk5Nqg9j6Uc4Jc=; b=CBFi
        kZ5Ui5leskZp9AShcLMHzquXRxN96AoZfYeyWwp0VQ6k4fD0lvBYTmXivN9EilsJ
        VpR8em2ZQHRZ4tzR77wVi1ltOaynP0RWlVdYwP/isFQBaNuSTCDBKKEHOPjxIn6f
        u5XcIgO/vHYv4dABTC6EMA1rThvEVfIc5yBTMJk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B9571AB9AB;
        Thu,  9 Jun 2022 19:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E74AB1AB9AA;
        Thu,  9 Jun 2022 19:47:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/4] branch: add branch_checked_out() helper
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 16:47:48 -0700
Message-ID: <xmqq8rq5iel7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9233E61A-E84E-11EC-848D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void prepare_checked_out_branches(void)
> +{
> +	int i = 0;
> +	struct worktree **worktrees;
> +
> +	if (initialized_checked_out_branches)
> +		return;
> +	initialized_checked_out_branches = 1;
> +
> +	worktrees = get_worktrees();
> +
> +	while (worktrees[i]) {
> +		struct worktree *wt = worktrees[i++];
> +
> +		if (wt->is_bare)
> +			continue;
> +
> +		if (wt->head_ref)
> +			strmap_put(&current_checked_out_branches,
> +				   wt->head_ref,
> +				   xstrdup(wt->path));
> +	}

If two worktrees have by accident or by bug checked out the same
branch, this strmap_put() will leak, as it overwrites the path to
the worktree we found earlier with the branch checked out with the
path to the worktree we just discovered with the same branch checked
out.  We could easily work it around by immediately freeing what
comes back from strmap_put(), presumably.  The resulting code

		if (wt->head_ref)
			free(strmap_put(...));

may look strange, though, especially because we will see more
instances of strmap_put() in this loop in later steps.
