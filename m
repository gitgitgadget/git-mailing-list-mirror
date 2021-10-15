Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50B8C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2F361184
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbhJOVzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 17:55:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJOVzv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 17:55:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD696D8E97;
        Fri, 15 Oct 2021 17:53:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9J/SrpCOO1bVmsujS73G74e3oM0cuUHqKViW89
        3YbfI=; b=kdEerr9Svrh+EJhx3IIkE0bya/8xgnBR48eH3zww8iAwlB2kuXcL/c
        XjkB7BDAmNFB1cVeO1IWddM5id20MqqddsW3ocNRTfQR4mN2038e/k+2b7IcUzyq
        4whO68zFrWSUQvD6RqsvxjvDubJ/O697GEgpgMY+Qd8To5eC5O8Do=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1C9DD8E96;
        Fri, 15 Oct 2021 17:53:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C901D8E95;
        Fri, 15 Oct 2021 17:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
Date:   Fri, 15 Oct 2021 14:53:41 -0700
In-Reply-To: <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 15 Oct 2021 19:54:57
        +0000")
Message-ID: <xmqqh7di3qfu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D3C8FB8-2E02-11EC-9DA1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Use the index.sparse config setting to expand or collapse the index when
> read. Previously, index.sparse would determine how the index would be
> written to disk, but would not enforce whether the index is read into memory
> as full or sparse. Now, the index is expanded when a sparse index is read
> with `index.sparse=false` and is collapsed to sparse when a full index is
> read with `index.sparse=true` (and the command does not require a full
> index).

Instead of calling both in-core index and on-disk index, perhaps use
"the in-core index" as appropriately in the above description and
the result would become much less ambigous.

My knee-jerk reaction was that it is of dubious value to spend
cycles to make the in-core index sparse after reading a non-sparse
index from the disk to give to the caller, but this hurts only the
commands that are not yet sparse-aware and call ensure_full_index()
as the first thing they do.  To them, we are wasting cycles to
shrink and expand for no good reason, and after they are done, the
final writeout would create a sparse on-disk index.

Besides, the on-disk index is expected to be sparse most of the time
when index.sparse is true, so it is hopefully a one-time waste that
corrects by itself.

For all commands that are sparse-aware, especially when asked to
perform their operation on the paths that are not hidden by a
tree-like index entry, it may or may not be a win, but the downside
would be much smaller.  The cost to shrink a full in-core index
before writing out as a sparse one should be comparable to the cost
to shrink a full in-core index just read from the disk before the
sparse-index-aware caller works on it and leaves a still mostly
sparse in-core index to be written out without much extra work to
re-shrink it to the disk.

> This makes the behavior of `index.sparse` more intuitive, as it now clearly
> enables/disables usage of a sparse index.

It is a minor thing, so I am willing to let it pass, but I am not
sure about this claim.  The write-out codepath ensures, independent
of this change, that a full on-disk index is corrected to become
sparse when the configuration is set to true, and a sparse on-disk
index is corrected to become full when the configuration is set to
false, no?

So the only "intuitive"-ness we may be gaining is that the codepaths
that are sparse-aware would work in their "sparse" (non-"sparse")
mode when index.sparse is set to true (false), respectively, no
matter how sparse (or not sparse) the on-disk index they work on is
initially.  That might help debuggability (assuming that converting
between the full and sparse forms are working correctly), but I am
not sure if that is something end users would even care about.

> -	if (istate->repo->settings.command_requires_full_index)
> +	if (!istate->repo->settings.sparse_index ||
> +	    istate->repo->settings.command_requires_full_index)
>  		ensure_full_index(istate);
> +	else if (!istate->sparse_index)
> +		convert_to_sparse(istate, 0);
>  
>  	return istate->cache_nr;

Quite straight-forward.  Looking good.

