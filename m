Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFEBC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DB820719
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NVTtrgkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgI1SF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:05:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50096 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgI1SF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 14:05:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0E0DED529;
        Mon, 28 Sep 2020 14:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dEEvzIbD2rdt1f+W1+gUDMqxPBc=; b=NVTtrg
        kHzKQQYBWS2bD7ZY3V+rWMSYnB+kXo0e1LuHs61ZN6stc3wO/so5a5IuuMmMmNCM
        HC9TJxR9sYYQMS+e3dqSrhEprDVXG62wZRO3nI14/ZMhbaK609rS6pmeJYXcP9na
        xCLYAxF4I6vxaTJvr8gUtqxw/HMfa4Jtz6XLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mg6GTlK6hEtNXhO7Xh+xrTgPQbIacH9B
        UMTrszo9mvoBfyg0h1lQptTDC2tDZWH8zJs8m/+VD12kXUhMND3/IB4pt5lWdCj9
        stKEgtK1Oo6KuN4YaMntGZ3kj8nPjj9zqbddDy0pgqrswhZXGqLIveSR8zbgmelA
        NUFzsjU7IEg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A90DDED528;
        Mon, 28 Sep 2020 14:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2EA3ED526;
        Mon, 28 Sep 2020 14:05:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com
Subject: Re: [PATCH 1/2] packfile: fix race condition on unpack_entry()
References: <cover.1601311803.git.matheus.bernardino@usp.br>
        <42a7948f94cb57ebd9c37c3850b46b1ac9813ec6.1601311803.git.matheus.bernardino@usp.br>
Date:   Mon, 28 Sep 2020 11:05:52 -0700
In-Reply-To: <42a7948f94cb57ebd9c37c3850b46b1ac9813ec6.1601311803.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Mon, 28 Sep 2020 13:50:34 -0300")
Message-ID: <xmqqpn65n5dr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FF6DF64-01B5-11EB-832D-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> To fix the race condition (and later segmentation fault), let's reorder
> the aforementioned steps so that the lock is not released between 1.
> and 3.

In other words, we hold the base in core only for ourselves without
adding it to the base cache, apply the delta to produce the result
and then place the base in the cache, and the reason why this change
fixes the breakage is because the base we have locally and not in
cache will not be seen by other people and will not be freed without
our consent?  Which does make sense.

But I was confused by the explanation "lock is not released".  We do
release the same lock when we call unpack_compressed_entry(), and
reaquire it before the unpack_compressed_entry() returns.  What the
reordering achieves is to protect the base from getting evicted when
the unlocking and relocing happens, no?

Thanks.
