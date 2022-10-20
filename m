Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6069EC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJTUZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJTUZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:25:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7BC57BF6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:25:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC5531CAE3F;
        Thu, 20 Oct 2022 16:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xudH+MHq4W5Np8fY8VloUCKIKDi/ZWOcspoZR/
        cVdCk=; b=IVSpuexQ+tAmp1GX+rcfXZxIhFf/rOkQGT37FaZA1HRvHfHQOAua7x
        PU/UAI3PDN/VKxEOfHj08KJy6nbWQKO4vJFsA6RHEQLDFrgZTVXuewBE4YZ3Eb4a
        imLF84QzhEKaXGCu5LZ7RvEQ/J3FPOySjbHqESWtpX6a5st/4ReLk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B55911CAE3E;
        Thu, 20 Oct 2022 16:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E5331CAE3D;
        Thu, 20 Oct 2022 16:25:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 7/8] trace2: add stopwatch timers
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <8e701109976777ad8fae1e0cd3908bb11a1fcf93.1666290489.git.gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 13:25:01 -0700
In-Reply-To: <8e701109976777ad8fae1e0cd3908bb11a1fcf93.1666290489.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 20 Oct 2022
        18:28:08 +0000")
Message-ID: <xmqq7d0us0o2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46DF756A-50B5-11ED-B31C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +#define NS_PER_SEC_D ((double)1000*1000*1000)
> ...
> +	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
> +	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
> +	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;

Hmph, it certainly is an improvement compared to the previous round,
but was there a reason why we did not want a more concise

	#define NS_TO_SECONDS(ns) ((double)(ns) / (1000*1000*1000.))

	double t_total = NS_TO_SECONDS(timer->total_ns);
	double t_min = NS_TO_SECONDS(timer->min_ns);
	double t_max = NS_TO_SECONDS(timer->max_ns);

that does not need to repeat (double) all over?

Not worth a reroll by itself.  Just wanted to know the reasoning
behind it, as I suspect I am missing the reason why it is good to
explicitly casting with (double) in some places; the above does not
look like one, though.

Thanks.

