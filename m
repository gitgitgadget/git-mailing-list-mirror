Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2FC07E95
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 00:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6B161CAA
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 00:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGHAXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 20:23:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62109 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGHAXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 20:23:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A78FAD0A8B;
        Wed,  7 Jul 2021 20:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xcf4D3RKPiz4mFBO0R5G130H19Q7VoeQyz1D58
        l/iiQ=; b=wrPnYNcMnma4kwNN/a1mObxhY126gmx1zvn114WVAuftf+NCjeKRtd
        MLk532Ocx7CI/llIn9mG5TkvyTbplop2yRZFMhSUUCxqsX0wowSRaaa5h931d5VR
        oGtki0W/E5At3K5gb9zK5N9TZyxUzRvGGQ/DbVkRSmWWZR2idIKTY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0157D0A8A;
        Wed,  7 Jul 2021 20:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 335C1D0A89;
        Wed,  7 Jul 2021 20:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 1/5] speed up alt_odb_usable() with many alternates
References: <20210629205305.7100-1-e@80x24.org>
        <20210707231019.14738-2-e@80x24.org>
Date:   Wed, 07 Jul 2021 17:20:53 -0700
In-Reply-To: <20210707231019.14738-2-e@80x24.org> (Eric Wong's message of
        "Wed, 7 Jul 2021 23:10:15 +0000")
Message-ID: <xmqq8s2hd5ay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BB5036A-DF82-11EB-90E2-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> With many alternates, the duplicate check in alt_odb_usable()
> wastes many cycles doing repeated fspathcmp() on every existing
> alternate.  Use a khash to speed up lookups by odb->path.
>
> Since the kh_put_* API uses the supplied key without
> duplicating it, we also take advantage of it to replace both
> xstrdup() and strbuf_release() in link_alt_odb_entry() with
> strbuf_detach() to avoid the allocation and copy.
>
> In a test repository with 50K alternates and each of those 50K
> alternates having one alternate each (for a total of 100K total
> alternates); this speeds up lookup of a non-existent blob from
> over 16 minutes to roughly 2.7 seconds on my busy workstation.
>
> Note: all underlying git object directories were small and
> unpacked with only loose objects and no packs.  Having to load
> packs increases times significantly.
>
> v3: Introduce and use fspatheq and fspathhash functions;
>     avoid unnecessary checks for allocation failures already
>     handled by our own *alloc wrappers.

The last one does not belong to the commit log message, as "git log"
readers do not care about and will not have access to v2 and earlier.
