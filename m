Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FACC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 17:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BF16137D
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 17:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhDOR6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:58:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51217 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDOR6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 13:58:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96DF3BFB39;
        Thu, 15 Apr 2021 13:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1rvcCpEKSzSz2H1RhFyVbqCqXX8=; b=Rmt35r
        MQjwjbfxOEveprFfnkQgKGKjFOJ83qEmGCh9k16vdk/DjPmLAP2EpxaEv5R3LCg/
        sWE8wNs0NtdUsmXFNoKDfyfidU3CahKuBg+rzG2mdXDwmQwcbVMR02edXB7P+uxV
        TjBfy7ZMwza1EHthdjci3yMc4kPsq2cHuY4RE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xr6UBdVFY3zCKaB+bdVaucBdgXkCGK/j
        GpfkNBmC/sCyGDfMZ/NpL9GHE9+O3G4Oea8HfmzZbeoDM9Kw0C0znHQKPiAqiI0O
        FHww+qNsdMquF0MOuCY27hXkkBUoIbVpTfDUBI1ob6INWynTjflCRQzxp7pyCB4l
        kKL4S1GOAlw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D34FBFB36;
        Thu, 15 Apr 2021 13:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16759BFB34;
        Thu, 15 Apr 2021 13:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
        <xmqqfsztlwxb.fsf@gitster.g> <YHbZNL0gzw0+1k5h@ncase>
        <xmqqmtu0y3r8.fsf@gitster.g>
        <YHgOCUI++AY/7zwX@coredump.intra.peff.net>
        <xmqqczuvsac6.fsf@gitster.g>
Date:   Thu, 15 Apr 2021 10:57:51 -0700
In-Reply-To: <xmqqczuvsac6.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        15 Apr 2021 10:53:45 -0700")
Message-ID: <xmqq8s5jsa5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19033A78-9E14-11EB-AE15-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  But that leads me to
> wonder into a different direction---coalesce (tag|tree|blob)_objects
> members into a single bit, say all_objects, have "--objects" and
> friends set that single bit, and update places like these to check
> that single bit.

Just to avoid misunderstanding, I am not saying this topic needs to
address any of this unifying of three bits.

It is just an idea for those interested to think about, when they
have nothing better to do, when the codebase is quiescent.
