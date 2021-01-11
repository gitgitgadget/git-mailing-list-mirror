Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A1CC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 18:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF96F225AB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 18:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbhAKSlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:41:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55691 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbhAKSlb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 13:41:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58348125B76;
        Mon, 11 Jan 2021 13:40:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dK/gdHLTtIHYG5bCL5lTw8tO/rU=; b=wG/bW0
        eCHupYVAK2LFCK9GRwww9sZNnvqzsKEMFdqAlSnjFLwKXRDeKjnosnXsiIIMrq0m
        gh2l5xFhQSmVz/foQ6fuvtvJZU9NOsG8w+hyIFhsHrFSMAYFN2RoAHHsge1fX6Z4
        G+nEYLUfHhQTBHZJjxW+UCRTuJvZF1OE3BVqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sWf13g5pkoAY/meutVrGNeEEmQlbapg6
        9kRSWzYM/+gBaIcp3Q/TR14U7b72I4deasLMlbZ1m1rl9hGruqZFGa93UIlrEEoZ
        hlpAVa2493J1nYsLlbQQQaWhi3pLmhzWFGJZFgZ8eggF6et+i7ffH49/nHkpJsw3
        YThJJkxNeFM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50C70125B75;
        Mon, 11 Jan 2021 13:40:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A941125B74;
        Mon, 11 Jan 2021 13:40:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
References: <cover.1610129796.git.me@ttaylorr.com>
        <75ba9979-1a1f-de9f-c2cc-1433d30ed09d@gmail.com>
        <X/x9MMv4hBZMGKBT@nand.local>
        <7e56e831-c6d6-3454-94c5-b8e888497568@gmail.com>
Date:   Mon, 11 Jan 2021 10:40:44 -0800
In-Reply-To: <7e56e831-c6d6-3454-94c5-b8e888497568@gmail.com> (Derrick
        Stolee's message of "Mon, 11 Jan 2021 12:15:58 -0500")
Message-ID: <xmqqlfcz8ggj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84BA35CC-543C-11EB-ACF3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Well, I found 782 instances of ") < 0)" in the codebase, and my initial
> scan of these shows they are doing exactly what you are asking. So as
> far as code style goes, there is plenty of precedent.
>
> The thing that makes me react to this is that it _looks_ like an extra
> comparison. However, I'm sure the assembly instructions have the same
> performance characteristics between "!= 0" and "< 0".

I'd prefer to keep it that way for the human cost's point of view.

Perhaps it could be subjective but

	if (func_that_signals_error_with_return_value() < 0)

is immediately recognizable as checking for an error to folks who
were trained to write C in POSIX environment, as "on error, return
negative" is a convention that they are familiar with.  At least to
me, your "if (func_that_signals_error_with_return_value())" looks
unnatural and makes me look at the function to see what its return
value means.

If there are helper functions that use "non-zero is an error and
zero is success" convention, we should look at them to see why they
do not do the usual "a negative is an error and a non-negative is
success".  And if the *only* reason they do so is because their
normal return do not have to give more than one kind of "success",
we should see if we can fix them to follow the usual "a negative is
an error" convention, I would think.

Thanks.
