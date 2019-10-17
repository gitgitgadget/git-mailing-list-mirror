Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC781F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 07:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407885AbfJQHDJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 03:03:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59918 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390955AbfJQHDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 03:03:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8DEF8C347;
        Thu, 17 Oct 2019 03:03:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V8A59eBnaz1DLe2UM+w+KaN3nR4=; b=s9SfXf
        F8fq8zo7b/M48q+XkPuQcvJX2KEvCLmcllJvFLpDNT1xq1XhuKq/osfh0R1Ccl1h
        csIw0cgBUxQco4d3nHXQPZvUlI8M/DJ9Sd9PNROXv1xDB58kCZoHSY3IVxNaoILs
        B6m7KQMcv5m+Hdjz2ZNlTPzI1ayW3eZxBPSz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nS2hd7LpE3kv4jJI2lUMTpE0ohSR7Tqy
        EtqPVzEfcbBh1eqGrroeFzN3Uoca1QaOKjh75ZG3Jm6RSpVgeG6V3FGLqjcMKTQN
        3IPLQ7f3Wv973zfaKu8DbJZsB3rcBBU5JLx+nlgwjOkpqIn+wTAnBQbn5vdq9qU0
        ias2L13V8Jc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D11198C346;
        Thu, 17 Oct 2019 03:03:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ABFF58C342;
        Thu, 17 Oct 2019 03:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
References: <20190913130226.7449-11-chriscool@tuxfamily.org>
        <20191010235952.174426-1-jonathantanmy@google.com>
        <20191011180125.GA20601@sigill.intra.peff.net>
        <xmqqsgnyg76d.fsf@gitster-ct.c.googlers.com>
        <20191013073851.GA7001@sigill.intra.peff.net>
Date:   Thu, 17 Oct 2019 16:03:00 +0900
In-Reply-To: <20191013073851.GA7001@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 13 Oct 2019 03:38:52 -0400")
Message-ID: <xmqq8spj97mj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 292AAC5E-F0AC-11E9-8B82-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Hmm, I am kind of surprised that the decoding side allowed such a
>> padding.
>
> IIRC, the "padding" is just a sequence of 0-length-plus-continuation-bit
> varint bytes. And for some reason it worked for the size but not for the
> delta offset value.

I think the reason is because they use different varint definition.

The encoding used in builtin/pack-objects.c::write_no_reuse_object()
is for offsets, and it came much later and with an improvement over
the encoding used for delta size in diff-delta.c::create_delta().
The more recent encoding does not allow padding (when I compare the
decoders for these two encodings, I notice there is +1 for each
7-bit iteration; this essentially declares that a byte with "not the
final byte" bit set with all other bits clear does not mean 0 but it
means 1, which breaks the idea of padding to encode filler zero
bits).
