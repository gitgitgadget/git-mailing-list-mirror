Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB30C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AA961289
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhEFVL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:11:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51304 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEFVL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:11:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84754127BDD;
        Thu,  6 May 2021 17:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JpQBs/kTbgHzPBw/f4MNk9AGVNs9rvSfUPKH5O
        nb0Oc=; b=G8wSJA0af/ieHhciVo4aZjGBDPTafEsWHuWbRDtY+wF1b48QdI/YVP
        A9wkpRL1kQ2MbP/DOD2b7dtkNESUc7GkkFYXpphmwumGZM/6dHHG7UxTtHAEld/T
        yJAzJ09v6MkJNUwSHF0QFP28z1zVPlXoN4IyLGduDXQb7MoOWBbJ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B17C127BDC;
        Thu,  6 May 2021 17:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7061127BDB;
        Thu,  6 May 2021 17:10:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
References: <20200404142131.GA679473@coredump.intra.peff.net>
        <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet>
        <xmqqv97w1wl1.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet>
Date:   Fri, 07 May 2021 06:10:53 +0900
In-Reply-To: <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 6 May 2021 22:29:57 +0200 (CEST)")
Message-ID: <xmqqh7jfy3du.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B7CC604-AEAF-11EB-9EA5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Otherwise I'd strongly prefer to see a word that hints that this is
>> an otherwise unneeded workaround for comiplers.  Your suggested
>> title instead hints that it is wrong to assume that errno will be
>> set to non-zero after a syscall.  I do not think that is the message
>> we want to send to our readers.
>
> Right, the oneline I suggested was only for the original patch, with which
> I disagreed.

I actually do not know how your rewrite could be better, though.

		/* GCC thinks socket()/connect() might fail to set errno */
		return errno ? errno : EIO;

If a compiler thinks errno may *not* be set, can 'errno' be reliably
used to decide if it can be returned as-is or a fallback value EIO
should be used, without triggering the same (incorrect) working in
the first place?
