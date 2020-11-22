Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D540DC5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 20:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE9A20776
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 20:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oLONWcyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgKVUcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 15:32:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgKVUcE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 15:32:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B140D9B289;
        Sun, 22 Nov 2020 15:32:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7FnyBr/UZXD77WCqi+jz1LxJba8=; b=oLONWc
        yAGBgTnAtnNIz2d24nrDgqtAl0Zea/V3ncmHGTOpTEiIlaAduY8PnC+Kdxj87MUZ
        7vYFaTeHWp/ZG40noySrHlOCB/AkRCuLtU1a+59quFNTp9j8Meu09nO/wFv/JC1K
        zuSbyFJwbQKhOYEtLytbxEfwfzZ6Slg9ACMAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PdhYQitdOf6qnnegp595B9ApE7vUj6xb
        x6Rw3ehoxHrdAaEOxszhfhGI98pK6fPzZpKrI+JebyzDS7ERW2GIftTrv1nr9cRM
        qrxuVP4CD96e8cNBZZvxudBTUtrJmoLhPAm0Zk03bJCgXzxa4kZpXsAWGscUpzhH
        fxVbfBJhN8c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9ACF9B288;
        Sun, 22 Nov 2020 15:32:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3391C9B287;
        Sun, 22 Nov 2020 15:32:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 07/23] ewah: make bitmap growth less aggressive
References: <cover.1605123652.git.me@ttaylorr.com>
        <c7db594fae4d0447a55a92e830475d9bc418ae7f.1605123652.git.me@ttaylorr.com>
Date:   Sun, 22 Nov 2020 12:32:01 -0800
In-Reply-To: <c7db594fae4d0447a55a92e830475d9bc418ae7f.1605123652.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 11 Nov 2020 14:42:58 -0500")
Message-ID: <xmqq7dqdqgji.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7075C1E-2D01-11EB-AB17-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  - a geometric increase in existing size; we'll switch to 3/2 instead of
>    2 here. That's less aggressive and may help avoid fragmenting memory
>    (N + 3N/2 > 9N/4, so old chunks can be reused as we scale up).

I am sure this is something obvious to bitmap folks, but where does
9N/4 come from (I get that the left-hand-side of the comparison is
the memory necessary to hold both the old and the new copy while
reallocating the words[] array)?

Thanks.
