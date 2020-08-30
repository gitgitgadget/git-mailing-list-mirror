Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC569C433E2
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB62520707
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 16:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ux83Cj/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgH3QPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:15:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63424 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgH3QPP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 12:15:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EEB28B278;
        Sun, 30 Aug 2020 12:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kMiR1vZ6jqGC
        G+F3Tbx0FAUJZDA=; b=ux83Cj/0aDK1PeWcOFrO6JgF5WWMfVkzZlVxOwlfWFQZ
        K2bEsQfiV3Cd/ssjLKvItjK9qW+kduy//QwiWAfDwzNstQ/pMbQV3GcKZ/ynkTMA
        fHVt49FcvCKO/t//esbwn0NS6m6JJegZzU6y4X/YmYwIBJ8Q4hqClnuil6V9a/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=d+8OpX
        idS4Lew2WDiutee/yFct55/GzT7tECb82favjoGvNS4ZRI5c3rliYCTPPCn2SWO3
        oIypVdKChMshujQjVmflBAGWKo/vqQXhM6cBC/3S+p8jJWuErUd4eZreUDwo/YBc
        Z2yFo8z14rPIi2oBVSuCOoBKKzzS3ojXz4UBk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3738F8B276;
        Sun, 30 Aug 2020 12:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD6918B275;
        Sun, 30 Aug 2020 12:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     ori@eigenstate.org, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
References: <A1CA9D499EDDACBA275BA61E114645F0@eigenstate.org>
        <59efeeab-49de-17e7-8b1c-355d6ef31b5d@web.de>
Date:   Sun, 30 Aug 2020 09:15:10 -0700
In-Reply-To: <59efeeab-49de-17e7-8b1c-355d6ef31b5d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 30 Aug 2020 12:56:11 +0200")
Message-ID: <xmqqwo1gglf5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB8CDC88-EADB-11EA-8D3E-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Will that work? I'd expect that modern pack files end up being
>> offset deltas, rather than reference deltas.
>
> True, but going down all the way would work:

Perhaps, but I'd rather use pack-objects to prepare the repository
with no-delta-base-offset to force ref deltas.

> diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
> index 0f06c40eb1..7fd21cd3ce 100755
> --- a/t/t5316-pack-delta-depth.sh
> +++ b/t/t5316-pack-delta-depth.sh
> @@ -94,4 +94,15 @@ test_expect_success '--depth limits depth' '
>  	test_i18ncmp expect actual
>  '
>
> +test_expect_success 'maxAllowedDeltaDepth is respected' '
> +	git clone . clone1 &&
> +	(
> +		cd clone1 &&
> +		git repack -a -d &&
> +		test_config core.maxAllowedDeltaDepth 0 &&
> +		test_must_fail git fsck 2>err &&
> +		test_i18ngrep "overlong delta chain" err
> +	)
> +'
> +
>  test_done
