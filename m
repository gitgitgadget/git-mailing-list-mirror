Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B268DC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568152067D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLDmmfkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgKXUL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:11:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55073 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgKXULz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:11:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5F0F9BB52;
        Tue, 24 Nov 2020 15:11:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjod+Acj3elwASLXSqmKsZEjbqk=; b=SLDmmf
        kv/917sRAry2xiNgj0TY+INhrkI5YGYhMs8X7b9rik8QF5dUhl/HbbYhmUgSjST5
        8Dz4PuidnHUirFJXniIER94a/am+h/CcwwcEZbdgqYOfEt9htS484fKluF/z86lh
        XpAPLnCCcm0pfI1puc8pZ9MDz+qXyRUBIyMy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OSyQMiqs2y8MznFwofH53RrOcgUFOGU0
        UJrSvOTQAK/HVDbALRQwD0erRPIPRy7Lr8zP025i7/ZDiG8iyH+T7xwz76Dscs+8
        h+hTM2umh7TXc0NkGG9fU5ha9gpf9gul78dK723cyanhAhoghKOdqoHi9mBLqYGe
        aSAVz8a3N+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD2B09BB51;
        Tue, 24 Nov 2020 15:11:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D6DE9BB50;
        Tue, 24 Nov 2020 15:11:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 07/23] ewah: make bitmap growth less aggressive
References: <cover.1605123652.git.me@ttaylorr.com>
        <c7db594fae4d0447a55a92e830475d9bc418ae7f.1605123652.git.me@ttaylorr.com>
        <xmqq7dqdqgji.fsf@gitster.c.googlers.com>
        <X7voLUlevHygqFg/@nand.local>
        <X7x3WtCItVGhQ57O@coredump.intra.peff.net>
Date:   Tue, 24 Nov 2020 12:11:52 -0800
In-Reply-To: <X7x3WtCItVGhQ57O@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 23 Nov 2020 22:00:42 -0500")
Message-ID: <xmqqh7pejz07.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B41FE2C-2E91-11EB-A26D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 23, 2020 at 11:49:49AM -0500, Taylor Blau wrote:
>
>> On Sun, Nov 22, 2020 at 12:32:01PM -0800, Junio C Hamano wrote:
>> > Taylor Blau <me@ttaylorr.com> writes:
>> >
>> > >  - a geometric increase in existing size; we'll switch to 3/2 instead of
>> > >    2 here. That's less aggressive and may help avoid fragmenting memory
>> > >    (N + 3N/2 > 9N/4, so old chunks can be reused as we scale up).
>> >
>> > I am sure this is something obvious to bitmap folks, but where does
>> > 9N/4 come from (I get that the left-hand-side of the comparison is
>> > the memory necessary to hold both the old and the new copy while
>> > reallocating the words[] array)?
>> 
>> I thought that I was in the group of "bitmap folks", but since it's not
>> obvious to me either, I guess I'll have to hand in my bitmap folks
>> membership card ;).
>> 
>> Peff: where does 9N/4 come from?
>
> it is not a bitmap thing at all. We are growing a buffer, so if we
> continually multiply it by 3/2, then our sequence of sizes is:
>
>   - before growth: N
>   - after 1 growth: 3N/2
>   - after 2 growths: 9N/4

AH, OK.  I feel stupid not to have thought of this myself X-<.

Thanks.
