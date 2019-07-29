Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B288B1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 16:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfG2QXY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 12:23:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58975 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfG2QXY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 12:23:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85A3F15A923;
        Mon, 29 Jul 2019 12:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2F+Tt/2R/Z2b
        uWjV+bA5dQBuTTM=; b=mGJBtL1+cjvDay6SGAzVkTLaItyNhz1whlC74l8u5t8F
        9u0AcHtg869lNCT+EF/wHpFqOa+S80OXn/iNg+pkUtkYgjOtkB1q+6M/LDiBM9bx
        QbX50kV+FxUmh5kRfW0ofMWNnqFeQcfdP5+hX/c0qeK3wMTb/PM272nYPR+2lkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sgXdsn
        4Wq8E55hPcw9Jd4B7RmV6NvzJbIRl8TPkvWcvtDdKBuURO2CLejP8boRSLO7bY1J
        3CY1gxS9sYcT4+4Bt4yZrsMTieyhpbO/WngfEUt0ovCsnSJWN9sBHy0uOIjvE/Ch
        mLOFRAp060+vKsrTHNFIUUhqZ4Asjz4ISQHeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E49B15A922;
        Mon, 29 Jul 2019 12:23:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E879115A920;
        Mon, 29 Jul 2019 12:23:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/8] grep: consistently use "p->fixed" in compile_regexp()
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-5-avarab@gmail.com>
        <CAPUEspgay3RnLH3pdEWyktgn8XeuiKZ8PYPNB_38gyxffmh5Jw@mail.gmail.com>
        <871ry96wiq.fsf@evledraar.gmail.com>
        <87zhkx5hlj.fsf@evledraar.gmail.com>
Date:   Mon, 29 Jul 2019 09:23:20 -0700
In-Reply-To: <87zhkx5hlj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 29 Jul 2019 11:13:12 +0200")
Message-ID: <xmqqlfwgvmh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2EC0859E-B21D-11E9-B776-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> The reason we ignore the user's choice here is because you might
>> e.g. set grep.patternType=3Dextended in your config, and you'd still w=
ant
>> grepping for a fixed "foo" to be fast.
>
> ...and more generally, for any future sanity of implementation and
> maintenance I think we should only make the promise that we support
> certain syntax & semantics, not that the -F, -G, -E, -P options are
> guaranteed to dispatch to a given codepath.
>
> Internally we should be free to switch between those, so e.g. if a
> pattern is fixed and you configure "basic" regexp, but we know your C
> library is faster for those matches with REG_EXTENDED we should just
> pass that regardless of -G or -E.

That certainly is a very sensible goal.

> I'm just saying that the presence of those bugs means we should be
> inclined to fix them / back out certain changes, not work around them
> with user-servicable knobs.

Amen.
