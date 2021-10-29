Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DDC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1508560187
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJ2XYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:24:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59691 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2XYH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:24:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35FD6E2A87;
        Fri, 29 Oct 2021 19:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=An42i749nR9VKJVbU7iAjBOCnvIBj8x/cfxXjw
        hu+7E=; b=WuWlYPzEyLgB9OpPcyjKSHFOsibkzxDHmZq2CYS01cDPaoVDeTXO+h
        coUlrUR71yN5SV8Bs2orqVjLTmbHFCr/7GYcHoW95nL9d5esbN0ird95438ITt3p
        nH+dYnvBby2KWMU6Yj5Ybdh9j/4uHWW14N3gCJyKfNFpcPxW93I7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CE33E2A86;
        Fri, 29 Oct 2021 19:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FC16E2A84;
        Fri, 29 Oct 2021 19:21:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 4/8] t1051: introduce a smudge filter test for
 extremely large files
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <ce9dfaac9f8693890aa402161b38292b31d3690c.1635515959.git.gitgitgadget@gmail.com>
        <xmqqo877h1x5.fsf@gitster.g>
Date:   Fri, 29 Oct 2021 16:21:36 -0700
In-Reply-To: <xmqqo877h1x5.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        29 Oct 2021 16:00:22 -0700")
Message-ID: <xmqqlf2bfmdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6E3964A-390E-11EC-9C40-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +# This smudge filter prepends 5GB of zeros to the file it checks out. This
>> +# ensures that smudging doesn't mangle large files on 64-bit Windows.
>> +test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
>> +		'files over 4GB convert on output' '
>> +	test_commit test small "a small file" &&
>> +	test_config filter.makelarge.smudge \
>> +		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
>> +	echo "small filter=makelarge" >.gitattributes &&
>> +	rm small &&
>> +	git checkout -- small &&
>> +	size=$(test_file_size small) &&
>> +	test "$size" -ge $((5 * 1024 * 1024 * 1024))
>> +'
>
> Why not exactly 5G, but anything that is at least 5G is OK?

I know it is more than 5G, thanks to the "&& cat".  THe question was
why aren't we measuring the size of "a small file" so that we can
check against an exact size to be expected.

Thanks.
