Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9FDC001DE
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 00:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjG0AtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjG0AtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 20:49:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6D128
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 17:49:04 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 178F8196174;
        Wed, 26 Jul 2023 20:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dNL8YNoQFHrbkeKH+7gM7uKM6JaVPjxa4zqGUb
        SGYrM=; b=WvJ0ZiIPqqoO1iVDJ+imrF39SvxFubW5UQRYXp6VGScb4muNvGivdu
        GARjDFO/UHyjj2mgB5+GZ77pui3veoSfO3l6hBCsY8HYDg3BgI/eWwxYwZBhuN0A
        ujQ1NTlb77xBEAtMpTyKXDBG61XVgSR33iWXIHiJRAWC+g414Nx1k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09029196170;
        Wed, 26 Jul 2023 20:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3AEA419616E;
        Wed, 26 Jul 2023 20:49:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1689889382.git.jonathantanmy@google.com>
        <xmqq8rb2csr1.fsf@gitster.g> <ZMG3kEO0BzKPaG75@nand.local>
Date:   Wed, 26 Jul 2023 17:49:01 -0700
In-Reply-To: <ZMG3kEO0BzKPaG75@nand.local> (Taylor Blau's message of "Wed, 26
        Jul 2023 20:17:20 -0400")
Message-ID: <xmqqzg3ib2ma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61E179E2-2C17-11EE-99E2-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Sorry for not getting to this sooner. I didn't notice anything during my
> review, but I think there may be a bug here.
>
> Suppose that we have an existing commit-graph with v1 Bloom filters. If
> we then try to rewrite that commit-graph using v2 Bloom filters, we
> *should* attempt to recompute the filter from scratch. But AFAICT, that
> isn't what happens.
> ...
> If I'm parsing this all correctly, Git used the v1 filter corresponding
> to that commit, and did not recompute a new one.
>
> I think that this could lead to incorrect results if you use this to
> masquerade a v1 Bloom filter as a v2 one.

That indeed is very bad.  How hard it would be to construct a test
case that fails if filter computed as v1 is marketed as v2?  A test
may be far easier to construct if it does not have to be end-to-end
(e.g. instrument the codepath you followed through with the debugger
with trace2 annotations and see the control takes the right branches
by reading the log).

> So I think we want to be more careful about when we load the existing
> Bloom data or not. I think we probably want to load it in all cases, but
> only read it when we have compatible Bloom settings. That should stop us
> from exhibiting this kind of bug, but it also gives us a handle on
> existing Bloom data if we wanted to copy forward existing results where
> we can.
>
> If all of this tracks, I think that there is a gap in our test coverage
> that didn't catch this earlier.

Yeah, thanks for raising a concern.

Jonathan?
