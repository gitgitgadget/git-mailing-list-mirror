Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5009C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C94661988
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhC2Vaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:30:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52408 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2VaP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:30:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62D64C625B;
        Mon, 29 Mar 2021 17:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a2e/HWwiBzMZpLoqXINCqHGDzhc=; b=Loctku
        qIsRdntr1Wg7lx4pNCahD9GDKQm5O3AnA4pGACihJM5y8qertavcffreoEiUvtEt
        yDfiAOhdTCTxPqBOgfkpbL3i7orkgE4FQ5xDlWUqtvb4dXs/6kT/ZrNi36M9hpUX
        unlBLp9sDadET3gyR/00QBSqSfVp9VbRHvNAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k2USjBquiK1LLVyM2MrEZt7ewzoxdNyO
        +JrzhDqleo4440Fwdc2NrmWzVqMjSzYPT68iEkqy6bLqIjTIJeCqUXK6fs9myt1V
        oq+W4KNYbmbxjMXPqU3olgL5PX463qypY2K3uhvsTuzmUXKWSC72Y7dn5zoVxIYT
        fd48sGSoEAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58FF1C625A;
        Mon, 29 Mar 2021 17:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA3D4C6259;
        Mon, 29 Mar 2021 17:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 00/16] midx: implement a multi-pack reverse index
References: <cover.1612998106.git.me@ttaylorr.com>
        <cover.1615482270.git.me@ttaylorr.com>
        <YGHQnQ9/ulXd+jgu@coredump.intra.peff.net>
Date:   Mon, 29 Mar 2021 14:30:13 -0700
In-Reply-To: <YGHQnQ9/ulXd+jgu@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 29 Mar 2021 09:05:33 -0400")
Message-ID: <xmqqeefxir6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2B1DD8E-90D5-11EB-983A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 11, 2021 at 12:04:31PM -0500, Taylor Blau wrote:
>
>> Here is another reroll of my series to implement a reverse index in
>> preparation for multi-pack reachability bitmaps. The previous version
>> was based on 'ds/chunked-file-api', but that topic has since been merged
>> to 'master'. This series is now built directly on top of 'master'.
>
> I gave the whole thing another careful read. Most of what I found were
> small nits, but enough that I think one more re-roll is worth it.

Thanks.

> The biggest question is what we want to happen next. As you note, the
> concept of a midx .rev file is useless until we have the matching
> .bitmap file. So we _could_ let this sit in next while the dependent
> bitmap topic is reviewed, and then merge them down together. But I'm
> inclined to treat this as an independent topic that can get merged to
> master on its own, since the early cleanups are valuable on their own,
> and the .rev parts at the end, even if dead, won't hurt anything.

It was my impression as well that the early clean-ups are worth on
their own.
