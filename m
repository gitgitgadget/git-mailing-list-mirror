Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59D31F461
	for <e@80x24.org>; Tue, 16 Jul 2019 20:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfGPUIj (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 16:08:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56976 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPUIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 16:08:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A97D66F3D2;
        Tue, 16 Jul 2019 16:08:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LjCM7OQhWmJDD2NtW68ETILPUbg=; b=pSEcZB
        bqkxZS/v/svkPqkPw2l0xw8W/pLOBPFUx0tti1kQrdlBjVIhZA0EwK5/VBumemKs
        rSDTUgyxIVJ3tEQEnlfnwMf9nWFkaayKBNPJdV9jRZ19WHLUE3+g2r7Nwn94Qwfq
        0U3xgZAva+B7TLhkJmzeK3JKXHOePi8qWX3kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P/RrwZ8erwGcGGGaikYBaom/ISmrU3pd
        5wBO+3h/xWy4sAK1JtLcIVSLudU6f7RT5XWfjp34mV8NSFlVD2S1y5Iqknl53w2u
        OW6TzR1XR0tlienGULKDultkl+1HpUzaNFldyRWcO3hQsoxVT8GvCWWzJOAoir9Q
        Afjj0klhmK8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A331C6F3D0;
        Tue, 16 Jul 2019 16:08:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5A526F3CF;
        Tue, 16 Jul 2019 16:08:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Martin Nicolay <m.nicolay@osm-ag.de>, git@vger.kernel.org
Subject: Re: [PATCH] stash: fix handling removed files with --keep-index
References: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
        <20190711174828.GF15477@hank.intra.tgummerer.com>
        <xmqqims8qn8f.fsf@gitster-ct.c.googlers.com>
        <20190716133501.GG15477@hank.intra.tgummerer.com>
Date:   Tue, 16 Jul 2019 13:08:32 -0700
In-Reply-To: <20190716133501.GG15477@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 16 Jul 2019 14:35:01 +0100")
Message-ID: <xmqqblxt3fpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DB683FA-A805-11E9-80BF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 07/11, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> > Fix that behaviour by using 'git restore' which can faithfully restore
>> > the index and working tree.  This also simplifies the code.
>> 
>> Hmph.  I would have preferred to see we stayed away from 'restore'
>> (and used 'checkout' instead, if you must use a Porcelain command),
>> so that the "fix" can go to maintenance tracks, if distro packagers
>> choose to backport it.
>
> Fair enough.  I thought this wouldn't even go to 'maint', since the
> bug exists since a while, so 'git restore' would be fine, but didn't
> think of distro packagers.  I'm happy to use 'checkout' here instead.  

As long as the "--no-overlay" option is used, it is not much better.
Backporting the fix goes only back to 2.22 and no earlier.
