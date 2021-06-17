Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE168C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 05:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA137613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 05:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFQFG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 01:06:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57059 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQFGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 01:06:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F080B9069;
        Thu, 17 Jun 2021 01:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bx8F7TAv6DYEbCC25vl2pIdm59LSjYqBTGcDNJ
        tIXKk=; b=DwTCpooUHUDQ191ayKwVULQjPicwwGoK0xnHXeYC8CliLFETFsbd5v
        NTLlGB7iwEokvqbNkTBgGme1vxpPKEfYEcJYB1XCzGUQ42hw16+iPK3f8Pzw6krh
        l4F9rWgTUGRMrmXKmDT3CkH0BbsEM+YYp4VeZOebj9jNrm0GXb1os=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66CD9B9068;
        Thu, 17 Jun 2021 01:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D135BB9067;
        Thu, 17 Jun 2021 01:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 5/5] merge-ort: add prefetching for content merges
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
        <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
        <317bcc7f56cb718a8be625838576f33ce788c3ef.1623796907.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Jun 2021 14:04:16 +0900
In-Reply-To: <317bcc7f56cb718a8be625838576f33ce788c3ef.1623796907.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 15 Jun 2021
        22:41:46 +0000")
Message-ID: <xmqqfsxhm69b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7766D5AC-CF29-11EB-BFC2-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		/* Ignore clean entries */
> +		if (ci->merged.clean)
> +			continue;
> +
> +		/* Ignore entries that don't need a content merge */
> +		if (ci->match_mask || ci->filemask < 6 ||
> +		    !S_ISREG(ci->stages[1].mode) ||
> +		    !S_ISREG(ci->stages[2].mode) ||
> +		    oideq(&ci->stages[1].oid, &ci->stages[2].oid))
> +			continue;
> +
> +		/* Also don't need content merge if base matches either side */
> +		if (ci->filemask == 7 &&
> +		    S_ISREG(ci->stages[0].mode) &&
> +		    (oideq(&ci->stages[0].oid, &ci->stages[1].oid) ||
> +		     oideq(&ci->stages[0].oid, &ci->stages[2].oid)))
> +			continue;

Even though this is unlikely to change, it is unsatisfactory that we
reproduce the knowledge on the situations when a merge will
trivially resolve and when it will need to go content level.

One obvious way to solve it would be to fold this logic into the
main code that actually merges a list of "ci"s by making it a two
pass process (the first pass does essentially the same as this new
function, the second pass does the tree-level merge where the above
says "continue", fills mmfiles with the loop below, and calls into
ll_merge() after the loop to merge), but the logic duplication is
not too big and it may not be worth such a code churn.

> +		for (i = 0; i < 3; i++) {
> +			unsigned side_mask = (1 << i);
> +			struct version_info *vi = &ci->stages[i];
> +
> +			if ((ci->filemask & side_mask) &&
> +			    S_ISREG(vi->mode) &&
> +			    oid_object_info_extended(opt->repo, &vi->oid, NULL,
> +						     OBJECT_INFO_FOR_PREFETCH))
> +				oid_array_append(&to_fetch, &vi->oid);
> +		}
> +	}
> +
> +	promisor_remote_get_direct(opt->repo, to_fetch.oid, to_fetch.nr);
> +	oid_array_clear(&to_fetch);
> +}
> +
