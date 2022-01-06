Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E743C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbiAFW12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:27:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61056 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244638AbiAFW12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:27:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87B7D1095DC;
        Thu,  6 Jan 2022 17:27:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gKm56gKaU2NK
        2OkDEHNTj2LPZu+K+75t8wXLTvTjNk8=; b=RPY/tWBCTnxoy+oBi7fkCZmEjzbS
        DSC26XE2vDL08RIkvrCNsair84heUIXouvTScwoS07JM7gwZUa8oeM8yqayu5UwP
        nyPl2xzaTbsrI/oCmJ/mTRaWkFUr8m1pYsiqNIX/L9bsL31AASUotRSv0f6Tapaf
        8vHIN/irSWwcXjE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 752C01095DB;
        Thu,  6 Jan 2022 17:27:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1EAC1095DA;
        Thu,  6 Jan 2022 17:27:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
        <YddjJ+uIQM34Gedo@nand.local>
Date:   Thu, 06 Jan 2022 14:27:25 -0800
In-Reply-To: <YddjJ+uIQM34Gedo@nand.local> (Taylor Blau's message of "Thu, 6
        Jan 2022 16:46:15 -0500")
Message-ID: <xmqqh7agbiuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3CE9378-6F3F-11EC-8DBC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> (+cc Ren=C3=A9 as another possible reviewer)
>
> On Wed, Jan 05, 2022 at 01:23:24PM +0000, Jessica Clarke wrote:
>> Currently git_qsort_s allocates a buffer on the stack that has no
>> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
>> alignment for any type.
>>
>> On CHERI, and thus Arm's Morello prototype, pointers are implemented a=
s
>> hardware capabilities which, as well as having a normal integer addres=
s,
>> have additional bounds, permissions and other metadata in a second wor=
d,
>> so on a 64-bit architecture they are 128-bit quantities, including the=
ir
>> alignment requirements. Despite being 128-bit, their integer component
>> is still only a 64-bit field, so uintmax_t remains 64-bit, and therefo=
re
>> uintmax_t does not sufficiently align an allocation.

Alignment aside, if uintmax_t is 64-bit but your pointer needs
128-bit to store, saving a pointer value in uintmax_t variable would
not work correctly, I presume, as casting the 64-bit integral type
back into pointer would not be sufficient to recover the lost
information that used to be in the second word.

So, does the architecture have 128-bit uintptr_t and that is a safe
type both from the point of view of alignment and from the point of
view of not losing information? =20

If that type is larger than uintmax_t, something smells wrong,
though.  max is not max anymore at that point.

IIRC, uintptr_t is optional in C99, so a simpler solution to use the
larger type between uintptr_t and uintmax_t as a replacement for how
we use uintmax_t would not quite work out of the box X-<.
