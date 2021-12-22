Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B9FC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbhLVT56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:57:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64368 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbhLVT56 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:57:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 101AE15099F;
        Wed, 22 Dec 2021 14:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gUhVDQ+eGxQOvByMn8AYFgqeyDqwg7asyqkfH7
        RpP04=; b=S0y6nlTeKkliX3KUrjW6kRIyug/Iq3Y2hRL8uNWO6OGOiJk+Emt4jG
        ObB14IGTNbk9jhkND6PcMKVyEuEqEBFKOmtyDkMaHRL84Fp3j3KmgiyspbRU+feP
        nQ/ZWmxhE9WfE/ttClIq9FQMlZL7uBsH/ZuAhQcyIIDR/KHdloIxY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 086E515099E;
        Wed, 22 Dec 2021 14:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5C64A15099D;
        Wed, 22 Dec 2021 14:57:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
        <xmqqsfumqv62.fsf@gitster.g>
        <ea4eb7f2-863f-2439-d175-cd4e97ad63a6@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 11:57:53 -0800
In-Reply-To: <ea4eb7f2-863f-2439-d175-cd4e97ad63a6@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 22 Dec 2021 11:28:23 -0500")
Message-ID: <xmqq8rwcjttq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7397C09A-6361-11EC-A74A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'll convert it to a flex-array at the bottom of the CTX structure
> and then defer the truncation to the _perf target (which only does
> that to keep the columns lined up).
>
> That will simplify things considerably.

I am not sure if the complexity of flex-array is worth it.

You have been storing an up-to-24-byte human readable name by
embedding a strbuf that has two size_t plus a pointer (i.e. 24-bytes
even on Windows), and the posted patch changes it to a pointer plus
a on-heap allocation with malloc() overhead.

An embedded fixed-size thread_name[TR2_MAX_THREAD_NAME+1] member
may be the simplest thing to do, I suspect.
