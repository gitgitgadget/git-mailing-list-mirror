Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4DC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F5F20715
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HXJjnvRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgERSo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:44:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62854 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgERSo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:44:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A939631EB;
        Mon, 18 May 2020 14:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xTy1V/BgOx7MwJoRCA6NiKt9V2s=; b=HXJjnv
        RsMTLWTOWuUgEmLsGYIAFJLDS0v8dvWRMn+myv+BG2vrJVKMBlNW6F8l10LCi1eB
        Xtc464eoB0NtzB9uIT3qbN8EZE0xMQslTPBT09CVBp8YdZOfqgzQFMniVFcsZJ16
        U4l8LzxbsSfQw0HnKxrM0G8BuPymsuQVk/Js0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cl3aYPV2WkHzEsj4UPFgXPFx2J2+05L/
        MPEqcjcsWVVCOZGebZk3XAcmcoaYvNeWYIQh6Hg/xeRBHuHckNH3vB1/4Ga3cbFT
        LaFJWf3U/uCLo8v+uor9iucGIWYUPxTDkO8+8ftqzdVdFmZCQyr2mj2vWASxfyi2
        fNIrk7A3dSw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 617EF631E9;
        Mon, 18 May 2020 14:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7EFF631E8;
        Mon, 18 May 2020 14:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/7] pkt-line: extern packet_length()
References: <cover.1589393036.git.liu.denton@gmail.com>
        <cover.1589816718.git.liu.denton@gmail.com>
        <c2b9d033bb774d3bccb572802c3ae114cad8d830.1589816719.git.liu.denton@gmail.com>
        <20200518160425.GA42240@coredump.intra.peff.net>
Date:   Mon, 18 May 2020 11:44:25 -0700
In-Reply-To: <20200518160425.GA42240@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 18 May 2020 12:04:25 -0400")
Message-ID: <xmqqlflp2id2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 990F4122-9937-11EA-B7CC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +/*
>> + * Convert a four hex digit packet line length header into its numeric
>> + * representation. linelen should not be null-terminated.
>
> Minor nit, but it is perfectly fine if there is a NUL. Maybe "linelen
> does not need to be..."?

Yup, I was wondering about the same thing.  I actually would go
stronger than "does not need to be", as the byte after these four
would never be taken as "the terminator for the linelen bytes", even
it happens to be '\0'.

Just getting rid of the extra sentence would suffice for that, I
think.  The first sentence makes it clear that it is about
interpreting the 4 bytes we are given, and those 4 bytes come from
the 'packet line length header' the caller has.

