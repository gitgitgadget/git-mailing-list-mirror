Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00365C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB0C64F13
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhBXXoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 18:44:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62583 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBXXoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 18:44:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ED19977E5;
        Wed, 24 Feb 2021 18:43:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+yzP6+5rPdktiBmtJE4dIbTiv7M=; b=sol1vN
        Rn3iBNIqNT7pcL5s4iBzMGQtzzGPyXvLwK1iB3fwPO4OLgwSTn3dixwTVUQ5RYHC
        0eR4FF6sRoFI9iMh03pDd8eKOfarAPdIBPwADAeyllaGw2pyjJrc91DDvP1/92rl
        fJYhvyqbQaVSc9bHNXyopRTPZlT6BM4p3AoHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tgRW9irUqwB82Z13mDVFbtzUwfgI/lZ+
        SmG9CQXo368Vy9LJ4fzqPJ3u6BlwGaMaUq/TRXOzEkBAFp4i4C05HkB8tZ0iN19j
        cZvbnZJQlBeQv8VA1ydfnIbw9cbZk4OqP4+VMN61oF/CiuXc1U91CeU113Fgvf65
        iTNdjgKXnxU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D852977E2;
        Wed, 24 Feb 2021 18:43:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78A6F977E1;
        Wed, 24 Feb 2021 18:43:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v4 8/8] builtin/repack.c: add '--geometric' option
References: <cover.1611098616.git.me@ttaylorr.com>
        <cover.1614047097.git.me@ttaylorr.com>
        <51f57d5da23244ebde27ad6c14cbf4b63da3317d.1614047097.git.me@ttaylorr.com>
        <xmqqv9ahxddp.fsf@gitster.g>
Date:   Wed, 24 Feb 2021 15:43:34 -0800
In-Reply-To: <xmqqv9ahxddp.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        24 Feb 2021 15:19:30 -0800")
Message-ID: <xmqqo8g9xc9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C644766-76FA-11EB-A128-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Let me try to follow aloud to see if I got this right.
>
> If we start from 1+1+1+2+4+32+... (similarly to the example given to
> explain 2 above, but with more larger packs---but the assumption
> here is that everything larger than 32 is already in good
> progression), depending on how many loose objects we have, the
> result of packing 1+1+1+2+4+loose might not necessarily be 9 but 100
> (collecting too many loose objects), and the set of packs would be
> 32+... (from before the "repack -g") plus a 100-object pack, not
> 9+32+... as the above explanation for 2 suggested.  Starting from
> that state, re-running "repack -g" again would then have to repack
> the packs existed before the first repack (i.e. 32+...) into one.
> In other words, the second "git repack -g" in back-to-back "git
> repack -g && git repack -g" may necessarily be a no-op.

"... may not necessarily be a no-op" is what I should have typed here.

> Is that what you meant by non-idempotent?

And I think it makes sense for the repack to be non-idempotent.
Once we have packs in good progression, it is the only way to make
progress by keep rolling loose objects up into the smallest pack
until it grows larger than the geometry factor allows it to be
relative to the next smallest pack.

