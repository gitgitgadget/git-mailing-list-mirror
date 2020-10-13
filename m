Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83937C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AA12537A
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mqgjLkQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgJMRpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:45:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61802 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMRpH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 13:45:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 164E3FA9D7;
        Tue, 13 Oct 2020 13:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fc4B7mqVGJb6Nlnv/y+Iutj/57w=; b=mqgjLk
        QRi5EcZks/AEdtGR0p11HsqmloGtfBPv8iM9vJ24ZruUQU6U3/zhtc2XsnHvL492
        GKpUTmDhOM7o2hYjwk4qNB7Khdk5ApXngLxTo19xPkkg7e9rBxJdXx+Om2TvrgUw
        yacflVO28NEUwzq1bKbyN0IBFTtKLr7+zxnvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yij7dBPaMolyNnZdS4KYQwrMsWqGgzim
        yOMeGY2fLzknE9qXJHTGhlzoQGyZIpbOTgxH2dwg+K50d52lRFBKx1aMIE/NjAEN
        916iTHgEElSXpZ203r76wj0hBPh04I/W2ne+SGVUBVuT342Hp2UJ4wqQE4lh3aAS
        kE33Ay29rCo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E590FA9D6;
        Tue, 13 Oct 2020 13:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F150FA9D5;
        Tue, 13 Oct 2020 13:45:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH 3/3] http: automatically retry some requests
References: <20201012184806.166251-1-smcallis@google.com>
        <20201012184806.166251-3-smcallis@google.com>
        <nycvar.QRO.7.76.6.2010122126280.50@tvgsbejvaqbjf.bet>
        <CAM4o00fL4oGNG_Z7tF5bL=Kp===683LBo1RhmZ=vZ6Kie=-jzA@mail.gmail.com>
Date:   Tue, 13 Oct 2020 10:45:01 -0700
In-Reply-To: <CAM4o00fL4oGNG_Z7tF5bL=Kp===683LBo1RhmZ=vZ6Kie=-jzA@mail.gmail.com>
        (Sean McAllister's message of "Tue, 13 Oct 2020 09:03:15 -0600")
Message-ID: <xmqq362ikoki.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2B4321C-0D7B-11EB-811B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean McAllister <smcallis@google.com> writes:

>> > +static int http_retry_limit = 3;
>> > +static int http_default_delay = 2;
>>
>> Should there be a config option for that? Also, it took me some time to
>> find the code using this variable in order to find out what unit to use:
>> it is seconds (not microseconds, as I had expected). Maybe this can be
>> documented in the variable name, or at least in a comment?
>
> Junio tossed that out during our private review and I think we decided to just

Needs clarification.  Here "that" in "tossed that out" only refers
to "static int const http_retry_limit = 3" and friends and nothing
else.  There weren't any discussion on units or comments.  I did
mention that it is an obvious future possibility to make these
configurable and that was why I suggested to "toss out" the const.

It seems we'll see names with "seconds" in them somewhere, which is
good.

> I've been writing a lot of python code lately =D  So splitting into
> lines was a natural paradigm for me.  You're right, I like yours more.  I've
> refactored it to be closer to that.  Little bit of fiddling to deal with header
> whitespace properly, but it's pretty close.

Good.  I personally think strbuf_split() is a mistaken API whose use
needs to be killed, so it makes me happy to see one new callsite we
didn't have to add ;-)

Thanks.
