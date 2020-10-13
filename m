Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B051C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956DE2538F
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mgMtcU6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgJMRxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:53:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54707 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMRxb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 13:53:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3D4E100891;
        Tue, 13 Oct 2020 13:53:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8AhKcNh0Ra9oeX3LE4ksCKTR8cg=; b=mgMtcU
        6FiPKJ3QKKmwQzFRG2TGCaemB4TG2EAN/QkpVufwXtZ8aPO/7Z3Pa03cdhserCUh
        a8y9YmwR/sR/d2s6z2lbiEIsFo89qdSZIgfo29PiK7GBoggMSJR41GQq5DALBGXw
        D2djjrZjVweO5QGS51atMu/r4+P2te4G7AxVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OurpSo2ilL/6wTls8iR9Gv/EH4HZngwK
        9zz/S/rJM8/6ckyxajY5iV1yPoNY4ERCjbDpkgkqRYuNS/QuFu5QLd0uo2ZUICVF
        DvhyDQJedQ2QTXTWuRCnHByOTgfZLvhcK5n6hSMqAqmdNezmmqyPH7vFOwDujh3M
        cVSII5JXaYo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDB55100890;
        Tue, 13 Oct 2020 13:53:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 403C110088F;
        Tue, 13 Oct 2020 13:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5500.43: make the check a bit more robust
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 10:53:24 -0700
In-Reply-To: <pull.753.git.1602600323973.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 13 Oct 2020 14:45:23
        +0000")
Message-ID: <xmqqy2kaj9m3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE8E6366-0D7C-11EB-B9CB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Note: we have code in `demultiplex_sideband()` _specifically_ to stitch
> back together lines that were delivered in separate sideband packets.
> However, this stitching fails when a primary packet is delivered in
> between the two sideband packets: since a primary packet was received,
> `demultiplex_sideband()` has to return that (and cannot wait for other
> sideband packets, and therefore has to flush any incomplete line it
> received).

Ouch.  Good find.

>  	git -C myclient fetch --progress origin 2>log &&
> -	test_i18ngrep "remote: Total 3 " log
> +	if ! test_i18ngrep "remote: Total 3 " log
> +	then
> +		# It is possible that the "Total 3" line is delivered in
> +		# multiple sideband packets, and that a primary packet is
> +		# delivered in between. When that happens, the line will be
> +		# presented on multiple "remote:" lines.
> +		sed "/^remote: T/{
> +			:a
> +			N
> +			s/\nremote: //
> +			ba

OK, so if we see multiple and adjacent "remote:" lines, we strip the
leading "remote: " prefix from the second and subsequent lines and
concatenate them into one giant line?  Sounds good.

Will queue.  Thanks.

> +		}" log >log.unsplit &&
> +		test_i18ngrep "remote: Total 3 " log.unsplit
> +	fi
>  '
>  
>  test_expect_success 'in_vain resetted upon ACK' '
>
> base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
