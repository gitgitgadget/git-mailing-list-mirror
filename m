Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45748C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4A20671
	for <git@archiver.kernel.org>; Wed, 20 May 2020 15:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WkDR+TKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgETPRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 11:17:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62370 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgETPRt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 11:17:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD93D4339C;
        Wed, 20 May 2020 11:17:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2NSeattfoabu8vHvTd9GZbBRFlo=; b=WkDR+T
        KpKMVLWqV3A2BFUxXjo7uCMYa4jl9KBtB85+Xco5kapOblHJnYKTAvgCsyHWDQU4
        UNM/OSD42oYwctV7J9ys5U0xrVqAeJYQrg3KqcjT8OTsrZiBSS1m02lWARo5DzEK
        9iuH3L3mzseIF0aUk85zP2ABJSON0oOIMyf2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AVJDKPHThI2RGsIutrINtA4blHiCZziH
        45yu4vfVRW/54JHMl6F5iAQDIivpkq70jc0E/uQg3lKvthkykRNe6OrPDb6fbj6q
        KctT7ZqtodBfH8Fc//BjC/lbSJKfZZ/52bIU12zEpIduHjLzm1oxGlsj9nw/KOs9
        SvGehNyRUO0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACB324339B;
        Wed, 20 May 2020 11:17:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79EB64339A;
        Wed, 20 May 2020 11:17:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] builtin/checkout: simplify metadata initialization
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
        <20200520014156.1570124-1-sandals@crustytoothpaste.net>
Date:   Wed, 20 May 2020 08:17:43 -0700
In-Reply-To: <20200520014156.1570124-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 20 May 2020 01:41:56 +0000")
Message-ID: <xmqqmu62ws88.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E1F5F30-9AAD-11EA-9991-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When we call init_checkout_metadata in reset_tree, we want to pass the
> object ID of the commit in question so that it can be passed to filters,
> or if there is no commit, the tree.  We anticipated this latter case,
> which can occur elsewhere in the checkout code, but it cannot occur
> here, since reset_tree is called only (indirectly) via switch_branches,
> which requires that we have a valid commit.  switch_branches dies if we
> lack a name and cannot produce a commit from HEAD, and its caller dies
> if we do have a branch name but still lack a commit pointer.
>
> Since we know we must always have a valid commit structure in this case,
> let's remove the dead code paths and just refer to the commit structure.
> This simplifies the code and makes it easier for the reader.

builtin/checkout.c::merge_working_tree() has these lines in its
earlier part:

	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
		if (new_branch_info->commit)
			BUG("'switch --orphan' should never acc...");
		new_tree = parse_tree_indirect(the_hash_algo->empty_tree);
	} else
		new_tree = get_commit_tree(new_branch_info->commit);
	if (opts->discard_changes) {
		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
		if (ret)
			return ret;
	...

So, when orphan && orphan-from-empty are both set, we must not have
commit, and then if discard is also there, we end up passing
new_brnach_info that has NULL in its commit.

There are few more callers of reset_tree() in this function, which I
did not trace.

Perhaps the "orphan && orphan-from-empty" is a dead combination and
we won't hit the codepath and that is why this change is safe?  I
dunno.


> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/checkout.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e9d111bb83..e53bdab5b8 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -620,11 +620,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>  	opts.verbose_update = o->show_progress;
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
> -	init_checkout_metadata(&opts.meta, info->refname,
> -			       info->commit ? &info->commit->object.oid :
> -			       is_null_oid(&info->oid) ? &tree->object.oid :
> -			       &info->oid,
> -			       NULL);
> +	init_checkout_metadata(&opts.meta, info->refname, &info->commit->object.oid, NULL);
>  	parse_tree(tree);
>  	init_tree_desc(&tree_desc, tree->buffer, tree->size);
>  	switch (unpack_trees(1, &tree_desc, &opts)) {
