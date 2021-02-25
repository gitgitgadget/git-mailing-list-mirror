Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80304C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1624B64EBA
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhBYFmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 00:42:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58975 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBYFmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 00:42:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FCB5ABA50;
        Thu, 25 Feb 2021 00:41:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SOV2oC5AzNxPUDYlHXlTXWKs6X8=; b=cq2HO5u2fuT8kERA6auO
        jLq83VABNTWoZ5WKvHNFhDrh7zRAghb2TLmphPYFgnpr4QXMW2KHqINywqOfv8t0
        PXeOTM9LYdLItT18RZXx4Jf0vdMgL+ggu7tGcjCclWmZO7+G2mWhGdCb4rn6uWg+
        9eFCzoGijAYnzGQcLwziD9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=nPZPtPYkJ3j9A+ItJZekMbI4ODuBErqWu4EzrVm+cVL1cB
        5hR82IeQwDEDMDYYpwwW7V/4DYvwgSpqqCdoILccT0Dj2ieDkJ0Otahx1aBMOzq/
        ggpa6hEaUz5YBtK1GpO4zB04xo+H5f+Bt6Kc6cfgnFVOPzzRo4P6ycFWPqB+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3622EABA4F;
        Thu, 25 Feb 2021 00:41:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABDD1ABA4E;
        Thu, 25 Feb 2021 00:41:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
        <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com>
        <xmqqv9ana05b.fsf@gitster.g>
        <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com>
        <xmqqo8gd8tyr.fsf@gitster.g>
        <CANQDOdfJApBOEm2gPMwtz9T0ETPoDk107mF7LYRGCmjFLi3Jxg@mail.gmail.com>
Date:   Wed, 24 Feb 2021 21:41:24 -0800
Message-ID: <xmqqmtvswvp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19A1D746-772C-11EB-A135-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> If we think about doing the fastest possible memcpy, I think we want to aim for
> maximizing the use of the CPU cache.  A write buffer that's too big would result
> in most of the data being flushed to DRAM between when git writes it and the
> OS reads it.  L1 caches are typically ~32K and L2 caches are on the
> order of 256K.
> We probably don't want to exceed the size of the L2 cache, and we
> should actually
> leave some room for OS code and data, so 128K is a good number from
> that perspective.
>
> I collected data from an experiment with different buffer sizes on Windows on my
> 3.6Ghz Xeon W-2133 machine:
> https://docs.google.com/spreadsheets/d/1Bu6pjp53NPDK6AKQI_cry-hgxEqlicv27dptoXZYnwc/edit?usp=sharing
>
> The timing is pretty much in the noise after we pass 32K.  So I think
> 8K is too small, but
> given the flatness of the curve we can feel good about any value above
> 32K from a performance
> perspective.  I still think 128K is a decent number that won't likely
> need to be changed for
> some time.

Thanks for a supporting graph.

I can very well imagine that it would have been tempting to instead
say "after we pass 128k" while explaining exactly the same graph,
and doing so would have given a more coherent argument to support
the choice of 128k the patch made.  You knew that a "then perhaps we
can reclaim 96k by sizing the buffer down a bit?" would become a
reasonable response, but you still chose to be honest, which I kinda
like ;-)



