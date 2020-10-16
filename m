Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CA5C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475A7207DE
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Te2EwTM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410794AbgJPTTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:19:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64099 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393095AbgJPTTt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:19:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30BF1FD766;
        Fri, 16 Oct 2020 15:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ooa24S39Y/Zj3YLLh0ET9uGDlYw=; b=Te2EwT
        M1C8EENXaCcpcT6Q6v0jiXYmyWzuk9HlM4rRiUfP6fp5/DWHxebzCC+5X7l6IY4a
        6TEJxx/DVE6a0CGK0NGymA8t6c5I/RuE0FvcyFQmsj3S+cczLTlFpWQFH4JapoFo
        +1+ej/7nxVli/Pnh57WQw5smsPdLB1SYeNGPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tYqAwy+ipyVRss24Czs6oaRYPqOVxDaF
        kH00jaaaVgTDNsW/aeEABtPSMqAfDMChlYBrPCIskZCJWxJ4nprZLY7i7szbqfWV
        TYtGHTzfitYtmhDTbo472MtyyrSCnHNlkDm5iO14Z0mRdHxjCzhY00HD8ULvUbt0
        pesEfZTDeok=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A1DEFD765;
        Fri, 16 Oct 2020 15:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 70097FD75F;
        Fri, 16 Oct 2020 15:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 05/11] merge-resolve: rewrite in C
References: <20200901105705.6059-1-alban.gruin@gmail.com>
        <20201005122646.27994-1-alban.gruin@gmail.com>
        <20201005122646.27994-6-alban.gruin@gmail.com>
Date:   Fri, 16 Oct 2020 12:19:41 -0700
In-Reply-To: <20201005122646.27994-6-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 5 Oct 2020 14:26:40 +0200")
Message-ID: <xmqqr1pyashe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BA4BFDE-0FE4-11EB-BDBF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> +#include "cache.h"
> +#include "builtin.h"
> +#include "merge-strategies.h"
> +
> +static const char builtin_merge_resolve_usage[] =
> +	"git merge-resolve <bases>... -- <head> <remote>";
> +
> +int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
> +{
> +	int i, is_baseless = 1, sep_seen = 0;
> +	const char *head = NULL;
> +	struct commit_list *bases = NULL, *remote = NULL;
> +	struct commit_list **next_base = &bases;
> +
> +	if (argc < 5)
> +		usage(builtin_merge_resolve_usage);
> +
> +	setup_work_tree();
> +	if (repo_read_index(the_repository) < 0)
> +		die("invalid index");
> +
> +	/* The first parameters up to -- are merge bases; the rest are
> +	 * heads. */

Style (I won't repeat).

> +	for (i = 1; i < argc; i++) {
> +		if (strcmp(argv[i], "--") == 0)

	if (!strcmp(...))

is more typical than comparing with "== 0".

> +			sep_seen = 1;
> +		else if (strcmp(argv[i], "-h") == 0)
> +			usage(builtin_merge_resolve_usage);
> +		else if (sep_seen && !head)
> +			head = argv[i];
> +		else if (remote) {
> +			/* Give up if we are given two or more remotes.
> +			 * Not handling octopus. */
> +			return 2;
> +		} else {
> +			struct object_id oid;
> +
> +			get_oid(argv[i], &oid);
> +			is_baseless &= sep_seen;
> +
> +			if (!oideq(&oid, the_hash_algo->empty_tree)) {

What is this business about an empty tree about?

> +				struct commit *commit;
> +				commit = lookup_commit_or_die(&oid, argv[i]);
> +
> +				if (sep_seen)
> +					commit_list_append(commit, &remote);
> +				else
> +					next_base = commit_list_append(commit, next_base);
> +			}
> +		}
> +	}
> +
> +	/* Give up if this is a baseless merge. */
> +	if (is_baseless)
> +		return 2;

This is quite convoluted.  

The original is much more straight-forward.  We just said "grab
everything before we see '--' and call them bases; immediately after
'--' is HEAD and everything else is remote.  Now do we have any
base?  Otherwise we cannot handle it".

I cannot see an equivalence to it in the rewritten result, with the
bit operation with is_baseless and sep_seen.  Wouldn't it be the
matter of checking if next_base is NULL, or is there something more
subtle that deserves in-code comment going on?

Thanks.
