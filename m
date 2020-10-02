Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621C8C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 15:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03415206FA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 15:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s+ElLm54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbgJBP7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 11:59:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64540 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBP7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 11:59:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 894D3783AE;
        Fri,  2 Oct 2020 11:59:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+6Zg+4sWC2Z4FvvpphpDIy0DAQ8=; b=s+ElLm
        54mMYMNktgJfM66C+YppXgnoveYynIv2Zxn04qW8Bx6x7j86eFtBIdXMyZi4TM/w
        bnan0hoYphl4Bafb3knH3Nort6e3XlH75Clf9ef43yxCm71Ct+uGS/lomTcafbwg
        4WG5tT5MN54N47Dd9wdE9TpsWCssrtDVdJLaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DRKTZDRdeNQrh9Nf31kWIr5BMkVoH1ma
        gue9rDcRxq79kU50EddDpccIG1H4FVwW56shH8SC0LdSXoddXfPsmQlYimo46HyH
        4j8UN+B4hAWGTSALoIsXgjhZaa4LOA+ZMencTiIbzeOnfPAT+Bab9FPiSid2jcmD
        4UGXDftSSVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81A08783AD;
        Fri,  2 Oct 2020 11:59:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10884783AC;
        Fri,  2 Oct 2020 11:59:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-reach: fix in_merge_bases_many bug
References: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
Date:   Fri, 02 Oct 2020 08:59:08 -0700
In-Reply-To: <pull.739.git.1601650736489.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 02 Oct 2020 14:58:56
        +0000")
Message-ID: <xmqq8scobovn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34CEABBA-04C8-11EB-8E02-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Way back in f9b8908b (commit.c: use generation numbers for
> in_merge_bases(), 2018-05-01), a heuristic was used to short-circuit
> the in_merge_bases() walk. This works just fine as long as the
> caller is checking only two commits, but when there are multiple,
> there is a possibility that this heuristic is _very wrong_.

Thanks.  That bug defeats the point of _many() part of the function.

> Some code moves since then has changed this method to
> repo_in_merge_bases_many() inside commit-reach.c. The heuristic
> computes the minimum generation number of the "reference" list, then
> compares this number to the generation number of the "commit".
>
> In a recent topic, a test was added that used in_merge_bases_many()
> to test if a commit was reachable from a number of commits pulled
> from a reflog. However, this highlighted the problem: if any of the
> reference commits have a smaller generation number than the given
> commit, then the walk is skipped _even if there exist some with
> higher generation number_.
>
> This heuristic is wrong! It must check the MAXIMUM generation number
> of the reference commits, not the MINIMUM.

Correct

>     Fix in_merge_bases_many() with commit-graphs
>     
>     Johannes alerted me to the difficulties Srinidhi was having with 
>     in_merge_bases_many() and commit-graphs. Sorry that I hadn't seen that
>     thread and the issues therein.
>     
>     After working with Johannes to investigate what was happening, we found
>     a 2-year-old bug in the generation number checks!
>     
>     Thanks, -Stolee

Good.  Thanks.

