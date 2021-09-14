Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B75C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363F1610A6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbhINFuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:50:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56655 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbhINFup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:50:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 130AF158B45;
        Tue, 14 Sep 2021 01:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o3RhzqQd9aJ/3QASGKnrk3iaViPQXxCcrIsTjY
        4bVkA=; b=a5WZN38KT1abdI94FAZMTjmd/Nz3K4RBDMo7uCTz1YiWxVqkeDHbMX
        JzsLmgLZ4cukO1J4uxa5sDw/dRqCQAb9YUDD95ZF8Cd0hztTHfOtwoA9zjk9+Xap
        at1f5QFiE1+IQKe6/fDopNUoQjWFayt8qpBaa+y/WkoT6JXws3MpY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C1A2158B44;
        Tue, 14 Sep 2021 01:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5AE60158B43;
        Tue, 14 Sep 2021 01:49:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
References: <cover.1631049462.git.me@ttaylorr.com>
        <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
        <xmqqa6khi9ph.fsf@gitster.g> <YT/3BuDa7KfUN/38@nand.local>
        <xmqqpmtbc3o3.fsf@gitster.g>
        <YUAxxPcd7RHC2AH+@coredump.intra.peff.net>
Date:   Mon, 13 Sep 2021 22:49:22 -0700
In-Reply-To: <YUAxxPcd7RHC2AH+@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Sep 2021 01:23:16 -0400")
Message-ID: <xmqqilz34sgt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83F7C394-151F-11EC-9A36-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 13, 2021 at 07:05:32PM -0700, Junio C Hamano wrote:
>
>> Taylor Blau <me@ttaylorr.com> writes:
>> 
>> > Alas, there they are. They are basically no different than having the
>> > name-hash for single pack bitmaps, it's just now we don't throw them
>> > away when generating a MIDX bitmap from a state where the repository
>> > already has a single-pack bitmap.
>> 
>> I actually wasn't expecting any CPU/time difference.
>
> I was, for the same reason we saw an improvement there in ae4f07fbcc
> (pack-bitmap: implement optional name_hash cache, 2013-12-21): without a
> name-hash, we try a bunch of fruitless deltas before we find a decent
> one.

Nice.  We learn new things every once in a while ;-)

>> I hope that we are talking about the same name-hash, which is used
>> to sort the blobs so that when pack-objects try to find a good delta
>> base, the blobs from the same path will sit close to each other and
>> hopefully fit in the pack window.
>
> Yes, exactly. We spend less time finding the good ones if the likely
> candidates are close together. We may _also_ find better ones overall,
> depending on the number of candidates and the window size.

It is a pleasant surprise that in a real history like linux.git we
can even find good delta base without the name hash (unless we are
using insanely wide window size, that is).  The objects in such a
case will be sorted solely by size, larger to smaller, and we need
to find a good delta base within that window.  It may not be as
horrible as fast-import (which only tries to delta against the
previous single object), but with ~70k paths in a single revision
with history that is ~1m deep, I was pessimistic to see a size-only
sort to drop even a pair of blobs from the same path within the
default window size of 10.  But it seems that such a pessimism is
unwarranted, which is a good news ;-).
