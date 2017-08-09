Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F21E20899
	for <e@80x24.org>; Wed,  9 Aug 2017 05:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdHIFgh (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 01:36:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60346 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752067AbdHIFgg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 01:36:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9497CA90E6;
        Wed,  9 Aug 2017 01:36:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rdI4y2Dg/VyyyeVheC0Olsne0YE=; b=qmI78Y
        hEfyRvA1MbMhZMDMjF1nVaYITwrOzdmnpoZeHim+ruIgMqllcL8kaa5pi+OTbkRE
        k1DkCB4tKUUXa+dsph727eXHVIAJhRaPN3BQ40XefXO2wE6OXFa5OGFR+Ws1prMu
        sP3dWSe2/3/obQBwK4gs4NfvR8SkJKdvrO3Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gBY9QoK1x5jxDXtUtWwahP4jFAgy+c2R
        GhdlmoE/8p08lBDq0VM7QMXd28bzgAOPrfjP7OmLqln1Oa9TxicCPIigOzo4qw+E
        hScoMQimisUR/dUkJhBZF9h6iqUAV+k/YKFkoxVEwsr9TDwLwtYOfum2Y5r7lHsu
        ZOBeOBsbkas=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BE50A90E5;
        Wed,  9 Aug 2017 01:36:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB805A90E4;
        Wed,  9 Aug 2017 01:36:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] sha1_file: avoid comparison if no packed hash matches the first byte
References: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
        <xmqq3791adfi.fsf@gitster.mtv.corp.google.com>
        <20170808225231.3l7gyoxxvghsvtv7@sigill.intra.peff.net>
        <20170808225851.kgbyrlqrtlurzc73@sigill.intra.peff.net>
Date:   Tue, 08 Aug 2017 22:36:33 -0700
In-Reply-To: <20170808225851.kgbyrlqrtlurzc73@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 8 Aug 2017 18:58:51 -0400")
Message-ID: <xmqqpoc58fq6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4F02B00-7CC4-11E7-934B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 08, 2017 at 06:52:31PM -0400, Jeff King wrote:
>
>> > Interesting.  I see that we still have the conditional code to call
>> > out to sha1-lookup.c::sha1_entry_pos().  Do we need a similar change
>> > over there, I wonder?  Alternatively, as we have had the experimental
>> > sha1-lookup.c::sha1_entry_pos() long enough without anybody using it,
>> > perhaps we should write it off as a failed experiment and retire it?
>> 
>> There is also sha1_pos(), which seems to have the same problem (and is
>> used in several places).
>
> Actually, I take it back. The problem happens when we enter the loop
> with no entries to look at. But both sha1_pos() and sha1_entry_pos()
> return early before hitting their do-while loops in that case.

Ah, I was not looking at that part of the code.  Thanks.

I still wonder if we want to retire that conditional invocation of
sha1_entry_pos(), though.
