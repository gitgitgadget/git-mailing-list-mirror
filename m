Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7991CC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 04:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B49F613CB
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 04:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQEvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 00:51:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64560 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFQEvM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 00:51:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F73112D8E8;
        Thu, 17 Jun 2021 00:49:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D419sHu0eUzp3GMnmEvf0rHlNjdJdQqnLcx7vG
        w0FxA=; b=sBSgsJj9IAgbPYyZoaXtrxL1FyfkJWcfRzh9uEoJHP6K15lA4ThiSC
        +wCOPcyDTDje4PvEpmMgLJyIkJ6uvbbgcPK9xuoWgOj+PApUCACAxM4uScJphvBO
        t32m0rHrcGTPxLcx9OlxFTIFN36PV0jBssXYWojCtvvMAMiAdktlk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AB2212D8E6;
        Thu, 17 Jun 2021 00:49:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5446712D8E3;
        Thu, 17 Jun 2021 00:49:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/5] t6421: add tests checking for excessive object
 downloads during merge
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
        <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
        <0f786cfb4c9507a224b1dc3ee6eca9f5ac5c2ae8.1623796907.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Jun 2021 13:49:00 +0900
In-Reply-To: <0f786cfb4c9507a224b1dc3ee6eca9f5ac5c2ae8.1623796907.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 15 Jun 2021
        22:41:43 +0000")
Message-ID: <xmqqk0mtm6yr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 564F1EB2-CF27-11EB-AF5A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		for i in `test_seq 1 88`; do
> +			echo content $i >dir/unchanged/file_$i
> +		done &&

        for i in $(...)
        do
                ... || return 1
        done &&

> +test_expect_merge_algorithm failure failure 'Objects downloaded for single relevant rename' '
> +	test_setup_repo &&
> +	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-single &&
> +	(
> +		cd objects-single &&
> +
> +		git rev-list --objects --all --missing=print |
> +			grep '\?' >missing-objects-before &&

The closing and reopening of single quote here is somewhat
misleading.  Wouldn't

		grep "?" >... &&

work just as well?

> +		git rev-list --objects --all --missing=print |
> +			grep ^? >missing-objects-after &&
> +		test_cmp missing-objects-before missing-objects-after |
> +			grep "^[-+]?" >found-and-new-objects &&

I do not think we specify what test_cmp's output looks like; we only
guarantee that it is the right tool to use for expecting two paths
have the same contents, and it may give some human readable output.

Do not assume you can grep in the output; use "diff -u" if you mean
you expect things that exist on the left side and missing from the
right hand side are prefixed with '-' and vice versa for '+'.

Or sort "missing-objects-after" and "missing-objects-before" and run 
"comm" on them, which might be more stable.  Depending on the order
two invocations of rev-list spews out the "missing" objects, you may
even see the same object mentioned with "-" and "+" in the diff output
if lines appear to be moved around.

> +		# We should not have any NEW missing objects
> +		! grep ^+ found-and-new-objects &&
> +		# Fetched 2+1=3 objects, so should have 3 fewer missing objects
> +		test_line_count = 3 found-and-new-objects
> +	)
> +'

I think similar comments apply to the tests in the remainder of the
patch.

Thanks.
