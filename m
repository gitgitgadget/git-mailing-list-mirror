Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85EC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B954920709
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0jXZZjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgENWRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:17:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59688 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgENWRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 18:17:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6376C687E;
        Thu, 14 May 2020 18:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8mAAhjv8N2kgF1qKwT4iUAQxPNY=; b=k0jXZZ
        jGy/tq4rddjw2P+2gAvxbIyYlJC4h0gAXwndQrj6QzRufKHI/HcgpIAH5/0+DM7Z
        J0Q5jufL+eIT9DCnfEg//bEfoYIsLN6y4K+oVH73WCFCEZV3X0avVS0CEtlyll79
        D4eb1BdcMcelVjbeCpzibRbUgvqjBia3pTHqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RDAjglCeFwtLQ4/Xn7F/+BnYLwwbdf9k
        ALhb2xXTllvHEC7ll64Li5NoVOS9QliboaxWUgt9p0LvyeFu+/F3AY+rMDGslSNf
        CDvDYjCBZWjw8aMv9i5+IKpr/V1oAJY0moX08JcIK6frU3BHfItRJK0nnAVBZ4LO
        eiq1WjZGkhM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADC93C687D;
        Thu, 14 May 2020 18:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F2985C687A;
        Thu, 14 May 2020 18:16:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] unpack-trees: also allow get_progress() to work on a different index
References: <pull.785.git.git.1589486002453.gitgitgadget@gmail.com>
        <xmqq4ksiqnbf.fsf@gitster.c.googlers.com>
        <CABPp-BHM8uS1yxAtjE=Frh_V7JF7-EJ8+47e-cr9TpEMZr4nfw@mail.gmail.com>
Date:   Thu, 14 May 2020 15:16:54 -0700
In-Reply-To: <CABPp-BHM8uS1yxAtjE=Frh_V7JF7-EJ8+47e-cr9TpEMZr4nfw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 14 May 2020 14:46:07 -0700")
Message-ID: <xmqqimgyp3ft.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F19DFF0-9630-11EA-B864-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Do we see these CE_UPDATE|CE_WT_REMOVE bits attached to the cache
>> entries in the o->src_index array when get_progress() is fed the
>> src_index in the first place?
>
> Yes, before calling check_updates(o, o->src_index), update_sparsity()
> loops over o->src_index and calls apply_sparse_checkout() on each of
> the non-conflicted cache entries.  apply_sparse_checkout() will set
> either CE_UPDATE or CE_WT_REMOVE whenever items flip from or to having
> the SKIP_WORKTREE bit set.

Hmph.

I thought that the whole point of splitting o->result from
o->src_index we did long time ago was to allow us to treat
o->src_index constant.  I hope we haven't broken anything by
starting to do things like that X-<.

Anyway, if that is the case, this change won't make things any
worse.  Let's queue it.

Thanks.

