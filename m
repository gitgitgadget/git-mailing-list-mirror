Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F28C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbiBQW1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:27:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbiBQW1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:27:23 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB4853B77
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:27:07 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CF23104158;
        Thu, 17 Feb 2022 17:27:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nRRD/nOR55jop6QEVcnsHXsSCRSf2hppMPsGxs
        pwpNg=; b=H0xsU0WirFBqKC+w774ho+Ox04IwPcMAqLgn2vjOILukjZZJuzXwQC
        pIt3z/sTc+54lUCF2XMCqEUgye8kX+Gis1qhYwzgvRcDHso4l8bKVXcvnlcuKwnW
        EGAB1XZooCHOfbUHiZeBweTy0lI02hgQiENAX5TySWGED8FsWSllY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B52CA104156;
        Thu, 17 Feb 2022 17:27:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36B55104154;
        Thu, 17 Feb 2022 17:27:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 6/7] fetch: make `--atomic` flag cover backfilling of
 tags
References: <cover.1645102965.git.ps@pks.im>
        <331ee40e57df1f07fe725dc679dd934c777d4eab.1645102965.git.ps@pks.im>
Date:   Thu, 17 Feb 2022 14:27:02 -0800
In-Reply-To: <331ee40e57df1f07fe725dc679dd934c777d4eab.1645102965.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 17 Feb 2022 14:04:36 +0100")
Message-ID: <xmqqiltd6seh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBAB64A2-9040-11EC-BAFD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Fix this by pulling up creation of the reference transaction such that
> we can pass the same transaction to both the code which updates local
> references and to the code which backfills tags. This allows us to only
> commit the transaction in case both actions succeed.

OK, having done the FETCH_HEAD thing, the idea is quite similar.
Instead of letting two invocations to store_updated_refs() to
independently open and close separate transactions, we control
everything centrally in do_fetch().

Makes sense.

> @@ -197,12 +194,10 @@ test_expect_success 'atomic fetch with backfill should use single transaction' '
>  		prepared
>  		$ZERO_OID $B refs/heads/something
>  		$ZERO_OID $S refs/tags/tag2
> +		$ZERO_OID $T refs/tags/tag1
>  		committed
>  		$ZERO_OID $B refs/heads/something
>  		$ZERO_OID $S refs/tags/tag2
> -		prepared
> -		$ZERO_OID $T refs/tags/tag1
> -		committed
>  		$ZERO_OID $T refs/tags/tag1
>  	EOF

OK.

Unlike the "expect the behaviour at the end of the series from the
beginning with known-to-fail tests" pattern I cautioned against in
an earlier step, this is a good way to show how the behaviour
changes.

Thanks.
