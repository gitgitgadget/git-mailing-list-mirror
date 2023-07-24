Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1124AC001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 17:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGXRVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGXRVw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 13:21:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B31709
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 10:21:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A9A828026;
        Mon, 24 Jul 2023 13:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p3wyixZekX2plaZl8UXmokeeTY6qP7X7VPpKAD
        j15Kw=; b=p7fntCxRj56QzsQSSilTan9RG0ZffhmRyajP8vS2S5C9XRaZBr2/zR
        T0R7YHxXO4TRVTm1ZcJNZhoLjr9I6fIl1h8EGEwoMsFU8LKu8PBPiJ9yI3sqZ44M
        k0IYrRRtLW8334tUnnIISnaEwE317mn+jRa+xMLfkb+txcvFoDXqU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7363528025;
        Mon, 24 Jul 2023 13:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 140C228023;
        Mon, 24 Jul 2023 13:21:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v4 2/2] ref-filter: add new "describe" atom
References: <20230719162424.70781-1-five231003@gmail.com>
        <20230723162717.68123-1-five231003@gmail.com>
        <20230723162717.68123-3-five231003@gmail.com>
Date:   Mon, 24 Jul 2023 10:21:15 -0700
In-Reply-To: <20230723162717.68123-3-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Sun, 23 Jul 2023 21:49:59 +0530")
Message-ID: <xmqqfs5dql84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F8B7984-2A46-11EE-8CA4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> +test_expect_success 'err on bad describe atom arg' '
> +	(
> +		cd describe-repo &&
> +
> +		# The bad arg is the only arg passed to describe atom
> +		cat >expect <<-\EOF &&
> +		fatal: unrecognized %(describe) argument: baz
> +		EOF
> +		! git for-each-ref --format="%(describe:baz)" \
> +			refs/heads/master 2>actual &&
> +		test_cmp expect actual &&

Instead of "! git something", use of "test_must_fail git something" is
recommended.  The former would pass upon a crashing "git" happily, but
the latter would complain if "git" segfaults.

> +		# The bad arg is in the middle of the option string
> +		# passed to the describe atom
> +		cat >expect <<-\EOF &&
> +		fatal: unrecognized %(describe) argument: qux=1,abbrev=14
> +		EOF
> +		! git for-each-ref \
> +			--format="%(describe:tags,qux=1,abbrev=14)" \
> +			ref/heads/master 2>actual &&

Ditto.

> +		test_cmp expect actual
> +	)
> +'

Other than that, both patches looked good to me.  Thanks.
