Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCF91F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfEPBun (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:50:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60335 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEPBnI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 21:43:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4525971732;
        Wed, 15 May 2019 21:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2eTZWjrKexUbIkekffuKlur5tmE=; b=RlxhgO
        7RggmwgeO++N5fwa9iWfM9G06rnx3WEU0KP2V3an2KF2R5EvqlSaAcIuvXXDktVR
        OYdWiMSHVbw4jAon4KGbM9d5CbrAHNuDlElJQQ+yFrtthVkSZ0CW2djLWZYgAiiw
        eBHpamKhgpG3WesVQKoPyojVx385Fd+b1j6pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o17W/ENkZ2bLZLAD+7gpbEfZrCYRQ7rd
        BcFuDrHzqo7RQ6jENy4Ag8NZTORodHHPnQ34w492T2V9WhIT7CuGi7eLz/aD8UbW
        N/UG7h5fM/UG1XWbSS1EXaTYoh/nhskxiYM/yDxNKOM0pHu95Vjrgyq3DUt6NveM
        8hiajRiTGVA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E4E971731;
        Wed, 15 May 2019 21:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68DC471730;
        Wed, 15 May 2019 21:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
References: <cover.1557868134.git.jonathantanmy@google.com>
        <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
        <20190515231617.GA1395@sigill.intra.peff.net>
Date:   Thu, 16 May 2019 10:43:03 +0900
In-Reply-To: <20190515231617.GA1395@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 15 May 2019 19:16:18 -0400")
Message-ID: <xmqqk1er5g48.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F314F718-777B-11E9-982C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that the current implementation (and probably any sane
> implementation) would not send us a delta if we have not provided any
> haves. But this does mean that a malicious server could send a client
> into an infinite loop.
>
> Pretty unlikely, but should we put some kind of circuit-breaker into the
> client to ensure this?

That's a pretty good point.  Would it be suffice to have a new
option to tell index-pack that fattens a thin pack and unpack-objects
that expands objects in a small incoming packfile into loose objects
that they are forbidden from on-demand fatching during this invocation,
as it is an error for the packfile they are digesting to depend on a
lazy objects?

> I dunno. Maybe we should just ignore it. It's a fundamental issue with
> partial clones that we're going to have to fetch extra junk here anyway,

Would it be an option not to ask for a thin pack in the first place?

> If we're willing to modify the format, one thing we _could_ do is have
> the server communicate the expectations for each base. I.e., introduce a
> new THIN_DELTA type that behaves exactly as a REF_DELTA, but with the
> extra 1-bit of knowledge that the server knows it is not including the
> base in the pack. I'm not sure how painful that retro-fitting would be.
> It would need at least a new capability and options to pack-objects and
> index-pack. We might be tight on bits in the packfile type field.

The type field is tight, but I wonder how much such a new
representation would help.  Unless the receiving end blindly trusts
what the sender says, there needs to be a logic to detect cyclic
dependencies while following such a delta chain to lazy-fill
promised objects on the receiving end anyway, no?

