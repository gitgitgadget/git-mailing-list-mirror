Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF51C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E35320784
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 17:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wsoecxc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411096AbgDORaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:30:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55042 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411089AbgDORaR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 13:30:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1A4E4A46C;
        Wed, 15 Apr 2020 13:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HEOgga/0FqKqU4Jkg9pqSKBFLlo=; b=wsoecx
        c0jUjIynh1/WCBDi6Rp5r9bgEd4BZGB9iD6APMIl7fukydNht2d4alQpSnUVa1ZL
        r1JWRr118hbnXEx8hEerLkmnIjIsyjg+jxlo6qtDsdkNtqbsiMQHOyVrPPRQF3lB
        pp7iJksAp9CPHjSuqRhgB3gyQK69Tloh3hOeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G/lGlO+/RzFdpsOT0aorrWyDXmw/1aYa
        aSxC69z0/PyTLCOq/Pbqvn272vnqZu1jSsNNEbrdRPbETt9fBLGw8TFGzqW64o1G
        kUhVokvSXU/EKKScWVrJXdPZ++FuCr+CPuVrqtceHV4EwjqP00NLZkdCCHKzyfVR
        e2idfwP0Reo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98FFF4A46B;
        Wed, 15 Apr 2020 13:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29D854A46A;
        Wed, 15 Apr 2020 13:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     luciano.rocha@booking.com, git@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/1] freshen_file(): use NULL `times' for implicit current-time
References: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
        <20200414195535.GA1879302@coredump.intra.peff.net>
        <20200415090906.wudutxpiyw7ooas6@C02Z11TTLVDN.corpad.adbkng.com>
        <20200415160535.GF2464307@coredump.intra.peff.net>
Date:   Wed, 15 Apr 2020 10:30:14 -0700
In-Reply-To: <20200415160535.GF2464307@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 15 Apr 2020 12:05:35 -0400")
Message-ID: <xmqq7dyg7j2x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4A2164C-7F3E-11EA-8FA0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 15, 2020 at 11:09:06AM +0200, luciano.rocha@booking.com wrote:
>
>> > The old code was setting the time based on the system time from time().
>> > We've occasionally hit cases where the filesystem time and the system
>> > time do not match exactly (this might be true on an NFS mount, for
>> > example).
>> > 
>> > It's not clear to me whether utime(NULL) would be using the system or
>> > filesystem time in such a case. If the former, then there's no change in
>> > behavior. If the latter, I'd argue that it's probably an _improvement_,
>> > since we're simulating the case that we wrote a new file with a new
>> > mtime.
>> 
>> I'm not that familiar with kernel code, so can't say for sure. From a
>> cursory look, it doesn't seem like it uses the remote server's time.
>> 
>> But it does seem to have a higher precision, for filesystems that
>> support it.
>
> Yeah, that's another point in its favor.
>
> It seems pretty clear to me that utime(NULL) should give either the same
> or better behavior in all cases.

Yup, thanks Luciano for the patch and Peff for a (n always) good
review.

