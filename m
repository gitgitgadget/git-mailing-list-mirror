Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC36B207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbcJLQYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:24:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55912 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753736AbcJLQYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:24:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D492543DEC;
        Wed, 12 Oct 2016 12:24:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OIsgrOoWr3KDnbAKhkw75IIeDaA=; b=PaTSCi
        J74nff0XwtfXn52A0yibbfnCNolYZaPJng27mjKdfWIe4dst6Glda06weYiQrguD
        e7CNWE5P0bSal75/UiqaRObfzYVXH7NTM1FLJ/pl20H6OW22KHPt0yRSi9KYs90x
        7j42FCfYmbWaeyEvrekrYDZDOAjGH6oMHEvZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FU4ox86CTuszMGirhV1M/dQpiKEtR7b7
        m6Mf5pVBvK9GvHPpQxxs6rjZy/Lr8D997Vbm6PVpIHXxiUVxhqb5ZWFVEw5X6Tg/
        ayjPeKt/i2C01YJe6vdT8hkFwykcBuTcB4qBv4WHm+U3+mRBea4vsGodNuXCKO/z
        agL2pcqhnWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBBD343DE9;
        Wed, 12 Oct 2016 12:24:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4416743DE7;
        Wed, 12 Oct 2016 12:24:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 12/25] sequencer: remember the onelines when parsing the todo file
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <f22bdcda3f748813e6b9fd08dc65f11c6f9f4b1e.1476120229.git.johannes.schindelin@gmx.de>
        <xmqq1szmaemr.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610121347361.3492@virtualbox>
Date:   Wed, 12 Oct 2016 09:24:47 -0700
In-Reply-To: <alpine.DEB.2.20.1610121347361.3492@virtualbox> (Johannes
        Schindelin's message of "Wed, 12 Oct 2016 13:49:27 +0200 (CEST)")
Message-ID: <xmqqbmyp5ycw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6574AB00-9098-11E6-B5AC-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	const char *arg;
>> > +	int arg_len;
>> >  	size_t offset_in_buf;
>> 
>> micronit: you can make it to size_t and lose the cast below, no?
>
> No. The primary users of arg_len call a printf() style function with %.*s,
> expecting an int. So your suggestion would lose one cast, but introduce at
> least four casts in return.

Actually my point was not the number of casts required, but more
about using the correct type to store things.  Granted, I do not
expect each of the lines would ever get too long to exceed "int"
(but fit in "size_t") in practice, and from that point of view, one
may be able to argue that "int" and "size_t" are both correct types,
but that argument applies equally to offset_in_buf, so...


