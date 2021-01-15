Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EAC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689D7238D7
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbhAOUG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:06:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59313 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAOUG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 15:06:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F821104357;
        Fri, 15 Jan 2021 15:06:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pj1UvJ9esUlYSbyEOemIGGxt2XI=; b=otuCwv
        i19Ck/qlkxv/3xUfRZvHqkrsp+/F8aNcpc2bwl0roQ/hSVGioX6WWTCUkpckZfRf
        VuqLZp8JgKn6LXre4/JzpDWcMUVC2eauaDIrdTUhp7RtzFQQe/BzNAGY4vGonn5R
        TXKCEbKTxwTvQ/msG3tm6B9TUGssa3H33xTi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mSL7H+UcxTc3aI844RDS1aZwJrWiKc9H
        QoFnEakvG4tTX2Xng6qYOG59EvA7sU+goEjMbiWLCaMO2eQBKfZYLWXVeFKPlrrE
        uMzAjEi6HlwD8ab3mLLMTNckwWCI/493nCRWsMlpurcAkEU4YLZpi4J+S8nV8nFp
        B3TEWJ2YUBE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48973104355;
        Fri, 15 Jan 2021 15:06:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F37210434C;
        Fri, 15 Jan 2021 15:06:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] use delete_refs when deleting tags or branches
References: <20190814024927.13167-1-phil.hord@gmail.com>
        <CABURp0rtkmo7MSSCVrdNXT0UzV9XqV_kXOGkC23C+_vMENNJUg@mail.gmail.com>
        <CABPp-BEUPH5Yc08uDehAXNQ5-3fJ9YeW0xscVBR45hniDe+HEg@mail.gmail.com>
Date:   Fri, 15 Jan 2021 12:06:11 -0800
In-Reply-To: <CABPp-BEUPH5Yc08uDehAXNQ5-3fJ9YeW0xscVBR45hniDe+HEg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 15 Jan 2021 10:43:07 -0800")
Message-ID: <xmqqh7nirmmk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E47FEB2-576D-11EB-93C2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Overall, I like the patch.  Peff commented on v1 that the basic idea
> (use the part of the refs API that batches operations) is the right
> thing to do.

I concur; I agree with the general direction.

Where do we reject branch deletion based on the merged-ness?  When
we ask to delete three branches and one is not merged yet and cannot
be removed (let's say we are not "--force"ing) but the other two are
OK to remove, we do want the other two branches to go.  I didn't
check what the patch does with respect to this point, but as long as
the updated code does not make it "all or none", it would be great.

> I would say Reviewed-by, but I'd like to get Junio's comments on the
> return code and minor race.

It would have to wait a bit more.  Thanks for a review.
