Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C82C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 23:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C68464E49
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 23:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhBCX1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 18:27:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52418 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhBCX06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 18:26:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B20FAD2D0;
        Wed,  3 Feb 2021 18:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ea1Vw/gFTeUbLVoDoq2uMlEPe68=; b=ouSmBa
        qwDj80KOIT/+oxfdOdyMpscncu1D/RCm43qbalCGAqW5yOrna1YlQhZbV58gST6D
        Ta5ytl2VdG6tX47fkbnddCI5g5/Gdo1eNKfojnEFoExxnPxA3fY8Qcbej7v8zBvL
        2LPBCgsneheBd9MXE0DGkAiVZW8CyDp60pKWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jqS0VbKO71CYWm3nZY8qZoFgaBj/k5QE
        RX/xlSNDBj1lEQldO8N9W3mHLKVD30rUcp+XmprSB6YxnwgJF58mkIB9QzLDaUgM
        iTvU2GtHPR3Zj4WICEwScSf83EEvHCnyULH5FsLRiOwDqdPzVIiZlHFBm5sQqIPv
        Rjt83P2mOHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91341AD2CD;
        Wed,  3 Feb 2021 18:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E902DAD2CC;
        Wed,  3 Feb 2021 18:26:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimization batch 6: make full use of exact
 renames
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
        <xmqqlfc4byt6.fsf@gitster.c.googlers.com>
        <CABPp-BEgwfv70NRGgyAnHnQBPx4APSyYxNCbvH9F=7WGSj4DLQ@mail.gmail.com>
Date:   Wed, 03 Feb 2021 15:26:13 -0800
In-Reply-To: <CABPp-BEgwfv70NRGgyAnHnQBPx4APSyYxNCbvH9F=7WGSj4DLQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 3 Feb 2021 15:06:26 -0800")
Message-ID: <xmqq5z38bune.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34E88966-6677-11EB-B753-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> 3) It uses a similarity measure that diverges from what researches
> used for MinHash and other fancy algorithms.  In particular,
>
>    size(A intersect B) / size(A union B)  != size(A intersect B) /
> max(size(A), size(B))
>
> The formula on the right hand side would mean that if file A is a
> subset of file B, say the first 10% of file B, then it will be treated
> as 100% similar when most humans would look at it and say it is only
> 10% similar.

If you are talking about "you start from 100 lines file and appended
900 lines of your own, then you still have 100% of the original
material remaining in the file", it is quite deliberate that we used
it as an indication that the original "100 lines" file is a good
candidate to have been renamed to the resulting "1000 lines" file.
It is "what you have kept from the original" measure.

Of course, taken to the extreme, this means that rename does not
have to be symmetrical.  "diff A B" may find that the original
100-line file in A has grown into 1000-line file in B elsewhere, but
"diff B A" or "diff -R A B" would not necessarily pair these two
blobs as matching.

> Maybe the performance gains I'm adding elsewhere will offset possible
> grumpy users?

Users, as they are, it would never happen.  When they have something
to complain about, they will, regardless of what else you do.


