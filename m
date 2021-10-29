Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC3C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3952661075
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhJ2Ss5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:48:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58552 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhJ2SsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:48:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFB87FB877;
        Fri, 29 Oct 2021 14:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Rc5qSXK9aDAPkZ9/1+No0YNUWAePjA1iEVRDg
        lIHUk=; b=eK7+6L27DgnQ52z5wwZeF8rHgFM2VDUye8vQ74rRL1TTGGqnLIjKRJ
        Xjb8HoAoATGs3+2zsrZCx3RnPDNiyDLNKU9wa9KuyNG+YZfoL/MQtLjQBQ1Jskwj
        Xt3RBbi8XQN/t8iOw8OizP1dEgRNPYBhJFSx14K3ssqrMLaelCxqU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D76FCFB876;
        Fri, 29 Oct 2021 14:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BE8FFB875;
        Fri, 29 Oct 2021 14:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 2/4] sparse-index: avoid unnecessary cache tree clearing
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
        <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
        <91351ac4bded2c19264cd2009e90ee71fcf67b81.1635515487.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 11:45:52 -0700
In-Reply-To: <91351ac4bded2c19264cd2009e90ee71fcf67b81.1635515487.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 29 Oct 2021 13:51:24
        +0000")
Message-ID: <xmqqfssjllen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71B1AA32-38E8-11EC-886E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> When converting a full index to sparse, clear and recreate the cache tree
> only if the cache tree is not fully valid. The convert_to_sparse operation
> should exit silently if a cache tree update cannot be successfully completed
> (e.g., due to a conflicted entry state). However, because this failure
> scenario only occurs when at least a portion of the cache tree is invalid,
> we can save ourselves the cost of clearing and recreating the cache tree by
> skipping the check when the cache tree is fully valid.

I see in cache-tree.c::update_one() this snippet of code.

	/*
	 * If the first entry of this region is a sparse directory
	 * entry corresponding exactly to 'base', then this cache_tree
	 * struct is a "leaf" in the data structure, pointing to the
	 * tree OID specified in the entry.
	 */
	if (entries > 0) {
		const struct cache_entry *ce = cache[0];

		if (S_ISSPARSEDIR(ce->ce_mode) &&
		    ce->ce_namelen == baselen &&
		    !strncmp(ce->name, base, baselen)) {
			it->entry_count = 1;
			oidcpy(&it->oid, &ce->oid);
			return 1;
		}
	}

Sorry for not noticing it earlier, but does this mean that the
content of a cache-tree changes shape when sparse-ness of the index
changes?  Is a cache-tree that knows about all of the
subdirectories, even the ones that are descendants of a directory
that is represented as a tree-ish entry in the main index array,
still valid in a sparse index?

If not, then I do not think of a quick and sure way to ensure that
the cache-tree is valid when the sparse-ness changes.

The earlier suggestion was based on my assumption that even when the
main index array becomes sparse, the cache tree is still populated
and valid, so that after writing a tree and writing an on-disk index,
and then reading the on-disk index back (possibly in another process),
would not have to incur the recomputation cost of the full tree when
the reading codepath needs to flip the sparseness.

But the above code snippet makes me worried a lot.  A cache-tree
that used to be valid when the corresponding in-core index array was
not sparse will become invalid immediately when we decide to make it
sparse, right?
