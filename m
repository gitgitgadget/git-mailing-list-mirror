Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D9C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE80B60555
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhHBTlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 15:41:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53040 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBTlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 15:41:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7900BD1407;
        Mon,  2 Aug 2021 15:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t49Q+OoNmwkEz2DN+hA4sTfi9juqo8yAbWwn2S
        gqe6Q=; b=uE/AhkcY/hfFq+W60GEgpASZ6BOTSX+gf+oWMYL1VnZDXF/XCI3hvc
        897aUowPVwCk5Y+bzAUbHwdEqRCd9VTWoPZorUUd9sNstHRiGKVTYZ9x5cCaAL0o
        zisnz5e19HyyqmKoCr2EMwSsiUq7XKOUvPMFQxVCN+HbGirp0NJFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F2B1D1406;
        Mon,  2 Aug 2021 15:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1E0AD1405;
        Mon,  2 Aug 2021 15:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/4] revision: avoid loading object headers multiple
 times
References: <cover.1624858240.git.ps@pks.im> <cover.1627896460.git.ps@pks.im>
        <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
Date:   Mon, 02 Aug 2021 12:40:56 -0700
In-Reply-To: <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 2 Aug 2021 11:38:10 +0200")
Message-ID: <xmqq5ywnws6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E7C30E2-F3C9-11EB-AC38-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When loading references, we try to optimize loading of commits by using
> the commit graph. To do so, we first need to determine whether the
> object actually is a commit or not, which is why we always execute
> `oid_object_info()` first. Like this, we'll unpack the object header of
> each object first.
>
> This pattern can be quite inefficient in case many references point to
> the same commit: if the object didn't end up in the cached objects, then
> we'll repeatedly unpack the same object header, even if we've already
> seen the object before.
> ...
> Assuming that in almost all repositories, most references will point to
> either a tag or a commit, we'd have a modest increase in memory
> consumption of about 12.5% here.

I wonder if we can also say almost all repositories, the majority of
refs point at the same object.  If that holds, this would certainly
be a win, but otherwise, it is not so clear.
