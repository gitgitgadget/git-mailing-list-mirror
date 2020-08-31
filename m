Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255FC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 16:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A6120719
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XF4UpjEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgHaQcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:32:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57489 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgHaQcd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 12:32:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1680F6B452;
        Mon, 31 Aug 2020 12:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G3P91+yG7QJRJTDAtPvvI5n9HeI=; b=XF4Upj
        EzAwPYSEvY3Vu4bD1XcD6rH6yLcApOCnrC/2hpMDf1MSjQPvdmlVaCeJBIhGIcqz
        DTFptXRDfnJMsufCLRkIt0fCW7nhLB410owKoZBkyJjuWNIRQKAr99j71TG5VxnT
        4+xDTJ98y9rppBEA6sQqqtD42io9t6G0zccSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lKgChkxGZOOidUhsYxr+6lZL0f46v0oj
        ltHnJWqmpd5OgNI1Yeg6Or3Z4u5da3uqW5YbmXx1bF1OLzxbtt3vOLp4CYaTED/7
        fQX2SvaCODwApdBGjFupQ/RqSbtYwl5nHNFzqq0LkCZcc4Y9JtAyqvZXUc7vawJ0
        sbOlSH8rqfI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E6EC6B451;
        Mon, 31 Aug 2020 12:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8260E6B450;
        Mon, 31 Aug 2020 12:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     ori@eigenstate.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
References: <A1CA9D499EDDACBA275BA61E114645F0@eigenstate.org>
        <59efeeab-49de-17e7-8b1c-355d6ef31b5d@web.de>
        <xmqqwo1gglf5.fsf@gitster.c.googlers.com>
        <20200831092946.GA2812764@coredump.intra.peff.net>
Date:   Mon, 31 Aug 2020 09:32:27 -0700
In-Reply-To: <20200831092946.GA2812764@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 31 Aug 2020 05:29:46 -0400")
Message-ID: <xmqqk0xehj38.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F5D4E40-EBA7-11EA-A024-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It does raise an interesting question, though. I had imagined we would
> limit the depth of all delta chains here, not just ref-deltas. But it is
> true that ofs deltas can't cycle. Without cycles, neither type can go on
> indefinitely (they are limited by the number of entries in the
> packfile). I could see arguments going either way:
>
>   - ofs deltas cannot cycle, so we do not need a counter that limits
>     them (and which _could_ find a false positive). So we should not
>     limit them.
>
>   - a counter is preventing us from following cycles indefinitely, but
>     also hardening us against misbehavior due to bugs or insanely large
>     delta chains (intentional or not). So we should include ofs deltas
>     in our limit.

A chain can have both types, so I am fuzzy how the counting would
go.  We just do not count ofs_delta at all and only count ref_delta
we've seen during the recursion?

> A related point is that delta chains might be composed of both types. If
> we don't differentiate between the two types, then the limit is clearly
> total chain length. If we do, then is the limit the total number of
> ref-deltas found in the current lookup, or is it the number of
> consecutive ref-deltas? I guess it would have to be the former if our
> goal is to catch cycles (since a cycle could include an ofs-delta, as
> long as a ref-delta is the part that forms the loop).

Ah, OK, you've thought about it already.

I wonder we can just count both and limit the chain length to the
total number of objects in the pack we are currently looking at?  It
guarantees to catch any cycle as long as pack is not thin, but is
that too lenient and likely to bust the stack while counting?  On
the other side of the coin, we saw 10000 as a hard-coded limit in
the patch, but do we know 10000 is low enough that most boxes have
no trouble recursing that deep?

Thanks.
