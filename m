Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF20C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 22:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiIWWEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiIWWEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 18:04:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C4EDD3B
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 15:04:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A0761456FF;
        Fri, 23 Sep 2022 18:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EDsg7TaeG9jkKnmGuTVeGs60IT1eZ1rrrpmJMD
        /lU3U=; b=Hg8FKmC3VSzUZYcQmMM7iXQFqgjMh4TZSDBN/EwdpszZmK5k/3CyWj
        X86sJD/8P4ZbLlVC+dAr7feaTRJuhFbHF5ul7mvBLSdyHfU+A0gHdMZ6ZZHZ63XC
        oKYO2aL5c+AfnR1t3JiOHwtsQ5O+eTrEpY3VIoXnV8m3cc/jeiL7Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 622561456FE;
        Fri, 23 Sep 2022 18:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C90AE1456FD;
        Fri, 23 Sep 2022 18:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
        <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
Date:   Fri, 23 Sep 2022 15:04:10 -0700
In-Reply-To: <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 23 Sep 2022 17:39:28 -0400")
Message-ID: <xmqqtu4xsq79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7B33226-3B8B-11ED-BA2B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here (and elsewhere), you can assume that the offsetof() "sec" in
> cache_time is 0, for two reasons:
>
>   - I didn't look up chapter and verse, but I'm pretty sure the standard
>     does guarantee that the first field of a struct is at the beginning.

https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf

6.7.2.1 #13 (page 103)

    Within a structure object, the non-bit-field members and the
    units in which bit-fields reside have addresses that increase in
    the order in which they are declared. A pointer to a structure
    object, suitably converted, points to its initial member (or if
    that member is a bit-field, then to the unit in which it
    resides), and vice versa. There may be unnamed padding within a
    structure object, but not at its beginning.

As an initial padding is forbidden, the first member's offset is zero.

