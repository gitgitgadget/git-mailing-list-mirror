Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C7AC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE9661361
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhGMVnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:43:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56152 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhGMVnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:43:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EBCC1564EF;
        Tue, 13 Jul 2021 17:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cwn8ji/rB5rOIkR1GN5tDD1aXv/19JLqPcJZ38
        Fd0UA=; b=DA3kxb6JQjDgWHDQWeUENlmpOoLNgesq+rTIJ7EYz6Li5s8iMnHLY6
        Ynx+ezDIAeVW52PQROvy+xw30C0+P1+Da/SURyo+PxwdnOn1fpGWTWAYfDhcPtw1
        1n2LlCUIlRLTtbL0d//GYaocTA/ZnT41YHtNt4hkZguvbugFsVQO4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 772481564ED;
        Tue, 13 Jul 2021 17:40:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EFF391564E9;
        Tue, 13 Jul 2021 17:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
        <20210713074018.232372-1-martin.agren@gmail.com>
        <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
        <xmqqpmvl29ry.fsf@gitster.g>
        <YO4FObgRvpt1nVr0@coredump.intra.peff.net>
Date:   Tue, 13 Jul 2021 14:40:08 -0700
In-Reply-To: <YO4FObgRvpt1nVr0@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Jul 2021 17:27:21 -0400")
Message-ID: <xmqqlf6928qv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5C72836-E422-11EB-B4A5-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Puzzled.
>
> ...and the answer is that we don't need to parse it. The tag object
> mentions the type of what it points to, and we use lookup_commit(), etc,
> to create the object pointed to by its "tagged" field.

Ahh, parse_object() on the outer tag, when instantiating the in-core
obj, allocated an in-core object and that instance is already given
a type from the tag object and .taggeed member points at that
object, so it is not an "unknown" object (tag.c::parse_tag_buffer()).

Totally forgot about that one; thanks.


