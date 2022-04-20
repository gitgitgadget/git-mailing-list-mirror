Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9F4C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382288AbiDTU4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiDTU4X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:56:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD17129800
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:53:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE75A131DC5;
        Wed, 20 Apr 2022 16:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rnZn7RT8X2jHga3SKlJ83nriXwmaxbgKO4B+sy
        4Zd8Y=; b=vE33+Co9Y5c5QOtRzxOIANWBz8kEIvE4wafXecnChvBxIEHlUKuTZQ
        CLOilqBYbWD9f05nvdQkHK83sT7T0KiUDhjawcmdUI7xY5L4Yr0FZUch/jh0wHbq
        8LlMw+LGAebOdBMS+cFL/Jnr4kGWNn5fY3Z2UTzYwaVeXO5XFF0Y8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6B30131DC4;
        Wed, 20 Apr 2022 16:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AEE8131DC3;
        Wed, 20 Apr 2022 16:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] clone: ignore invalid local refs in remote
References: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 13:53:32 -0700
In-Reply-To: <pull.1214.git.1650301959803.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 18 Apr 2022 17:12:39
        +0000")
Message-ID: <xmqqczhbo4s3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F162B2F4-C0EB-11EC-96DC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
> Subject: Re: [PATCH] clone: ignore invalid local refs in remote

After seeing the title, I expected that cloning from such a
repository with cruft in .git/refs/ directory would issue a warning
and succeed without these non-ref files.

But that is not what is happening here?

> +test_expect_success 'local clone from repo with corrupt refs fails gracefully' '
> +	git init corrupt &&
> +	test_commit -C corrupt one &&
> +	echo a >corrupt/.git/refs/heads/topic &&
> +
> +	test_must_fail git clone corrupt working 2>err &&
> +	grep "has a null OID" err
> +'
> +

We keep expecting that clone _will_ fail.

So the net change is that we still do not tolerate a corrupt
repository and do not let corruption to propagate through cloning,
but we diagnose this breakage as an error by calling die(), which 
is appropriate for dealing with runtime data error, instead of
hitting a BUG(), which is reserved for program errors.

I agree with the fixed behaviour and implementation.  It just is
that "ignore" on the title seems misleading.  Other than that,
thanks for a good finding and a clean fix.

> -	if (!new_oid || is_null_oid(new_oid))
> -		BUG("create called without valid new_oid");
> +	if (!new_oid || is_null_oid(new_oid)) {
> +		strbuf_addf(err, "'%s' has a null OID", refname);
> +		return 1;
> +	}
