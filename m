Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE0C433E9
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D30122CA1
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391067AbhAKTY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 14:24:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65189 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391053AbhAKTY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 14:24:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D616122489;
        Mon, 11 Jan 2021 14:24:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eq8HsjZHOAnYkyQLXRLXSaDYncY=; b=S6YY4+
        UB6yNAngphgtz1xar5lmj1R41heTqXE8H+d1wXyAew9JFGg54KiXgWSnubMnIwHj
        wWV/knuJeSlISbL+7F0FKu3JW7RYiCOXHRIk7sRaHb1MXDe0O/EhMwRC8cS2ZRm2
        8z+Yxmgcyi8v34Xa6YBYwLvv+UxUBpI/szpHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a0M93dzWa1YxEEuz5cv8w9fbqqNj1Ead
        mXAyxGh0a50deCdfosi1iQl4nDPFGVIrUDGXH+YzaiSzYK53+UMmBMOlNm0Gc844
        u3FStNwfW3kb+GDBd2Bv/WesCiURjWhka0vdVBKHmN4ltWFB0+yUwTqvacX2bxYc
        Cf2e2zAmWRE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15865122488;
        Mon, 11 Jan 2021 14:24:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60016122486;
        Mon, 11 Jan 2021 14:24:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/4] fetch: extract writing to FETCH_HEAD
References: <cover.1610027375.git.ps@pks.im> <cover.1610107599.git.ps@pks.im>
        <d80dbc5a9c9520621651541e418ee5216d164053.1610107599.git.ps@pks.im>
        <xmqqmtxjgfq6.fsf@gitster.c.googlers.com> <X/wnxSn4KjQF0/T+@ncase>
Date:   Mon, 11 Jan 2021 11:24:09 -0800
In-Reply-To: <X/wnxSn4KjQF0/T+@ncase> (Patrick Steinhardt's message of "Mon,
        11 Jan 2021 11:26:13 +0100")
Message-ID: <xmqqa6tf8eg6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95489CE8-5442-11EB-85F8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> As an abstraction, it may be better to make the caller pass a
>> boolean "is this for merge?" and keep the knowledge of what exact
>> string is used for merge_status_marker to this function, instead of
>> letting the caller passing it as a parameter in the string form.
>> After all, we never allow anything other than an empty string or a
>> fixed "not-for-merge" string in that place in the file format.
>> [Nit #2]
>
> I think it's even nicer to just pass in `rm->fetch_head_status`
> directly, which allows us to move below switch into `append_fetch_head`.

OK.  That may even be better.

Thanks.
