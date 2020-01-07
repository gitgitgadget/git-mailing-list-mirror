Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E281C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98FC2080A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jY61NR53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgAGTVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:21:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55907 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTVH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:21:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C32EC97AB8;
        Tue,  7 Jan 2020 14:21:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lzTlZGKSzcS47B5m9UdL+Bdae0g=; b=jY61NR
        53Ww3VB33toeQFgbzeyFbTbkh6b22+PNZRFf4kfcmFW/xz97EZWiQBLtX5YgMIB6
        oZnCqWhmDl0o1aQUEw4ePcEjafokU40/VvKi+PP45r+6ER738pFDPwnfqazf1tU2
        UP76M1IrZ1ksRUjYDgaleEGh70DwPuj5reeLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tp4sP0Zo5fWo+ZBLMpp8exh7gau993tQ
        KubUIyj65vPbkwsvHj8PQ+wU6e9Wo27MwPq00AG9AmFNgdaxs1fWORWyTrODy5DN
        AullLx/9Zx/EzUzH31iuM1LCDuKfRhTM7jHGH/GBl7LSc4TlJZ6K67xfoYYajwNk
        83NKoEeUm+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAF2A97AB5;
        Tue,  7 Jan 2020 14:21:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC00097AB4;
        Tue,  7 Jan 2020 14:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] graph: fix case that hit assert()
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
        <65186f3ded251e0bcf1fcb18160163a3efd97c37.1578408947.git.gitgitgadget@gmail.com>
        <20200107153006.GA20591@coredump.intra.peff.net>
Date:   Tue, 07 Jan 2020 11:21:00 -0800
In-Reply-To: <20200107153006.GA20591@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 7 Jan 2020 10:30:06 -0500")
Message-ID: <xmqqblrf5azn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D817DFAE-3182-11EA-9CAD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Second, the horizontal lines in that first line drop their coloring.
>> This is due to a use of graph_line_addch() instead of
>> graph_line_write_column(). Using a ternary operator to pick the
>> character is nice for compact code, but we actually need a column
>> to provide the color.
>
> It seems like this is a totally separate bug, and could be its own
> commit?

I think so.

And with that removed, all that remains would be a removal of the
assert() plus an additional test?

>> +test_expect_success 'log --graph with multiple tips' '
>
> This nicely covers the assert() problem. Could we check the same case
> with "--color" and test_decode_color to check the coloring issue (see
> t4214 for some prior art)?

