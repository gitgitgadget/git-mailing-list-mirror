Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E01C433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3400B23A34
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbhANUwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:52:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62816 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbhANUwj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:52:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A56F2113506;
        Thu, 14 Jan 2021 15:51:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QmBFYMjy9f/nb7IxFbhMzL2K8Y8=; b=CTJgt0
        EgCFqdfIfnSKK7BEhEC3N/yvS0leTxfWw8wrvSxfBJoKVA6omdQOiWcN3OGmOqoL
        degpTTrxm7cTbucGUggo3gAuVF0iSd6P/ML4QmHpN2u0I/N5kwO2cneg4iKf8YvB
        hODX9QZ0kKMBbDnjQiLnZsmXeG6TneCts0mgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xAnTLoSOe4tY3nnJJ6GmzZjEiyKJ81we
        N6p18buxf8F9EmeqIXs8Y9vtbWgrFPPlMlLcS/7gwt6cXQtiV3dJhM2VuSV56MnQ
        8r1Puh0tYGHUjCPJIMgVQI7dPJcZvyJ6G+3wuh0gRU5EpkWLz81rqZ2XrAuBdaBq
        pYe0VuhgmZA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DEF3113505;
        Thu, 14 Jan 2021 15:51:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA4BE113503;
        Thu, 14 Jan 2021 15:51:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
        <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
        <YACcoNY/SiEbBSgh@coredump.intra.peff.net>
Date:   Thu, 14 Jan 2021 12:51:52 -0800
In-Reply-To: <YACcoNY/SiEbBSgh@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 14 Jan 2021 14:33:52 -0500")
Message-ID: <xmqqv9bzw8bb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55DAA7BC-56AA-11EB-B47F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  	for (i = 0; i < p->num_objects; i++) {
> -		uint32_t pos;
> +		uint32_t index_pos;
> ...
>> *1* The nth_packed_object_id() call we make later using the value we
>> obtain here should be documented to take "index" as its last
>> parameter, now that is what we call the location in the index, which
>> is in object name order.
>
> I would love to see the function given a more descriptive name. Having
> worked on the bitmap code a lot, where the norm is pack-order, saying
> "nth" is confusing and error-prone.
>
> But I think that's out of scope for this series.

Yeah, an explicit index_pos (vs pack_order_pos) would be good names
to use, and nth_packed_object_id() can also use somewhere in its
name to hint that it is about the object name order, but I agree
that both are outside the scope of this series.

Thanks.
