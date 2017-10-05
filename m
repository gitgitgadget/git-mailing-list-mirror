Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA2B2036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdJEJsS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:48:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50317 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751388AbdJEJsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:48:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4A07AF073;
        Thu,  5 Oct 2017 05:48:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8FI0emKtabHtRddtRWuBF/YZ9E8=; b=BprT7o
        dlowMDS7gcY+RuI8Nn2CRMWm+NdB5ef/gln1ME919FgoAYA2RrehN1Cn2pMuHpeP
        GKMAu0GBetIv+jWt+q+vtvHxF+ygRTwbSnjV3HMA48eN1kTElrqF+VQBMs2DCmmy
        T3BKpsxj8X5VYQ0kisUDsUbxY2exRT9Rfq9A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NjwgMNIithiOrkvg/oa1Pnsq1liK2Y1f
        3m3HR2rpRRyqULBww6L6WWPiVUaoUxbBusgx7qVOHusl4UZdp4pCVJ1afuGh3Ubl
        CRgE4bwIAbuC9af0xg2ZGz1TnyKudM80Uq0Brl863IiBHKNXdU/g2+0bzh1yiPjx
        4BlYWpDoQlE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD039AF072;
        Thu,  5 Oct 2017 05:48:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C995AF071;
        Thu,  5 Oct 2017 05:48:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20170925095452.66833-2-dstolee@microsoft.com>
        <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net>
Date:   Thu, 05 Oct 2017 18:48:10 +0900
In-Reply-To: <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Oct 2017 04:42:50 -0400")
Message-ID: <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C9B2CF6-A9B2-11E7-9641-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is weirdly specific. Can we accomplish the same thing with existing
> tools?
>
> E.g., could:
>
>   git cat-file --batch-all-objects --batch-check='%(objectname)' |
>   shuffle |
>   head -n 100
>
> do the same thing?
>
> I know that "shuffle" isn't available everywhere, but I'd much rather
> see us fill in portability gaps in a general way, rather than
> introducing one-shot C code that needs to be maintained (and you
> wouldn't _think_ that t/helper programs need much maintenance, but try
> perusing "git log t/helper" output; they have to adapt to the same
> tree-wide changes as the rest of the code).

I was thinking about this a bit more, and came to the conclusion
that "sort -R" and "shuf" are wrong tools to use.  We would want to
measure with something close to real world workload.  for example,
letting

	git rev-list --all --objects

produce the listof objects in traversal order (i.e. this is very
similar to the order in which "git log -p" needs to access the
objects) and chomping at the number of sample objects you need in
your test would give you such a list.
