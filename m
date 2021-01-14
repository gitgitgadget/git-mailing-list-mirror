Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E68C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3144C22A84
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbhANUsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:48:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50422 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbhANUsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:48:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64E3710FBF1;
        Thu, 14 Jan 2021 15:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iiWPJZs3aT4PN5wZKsvGkbhpbnw=; b=wCyOag
        fIAADKhMFVIZJ1RtmjWVYztEB6RFYIyFOryOP7gPSsVrY+aMiVmlVwy/tgFNtvKn
        Ak6xWkSxFrMYFspLUCtz+LdvE76GKhySFZ2FUhj03LXcqDzJxoxfX6mIqr0132OW
        xRzz31EP9Z32qpYJC2lo0kp7ohHn02TUSjL1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aXP+p6coyT7OdxhayGkVWgt8Dii5YhRk
        CUsn1XyJpyu+VZHc9Mch9Etqg2rs1FFZn8Ah0oizRoGhs22exdrz7p+6zqlTMFY5
        zJ8o+auGf76rRoA0KHaVBvHoF4al/oFp2IIEjLnGifqB70rND9Y67884JmGBMDVG
        23p66INsC6w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D68210FBF0;
        Thu, 14 Jan 2021 15:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A615D10FBEF;
        Thu, 14 Jan 2021 15:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 01/20] pack-revindex: introduce a new API
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <e1aa89244ad3edb52aaeb28d6934cb2b0a0dc65a.1610576604.git.me@ttaylorr.com>
        <xmqq1reoypzy.fsf@gitster.c.googlers.com>
        <YAB6DNk4wPBVbGtU@nand.local>
        <YACZLHm4NtrM3POZ@coredump.intra.peff.net>
Date:   Thu, 14 Jan 2021 12:47:31 -0800
In-Reply-To: <YACZLHm4NtrM3POZ@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 14 Jan 2021 14:19:08 -0500")
Message-ID: <xmqq35z3xn30.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B985F66E-56A9-11EB-A93F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 14, 2021 at 12:06:20PM -0500, Taylor Blau wrote:
>
>> > > + * This function runs in time O(log N) with the number of objects in the pack.
>> >
>> > Is it a good idea to commit to such performance characteristics as a
>> > promise to callers like this (the comment applies to all three
>> > functions)?
>> >
>> > It depends on how a developer is helped by this comment when
>> > deciding whether to use this function, or find other ways, to
>> > implement what s/he wants to do.
>> 
>> I don't mind it. If they all had the same performance characteristics, I
>> wouldn't be for it, but since they don't, I think that it's good to
>> know. Peff suggested this back in [1].
>
> Yeah, I asked for this. As somebody who has frequently worked on the
> code which accesses the revindex (mostly bitmap stuff), I found it
> useful to understand how expensive the operations were.  However, I also
> know what their runtimes are at this point, and it is not like somebody
> interested cannot look at the implementation. So it may not be that
> important.
>
> So I do still think it is useful, but if somebody feels strongly against
> it, I don't mind it being removed.

That won't be me.  It's not like you'd use pack_pos_to_index()
combined with pack_pos_to_offset() instead of offset_to_pack_pos()
because the latter is more expensive than using the other two
functions; the comment does not help those who want to know relative
performance of these functions for such a purpose.

I was just curious who the comments were meant to help, that's all.

Thanks.
