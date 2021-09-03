Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD0C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 04:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7725B61074
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 04:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhICEnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 00:43:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62654 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhICEnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 00:43:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0056FF1A84;
        Fri,  3 Sep 2021 00:42:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9fvZ9E1PRT14fEDFCHasXy1+rcS1rhTJEF71p3
        SkTtk=; b=X5Yx0sQKPe6grYtxfHowIUbDSzfy0S1opTh9+F30df1jXPJPzCCWlu
        /P/5G5Rp+AGJMbxEGXsWr+u7+hqZJBdV0eoHawKYjsjEceLXZ5x7te/2HJXjRKL1
        beZIxg+iFRrr4uZr5EMhzHuTpkcPaVC7ZVwe5grwAXuHbsxg38VuE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3120F1A83;
        Fri,  3 Sep 2021 00:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D000F1A82;
        Fri,  3 Sep 2021 00:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH 3/3] fixup! reftable: add a heap-based priority queue
 for reftable records
References: <20210902053023.44006-1-carenas@gmail.com>
        <20210902053023.44006-4-carenas@gmail.com>
        <YTCU3F+0sKcrym6F@coredump.intra.peff.net>
        <xmqqeea6kaed.fsf@gitster.g>
        <YTFS2oQz9QEzBe0Q@coredump.intra.peff.net>
Date:   Thu, 02 Sep 2021 21:42:02 -0700
In-Reply-To: <YTFS2oQz9QEzBe0Q@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 2 Sep 2021 18:40:26 -0400")
Message-ID: <xmqqbl5agtid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48C4DFDE-0C71-11EC-8649-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I agree that the patch as posted does not help but if this is
>> originally an assertion, then it should never trigger in real life,
>> so BUG() would be more appropriate than an error return, no?
>
> My thinking was that it doesn't make much sense as an assertion in the
> first place. It is not a side effect of "let's make sure things are as
> we expect while we're doing some other operation". The whole point of
> the function is: is this data structure properly in order.

Very true.  Ah, so you mean the way this function is supposed to be
used is to _call_ it, like so:

	if (!is_our_data_structure_healthy())
		BUG(...);

It makes it easier to reason about what the function is doing, I
guess.

> But I guess you could argue that calling the function is itself a form
> of assertion. I don't really care that much either way, so whatever
> Han-Wen prefers is fine with me (but I do think it is worth addressing
> the warning Carlo found _somehow_).
>
> -Peff
