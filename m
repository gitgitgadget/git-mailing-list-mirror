Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD76C3B1BF
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 23:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ABB208C3
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 23:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MwJqH4hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBPXg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 18:36:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51524 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgBPXg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 18:36:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B550AE2BE;
        Sun, 16 Feb 2020 18:36:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v15SbXKO4gbba2DzyInEKslYK1g=; b=MwJqH4
        hOZMClyIHS7fhwe3XyBQOud1qHKwHtoBIf6zs1/efhFaP3lULBAx+nW4W97JE0MR
        NPLIbaxXFzQmUBmyzge+cmqxLy4Dfm0B+n9jMp8P/RxjTGAtQmtTHplKTzHneM5c
        MqzyzG7JH4+FOb8QuWeOdBqtcJsVkG6L6FLQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IyJjJnbDJ+kezxRpPmIe/eLIPUlYJOLh
        /NJ7oX2HUsF1Ngviu01jlw/O7zGTFYizAEFsDgtHoNJNA3V1GIGfu91wI2ibsRnJ
        ccVuBwg8Ims/P6XLtlhWPP5Wcv5dkwQjNMss2BirMd/UOlHbZd3+PrhrEf91Vta+
        clBe/y5HrBY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2310EAE2BD;
        Sun, 16 Feb 2020 18:36:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C0B1AE2BC;
        Sun, 16 Feb 2020 18:36:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 07/15] rev-list: allow bitmaps when counting objects
References: <20200214182147.GA654525@coredump.intra.peff.net>
        <20200214182222.GG150965@coredump.intra.peff.net>
        <20200215004555.GB15192@syl.local>
        <20200215065500.GC1633703@coredump.intra.peff.net>
Date:   Sun, 16 Feb 2020 15:36:53 -0800
In-Reply-To: <20200215065500.GC1633703@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 15 Feb 2020 01:55:00 -0500")
Message-ID: <xmqqsgjam7e2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 375DD05C-5115-11EA-884D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > +	uint32_t commit_count = 0,
>> > +		 tag_count = 0,
>> > +		 tree_count = 0,
>> > +		 blob_count = 0;
>> 
>> Hmm, I don't usually see the comma-separated declaration/initialization
>> in git.git. Is there a reason you did it here? Not that I really mind
>> one way or the other, just interested.
>
> The variables are all related, and all should have the same type. I'd
> complain about a patch that did:
>
>   int ret, count;
>
> because there's no logical reason those two variables have the same
> type. They just happen to. And putting them both on the same line is
> even worse, because it makes a diff changing one of them noisy.
>
> But in the code quoted above, if one of them changes, they would all
> (presumably) change. So I think it communicates something to group them
> like this.

I often apply exactly the same criteria as above to my code and
review---since it is not just you (or me), perhaps CodingGuideline
can help other readers, but I am OK to delay documenting it until we
find the third person who has been applying this rule that has not
been spelt out explicitly ;-)
